-> invitation

VAR time_waited = -1
VAR temperment = 0
VAR wit = 0
VAR romance = 0
VAR queer = -1
VAR titled = false
VAR name = true
LIST titles = (Miss), Lady, Dowager //deterimes what is is on the UI when you talk
LIST Essex_title = (Lord), Earl, Dummy1 
LIST Ascot_title = (Lord), Viscount, Dummy2 
LIST Bath_title = (Lord), Marquess, Dummy3
LIST Camilla_title = (Lady), Marchioness, Dummy4

LIST Bachloer_names = Place, Holder, Essex, Ascot, Bath, Camilla //fix


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

== invitation ==
{titles} {full_name()}: Standing before an impressive manor, you quickly check the invitaion you received a fortnight prior, disbelieving your good fortnue. //player starts in front of the door 
"The Marquess and Marchioness of Derby request the pleasure of Miss Ruth Leigh's company at dinner on Thursday, the 14th of April, at 5 o’clock."//Will be displayed on a fancy calling card
{titles} {full_name()}: Along with the decandent note came a glorious gown and heels, which you now don. You are not used to such elaborate garments and buckle under the weight of the many layers. Attached to the dress was a short note, in a script dissimilar to what appeared on the invitation
"Surely, my dear Ruth, you have nothing to wear?" // also on fancy paper

{titles} {full_name()}:
*  You were disarmed by hostile familarity of the note, <>
-> hostile

* You thought the note strange, <>
-> hostile

*You thought nothing of the note <>
->nothing

- (hostile) but the chance to mingle with the likes of high society were too promising to miss. ->exitce

- (nothing) and were overjoyed that some guardian had placed you in good hands. {increase_stat(temperment)}

- (exitce) With anxious exitcement, you stare expecetedly at Rose House, wondering what the evening holds for you.  

-> arrived_At_Rose_House

=== arrived_At_Rose_House ===

-(outside)

{time_waited < 4} {You arrive at the townhouse | After occupying ourself for a short while, you arrived |Surely, you figure, it is time to enter | If fifteen minutes is fashionably late, then I must be excelling in style at}{five minutes before the hour.|at Rose House again at exactly five o'clock. | fifteen minutes past the hour. | thirty minutes past the hour. | fourty-five past the hour}

    *You enter Rose House
    <> with much trepadiation.
    
  //  Temperment is now {temperment} //Test for stat_increase(). Will remove in game
    ->introductions
 
     + (wait) {time_waited < 3} [Wait] 
    You wait {and take a stroll around the block. A street barker shouts the news of the day and you intently listen. |{increase_stat(temperment)} and hoped to find something of interest on the street. You glance at your heels, wishing you had a more comfortable option.| {decrease_stat(temperment)}, and feel as if you will truly make quite an entrance. } //when you wait an animation will play of the player walking away from the door and then fade to black
    {waited()}
    ->outside

=== introductions ===
Servant: A servant escorts you to the parlor room. 
Marchioness of Derby: Amy walks up to you a little confused who you are. Amy asks for your name.
{titles} {full_name()}:
*Christian name

Marchioness of Derby: Amy scoffs at you 
-> time

*Make up title
    
    What is your titled adresss?
    ** Lady Ruth Leigh
    ~titles = titles.Lady
    Marchioness of Derby: Amy is somewhat impressed 
   -> time
   
    ** Dowager Lady Maidstone
    ~titles = Dowager
    ~titled = true 
    ~name = false
     Marchioness of Derby: Amy is very  impressed 
    ->time

-(time)
{time_waited != 1 : 
        Marchioness of Derby: Amy comments that you came at the wrong time 
- else: 
        Marchioness of Derby: Amy comments you came at right time
}
-(introduce)

{titles} {full_name()}: You look at the crowd.
* You start to introduce yourself to the group
    Marchioness of Derby: Amy admonishes you
    {decrease_stat(temperment)}
    ->bachelor_And_Camilla_Intro

* You remain silent
    ->bachelor_And_Camilla_Intro
    
=bachelor_And_Camilla_Intro
Marchioness of Derby: Amy introduces everyone.
->chit_Chat

=== chit_Chat ===

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

*Talk to Lady Camilla 
You walk over to Lady Camilla
->chat_Camilla

* ->march_Order

=chat_Essex
{titles} {full_name()}:

How do you address Lord Essex?

*Lord Essex
{titled == false:
{increase_stat(temperment)}
{NPC_full_name(Essex, Essex_title)}: He looks pleased

-else:
{NPC_full_name(Essex, Essex_title)}: He looks confused
}

*Earl Essex
~Essex_title = Earl
{decrease_stat(temperment)}
{NPC_full_name(Essex, Essex_title)}: He looks amused

*Essex
~Essex_title = Dummy1
{titled == true:
{increase_stat(temperment)}
{increase_stat(temperment)}
{NPC_full_name(Essex, Essex_title)}: He looks impressed

-else:
{decrease_stat(temperment)}
{NPC_full_name(Essex, Essex_title)}: He looks displeased
}

-->talk_Essex

-(talk_Essex)
[Placeholder for more talk]
-->talk_options

=chat_Ascot
{titles} {full_name()}:
How do you address Lord Ascot?

*Lord Ascot
{decrease_stat(wit)}
{NPC_full_name(Ascot, Ascot_title)}: He looks displeased

*Viscount Ascot
~Ascot_title = Viscount
{increase_stat(wit)}
{NPC_full_name(Ascot, Ascot_title)}: He looks amused

*Ascot
~Ascot_title = Dummy2
{increase_stat(wit)}
{NPC_full_name(Ascot, Ascot_title)}: He looks impressed

-->talk_Ascot

-(talk_Ascot)
[Placeholder for more talk]
-->talk_options

=chat_Bath
{titles} {full_name()}:
How do you address Lord Bath?

*Lord Bath
{titled == true:
{decrease_stat(romance)}
{NPC_full_name(Bath, Bath_title)}: He looks disgusted

-else:
{increase_stat(romance)}
{NPC_full_name(Bath, Bath_title)}: He looks enchanted
}

*Marquess Bath
~Bath_title = Marquess
{decrease_stat(romance)}
{decrease_stat(romance)}
{NPC_full_name(Bath, Bath_title)}: He looks disgusted

*Bath
~Bath_title = Dummy3
{titled == true:
{decrease_stat(romance)}
{NPC_full_name(Bath, Bath_title)}: He looks disgusted

-else:
{increase_stat(romance)}
{increase_stat(romance)}
{NPC_full_name(Bath, Bath_title)}: He looks enchanted 
}
-->talk_Bath

-(talk_Bath)
[Placeholder for more talk]
-->talk_options

=chat_Camilla
{titles} {full_name()}:
How do you address Lady Camilla?
{titled == true: {decrease_stat(queer)}{decrease_stat(queer)}}

*Lady Camilla
{NPC_full_name(Camilla, Camilla_title)}: She looks amused

*Marchioness Derby
~Camilla_title = Marchioness
{NPC_full_name(Camilla, Camilla_title)}: She says that is her mother's name

*Camilla
~Camilla_title = Dummy4
{increase_stat(queer)}
{increase_stat(queer)}
{NPC_full_name(Camilla, Camilla_title)}: She is warmed by your familarity


-->talk_Camiila

-(talk_Camiila)
[Placeholder for more talk]
-->talk_options

== march_Order ==
  Marchioness of Derby walks over and starts to ask you questions.
  ->DONE      

    
  





