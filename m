Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIK3AIi016011
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 15:03:10 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIK1giM026533
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 20:01:42 GMT
Subject: Re: gentoo policy for stunnel
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4198D4CA.3020708@gentoo.org>
References: <4198D4CA.3020708@gentoo.org>
Content-Type: text/plain
Message-Id: <1100808355.26930.26.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 18 Nov 2004 15:05:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added.

I also removed the duplicate stunnel specification in inetd.fc.

By the way, the privlog attribute comes free of charge with the
daemon_core_rules macro (which is used by daemon_domain macro).

On Mon, 2004-11-15 at 11:09, petre rodan wrote:
> Hi,
> 
> attached you'll find the policy we use for stunnel [1]
> 
> [1] http://www.stunnel.org
> 	Stunnel is a program that allows you to encrypt arbitrary TCP connections inside SSL (Secure Sockets Layer) available on both Unix and Windows. Stunnel can allow you to secure non-SSL aware daemons and protocols (like POP, IMAP, LDAP, etc) by having Stunnel provide the encryption, requiring no 
> changes to the daemon's code.
> 
> bye,
> peter
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
