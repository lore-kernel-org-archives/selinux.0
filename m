Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n62FJCqx032340
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 11:19:12 -0400
Received: from pobox.globalherald.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n62FIuAi005527
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 15:18:56 GMT
Date: Thu, 2 Jul 2009 12:26:25 -0400 (EDT)
From: Joshua Kramer <josh@globalherald.net>
To: Dominick Grift <domg472@gmail.com>
cc: selinux@tycho.nsa.gov
Subject: Re: request for review of, and collaboration on SELinux models wiki
 entry
In-Reply-To: <1246546486.26320.30.camel@notebook2.grift.internal>
Message-ID: <alpine.LFD.2.00.0907021220590.25405@home-av-server.home-av>
References: <1246542053.26320.15.camel@notebook2.grift.internal>  <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil> <1246546486.26320.30.camel@notebook2.grift.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> - Security contexts are assigned to more than just processes and files.
> You and i know that but for a common user i think just separation of
> files and processes should suffice.
> When all is said and done a Linux system is just a bunch of files

Note that I'm putting together a similar tutorial on Userspace Object 
Managers [1].  There are applications - DBus, SE-PGSQL - that use SELinux 
contexts on arbitrary objects in the program itself, for example, database 
columns.  These objects are not necessarily files, but instead they are 
in-memory data structures.

I'm going way out there and modelling the behavior of a dog pack - sled 
dogs actually - using SELinux contexts.  I'll forward to the group for 
review when it's done.

Cheers,
-JK

-----
http://www.globalherald.net/jb01
GlobalHerald.NET, the Smarter Social Network! (tm)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
