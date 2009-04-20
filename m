Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3KFFPm2009628
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 11:15:25 -0400
Received: from AZ25EGS03.gdc4s.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3KFFMiZ017583
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 15:15:25 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: can't access problem a file with a given range (mls policy)
Date: Mon, 20 Apr 2009 08:15:18 -0700
Message-ID: <FA8938DBA959E546BF6527F085F22FF804A36A17@AZ25EXM04.gddsi.com>
In-Reply-To: <FE5666DB-4EA1-4E4E-8A7B-E051F71BFE2F@gmail.com>
References: <FE5666DB-4EA1-4E4E-8A7B-E051F71BFE2F@gmail.com>
From: "West, Gary-P55389" <Gary.West@gdc4s.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Root can't read the object because it does not dominate the object.


Object's currnet level: s0:c0.c512
Subject's current level: s4:c0.c256

There are extra categories (c257.c512) in the subject that are not in
the subject. The subject must have every category of the object, not
just some.

Gary

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Sebastian Pfaff
Sent: Sunday, April 19, 2009 6:45 AM
To: selinux@tycho.nsa.gov
Subject: can't access problem a file with a given range (mls policy)

hello list,

security context of rangeRange:

[root@localhost ~]# ls -Z rangeRange
-rw-r--r--. root root root:object_r:admin_home_t:s0:c0.c512-
s5:c0.c1023 rangeRange

here the problem:

bonbon:Downloads seba$ ssh root/sysadm_r/s4:c0.c256@192.168.2.13
root/sysadm_r/s4:c0.c256@192.168.2.13's password:
Last login: Sun Apr 19 04:34:15 2009 from 192.168.2.3 [root@localhost
~]# id -Z
root:sysadm_r:sysadm_t:s4:c0.c256
[root@localhost ~]# ls -Z rangeRange
ls: cannot access rangeRange: Permission denied

Why can't i access rangeRange. IMHO i'm within the range (s0:c0.c512-
s5:c0.c1023), but i'm not totally sure. Please, correct if i'm wrong and
give me a short pointer.

tnx in advance

--
Sebastian Pfaff

PS: If you need additional information, please let me know.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
