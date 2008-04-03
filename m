Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m33FmUES028798
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 11:48:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m33FmRhX007444
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 15:48:27 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Error running semanage from trunk
Date: Thu, 3 Apr 2008 11:45:41 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801CD22C7@exchange.columbia.tresys.com>
From: "Brian M. Williams" <bwilliams@tresys.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I built the toolchain out of trunk this morning (rev 2860); I have
python 2.4.3 installed on RHEL 5.1, running semanage with any input
gives this error:

[root@localhost policy]# semanage
Traceback (most recent call last):
  File "/usr/sbin/semanage", line 24, in ?
    import seobject
  File "/usr/lib/python2.4/site-packages/seobject.py", line 93, in ?
    import xml.etree.ElementTree
ImportError: No module named etree.ElementTree

Does anyone know where this might be coming from?  Does semanage need a
newer version of python?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
