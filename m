Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA24007
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2001 17:40:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA02244
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2001 21:39:58 GMT
Received: from mailhost.auckland.ac.nz (mailhost.auckland.ac.nz [130.216.1.4])
	by jazzband.ncsc.mil  with ESMTP id VAA02236
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2001 21:39:56 GMT
Received: from gromit.ele.auckland.ac.nz (IDENT:postfix@gromit.ele.auckland.ac.nz [130.216.216.23])
	by mailhost.auckland.ac.nz (8.9.2/8.9.2/8.9.2-ua) with ESMTP id JAA16719
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2001 09:39:59 +1200 (NZST)
Date: Wed, 30 May 2001 09:39:59 +1200
From: Colin Coghill <C.Coghill@auckland.ac.nz>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: SELinux on a Workstation Reprise
Message-ID: <20010530093959.A16433@gromit.ele.auckland.ac.nz>
References: <Pine.LNX.4.30.0105291349590.18681-100000@linux42.zdv.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0105291349590.18681-100000@linux42.zdv.uni-tuebingen.de>; from jan.petranek@student.uni-tuebingen.de on Tue, May 29, 2001 at 01:53:28PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 29, 2001 at 01:53:28PM +0200, Jan Petranek wrote:
> Hello out there,
> 
> the discussion about the topic was quite fruitful to me, so I decided on
> installing SELinux on my desktop and to trying to find a suitable policy.
> 
> So... has anyone actually _done_ this before?

I'm intending on embarking on a project like this in a few weeks.

It's hopefully for credit towards my Masters so I'm not terribly
sure if I can collaborate *too* much though (at least until that
part is done). If I don't get it accepted then I'll do it anyway 
on my free time and would be keen to work with others. :)

On a seperate note, one thing I'm thinking of setting up (on 
one of my unused web sites) is an online database of applications 
and the permissions they require to function. Not SELinux specific,
but I would hope this would be very useful to many security projects.

For example, an entry for (UNIX) Netscape might list all the 
configuration files it needs read/write access to, all the
system libraries it needs read access, all the helper applications
it wants to execute, the network ports it needs, and a 
suggested set of places it can write downloaded files to.

This'd contain similar information to an SELinux policy file, 
but hopefully be a lot more human readable and with lots of room
for comments and suggestions. The idea would be to give people
creating secure systems a source for generating their policy
files from.

Is there something like this already out there?

Would something like this be a useful online resource?

- Colin
--
Colin Coghill
Senior Tutor,
Dept. of Electrical and Electronic Engineering,
The University of Auckland,
New Zealand.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
