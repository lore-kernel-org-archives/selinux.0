Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA29190
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2001 14:41:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA04022
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2001 18:40:53 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id SAA04018
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2001 18:40:48 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152413F@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Colin Coghill'" <C.Coghill@auckland.ac.nz>,
        NSA Selinux Mailinglist
	 <selinux@tycho.nsa.gov>
Subject: RE: SELinux on a Workstation Reprise
Date: Wed, 30 May 2001 13:41:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am using it now on my desktop.
I will clean up my policy files and send them to you.
Also I use gdm as my session manager. I have made the required
changes to the GDM source for selinux. It is part of the 
cvs tree for selinux at www.sourceforge.net/project/selinux

Mark

-----Original Message-----
From: Colin Coghill [mailto:C.Coghill@auckland.ac.nz]
Sent: Tuesday, May 29, 2001 4:40 PM
To: NSA Selinux Mailinglist
Subject: Re: SELinux on a Workstation Reprise


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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
