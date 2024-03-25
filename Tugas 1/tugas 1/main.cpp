#include <iostream>

using namespace std;

class character{
public:

    int herbs = 3;
    int manapotion = 3;
    int hppotion = 3;
    int swords[2] = {20,30};
    int equippedsword=0;
    int hp = 100;
    int mana = 100;
    int damage = swords[equippedsword];


    void useherb(){
        if(herbs<1){
            cout << "anda tidak memiliki herbs" << endl;
        }else if(hp>=100){
            cout << "HP anda penuh" << endl;
        }else{
        herbs=herbs-1;
        hp=hp+5;
        cout << "anda menggunakan herbs +10hp" << endl;
        }
    }
    void usehppotion(){
        if(hppotion<=1){
            cout << "Anda tidak punya obat HP" << endl;
        }else if(hp>=100){
            cout << "HP anda penuh" << endl;
        }else{
    hppotion=hppotion-1;
        hp=hp+30;
        cout << "anda menggunakan obat +30hp" << endl;
        }
    }
    void usemanapotion(){
        if(manapotion<=1){
            cout << "Anda tidak memiliki obat mana" << endl;
        }else if(mana>=100){
            cout << "Mana anda penuh" << endl;
        }else{
        manapotion=manapotion-1;
        mana=mana+20;
        cout << "anda menggunakan obat mana +10mana" << endl;
        }
    }

    void changesword(int a){
        damage=damage-swords[equippedsword]+swords[a];
        equippedsword=a;
    }

    void status(){
        cout << "hp = " << hp << endl;
        cout << "mana = " << mana << endl;
        cout << "damage = " << damage << endl;
        cout << "anda menggunanakan senjata = " << equippedsword << endl << endl;
    }
    void bag(){
        cout << "====inventory=====" << endl;
        cout << "herbs = " << herbs << endl;
        cout << "obat mana = " << manapotion << endl;
        cout << "obat hp  = " << hppotion << endl << endl;
    }
};


int main()
{
    character mina;
    mina.status();
    mina.bag();
    mina.useherb();
    mina.usemanapotion();
    mina.usehppotion();
    mina.changesword(1);

    cout << endl;

    mina.status();
    mina.bag();

    return 0;
}
