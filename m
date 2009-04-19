Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3JDjT9j010404
	for <selinux@tycho.nsa.gov>; Sun, 19 Apr 2009 09:46:30 -0400
Received: from mail-bw0-f160.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3JDjSdL004668
	for <selinux@tycho.nsa.gov>; Sun, 19 Apr 2009 13:45:29 GMT
Received: by bwz4 with SMTP id 4so286721bwz.18
        for <selinux@tycho.nsa.gov>; Sun, 19 Apr 2009 06:45:15 -0700 (PDT)
Message-Id: <FE5666DB-4EA1-4E4E-8A7B-E051F71BFE2F@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: can't access problem a file with a given range (mls policy)
Date: Sun, 19 Apr 2009 15:45:13 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello list,

security context of rangeRange:

[root@localhost ~]# ls -Z rangeRange
-rw-r--r--. root root root:object_r:admin_home_t:s0:c0.c512- 
s5:c0.c1023 rangeRange

here the problem:

bonbon:Downloads seba$ ssh root/sysadm_r/s4:c0.c256@192.168.2.13
root/sysadm_r/s4:c0.c256@192.168.2.13's password:
Last login: Sun Apr 19 04:34:15 2009 from 192.168.2.3
[root@localhost ~]# id -Z
root:sysadm_r:sysadm_t:s4:c0.c256
[root@localhost ~]# ls -Z rangeRange
ls: cannot access rangeRange: Permission denied

Why can't i access rangeRange. IMHO i'm within the range (s0:c0.c512- 
s5:c0.c1023), but i'm not totally sure. Please, correct if i'm wrong  
and give me a short pointer.

tnx in advance

--
Sebastian Pfaff

PS: If you need additional information, please let me know.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
