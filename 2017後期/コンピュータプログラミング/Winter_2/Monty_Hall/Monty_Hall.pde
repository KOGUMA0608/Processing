import controlP5.*;
ControlP5 cp5;
String stage;//今ゲームが何段階目まで進行しているか
PFont TimesNewRoman;
PFont Migu;
PFont Migubold;
Howto howto;
Game game;
void setup() {
  Door[] door;
  cp5=new ControlP5(this);
  size(1280, 640);
  int id;
  int correct;
  door=new Door[100];
  for (int i=0; i<100; i++) {
    id=i+1;
    door[i]=new Door(id);
  }
  correct=(int)random(100);
  door[correct].correct=true;


  size(1280, 640);
  fill(#000000);
  TimesNewRoman = loadFont("TimesNewRomanPS-BoldMT-48.vlw");
  Migu=loadFont("migu-1m-regular-48.vlw");
  Migubold=loadFont("migu-1m-bold-48.vlw"); 
  textFont(TimesNewRoman);
  background(255, 255, 255);
  howto=new Howto();
  game=new Game();

  stage="title";//タイトル画面
}
void draw() {
  background(255, 255, 255);
  if (stage.equals("play")) {
    //game.stageStart();//ゲームスタート!
  }
  if (stage.equals("howto")) {
    howto.howto();//ゲームスタート!
  }
  System.out.println(stage);
} //<>//
//なんかTitleクラス内に入れると反応しないからここに置いた(本当はTitleクラス内で管理したい)
class Howto {
  int stage;//現在の段階
  Howto() {  
    howto();
  }
  void howto() {
    //ゲームの概要
    textFont(Migu);
    textSize(35);
    String reference="皆さんは「モンティ・ホール問題」と呼ばれるものを聞いたことがありますか？"
      +"\n例えば・・・皆さんの前に3つの箱があり、そのうち1つにはお宝が入っています。"
      +"\nまず、みなさんはその中から1つを選びます。すると、あなたが選んでいないハズレの箱が一つ開きます。"
      +"/nそして、あなたはもう一度箱を選び直すことができます"
      +"/nその場合、箱を選び直した場合と選び直さなかった場合ではどちらのほうが当たる確率が高いか？と言うものです"
      +"/nそんなわけで、今回はそれをモチーフにしたゲームを作成しました";
    text(reference, 0, 40);
  }
}
class Game {
  int level;//現在のステージ
  int stage;//現在の段階

  Game() {
    /*
    cp5.addButton("play")
     .setLabel("START")
     .setPosition(50, 50)
     .setSize(300, 200);
     //void start(){}
     cp5.addButton("howto")
     .setLabel("Howtoplay")
     .setPosition(350, 50)
     .setSize(300, 200);
     */

    for (int i=0; i<10; i++) {
      int j;
      for (j=0; j<10; j++) {
        cp5.addButton("door_"+i+j+1)
          .setLabel("door_"+i+j+1)
          .setPosition(10+i*50, 10+j*30)
          .setSize(40, 20);
      }
      j=0;
    }

    level=1;
  }
  void gameover() {
  }
}

class Door {
  final int ID;//ドアの固有ID
  boolean correct;//正解のドアか？
  Door(int id) {
    this.ID=id;
  }
}
public class Button {
  //なんでJavaのButtonを取り扱うような標準クラスがないんだ？おかげで自作しなくちゃならない。こういうの全然やったことなかったから作業時間の殆どはここに持ってかれた・・・
  String button_id;
  int button_x;
  int button_y;
  int x_size;
  int y_size;
  PImage texture;
  String text;
  boolean visible=false; 
  boolean click=false;

  //文字無し
  Button(String button_id, int button_x, int button_y, int x_size, int y_size, String texture) {
    this.button_id=button_id;
    this.button_x=button_x;
    this.button_y=button_y;
    this.x_size=x_size;
    this.y_size=y_size;
    this.texture = loadImage(texture);
  }
  //文字あり
  Button(String button_id, int button_x, int button_y, int x_size, int y_size, String texture, String text) {
    this.button_id=button_id;
    this.button_x=button_x;
    this.button_y=button_y;
    this.x_size=x_size;
    this.y_size=y_size;
    this.texture = loadImage(texture);
    this.text=text;
  }

  void adding() {
    visible=true;
  }
  void removeing() {
    visible=false;
  }

  void view() {
    if (visible) {
      image(texture, button_x, button_y, x_size, y_size);
      if (text!=null) {
        textSize(20);
        textAlign(CENTER);
        text(text, button_x+x_size/2, button_y+y_size/2);
      }
      if (mousePressed&&mouseX>=(button_x-x_size/2)&&mouseX<=(button_x+x_size/2)&&mouseY<=button_y+y_size/2&&mouseY>=button_y-y_size/2) {
        click=true;
        System.out.println("Button"+button_id+"が押されました！");
      }
      if (click) {
        click(button_id);
        click=false;
      }
    }
  }
  /*void mousePressed() {
   if (mouseX>=(button_x-x_size/2)&&mouseX<=(button_x+x_size/2)&&mouseY<=button_y+y_size/2&&mouseY>=button_y-y_size/2) {
   click=true;
   System.out.println("Button"+button_id+"が押されました！");
   }
   }*/

  String click(String button_id) {
    return button_id;
  }
}