Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n81G3Pon018342
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 12:03:25 -0400
Received: from pobox.globalherald.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n81G2mYZ013726
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 16:02:48 GMT
Received: from [192.168.2.3] (unknown [192.168.2.3])
	by pobox.globalherald.net (Postfix) with ESMTP id 097C81FD082
	for <selinux@tycho.nsa.gov>; Tue,  1 Sep 2009 13:23:36 -0400 (EDT)
Date: Tue, 1 Sep 2009 13:23:36 -0400 (EDT)
From: Joshua Kramer <josh@globalherald.net>
To: selinux@tycho.nsa.gov
Subject: CentOS / RHEL5: where is setrans.conf?
Message-ID: <alpine.LFD.2.00.0909011317390.26878@home-av-server.home-av>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

I am using CentOS 5.3 and experimenting with MLS.

When I do this: chcat -L

I get the error noted below.  What package provides setrans.conf - or do I 
have to write that myself?  Is this a case where CentOS differs from RHEL?

Thanks!
-Josh

[root@localhost qpid]# chcat -L
Traceback (most recent call last):
   File "/usr/bin/chcat", line 415, in ?
     sys.exit(listcats())
   File "/usr/bin/chcat", line 341, in listcats
     fd = open(selinux.selinux_translations_path())
IOError: [Errno 2] No such file or directory: '/etc/selinux/clip/setrans.conf'

[root@localhost qpid]# rpm -qa | grep sel
libselinux-utils-1.34.15-2
selinux-policy-devel-2.4.6-203.el5
libselinux-python-1.34.15-2
libselinux-devel-1.34.15-2
selinux-policy-mls-2.4.6-203.el5
selinux-policy-clip-3.1-1.1
selinux-policy-2.4.6-203.el5
libselinux-1.34.15-2

[root@localhost qpid]# rpm -qa | grep libse
libselinux-utils-1.34.15-2
libselinux-python-1.34.15-2
libselinux-devel-1.34.15-2
libsepol-devel-1.16.14-1
libsepol-1.16.14-1
libselinux-1.34.15-2
libsemanage-1.10.9-1
libsemanage-devel-1.10.9-1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
