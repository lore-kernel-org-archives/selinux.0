Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RL94rT023035
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 17:09:04 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RL92oM002474
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:09:02 GMT
Subject: Re: file_contexts/types.fc
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200408272141.36561.russell@coker.com.au>
References: <200408272141.36561.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093640898.24188.45.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Aug 2004 17:08:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks.  Merged.

On Fri, 2004-08-27 at 07:41, Russell Coker wrote:
> The attached patch changes file_contexts/types.fc, it removes a bogus entry 
> for /dev/mdsp (it's a DSP board whatever that means, not a hard disk).
> 
> It fixes an error in the tape device labelling which missed some entries, and 
> it adds a Debian specific entry for fonts.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
