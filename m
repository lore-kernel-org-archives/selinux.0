Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82Gg5rT000803
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 12:42:05 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82Gg4v0016112
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 16:42:04 GMT
Subject: Re: Latest Patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41374AB7.70206@tresys.com>
References: <200408241818.40064.russell@coker.com.au>
	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
	 <200408282346.05926.russell@coker.com.au>
	 <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>
	 <41371628.2020408@redhat.com>  <41374AB7.70206@tresys.com>
Content-Type: text/plain
Message-Id: <1094143205.17265.292.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 12:40:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 12:30, Joshua Brindle wrote:
> Why are you submitting a patch to the list that turns on all these 
> tunables? These should definately not be turned on in the sample policy!

Not an issue; we always omit diffs to tunables from merging.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
