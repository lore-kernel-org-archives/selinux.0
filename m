Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0OKixsj029399
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 15:44:59 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0OKgtsm022067
	for <selinux@tycho.nsa.gov>; Mon, 24 Jan 2005 20:42:55 GMT
Subject: Re: [patch] dpkg.fc
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050119001839.GA8704@yggdrasil.localdomain>
References: <20050119001839.GA8704@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1106596984.3298.13.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Jan 2005 15:03:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2005-01-18 at 19:18, Greg Norris wrote:
> The attached patch removes a duplicate entry from dpkg.fc, which causes 
> `make relabel' to complain.  Please apply.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
