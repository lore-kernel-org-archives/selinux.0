Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA10499
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 21:55:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA29361
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 01:53:54 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
        by jazzband.ncsc.mil  with ESMTP id BAA29357 for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 01:53:53 GMT
Received: from ed (ed1 [192.168.1.10])
	by mail.simplyaquatics.com (Postfix) with ESMTP id 49CAB84404A
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 21:55:22 -0400 (EDT)
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "Selinux" <selinux@tycho.nsa.gov>
Subject: netfilter
Date: Mon, 15 Jul 2002 21:55:22 -0400
Message-ID: <017901c22c6b$d8655e80$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Started working with netfilter under Selinux and I noted that it was
grouped with ipchains and labeled as 
/sbin/iptables                  system_u:object_r:ipchains_exec_t

Should this have a separate label and it's own te file?

Ed



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
