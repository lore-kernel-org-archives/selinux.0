Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91GGErT002518
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 12:16:14 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91GF84L020702
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 16:15:08 GMT
Subject: Re: sulogin.te
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409300850.04208.russell@coker.com.au>
References: <200409300850.04208.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1096647317.13366.7.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 01 Oct 2004 12:15:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Wed, 2004-09-29 at 18:50, Russell Coker wrote:
> The attached patch removes a redundant line from sulogin.te.  The "auth" 
> attribute grants read and getattr access to /etc/shadow.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
