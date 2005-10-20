Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9KKeRNs006473
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 16:40:27 -0400 (EDT)
Subject: Re: range transitions in MCS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200510152033.03582.russell@coker.com.au>
References: <200510152033.03582.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 16:37:00 -0400
Message-Id: <1129840620.25091.40.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

Along with:
2 patches from 9/17/05
5 patches from 9/19/05
1 patch from 9/22/05
2 patches from 10/13/05

I probably missed one somewhere.

On Sat, 2005-10-15 at 20:32 +1000, Russell Coker wrote:
> Currently in the MCS policy in rawhide restarting a daemon changes it's MLS 
> context from "s0" to "s0:c0.c255".  This is obviously not what we want.
> 
> I suggest the attached patch to fix this.
> 
> The daemon policies cups.te, udev.te, and xdm.te need to be modified to 
> include this attribute.
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
