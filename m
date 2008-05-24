Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4ONwxdC007935
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2008 19:59:00 -0400
Received: from mho-02-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4ONwu6U005314
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2008 23:58:57 GMT
Received: from adsl-71-155-178-116.dsl.austtx.sbcglobal.net ([71.155.178.116] helo=[192.168.20.100])
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1K03dY-000JKz-HK
	for selinux@tycho.nsa.gov; Sat, 24 May 2008 23:58:56 +0000
Message-Id: <552999F5-C6B1-4ACE-B6CF-A4020CD13B5F@nall.com>
From: Joe Nall <joe@nall.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Is there a command line tool that returns 1 if a file is in the wrong context?
Date: Sat, 24 May 2008 18:58:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a command line tool that returns 1 if a file is in the wrong  
context?. I want to add a %verifyscript to our rpms to validate the  
installed file context when rpm -V is invoked.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
