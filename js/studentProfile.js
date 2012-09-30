var app = app || {};
app.instructor = "Linda Kim";

/**
 * Initialize the app. Retrieves the info for the student with the given
 * studentId
 */
$(document).ready(function () {
    app.studentId = getParameterByName('id'); 
	GetData("studentProfile.aspx/GetSingleStudentData", { studentId : app.studentId }, displayStudentInfo);
});

/**
  * Callback function for retrieving the student data from the backend. Populates the student data
  * fields with the backend data
  */
function displayStudentInfo(data){
    app.student = data;
    
    // mock data
    app.student.disabilities = sampleMattData.disabilities;
    app.student.languages = sampleMattData.languages;
    app.student.learningStyles = sampleMattData.learningStyles;

	var name = data.name.firstName + " "+ data.name.middleName + " " + data.name.lastSurname;
	$("#name").text(name);
	$("#gender").text(data.sex);	
	$("#email").text(data.electronicMail[0].emailAddress);
	$("#gradeLevel").text(data.gradeLevel);
	$("#englishProficiency").text(data.limitedEnglishProficiency);

	_.each(app.student.languages, function (language) {
	    $("#languages").text(language);
	});

	_.each(app.student.disabilities, function (disability) {
	    var disabilityElem = $("<a style='color:white; text-decoration: underline' href='#' title='" + disability.disabilityDiagnosis + "'>" + disability.disability + ", </a>");
	    $(disabilityElem).tooltip();
	    $("#disabilities").append(disabilityElem);
	});

	$("#groups").text("Honor Roll, Visual Learners");

    // creates piechart for the student's learning styles - uses the jqPlot plugin
	var learningStyles = app.student.learningStyles;
	var data = [
    ['Auditory', learningStyles.auditoryLearning], ['Tactile', learningStyles.tactileLearning], ['Visual', learningStyles.visualLearning]
    ];
	var plot1 = jQuery.jqplot('learningStylePlots', [data],
    {
        seriesDefaults: {
            // Make this a pie chart.
            renderer: jQuery.jqplot.PieRenderer,
            rendererOptions: {
                // Put data labels on the pie slices.
                // By default, labels show the percentage of the slice.
                showDataLabels: true
            },
            grid: {
                background: 'transparent'
            },
            cursor: {
                show: true,
                showTooltip: true
            }
        },
        legend: { show: true, location: 'e' }
    }
  );
}

/**
 * Function creates a new sticky note object. Currently does not save back to the database 
 */
function addNote() {
    var noteText = $("#txtAddNode").val();
    var typeVal = $("#selNoteType").val();
    var typeStr = getNoteTagType(typeVal);  
	var timestamp = new Date();
	
    // create the html elem
    var noteElem = $("<li class='notecontainer'><section class='notepaper'>"
        + "<span class='label label-" + typeVal + "'>" + typeStr + "</span><figure class='quote'><blockquote class='curly-quotes'>"
        + noteText + "</blockquote><figcaption class='quote-by'>—" + app.instructor + " " + timestamp.toDateString()
        + "</figcaption></figure></section></li>");
	$("#listOfNotes").prepend(noteElem);
	$(noteElem).hide().show("slide", { direction: 'left' });
}

/**
 * Populate the background fields and retrieve additional background information
 * from the backend
 */
function getBackgroundData(){

    if (!app.hasBackgroundData) {
        // mock data
        app.student.address = sampleMattData.address;
        $("#birthdate").html(app.student.birthData.birthDate);
        $("#hispanicLatino").html(app.student.hispanicLatinoEthnicity ? 'Yes' : 'No');

        var addresses = app.student.address;
        _.each(addresses, function(address){
            $("#address").append("<div>" + 
                address.streetNumberName + ", " + address.city + " " + address.stateAbbreviation + ", " + address.postalCode
                + "</div>");
        });
        
        // get parents
        GetData("studentProfile.aspx/GetStudentParents", { studentId: app.studentId }, displayParentInfo);

        var telephones = app.student.telephone;
        _.each(telephones, function (telephone) {
            $("#phones").append("<div>" + telephone.telephoneNumber + " ( " + telephone.telephoneNumberType + " )</div>");
        });

        app.hasBackgroundData = true;
    }
}

/**
 * Callback function for retrieving the student's parent information from backend
 */
function displayParentInfo(parents) {
    _.each(parents, function (parent) {
        var relation = parent.studentParentAssociation[0].relation;
        $("#parents").append("<div>" + parent.name.firstName + " " + parent.name.lastSurname + " ( " + relation + " )</div>");
    });
}

/**
* Retrieve education data from the backend
*/
function getEducationData(){
    if (!app.hasEducationData) {
        GetData("studentProfile.aspx/GetStudentSchoolsData", { studentId: app.studentId }, displayEducationInfo);
        app.hasEducationData = true;
    }
}

/**
 * Callback for retrieving education info. Populatest the timeline using the 
 * backend data
 */
function displayEducationInfo(data) {
    
    // add fake school association data
    data.push(studentSchools[0]);

    var numSchools = data.length;
    for (var i = 0; i < numSchools; i++){
        var school = data[i];
        var address = school.address[0];
        var elemStr = "<div class='timelineMajor'><h2 class='timelineMajorMarker'>" + school.nameOfInstitution + "</h2>";
        elemStr += "&nbsp;<strong>" + address.streetNumberName + ", " + address.city + " " + address.stateAbbreviation + ", " + address.postalCode + " " + " - " + school.telephone[0].telephoneNumber + "</strong>"
        var schoolAssociations = school.studentSchoolAssociation;
        var numAssociations = schoolAssociations.length;
        
        // sort by date descending
        var sortedAssociations = _.sortBy(schoolAssociations, function(item){
            return new Date(item.entryDate);
        }).reverse();

        // loop through the different years the student has been in that school
        for (var j = 0; j < numAssociations; j++){
            var association = sortedAssociations[j];
            var startDate = association.entryDate;
            var endDate = association.exitWithdrawDate;
            if (endDate === undefined) {
                endDate = "Present";
            }
            elemStr += "<dl class='timelineMinor'><dt id='event" + j + "'><a>" + startDate + " - " + endDate
            + "</a></dt><dd class='timelineEvent' id='event" + j + "EX' style='display:none;'>";
            elemStr += "<p><strong>" + association.entryGradeLevel + "</strong></p>";
            elemStr += "<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet "
            + "dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. "
            + "Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu...</p></dd></dl>";
        }

        elemStr += "</div>"; 
        var eventElem = $(elemStr);
        $("#timelineContainer").append(eventElem);
    }    
        
    $.timeliner({
        timelineContainer: '#timelineContainer', // value: selector of the main element holding the timeline's content, default to #timelineContainer
        startState: 'closed', // value: closed | open, default to closed; determines whether the timeline is initially collapsed or fully expanded
        baseSpeed: 200 // value: any integer, default to 200; determines the base speed, some animations are a multiple (4x) of the base speed
    });
}

/**
 * NOT IMPLEMENTED - dont think there is medical data yet so it is mocked up
 */
function getMedicalData(){
	
}

/**
 * Filters through the sticky notes using the select tag
 */
function filterNotes(type) {
    $("li.notecontainer section.notepaper").show();
    // find using the tag label
    $("li.notecontainer span").each(function (index, elem) {
        if (!$(elem).hasClass('label-' + type)) {            
            // hide the parent, which includes the tag and the sticky content
            var parent = elem.parentElement;
            $(parent).hide();
        }
    });
}

/**
 * Helper function for getting the tag names from the values
 */
function getNoteTagType(val) {
    switch (val) {
        case 'success': return 'Performance';
        case 'warning': return 'Behavioral';
        case '': return 'Other';
    }
}