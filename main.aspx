<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="SLC_Classview_CSharp.main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="vendor/chosen/css/chosen.css" />
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="vendor/chosen/js/chosen.jquery.min.js"></script>
    <script type="text/javascript" src="js/commonUtils.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
</head>
<body>
    
    <div class="container-fluid">        
        <select id="studentList" data-placeholder="Choose a student">
            <option></option>
        </select>
        <button onclick="showStudentInfo()" class="btn">Search</button>
    </div>
    
</body>
</html>
