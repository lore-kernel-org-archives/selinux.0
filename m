Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA27855
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 12:50:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA09884
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 16:48:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA09869
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 16:48:52 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
Date: Tue, 23 Apr 2002 18:50:27 +0200
References: <Pine.GSO.4.33.0204221825010.5657-100000@raven> <20020423124406.E6870B1A@lyta.coker.com.au> <20020423173612.A5381@lemuria.org>
In-Reply-To: <20020423173612.A5381@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020423165027.470E93A16E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Apr 2002 17:36, Tom wrote:
> On Tue, Apr 23, 2002 at 02:44:06PM +0200, Russell Coker wrote:
> > Simple, if you don't have a password then anyone can enter
> > "linux init=/bin/bash" at the lilo prompt and take over the machine
> > entirely!
>
> dumb me. I thought disabling the prompt (as you would do in a cafe or
> university) takes care of that. A quick glance into the lilo doc shows
> that it doesn't.

Also you definately don't want to totally disable it.  You want to allow 
authorised people to perform maintenance on the machines without taking them 
apart (with machines that have no other boot device than a hard drive it's 
mandatory to allow "linux init=/bin/bash" for emergencies).

> > > No security-aware hosting center will let run people around
> > > unsupervised unless every customer has a steel-cage of his own.
> >
> > There aren't many security aware hosting centers.
>
> then why spend much time on securing the system when any dumbass can
> just walk in and take control of it? most servers have easy access to
> stuff like hard disks. on a system you care about, you'll almost always
> run raid, so your evil neighbour may even be able to steal/swap a drive
> without you ever noticing, then take home his "copy" and do with it
> whatever he wants (like building up an almost identical system and
> swapping that in next time he's over).

1)  You do the best you can.

2)  Walking into a hosting center with a set of lock picks and a fake ID 
takes more guts than most attackers have.

3)  Not all hosting environments are insecure.

> > > I agree. The point was that lilo.conf may or may not be especially
> > > sensitive, depending on the setup. It may be, but similiar points may
> > > be made for many other files (/etc/ppp/*.secrets, snmp config files,
> > > quite a lot of things actually).
> >
> > So we provide a different type for it and let the users decide who gets
> > access to that type.
>
> the point I was trying to make is whether we really want to provide
> different types for almost everything inside /etc. if the answer is
> yes, I'll shut up, just wanted to point out that lilo won't be the last
> program to warrant that kind of attention.

Actually there's many things that are currently in different types which 
don't need it IMHO.  Such as resolv.conf.  Probably most daemon config files 
could be etc_t except where the daemon re-writes it's own config.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
