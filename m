Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j96M73Ns022556
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2005 18:07:03 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j96M6SUc025156
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2005 22:06:28 GMT
Date: Thu, 6 Oct 2005 23:05:23 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Gaurav Poothia <gpoothia@cs.sunysb.edu>, SELinux@tycho.nsa.gov
Subject: Re: Newbie questions
Message-ID: <20051006220523.GD10538@lkcl.net>
References: <Pine.GSO.4.53.0510061416520.10856@compserv1> <4345915C.7050305@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4345915C.7050305@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 06, 2005 at 05:04:28PM -0400, Ivan Gyurdiev wrote:
> 
> >Q1. Is the idea here for SELinux to create specialized domains for all
> >possible desktop apps (on the server side it seems the plan is to
> >eventually confine all daemons)?
> I think that's what the plan is/was...whether this is actually possible 
> remains to be discovered. Desktop apps are very difficult to deal with, 
> since they tend to be highly complex, and interact in complicated ways.

 one of those complexities is well illustrated by KDE's
 favourite game: doing an optimisation job which should
 otherwise really be done by the kernel, the compiler or
 the linker.

 for example, prior to the existence of prelink, a tool for prelinking
 dynamically linked libraries and preallocating fixed locations right
 across the board of all .sos and their references in all programs that
 use them - yes it takes about an hour to run prelink on a desktop
 system - the kde team came up with "kdeinit".

 kdeinit is a program that preloads virtually every component of the kde
 system instead of as independent executables as .so libraries.

 then, instead of exec()ing new programs, a fork() is performed instead
 and the alternative .so called.  so, you run kdesktop - actually it's
 kdeinit loading the kde_kdesktop.so - and that runs the kde start menu
 program - and actually it's kdeinit loading the kde_kstartmenu.so.

 the fork()ed process has all of the previously called dynamically
 allocated library functions already sorted.

 
 a similar thing was done with the networking: one program, the kde io
 handler, will fork() and maintain a cache of outgoing connections,
 whereby you will be presented with access to those network connections
 via the kde io handler, which performs proxying on your behalf via unix
 domain sockets.

 the idea is to have the kde io handler "cache" connections
 such as authenticated IMAP, POP3, SSL connections, HTTP
 connections which required a password - that sort of thing.

 fortunately, the KDE team saw fit to do away with both these things if
 you set some environment variables, one of which is only active in KDE
 3.4 and above.

 export KDE_IS_PRELINKED="1" will stop the kdeinit silliness and

 export KDE_EXECS_SLAVES="1" will stop the io slave silliness.

 i pointed out to the kde development team that their cacheing
 of network connections presents quite a serious security risk,
 namely that any one program (e.g. irc) could be compromised
 and end up hacking in to _all_ outgoing network connections.

 they were quite good about it and did actually acknowledge that there
 was a potential problem.

 i don't know if anything came of my pointing it out, though.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
