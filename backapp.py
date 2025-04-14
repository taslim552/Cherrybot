# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import tempfile, fitz
# import spacy, requests
# from gtts import gTTS
# import os
# from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
# from transformers import pipeline
# from sklearn.feature_extraction.text import TfidfVectorizer
# from sklearn.metrics.pairwise import cosine_similarity

# app = Flask(__name__)
# CORS(app)

# # Load models
# nlp = spacy.load("en_core_web_sm")
# sentiment_analyzer = SentimentIntensityAnalyzer()
# qa_model = pipeline('question-answering', model='distilbert-base-uncased-distilled-squad')

# # Globals (ideally use sessions or a DB)
# interview_data = {
#     "questions": [],
#     "answers": [],
#     "keywords": "",
#     "step": 0,
#     "pool": [],
#     "asked": set()
# }

# # API Config
# API_KEY = "AIzaSyAC6TbmjG1FJWArYKOkIjVZXi0SqBFYUcE"
# MODEL_NAME = "gemini-1.5-pro"
# API_URL = f"https://generativelanguage.googleapis.com/v1/models/{MODEL_NAME}:generateContent?key={API_KEY}"

# def generate_text(prompt):
#     headers = {"Content-Type": "application/json"}
#     data = {"contents": [{"parts": [{"text": prompt}]}]}
#     response = requests.post(API_URL, headers=headers, json=data)
#     return response.json()['candidates'][0]['content']['parts'][0]['text']

# def extract_text_from_pdf(pdf_bytes):
#     doc = fitz.open(stream=pdf_bytes, filetype="pdf")
#     return "".join([page.get_text() for page in doc])

# def extract_keywords(text):
#     doc = nlp(text)
#     keywords = set()
#     for ent in doc.ents:
#         if ent.label_ in ["ORG", "PRODUCT", "SKILL", "WORK_OF_ART", "LANGUAGE"]:
#             keywords.add(ent.text.strip())
#     return ", ".join(list(keywords)[:15])

# @app.route('/upload-resume', methods=['POST'])
# def upload_resume():
#     file = request.files['resume']
#     pdf_text = extract_text_from_pdf(file.read())
#     keywords = extract_keywords(pdf_text)

#     prompt = f"Based on these resume keywords: {keywords}, generate 10 technical interview questions."
#     raw_questions = generate_text(prompt)
#     questions = ["Tell me about yourself"] + [q.strip("-•1234567890. ") for q in raw_questions.split('\n') if q.strip()][:10]

#     interview_data.update({
#         "questions": questions,
#         "answers": [],
#         "keywords": keywords,
#         "step": 0,
#         "pool": questions[1:],
#         "asked": {"Tell me about yourself"}
#     })

#     return jsonify({"message": "Resume processed", "first_question": questions[0]})

# @app.route('/submit-answer', methods=['POST'])
# def submit_answer():
#     data = request.json
#     answer = data.get("answer")
#     step = interview_data["step"]

#     if step >= 10:
#         return jsonify({"done": True})

#     question = interview_data["questions"][step]
#     interview_data["answers"].append(answer)

#     sentiment = sentiment_analyzer.polarity_scores(answer)
#     score = qa_model(question=question, context=answer)['score']

#     # Get next question
#     if interview_data["step"] < 9:
#         vectorizer = TfidfVectorizer()
#         tfidf_matrix = vectorizer.fit_transform(interview_data["pool"])
#         query_vec = vectorizer.transform([answer])
#         sim_idx = cosine_similarity(query_vec, tfidf_matrix).argmax()
#         next_q = interview_data["pool"][sim_idx]

#         # Avoid repeats
#         if next_q not in interview_data["asked"]:
#             interview_data["questions"].append(next_q)
#             interview_data["asked"].add(next_q)

#     interview_data["step"] += 1
#     done = interview_data["step"] >= 10
#     return jsonify({
#         "next_question": interview_data["questions"][interview_data["step"]] if not done else "",
#         "sentiment": sentiment,
#         "score": score,
#         "done": done
#     })

# @app.route('/final-feedback', methods=['GET'])
# def final_feedback():
#     qas = "\n".join(
#         f"Q: {q}\nA: {a}" for q, a in zip(interview_data["questions"], interview_data["answers"])
#     )
#     prompt = f"Evaluate this interview:\n{qas}"
#     feedback = generate_text(prompt)
#     return jsonify({"feedback": feedback})

# if __name__ == '__main__':
#     app.run(debug=True)
# from flask import Flask, request, jsonify
# import tempfile
# import fitz  # PyMuPDF
# import spacy
# import requests
# from sklearn.metrics.pairwise import cosine_similarity
# from sklearn.feature_extraction.text import TfidfVectorizer
# from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
# from transformers import pipeline
# from flask_cors import CORS


# # API config
# API_KEY = "AIzaSyAC6TbmjG1FJWArYKOkIjVZXi0SqBFYUcE"
# MODEL_NAME = "gemini-1.5-pro"
# API_URL = f"https://generativelanguage.googleapis.com/v1/models/{MODEL_NAME}:generateContent?key={API_KEY}"

# # Load models
# nlp = spacy.load("en_core_web_sm")
# sentiment_analyzer = SentimentIntensityAnalyzer()
# qa_model = pipeline('question-answering', model='distilbert-base-uncased-distilled-squad')

# app = Flask(__name__)
# CORS(app)


# # Utils
# def generate_text(prompt):
#     headers = {"Content-Type": "application/json"}
#     data = {"contents": [{"parts": [{"text": prompt}]}]}
#     response = requests.post(API_URL, headers=headers, json=data)
#     return response.json()['candidates'][0]['content']['parts'][0]['text']

# def extract_text_from_pdf(uploaded_file):
#     doc = fitz.open(stream=uploaded_file.read(), filetype="pdf")
#     return "".join([page.get_text() for page in doc])

# def extract_keywords(text):
#     doc = nlp(text)
#     keywords = set()
#     for ent in doc.ents:
#         if ent.label_ in ["ORG", "PRODUCT", "SKILL", "WORK_OF_ART", "LANGUAGE"]:
#             keywords.add(ent.text.strip())
#     for chunk in doc.noun_chunks:
#         if len(chunk.text) > 3 and not chunk.text.lower().startswith("the "):
#             if any(token.pos_ in ["PROPN", "NOUN"] for token in chunk):
#                 keywords.add(chunk.text.strip())
#     return list(keywords)[:15]

# def analyze_sentiment(text):
#     return sentiment_analyzer.polarity_scores(text)

# def evaluate_answer(question, answer):
#     result = qa_model(question=question, context=answer)
#     return result['score']

# def get_followup_question(answer, questions):
#     vectorizer = TfidfVectorizer()
#     tfidf_matrix = vectorizer.fit_transform(questions)
#     query_vec = vectorizer.transform([answer])
#     similarities = cosine_similarity(query_vec, tfidf_matrix)
#     return questions[similarities.argmax()]

# # API endpoints
# @app.route("/upload_resume", methods=["POST"])
# def upload_resume():
#     file = request.files['file']
#     resume_text = extract_text_from_pdf(file)
#     keywords = extract_keywords(resume_text)

#     prompt = f"Based on these resume keywords: {', '.join(keywords)}, generate 10 technical interview questions. dont give any startup instruction like here are 10 question only give question no text other than that"
#     raw_questions = generate_text(prompt)
#     parsed = [q.strip("-•1234567890. ") for q in raw_questions.split('\n') if q.strip()]

#     return jsonify({
#         "keywords": keywords,
#         "questions": ["Tell me about yourself"] + parsed[:10]
#     })

# @app.route("/submit_answer", methods=["POST"])
# def submit_answer():
#     data = request.json
#     question = data["question"]
#     answer = data["answer"]
#     all_questions = data["all_questions"]

#     sentiment = analyze_sentiment(answer)
#     score = evaluate_answer(question, answer)
#     followup = get_followup_question(answer, all_questions)

#     return jsonify({
#         "sentiment": sentiment,
#         "score": score,
#         "followup": followup
#     })

# if __name__ == "__main__":
#     app.run(port=5000, debug=True)

#backapp.py
from flask import Flask, request, jsonify
import tempfile
import fitz  # PyMuPDF
import spacy
import requests
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import TfidfVectorizer
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
from transformers import pipeline
from flask import Flask
from flask_cors import CORS

# API config
API_KEY = "AIzaSyApa-sWIB4XZEaRZJ-Ke2heFxBrR0WfNFI"
MODEL_NAME = "gemini-1.5-pro"
API_URL = f"https://generativelanguage.googleapis.com/v1/models/{MODEL_NAME}:generateContent?key={API_KEY}"

# Load models
nlp = spacy.load("en_core_web_sm")
sentiment_analyzer = SentimentIntensityAnalyzer()
qa_model = pipeline('question-answering', model='distilbert-base-uncased-distilled-squad')

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

# ===== Utility Functions =====

# def generate_text(prompt):
#     headers = {"Content-Type": "application/json"}
#     data = {"contents": [{"parts": [{"text": prompt}]}]}
#     response = requests.post(API_URL, headers=headers, json=data)
#     return response.json()['candidates'][0]['content']['parts'][0]['text']


def generate_text(prompt):
    headers = {"Content-Type": "application/json"}
    data = {"contents": [{"parts": [{"text": prompt}]}]}
    
    response = requests.post(API_URL, headers=headers, json=data)
    
    try:
        response_data = response.json()
        if 'candidates' in response_data:
            return response_data['candidates'][0]['content']['parts'][0]['text']
        else:
            print("Unexpected response format:", response_data)
            return "Sorry, I couldn't generate a response at the moment."
    except Exception as e:
        print("Error parsing Gemini API response:", e)
        print("Raw response text:", response.text)
        return "Sorry, there was an error generating the response."


def extract_text_from_pdf(uploaded_file):
    doc = fitz.open(stream=uploaded_file.read(), filetype="pdf")
    return "".join([page.get_text() for page in doc])

def extract_keywords(text):
    doc = nlp(text)
    keywords = set()
    for ent in doc.ents:
        if ent.label_ in ["ORG", "PRODUCT", "SKILL", "WORK_OF_ART", "LANGUAGE"]:
            keywords.add(ent.text.strip())
    for chunk in doc.noun_chunks:
        if len(chunk.text) > 3 and not chunk.text.lower().startswith("the "):
            if any(token.pos_ in ["PROPN", "NOUN"] for token in chunk):
                keywords.add(chunk.text.strip())
    return list(keywords)[:15]

def analyze_sentiment(text):
    sentiment = sentiment_analyzer.polarity_scores(text)
    
    # Add error handling if sentiment is not as expected
    if sentiment is None or not all(key in sentiment for key in ["pos", "neg", "neu"]):
        # Return default values if sentiment data is not available
        return {"pos": 0, "neg": 0, "neu": 0}
    
    return sentiment


def evaluate_answer(question, answer):
    result = qa_model(question=question, context=answer)
    return result['score']

def get_followup_question(answer, questions):
    vectorizer = TfidfVectorizer()
    tfidf_matrix = vectorizer.fit_transform(questions)
    query_vec = vectorizer.transform([answer])
    similarities = cosine_similarity(query_vec, tfidf_matrix)
    return questions[similarities.argmax()]

# ===== Routes =====

@app.route("/upload_resume", methods=["POST"])
def upload_resume():
    file = request.files['file']
    resume_text = extract_text_from_pdf(file)
    keywords = extract_keywords(resume_text)

    prompt = f"Based on these resume keywords: {', '.join(keywords)}, generate 10 technical interview questions. Don't add any explanation or introductory text. and first question should be introduce yourself"
    raw_questions = generate_text(prompt)
    parsed = [q.strip("-•1234567890. ") for q in raw_questions.split('\n') if q.strip()]

    return jsonify({
        "keywords": keywords,
        "questions": parsed[:10]
    })

@app.route("/submit_answer", methods=["POST"])
def submit_answer():
    data = request.json
    question = data["question"]
    answer = data["answer"]
    all_questions = data["all_questions"]

    # Store all Q&A pairs
    qa_pairs = data.get("qa_pairs", [])
    qa_pairs.append({"question": question, "answer": answer})

    # Check if all 10 questions have been answered
    if len(qa_pairs) == 10:
        # Trigger final feedback generation
        final_feedback_data = {"qa_pairs": qa_pairs}
        final_feedback_response = final_feedback(final_feedback_data)
        return final_feedback_response

    sentiment = analyze_sentiment(answer)
    score = evaluate_answer(question, answer)
    # followup = get_followup_question(answer, all_questions)

    return jsonify({
        "sentiment": sentiment,
        "score": score,
       
        "qa_pairs": qa_pairs  # Pass Q&A pairs along with the response
    })


# @app.route("/final_feedback", methods=["POST"])
# def final_feedback(data):
#     interview_text = "\n".join(
#         f"Q: {qa['question']}\nA: {qa['answer']}" for qa in data["qa_pairs"]
#     )
#     feedback = generate_text(f"Evaluate this interview:\n{interview_text}")
#     return jsonify({"feedback": feedback})

@app.route("/final_feedback", methods=["POST"])
def final_feedback():
    
    data = request.json  # <-- Get data from request
    interview_text = "\n".join(
        f"Q: {qa['question']}\nA: {qa['answer']}" for qa in data["qa_pairs"]
    )
    feedback = generate_text(f"Evaluate this interview:\n{interview_text}")
    return jsonify({"feedback": feedback})


# ===== Run App =====
if __name__ == "__main__":
    app.run(debug=True, port=5000)
