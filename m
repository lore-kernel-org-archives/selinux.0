Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m23GvnLh024637
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 11:57:49 -0500
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m23Gvhl4009537
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 16:57:48 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m23Gu61n003124
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 11:56:06 -0500
Received: from blums0041.bluelnk.net ([134.120.81.53])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m23Gtfvj026943
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 11:55:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: mcs translation daemon
Date: Mon, 3 Mar 2008 08:56:26 -0800
Message-ID: <0794F277152EF94AA637E3AECF5CB70F21A367@blums0042.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How is the mcs translation daemon supposed to be started/restarted?

When I reboot the machine, mcstransd comes up in the setrans_t domain.
If I start/restart it with "service mcstrans start/restart" (or
equivalently "/etc/init.d/mcstrans start/restart"), it comes up in
whatever user domain I'm in (either staff_t or sysadm_t). There is also
a /sbin/mcstransd executable which is labeled setrans_exec_t, but using
that still ends up with the mcstrans daemon running in my user shell
domain.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
