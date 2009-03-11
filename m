Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2BH17J2006806
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 13:01:07 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2BH17Ft025154
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 17:01:07 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2) with ESMTP id n2BH0ifK013371
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 13:00:44 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2/Submit) id n2BH0i69013370
	for selinux@tycho.nsa.gov; Wed, 11 Mar 2009 13:00:44 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2BGG2nF031596
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 12:16:02 -0400
Received: from mho-01-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2BGG1Ft016456
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 16:16:02 GMT
Received: from cpe-66-68-165-162.austin.res.rr.com ([66.68.165.162] helo=[192.168.20.230])
	by mho-01-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1LhR68-000Fpg-TQ
	for selinux@tycho.nsa.gov; Wed, 11 Mar 2009 16:16:01 +0000
Message-Id: <1BF3FC9F-9D76-4CF5-B67E-DFE8216038FA@nall.com>
From: Joe Nall <joe@nall.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Help with python seobject.loginRecords
Date: Wed, 11 Mar 2009 11:15:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I need to add login mappings in python firstboot modules during system  
configuration. In my first module a simple:

seobject.loginRecords().add(username, "siterep_u", "SystemLow- 
SystemHigh")

works. In subsequent modules, I get an exception:

libsemanage.enter_rw: this operation requires a transaction
libsemanage.enter_rw: could not enter read-write section
Traceback (most recent call last):
   File "./t", line 6, in <module>
     seobject.loginRecords().add("test3", "sysadm_u", "SystemLow- 
SystemHigh")
   File "/usr/lib64/python2.5/site-packages/seobject.py", line 442, in  
add
     raise error
ValueError: Could not add login mapping for test3

What is the right way to do this?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
