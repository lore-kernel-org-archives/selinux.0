Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FECRWt025503
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 10:12:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FECQmR001864
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:12:27 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id h9FECOjp001861 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:12:25 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id h9FECeJd001002
	for selinux@tycho.nsa.gov; Wed, 15 Oct 2003 11:12:40 -0300
Received: from ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id h9FECUIB000930
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 11:12:30 -0300
Message-ID: <3F8D2B57.2080807@ipen.br>
Date: Wed, 15 Oct 2003 09:11:20 -0200
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: enforce mode problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

When I switch to enforce mode (echo 1 > /selinux/enforce), a lot of 
messages "avc" running in the console and the computer "freeze".
I am not succeeding in to resolve this avc messages. I note that this 
avc messages, mostly,  are associate to the system_u:system_r:kernel_t 
context trying access another context.

Please, anyone could me help.

Thanks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
