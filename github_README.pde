import gifAnimation.*;  // Import the GifAnimation library

String[][] strs = new String[6][2];
PFont font;

GifMaker gifExport;     // Gif maker instance

int i = 0;
boolean delete = false;
int s = 0;
int offset = 50;
int mainFontSize = 60;
int secondaryFontSize = 40;

int pauseFrames = 0;
int pauseLength = 45; // ~1.5 seconds at 30fps

void setup() {
  size(2000, 600);
  font = createFont("HelveticaNeue-48.vlw", 48);
  textFont(font);
  frameRate(30);
  textAlign(CENTER);
  textSize(40);
  background(255);
  fill(0);

  // Set up gif export
  gifExport = new GifMaker(this, "output.gif");
  gifExport.setRepeat(0); // loop forever
  gifExport.setQuality(10);
  gifExport.setDelay(33); // 30fps

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

  if (s < strs.length) {
    if ((strs[s][0].length() >= i || strs[s][1].length() >= i) && !delete) {
      // Typing animation
      if (strs[s][0].length() >= i) {
        textSize(mainFontSize);
        text(strs[s][0].substring(0, i), width/2, height/2 - offset);
      } else {
        textSize(mainFontSize);
        text(strs[s][0], width/2, height/2 - offset);
      }
      if (strs[s][1].length() >= i) {
        textSize(secondaryFontSize);
        text(strs[s][1].substring(0, i), width/2, height/2 + offset);
      } else {
        textSize(secondaryFontSize);
        text(strs[s][1], width/2, height/2 + offset);
      }
      i++;
    } else {
      // Hold full text for pauseLength frames
      if (!delete && pauseFrames < pauseLength) {
        textSize(mainFontSize);
        text(strs[s][0], width/2, height/2 - offset);
        textSize(secondaryFontSize);
        text(strs[s][1], width/2, height/2 + offset);

        pauseFrames++;
        gifExport.addFrame();
        return; // wait before starting delete
      }
      delete = true;
    }

    // Deleting animation
    if (delete) {
      if (i > 0) {
        if (i < strs[s][0].length()) {
          textSize(mainFontSize);
          text(strs[s][0].substring(0, i - 1), width/2, height/2 - offset);
        } else {
          textSize(mainFontSize);
          text(strs[s][0], width/2, height/2 - offset);
        }
        if (i < strs[s][1].length()) {
          textSize(secondaryFontSize);
          text(strs[s][1].substring(0, i - 1), width/2, height/2 + offset);
        } else {
          textSize(secondaryFontSize);
          text(strs[s][1], width/2, height/2 + offset);
        }
        i--;
      } else {
        delete = false;
        s++;
        pauseFrames = 0;  // reset pause for next section
      }
    }

    gifExport.addFrame(); // Add this frame to gif
  } else {
    gifExport.finish(); // Finalize gif
    noLoop();
    println("GIF saved.");
  }
}
