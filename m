Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA10398
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 17:31:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA24431
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 22:29:09 GMT
Received: from mail.osss.is.tsukuba.ac.jp (dumbo.osss.is.tsukuba.ac.jp [130.158.85.97])
	by jazzswing.ncsc.mil  with ESMTP id WAA24427
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 22:29:08 GMT
Received: from manchester (ryche.osss.is.tsukuba.ac.jp [130.158.85.100])
	by mail.osss.is.tsukuba.ac.jp (Postfix) with SMTP id CBD2DD529D
	for <selinux@tycho.nsa.gov>; Fri,  1 Nov 2002 07:31:00 +0900 (JST)
Date: Fri, 1 Nov 2002 07:31:00 +0900
From: Koichi ONOUE <koichi@osss.is.tsukuba.ac.jp>
To: selinux@tycho.nsa.gov
Subject: MLS
Message-Id: <20021101073100.066b9899.koichi@osss.is.tsukuba.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I try to build and install example policy configuration with MLS.
I add "policy/user" to below line.

	user system_u roles system_r range u

but below error

/usr/local/selinux/bin/checkpolicy: loading policy configuration from
/etc/security/selinux/src/policy.conf
ERROR 'permission transition is not defined for common file' at toke '}' on line 471:
	mounton		:	{ read write }
/usr/local/selinux/bin/checkpolicy: error(s) encountered while parsing configuraion
make: *** [/etc/security/selinux/policy.12-mls] Error 1


Please tell me what I have to fix.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
