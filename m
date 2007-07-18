Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6ILTS6V027394
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 17:29:38 -0400
Received: from e35.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6ILTRdP009912
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 21:29:27 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6ILTOwL021784
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 17:29:24 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6ILTOCk258392
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 15:29:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6ILTOPK007951
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 15:29:24 -0600
Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        sailer@us.ibm.com
In-Reply-To: <Line.LNX.4.64.0707171025160.5764@d.namei>
References: <1184594240.5860.5.camel@localhost.localdomain>
	 <Line.LNX.4.64.0707171025160.5764@d.namei>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 17:33:22 -0400
Message-Id: <1184794402.10771.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-17 at 10:44 -0400, James Morris wrote: 
> On Mon, 16 Jul 2007, Mimi Zohar wrote:
> 
> > This is a first attempt to verify and measure file integrity, by
> > adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> > We are planning on posting the corresponding LIM and IMA patches to
> > LKML, but would like comments/suggestions here first, particularly
> > in regards to the policy checking code in selinux_measure() called 
> > from selinux_inode_permission().
> 
> Can you please post the integrity code being called? (Perhaps I missed it, 
> or should we look at your older patches?)

Based on comments here on the selinux mailing list, I need to make some
additional changes to the LIM patches (i.e use audit).  So I'll post the 
current set of LIM patches here.

Mimi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
