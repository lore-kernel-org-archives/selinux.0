Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA17825
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 18:18:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA29924
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 22:18:11 GMT
Received: from mailgw1a.lmco.com (mailgw1a.lmco.com [192.31.106.7])
	by jazzswing.ncsc.mil  with ESMTP id WAA29920
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 22:18:10 GMT
Date: Tue, 04 Jun 2002 16:17:34 -0600
From: "McFadden, Ken" <ken.mcfadden@lmco.com>
Subject: RE: Sorry, read this one: Re: SELinux Dumb Questions
To: "'JW'" <jw@centraltexasit.com>, SE Linux <selinux@tycho.nsa.gov>
Cc: "Haigh, Tom" <tom_haigh@securecomputing.com>
Message-id: <31A81CDD9175D411815100508BE32AA60142F387@emss02m13.ems.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tom,
You need to get with the NSA to remove the download from their web
page then, but as long as we download from NSA and per their license
agreement http://www.nsa.gov/selinux/license.html it is free and you
can't put any restrictions on it.......



-----Original Message-----
From: JW [mailto:jw@centraltexasit.com]
Sent: Tuesday, June 04, 2002 3:49 PM
To: SE Linux
Cc: Haigh, Tom; 'Admissions Office'; Carsten Grohmann; Russell Coker
Subject: Sorry, read this one: Re: SELinux Dumb Questions


Sorry about that last empty message, I accidently hit ^[ENTER] when I meant 
hit shift...
-------------------

Something is really amiss with this and needs to be brought to a reasonable 
conclusion soon. Read on for details...

On Monday, 03 June Admissions Office wrote:
> > Folks this may seem like a dumb question given the Open Source and
> > postings on the site. Its just that we want to be sure....
> >
> > Is there any reason why a Colo company cannot offer SELinux as a
standard
> > product offering they would install on clients servers?

And on Monday 03 June Russell Coker replied:
> As Mark stated there are no license or legal issues preventing such use.

BUT;
On Monday 03 June Tom Haigh wrote:

> SELinux includes Type Enforcement technology developed and patented by the
> Secure Computing Corporation, who still holds rights to all commercial use
> of the technology.  Before a colo company, or anyone else uses the
> technology commercially, it will be necessary to negotiate a license with
> Secure Computing.  If anyone wants to do so, I can help get the ball
> rolling with our Legal and BD folks.
>
> --Tom
>
> Dr. Tom Haigh, CTO
> Secure Computing Corp.
> 2675 Long Lake Road
> Roseville, MN 55113
>
> 651-628-2738 (V)
> 651-628-2701 (F)
>
> haigh@securecomputing.com


There is some severe misunderstanding here. 

IANAL, but it is my understanding that you cannot restrict the use or 
distribution of GPLd Free Software. It simply does not work that way, no 
exceptions, no excuses. Once code is GPLd it is free for all to use. You can

change the license on future versions of the code, but you cannot go back
and 
restrict GPL's code "after the fact"

Either:

 1. Someone (at the NSA?) affixed the GPL to code they didn't have a right
to 
do so on, or

2. (More likely) Secure Computing did not understand under what terms they 
were developing Type Enforcment for the NSA under.

I've got the flu right now so I'm too tried to reason it all through, but 
_someone_ needs to very soon.

Just a few implications that come to the top of my head if Secure COmputing 
is right:

1. SELinux patches cannot legally be applied to GPLd software or the Linux 
kernel, because that would break the GPL itself (GPL forbids making non-free

changes to GPL'd code -- i.e., if you modify GPL'd code, the modifications 
must be made available under the terms of the GPL).

2. It will need to be removed from Debian's tree -- at least moved to 
non-free, yet as I said before, if Secure Computing is correct, SE-Linux is 
not legal to use with GPL'd software anyway (at least the way I see it).

You'd better bet that GNU and other people who's code is being modified to 
work with SE-Linux will have ten purple cows on anyone who mixes non-free 
code with their GPLd code.

Perhaps I'm totally misunderstanding something while I'm half-delirious with

the flu, but this needs to be clarified _soon_.

	JW

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
