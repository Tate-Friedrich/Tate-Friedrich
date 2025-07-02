import gifAnimation.*;

String[][] strs = new String[6][2];
PFont fontRegular;
PFont fontBold;

GifMaker gifExport;

int i = 0;
boolean delete = false;
int s = 0;
int offset = 50;
int mainFontSize = 60;
int secondaryFontSize = 40;

int pauseFrames = 0;
int pauseLength = 45;

boolean showIntro = true;
int introHoldFrames = 0;

void setup() {
  size(2200, 300);
  fontRegular = createFont("Helvetica", 48);
  fontBold = createFont("Helvetica-Bold", 120);
  textAlign(CENTER);
  frameRate(30);
  background(255);
  fill(0);

  gifExport = new GifMaker(this, "output.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(10);
  gifExport.setDelay(33);

  strs[0][0] = "Hey there!";
  strs[0][1] = "I'm Tate Friedrich—great to meet you.";

  strs[1][0] = "I'm a multidisciplinary engineer with a broad skill set.";
  strs[1][1] = "I earned both my undergraduate and graduate degrees from Missouri S&T.";

  strs[2][0] = "My background spans Explosives, Mechanical, and Electrical Engineering.";
  strs[2][1] = "It’s an unusual mix—but it keeps things exciting.";

  strs[3][0] = "I’m passionate about solving problems across different disciplines.";
  strs[3][1] = "Each challenge is a chance to learn something new.";

  strs[4][0] = "I’ve worked on everything from systems integration to PLCs to explosives.";
  strs[4][1] = "Scroll down to explore more of my work and past projects.";

  strs[5][0] = "Don’t hesitate to reach out—I'd love to connect!";
  strs[5][1] = "You’ll find my contact info at the bottom of the page.";
}

void draw() {
  background(255);

  if (showIntro) {
    int fadeInLength = 45;
    int holdLength = 90;
    int fadeOutLength = 45;
    int totalIntroLength = fadeInLength + holdLength + fadeOutLength;

    if (introHoldFrames < fadeInLength) {
      float alpha = map(introHoldFrames, 0, fadeInLength, 0, 255);
      fill(0, alpha);
    } else if (introHoldFrames < fadeInLength + holdLength) {
      fill(0, 255);
    } else if (introHoldFrames < totalIntroLength) {
      float alpha = map(introHoldFrames, fadeInLength + holdLength, totalIntroLength, 255, 0);
      fill(0, alpha);
    } else {
      showIntro = false;
      return;
    }

    textFont(fontBold);
    textSize(120);
    text("Tate B. Friedrich", width / 2, height / 2);

    introHoldFrames++;
    gifExport.addFrame();
    return;
  }

  textFont(fontRegular);

  if (s < strs.length) {
    if ((strs[s][0].length() >= i || strs[s][1].length() >= i) && !delete) {
      if (strs[s][0].length() >= i) {
        textSize(mainFontSize);
        fill(0);
        text(strs[s][0].substring(0, i), width / 2, height / 2 - offset);
      } else {
        textSize(mainFontSize);
        fill(0);
        text(strs[s][0], width / 2, height / 2 - offset);
      }
      if (strs[s][1].length() >= i) {
        textSize(secondaryFontSize);
        fill(0);
        text(strs[s][1].substring(0, i), width / 2, height / 2 + offset);
      } else {
        textSize(secondaryFontSize);
        fill(0);
        text(strs[s][1], width / 2, height / 2 + offset);
      }
      i++;
    } else {
      if (!delete && pauseFrames < pauseLength) {
        textSize(mainFontSize);
        fill(0);
        text(strs[s][0], width / 2, height / 2 - offset);
        textSize(secondaryFontSize);
        fill(0);
        text(strs[s][1], width / 2, height / 2 + offset);

        pauseFrames++;
        gifExport.addFrame();
        return;
      }
      delete = true;
    }

    if (delete) {
      if (i > 0) {
        if (i < strs[s][0].length()) {
          textSize(mainFontSize);
          fill(0);
          text(strs[s][0].substring(0, i - 1), width / 2, height / 2 - offset);
        } else {
          textSize(mainFontSize);
          fill(0);
          text(strs[s][0], width / 2, height / 2 - offset);
        }
        if (i < strs[s][1].length()) {
          textSize(secondaryFontSize);
          fill(0);
          text(strs[s][1].substring(0, i - 1), width / 2, height / 2 + offset);
        } else {
          textSize(secondaryFontSize);
          fill(0);
          text(strs[s][1], width / 2, height / 2 + offset);
        }
        i--;
      } else {
        delete = false;
        s++;
        pauseFrames = 0;
      }
    }

    gifExport.addFrame();
  } else {
    gifExport.finish();
    noLoop();
    println("GIF saved.");
  }
}
