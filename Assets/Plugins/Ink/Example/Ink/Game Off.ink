-> invitation

VAR time_waited = -5
VAR temperment = 0

== function increse_stat(ref x)
~  x += 1

== function waited
~time_waited += 5 

== invitation ==
Standing before an impressive manor, you quickly check the invitaion you received a fortnight prior, disbelieving your good fortnue. 
"The Marquess and Marchioness of Derby request the pleasure of Miss Ruth Leigh company at dinner on Thursday, the 14th of April, at 5 o’clock."//Will displayed on a fancy calling card
Along with the decandent note came a glorious gown and heels, which you now don. You are not used to such elaborate garments and buckle under the weight of the many layers. Attached to the dress was a short note, in a script dissimilar to what appeared on the invitation
"Surely, my dear Ruth, you have nothing to wear?" // also on fancy paper

*  You were disarmed by hostile familarity of the note, <>
-> hostile

* You thought the note strange, <>
-> hostile

*You thought nothing of the note <>
->nothing

- (hostile) but the chance to mingle with the likes of high society was too promising to miss. ->exitce

- (nothing) and were overjoyed that some guardian had placed you in good hands. {increse_stat(temperment)}

-(exitce) With anxious exitcement, you stare expecetedly at Rose House, wondering what the evening holds for you.  

-> arrived_at_Rose_House

=== arrived_at_Rose_House ===

-(outside)
{time_waited < 15} {You arrive at the townhouse | After occupying ourself for a short while, you arrived | Again, you dwindle the time away, arriving | Surely, you figure, it is time to enter}{five minutes before the hour. |at Rose House again at exactly five o'clock. | five minutes past the hour. |, ten minutes past the hour. | fifteen minutes past the hour.}

    *You enter Rose House
    <> with much trepadiation.
    
    Temperment is now {temperment} //Test for stat_increase(). Will remove in game
    ->DONE
    
     + (wait) {time_waited < 15} [Wait] 
    You wait { and take a stroll around the block. A street barker shouts the news of the day and you intently listen. |and hope to find something of interest on the street but fail to do so. You pondered the romantic prospects you imagine you will meet. |and become increasingly bored with the matter. You glance at your heels, wishing that a more comfortable option was available |{increse_stat(temperment)}, impressed with your own restraint and patience. You are confident you made the right choice and demostrated you ease with the etiquete of the day. }
    {waited()}
    ->outside





