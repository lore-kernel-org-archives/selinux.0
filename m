Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9EK3nrT001093
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 16:03:49 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9EK2bmT004714
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 20:02:37 GMT
Subject: Re: cleanup: domain self references
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041011085450.GA15844@jmh.mhn.de>
References: <20041011085450.GA15844@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1097784161.32077.68.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 14 Oct 2004 16:02:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2004-10-11 at 04:54, Thomas Bleher wrote:
> I just did a global search and replace to clean up rules of the form
>         allow some_domain_t some_domain_t:capability setuid;
> This makes the policy easier to read.
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
