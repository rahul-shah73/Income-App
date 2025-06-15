//
//  HomeView.swift
//  Income
//
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    //We remove transactions and replace it with FetchRequest
    //@State private var transactions: [Transaction] = []
    /*
     A fetch request requires two pieces of information. The entity that you want to query and a sort descriptor that determines the order in which
     results are returned.
     */
    @FetchRequest(sortDescriptors: []) var transactions: FetchedResults<TransactionItem>
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: TransactionItem?
    
    @State private var showSettings = false
    
    @AppStorage("orderDescending") var orderDescending = false
    @AppStorage("filterMinimum") var filterMinimum = 0.0
    @AppStorage("currency") var currency = Currency.dollar
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    
    private var displayTransactions: [TransactionItem] {
        let sortedTransactions = orderDescending ? transactions.sorted(by: { $0.wrappedDate < $1.wrappedDate }) : transactions.sorted(by: { $0.wrappedDate > $1.wrappedDate })
        guard filterMinimum > 0 else {
            return sortedTransactions
        }
        let filteredTransactions = sortedTransactions.filter({ $0.amount > filterMinimum })
        return filteredTransactions
    }
    
    private var expenses: String {
        let sumExpenses = transactions.filter({ $0.type == TransactionType.expense.rawValue }).reduce(0, { $0 + $1.amount })
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "$US0.00"
    }
    
    private var income: String {
        let sumIncome = transactions.filter({ $0.type == TransactionType.income.rawValue }).reduce(0, { $0 + $1.amount })
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "$US0.00"
    }
    
    private var total: String {
        let sumExpenses = transactions.filter({ $0.type == TransactionType.expense.rawValue }).reduce(0, { $0 + $1.amount })
        let sumIncome = transactions.filter({ $0.type == TransactionType.income.rawValue }).reduce(0, { $0 + $1.amount })
        let total = sumIncome - sumExpenses
        return numberFormatter.string(from: total as NSNumber) ?? "$US0.00"
    }
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView()
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 7)
                    
            }
            .background(Color.forestGray)
            .clipShape(Circle())
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.forestGray)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                        Text("\(total)")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(expenses)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(income)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List {
                        ForEach(displayTransactions) { transaction in
                            Button(action: {
                                transactionToEdit = transaction
                            }, label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            })
                        }
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingButton()
            }
            .sheet(isPresented: $showSettings, content: {
                SettingView()
            })
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactionToEdit: transactionToEdit)
            })
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.black)
                    })
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let transaction = transactions[index]
            viewContext.delete(transaction)
        }
    }
    
}

#Preview {
    
//    let dataManager = DataManager.preview
//    return HomeView()
//        .environment(\.managedObjectContext, dataManager.container.viewContext)
}


