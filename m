Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RL6krT022979
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 17:06:47 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RL6joM002432
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:06:45 GMT
Subject: Re: latest hald policy patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200408272138.05091.russell@coker.com.au>
References: <200408272138.05091.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093640765.24188.39.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Aug 2004 17:06:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2004-08-27 at 07:38, Russell Coker wrote:
> This one differs from the last in one line.
> 
> A recent patch we discussed (and I believe came to agreement on) was to change 
> the file_contexts to label /dev/hdX as removable_device_t if it refers to a 
> CD-ROM or DVD.  This means of course that hald needs to be able to read 
> removable_device_t.
> 
> Apart from this it's the same as the last patch I sent.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
