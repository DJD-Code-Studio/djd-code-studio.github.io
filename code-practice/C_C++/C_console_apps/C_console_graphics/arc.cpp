#include <graphics.h>
#include <conio.h>

int main(void)
{
   //int gd = DETECT, gm;

//   initgraph(&gd, &gm, "C:\\TC\\BGI");
int gd = DETECT, gm;
    initgraph(&gd,&gm, "C:\\tc\\bgi");
    circle(300,300,50);
    closegraph();
//    initwindow(400, 300);
//
//   arc(100, 100, 0, 135, 50);
//
   getch();
//   closegraph();
//   return 0;
}
