Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA13747
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 21:08:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA27273
	for <selinux@tycho.nsa.gov>; Sun, 13 May 2001 01:08:00 GMT
Received: from mail.lemuria.org (lemuria.org [62.197.4.65])
	by jazzband.ncsc.mil  with ESMTP id BAA27269
	for <selinux@tycho.nsa.gov>; Sun, 13 May 2001 01:07:59 GMT
Date: Sun, 13 May 2001 03:03:48 +0200
From: Tom <tom@lemuria.org>
To: Will Dye <willdye@dsndata.com>
Cc: Bede McCall <bede@mitre.org>, selinux@tycho.nsa.gov
Subject: Re: SELinux as a desktop / workstation?
Message-ID: <20010513030347.C9636@lemuria.org>
References: <200105120051.UAA25152@idiot-savant.mitre.org> <m14ygd1-000098C@zuul.dsndata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m14ygd1-000098C@zuul.dsndata.com>; from willdye@dsndata.com on Sat, May 12, 2001 at 04:08:42PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, May 12, 2001 at 04:08:42PM -0500, Will Dye wrote:
> Extending the idea further, what if we had very smart clients, 
> but processing (that is of interest to the server) may only run 
> on a *virtual* machine.  The virtual machine mostly runs on the 
> local client, but the integrity of the VM is cryptographically 
> authenticated by the server before its output is approved.  In 
> this scenario, the "dumb client" is a virtual machine, which 
> runs on any of a variety of platforms -- even an ordinary PC 
> somewhere on the Internet.  

a simple form of this is done in almost all multiplayer online games
(mostly to prevent cheating). the experience there is that it doesn't
work.



> Besides, if you try to improve security by having only a 
> restricted class of machines on your network, you eventually 
> still have to set up a scheme to prove that the "dumb client" 
> at a certain location isn't really Mallory's PC in disguise.
> Thus, it seems like you'll have to make a VM model at some 
> point or another anyway, and use that model to try to validate 
> that the client hasn't been modified.  

I have serious doubts that this will *ever* work. as long as the user
can theoretically access data that he shouldn't, he'll find a way to
actually do it.

the VM part has actually been used a while ago, and was even called
that - VMS. thin clients all over again, in VMS they just processed
user input and server output and ALL actual computations were done on
the server machine.


> The PC can run whatever junk the user wants, including Outlook 
> viruses and who-knows-what.  Processing that is of interest to 
> the server, however, has to run on a VM.  

and the VM will be hacked, reverse-engineered and pried wide open.
people do it in order to get better scores at GAMES. I'm fairly
pessimistic at their potential when it's about serious data instead.


a good general security model should - IMHO - work very much like a
good program: don't make assumptions and don't take shortcuts. you
can't assume the VM is what it should be once it left your hands. you
can't assume the line is clear or your crypto layer has not been broken
(the german u-boot command assumed that enigma was unbreakable - it may 
have been the deciding factor on the sea theatre).


-- 
-- http://web.lemuria.org
--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
