Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9SEeCXZ000203
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 10:40:12 -0400 (EDT)
Received: from wgimx02.wgint.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9SEcrba003550
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 14:38:53 GMT
Received: from wgiptcemx01.wgint.net ([10.246.80.18])
	by wgimx02.wgint.com (8.12.11/8.12.11) with ESMTP id i9SEeBRr002007
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 09:40:11 -0500
From: "Richard Simpson" <richard.simpson@wgint.com>
To: "Selinux@Tycho. Nsa. Gov" <selinux@tycho.nsa.gov>
Subject: wrong context for ntpd.pid
Date: Thu, 28 Oct 2004 08:42:52 -0600
Message-ID: <BJENLMGHDPAAAGKKPOFOKEGMCFAA.richard.simpson@wgint.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi:

I posted this to the Gentoo mailing list, but thought I might benefit from a
wider audience.

I'm trying to install ntpd on an selinux-enabled gentoo system, and one of
the stranger problems I'm having is with /var/run/ntpd.pid. The file is
being created with a context of initrc_var_run_t, but the ntpd.te policy
expects this file to have a context of ntpd_var_run_t. Poking around, I see
that the /etc/init.d/ntpd script creates an empty ntpd.pid because it wants
to `chown ntp:ntp` before it starts the daemon (with a "-u ntp:ntp" option),
ergo the initrc_var_run_t context.

The startup script is the obvious culprit, but I'm not sure how to fix it.
What is the proper selinux way to run a process as a non-root user:group?

Thanks,
Richard Simpson



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
