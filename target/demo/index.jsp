<!-- <html>
  <head><title>Resume Upload</title></head>
  <body>
    <h2>Upload Your Resume (PDF)</h2>
    <form id="resumeForm" enctype="multipart/form-data">
      <input type="file" id="resumeFile" accept="application/pdf" />
      <button type="button" onclick="uploadResume()">Start Interview</button>
    </form>

    <script>
      function uploadResume() {
        const fileInput = document.getElementById('resumeFile');
        const formData = new FormData();
        formData.append('resume', fileInput.files[0]);

        fetch('http://127.0.0.1:5000/upload-resume', {
          method: 'POST',
          body: formData
        })
        .then(res => res.json())
        .then(data => {
          sessionStorage.setItem("currentQuestion", data.first_question);
          window.location.href = "intv.jsp";
        });
      }
    </script>
  </body>
</html> -->
<!-- index.jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Resume Upload</title>
</head>
<body>
    <h2>Upload Your Resume</h2>
    <form id="resumeForm" enctype="multipart/form-data">
        <input type="file" name="file" accept=".pdf" required />
        <button type="submit">Upload & Generate Questions</button>
    </form>

    <div id="questionsSection" style="display:none;">
        <h3>Generated Questions</h3>
        <ul id="questionList"></ul>
        <button onclick="goToInterview()">Start Interview</button>
    </div>

    <script>
    let questions = [];

    document.getElementById('resumeForm').onsubmit = async function(e) {
        e.preventDefault();
        const formData = new FormData(this);

        const response = await fetch("http://127.0.0.1:5000/upload_resume", {
            method: "POST",
            body: formData
        });

        const data = await response.json();
        questions = data.questions;

        const qList = document.getElementById("questionList");
        qList.innerHTML = "";
        questions.forEach(q => {
            const li = document.createElement("li");
            li.textContent = q;
            qList.appendChild(li);
        });

        localStorage.setItem("questions", JSON.stringify(questions));
        document.getElementById("questionsSection").style.display = "block";
    }

    function goToInterview() {
        window.location.href = "intv.jsp";
    }
    </script>
</body>
</html> -->

<!-- index.py -->
<!-- <!DOCTYPE html>
<html>
<head>
    <title>Resume Upload</title>
</head>
<body>
    <h2>Upload Your Resume</h2>
    <form id="resumeForm" enctype="multipart/form-data">
        <input type="file" name="file" accept=".pdf" required />
        <button type="submit">Upload & Generate Questions</button>
    </form>

    <div id="questionsSection" style="display:none;">
        <h3>Generated Questions</h3>
        <ul id="questionList"></ul>
        <button onclick="goToInterview()">Start Interview</button>
    </div>

    <script>
    let questions = [];

    document.getElementById('resumeForm').onsubmit = async function(e) {
        e.preventDefault();
        const formData = new FormData(this);

        try {
            const response = await fetch("http://127.0.0.1:5000/upload_resume", {
                method: "POST",
                body: formData
            });

            const data = await response.json();
            questions = data.questions;

            const qList = document.getElementById("questionList");
            qList.innerHTML = "";
            

            localStorage.setItem("questions", JSON.stringify(questions));
            document.getElementById("questionsSection").style.display = "block";
        } catch (error) {
            alert("Error uploading resume: " + error.message);
        }
    }

    function goToInterview() {
        localStorage.setItem("currentIndex", 0);  // Store index of current question
        window.location.href = "intv.jsp";
    }
    
    </script>
</body>
</html> -->
<!DOCTYPE html>
<html>
<head>
    <title>Resume Upload</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f4f4;
            padding: 50px;
            text-align: center;
        }

        h2 {
            color: #333;
        }

        form {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            display: inline-block;
        }

        input[type="file"] {
            margin: 20px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        #questionsSection {
            margin-top: 40px;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            display: none;
        }

        #questionList {
            text-align: left;
            max-width: 500px;
            margin: 0 auto 20px;
        }

        #questionList li {
            background: #eaf4ea;
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 6px;
            list-style: decimal inside;
        }
    </style>
</head>
<body>
    <h2>Upload Your Resume</h2>
    <form id="resumeForm" enctype="multipart/form-data">
        <input type="file" name="file" accept=".pdf" required />
        <br>
        <button type="submit">Upload & Generate Questions</button>
    </form>

    <div id="questionsSection">
        <h3>Don't be norvous</h3>
        <ul id="questionList"></ul>
        <button onclick="goToInterview()">lets Start Interview</button>
    </div>

    <script>
    let questions = [];

    document.getElementById('resumeForm').onsubmit = async function(e) {
        e.preventDefault();
        const formData = new FormData(this);

        try {
            const response = await fetch("http://127.0.0.1:5000/upload_resume", {
                method: "POST",
                body: formData
            });

            const data = await response.json();
            questions = data.questions;

            const qList = document.getElementById("questionList");
            qList.innerHTML = "";
            

            localStorage.setItem("questions", JSON.stringify(questions));
            document.getElementById("questionsSection").style.display = "block";
        } catch (error) {
            alert("Error uploading resume: " + error.message);
        }
    }

    function goToInterview() {
        localStorage.setItem("currentIndex", 0);  // Store index of current question
        window.location.href = "intv.jsp";
    }
    </script>
</body>
</html>
