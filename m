Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j05GhOIi003125
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 11:43:24 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j05GhRBa010576
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 16:43:27 GMT
Subject: Re: policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200501022303.49225.russell@coker.com.au>
References: <200501022303.49225.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1104943533.1511.5.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 05 Jan 2005 11:45:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged quota and screen patches.

On Sun, 2005-01-02 at 07:03, Russell Coker wrote:
> network_macros.diff makes a cosmetic change to the network macros.
> 
> quota.diff enables converting quota files from old format to new format and 
> adds access to raw disk devices which seems to be needed by the newer 
> versions of the quota utilities.
> 
> screen.diff allows screen access to proc files so that it can display the 
> uptime and other trivial stuff.  Screen can work without this, but it's handy 
> to have it and proc_t is hardly restricted anyway.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
