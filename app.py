from flask import Flask, render_template, request
from sentiment import analyze_sentiment

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def home():
    if request.method == "POST":
        headline = request.form["headline"]
        sentiment = analyze_sentiment(headline)
        print(f"Headline: {headline} | Sentiment: {sentiment}")
        return render_template("result.html", headline=headline, sentiment=sentiment)
    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)