Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CIkPIi017888
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:46:25 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CIkSgF000064
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:46:28 GMT
Subject: Re: [patch] types.fc
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050104025950.GA5321@yggdrasil.localdomain>
References: <20050104025950.GA5321@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1105555711.11834.28.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 13:48:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2005-01-03 at 21:59, Greg Norris wrote:
> The attached patch against types.fc is needed by Debian, which currently
> supports only a single policy type.  At present "make relabel" mislabels
> the binary policy file, which as you can probably imagine is somewhat
> inconvenient. ;-)  The patch was generated against current CVS.
> 
> Please apply.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
