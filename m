Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIJkHIi015639
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 14:46:17 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIJkJ3m008419
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 19:46:19 GMT
Subject: Re: cleanup patch: fix wrong use of dot in file_contexts
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041112000732.GE2544@jmh.mhn.de>
References: <20041112000732.GE2544@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1100807341.26930.3.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 18 Nov 2004 14:49:01 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks.  Merged.

On Thu, 2004-11-11 at 19:07, Thomas Bleher wrote:
> In a lot of places, a simple . was used in the file_contexts file, when
> \. was intended. Attached patch fixes this.
> It also fixes one or two places where a path specification was
> duplicated.
> 
> Please apply.
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
