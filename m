Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PDUPrT023517
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 09:30:25 -0400 (EDT)
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PDUOAk020701
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 13:30:24 GMT
Subject: Re: Remove unrestricted_admin
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Russell Coker <russell@coker.com.au>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409252039.01196.russell@coker.com.au>
References: <200409211526.37810.russell@coker.com.au>
	 <200409250513.29870.russell@coker.com.au> <20040924222253.GB15746@lkcl.net>
	 <200409252039.01196.russell@coker.com.au>
Content-Type: text/plain
Date: Sat, 25 Sep 2004 09:30:05 -0400
Message-Id: <1096119005.11665.21.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-09-25 at 20:39 +1000, Russell Coker wrote:
> On Sat, 25 Sep 2004 08:22, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > > > dd if=/dev/hda of=/dev/hdb
> > > > >
> > > > > file -s /dev/hda
> > > > >
> > > > > Using an LVM snapshot to backup a disk onto a DVD.
> > > >
> > > > Yes these are reasons; however, this is supposed to be the strict
> > > > policy, and these are not compelling enough to loosen the policy this
> > > > way, in my opinion.
> > >
> > > How do you suggest that we address those needs then?
> >
> >  write a small program that does the job, add it to fsadm_t?
> >  [or is that too obvious an answer]
> 
> So you are saying we should write special programs to copy block devices to 
> other block devices, to/from DVD, copying raw partition tables, and all the 
> other things that administrators usually do?  I don't think that is viable.

I still believe that the first two are more like corner cases.  I see it
much more likely that an admin would be using a regular backup solution
with tapes and autoloaders (bigger systems) and the like for backups
with tools seem to be fit for backup_t or similar domain.

I believe that the corner cases should be left broken, as it loosens the
strict policy too much.

> One possibility is to run things in fsadm_t, this means that fsadm_t needs a 
> heap of extra access which probably isn't desired.

Since I'm not familiar with LVM, I'm curious as to why doing a snapshot
doesn't fit into a domain of its own or fsadm_t.

> Another possibility is to have multiple domains in the sysadm_r role, only one 
> of which has such privs and then have the administrator use runcon to perform 
> such tasks.

Well we'd probably want the binaries to be specifically labeled to
control the entrypoint, but if we do that, then domain_auto_trans() will
work.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
