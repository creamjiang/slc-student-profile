function displayStudents(data){
    var numStudents = data.length;
    for (var i = 0; i < numStudents; i++) {
        var student = data[i];
        var studentOp = $("<option>");
        $(studentOp).val(student.id);
        $(studentOp).text(student.name.firstName + " " + student.name.lastSurname);

        $("#studentList").append(studentOp);
    }
    $("#studentList").chosen();
};

$(document).ready(function () {
    GetData("Main.aspx/GetStudents", {}, displayStudents);
});

function showStudentInfo() {
    var id = $("#studentList").val();
    window.location.href = "/studentProfile.aspx?id=" + id;
}