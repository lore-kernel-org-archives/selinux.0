Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA11111
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 09:26:00 -0400 (EDT)
From: pasi.kivikangas@nokia.com
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA03682
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 13:24:31 GMT
Received: from mgw-x4.nokia.com (mgw-x4.nokia.com [131.228.20.27])
	by jazzswing.ncsc.mil  with ESMTP id NAA03678
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 13:24:30 GMT
Received: from esvir03nok.nokia.com (esvir03nokt.ntc.nokia.com [172.21.143.35])
	by mgw-x4.nokia.com (Switch-2.2.1/Switch-2.2.0) with ESMTP id g8PDQQF27893
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 16:26:26 +0300 (EET DST)
Received: from esebh002.NOE.Nokia.com (unverified) by esvir03nok.nokia.com
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T5d8e49bfa1ac158f23157@esvir03nok.nokia.com> for <selinux@tycho.nsa.gov>;
 Wed, 25 Sep 2002 16:25:56 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: SELinux on UML
Date: Wed, 25 Sep 2002 16:25:54 +0300
Message-ID: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8429@esebe013.ntc.nokia.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I wanted to try out SELinux on UML (User Mode Linux). What I did was, I patched Linux kernel 2.4.19 with LSM- then with SELinux- and finally with UML-patches. Everything went quite well and I didn't have to do too much manual work.

Anyhow, UML kernel compilation didn't succeed because SELinux seems to rely on some ptrace stuff (I'm not quite familiar with that) and UML doesn't seem to provide that.

Just wanted to ask if somebody around have done some experiments with SELinux on UML and got it working somehow?


	- Pasi

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
