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
//outside scene
//background music is folksy version of normal theme
#loadScene outside
{titles} {full_name()}: Standing before an impressive manor, you quickly check the invitaion you received a fortnight prior, disbelieving your good fortnue. //player starts in front of the door 
{titles} {full_name()}: "The Marquess and Marchioness of Derby request the pleasure of Miss Ruth Leigh's company at dinner on Thursday, the 14th of April, at 5 o’clock."//Will be displayed on a fancy calling card
{titles} {full_name()}: Along with the decadent note came a glorious gown and heels, which you now don. You are not used to such elaborate garments and buckle under the weight of the many layers. Attached to the dress was a short note, in a script dissimilar to what appeared on the invitation
"Surely, my dear Ruth, you have nothing to wear?" // also on fancy paper
{titles} {full_name()}:
* You were disarmed by hostile familarity of the note, <>
-> hostile

* You thought the note strange, <>
-> hostile

*You thought nothing of the note <>
->nothing

- (hostile)  but the chance to mingle with the likes of high society were too promising to miss. ->exitce 

- (nothing)  and were overjoyed that some guardian had placed you in good hands. {increase_stat(queer)} 

- (exitce) With anxious exitcement, you stare expecetedly at Rose House, wondering what the evening holds for you.   

-> arrived_At_Rose_House 

=== arrived_At_Rose_House ===
//outside scene
//background music is folksy version of normal theme
-(outside)

{time_waited < 4} {titles} {full_name()}: {{decrease_stat(temperment)} You arrive at the townhouse | After occupying ourself for a short while, you arrived |Surely, you figure, it is time to enter | If fifteen minutes is fashionably late, then I must be excelling in style at}{five minutes before the hour.|at Rose House again at exactly five o'clock. | fifteen minutes past the hour. | thirty minutes past the hour. | fourty-five past the hour}

    * You enter Rose House
    <> with much trepidation.
    
   //Temperment is now {temperment} //Test for stat_increase(). Will remove in game
    ->introductions
 
     + (wait) {time_waited < 3} [Wait] 
    {titles} {full_name()}: You wait {and take a stroll around the block. A street barker shouts the news of the day and you intently listen. |{increase_stat(temperment)} {increase_stat(temperment)} and hoped to find something of interest on the street. You glance at your heels, wishing you had a more comfortable option.| {decrease_stat(temperment)} {decrease_stat(temperment)}, and feel as if you will truly make quite an entrance. } //when you wait an animation will play of the player walking away from the door and then fade to black
    {waited()}
    ->outside

=== introductions ===
//parlor1 scene
//background music is normal parlor theme

#loadScene parlor1
{titles} {full_name()}:A manservant stands before you and looks approvingly at your dress. 
{titles} {full_name()}:You hand him your invitation and, without a word, he escorts you down a series of hallways, ending in a densely decorated parlor room.
{titles} {full_name()}: A woman of a certain age walks briskly towards you with a perplexed look on her face. 
Marchioness of Derby: Hello, my dear. I do not believe I've looked upon your face before. I imagine you are here for my intimatie soiree considering my footman let you through. You have the pleasure of my acquaintance, the Marchioness of Derby. I assume you must have heard of me, but again, I have not heard of you. //music cue - Marchioness intro 
Marchioness of Derby: You are? 
{titles} {full_name()}:
*You give your Christian name <>
and the Marchioness lets out a small scoff in return.
Marchioness of Derby: Well, I could never imagine a commoner would grace the halls of Rose House, but I suppose you were invited. An oversight on someone's part, surely. Regardless, please let me show you the other guests. They are quite distinguished, unlike youself. //music cue - bad reaction Marchioness
{increase_stat(queer)}
-> time

*You give a title (lie)
    
    What is your titled adresss?
    ** Lady Ruth Leigh<>
    ~titles = titles.Lady
    , you remark.
    Marchioness of Derby: How wonderful! I suppose your father is quite a remarkable gentleman. I must thank whomever invited such a delightful creature. Please, let me show you to the other guests. They are quite distinguished, like yourself. //music cue - good reaction Marchioness
   -> time
   
    ** Dowager Lady Maidstone<>
    , you remark.
    ~titles = Dowager
    ~titled = true 
    ~name = false
     Marchioness of Derby: Superb! Dreadful business about your late husband, I gather, but I must thank whomever invited such a distinguished guest. It is not every day we have such a honor to grace Rose House. Please, let me show you to the other guest, though I imagine you are more familiar with greater company.  //music cue - great reaction Marchioness
    ->time

-(time)
{time_waited != 1 : 
       Marchioness of Derby: By the by, I cannot abide by a lack of etiquette. Whoever you are, you must not arrive at Rose House at such an inopportune time. //music cue - bad reaction Marchioness
- else: 
     Marchioness of Derby: By the by, I approve of your adherence to proper etiquette. It is of the upmost importance in my home. If only all our guests matched your elegance and arrived at the Rose House at the proper time. //music cue - great reaction Marchioness
}
-(introduce)

{titles} {full_name()}: You are finally given a chance to properly survey the room. A number of guests are talking idly throughout. They seem to be waiting expectantly to be called to dinner. Several of the men immediately draw your attention. They give the apperance of eligible bachelors, eyeing up the female guests for suitable qualities. 
{titles} {full_name()}: A woman, about your age, gives you a queer look you cannot place as you glance around.

*You introduce yourself to the group, <> //should this have a negative effect, like minus temperment and wit?
    ->introduce_self

* You remain silent
    ->bachelor_And_Camilla_Intro

=introduce_self
 or at least you start to, but before you can finish the Marchioness interupts. 
 Marchioness of Derby: No, no my dear. You must know the gentleman always introduce themselves first. //music cue - bad reaction Marchioness
  {decrease_stat(temperment)}
  ->bachelor_And_Camilla_Intro
  
=bachelor_And_Camilla_Intro
{titles} {full_name()}: The Marchioness waves a hand at each of the men in turn.

Lord Essex: You may address me as Lord Essex, if you find it suitable. I await the pleasure of your acquaintance. //music cue - Lord Essex intro
 {titles} {full_name()}: Lord Essex appears a proper gentleman, if not a tad stiff. Perhaps the right mate could warm his cold heart. 

Lord Ascot: Good evening, or, as they say in great Nippon, konbanwa! I am called Lord Ascot, and not just due to my dashing attire.// music cue - Lord Ascot intro 
{titles} {full_name()}: Lord Ascot looks to be an eccentric but clearly a friendly one at that. You sense that he is often the life of the party and is looking for someone who can keep up.

Lord Bath: My lady, your beauty is as radiant as a young moon. I am eager to meet our "golden close of love" as my dear friend Alfred once said. The gentry label me as Lord Bath, but you may call me as you please.//music cue - Lord Bath intro
{titles} {full_name()}: Lord Bath might need to follow his name-sake as his disheleved apperance seems at odds with the occasion. Still you note his easy flirtation. 

{titles} {full_name()}: The Marchioness then turns to the queer-looking woman and remarks.
 Marchioness of Derby: And finally, this is my dearest daughter, Lady Camilla. 
 
 Lady Camilla: Lady Camilla gives you the same look and a slight smile.
 
 {titles} {full_name()}: The Marchioness looks to you and says
 
 Marchioness of Derby: And this is {titles} {full_name()}. Feel free to mingle, my dear. Dinner will be served shortly.
->chit_Chat

=== chit_Chat ===
//parlor1 scene
//background music is normal parlor theme
//maybe some murmering in the background

#gameEvent talkInParlor
-(talk_options)

{titles} {full_name()}:
*Talk to Lord Essex
 You walk over to Lord Essex
 ->chat_Essex

*Talk to Lord Ascot
You walk over to Lord Accot
->chat_Ascot

*Talk to Lord Bath
You walk over to Lord Bath
->chat_Bath

*{introductions.introduce_self} Talk to Lady Camilla 
You walk over to Lady Camilla
->chat_Camilla

* ->march_Order 

=chat_Essex

How do you address Lord Essex?
{introductions.introduce_self: {decrease_stat(temperment)} }

*[Lord Essex]
{titled == false:
{increase_stat(temperment)}
{NPC_full_name(Essex, Essex_title)}: I am pleased you respect my stature. Too many place familiarity above formality these days. //music cue - good reaction Essex

-else:
{NPC_full_name(Essex, Essex_title)}: You do me the honor of such an adresss but no doubt there is no need to demean yourself. //music cue - bad reaction Essex
}

*[Earl Essex]
~Essex_title = Earl
{decrease_stat(temperment)}
{NPC_full_name(Essex, Essex_title)}: Did you just address me -- aha, I get it. You must be joking with such needless formality. Yes yes, very clever.
//music cue - bad reaction Essex
*[Essex]
~Essex_title = Dummy1
{titled == true:
{increase_stat(temperment)}
{increase_stat(temperment)}
{NPC_full_name(Essex, Essex_title)}: Why, such forthrightness is rare these days. I am impressed with your command of your superior station.
//music cue - great reaction Essex
-else:
{decrease_stat(temperment)}
{NPC_full_name(Essex, Essex_title)}: Why, I never have been so insulted by one so common. //music cue - bad reaction Essex
}

-->talk_Essex

-(talk_Essex)
{NPC_full_name(Essex, Essex_title)}: Did you come over to chat with me?
    * Talk about politics
    {decrease_stat(temperment)}
    Now now, no need to steer polite conversation into such clefted water. It wouldn't be prudent.//music cue - bad reaction Essex
    
    * Talk about the weather
    {increase_stat(temperment)}
    Yes, a most pleasant topic. This long bout of overcast weather we've been having has suited me well this Spring.
    
    * Talk about the stock market//music cue - great reaction Essex
    {decrease_stat(temperment)} {decrease_stat(temperment)}
    I say! You should know a gentleman only speaks of financial affairs with his closest confidants and his wife. Do you already presume to be as such? Harumph!//music cue - bad reaction Essex
-->talk_options

=chat_Ascot
How do you address Lord Ascot?

*[Lord Ascot]
{decrease_stat(wit)}
{NPC_full_name(Ascot, Ascot_title)}: No need for such formality. If I wanted to talk to a marm I would dine at a schoolhouse. Totemo vulgar. //music cue - bad reaction Ascot

*[Viscount Ascot]
~Ascot_title = Viscount
{increase_stat(wit)}
{increase_stat(wit)}
{NPC_full_name(Ascot, Ascot_title)}: Omoshiroi! What a fabulous witticism. I sense a strong sense of irony in you. //music cue - great reaction Ascot

*[Ascot]
~Ascot_title = Dummy2
{increase_stat(wit)}
{NPC_full_name(Ascot, Ascot_title)}: Sugoi! Not everyone gets the line, but you caught on quick. I have quite the collection as you may have guessed. //music cue - good reaction Ascot

-->talk_Ascot

-(talk_Ascot)
{NPC_full_name(Ascot, Ascot_title)}: Well, my good miss, what do you like to do for leisure?
    * Fox hunting
        {decrease_stat(wit)}
        Ugh. I understand being prodigal, but spending all that money just to shoot an innocent creature? Poor little kitsunes.//music cue - bad reaction Ascot
        
    * Go to the horse races
        {decrease_stat(wit)}
        A common enough interest, if a little dull for my tastes. At least the horses all have colorful names, I suppose.//music cue - bad reaction Ascot
        
    * Read the latest issue of Punch
        {increase_stat(wit)}
        A sense of humor? Subarashi! My peers say Punch is a middle-class rag, but they wouldn't know satire if it yanked their tailcoats. //music cue - great reaction Ascot


-->talk_options

=chat_Bath
How do you address Lord Bath?
{introductions.introduce_self: {increase_stat(romance)}}

*[Lord Bath]
{decrease_stat(romance)}
{NPC_full_name(Bath, Bath_title)}: Dearest, my love, I scoff at wealth. As my friend William says

{NPC_full_name(Bath, Bath_title)}: "Is this a holy thing to see
{NPC_full_name(Bath, Bath_title)}: In a rich and fruitful land,
{NPC_full_name(Bath, Bath_title)}: Babes reduced to misery
{NPC_full_name(Bath, Bath_title)}: Fed with cold and usurous hand?"
//music cue - bad reaction Bath

*[Marquess Bath]
~Bath_title = Marquess
{decrease_stat(romance)}
{NPC_full_name(Bath, Bath_title)}: Although my dearest friend, Byron, has said: 
"Money, that most pure imagination, gleams only through the dawn of its creation." 
Do not mistake me for a patrician. I shirk such titles. 
//music cue - bad reaction Bath

*[Bath]
~Bath_title = Dummy3
{increase_stat(romance)}
{increase_stat(romance)}
{increase_stat(romance)}
{NPC_full_name(Bath, Bath_title)}: Ah, so informal already? No matter, I welcome the intimacy. My friend William once wrote of seeing Heaven in a wild flower, but I can only imagine what he would have seen in one as comely as you.
//music cue - great reaction Bath

-->talk_Bath

-(talk_Bath)
[Placeholder for more talk]
-->talk_options

=chat_Camilla
How do you address Lady Camilla?
{titled == true: {decrease_stat(queer)}{decrease_stat(queer)}}
{introductions.introduce_self: {increase_stat(queer)}}

*Lady Camilla
{NPC_full_name(Camilla, Camilla_title)}: She looks amused.
//music cue - good reaction Camilla

*Marchioness Derby
~Camilla_title = Marchioness
{NPC_full_name(Camilla, Camilla_title)}: She says that is her mother's name.
//music cue - bad reaction Camilla

*Camilla
~Camilla_title = Dummy4
{increase_stat(queer)}
{increase_stat(queer)}
{NPC_full_name(Camilla, Camilla_title)}: She takes pause at your familarity.
//music cue - great reaction Camilla

-->talk_Camiila

-(talk_Camiila)
{NPC_full_name(Camilla, Camilla_title)}: Hello, Miss Leigh. You must be wondering why someone of your low station received an invitation to an event as luxurious as my mother's party. Well, I'm the one who sent it! I saw you walking down Regent Street and knew you'd be perfect for my needs. The way you walked and dressed... why, it looked as though you just didn't care what anyone thought of you! //music cue - Camilla intro
{titles} {full_name()}: {NPC_full_name(Camilla, Camilla_title)} is looking at you eagerly for a response.

    *You look enchanting tonight. 
    {increase_stat(queer)}
    Camilla route
    //music cue - great reaction Camilla
    
    * What a marvelous dress you’re wearing, it really slims your figure. 
    neutral reaction
    //music cue - bad reaction Camilla
    * You want a punch in the sauce-box, church-bell? 
    bad reaction
    //music cue - bad reaction Camilla
   --> camilla_reveal 
   
-(camilla_reveal) {NPC_full_name(Camilla, Camilla_title)}: (Camilla whispers to you) Listen here, you little strumpet. The only reason you’re at this party is to make me look good by comparison. Do you think your peasant manners will let you fit in with a crowd of aristocrats? Ohoho! Your indelicacy is going to help me find a husband tonight!

-->talk_options

== march_Order ==
//parlor1 scene
//background music is normal parlor theme
//maybe some mummering in the background 

  <> Marchioness of Derby walks over.
  //if time add followup questions if appropriate 
  Marchioness of Derby: Pardon me, but I just remembered that you don't have an escort for dinner, dear! If you would please just answer a few questions, I can match you with an appropriate gentleman. 
  
  What does your father do?
  
  {titles} {full_name()}:
  
  *Solicitor
   Marchioness of Derby: Hmm, I see.
  {increase_stat(romance)}
  {increase_stat(queer)}
    //music cue - bad reaction Marchioness
    
  *Squire
   Marchioness of Derby: He must be a respectable man.
  {increase_stat(temperment)}
  //music cue - great reaction Marchioness
  
  *Doctor
   Marchioness of Derby: Ah, excellent.
  {increase_stat(wit)}
   //music cue - good reaction Marchioness
 
  - Where does your family holiday?
 
  {titles} {full_name()}:
  *Cairo 
  Marchioness of Derby: Oh, quite exotic.
  {increase_stat(wit)}
  //music cue - good reaction Marchioness
  
  *Nice 
  Marchioness of Derby: Really? You know, I’ve heard the Queen visits Nice often.
  {increase_stat(temperment)}
  //music cue - great reaction Marchioness
  
  *Brighton
  Marchioness of Derby: The seaside? How quaint…
  {increase_stat(queer)}
  //music cue - bad reaction Marchioness
  
  -What time do you eat dinner?
  
  {titles} {full_name()}:
  *Eight p.m.
  Marchioness of Derby: How fashionable of you!
  {increase_stat(temperment)}
  //music cue - great reaction Marchioness
  
  *Six p.m. 
  Marchioness of Derby: Like a proper young lady should.
  {increase_stat(wit)}
  //music cue - good reaction Marchioness
  
  *Noon
   Marchioness of Derby: Oh, dear. An unfortunate family tradition, I hope.
  {increase_stat(romance)} 
  {increase_stat(queer)}
  
  //music cue - bad reaction Marchioness
  --> pick_order 

=pick_order
//for testing
 Camila: {queer}
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
-order(temperment, wit, romance, queer) == romance:
->order_Bath
-else:
     ->order_rando
}

=order_rando
Picked Rando
~Bachloer_names = rando
-> march

=order_Essex
Picked Essex
~Bachloer_names = Essex
 -> march
=order_Ascot
Picked Ascot
~Bachloer_names = Ascot
 -> march
=order_Bath
Picked Bath
~Bachloer_names = Bath
 -> march    

=== march ===
//parlor2 scene
//background music is procession music 

#loadScene parlor2 
//maybe add marching convo
{
- Bachloer_names == rando:
    Walk with Rando
    ->dinner
- Bachloer_names == Essex:
    Walk with Essex
    ->dinner
- Bachloer_names == Ascot:
    Walk with Ascot
    ->dinner
- Bachloer_names == Bath:
    Walk with Bath
    ->dinner
}
=== dinner ===
//dining scene
//background music is dining music 
//mummering 

#loadScene dining
You are seated at a table with <>
{Bachloer_names == rando: 
      a {Bachloer_names} 
-else:
      {Bachloer_names}
 }  <>   
to your left.
->table_manners

=table_manners
A footman places a shallow bowl of pea soup in front of you. You:
	* Dip your bread in it 
	  {increase_stat(wit)}
	  {decrease_stat(temperment)}
	    You receive narrowed eyes and throat clearings from the diners around you, except for the Viscount Ascot. When he sees you dip your bread into the pea soup, he chuckles, then mimes doing it himself.
	    //music cue - good reaction Ascot
	    
	* Eat it with a spoon, sipping from the side 
	  {increase_stat(temperment)}
	  {decrease_stat(queer)}
	  (correct)
	  
	* Eat it with a spoon, blowing on it and sipping from the tip 
      {decrease_stat(temperment)}
      {decrease_stat(wit)}
      {increase_stat(queer)}
      (incorrect)
   -->trout
    
-(trout) The footman takes the bowl of pea soup away, and replaces it with a steaming plate of trout. You eat it:
	* Knife in right hand, fork in left 
	{decrease_stat(temperment)}
    {decrease_stat(wit)}
    (incorrect)
    
	* Napkin in right hand, fork in left 
	{decrease_stat(temperment)}
    {decrease_stat(wit)}
    {increase_stat(queer)}
    (incorrect)
    
	* Fork in right hand, bread in left (correct)
	{increase_stat(temperment)}
	{decrease_stat(queer)}
	(incorrect)
-->pudding

-(pudding) The footman takes the main course away, and places in front of you a small plate of the most Victorian of desserts, sponge pudding. You: 
	* Eat it with a spoon 
    {decrease_stat(temperment)}
    {decrease_stat(wit)}
	(incorrect)
	
	* Eat it with a fork 
	{increase_stat(temperment)}
	{decrease_stat(queer)}
	(correct)
	
	* Eat it with your hands
	{increase_stat(romance)}
    {decrease_stat(temperment)}
    {increase_stat(queer)}
        The table is aghast at your barbarous consumption of the pudding, except for the Marquess Bath. His eyes are ablaze with lust after witnessing your passionate eating style.
        //music cue - good reaction Bath

-->conversation_dinner

=conversation_dinner
There is a lull in the conversation
//mummering stops here

*Talk to {Bachloer_names}

*Talk to someone else

*Remain Silent

-->final_scene_prep 

=== final_scene_prep ===
//parlor3 scene
//background music is victory music for ending?
//if you end up with nobody sad failure music
//if you end up with Camilla super victory music 

//for the Camilla ending, it would make sense to gate it behind a minimum Queer score that requires the player to make all of the right Camilla Path decisions. Since Camilla is your rival, it makes sense that she would need a certain high number of correct decisions to win her over.
//if Camilla at threshold and biggest stat -> camilla ending, else: pick between bachelors

#loadScene parlor3

 Camila: {queer}
 Essex: {temperment}
 Ascot: {wit}
 Bath: {romance}
 
 {
 -order(temperment, wit, romance, queer) == queer:
     ->final_Camilla
-order(temperment, wit, romance, queer) == temperment:
     ->final_Essex
-order(temperment, wit, romance, queer) == wit:
     ->final_Ascot
-order(temperment, wit, romance, queer) == romance:
     ->final_Bath
-else:
     ->final_nobody
}

=final_Camilla
{queer < 2 : -> final_Essex}
~ending = Rossetti
#loadScene dining
->ending_Camilla

=final_Essex
{temperment < 2: -> final_Ascot}
~ending = Primus
~ending_last = Rank
#loadScene dining
->ending_Essex

=final_Ascot
{wit < 2: -> final_Bath}
~ending = Beau
~ending_last = Dandy
#loadScene dining
->ending_Ascot


=final_Bath
{romance < 2: ->final_nobody}
~ending = Blake
~ending_last = Percy
#loadScene dining
->ending_Bath


=final_nobody
->ending_nobody 


=ending_Camilla
Ended up with Camilla {ending} 
->DONE

=ending_Essex
Ended up with {ending} {ending_last}
->DONE

=ending_Ascot
Ended up with {ending} {ending_last}
->DONE

=ending_Bath
Ended up with {ending} {ending_last}
->DONE

=ending_nobody
Ended up with Nobody
->DONE
    
  





