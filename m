Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA26093
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 13:33:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA04815
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 17:33:21 GMT
Received: from sparcy.internal.lan (sparcy.atari-source.com [66.92.233.10])
	by jazzswing.ncsc.mil  with ESMTP id RAA04807
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 17:33:20 GMT
Date: Mon, 17 Jun 2002 13:26:36 -0400 (EDT)
From: Noah silva <nsilva@atari-source.com>
To: "Betz, John" <john.betz@pec.com>
cc: selinux@tycho.nsa.gov
Subject: Re: General Linux Help Needed
In-Reply-To: <3EF5A4B95135C549B761B73B290142944ACEBD@ffx-exchng1>
Message-ID: <Pine.LNX.4.21.0206171320410.19303-100000@sparcy.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Mon, 17 Jun 2002, Betz, John wrote:

>  I was hoping I could get some help on the following general topics related
> to Linux. I believe the questions are not version specific, but if so,
> please indicate. In my case this applies to Red Hat Advanced Server (Linux
> version 7+).

first of all:  I don't care, but other people will kill you for saying
"Linux version 7".  The 'proper' thing to say is "Redhat v7", as the linux
version is the kernal version, which is probably something like 2.4.17 in
your case.
 
> If this is inappropriate, I apologize -- a pointer to the appropriate source
> of info would be appreciated.

I don'tthink it's inappropriate since it's a linux group...
 
> Support For ISVs:
> 1) What are major ISVs doing in terms of providing support for their
> products on Red Hat?
> 2) Specific products: HP OpenView, Oracle, Sybase, CA Unicenter?

Definatly Oracle.
 
> Platform Support:
> 3) Support for specific protocols on Red Hat: ATM, Gigabit, PCI-based T1
> support in multi-channel generation 
> 4) Support for specific components on Red Hat: disk arrays, dual controllers

Most of that is supported.  Disk arrays for sure.  This sort of thing
depends on the kernal and is therefore mostly the same across distros.
 
> Tuning:
> 5) Ability to tune/configure the Red Hat kernel to support peripherals,
> number of processes, etc. compared to Solaris or HP-UX

I don't think it can go quite as far as solaris.  Solaris still kills
linux for SMP.  HP-UX.. no experience with it.

> 6) Ability or suitability to run in a multi-box headless (no monitor)
> configuration

This works fine and I do it. ;)
 
> Troubleshooting Tools:
> 7) Tools for analyzing problems with the O/S, particularly in a headless
> environment

There are many such things, probably too many (f.e. Netsaint?).  You can
always telnet or SSH in and look at whatever you like. (unless it's really
broken!).  You can use a serial console when the network is broken.
 
> High Availability/Data Loss Protection:
> 8) Ability to support redundant NIC cards, or operate with automatic
> failover software

not so much experience here.

> 9) Ability to support disk mirroring

This works, but the best disk mirroring is done in HW, so the OS wouldn't
know.

> 10) How often does the O/S need to be recycled/rebooted

he hehe.... once every few years? maybe...  I normally don't reboot my
machines unless I change hardware that makes me turn it off.

> 11) Any data loss protections?

backups, ext3/jfs/reiserfs (well that's more corruption protection).

> Any info on these topics is appreciated. Thank you.
> 
hope that was at least somewhat useful?  Perhaps someone else can fill in
the blanks I left.

 -- noah silva 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
