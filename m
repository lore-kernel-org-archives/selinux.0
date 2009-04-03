Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n33GihsE004195
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 12:44:43 -0400
Received: from brmea-mail-4.sun.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n33GigBk000418
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 16:44:43 GMT
Received: from dm-central-01.central.sun.com ([129.147.62.4])
	by brmea-mail-4.sun.com (8.13.6+Sun/8.12.9) with ESMTP id n33Gig2i000491
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 16:44:42 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-01.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n33GigcO017071
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 10:44:42 -0600 (MDT)
Date: Fri, 3 Apr 2009 10:42:54 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Santosh Chokhani <SChokhani@cygnacom.com>
Cc: saag@ietf.org, labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        nfsv4@ietf.org, selinux@tycho.nsa.gov
Subject: Re: [saag] Common labeled security (comment on CALIPSO,	labeled NFSv4)
Message-ID: <20090403154253.GZ1500@Sun.COM>
References: <20090402154402.GM1500@Sun.COM> <FAD1CF17F2A45B43ADE04E140BA83D48A9FF82@scygexch1.cygnacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FAD1CF17F2A45B43ADE04E140BA83D48A9FF82@scygexch1.cygnacom.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 03, 2009 at 11:22:38AM -0400, Santosh Chokhani wrote:
> As part of MISSI and DMS, in mid to late 90's we did work on something
> called Security Policy Information File (SPIF).

Oh, very nice!  Thanks for the pointer.  That would be ISO15816.  I've
found the spec, though it's non-free (hadn't they learned the lesson
with ASN.1??  will they ever learn it??).

> At high level SPIF entailed the following:
> 
> 1.  It was ASN.1 based.

Not surprisingly :)  Converting that to XML is probably the correct
first step in order to ensure adoption, sadly.  (Actually, apparently
that has already been done once, though outside the ISO/ITU-T.)

> 2.  It permitted you to convert the machine representation to human
> readable representation.
> 3.  It permitted you to convert the human readable input to machine
> representation.
> 4.  It mapped labels (hierarchical sensitivity levels and
> non-hierarchical categories) from one labeling policy to another (i.e.,
> establish equivalency mapping)
> 5.  It allowed you to constrain labels since for some policies,
> existence of a category may mean some categories, levels, may be
> included and/or excluded.
> 
> Different labeling policies were indicated by different policy OID.
> 
> Some of the concept from that work may be applicable here. 

I think so!  Except for the part about this spec being non-free.  I
think that means: start over in the IETF.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
