Here's a sample README content for your CherryBot project:

---

# CherryBot - AI-powered Interview Assistant

CherryBot is an AI-powered interview assistant designed to help candidates prepare for interviews by asking dynamic questions based on their resume. It leverages advanced natural language processing (NLP) and sentiment analysis to assess the quality of responses, and provide real-time feedback. CherryBot offers a voice-based interaction system where candidates can either type or speak their responses.

## Features

- **Dynamic Question Generation**: Generates 10 interview questions based on the keywords extracted from the user's uploaded resume.
- **Voice Interaction**: Candidates can choose to answer questions either by speaking or typing.
- **Sentiment Analysis**: Analyzes the sentiment of the candidate's response to provide feedback.
- **Relevance Scoring**: Evaluates how relevant the candidate's response is to the question.
- **Follow-up Questions**: Provides dynamic follow-up questions based on the candidate's answers.
- **Real-time Feedback**: After each answer, the system evaluates and gives instant feedback on sentiment and relevance.
- **Final Feedback**: At the end of the interview, CherryBot provides an overall performance review with suggestions for improvement.

## Tech Stack

- **Frontend**: HTML, JavaScript, CSS
- **Backend**: Python (Flask)
- **API**: Google Speech-to-Text (STT), Google Text-to-Speech (TTS), Sentiment Analysis (VADER)
- **Storage**: Local Storage (for session management)
- **Speech Interaction**: Uses Web APIs for real-time speech recognition and synthesis.

## Installation

### Clone the Repository

```bash
git clone https://github.com/yourusername/cherrybot.git
cd cherrybot
```

### Frontend

The frontend is a simple HTML page. It doesn't require any installation. Just open `index.html` in your browser to start using CherryBot.

### Backend (Flask)

CherryBot's backend is built using Flask. To run the backend:

1. Install dependencies:

```bash
pip install -r requirements.txt
```

2. Start the Flask server:

```bash
python app.py
```

The server will run on `http://127.0.0.1:5000`.

### Frontend to Backend Communication

The frontend communicates with the backend through the following endpoints:

- `/submit_answer` - Receives the candidate's answer, performs sentiment analysis, and generates follow-up questions.
- `/final_feedback` - After completing the interview, provides final feedback based on the candidate's responses.

## How It Works

1. **Uploading the Resume**: The user uploads their resume (PDF) to the system. CherryBot extracts keywords from the resume to dynamically generate relevant interview questions.
2. **Interview Process**: CherryBot presents the questions one by one, and the candidate responds either by typing or speaking. The system analyzes the sentiment of each response and scores its relevance.
3. **Feedback**: After each response, CherryBot gives real-time feedback on the sentiment and relevance of the answer. At the end of the interview, a final performance review is generated.
4. **Real-time Voice Interaction**: Candidates can answer questions using voice. CherryBot uses speech-to-text for voice input and text-to-speech for reading questions aloud.

## Example Use Case

1. **Start Interview**: Candidate uploads their resume and starts the interview.
2. **Interview**: CherryBot asks 10 dynamic questions based on the resume.
3. **Answering Questions**: Candidate answers using text or voice.
4. **Feedback**: After each answer, CherryBot provides feedback on the sentiment and relevance of the response.
5. **Final Feedback**: At the end, CherryBot provides a final assessment of the candidate’s performance.

## Future Improvements

- Support for more languages in the TTS and STT components.
- Integrating AI models for more personalized feedback and dynamic follow-up questions.
- Incorporate additional metrics like confidence level, time taken to answer, etc.


