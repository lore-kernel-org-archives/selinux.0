Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCCkQRb008282
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 07:46:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBCCjdlU009304
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 12:45:39 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
	by jazzswing.ncsc.mil  with ESMTP id hBCCjbSX009270
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 12:45:38 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id hBCCl2Vf001083
	for selinux@tycho.nsa.gov; Fri, 12 Dec 2003 10:47:02 -0200
Received: from ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id hBCCkvjx001065
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 10:46:57 -0200
Message-ID: <3FD9B8F2.7030100@ipen.br>
Date: Fri, 12 Dec 2003 10:47:46 -0200
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Information about selinuxfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Helo.

A information about the selinuxfs filesystem.
The directory name and the path to mount o selinuxfs must be alway /selinux.
A change on this name (/selinux) only affect the sysvinit and initrd, 
what set the directory name and path, or it will cause others problems ?

Many thanks.


-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
