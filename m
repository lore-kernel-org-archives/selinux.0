Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OJDZrT020047
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 15:13:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OJCXxO008306
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 19:12:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Remove unrestricted_admin
Date: Sat, 25 Sep 2004 05:13:29 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, jwcart2@epoch.ncsc.mil,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <200409211526.37810.russell@coker.com.au> <200409250427.49189.russell@coker.com.au> <1096052356.9895.25.camel@selinux>
In-Reply-To: <1096052356.9895.25.camel@selinux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409250513.29870.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Sep 2004 04:59, "Christopher J. PeBenito" <cpebenito@tresys.com> 
wrote:
> > > Why would you need to directly access the disk as sysadm_t?  All the
> > > applicable tools should be transitioning to fsadm_t.
> >
> > dd if=/dev/hda of=/dev/hdb
> >
> > file -s /dev/hda
> >
> > Using an LVM snapshot to backup a disk onto a DVD.
>
> Yes these are reasons; however, this is supposed to be the strict
> policy, and these are not compelling enough to loosen the policy this
> way, in my opinion.

How do you suggest that we address those needs then?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
