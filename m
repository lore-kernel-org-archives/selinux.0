Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA13474
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 17:08:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA21567
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 21:08:54 GMT
Received: from zuul.dsndata.com (zuul.dsndata.com [198.183.3.2])
	by jazzband.ncsc.mil  with SMTP id VAA21563
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 21:08:50 GMT
Received: from dsndata.com(localhost[127.0.0.1]) (3329 bytes) by zuul.dsndata.com
	via sendmail with P:esmtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <willdye@dsndata.com>)
	id <m14ygd1-000098C@zuul.dsndata.com>
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 16:08:43 -0500 (CDT)
	(Smail-3.2.0.102 1998-Aug-2 #1 built 1998-Nov-18)
Message-Id: <m14ygd1-000098C@zuul.dsndata.com>
Reply-To: willdye@dsndata.com
To: bede@mitre.org (Bede McCall)
Subject: Re: SELinux as a desktop / workstation? 
In-reply-to: Your message of "Fri, 11 May 2001 20:51:10 EDT."
         <200105120051.UAA25152@idiot-savant.mitre.org>
Cc: selinux@tycho.nsa.gov
Date: Sat, 12 May 2001 16:08:42 -0500
From: Will Dye <willdye@dsndata.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Another possibility: give all the clients as much data and 
applications as you can fit in them, but keep it all encrypted 
and/or slightly incomplete.  Decryption keys and/or the missing 
pieces of critical information are available only from the 
servers.  

Extending the idea further, what if we had very smart clients, 
but processing (that is of interest to the server) may only run 
on a *virtual* machine.  The virtual machine mostly runs on the 
local client, but the integrity of the VM is cryptographically 
authenticated by the server before its output is approved.  In 
this scenario, the "dumb client" is a virtual machine, which 
runs on any of a variety of platforms -- even an ordinary PC 
somewhere on the Internet.  

The trick, of course is setting up a VM architecture that is 
both mathematically-sound and runs in a reasonable amount of 
time.  There are proofs that you can do generic computation 
in a distributed-yet-cryptographically-secure manner, but the 
problem is that you have to send a bunch of network packets 
just to get a single cycle on the VM.  Hmm.

Still, the idea has appeal.  When writing programs, we usually 
wind up making some kind of a VM model anyway -- even if it's 
only in the form of bogus assumptions by us coders.  :-)  

Besides, if you try to improve security by having only a 
restricted class of machines on your network, you eventually 
still have to set up a scheme to prove that the "dumb client" 
at a certain location isn't really Mallory's PC in disguise.
Thus, it seems like you'll have to make a VM model at some 
point or another anyway, and use that model to try to validate 
that the client hasn't been modified.  

In other words, you'll probably have to do the VM work anyway, 
including the part about having the server try to verify that 
the client is running according to specs.  If you have to go 
through all that, 'might as well make the client a VM, which 
you can then port to different platforms -- including a PC.  

The PC can run whatever junk the user wants, including Outlook 
viruses and who-knows-what.  Processing that is of interest to 
the server, however, has to run on a VM.  The PC can store as 
much as it likes locally, but nothing is decrypted until the 
server gives the OK, processing itself is kept scrambled, and 
the results have to be examined by the server in some form 
(hashes or whatever) before the key is sent that decrypts and 
presents the final answers.  

Just thinking out loud,


--Will

 _____________________________________________________________________
 William Dye, Interim Chief Executive Cat-Herder, the Tweakdom Project
 Open-source tweaks to "Freedom", an Internet privacy software system.
 http://tweakdom.sourceforge.net   No relation Zero-Knowledge Systems.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
