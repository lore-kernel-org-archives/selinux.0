Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2E58nRb008094
	for <selinux@tycho.nsa.gov>; Sun, 14 Mar 2004 00:08:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2E58c0F017145
	for <selinux@tycho.nsa.gov>; Sun, 14 Mar 2004 05:08:38 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i2E58agZ017116 for <selinux@tycho.nsa.gov>; Sun, 14 Mar 2004 05:08:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bill McCarty <bmccarty@pt-net.net>
Subject: Re: grsecurity / LSM issue
Date: Sun, 14 Mar 2004 16:07:07 +1100
Cc: selinux@tycho.nsa.gov
References: <20040308043522.GA4760@coker.com.au> <404EE624.7010901@hotmail.com> <5343153.1079084709@[192.168.0.2]>
In-Reply-To: <5343153.1079084709@[192.168.0.2]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403141607.07383.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 13 Mar 2004 04:45, Bill McCarty <bmccarty@pt-net.net> wrote:
> <jtl2nospamMUNGIEjump@hotmail.com> wrote:
> > Would it be possible to make a snapshot clone of the disk and make that
> > available to people experienced with forensics? I was thinking of the
> > honeypot/net project folks and the competition to analyse a rooted system
> > a
> > few years back.
>
> I'm the director of a Honeynet Alliance project and work with the Honeynet
> Project, having been the lead on Scan of the Month #27. If Russell wants to
> pursue the possibility of using his data as the basic for a Honeynet
> Project Forensic Challenge, I'd be happy to make the proper introductions.
> Seeing his SELinux machine as a honeypot might be pushing the envelope a
> bit; but doing so makes sense to me.

As I mentioned in a previous message, I am not convinced that there was a 
crack of the machine.  It was claimed that stealth cracked it, but stealth 
denies having done that or anything remotely similar.  It was claimed that 
the machine was cracked some months ago, if so the attacker would have had to 
maintain their root-kit past upgrades of SE Linux policy, kernel, and OS 
packages.  It is possible that the machine was cracked and then the attacker 
left it without causing any harm.

I would be happy to give you a copy of the file system, if you are interested 
then please contact me off-list.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
