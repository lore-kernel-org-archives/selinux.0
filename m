Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TAhLrT017487
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 06:43:21 -0400 (EDT)
Received: from crisium.vnl.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TAhJCb000247
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 10:43:20 GMT
Received: from amon by crisium.vnl.com with local (Exim 4.32 #1 (Debian))
	id 1Bq8NZ-0006eK-NX
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 11:43:17 +0100
Date: Thu, 29 Jul 2004 11:43:17 +0100
From: Dale Amon <amon@vnl.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pear-shaped behaviour after enough make reloads
Message-ID: <20040729104317.GE24051@vnl.com>
References: <20040728211229.GB18711@lkcl.net> <20040728225322.GE18711@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040728225322.GE18711@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 28, 2004 at 11:53:22PM +0100, Luke Kenneth Casson Leighton wrote:
>  i had to kill off processes manually one by one, umount the partitions
>  manually, poweroff, and i chose to boot with enforcing=0 init 1 in
>  order to safely run ldconfig and make relabel.
> 
>  i find this all a bit odd, i haven't a clue what's causing it.

Is this particular machine and kernel presently stable 
when running the same kernel and no selinux? I have
seen very strange things happen over the years when
hardware is failing or marginal, power supply voltages
are on the edge... I've seen particular PCI modules
blow the bus out of the water, etc, etc...

Worth checking before you ruin Stephen Smalley's sleep 
and fill it with nightmares of kernel race conditions
and random byte squashers. :-)

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
