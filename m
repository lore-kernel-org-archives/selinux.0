Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TE5NrT018988
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 10:05:23 -0400 (EDT)
Received: from smtp810.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TE5MCb005940
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 14:05:22 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp810.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 14:05:22 -0000
Date: Thu, 29 Jul 2004 15:16:28 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Dale Amon <amon@vnl.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pear-shaped behaviour after enough make reloads
Message-ID: <20040729141628.GF8858@lkcl.net>
References: <20040728211229.GB18711@lkcl.net> <20040728225322.GE18711@lkcl.net> <20040729104317.GE24051@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040729104317.GE24051@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 11:43:17AM +0100, Dale Amon wrote:
> On Wed, Jul 28, 2004 at 11:53:22PM +0100, Luke Kenneth Casson Leighton wrote:
> >  i had to kill off processes manually one by one, umount the partitions
> >  manually, poweroff, and i chose to boot with enforcing=0 init 1 in
> >  order to safely run ldconfig and make relabel.
> > 
> >  i find this all a bit odd, i haven't a clue what's causing it.
> 
> Is this particular machine and kernel presently stable 
> when running the same kernel and no selinux? 

 as a general rule, yes: i have used it to watch tv and dvds...

 now that you mention it, the hard drive _did_ have a head-crash
 last week when i was doing a 4.3gbyte disk-image...


> I have
> seen very strange things happen over the years when
> hardware is failing or marginal, power supply voltages
> are on the edge... 

 yes, so have i, but having bought eight identical cheap-and-nasty
 machines ($125ea) where one of the PSUs blew so loud it took out its
 internal fuse, the plug fuse, the 4-way-block fuse _and_ the
 mains trip, i didn't want to admit that anything was wrong.

> Worth checking before you ruin Stephen Smalley's sleep 
> and fill it with nightmares of kernel race conditions
> and random byte squashers. :-)
 
 *lol*.

 oh, okay then, i'll try running it without selinux for a while,
 see what happens.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
