Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i28BeKRb004886
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 06:40:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i28BeJ0F009993
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 11:40:19 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id i28BeIgZ009980 for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 11:40:18 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id i28BgOqx030340
	for selinux@tycho.nsa.gov; Mon, 8 Mar 2004 08:42:24 -0300
Received: from net.ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id i28BgHiX030214
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 08:42:18 -0300
Message-ID: <404C5B57.9020209@net.ipen.br>
Date: Mon, 08 Mar 2004 08:39:03 -0300
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@baitaca.ipen.br>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: system_r and sysadm_r roles
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Helo.

I´d  like to know why there is a transition permission between system_r 
and sysadm_r.

Example:  allow system_r sysadm_r;

This would can induce the a problem of security ?

Thanks.

-- 
Carlos Anísio Monteiro	<monteiro@ipen.br>
IPEN-CNEN/SP
São Paulo - Brasil



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
