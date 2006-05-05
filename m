Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k45DXtXD017285
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 09:33:55 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k45DXsFK018560
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 13:33:54 GMT
Subject: swig wrapper bug: setexeccon
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 05 May 2006 09:34:01 -0400
Message-Id: <1146836041.11149.2.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Having a problem with the swig wrapper:

>>> import selinux
>>> selinux.setexeccon('user_u:system_r:java_t')
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
TypeError: argument number 1: a 'security_context_t *' is expected, 'str(user_u:system_r:java_t)' is received

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
