Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA05208
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 06:47:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA06128
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 11:44:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA06124
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 11:44:45 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: expect
Date: Tue, 3 Dec 2002 12:46:40 +0100
References: <200211292002.PAA23890@moss-shockers.ncsc.mil> <200212022040.26257.russell@coker.com.au> <20021202230046.A8632@lemuria.org>
In-Reply-To: <20021202230046.A8632@lemuria.org>
MIME-Version: 1.0
Message-Id: <200212031246.40414.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Dec 2002 23:00, Tom wrote:
> Actually, it's more a problem of "do I really want Tk on this machine,
> just so that I can run SELinx?" - it is a considerably extension of the
> dependencies. Maybe I'm too old-school, but I cringe everything I
> select a simple packet and it wants to install two dozen libraries and
> programming languages in dependencies.

Good point, I've just checked it out, on Debian this involves 3.1M of disk 
space for Expect and TK.  It hadn't been an issue for me as I already had 
other packages depending on TK on all my machines.

Maybe I'll have to go back to writeing such a program in C...

> Or maybe that attitude is not for the SELinux world anymore. With a
> regular system, the less stuff you have on it the more secure you can
> feel (less possibilities for problems). On an SELinux machine, though,
> that isn't (or at least shouldn't) be true anymore.

I don't think that having expect present causes any security problems anyway.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
