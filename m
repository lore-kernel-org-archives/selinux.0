Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27204
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 11:36:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA05373
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 15:34:14 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id PAA05367
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 15:34:13 GMT
Date: Tue, 23 Apr 2002 17:36:12 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
Message-ID: <20020423173612.A5381@lemuria.org>
References: <Pine.GSO.4.33.0204221825010.5657-100000@raven> <20020423115519.83E491916@lyta.coker.com.au> <20020423142051.A24878@lemuria.org> <20020423124406.E6870B1A@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020423124406.E6870B1A@lyta.coker.com.au>; from russell@coker.com.au on Tue, Apr 23, 2002 at 02:44:06PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 23, 2002 at 02:44:06PM +0200, Russell Coker wrote:
> Simple, if you don't have a password then anyone can enter
> "linux init=/bin/bash" at the lilo prompt and take over the machine entirely!

dumb me. I thought disabling the prompt (as you would do in a cafe or
university) takes care of that. A quick glance into the lilo doc shows
that it doesn't.


> No.  To boot with the default parameters you don't need a password.  You only 
> need a password for maintenance mode.

right again.


> > No security-aware hosting center will let run people around
> > unsupervised unless every customer has a steel-cage of his own.
> 
> There aren't many security aware hosting centers.

then why spend much time on securing the system when any dumbass can
just walk in and take control of it? most servers have easy access to
stuff like hard disks. on a system you care about, you'll almost always
run raid, so your evil neighbour may even be able to steal/swap a drive
without you ever noticing, then take home his "copy" and do with it
whatever he wants (like building up an almost identical system and
swapping that in next time he's over).


> > I agree. The point was that lilo.conf may or may not be especially
> > sensitive, depending on the setup. It may be, but similiar points may
> > be made for many other files (/etc/ppp/*.secrets, snmp config files,
> > quite a lot of things actually).
> 
> So we provide a different type for it and let the users decide who gets 
> access to that type.

the point I was trying to make is whether we really want to provide
different types for almost everything inside /etc. if the answer is
yes, I'll shut up, just wanted to point out that lilo won't be the last
program to warrant that kind of attention.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
