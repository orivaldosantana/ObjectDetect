PImage photo;
int stateBuildRect = 0; 
float p1x, p1y, p2x, p2y, largura, altura; 
String nome, nomeBase, mensagem; 
int contFrames = 10; 
  
PrintWriter output;

void setup() {
  //size(640, 480);
  //size(285,160);
  size(720,480);
  // Create a new file in the sketch directory
  output = createWriter("positive_ieee_open.txt"); 
  //nome = "1.jpg"; 

  //nomeBase = "images/frame";
  nomeBase = "../pos_ieee_open/000000";
  nome = nomeBase+contFrames+".jpg"; 
  mensagem = "Selecione um ponto!"; 
  photo = loadImage(nome);
}

void draw() {
  
  stroke(255, 50, 0);
  image(photo, 0, 0);
  if (stateBuildRect == 1) {
    noFill(); 
    rect(p1x,p1y,mouseX-p1x,mouseY-p1y);
  }
  if (stateBuildRect == 2) {
    noFill(); 
    largura = p2x-p1x; 
    altura = p2y-p1y; 
    rect(p1x,p1y,largura,altura);
    text("A imagem \""+nome+"\".", 10, 140);
  }  
  fill(255, 50, 0);
  textSize(14);
  text(mensagem, 10, 30);
  
}

void mouseClicked() {
  if (stateBuildRect == 0) {
    p1x = mouseX; 
    p1y = mouseY; 
    stateBuildRect = 1;  
    mensagem = "Desenhe um quadrado para salvar a image \""+nome+"\""; 
  } else  
    if (stateBuildRect == 1) {
      p2x = mouseX; 
      p2y = mouseY; 
      stateBuildRect = 2; 
      mensagem = "Click em qualquer região para salvar."; 
      text("Imagem \""+nome+"\" salva.", 10, 50);
    }
    else 
      if (stateBuildRect == 2) { 
          println(nome," ",p1x," ",p1y," ",largura," ",altura); 
          output.println(nome+" 1 "+p1x+" "+p1y+" "+largura+" "+altura);
          mensagem = "Imagem \""+nome+"\" salva.";
          stateBuildRect = 3;
          contFrames++;
      }
      else 
      if (stateBuildRect == 3) { 
          nome = nomeBase+contFrames+".jpg";
          photo = loadImage(nome);
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