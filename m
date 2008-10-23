Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9N26sZE006079
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2008 22:06:54 -0400
Received: from mail.magitekltd.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9N26rLg015921
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2008 02:06:54 GMT
Received: from [24.242.137.194] (helo=[192.168.30.40])
	by mail.magitekltd.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <lenny@magitekltd.com>)
	id 1KspZq-0005oU-E6
	for selinux@tycho.nsa.gov; Wed, 22 Oct 2008 21:05:30 -0500
Subject: semanage help
From: LC Bruzenak <lenny@MagitekLtd.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 21:06:52 -0500
Message-Id: <1224727612.14755.244.camel@homeserver>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

- get the file context -
[root@v1 ~]# semanage fcontext -l | grep prelude_spool
/var/spool/prelude(/.*)?                           all files          system_u:object_r:prelude_spool_t:s0 
/var/spool/prelude-manager(/.*)?                   all files          system_u:object_r:prelude_spool_t:s0 

So it seems that it knows about this path match.

- set the file range -
[root@v1 ~]# semanage fcontext -m -r s15:c0.c1023  "/var/spool/prelude(/.*)?"
/usr/sbin/semanage: File context for /var/spool/prelude(/.*)? is not defined

[root@v1 ~]# semanage fcontext -m -r s15:c0.c1023 -t prelude_spool_t '/var/spool/prelude(/.*)?'
/usr/sbin/semanage: File context for /var/spool/prelude(/.*)? is not defined

Can someone tell me what I'm doing wrong/how to fix?

Thanks in advance,
LCB.

-- 
LC (Lenny) Bruzenak
lenny@magitekltd.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
