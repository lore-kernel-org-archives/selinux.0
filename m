Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PAdCrT023144
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 06:39:12 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PAc9sn025459
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 10:38:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Remove unrestricted_admin
Date: Sat, 25 Sep 2004 20:39:01 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <200409211526.37810.russell@coker.com.au> <200409250513.29870.russell@coker.com.au> <20040924222253.GB15746@lkcl.net>
In-Reply-To: <20040924222253.GB15746@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409252039.01196.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Sep 2004 08:22, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > > dd if=/dev/hda of=/dev/hdb
> > > >
> > > > file -s /dev/hda
> > > >
> > > > Using an LVM snapshot to backup a disk onto a DVD.
> > >
> > > Yes these are reasons; however, this is supposed to be the strict
> > > policy, and these are not compelling enough to loosen the policy this
> > > way, in my opinion.
> >
> > How do you suggest that we address those needs then?
>
>  write a small program that does the job, add it to fsadm_t?
>  [or is that too obvious an answer]

So you are saying we should write special programs to copy block devices to 
other block devices, to/from DVD, copying raw partition tables, and all the 
other things that administrators usually do?  I don't think that is viable.

One possibility is to run things in fsadm_t, this means that fsadm_t needs a 
heap of extra access which probably isn't desired.

Another possibility is to have multiple domains in the sysadm_r role, only one 
of which has such privs and then have the administrator use runcon to perform 
such tasks.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
