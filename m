Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2VJHnx6012490
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2003 14:17:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2VJEDOv001157
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2003 19:14:13 GMT
Received: from RelaySNC.nai.com (relaysnc.nai.com [161.69.3.67])
	by jazzswing.ncsc.mil  with ESMTP id h2VJECY1001154
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2003 19:14:12 GMT
Received: from scwsout1.nai.com (scwsout1.nai.com [161.69.3.73])
	by RelaySNC.nai.com (Switch-2.2.5/Switch-2.2.5) with SMTP id h2VJ6Cd21048
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2003 13:06:12 -0600 (CST)
Subject: Latest policy changes
Date: Mon, 31 Mar 2003 11:20:17 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14D11@md-exchange1.na.nai.com>
From: <Kelly_Djahandari@nai.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Several policy files have been modified. We've removed more macros including can_exec_any() from the core policy and other small changes for usability. We've also moved domains/misc/fcron.te and auth-net.te to the unused directory, since these are not part of core policy. The files have been updated on sourceforge. Please experiment.

Kelly Djahandari
Network Associates Laboratories


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
