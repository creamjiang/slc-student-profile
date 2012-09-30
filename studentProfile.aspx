<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="studentProfile.aspx.cs" Inherits="SLC_Classview_CSharp.StudentProfile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="vendor/notepaper/css/notepaper.css" rel="stylesheet"/>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>    
    <link href="vendor/timeliner/css/timeliner.css" rel="stylesheet"/>
    <link href="vendor/jqplot/css/jquery.jqplot.min.css" rel="stylesheet"/>
    <link href="vendor/dropshadow/css/dropshadow.css" rel="stylesheet"/>
    <link href="css/studentProfile.css" rel="stylesheet"/>

	<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js"></script>
	<script type="text/javascript" src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="vendor/timeliner/js/timeliner.min.js"></script>
    <script type="text/javascript" src="vendor/underscore/js/underscore.min.js"></script>
    <script type="text/javascript" src="vendor/jqplot/js/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="vendor/jqplot/js/jqplot.cursor.min.js"></script>
    <script type="text/javascript" src="vendor/jqplot/js/jqplot.highlighter.min.js"></script>
    <script type="text/javascript" src="vendor/jqplot/js/jqplot.pieRenderer.min.js"></script>

    <script type="text/javascript" src="js/mockData.js"></script>
    <script type="text/javascript" src="js/commonUtils.js"></script>
    <script type="text/javascript" src="js/studentProfile.js"></script>
</head>
<body>
    <div>
			<div id="title">               
                <div id="header"></div>
				<div class="container" style="padding : 80, 0, 0, 80;">
					<img src="img/person.png" style="float:left;"/>	
					<div>
						<h2>
                            <div id="name" style="float:left"></div>
                            <div >
                                <img src="img/stickyPrint.png" style="width:60px; margin-left:15px; cursor:pointer;"/>
                            </div>
                        </h2>
                        
                        <div style="float:left">
						<table style="width:400px;">
							<tr>
								<td><strong>Gender</strong></td>
								<td id="gender"></td>
							</tr>
							<tr>
								<td><strong>Languages</strong></td>
                                <td id="languages"></td>	
							</tr>
                            <tr>
                                <td><strong>Email</strong></td>
                                <td id="email"></td>
                            </tr>
							<tr>
								<td><strong>English Proficiency</strong></td>
                                <td id="englishProficiency"></td>
							</tr>
                            <tr>                                
                                <td><strong>Disabilities</strong></td>
                                <td id="disabilities"></td>
                            </tr>
                            <tr>                                
								<td><strong>Groups</strong></td>
								<td id="groups"></td>
                            </tr>
                            <tr>
                                <td><strong>Grade Level</strong></td>
                                <td id="gradeLevel"></td>
                            </tr>
						</table>
                        </div>
                        <div style="float:left">
                            <p>Learning Styles</p>
                            <div id="learningStylePlots" style="width:300px; height:200px;">
                                        
                            </div>
                        </div>
					</div>												
				</div>				
                <div id="footer"></div>
			</div>
			<div style="clear:both"  class="container">
				<div class="tabbable"> <!-- Only required for left/right tabs -->
				  <ul class="nav nav-tabs">
				    <li class="active"><a href="#tab1" data-toggle="tab">Updates</a></li>
				    <li><a href="#tab2" data-toggle="tab" onclick="getBackgroundData()">Background</a></li>
				    <li><a href="#tab3" data-toggle="tab" onclick="getEducationData()">Education</a></li>
				    <li><a href="#tab4" data-toggle="tab" onclick="getMedicalData()">Medical</a></li>
				    <li><a href="#tab5" data-toggle="tab">SWDL</a></li>
				  </ul>
				  <div class="tab-content">
				    <div class="tab-pane active notes" id="tab1">				     
				      <div class="container-fluid">
				      	Add a quick note <input type="text" id="txtAddNode" style="width: 400px; margin-top:6px"/>
				      	<select id="selNoteType" style="margin-top:7px; width:170px;">
                            <option value="success">Performance</option>
                            <option value="warning">Behavioral</option>
                            <option value="">Other</option>
                        </select>
                        <button class="btn btn-primary" onclick="addNote();">Add</button>
				      </div>	
				      <div>
                        <div class="btn-group" data-toggle="buttons-radio">
                          <button type="button" class="btn btn-success" onclick="filterNotes('success')">Performance</button>
                          <button type="button" class="btn btn-warning" onclick="filterNotes('warning')">Behavioral</button>
                          <button type="button" class="btn" onclick="filterNotes('')">Other</button>
                        </div>
                      </div>
                      <div>
				      	<ul id="listOfNotes">
                            <li class="notecontainer">
                             <section class="notepaper">
                             <span class="label label-success">Performance</span>
						    <figure class="quote">
						      <blockquote class="curly-quotes">
						        Matt is a very quick learner,
						        he picks up things very easily.
						      </blockquote>
						      <figcaption class="quote-by">— John Smith: Mon, 25 Sep 2012</figcaption>
						    </figure>
						  </section>
                            </li>
                            <li class="notecontainer">
                             <section class="notepaper">
                             <span class="label label-warning">Behavioral</span>
						    <figure class="quote">
						      <blockquote class="curly-quotes">
						        Matt helped out a few of his fellow students with arithmetics.
						      </blockquote>
						      <figcaption class="quote-by">— Mary Anne: Thur, 1 May 2012</figcaption>
						    </figure>
						  </section>
                            </li>
                        </ul>                     
				      </div>
				      </div>
				    <div class="tab-pane" id="tab2">
				        <p>Student Background Information</p>
				        <hr>
				        <div class="drop-shadow lifted">
				        <dl class="dl-horizontal">
						    <dt>Birthdate: </dt>
						    <dd id="birthdate"></dd>
						    <dt>Hispanic/Latino: </dt>
						    <dd id="hispanicLatino"></dd>
						    <dt>Address: </dt>
						    <dd id="address"></dd>
						    <dt>Parents: </dt>
						    <dd id="parents"></dd>
						    <dt>Phones:</dt>
						    <dd id="phones"></dd>		
					    </dl>		
				        </div>
				    </div>
				    <div class="tab-pane" id="tab3">
				      <div>
				          <div id="timelineContainer" style="margin-left:20px;">
		                    <!--<div class="timelineMajor">
			                    <h2 class="timelineMajorMarker">Education History</h2>
			                    <dl class="timelineMinor">
				                    <dt id="school01"><a>Event</a></dt>
				                    <dd class="timelineEvent" id="school01EX" style="display: none; ">
					                    <p>Content about the event goes here.</p>
				                    </dd><!-- /.timelineEvent
			                    </dl><!-- /.timelineMinor
		                    </div><!-- /.timelineMajor -->
	                    </div><!-- /#timelineContainer -->
                       </div>
				    </div>
				    <div class="tab-pane" id="tab4">
				      
				      <div class="well">
				      	<p>Conditions:</p>
				      	<hr>
				      	<span class="label label-important">Important</span> Has asthma, must be able to administer E-bi pen
				      </div>
				      
				      <div class="drop-shadow lifted">
				      	<p>Medical History</p>
				      	<ul>
				      		<li>
				      			2007 - 2004 : Dr. Mulligan, MD (617-120-2031) - 1 Memorial Dr, Cambridge, MA 02131				      							      			
				      		</li>
				      		<li>
				      			2004 - 2000 : Dr. Schmoogle, MD (617-342-2012) - 47 Nowhere St, Cambridge, MA 02131				      							      			
				      		</li>
				      	</ul>
				      </div>
				    </div>
				     <div class="tab-pane" id="tab5">
				        <div class="container">
                            <table style="width:600px">
                            <tr>
                            <td>
                                   <div class="drop-shadow lifted" style="background-color:Green; color:White;">
                                   <div>Strengths</div>
                                   <ul>
                                           <li>
                                                   Arithmetics
                                           </li>
                                           <li>
                                                   Awesomeness
                                           </li>
                                   </ul>
                                   </div>
                            </td>
                            <td>
                                   <div class="drop-shadow lifted" style="background-color:red; color:White;">
                                   <div>Weaknesses</div>
                                   <ul>
                                           <li>
                                                   Medical condition - Asthma
                                           </li>
                                           <li>
                                                   Can't run that fast
                                           </li>
                                   </ul>
                                   </div>
                            </td>
                            </tr>
                            <tr>
                            <td>
                                   <div class="drop-shadow lifted"  style="background-color:Orange; color:White;">
                                   <div>Likes</div>
                                   <ul>
                                           <li>
                                                   Basketball
                                           </li>
                                           <li>
                                                   Gaming
                                           </li>
                                   </ul>
                                   </div>
                            </td>
                            <td>
                                   <div class="drop-shadow lifted"  style="background-color:Gray; color:White;">
                                   <div>Dislikes</div>
                                   <ul>
                                           <li>
                                                   Vegetables
                                           </li>
                                           <li>
                                                   Closet Monsters
                                           </li>
                                   </ul>
                                   </div>
                            </td>
                            </tr>
                       </table>
                       </div>
				    </div>
				  </div>
				</div>
			</div>
		</div>
  
</body>
</html>
