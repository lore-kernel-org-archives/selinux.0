Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HHaqrT015254
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 13:36:52 -0400 (EDT)
Received: from oberon.geminidataloggers.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HHaB2E006579
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 17:36:12 GMT
From: Toby Dickenson <tdickenson@devmail.geminidataloggers.co.uk>
Reply-To: tdickenson@geminidataloggers.com
To: Timothy Wood <timothy@diyab.net>
Subject: Re: [patch] setting default role from ssh
Date: Tue, 17 Aug 2004 18:36:50 +0100
Cc: selinux@tycho.nsa.gov
References: <1092513257.4515.28.camel@nexus.verbum.private> <1092670862.9971.20.camel@nexus.verbum.private> <41221FC2.8050403@diyab.net>
In-Reply-To: <41221FC2.8050403@diyab.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408171836.50217.tdickenson@devmail.geminidataloggers.co.uk>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 17 August 2004 16:09, Timothy Wood wrote:

> so maybe, as colin posted, using this
> 
> username/role:selinux@hostname

Ive had problems with colons and slashes in the host part of the ssh command 
line when using scp and cvs-over-ssh. Those tools already use those 
separators for other purposes. Im not sure if there are less encumbered 
seperators that would be a better choice here.

-- 
Toby Dickenson

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
