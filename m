Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91GFsrT002501
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 12:15:55 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91GFrEZ005940
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 16:15:53 GMT
Subject: Re: rpcd.te patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200409291237.13327.russell@coker.com.au>
References: <200409291237.13327.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1096647285.13366.5.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 01 Oct 2004 12:14:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2004-09-28 at 22:37, Russell Coker wrote:
> The latest version of rpc.statd uses netlink to query the network state.  The 
> attach patch permits this.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
