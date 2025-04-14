// // voice.js
// function speakText(text) {
//     const msg = new SpeechSynthesisUtterance(text);
//     msg.lang = 'en-US';
//     speechSynthesis.speak(msg);
// }

// function startListening() {
//     const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
//     recognition.lang = 'en-US';

//     recognition.onresult = function(event) {
//         document.getElementById("answerInput").value = event.results[0][0].transcript;
//     };

//     recognition.onerror = function(event) {
//         alert("Speech error: " + event.error);
//     };

//     recognition.start();
// }
function speakText(text) {
    const msg = new SpeechSynthesisUtterance(text);
    msg.lang = 'en-US';
    speechSynthesis.speak(msg);
}

function startListening() {
    const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
    recognition.lang = 'en-US';

    recognition.onresult = function(event) {
        document.getElementById("answerInput").value = event.results[0][0].transcript;
    };

    recognition.onerror = function(event) {
        alert("Speech Recognition Error: " + event.error);
    };

    recognition.start();
}
