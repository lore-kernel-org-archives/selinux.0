Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA83klSf027201
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2003 22:46:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA83klKl016632
	for <selinux@tycho.nsa.gov>; Sat, 8 Nov 2003 03:46:47 GMT
Received: from savages.net (savages.net [12.154.202.18])
        by jazzband.ncsc.mil  with ESMTP id hA83kj5m016629 for <selinux@tycho.nsa.gov>; Sat, 8 Nov 2003 03:46:46 GMT
Message-ID: <3FAC671F.4080702@pcez.com>
Date: Fri, 07 Nov 2003 19:46:39 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: util-linux-2.11y  and kernel 2.6-test9
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has any person had problems compiling util-linux-2.11y with kernel 
2.6-test9?

in disk-utils/blockdev.c

line 70 parse error
{ "--getbsz", "BLKBSZGET", BLKBSZGET, ARGINTG, -1,NULL,N_("get blocksize") }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
