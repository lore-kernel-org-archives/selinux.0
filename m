Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJJinIi023338
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 14:44:49 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJJiplF016639
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 19:44:51 GMT
Subject: Re: gentoo diff for arpwatch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4198D07B.6070401@gentoo.org>
References: <4198D07B.6070401@gentoo.org>
Content-Type: text/plain
Message-Id: <1100893653.31793.25.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 19 Nov 2004 14:47:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged with some changes.

I moved the following rules and put an "ifdef(`arpwatch.te'" around
them:
"allow system_mail_t" rules to mta.te
"allow qmail_inject_t" rules to qmail.te
"allow allow postfix_local_t" rule to postfix.te

I also moved the "allow initrc_t" rules to initrc.te and put
"ifdef(`distro_gentoo" and "ifdef(`arpwatch.te'" around them.

On Mon, 2004-11-15 at 10:51, petre rodan wrote:
> Hi,
> 
> attached you'll find a +15 -5 patch to the arpwatch policy
> 
> both /var/lib/arpwatch and /var/arpwatch are used by gentoo.
> etc_t is used when arpwatch_t reads nsswitch.conf, usr_t is needed to read the ethercodes file.
> 
> the distro_gentoo block is needed because init creates ethX.dat files before the daemon is started.
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
