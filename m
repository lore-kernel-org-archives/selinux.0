Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFBOKRb019068
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 06:24:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBFBOJpn016136
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 11:24:19 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id hBFBOIab016127 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 11:24:18 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id hBFBP033001532
	for selinux@tycho.nsa.gov; Mon, 15 Dec 2003 09:25:01 -0200
Received: from ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id hBFBOjjx001032
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 09:24:46 -0200
Message-ID: <3FDD9A28.9070406@ipen.br>
Date: Mon, 15 Dec 2003 09:25:28 -0200
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Information
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

I have seen that the binary policy file (policy.15) have "15" as version 
of the checkpolicy utility, right ?
The change done in the sysvinit package load the policy as: 
/sbin/load_policy /etc/security/selinux/policy.15, right?
If yes, a change in the version of the checkpolicy, I have that change 
the sysvinit too ?

Is this a good idea ?
This is only a question.

Cheers.
Thanks.


-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
