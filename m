Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OFp4rT027860
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:51:04 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OFp2CV008186
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:51:02 GMT
Date: Tue, 24 Aug 2004 15:58:45 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Message-ID: <20040824145845.GH4698@lkcl.net>
References: <20040823214228.GA13677@lkcl.net> <20040824002244.GA25356@lkcl.net> <1093345601.1800.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093345601.1800.5.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 07:06:41AM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-23 at 20:22, Luke Kenneth Casson Leighton wrote:
> > my apologies for the length of the patch which i had not correctly
> > observed: the /.?u?dev is there to deal with /.dev which on debian
> > linux with udev is the "real" /dev remounted (--bind?) to a different
> > point.
> 
> fixfiles and make relabel exclude bind mounts from the relabeling.  So
> if it is a bind mount, it shouldn't get relabeled anyway.
 
 it was.  this is with a 2.6.7 kernel.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
