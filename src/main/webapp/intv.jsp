<!-- <html>
  <head><title>AI Interview</title></head>
  <body>
    <h2>Interview in Progress</h2>
    <p id="question"></p>
    <textarea id="answer" rows="4" cols="50"></textarea><br>
    <button onclick="submitAnswer()">Submit Answer</button>

    <p id="feedback"></p>

    <script>
      let question = sessionStorage.getItem("currentQuestion");
      document.getElementById("question").innerText = "Q: " + question;

      function submitAnswer() {
        const answer = document.getElementById("answer").value;

        fetch('http://127.0.0.1:5000/submit-answer', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ answer: answer })
        })
        .then(res => res.json())
        .then(data => {
          if (data.done) {
            fetch('http://127.0.0.1:5000/final-feedback')
              .then(res => res.json())
              .then(final => {
                document.getElementById("feedback").innerText = final.feedback;
                document.getElementById("question").innerText = "Interview Completed!";
              });
          } else {
            sessionStorage.setItem("currentQuestion", data.next_question);
            document.getElementById("question").innerText = "Q: " + data.next_question;
            document.getElementById("answer").value = "";
          }
        });
      }
    </script>
  </body>
</html> -->



<!-- intv.jsp -->
<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Interview Bot</title>
    <script src="js/voice.js"></script>

</head>
<body>
    <h2>Interview in Progress</h2>
    <div id="qaContainer">
        <p><strong>Question:</strong> <span id="questionText"></span></p>
        <button onclick="speakCurrentQuestion()">🔊 Read Question</button>
        <br><br>

        <button onclick="startListening()">🎤 Answer by Speaking</button>
        <input type="text" id="answerInput" placeholder="Or type your answer" />
        <button onclick="submitAnswer()">Submit</button>
    </div>

    <div id="responseContainer"></div>

    <script>
    const allQuestions = JSON.parse(localStorage.getItem("questions"));
    let currentIndex = 0;

    function loadQuestion() {
        document.getElementById("questionText").textContent = allQuestions[currentIndex];
    }

    function speakCurrentQuestion() {
        speakText(allQuestions[currentIndex]);
    }

    async function submitAnswer() {
        const answer = document.getElementById("answerInput").value;
        const question = allQuestions[currentIndex];

        const response = await fetch("http://127.0.0.1:5000/submit_answer", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ question, answer, all_questions: allQuestions })
        });

        const result = await response.json();
        document.getElementById("responseContainer").innerHTML = `
            <p><strong>Sentiment:</strong> ${JSON.stringify(result.sentiment)}</p>
            <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
            <p><strong>Follow-up Question:</strong> ${result.followup}</p>
        `;

        speakText(result.followup);

        // load follow-up
        currentIndex++;
        allQuestions.push(result.followup);
        loadQuestion();
    }

    loadQuestion();
    </script>
</body>
</html> -->

<!-- 
<!DOCTYPE html>
<html>
<head>
    <title>Interview Bot</title>
    <script src="js/voice.js"></script>
</head>
<body>
    <h2>Interview in Progress</h2>
    <div id="qaContainer">
        <p><strong>Question:</strong> <span id="questionText"></span></p>
        <button onclick="speakCurrentQuestion()">🔊 Read Question</button>
        <br><br>

        <button onclick="startListening()">🎤 Answer by Speaking</button>
        <input type="text" id="answerInput" placeholder="Or type your answer" />
        <button onclick="submitAnswer()">Submit</button>
    </div>

    <div id="responseContainer" style="margin-top: 20px;"></div>

    <script>
    const allQuestions = JSON.parse(localStorage.getItem("questions"));
let currentIndex = parseInt(localStorage.getItem("currentIndex"), 10);

function loadQuestion() {
    document.getElementById("questionText").textContent = allQuestions[currentIndex];
    speakCurrentQuestion();
}

function speakCurrentQuestion() {
    speakText(allQuestions[currentIndex]);
}

async function submitAnswer() {
    const answer = document.getElementById("answerInput").value;
    const question = allQuestions[currentIndex];

    const response = await fetch("http://127.0.0.1:5000/submit_answer", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ question, answer, all_questions: allQuestions })
    });

    const result = await response.json();
    document.getElementById("responseContainer").innerHTML = `
        <p><strong>Sentiment:</strong> ${JSON.stringify(result.sentiment)}</p>
        <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
        <p><strong>Follow-up Question:</strong> ${result.followup}</p>
    `;

    speakText(result.followup);

    // Check if it's the last question
    if (currentIndex < allQuestions.length - 1) {
        currentIndex++;
        localStorage.setItem("currentIndex", currentIndex);  // Save new index
        loadQuestion();
    } else {
        document.getElementById("qaContainer").innerHTML = "<p>Interview Complete. Thank you!</p>";
    }
}


    function speakCurrentQuestion() {
        speakText(allQuestions[currentIndex]);
    }

    async function submitAnswer() {
        const answer = document.getElementById("answerInput").value;
        const question = allQuestions[currentIndex];

        if (!answer.trim()) {
            alert("Please provide an answer.");
            return;
        }

        try {
            const response = await fetch("http://127.0.0.1:5000/submit_answer", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ question, answer, all_questions: allQuestions })
            });

            const result = await response.json();

            document.getElementById("responseContainer").innerHTML = `
                <p><strong>Sentiment:</strong> ${result.sentiment.label} (${result.sentiment.score})</p>
                <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
                <p><strong>Follow-up Question:</strong> ${result.followup}</p>
            `;

            speakText(result.followup);

            currentIndex++;
            allQuestions.push(result.followup);
            loadQuestion();
        } catch (error) {
            alert("Error during submission: " + error.message);
        }
    }

    loadQuestion();
    </script>
</body>
</html> -->

<!-- intv.jsp -->
<!-- <!DOCTYPE html>
<html>
<head>
    <title>Interview Bot</title>
    <script src="js/voice.js"></script>
</head>
<body>
    <h2>Interview in Progress</h2>
    <div id="qaContainer">
        <p><strong>Question:</strong> <span id="questionText"></span></p>
        <button onclick="speakCurrentQuestion()">🔊 Read Question</button>
        <br><br>

        <button onclick="startListening()">🎤 Answer by Speaking</button>
        <input type="text" id="answerInput" placeholder="Or type your answer" />
        <button onclick="submitAnswer()">Submit</button>
    </div>

    <div id="responseContainer" style="margin-top: 20px;"></div>

    <script>
        const allQuestions = JSON.parse(localStorage.getItem("questions"));
        let currentIndex = parseInt(localStorage.getItem("currentIndex"), 10);
        let qa_pairs = [];
        
        // Function to load the current question
        function loadQuestion() {
            document.getElementById("questionText").textContent = allQuestions[currentIndex];
            speakCurrentQuestion();
        }
        
        // Function to speak the current question
        function speakCurrentQuestion() {
            speakText(allQuestions[currentIndex]);
        }
        
        // Function to submit the answer
        async function submitAnswer() {
            const answer = document.getElementById("answerInput").value;
            const question = allQuestions[currentIndex];
        
            if (!answer.trim()) {
                alert("Please provide an answer.");
                return;
            }
        
            try {
                const response = await fetch("http://127.0.0.1:5000/submit_answer", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ question, answer, all_questions: allQuestions, qa_pairs })
                });
        
                const result = await response.json();
        
                // Check if the sentiment data is available before trying to access it
                if (result.sentiment && result.sentiment.pos !== undefined) {
                    document.getElementById("responseContainer").innerHTML = `
                        <p><strong>Sentiment:</strong> Positive: ${result.sentiment.pos}, Negative: ${result.sentiment.neg}, Neutral: ${result.sentiment.neu}</p>
                        <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
                        <p><strong>Follow-up Question:</strong> ${result.followup}</p>
                    `;
                } else {
                    document.getElementById("responseContainer").innerHTML = `
                        <p><strong>Sentiment:</strong> Could not analyze sentiment.</p>
                        <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
                        
                    `;
                }

                //<p><strong>Follow-up Question:</strong> ${result.followup}</p>
        
                speakText(result.followup);
        
                // Save the Q&A pair
                qa_pairs.push({ question, answer });
        
                // Check if it's the last question 
                if (currentIndex < 6) {
                    currentIndex++;
                    localStorage.setItem("currentIndex", currentIndex);  // Save new index
                    allQuestions.push(result.followup);  // Add follow-up question to the list
                    loadQuestion();
                } else {
                    // Interview is complete, request final feedback
                    const finalFeedbackResponse = await fetch("http://127.0.0.1:5000/final_feedback", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ qa_pairs })
                    });
                    const feedbackData = await finalFeedbackResponse.json();
                    document.getElementById("qaContainer").innerHTML = `
                        <div style="
                            border: 2px solid #4CAF50;
                            border-radius: 12px;
                            padding: 20px;
                            background-color: #f9fdf9;
                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                            font-family: 'Segoe UI', sans-serif;
                            max-width: 600px;
                            margin: auto;
                            text-align: left;
                        ">
                            <h3 style="color: #4CAF50;">🎯 Final Interview Feedback</h3>
                            <p style="line-height: 1.6; font-size: 16px;">${feedbackData.feedback}</p>
                        </div>
                    `;
                }
            } catch (error) {
                alert("Error during submission: " + error.message);
            }
        }
        
        
        // Load the first question
        loadQuestion();
        
    </script>
</body>
</html> -->
<!-- <!DOCTYPE html>
<html>
<head>
    <title>Interview Bot</title>
    <script src="js/voice.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
        }

        #qaContainer {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            margin: auto;
            text-align: center;
        }

        #questionText {
            font-size: 18px;
            color: #34495e;
        }

        button {
            margin: 10px;
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            background-color: #3498db;
            color: white;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        button:hover {
            background-color: #2980b9;
        }

        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        #responseContainer {
            margin-top: 30px;
            text-align: left;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.05);
        }

        #responseContainer p {
            font-size: 15px;
            margin-bottom: 10px;
            color: #2d3436;
        }
    </style>
</head>
<body>
    <h2>Interview in Progress</h2>
    <div id="qaContainer">
        <p><strong>Question:</strong> <span id="questionText"></span></p>
        <button onclick="speakCurrentQuestion()">🔊 Read Question</button>
        <br><br>

        <button onclick="startListening()">🎤 Answer by Speaking</button>
        <input type="text" id="answerInput" placeholder="Or type your answer" />
        <br>
        <button onclick="submitAnswer()">Submit</button>
    </div>

    <div id="responseContainer"></div>

    <script>
        const allQuestions = JSON.parse(localStorage.getItem("questions"));
        let currentIndex = parseInt(localStorage.getItem("currentIndex"), 10);
        let qa_pairs = [];
        
        function loadQuestion() {
            document.getElementById("questionText").textContent = allQuestions[currentIndex];
            speakCurrentQuestion();
        }

        function speakCurrentQuestion() {
            speakText(allQuestions[currentIndex]);
        }

        async function submitAnswer() {
            const answer = document.getElementById("answerInput").value;
            const question = allQuestions[currentIndex];

            if (!answer.trim()) {
                alert("Please provide an answer.");
                return;
            }

            try {
                const response = await fetch("http://127.0.0.1:5000/submit_answer", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ question, answer, all_questions: allQuestions, qa_pairs })
                });

                const result = await response.json();

                if (result.sentiment && result.sentiment.pos !== undefined) {
                    document.getElementById("responseContainer").innerHTML = `
                        <p><strong>Sentiment:</strong> Positive: ${result.sentiment.pos}, Negative: ${result.sentiment.neg}, Neutral: ${result.sentiment.neu}</p>
                        <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
                        <p><strong>Follow-up Question:</strong> ${result.followup}</p>
                    `;
                } else {
                    document.getElementById("responseContainer").innerHTML = `
                        <p><strong>Sentiment:</strong> Could not analyze sentiment.</p>
                        <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
                    `;
                }

                speakText(result.followup);
                qa_pairs.push({ question, answer });

                if (currentIndex < 2) {
                    currentIndex++;
                    localStorage.setItem("currentIndex", currentIndex);
                    allQuestions.push(result.followup);
                    loadQuestion();
                } else {
                    const finalFeedbackResponse = await fetch("http://127.0.0.1:5000/final_feedback", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ qa_pairs })
                    });
                    const feedbackData = await finalFeedbackResponse.json();
                    document.getElementById("qaContainer").innerHTML = `
                        <div style="
                            border: 2px solid #4CAF50;
                            border-radius: 12px;
                            padding: 20px;
                            background-color: #f9fdf9;
                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                            font-family: 'Segoe UI', sans-serif;
                            max-width: 600px;
                            margin: auto;
                            text-align: left;
                        ">
                            <h3 style="color: #4CAF50;">🎯 Final Interview Feedback</h3>
                            <p style="line-height: 1.6; font-size: 16px;">${feedbackData.feedback.replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>").replace(/\*(.*?)\*/g, "<em>$1</em>")}</p>

                        </div>
                    `;
                }
            } catch (error) {
                alert("Error during submission: " + error.message);
            }
        }

        loadQuestion();
    </script>
</body>
</html> -->
<!DOCTYPE html>
<html>
<head>
    <title>Interview Bot</title>
    <script src="js/voice.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
        }

        #qaContainer {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            margin: auto;
            text-align: center;
        }

        #questionText {
            font-size: 18px;
            color: #34495e;
        }

        button {
            margin: 10px;
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            background-color: #3498db;
            color: white;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        button:hover {
            background-color: #2980b9;
        }

        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        #responseContainer {
            margin-top: 30px;
            text-align: left;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.05);
        }

        #responseContainer p {
            font-size: 15px;
            margin-bottom: 10px;
            color: #2d3436;
        }
    </style>
</head>
<body>
    <h2>Interview in Progress</h2>
    <div id="qaContainer">
        <p><strong>Question:</strong> <span id="questionText"></span></p>
        <button onclick="speakCurrentQuestion()">🔊 Read Question</button>
        <br><br>

        <button onclick="startListening()">🎤 Answer by Speaking</button>
        <input type="text" id="answerInput" placeholder="Or type your answer" />
        <br>
        <button onclick="submitAnswer()">Submit</button>
    </div>

    <div id="responseContainer"></div>

    <script>
        const allQuestions = JSON.parse(localStorage.getItem("questions"));
        let currentIndex = parseInt(localStorage.getItem("currentIndex"), 10);
        let qa_pairs = [];

        function loadQuestion() {
            document.getElementById("questionText").textContent = allQuestions[currentIndex];
            speakCurrentQuestion();
        }

        function speakCurrentQuestion() {
            speakText(allQuestions[currentIndex]);
        }

        async function submitAnswer() {
            const answer = document.getElementById("answerInput").value;
            const question = allQuestions[currentIndex];

            if (!answer.trim()) {
                alert("Please provide an answer.");
                return;
            }

            try {
                const response = await fetch("http://127.0.0.1:5000/submit_answer", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ question, answer, all_questions: allQuestions, qa_pairs })
                });

                const result = await response.json();

                if (result.sentiment && result.sentiment.pos !== undefined) {
                    document.getElementById("responseContainer").innerHTML = `
                        <p><strong>Sentiment:</strong> Positive: ${result.sentiment.pos}, Negative: ${result.sentiment.neg}, Neutral: ${result.sentiment.neu}</p>
                        <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
                        <p><strong>Follow-up Question:</strong> ${result.followup}</p>
                    `;
                } else {
                    document.getElementById("responseContainer").innerHTML = `
                        <p><strong>Sentiment:</strong> Could not analyze sentiment.</p>
                        <p><strong>Relevance Score:</strong> ${result.score.toFixed(2)}</p>
                    `;
                }

                speakText(result.followup);
                qa_pairs.push({ question, answer });

                if (currentIndex < 2) {
                    currentIndex++;
                    localStorage.setItem("currentIndex", currentIndex);
                    allQuestions.push(result.followup);
                    loadQuestion();
                } else {
                    const finalFeedbackResponse = await fetch("http://127.0.0.1:5000/final_feedback", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ qa_pairs })
                    });

                    const feedbackData = await finalFeedbackResponse.json();
                    const formattedFeedback = feedbackData.feedback
                        .replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>")
                        .replace(/\*(.*?)\*/g, "<em>$1</em>")
                        .replace(/\n/g, "<br>• "); // bullet point style

                    document.getElementById("qaContainer").innerHTML = `
                        <div style="
                            border: 2px solid #4CAF50;
                            border-radius: 12px;
                            padding: 20px;
                            background-color: #f9fdf9;
                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                            font-family: 'Segoe UI', sans-serif;
                            max-width: 600px;
                            margin: auto;
                            text-align: left;
                        ">
                            <h3 style="color: #4CAF50;">🎯 Final Interview Feedback</h3>
                            <p style="line-height: 1.6; font-size: 16px;">• ${formattedFeedback}</p>
                        </div>
                    `;
                }
            } catch (error) {
                alert("Error during submission: " + error.message);
            }
        }

        loadQuestion();
    </script>
</body>
</html>
