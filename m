Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA16286
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 12:13:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA29575
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 16:12:32 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id QAA29571
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 16:12:31 GMT
Received: from ed (ed1 [192.168.1.10])
	by mail.simplyaquatics.com (Postfix) with ESMTP id 3D9CC844054
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 12:13:06 -0400 (EDT)
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: sysadm_tty_device_t
Date: Thu, 11 Jul 2002 12:13:06 -0400
Message-ID: <00cc01c228f5$d73b6e10$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020710144012.524CB2F71@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Was working with putting syslog on /dev/tty24 (entry in /etc/syslog.conf
is 
*.*	/dev/tty24

Selinux shows /dev/tty1 as syadm_tty_device_t but /dev/tty24 is just
tty_device_t.  I started poking around looking for sysadm_tty_device_t
but not exactly sure what tty's are being set to this.  My question is
where is the control file, is it /etc/securetty?

Ed


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
