Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m23HvnUF032316
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 12:57:51 -0500
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m23Hvkl4002462
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 17:57:46 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m23HuMAX028795
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 12:56:22 -0500
Received: from blums0041.bluelnk.net ([134.120.81.53])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m23Hu9tf020808
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 12:56:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: sudo
Date: Mon, 3 Mar 2008 09:56:54 -0800
Message-ID: <0794F277152EF94AA637E3AECF5CB70F21A399@blums0042.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Should sudo work with the strict policy? Using the RHEL5.1 strict
policy, sudo doesn't work in enforcing mode. Looking at the audit logs,
quite a few rules need to be added to get it working. This is seems to
be the case when I'm in either the staff_t or sysadm_t domain. Is there
an easy trick to get sudo working? Or do I just need to use the audit
logs to figure out which rules I need to add?

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
