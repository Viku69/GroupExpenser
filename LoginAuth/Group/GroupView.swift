//
//  GroupView.swift
//  LoginAuth
//
//  Created by Vikram Singh on 10/10/23.
//

import SwiftUI
import ContactsUI
import Contacts



struct Contact: Identifiable, Codable {
    var id = UUID()
    var name: String
    var amount : Double
    
    init(name: String , amount: Double = 0.0) {
        self.name = name
        self.amount = amount
    }
}

class Group: Identifiable, Codable {
    var id = UUID()
    var name: String
    var contacts: [Contact]
    
    init(name: String, contacts: [Contact]) {
        self.name = name
        self.contacts = contacts
    }
}


class GroupsViewModel: ObservableObject {
    @Published var groups: [Group] {
        didSet {
            saveGroups(groups)
        }
    }
    
    init() {
        self.groups = GroupsViewModel.loadGroups()
    }
    
    func addGroup(_ group: Group) {
        groups.append(group)
    }
    
    private static func loadGroups() -> [Group] {
        if let data = UserDefaults.standard.data(forKey: "groups") {
            let decoder = JSONDecoder()
            if let groups = try? decoder.decode([Group].self, from: data) {
                return groups
            }
        }
        return []
    }
    
    private func saveGroups(_ groups: [Group]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(groups) {
            UserDefaults.standard.set(encoded, forKey: "groups")
        }
    }
    
    func deleteGroup(at indexSet: IndexSet) {
           groups.remove(atOffsets: indexSet)
       }
}

struct ContactPickerView: View {
    @State private var isContactPickerPresented = false
    @Binding var selectedContacts: [Contact]
    
    var body: some View {
        NavigationView {
            VStack {
                
                Button("Pick Contacts") {
                    self.isContactPickerPresented = true
                }
                .padding()
                .foregroundStyle(.green)
                
                List(selectedContacts) { contact in
                    Text(contact.name)
                }
                .navigationBarTitle("Selected Contacts")
//                .navigationBarItems(trailing: Button("Done") {
//                    self.isContactPickerPresented = false
//                })
            }
            .sheet(isPresented: $isContactPickerPresented) {
                ContactPickerViewController(selectedContacts: self.$selectedContacts)
            }
        }
    }
}

struct GroupView: View {
    @ObservedObject var groupsViewModel = GroupsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groupsViewModel.groups) { group in
                    NavigationLink(destination: GroupDetailView(group: group)) {
                        Text(group.name)
                    }
                }
                .onDelete { indexSet in
                    groupsViewModel.deleteGroup(at: indexSet)
                }
            }
            .navigationBarTitle("Groups")
            .navigationBarItems(trailing: NavigationLink(destination: CreateGroupView(groupsViewModel: groupsViewModel)) {
                Text("+")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.green)
            })
        }
    }
}


struct CreateGroupView: View {
    @ObservedObject var groupsViewModel: GroupsViewModel
    @State private var groupName = ""
    @State private var selectedContacts: [Contact] = []
    
    
    var body: some View {
        VStack {
            HStack(spacing: 2) {
                Image(systemName: "person.2.gobackward")
                    .font(.title)
                    .foregroundStyle(.green)
                
                Spacer()
                
                TextField("Enter Group Name", text: $groupName)
                    .padding(.horizontal , 15)
                    .padding(.vertical , 15)
                .background(.ultraThinMaterial , in: .capsule)
            }
            .padding(.horizontal , 20)
            
            ContactPickerView(selectedContacts: $selectedContacts)
            
            Button("Create Group") {
                if !groupName.isEmpty && !selectedContacts.isEmpty {
                    let newGroup = Group(name: groupName, contacts: selectedContacts)
                    groupsViewModel.addGroup(newGroup)
                    // Clear group name and selected contacts for the next group creation
                    groupName = ""
                    selectedContacts.removeAll()
                }
            }
            .padding()
            .disabled(groupName.isEmpty || selectedContacts.isEmpty)
            .foregroundStyle(.green)
        }
        .navigationBarTitle("Add Group")
    }
}

struct GroupDetailView: View {
    
    var group: Group
    @State private var amount: String = ""
    @State private var paymentAmounts: [String] // Array to store payment amounts for each contact
       
       init(group: Group) {
           self.group = group
           _paymentAmounts = State(initialValue: Array(repeating: "", count: group.contacts.count))
       }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "indianrupeesign.circle")
                    .font(.title)
                    .fontWeight(.bold)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(50)
                
                TextField("Enter Amount", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.decimalPad)
                
            }
            .padding()
            // List of contacts with individual payment options
            VStack(spacing: 30){
                List {
                    ForEach(0..<group.contacts.count, id: \.self) { index in
                        HStack {
                            Text(group.contacts[index].name)
                                .padding(.trailing) // Add padding for spacing between name and text field
                            TextField("Payment", text: $paymentAmounts[index])
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                        }
                    }
                }
                
                .listStyle(.insetGrouped) // Remove default list style for cleaner appearance
                .padding() // Optional: Add padding to the list for spacing
                .background(Color.white)
                
                // Divide Equally button
                Button("Divide Equally") {
                    if let enteredAmount = Double(amount), enteredAmount > 0 {
                        let dividedAmount = enteredAmount / Double(group.contacts.count)
                        paymentAmounts = Array(repeating: "\(dividedAmount)", count: group.contacts.count)
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
            }
        }
        .navigationBarTitle(group.name)
    }
}



// ContactPickerViewController Definition
struct ContactPickerViewController: UIViewControllerRepresentable {
    @Binding var selectedContacts: [Contact]
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPickerViewController
        
        init(parent: ContactPickerViewController) {
            self.parent = parent
        }
        
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            var selectedContacts: [Contact] = []
            for contact in contacts {
                let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? "No Name"
                selectedContacts.append(Contact(name: fullName))
            }
            self.parent.selectedContacts = selectedContacts
            picker.dismiss(animated: true, completion: nil)
        }
        
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = context.coordinator
        return contactPicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}





#Preview {
    
    GroupView()
}
