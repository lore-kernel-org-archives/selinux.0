Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h483uoI4014793
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 23:56:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h483uZVf017473
	for <selinux@tycho.nsa.gov>; Thu, 8 May 2003 03:56:35 GMT
Received: from windowpane.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by jazzswing.ncsc.mil  with ESMTP id h483uU4D017464
	for <selinux@tycho.nsa.gov>; Thu, 8 May 2003 03:56:31 GMT
Message-ID: <021f01c31516$43cf0390$398314d1@windowpane.com>
From: "ccallen" <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
Subject: Fw: SELinux and LFS
Date: Wed, 7 May 2003 20:59:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Scratch the request for the use of the dat drive, cant find the tape. I have
some windows based utilities that can incorporate some of yard's features.

Conan

----- Original Message -----
From: "ccallen" <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
Cc: <nagray@austin.rr.com>
Sent: Wednesday, May 07, 2003 2:01 PM
Subject: Re: SELinux and LFS


I have been working on the same kind of thing and wanted to ask the same
question. My goal has been to create a minimal dist (like the linux router
project) that has just whats needed (http & smtp for now), and boots from a
cd (like a rescue / boot disk). If my system does get hacked or out of wack,
It can just be rebooted. Selinux would be used to protect the system in
memory (on a ram disk), and protect any working files on disk (logs,
databases, etc).

For a gui I want to use motif. The gui is not for a production dist but for
configuring and building the dist. However it could be on the production
machine (ran from the hard drive, not on a ram disk). I built some motif
configuration management tools that would work for this project. Although I
have them on an HP DAT tape and dont have a tape drive, so I cant read the
data :( Is there anyone in the Bellevue / Redmond area who has one of these
drives I could use to read the source code off with?

I started with the boot disk howto and Linux Router Project, and eventually
stumbled across the LFS project. The LFS looks to have a bunch of LFS
specific unix utilities, I wasnt sure if they would be compatible with
selinux. All I wanted was a list of esential files and steps to build and
configure a minimal linux system. Then I could pull these files from redhat
so it would be compatible with selinux.

The author of the boot-disk how created a tool, Yard, that looks like it
does what I have in mind. http://www.croftj.net/~fawcett/yard/index.html
I decided to start with yard and build on that.

There are many other boot disk tools like yard,  but Yard looks like it's as
good as any. If your interested I can track down some of the links I came
across.

Conan


----- Original Message -----
From: "Nick Gray" <nagray@austin.rr.com>
To: <selinux@tycho.nsa.gov>
Sent: Wednesday, May 07, 2003 9:02 AM
Subject: SELinux and LFS


All,

I introduced myself several months back. I work on a MLS project for the
ONI. We have been evaluating SELinux for awhile. A couple of months ago
I raise a question, within our group, about the viability of using
RedHat as a base for a secure system. I believe that certification of a
system based on a (almost any) distribution would be rather difficult to
achieve. This coupled with the fact that a Redhat server that was under
scrutiny here at the lab, continued to contact Redhat via HTTPS despite
my efforts to remove the software responsible. I actually found circular
dependencies in the packages.

This led me to the question, Does anyone remember when we used to build
this things from scratch. In answer to that question, I found a web site
which I have been playing with for the last couple of weeks called
appropriately enough "Linux from Scratch" so far I have been able to use
LFS as the starting point for a CDROM based Linux gateway/firewall.I
started a build of SELinux on a LFS system, but had several problems
including discovering what I believe are a couple bugs in the code.I
have put it aside for the moment to work on a couple of other things,
but I will return to this when I get the chance.

I am interested in whether anyone on the list has used this as the
starting point for SELinux and what the results where.

In the next day or so I will post the problem I found in the makefile.
Perhaps it is either a known issue or doesn't come up on Redhat based
systems. In a separate post I will address a problem I found in string.h
(as soon as I get a chance to figure out what the problem is)

Don't get me wrong, I have nothing against Redhat. I'm just not sure
that I could keep a straight face when placing this in front of the
accreditors.

Any comments/discussion would be appreciated

Nick Gray
Senior Network Engineer
Bruzenak Inc.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
