Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA25880
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 11:33:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA25075
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 16:33:39 GMT
Received: from smtp3-cm.mail.eni.net (smtp3-cm.mail.eni.net [216.133.226.136])
	by jazzswing.ncsc.mil  with ESMTP id QAA25071
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 16:33:37 GMT
From: "John Cordani" <cordanij@twminc.com>
To: <paul@bladestorm.com>, <selinux@tycho.nsa.gov>
Subject: RE: Cature the flag (was Re: Selinux kernel patches)
Date: Fri, 9 Feb 2001 11:31:32 -0500
Message-ID: <NEBBIAJJNBKNINJEFODOIEKJCBAA.cordanij@twminc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <200102091033.AA740426066@bladestorm.com>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Paul,
As a scientist I certainly try to apply science to the production of
information products. I agree with your stance on this issue. Certainly
engineers and scientists should first test their hypothesis and experiment
in a controlled environment prior to any beta release. When the engineering
and testing teams have reached their conclusions and refinements an open
test of the beta release might be warrented.

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of paul
Sent: Friday, February 09, 2001 10:33 AM
To: selinux@tycho.nsa.gov
Subject: Re: Cature the flag (was Re: Selinux kernel patches)


I have always felt that the best way to test a piece of software is the same
way that any scientist would test a hypothesis.  The hypothesis here is that
the software is secure.  So in order to test that hypothesis you have to
have people that test that software for security holes.

In my opinion, finishing a piece of software and then inviting the whole
planet to try and "hack" it for $200 and a free shirt is just not the best
way to approach this.  You will end up with people from all over the planet
not only attacking the system but also the network, including other systems
on the same wire that are gathering packets, routers, and perhaps even the
upstream provider.  Sure, you can say that all these are off limits, but
people will simply not care as has been shown by these kind of "tests" over
and over and over.

What we intend to do at Bladestorm is to integrate all the efforts here into
our distribution and conduct a controlled test, where the software is tested
by security professionals.  It will be probed and tested thoroughly, we
would report our findings, patch, reprobe, and then after that cycle is done
we will do a beta.  And the beta would be to put the distribution into
environments where the software can be tested.  This way, we can eliminate
variables such as routers going down and so forth and really be able to
pinpoint holes.

Public stunts like this is more like handing 2,000 people a can opener and
telling them all to try to be the first to open a can.  You end up with a
mess, and a lot of spilled tomato soup.  It's just not worth it from my
vantage point.

---------- Original Message ----------------------------------
From: Sandy Harris <sandy@storm.ca>
Date: Thu, 08 Feb 2001 21:32:11 -0500

>Dale Amon wrote:
>>
>> On Tue, Feb 06, 2001 at 03:28:44PM -0500, Pete Loscocco wrote:
>> > We think that we have a good architecture and that it warrants
>> > consideration. ...
>>
>> Just a wild suggestion. When things are well along and
>> everyone thinks the system is ready, why not put a box
>> out on a public network for a game of "capture the flag"?
>
>The annual Defcon conference (http://www.defcon.org/) has run such
>a contest, on a LAN at the conference, for several years now. Some
>firewall vendors bring machines for use as targets.
>
>> Offer a free T-shirt "I cracked the NSA" to anyone who
>> succeeds *and* tells precisely how it was done. Set up
>> tests for system cracks both from fully external or from
>> various shell access levels.
>
>In addition to attackers' machines and target machiness, they have
>other machines doing packet logging so attacks can be analysed
>later.
>
>A web search on "defcon capture the flag" will turn up the rules,
>last year's logs and some discussion.
>
>--
>You have received this message because you are subscribed to the selinux
list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
>the words "unsubscribe selinux" without quotes as the message.
>

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
