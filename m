Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6932ugA027374
	for <selinux@tycho.nsa.gov>; Fri, 8 Jul 2005 23:02:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6930QGt022823
	for <selinux@tycho.nsa.gov>; Sat, 9 Jul 2005 03:00:27 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9A48961B05
	for <selinux@tycho.nsa.gov>; Sat,  9 Jul 2005 13:00:11 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13190-10 for <selinux@tycho.nsa.gov>;
	Sat, 9 Jul 2005 13:00:11 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2451861B02
	for <selinux@tycho.nsa.gov>; Sat,  9 Jul 2005 13:00:11 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: crond_t
Date: Sat, 9 Jul 2005 13:00:03 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200507090004.57794.russell@coker.com.au> <42CE8CCF.6000508@redhat.com>
In-Reply-To: <42CE8CCF.6000508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507091300.07806.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 09 July 2005 00:25, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> >It seems that the domain crond_t needs the attribute privfd.  The number
> > of things that are run from cron jobs demands it.  A user of the rawhide
> > policy reported a problem running ping from a cron job on IRC.
>
> crond_t has privfd.

In which version?  selinux-policy-targeted-sources-1.24-3 doesn't have it.

> Are you talking about system_crond_t and friends?

No, the domain_auto_trans() rules from those domains give the fd use rules 
that are needed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
