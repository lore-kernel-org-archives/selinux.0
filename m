Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBFJSoIi020502
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2004 14:28:50 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBFJSrSe022410
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2004 19:28:53 GMT
Subject: Re: gentoo policies for daemontools, ucspi-tcp, publicfile,
	djbdns, clockspeed
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41A07D3C.4070300@gentoo.org>
References: <41A07D3C.4070300@gentoo.org>
Content-Type: text/plain
Message-Id: <1103139082.31218.29.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 15 Dec 2004 14:31:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Do others use these tools?

Petre, you didn't include the publicfile policy, would you please send
it to the list.

Looking through these:

In Daemontools.te:
- The macro svc_sub_domain() is not used, so I will probably remove it.
- The macro svc_confdir_domain() is only used once (and it is only one
line long), so I will probably remove it as well.

In djbdns.te:
I will add ifdef(`daemontools.te' and ifdef(`ucspi-tcp.te'.

Anyone else have any comments on these?

On Sun, 2004-11-21 at 06:34, petre rodan wrote:
> Hi,
> 
> This is a collection of policies that I've been using and maintaining for more than an year now.
> 
> [1] http://cr.yp.to/daemontools.html
> [2] http://cr.yp.to/ucspi-tcp.html
> [3] http://cr.yp.to/publicfile.html
> [4] http://cr.yp.to/djbdns.html
> [5] http://cr.yp.to/clockspeed.html
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
