Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9SGtfXZ001454
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 12:55:41 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9SGsMba013126
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 16:54:23 GMT
Date: Thu, 28 Oct 2004 18:55:38 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Richard Simpson <richard.simpson@wgint.com>
Cc: "Selinux@Tycho. Nsa. Gov" <selinux@tycho.nsa.gov>
Subject: Re: wrong context for ntpd.pid
Message-ID: <20041028165529.GE27776@rom.cip.ifi.lmu.de>
References: <BJENLMGHDPAAAGKKPOFOKEGMCFAA.richard.simpson@wgint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <BJENLMGHDPAAAGKKPOFOKEGMCFAA.richard.simpson@wgint.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Richard Simpson <richard.simpson@wgint.com> [2004-10-28 18:17]:
> I'm trying to install ntpd on an selinux-enabled gentoo system, and one of
> the stranger problems I'm having is with /var/run/ntpd.pid. The file is
> being created with a context of initrc_var_run_t, but the ntpd.te policy
> expects this file to have a context of ntpd_var_run_t. Poking around, I see
> that the /etc/init.d/ntpd script creates an empty ntpd.pid because it wants
> to `chown ntp:ntp` before it starts the daemon (with a "-u ntp:ntp" option),
> ergo the initrc_var_run_t context.

Add the following line to /etc/init.d/ntpd directly after the chown:
        [ -e /sbin/restorecon ] && /sbin/restorecon /var/run/ntpd.pid

This should be all that is needed.

Thomas
-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
