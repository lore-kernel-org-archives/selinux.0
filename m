Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IE4NrT020387
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 10:04:23 -0400 (EDT)
Received: from curiango.ipen.br (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IE3eho015693
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 14:03:41 GMT
Received: from [10.0.12.47] (helo=ipen.br)
	by curiango.ipen.br with esmtp (Exim 3.35 #1 (Debian))
	id 1BxQzz-0004nN-00
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 11:01:07 -0300
Message-ID: <41236128.9080709@ipen.br>
Date: Wed, 18 Aug 2004 11:01:12 -0300
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Information about execute_no_trans permission
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Helo.

I would like know how work the *execute_no_trans permission*.
Is it transition ?
How I would interprete this avc message, for sample.

avc:  denied  { execute_no_trans } for  pid=1873 
exe=/usr/sbin/boserver-apache
path=/bin/bash dev=hda3 ino=94777 scontext=system_u:system_r:httpd_t
tcontext=system_u:object_r:shell_exec_t tclass=file

Thanks.

-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
