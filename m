Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2PJZGx6012422
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 14:35:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2PJZFR1027729
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 19:35:15 GMT
Received: from RelayDAL.nai.com (relaydal.nai.com [205.227.136.197])
        by jazzband.ncsc.mil  with ESMTP id h2PJZFj9027719 for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 19:35:15 GMT
Received: from txwsout1.nai.com (txwsout1.na.nai.com [161.69.216.92])
	by RelayDAL.nai.com (Switch-2.2.5/Switch-2.2.5) with SMTP id h2PJWmY15705
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 13:32:48 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: updated core policy files on sourceforge
Date: Tue, 25 Mar 2003 13:37:04 -0600
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14CFF@md-exchange1.na.nai.com>
From: <Kelly_Djahandari@nai.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've updated several of the core policy files to remove the use of every_domain(). The modified files include syslogd.te, klogd.te, crontd.te, fsadm.te, login.te, ssh.te, ifconfig.te and netutils.te. The files are on sourceforge. Please try them out.

Thanks,
Kelly Djahandari
Network Associates Laboratories



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
