Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIJwGIi015875
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 14:58:16 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIJwI3m008899
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 19:58:18 GMT
Subject: Re: gentoo diff for snmpd
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4198D752.2020405@gentoo.org>
References: <4198D752.2020405@gentoo.org>
Content-Type: text/plain
Message-Id: <1100808061.26930.18.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 18 Nov 2004 15:01:01 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

Oops, there is no proc_net_t defined.
Petre, could you send me the proc_net_t stuff as well.

On Mon, 2004-11-15 at 11:20, petre rodan wrote:
> Hi,
> 
> gentoo as a special context for /proc/net:
> genfscon proc /net  system_u:object_r:proc_net_t
> 
> so a small diff is needed for the snmpd policy. attached.
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
