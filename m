Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OMBorT021205
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 18:11:50 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OMBmrq009847
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 22:11:49 GMT
Date: Fri, 24 Sep 2004 23:22:53 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Daniel J Walsh <dwalsh@redhat.com>, jwcart2@epoch.ncsc.mil,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Remove unrestricted_admin
Message-ID: <20040924222253.GB15746@lkcl.net>
References: <200409211526.37810.russell@coker.com.au> <200409250427.49189.russell@coker.com.au> <1096052356.9895.25.camel@selinux> <200409250513.29870.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409250513.29870.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 25, 2004 at 05:13:29AM +1000, Russell Coker wrote:
> On Sat, 25 Sep 2004 04:59, "Christopher J. PeBenito" <cpebenito@tresys.com> 
> wrote:
> > > > Why would you need to directly access the disk as sysadm_t?  All the
> > > > applicable tools should be transitioning to fsadm_t.
> > >
> > > dd if=/dev/hda of=/dev/hdb
> > >
> > > file -s /dev/hda
> > >
> > > Using an LVM snapshot to backup a disk onto a DVD.
> >
> > Yes these are reasons; however, this is supposed to be the strict
> > policy, and these are not compelling enough to loosen the policy this
> > way, in my opinion.
> 
> How do you suggest that we address those needs then?
 
 write a small program that does the job, add it to fsadm_t?
 [or is that too obvious an answer]

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
