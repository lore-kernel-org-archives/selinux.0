Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2THd9Rb006530
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 12:39:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2THOHqJ029066
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 17:38:59 GMT
Received: from nibbel.kulnet.kuleuven.ac.be (nibbel.kulnet.kuleuven.ac.be [134.58.240.41])
        by jazzband.ncsc.mil  with ESMTP id i2SMbB36005428 for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 22:37:11 GMT
In-Reply-To: <20040328192930.GA12067@bern.cip.informatik.uni-muenchen.de>
References: <D571AD7F-7F4B-11D8-A7FC-000A95D903E6@student.kuleuven.ac.be> <200403262039.i2QKdELb020746@turing-police.cc.vt.edu> <5D73C9A0-7F6C-11D8-A718-003065725CB8@student.kuleuven.ac.be> <200403270025.i2R0PK2l029036@turing-police.cc.vt.edu> <20040328192930.GA12067@bern.cip.informatik.uni-muenchen.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7204F773-8108-11D8-AC4F-000A95D903E6@student.kuleuven.ac.be>
Cc: selinux@tycho.nsa.gov
From: Koen Vervloesem <koen.vervloesem@student.kuleuven.ac.be>
Subject: Re: make relabel: invalid context
Date: Mon, 29 Mar 2004 00:37:08 +0200
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I hit this problem when trying to use a version 16 policy on a kernel
> which was not configured for it (that is vanilla 2.6.4). Try to set
> POLICYCOMPAT = -c in the Makefile and also delete
> /etc/security/selinux/policy.16 , this should fix it.

OK. Many thanks for the help. I changed the Makefile, deleted the 
policy.16 file, and reran make policy and make install. Now I didn't 
get any errors. But is this normal:

root@carnivore:~/policy-1.8# make load
/usr/sbin/load_policy /etc/security/selinux/policy.15
touch tmp/load
root@carnivore:~/policy-1.8# make relabel
/usr/sbin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]| 
xfs).*rw/{print $3}'`
/usr/sbin/setfiles:  read 0 specifications

Regards,

Koen
--
"A great many people think they are thinking when they are merely 
rearranging their prejudices." (William James)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
