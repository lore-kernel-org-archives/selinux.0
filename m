Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJZpXZ011131
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:35:51 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TJZmsx021641
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 19:35:48 GMT
Subject: Re: [patch] allow hald to read selinux config
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Colin Walters <walters@verbum.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1098558352.8447.33.camel@x-infinity.verbum.private>
References: <1098558352.8447.33.camel@x-infinity.verbum.private>
Content-Type: text/plain
Message-Id: <1099078478.12321.100.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 15:34:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Sat, 2004-10-23 at 15:05, Colin Walters wrote:
> This patch is needed because HAL 0.4.0 now determines whether or not
> SELinux is enabled, and if it is applies the removable media context to
> mounted filesystems. 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
