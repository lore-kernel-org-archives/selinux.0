Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OFOorT018139
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 11:24:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OFNmxO021118
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 15:23:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dax Kelson <dax@gurulabs.com>
Subject: Re: SELinux policy discussion.
Date: Sat, 25 Sep 2004 01:24:30 +1000
Cc: Valdis.Kletnieks@vt.edu, ivg2@cornell.edu,
   Colin Walters <walters@redhat.com>, selinux@tycho.nsa.gov
References: <4148A003.6080309@redhat.com> <200409171719.i8HHJ1tP020778@turing-police.cc.vt.edu> <1095551424.4016.9.camel@mentorng.gurulabs.com>
In-Reply-To: <1095551424.4016.9.camel@mentorng.gurulabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409250124.30759.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 19 Sep 2004 09:50, Dax Kelson <dax@gurulabs.com> wrote:
> > You'll sing a different tune if some hostile Javascript saves a .rhosts
> > in your home directory (or any other file that will produce surprising
> > results).
>
> Your point is valid, but the example is a bit dated.
>
> On any Linux distro made in the past 2-3 years, and certainly all the
> 2.6 kernel based distros, creating a .rhosts or /etc/hosts.equiv file
> will have zero effect.

So you do the same with ~/.ssh/authorized_keys .

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
