library tf2sb.globals;
import "dart:html";
import "html_template.dart";
import "character_data.dart" as CD;
import "tile_data.dart";

// Templates used for certain repeatable elements
HTMLTemplate tileTemplate;
HTMLTemplate selectTemplate;

const List<String> colors = const [
  // "white",
  "green",
  "blue",
  // "yellow",
  "orange",
  "purple",
  "red",
  "violet",
  "pink"
];


// 
enum Characters{
  Scout,
  Soldier,
  Pyro,

  Demo,
  Engineer,
  Heavy,

  Sniper,
  Medic,
  Spy,

  FAVORITES
}


CD.CharacterData createConfig( String name, List<String> quotes, int images, Characters char) =>  new CD.CharacterData(name, quotes, images, char);
Map<Characters, CD.CharacterData> initConfig = {
  Characters.Scout: createConfig("scout", [
    "I broke your stupid crap, moron",
    "Evil Laugh",
    "You.. are.. Terrible!",
    "I am the scout here!",
    "Drop dead and give me twenty.",
    "Hey, who's on fire now?",
    "Eat it you mute frikin moron.",
    "\$400k to fire that gun? Money well spent!",
    "I. Eat. Your. Sandwhiches. I eat em up!",
    "Here's a schematic for ya. My ASS!",
    "Here's something you shoulda built. A not dying machine!",
    "Diagnosis? You suck!",
    "I - HATE - doctors.",
    "I wasted you!",
    "I did it!",
    "Bang! I make it look easy.",
    "Wassamatter, y'freakin' stupid?",
    "Eat my dust!",
    "This sucks on ice!",
    "Boooooooo!",
    "Frickin' unbelievable.",
    "This is a real frickin' embarrassment."
  ], 10, Characters.Scout),
  Characters.Soldier: createConfig("soldier", [
    "Maggots!",
    "Take your lumps like a man, Private Twinkletoes.",
    "You will not be missed.",
    "I never liked you.",
    "Screamin' Eagles!",
    "Hooah!",
    "If God had wanted you to live, He would not have created me!",
    "Never bring a bat to a battlefield, war is not a game.",
    "You were in a big fat hurry to die, son.",
    "Dominated, you skirt-twirling drunk.",
    "This American boot just kicked your ass back to Russia!",
    "Stop hiding behind your little toys and fight like a man!",
    "America wins again!",
    "Aww, am I too violent for you, cupcake?",
    "The next time you want to kill a man, look him in the eyes!",
    "Outstanding!",
    "Today is a good day.",
    "Hehehyaaa!",
    "Get with the program!",
    "*Dying scream*",
    "*Dying scream*"
  ], 9, Characters.Soldier),
  Characters.Pyro: createConfig("pyro", [
    "Mmph mphna mprh.",
    "Evil laugh",
    "Evil laugh 2",
    "Mmmmmmmrrrrrrrpppghhh!",
    "Hudda hudda huh!",
    "Mhhhhoooooo!" ,
    "Tha fuh??",
    "Fire! Fire!!",
    "Mmmrgh!",
    "*Dying muffled scream*",
    "*Dying muffled scream 2*",
    "*Dying* URR URR",
    "Thanks for the teleport",
    "Thank you doc",
    "Ruuh Reeh reeh? Buh bum buh",
    "I don't know why I've got to do everything.",
    "Hurrururururu!",
    "Mrfer!",
    "Ow dow how dow.",
    "Murr hurr mphuphurrur, hurr mph phrr.",
    "They can go to hell!",
    "Just stand on the point you idiots!",
  ], 10, Characters.Pyro),

  Characters.Demo: createConfig("demo", [
    "Ya great lactating wet nurse!",
    "Don't fret, boyo. I'll be gentle!",
    "Oh, they're goin' ta have to glue you back together...IN HELL!",
    "And that's what yeh get for touching that!",
    "Bloody hell, those ones were me favorites!",
    "Let that be a bloody lesson to yeh!",
    "We did it, mate!",
    // "That'll teach 'em!",
    "...yer arses arse and I'm the grass man, punk yeah ya havin' heathen.",

    "Any one of you, I... (BURP)" ,
    "...the BOTH of yeh on you...",
    "Any one of you (belches) Everyone, damn it... (sobs)",

    "Aye, me bottle o' scrumpy!",
    "Ka-boooom!",
    "Kablooie!",
    "Evil laugh",
    "Evil laugh 2",
    "(Unintelligible Muttering)...I love you man...",

    "Dominated, ya wee scamperin' windbag!",
    "Lot o' good that Soldier trainin' did ya! I'm drunk!",
    "Cheers, mate!",
    // "I had me good eye on you the whole time!",
    "Leeeeet's do iiiiit!",
    "We're a sorry buncha' losers!",
  ], 10, Characters.Demo),
  Characters.Engineer: createConfig("engineer", [
    "Whoooowee! Makin' bacon!",
    "How'd that plan turn out for ya, dummy?",
    "That's what ya get!",
    "Whoooowee, would ya look at that!",
    "Nice goin', pardner!",
    "I told ya don't touch that darn thing.",
    "I built that.",
    "Gotcha!",
    "Sometimes, you just need a little less gun.",
    "Ain't that a cute little gun?",
    "I love that little gun!",
    "Y'all gotta run a lot faster than that.",
    "Y'all take that, rocket-boy.",
    "Gotcha, mumbles.",
    "Gotcha, eyehole.",
    "Gotcha, fat boy!",
    "Dominated, fat man!",
    "You're a looooooong way from France, boy.",
    "Hee hee... Yee-haw!",
    "Woooeee!",
    "Cream Gravy!",
    "Yippekeeyah-heeyapeeah-kayoh!",
    "Well, good night, Irene!",
    "*Dying scream*"
  ], 10, Characters.Engineer),
  Characters.Heavy: createConfig("heavy", [
    "Cry some more!",
    "Weeeeeeeeh! Waaaaaaaahh!",
    "Maniacal laugh",
    "I'm coming for you!",
    "Keep crying, baby!",
    "All of you are babies!",
    "Vzzzzzt! Rahrahrahrah! Vrrrrr! Wahahahaaaaaa!",
    "Ooohhhh, run, run, I'm coming for you!",
    "All of you are dead!",
    "Who send all these babies to fight!?",
    "Entire team is babies!",
    "What sick man sends babies to fight me?",
    "I destroy coward toys!",
    "Go ahead! Build your tiny gun then run!",
    "Haha!",
    "Hah!",
    "You cannot hide, coward.",
    "Happy laugh",
    "Little little man.",
    "You are no match for me!",
    "Go ahead and cry, baby."
  ], 11, Characters.Heavy),
  
  Characters.Sniper: createConfig("sniper", [
    "Mongrel!",
    "Bloody bogan!",
    "You bloody pikers!",
    "You're all a bunch of no-hopers!",
    "All your heads look bloody twelve feet tall.",
    "I'm gonna blow the inside of ya head all over four counties!",
    "I'm gunnin' for ya, you mongrels!",
    "This is gonna be a real piece of piss, you bloody fruit shop owners!",
    "Everything above your neck is going to be a fine red mist!",
    "Hold still!",
    "Now that was a proper bloody rootin'" ,
    "Bloody bogan." ,
    "You big-head wankers." ,
    "You prancin' show ponies." ,
    "D'they make them shirts for men?" ,
    "G'day!",
    "Wave goodbye to your head, wanker.",
    "Thanks fer standin' still, wanker!",
    "Ah, I'm sorry, mate.",
    "Standin' around like a bloody idiot!",
    "That helmet ain't gonna save ya.",
    "Ah... Piss!",
    "*Grumbles*",
    "*dyin sounds*",
    "*death man*",
  ], 10, Characters.Sniper),
  Characters.Medic: createConfig("medic", [
    "Eins, zwei, drei... Ugh, I do not think ve brought enough body bags.",
    "Haha! Vat a bloodbath!",
    "Ze healing is not as revarding as ze hurting.",
    "Oops! Zat was not medicine!",
    "Can you feel ze Schadenfreude?" ,
    "Danke, Kamerad!",
    "laugh",
    "happeh laugh",
    "Come over here. I promise I will heal you!",
    "Evil Laugh",
    "Stupendous!",
    "Schweinhunds.",
    "Forward!",
    "Heil, us!" ,
    "Iz zere a point to your lives?",
    "My skill is VASTED on zis team!",
    "DUMMKOPFS!",
    "Zis... is unacceptable!",
    "Anyvun still alive has let me down!",
    "Dawww..."
  ], 10, Characters.Medic),
  Characters.Spy: createConfig("spy", [
    "Evil laugh",
    "Happy laugh",
    "Coward!",
    "You disgust me!",
    "You got blood on my suit.",
    "With my apologies.",
    "Oh dear, I've made quite a mess.",
    "Pardon me.",
    "Thank you for being such a dear friend.",
    "Apologies.",
    "Surprise!",
    "Sorry to 'pop-in' unannounced.",
    "Peek-a-boo!",
    "Why don't we just give up, pardner?",
    "I murdered your toys as well.",
    "I never really was on your side.",
    "I'll see you in hell... you handsome rogue!",
    "Well, off to visit your mother!",
    "Here lies Scout--he ran fast and died a virgin.",
    "Oh, Soldier, who will they ever find to replace you? Anyone! (laughs)",
    "They can bury you in the 'Tomb of the Unskilled Soldier!'",
    "What's the matter? Fat got your tongue?",
    "Aww, too bad this wasn't a pie-eating contest!",
    "Hsssssssss!",
    "Well, this was a disappointment!",
    "I did all I could.",
    "What a disaster!",
    "Ugh...merde." ,
  ], 10, Characters.Spy),
};


/// Favorites system
Map<int,TileData> favoriteSounds = {};
final AudioElement _favoriteSound =  new AudioElement("audio/etc/favorited.wav")..load();
final AudioElement _unfavoriteSound =  new AudioElement("audio/etc/unfavorited.wav")..load();
void playFavoritedSound(bool favorited){
  var snd = (favorited)?_favoriteSound:_unfavoriteSound;
  snd.currentTime = 0;
  snd.play();
}