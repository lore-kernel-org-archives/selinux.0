Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANL6rIi015235
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 16:06:53 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANL6uau003892
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 21:06:56 GMT
Subject: Re: gentoo diff for ntpd, gpm
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <419E0D54.3000409@gentoo.org>
References: <419E0D54.3000409@gentoo.org>
Content-Type: text/plain
Message-Id: <1101244176.7273.36.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 23 Nov 2004 16:09:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2004-11-19 at 10:12, petre rodan wrote:
> gpm:
> gpm_conf_t label for /etc/gpm(/.*)?
> 
> ntpd:
> logrotate_exec_t has been added in a ifdef('logrotate some time ago
> 2 file contexts tweaked to support gentoo file locations
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
