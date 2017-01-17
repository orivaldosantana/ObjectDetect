PImage photo, roi;
int stateBuildRect = 0; 
float p1x, p1y, p2x, p2y, largura, altura; 
String nomeSrc, nomeBase, mensagem, nomeBaseToSave, nomeDst;  
int contFrames = 10; 
  
PrintWriter output;

void criaSalvaImagem(String nome, float xa, float ya, float l, float a) {
  PImage newImage = createImage((int)l, (int)a, ALPHA);
 
  // We are going to look at both image's pixels
  photo.loadPixels();
  newImage.loadPixels();
  
  for (int x = 0; x < newImage.width; x++) {
    for (int y = 0; y < newImage.height; y++ ) {
        int xp = int(xa+x); 
        int yp = int(ya+y);
        int loc = x + y*newImage.width;
        int locPhoto = xp + yp*photo.width;
        newImage.pixels[loc]  = photo.pixels[locPhoto]; 
    }
  }
  // We changed the pixels in destination
  newImage.updatePixels();
  newImage.save(nome); 
}

void setup() {
  //size(640, 480);
  //size(285,160);
  size(720,480);
  // Create a new file in the sketch directory
  output = createWriter("negative_objects.txt"); 
  //nome = "1.jpg"; 
  //nomeBase = "images/frame";
  nomeBase = "../positive_samples/pos_ieee_open/000000";
  nomeBaseToSave = "neg_tags_cel/neg";
  
  nomeSrc = nomeBase+contFrames+".jpg";
  nomeDst = nomeBaseToSave+contFrames+".jpg";
  mensagem = "Selecione um ponto!"; 
  photo = loadImage(nomeSrc);
  
  largura = 130;
  altura = 130; 
}

void draw() {
  stroke(255, 50, 0);
  image(photo, 0, 0);
  if (stateBuildRect == 1) {
    noFill(); 
    rect(mouseX,mouseY,largura,altura);
  }
  if (stateBuildRect == 2) {
    noFill(); 
    
    rect(p1x,p1y,largura,altura);
    text("A imagem \""+nomeDst+"\".", 10, 140);
  }  
  fill(255, 50, 0);
  textSize(14);
  text(mensagem, 10, 30);
}

void mouseClicked() {
  if (stateBuildRect == 0) {

    stateBuildRect = 1;  
    mensagem = "Selecione um ponto para criar uma image \""+nomeDst+"\""; 
  } else  
    if (stateBuildRect == 1) {
      p1x = mouseX; 
      p1y = mouseY; 
      stateBuildRect = 2; 
      mensagem = "Click em qualquer região para salvar."; 
      text("Imagem \""+nomeDst+"\" salva.", 10, 50);
    }
    else 
      if (stateBuildRect == 2) { 
          println(nomeDst," "); 
          output.println(nomeDst);
          mensagem = "Imagem \""+nomeDst+"\" salva.";
          stateBuildRect = 3;
          contFrames++;
      }
      else 
      if (stateBuildRect == 3) { 
          nomeDst = nomeBaseToSave+contFrames+".jpg";
          nomeSrc = nomeBase+contFrames+".jpg";
          photo = loadImage(nomeSrc);
          criaSalvaImagem(nomeDst,p1x,p1y,largura,altura);
          stateBuildRect = 0; 
          mensagem = "Proxima imagem. Escolha um ponto";          
      }
}

void keyPressed() {
  if ( key == 'x' ) {
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    exit(); // Stops the program
  }
}