import processing.sound.*;

String musicFile = "cyberpunk.mp3";
SoundFile file;

FFT fft;
AudioIn in;
Amplitude amp;
int bands = 512;
float[] spectrum = new float[bands];
float[][] last_spectrums = new float[10][bands];
color cur_bg_color = color(37, 150, 100);

void setup() {
  size(1024, 1024);
  background(37, 150, 100);
  strokeWeight(3);
  frameRate(24);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  
  file = new SoundFile(this, "cyberpunk.mp3");
  file.play();
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
}

void draw_partial_spectrum(float[] partial_spectrum, int x, int y, float radius_factor) {
  translate(x, y);
  
  float local_peak = max(partial_spectrum) * 100;
  println("LOCAL PEAK: " + local_peak);
  for(int i = 0; i < partial_spectrum.length; i++){
    partial_spectrum[i] /= max(partial_spectrum);
    partial_spectrum[i] *= 10;
  }
  //local_peak = max(partial_spectrum) * 10; //gotta update
  //float smoothed_peak = (max(last_spectrums[9]) + peak) / 2;
  ellipse(0,0,local_peak * radius_factor, local_peak * radius_factor);
  
  float r1 = local_peak * radius_factor / 2 + 5;

  for(int i = 0; i < partial_spectrum.length; i+=2){
    stroke(random(255), random(40), random(40));
    
    float r2 = r1 + height * partial_spectrum[i/2] * 1;
    float theta = i*4;
    float x1 = r1 * cos(theta);
    float y1 = r1 * sin(theta);
    float x2 = r2 * cos(theta);
    float y2 = r2 * sin(theta);
    
    line(x1, y1, x2, y2);
    //line( i * 2, height, i * 2, height - spectrum[i/2]*height*50 );
  } 
  //last_spectrums[0] = spectrum;
}

void draw() { 
  fft.analyze(spectrum);
  
  float peak = max(spectrum) * 100;
  if(peak > 1.2)
    cur_bg_color = color(random(30), random(150), random(65));
  background(cur_bg_color);
  
  float[] bass_subset = subset(spectrum, 0, 128);
  float[] treb_subset = subset(spectrum, 128, 128);
  
  float[] bass1 = new float[256];
  float[] bass2 = new float[256];
  float[] treb1 = new float[256];
  float[] treb2 = new float[256];
  
  arrayCopy(bass_subset, bass1);
  arrayCopy(bass_subset, bass2);
  arrayCopy(treb_subset, treb1);
  arrayCopy(treb_subset, treb2);
  
  draw_partial_spectrum(bass1, width/4, height/4, 100);
  draw_partial_spectrum(treb1, width/2, 0, 400);
  draw_partial_spectrum(bass2, 0, height/2, 100);
  draw_partial_spectrum(treb2, - width/2, 0, 400);
}
