Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBFKeCIi020947
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2004 15:40:12 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBFKcUxm002462
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2004 20:38:30 GMT
Subject: Re: dhcpc.te patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200412140350.07001.russell@coker.com.au>
References: <200412140350.07001.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1103143337.31218.31.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 15 Dec 2004 15:42:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2004-12-13 at 11:50, Russell Coker wrote:
> The attached patch removes some redundant dontaudit rules from dhcpc.te.
> 
> It seems that Dan fixed the bugs some months ago but we didn't get around to 
> fixing the policy to match.
> 
> If other distributions don't have the patch then it's still appropriate to 
> apply this patch so people can discover the problem and get Dan's patches 
> applied.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
