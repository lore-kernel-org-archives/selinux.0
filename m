Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAGKHHMA002370
	for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2005 15:17:17 -0500 (EST)
Received: from iron2-mx.tops.gwu.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAGK97Su003578
	for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2005 20:09:07 GMT
Message-Id: <4gfoda$4t2vl7@iron2-mx.tops.gwu.edu>
Date: Wed, 16 Nov 2005 15:09:22 -0500
From: Yuichi Nakamura <ynakam@gwu.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Cc: ynakam@gwu.edu
Subject: Replacing capability:sys_admin by other permissions
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

I am thinking whether capability:sys_admin can be replaced by other permissions. 
I do not like capablity:sys_admin because it is not fine-grained and hard to explain to users.

I found capability:sys_admin is checked as follows.
(1) Usage of quotactl, mount, mount, swapon, swapoff 
(2) Set attribute to all IPC objects(IPC_SET)
(3) Delete all IPC objects(IPC_RMID)
(4) Set extended security attibute for file system.
(5) Use fake UID as socket credential.
(6) Usage of sethostname, setdomainname
(7) Can open more file than limits in /proc/sys/fs/file-max.
(8) Allocate memory using space reserved for priviledged process.
(9) Some ioctl operations in device drivers 

I think (1)-(5) can be replaced by other permissions.
#There is other permissions that restricts (1)-(5).

However, (6)-(9) can not be replaced by other permissions.
For example, when we want to grant "sethostname" then 
(7),(8),(9) are also granted. It is not least-priviledge...

I think in old SELinux "sethostname, setdomainname" can be restricted.
Will they come back again?

And I think it is natural (7) and (8) are integrated into capability:sys_resource.
Is there plan to construct new sets of capability?
I think POSIX capability may reduce granularity of access control.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
