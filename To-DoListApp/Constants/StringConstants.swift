import Foundation

class StringContants {
    static var instance: StringContants = {
        let instance = StringContants()
        return instance
    }()

    private init() { }

    let addTaskAlertTitle = "Add Task"
    let addButton = "Add"
    let addTaskSucces = "Task Added"
    let cancelButton = "Cancel"
    let okButton = "OK"
    let errorAlertTitle = "Error Message"
    let errorAlertMessage = "You must enter all parameters. \n Please, try again!"
    let fieldsPlaceHolder = [
        "Please enter Task name."
    ]
    let deleteEmptyAlertMessage = "Your Task list is empty! \n Please, add Task in your list."
    let delete = "Delete"
    let deleteAlertTitle = "Delete Task"
    let deleteAlertMessage = "The Task will be deleted from list. \n Are you sure to continue?"
    let edit = "Edit"
    let editAlertTitle = "Edit Task"
    let editSuccesAlertTitle = "Task Edited"
}
