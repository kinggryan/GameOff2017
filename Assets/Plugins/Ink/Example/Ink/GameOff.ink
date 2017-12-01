-> invitation

VAR time_waited = -1
VAR temperment = 0
VAR wit = 0
VAR romance = 0
VAR queer = -1
VAR titled = false
VAR name = true
VAR rando_Camilla = false

LIST titles = (Miss), Lady, Dowager //deterimes what is is on the UI when you talk
LIST Essex_title = (Lord), Earl, Dummy1 
LIST Ascot_title = (Lord), Viscount, Dummy2 
LIST Bath_title = (Lord), Marquess, Dummy3
LIST Camilla_title = (Lady), Marchioness, Dummy4
LIST ending = Rossetti, Primus, Beau, Blake, Nobody
LIST ending_last = Rank, Dandy, Percy


LIST Bachloer_names = rando, Holder, Essex, Ascot, Bath, Camilla //fix


== function increase_stat(ref x)
~  x += 1

== function decrease_stat(ref x)
~ x -= 1

== function waited
~time_waited += 1 

== function full_name()
{name == true:
   ~ return "Ruth Leigh"
-else:
   ~ return "Lady Maidstone"
}

== function NPC_full_name (x, list) //fix
{
- LIST_VALUE(list) == 3:
     ~return x

- else:
    ~return  x + list
}

== function order(a,b,c,d) ==
VAR bigger = 0
VAR bigger2 = 0
{a < b:
    ~bigger = b
-else:
    ~bigger = a
}

{c < d:
    ~bigger2 = d
-else:
     ~bigger2 = c
}

{bigger < bigger2:
    ~return bigger2
-else: 
     ~return bigger
}

== invitation ==
#changeMusic folksyMusic
#loadScene outside

{titles} {full_name()}: Standing before an impressive manor, you quickly check the invitaion you received a fortnight prior, disbelieving your good fortnue. 
{titles} {full_name()}: "The Marquess and Marchioness of Derby request the pleasure of Miss Ruth Leigh's company at dinner on Thursday, the 14th of April, at 5 o’clock."

{titles} {full_name()}: Along with the decadent note came a glorious gown and heels, which you now don. You are not used to such elaborate garments and buckle under the weight of the many layers.

{titles} {full_name()}: Attached to the dress was a short note, in a script dissimilar to what appeared on the invitation
{titles} {full_name()}: "Surely, my dear Ruth, you have nothing to wear?" 

{titles} {full_name()}:
* [You were disarmed by hostile familarity of the note...]
  {titles} {full_name()}: But the chance to mingle with the likes of high society were too promising to miss. 

* [You thought the note strange...]
   {titles} {full_name()}: But the chance to mingle with the likes of high society were too promising to miss.

*[You thought nothing of the note...]
 {titles} {full_name()}: And were overjoyed that some guardian had placed you in good hands. {increase_stat(queer)} 

-(excite) {titles} {full_name()}: With anxious exitcement, you stare expecetedly at Rose House, wondering what the evening holds for you.   
-> arrived_At_Rose_House 

=== arrived_At_Rose_House ===
-(outside)

{time_waited < 4} {titles} {full_name()}: { You arrive at the townhouse | After occupying ourself for a short while, you arrived |Surely, you figure, it is time to enter | If fifteen minutes is fashionably late, then I must be excelling in style at}{five minutes before the hour.|at Rose House again at exactly five o'clock. | fifteen minutes past the hour. | thirty minutes past the hour. | fourty-five past the hour}

    * [You enter Rose House]
        ->introductions
 
     + (wait) {time_waited < 3} [Wait] 
    {titles} {full_name()}: You wait {and take a stroll around the block. A street barker shouts the news of the day and you intently listen. | {increase_stat(temperment)} and hoped to find something of interest on the street. You glance at your heels, wishing you had a more comfortable option.|  {decrease_stat(temperment)}, and feel as if you will truly make quite an entrance. } #gameEvent walkAway
    {waited()}
    ->outside

=== introductions ===
#changeMusic parlorMusic
#loadScene parlor1

{titles} {full_name()}: A manservant stands before you and looks approvingly at your dress. 
{titles} {full_name()}:You hand him your invitation and, without a word, he escorts you down a series of hallways, ending in a densely decorated parlor room.
{titles} {full_name()}: A woman of a certain age walks briskly towards you with a perplexed look on her face. 
Marchioness of Derby: Hello, my dear. I do not believe I've looked upon your face before. I imagine you are here for my intimatie soiree considering my footman let you through. #playSound amyGreet
Marchioness of Derby: You have the pleasure of my acquaintance, the Marchioness of Derby. I assume you must have heard of me, but again, I have not heard of you. 
Marchioness of Derby: You are? 
{titles} {full_name()}:

*[You give your Christian name]
{titles} {full_name()}: The Marchioness lets out a small scoff in return.
Marchioness of Derby: Well, I could never imagine a commoner would grace the halls of Rose House, but I suppose you were invited. An oversight on someone's part, surely. #playSound amyNegative
Marchioness of Derby: Regardless, please let me show you the other guests. They are quite distinguished, unlike youself.{increase_stat(queer)}
-> time

*[You give a title (lie)]
    
   {titles} {full_name()}: What is your titled adresss?
    ** [Lady Ruth Leigh]
    ~titles = titles.Lady
    Marchioness of Derby: How wonderful! I suppose your father is quite a remarkable gentleman. I must thank whomever invited such a delightful creature. #playSound amyPositive
     Marchioness of Derby: Please, let me show you to the other guests. They are quite distinguished, like yourself. 
   -> time
   
    ** [Dowager Lady Maidstone]
    ~titles = Dowager
    ~titled = true 
    ~name = false
     Marchioness of Derby: Superb! Dreadful business about your late husband, I gather, but I must thank whomever invited such a distinguished guest. #playSound amyPositive
     Marchioness of Derby: It is not every day we have such a honor to grace Rose House. Please, let me show you to the other guest, though I imagine you are more familiar with greater company. 
    ->time

-(time)
{time_waited != 1 : 
       Marchioness of Derby: By the by, I cannot abide by a lack of etiquette. Whoever you are, you must not arrive at Rose House at such an inopportune time. #playSound amyNegative
- else: 
     Marchioness of Derby: By the by, I approve of your adherence to proper etiquette. It is of the upmost importance in my home. If only all our guests matched your elegance and arrived at the Rose House at the proper time. #playSound amyPositive
}
-(introduce)

{titles} {full_name()}: You are finally given a chance to properly survey the room. A number of guests are talking idly throughout. They seem to be waiting expectantly to be called to dinner. 
{titles} {full_name()}: Several of the men immediately draw your attention. They give the apperance of eligible bachelors, eyeing up the female guests for suitable qualities. 
{titles} {full_name()}: A woman, about your age, gives you a queer look you cannot place as you glance around.
{titles} {full_name()}:
*[You introduce yourself to the group] 
    ->introduce_self

* [You remain silent]
    ->bachelor_And_Camilla_Intro

=introduce_self
  {decrease_stat(temperment)} {titles} {full_name()}: Or at least you start to, but before you can finish the Marchioness interupts. 
 Marchioness of Derby: No, no my dear. You must know the gentleman always introduce themselves first. #playSound amyNegative
  ->bachelor_And_Camilla_Intro
  
=bachelor_And_Camilla_Intro
{titles} {full_name()}: The Marchioness waves a hand at each of the men in turn. #playSound amyIntro

Lord Essex: You may address me as Lord Essex, if you find it suitable. I await the pleasure of your acquaintance. #playSound essexGreet
 {titles} {full_name()}: Lord Essex appears a proper gentleman, if not a tad stiff. Perhaps the right mate could warm his cold heart. 

Lord Ascot: Good evening, or, as they say in great Nippon, konbanwa! I am called Lord Ascot, and not just due to my dashing attire. #playSound ascotGreet
{titles} {full_name()}: Lord Ascot looks to be an eccentric but clearly a friendly one at that. You sense that he is often the life of the party and is looking for someone who can keep up.

Lord Bath: My lady, your beauty is as radiant as a young moon. I am eager to meet our "golden close of love" as my dear friend Alfred once said. #playSound bathGreet
Lord Bath: The gentry label me as Lord Bath, but you may call me as you please.

{titles} {full_name()}: Lord Bath might need to follow his name-sake as his disheleved apperance seems at odds with the occasion. Still you note his easy flirtation. 

{titles} {full_name()}: The Marchioness then turns to the queer-looking woman and remarks.
 Marchioness of Derby: And finally, this is my dearest daughter, Lady Camilla. #playSound amyIntro
 
 Lady Camilla: Lady Camilla gives you the same look and a slight smile. #playSound camillaGreet
 
 {titles} {full_name()}: The Marchioness looks to you and says
 
 Marchioness of Derby: And this is {titles} {full_name()}. Feel free to mingle, my dear. Dinner will be served shortly. #playSound amyIntro
->chit_Chat

=== chit_Chat ===
#gameEvent talkInParlor

-(talk_options)

{titles} {full_name()}:
*[Talk to Lord Essex]
{titles} {full_name()}: You walk over to Lord Essex
 ->chat_Essex

*[Talk to Lord Ascot]
{titles} {full_name()}: You walk over to Lord Accot
->chat_Ascot

*[Talk to Lord Bath]
{titles} {full_name()}: You walk over to Lord Bath
->chat_Bath

*{introductions.introduce_self} [Talk to Lady Camilla] 
{titles} {full_name()}: You walk over to Lady Camilla
->chat_Camilla

*->march_Order 

=chat_Essex

{introductions.introduce_self: {decrease_stat(temperment)}} {titles} {full_name()}:How do you address Lord Essex?
{titles} {full_name()}:
*[Lord Essex]
{titled == false:
{increase_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: I am pleased you respect my stature. Too many place familiarity above formality these days. #playSound essexPositive

-else:
{NPC_full_name(Essex, Essex_title)}: You do me the honor of such an adresss but no doubt there is no need to demean yourself. #playSound essexNegative
}

*[Earl Essex]
~Essex_title = Earl
{decrease_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: Did you just address me -- aha, I get it. You must be joking with such needless formality. Yes yes, very clever. #playSound essexNegative
*[Essex]
~Essex_title = Dummy1
{titled == true: 
{increase_stat(temperment)} {increase_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: Why, such forthrightness is rare these days. I am impressed with your command of your superior station. #playSound essexPositive
-else:
{decrease_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: Why, I never have been so insulted by one so common. #playSound essexNegative
}
-->talk_Essex

-(talk_Essex)
{NPC_full_name(Essex, Essex_title)}: Did you come over to chat with me?
{titles} {full_name()}:
    * [Talk about politics]
    {decrease_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: Now now, no need to steer polite conversation into such clefted water. It wouldn't be prudent. #playSound essexNegative
    
    * [Talk about the weather]
    {increase_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: Yes, a most pleasant topic. This long bout of overcast weather we've been having has suited me well this Spring. #playSound essexPositive
    
    * [Talk about the stock market]
    {decrease_stat(temperment)} {decrease_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: I say! You should know a gentleman only speaks of financial affairs with his closest confidants and his wife. #playSound essexNegative 
    {NPC_full_name(Essex, Essex_title)}: Do you already presume to be as such? Harumph! 
-->talk_options

=chat_Ascot
{titles} {full_name()}: How do you address Lord Ascot?

*[Lord Ascot]
{decrease_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: No need for such formality. If I wanted to talk to a marm I would dine at a schoolhouse. Totemo vulgar.#playSound ascotNegative

*[Viscount Ascot]
~Ascot_title = Viscount
{increase_stat(wit)}{increase_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: Omoshiroi! What a fabulous witticism. I sense a strong sense of irony in you. #playSound ascotPositive

*[Ascot]
~Ascot_title = Dummy2
{increase_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: Sugoi! Not everyone gets the line, but you caught on quick. I have quite the collection as you may have guessed. #playSound ascotPositive
-->talk_Ascot

-(talk_Ascot)
{NPC_full_name(Ascot, Ascot_title)}: Well, my good miss, what do you like to do for leisure?
{titles} {full_name()}:
    * [Fox hunting]
        {decrease_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: Ugh. I understand being prodigal, but spending all that money just to shoot an innocent creature? Poor little kitsunes. #playSound ascotNegative
        
    * [Go to the horse races]
        {decrease_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: A common enough interest, if a little dull for my tastes. At least the horses all have colorful names, I suppose. #playSound ascotNegative
        
    * [Read the latest issue of Punch]
        {increase_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: A sense of humor? Subarashi! My peers say Punch is a middle-class rag, but they wouldn't know satire if it yanked their tailcoats. #playSound ascotPositive
-->talk_options

=chat_Bath
{titles} {full_name()}:How do you address Lord Bath? {introductions.introduce_self: {increase_stat(romance)}}
{titles} {full_name()}:
*[Lord Bath]
{decrease_stat(romance)}{NPC_full_name(Bath, Bath_title)}: Dearest, my love, I scoff at wealth. As my friend William says #playSound bathNegative

{NPC_full_name(Bath, Bath_title)}: "Is this a holy thing to see
{NPC_full_name(Bath, Bath_title)}: In a rich and fruitful land,
{NPC_full_name(Bath, Bath_title)}: Babes reduced to misery
{NPC_full_name(Bath, Bath_title)}: Fed with cold and usurous hand?"


*[Marquess Bath]
~Bath_title = Marquess
{decrease_stat(romance)}{NPC_full_name(Bath, Bath_title)}: Although my dearest friend, Byron, has said 
{NPC_full_name(Bath, Bath_title)}: "Money, that most pure imagination, gleams only through the dawn of its creation." #playSound bathNegative
{NPC_full_name(Bath, Bath_title)}: Do not mistake me for a patrician. I shirk such titles. 

*[Bath]
~Bath_title = Dummy3
{increase_stat(romance)}{increase_stat(romance)}{NPC_full_name(Bath, Bath_title)}: Ah, so informal already? No matter, I welcome the intimacy. #playSound bathPositive
{NPC_full_name(Bath, Bath_title)}: My friend William once wrote of seeing Heaven in a wild flower, but I can only imagine what he would have seen in one as comely as you.
-->talk_Bath

-(talk_Bath)
{NPC_full_name(Bath, Bath_title)}: You know, you're the right age to have marriage on your mind, and you strike me as someone pining for courtship. What kind of wedding do you want?

{titles} {full_name()}:
*[A big wedding in a fashionable church]
{decrease_stat(romance)}{NPC_full_name(Bath, Bath_title)}: Oh, really? That's... conventional. #playSound bathNegative

*[Elope to Scotland and get married]
{increase_stat(romance)}{NPC_full_name(Bath, Bath_title)}: A scandalous streak in you, eh? You know, many of my friends have eloped to Gretna Green. They say the blacksmith acts as witness. #playSound bathPositive

*[A small ceremony at home]
{decrease_stat(romance)}{NPC_full_name(Bath, Bath_title)}: I suppose your preference in romance is more Dickens and less Dante. #playSound bathNegative
-->talk_options

=chat_Camilla
{titles} {full_name()}:How do you address Lady Camilla? {titled == true: {decrease_stat(queer)}{decrease_stat(queer)}} {introductions.introduce_self: {increase_stat(queer)}}

{titles} {full_name()}:
*[Lady Camilla]
{NPC_full_name(Camilla, Camilla_title)}: It appears you have at least some training in how to address your betters. #playSound camillaPositive

*[Marchioness Derby]
~Camilla_title = Marchioness
{NPC_full_name(Camilla, Camilla_title)}: That is my mother's name. You must be disoriented, or perhaps just out of place. #playSound camillaNegative

*[Camilla]
~Camilla_title = Dummy4
{increase_stat(queer)}{increase_stat(queer)}{NPC_full_name(Camilla, Camilla_title)}: Remember who you speak to, Miss Leigh. Even commoners must observe basic decorum. #playSound camillaNegative

-->talk_Camiila

-(talk_Camiila)
{NPC_full_name(Camilla, Camilla_title)}: Hello, Miss Leigh. You must be wondering why someone of your low station received an invitation to an event as luxurious as my mother's party. 

{NPC_full_name(Camilla, Camilla_title)}: Well, I'm the one who sent it! I saw you walking down Regent Street and knew you'd be perfect for my needs. 

{NPC_full_name(Camilla, Camilla_title)}: The way you walked and dressed... why, it looked as though you just didn't care what anyone thought of you! 
 

{titles} {full_name()}: {NPC_full_name(Camilla, Camilla_title)} is looking at you eagerly for a response.
{titles} {full_name()}:
    *[You look enchanting tonight.]
    {increase_stat(queer)}{NPC_full_name(Camilla, Camilla_title)}: *Camilla blushes* #playSound camillaPositive
    
    *[What a marvelous dress you’re wearing, it really slims your figure.]
    *[You want a punch in the sauce-box, church-bell?]
  --> camilla_reveal 
   
-(camilla_reveal) 
{titles} {full_name()}: In a low voice {NPC_full_name(Camilla, Camilla_title)} whispers...

{NPC_full_name(Camilla, Camilla_title)}: Listen here, you little strumpet. The only reason you’re at this party is to make me look good by comparison. #playSound camillaNegative

{NPC_full_name(Camilla, Camilla_title)}: Do you think your peasant manners will let you fit in with a crowd of aristocrats? Ohoho! Your indelicacy is going to help me find a husband tonight!
-->talk_options

== march_Order ==
  {titles} {full_name()}: The Marchioness of Derby walks over.
  Marchioness of Derby: Pardon me, but I just remembered that you don't have an escort for dinner, dear! 
   Marchioness of Derby: If you would please just answer a few questions, I can match you with an appropriate gentleman. 
  
Marchioness of Derby: What does your father do?
  
  {titles} {full_name()}:
  
  *[Solicitor]
   {increase_stat(romance)} {increase_stat(queer)}Marchioness of Derby: Hmm, I see. #playSound amyNegative 
   
  *[Squire]
    {increase_stat(temperment)} Marchioness of Derby: He must be a respectable man. #playSound amyPositive
    
  *[Doctor]
   {increase_stat(wit)}Marchioness of Derby: Ah, excellent. #playSound amyPositive
 
  -  Marchioness of Derby: Where does your family holiday?
 
  {titles} {full_name()}:
  *[Cairo] 
 {increase_stat(wit)} Marchioness of Derby: Oh, quite exotic. #playSound amyPositive
  
  *[Nice]
   {increase_stat(temperment)} Marchioness of Derby: Really? You know, I’ve heard the Queen visits Nice often. #playSound amyPositive
 
  *[Brighton]
   {increase_stat(queer)} Marchioness of Derby: The seaside? How quaint… #playSound amyNegative
 
  - Marchioness of Derby: What time do you eat dinner?
  
  {titles} {full_name()}:
  *[Eight p.m.]
    {increase_stat(temperment)} Marchioness of Derby: How fashionable of you! #playSound amyPositive
    
  *[Six p.m.] 
  {increase_stat(wit)} Marchioness of Derby: Like a proper young lady should. #playSound amyPositive
  
  
  *[Noon]
     {increase_stat(romance)}{increase_stat(queer)}Marchioness of Derby: Oh, dear. An unfortunate family tradition, I hope. #playSound amyNegative
  --> pick_order 
=pick_order
//for testing
 {NPC_full_name(Camilla, Camilla_title)}: {queer}
 Essex: {temperment}
 Ascot: {wit}
 Bath: {romance}
 {
 -order(temperment, wit, romance, queer) == queer:
     ~rando_Camilla = true
     ->order_rando
-order(temperment, wit, romance, queer) == temperment:
     ->order_Essex
-order(temperment, wit, romance, queer) == wit:
     ->order_Ascot
-else:
     ->order_Bath
}
=order_rando
//Picked Rando
~Bachloer_names = rando
-> dinner

=order_Essex
//Picked Essex
~Bachloer_names = Essex
 -> dinner

=order_Ascot
//Picked Ascot
~Bachloer_names = Ascot
 -> dinner

=order_Bath
//Picked Bath
~Bachloer_names = Bath
 -> dinner    

=== dinner ===
#changeMusic dinnerMusic
#loadScene dining
 
{titles} {full_name()}: You are seated at a table with <>
{Bachloer_names == rando: 
      a {Bachloer_names} 
-else:
      {Bachloer_names}
 }  <>   
to your left.
->table_manners

=table_manners
  {titles} {full_name()}:A footman places a shallow bowl of pea soup in front of you. Do you...
    {titles} {full_name()}:
	* [Dip your bread in it] 
	  {increase_stat(wit)}{decrease_stat(temperment)}{titles} {full_name()}:  You receive narrowed eyes and throat clearings from the diners around you, except for Lord Ascot. 
	   {titles} {full_name()}: When he sees you dip your bread into the pea soup, he chuckles, then mimes doing it himself. #playSound ascotPositive
	    
	* [Eat it with a spoon, sipping from the side ]
	  {increase_stat(temperment)}{decrease_stat(queer)}{titles} {full_name()}: You look around the table, and see everyone else eating in the same manner. #playSound essexPositive
	   
	* [Eat it with a spoon, blowing on it and sipping from the tip]
      {decrease_stat(temperment)}{decrease_stat(wit)}{increase_stat(queer)}{titles} {full_name()}: {NPC_full_name(Camilla, Camilla_title)} looks your way and titters to herself over your mistake. #playSound camillaNegative
   -->trout
    
-(trout)  
{titles} {full_name()}: The footman takes the bowl of pea soup away, and replaces it with a steaming plate of trout. You eat it with...
 {titles} {full_name()}:
	* [Knife in right hand, fork in left ]
	{decrease_stat(temperment)}{decrease_stat(wit)}{titles} {full_name()}: This is the way you've always eaten fish, but you see that no one is using a knife and everyone has a piece of bread in their hand.
{titles} {full_name()}:They glance at you, annoyed.

	* [Napkin in right hand, fork in left ]
	{decrease_stat(temperment)}{decrease_stat(wit)}{increase_stat(queer)} {titles} {full_name()}: {NPC_full_name(Camilla, Camilla_title)} suppresses a smile at your lack of dining etiquette. #playSound camillaPositive
    
	* [Fork in right hand, bread in left ]
	{increase_stat(temperment)}{decrease_stat(queer)}{titles} {full_name()}: Though it feels strange, everyone else at the table is eating this way as well. #playSound essexPositive
-->pudding

-(pudding)  {titles} {full_name()}:The footman takes the main course away, and places in front of you a small plate of the most Victorian of desserts, sponge pudding. Do you... 
 {titles} {full_name()}:
	* [Eat it with a spoon ]
    {decrease_stat(temperment)}{decrease_stat(wit)}{titles} {full_name()}: A woman near you sees you use your spoon, and mutters "that's not how Victoria does it."
	* [Eat it with a fork ]
	{increase_stat(temperment)}{decrease_stat(queer)}{titles} {full_name()}: You, along with the majority of the table, eat your pudding with a fork. #playSound ascotPositive
	
	* [Eat it with your hands]
	{increase_stat(romance)}{decrease_stat(temperment)}{increase_stat(queer)}{titles} {full_name()}: The table is aghast at your barbarous consumption of the pudding, except for Lord Bath 
    {titles} {full_name()}: His eyes are ablaze with lust after witnessing your passionate eating style. #playSound bathPositive
-->conversation_dinner

=conversation_dinner
 {titles} {full_name()}: There is a lull in the conversation

-(dinner_options)
{titles} {full_name()}:
* [Talk to the man on your right]
{
- Bachloer_names == rando:
      ->dinner_rando
- Bachloer_names == Essex:
     ->dinner_Essex
- Bachloer_names == Ascot:
     ->dinner_Ascot
- Bachloer_names == Bath:   
     ->dinner_Bath
}
+ {dinner_options < 3} [Talk to someone else]
     ** {Bachloer_names != Essex} [Talk to Lord Essex]
            ->dinner_Essex
     ** {Bachloer_names != Ascot} [Talk to Lord Ascot] 
              ->dinner_Ascot
     ** {Bachloer_names != Bath} [Talk to Lord Bath]
             ->dinner_Bath
     ** {Bachloer_names != Camilla} [Talk to Lady Camilla]
              ->dinner_Camilla
*->final_scene_prep  
  
-(dinner_rando)
{titles} {full_name()}: The nameless gentleman had nothing of import to say.
->dinner_options

-(dinner_Essex)
{NPC_full_name(Essex, Essex_title)}: This dinner is excellent. You looked as though you were especially enjoying your soup.
 {titles} {full_name()}:
*[It was so tasty I thought about asking for seconds]
	{decrease_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: Well, good that you didn't. It's most unbecoming to ask for second helpings of soup, unless it's chowder of course. #playSound essexNegative
     
* [Actually, I preferred the fish.]
   {decrease_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: ...Yes, the fish was finely cooked as well. I didn't realize you were a woman of such strong opinion. #playSound essexNegative
   
* [I find it best to not talk about food during dinner.]
    {increase_stat(temperment)}{increase_stat(temperment)}{NPC_full_name(Essex, Essex_title)}: Oh... oh my. F-forgive me, Miss, I did not mean to act improper. Your senses must be better suited to etiquette than my own. #playSound essexPositive
-->dinner_options

-(dinner_Ascot)
{NPC_full_name(Ascot, Ascot_title)}: I just returned from a trip to Yokohama. You really must go, it's so delightfully rustic! Do you have any interest in the Far East?
{titles} {full_name()}:
*[I've heard China is a beautiful country]
  {decrease_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: Really? From the photographs I've seen China looks as though its best days are well behind it. It cannot compare to how kirei Nippon is.#playSound ascotNegative
  
*[I adore Chinese artwork]
  {increase_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: Yes, the Chinese do make some dazzling porcelain. A shame that country itself is stuck in the past, so the people are backwards.  #playSound ascotPositive
    {NPC_full_name(Ascot, Ascot_title)}: Unlike Nippon! The people there are so noble, like they’re living in the days of yore.
    
*[Japan is stupid]    
    {decrease_stat(wit)}{decrease_stat(wit)}{NPC_full_name(Ascot, Ascot_title)}: ...Baka. #playSound ascotNegative
-->dinner_options

-(dinner_Bath)
{NPC_full_name(Bath, Bath_title)}: My chemist introduced me to a lovely dark unguent that calms my nerves and elevates me closer to the spirits of inspiration.
{NPC_full_name(Bath, Bath_title)}: Its effects are so sublime, I scarce feel myself without it anymore. Tell me, my lady, do you have any vices?

{titles} {full_name()}:
* [I take some laudanum to help me sleep]
{increase_stat(romance)} {increase_stat(romance)}{NPC_full_name(Bath, Bath_title)}: My dear friend Samuel’s daughter had the same habit! If you’re feeling listless, I hear there are some wonderful rejuvenating elixirs being created in France using the coca plant. #playSound bathPositive
*[I occasionally drink to excess]
{increase_stat(romance)}{NPC_full_name(Bath, Bath_title)}: Only occasionally? Ah well, at least you’re not a teetotaler. Were you my wife, your tolerance to drink would quickly heighten. #playSound bathPositive
* [I stay away from vice]
{decrease_stat(romance)}{NPC_full_name(Bath, Bath_title)}: It’s a shame when a beautiful willow has its roots stuck in the mud. #playSound bathNegative
-->dinner_options

-(dinner_Camilla)
{titles} {full_name()}: Camilla is chatting with her mother.
Marchioness of Derby: The strangest thing happened the other day. I was walking down Bond doing some shopping, and I could have sworn I saw a lady who looked just like you walk down Regent Street, Camilla.
{NPC_full_name(Camilla, Camilla_title)}: Oh... that must have been someone else. You know I wouldn't be caught dead on Regent Street. 

Marchioness of Derby: Yes, I thought so at first, but I noticed this woman was wearing a gray hat that looks just like one I've seen you wear.

{NPC_full_name(Camilla, Camilla_title)}: I... I, uh...

{titles} {full_name()}:
*[Say nothing and let Camilla squirm.]
{NPC_full_name(Camilla, Camilla_title)}: I... it... what an unusual coincidence.

*[Camilla and I met on Regent Street.]
{decrease_stat(queer)}Marchioness of Derby: Ah, so I see you're the one who invited our unexpected guest.
  {NPC_full_name(Camilla, Camilla_title)}: *Camilla glares at you* #playSound camillaNegative

*[Shhh, don't tell anyone. Regent Street has the most fashionable boutiques.]
{increase_stat(queer)} {increase_stat(queer)}{NPC_full_name(Camilla, Camilla_title)}: I... yes, that's right. Hidden boutiques carrying dresses and accessories du jour.#playSound camillaPositive
{NPC_full_name(Camilla, Camilla_title)}: Do promise you'll keep this quiet, will you mother?

Marchiness of Derby: Really? Oh, how exciting! Your secret is safe with me, Camilla. Do you think you could show me these boutiques some time?

{NPC_full_name(Camilla, Camilla_title)}: ...Perhaps, in the future.
-->dinner_options

=== final_scene_prep ===
#changeMusic finalMusic
{titles} {full_name()}: After dessert, the men start drinking brandy and the ladies begin to leave for coffee. You are the last one out of the dining room. 
{titles} {full_name()}: As you walk through the parlor, you feel a tap on your shoulder.
//for the Camilla ending, it would make sense to gate it behind a minimum Queer score that requires the player to make all of the right Camilla Path decisions. Since Camilla is your rival, it makes sense that she would need a certain high number of correct decisions to win her over.
//if Camilla at threshold and biggest stat -> camilla ending, else: pick between bachelors

 Camila: {queer}
 Essex: {temperment}
 Ascot: {wit}
 Bath: {romance}
 
 {dinner.dinner_Camilla && chit_Chat.talk_Camiila :
     -> final_Camilla
-else:
    ->pick_bach
 }
 
 =pick_bach
 {
-order(temperment, wit, romance, queer) == temperment:
     ->final_Essex
-order(temperment, wit, romance, queer) == wit:
     ->final_Ascot
-else:
     ->final_Bath
}
 

=final_Camilla
{-order(temperment, wit, romance, queer) != queer:
     ->pick_bach
-else:
~ending = Rossetti
#loadScene parlor3
->ending_Camilla
}

=final_Essex
~ending = Primus
~ending_last = Rank
#loadScene parlor3
->ending_Essex

=final_Ascot
~ending = Beau
~ending_last = Dandy
#loadScene parlor3
->ending_Ascot

=final_Bath
~ending = Blake
~ending_last = Percy
#loadScene parlor3
->ending_Bath

=ending_Camilla
{NPC_full_name(Camilla, Camilla_title)}: Lord Essex proposed that he and I begin courting! He’s infatuated with me, thanks to your cloddish behavior letting me shine like a flawless gem.

{NPC_full_name(Camilla, Camilla_title)}: I suppose I owe you some sort of gratitude. You were quite congenial with me, even though I used your ill bearing for my own purposes.

{NPC_full_name(Camilla, Camilla_title)}: When you’re advancing through society you exchange pleasantries with many different kinds of people, but I sensed something different when you spoke to me. Was it… affection?

{NPC_full_name(Camilla, Camilla_title)}: Well, if you’re in the neighborhood again, do stop by and call sometime. I’ll be waiting. #playSound camillaPositive

{titles} {full_name()}: Camilla began inviting you for afternoon tea, and later to more private, intimate meetings.

{titles} {full_name()}: One year later, Camilla married Lord Essex and hired you as a governess for her coming children

{titles} {full_name()}: While working closely together, you and Camilla began to sneak off for secret love trysts.

{titles} {full_name()}: Lord Essex was none the wiser, never guessing that your bond was more than a close friendship.

->DONE

=ending_Essex
{NPC_full_name(Essex, Essex_title)}: Pardon me miss, may I have a moment of your time?
{NPC_full_name(Essex, Essex_title)}: All evening, you have been the picture of grace and social elegance. I’m not acquainted with your family, but you must come from immaculate breeding. 
{NPC_full_name(Essex, Essex_title)}: As an Earl, I need to have a respectable wife. You, my dear, are the most respectable woman I believe I have ever had the good fortune of meeting.
{NPC_full_name(Essex, Essex_title)}: Would you allow me the privilege of courting you? #playSound essexPositive

->DONE

=ending_Ascot
{NPC_full_name(Ascot, Ascot_title)}: Odoroku! I was afraid this party would be a dreadful bore. Thankfully, I found a magnificent conversation partner to help me stay awake.
{NPC_full_name(Ascot, Ascot_title)}: You know, I don’t meet many ladies like you at parties like these. You invest yourself in discussions without losing yourself to them. You jest without descending into impropriety.
{NPC_full_name(Ascot, Ascot_title)}: You even understand the greatness of Nippon!
{NPC_full_name(Ascot, Ascot_title)}: I am of marriageable age, but I’ve been looking for more than just a wife. I want a companion in my travels and adventures. 
{NPC_full_name(Ascot, Ascot_title)}: If I may be so presumptuous, would you be that companion? #playSound ascotPositive

->DONE

=ending_Bath
{NPC_full_name(Bath, Bath_title)}: Well, my lady, the hour draws late. However, I felt compelled to tell you something before I take my leave.
{NPC_full_name(Bath, Bath_title)}: I’ve been searching for a woman possessed of a delightful mania, with the fairness of a nymph, who has, before tonight, only visited me in my sweetest reveries. After encountering you, I can tell my search is at an end.
{NPC_full_name(Bath, Bath_title)}: Would you do me the honor of letting me give you a carriage ride home?
{NPC_full_name(Bath, Bath_title)}: Oh, but do me one favor. Pay little heed to the rumors surrounding my family’s estate. My fortunes may have temporarily deserted me, but that shant be the case for long!
{NPC_full_name(Bath, Bath_title)}: At my chemist’s suggestion, I have invested in Brazilian railway stocks that are destined to provide a generous return. With me, you will never want for comfort... or satisfaction. #playSound bathPositive
->DONE

    
  





