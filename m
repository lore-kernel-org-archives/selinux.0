Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2PKIxx6012799
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 15:18:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2PKFQlY010334
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 20:15:26 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-156.nas-smoothtransition.com [66.95.157.156] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id h2PKFQKX010331
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 20:15:26 GMT
Received: from acme ([66.200.42.3])
	by mx.nas-smoothtransition.com (8.12.8/8.9.3) with ESMTP id h2PKIvLF012955
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 15:18:57 -0500
From: "david caplan" <dac@tresys.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: usermod
Date: Tue, 25 Mar 2003 15:18:57 -0500
Message-ID: <GBEAJBKHFOBIBBJBCGAGAEOACKAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200303251636.17723.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Was there a reason usermod was not wrapped similar to useradd/userdel?

On a similar note, what about the gpasswd/group[add|mod|del] family?  As
they are all sbin_t, they do not have permission, when run by sysadm_t, to
open /etc/gshadow (which is shadow_t).

Thanks,
david


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
