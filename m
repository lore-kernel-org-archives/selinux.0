Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBU5uruh024971
	for <selinux@tycho.nsa.gov>; Tue, 30 Dec 2008 00:56:53 -0500
Received: from ik-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBU5sKee018113
	for <selinux@tycho.nsa.gov>; Tue, 30 Dec 2008 05:54:20 GMT
Received: by ik-out-1112.google.com with SMTP id b32so1104806ika.2
        for <selinux@tycho.nsa.gov>; Mon, 29 Dec 2008 21:56:51 -0800 (PST)
Message-ID: <dd18b0c30812292156l646b11f9kfe1ddbdf938b9b12@mail.gmail.com>
Date: Mon, 29 Dec 2008 21:56:51 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: tresys <refpolicy@oss.tresys.com>
Subject: class kernel_service not defined in policy
Cc: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello;
this was received when doing a git-pull
today from the linus tree.
 class kernel_service not defined in policy


[    0.000999] SELinux:  Initializing.
[    0.000999] SELinux:  Starting in enforcing mode
[    0.263823] SELinux:  Registering netfilter hooks
[    2.247051] SELinux: 8192 avtab hash slots, 145624 rules.
[    2.343549] SELinux: 8192 avtab hash slots, 145624 rules.
[    2.517323] SELinux:  7 users, 9 roles, 2684 types, 95 bools, 1
sens, 256 cats
[    2.525821] SELinux:  73 classes, 145624 rules
[    2.540472] SELinux:  class kernel_service not defined in policy
[    2.548944] SELinux: the above unknown classes and permissions will be denied
[    2.557235] SELinux:  Completing initialization.
[    2.565527] SELinux:  Setting up existing superblocks.
[    2.601357] SELinux: initialized (dev sda1, type ext3), uses xattr
[    2.729447] SELinux: initialized (dev selinuxfs, type selinuxfs),
uses genfs_contexts
[    2.737693] SELinux: initialized (dev mqueue, type mqueue), uses
transition SIDs
[    2.745982] SELinux: initialized (dev hugetlbfs, type hugetlbfs),
uses genfs_contexts
[    2.754208] SELinux: initialized (dev devpts, type devpts), uses
transition SIDs
[    2.762309] SELinux: initialized (dev inotifyfs, type inotifyfs),
uses genfs_contexts
[    2.770475] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[    2.778693] SELinux: initialized (dev anon_inodefs, type
anon_inodefs), uses genfs_contexts
[    2.786995] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
[    2.795429] SELinux: initialized (dev debugfs, type debugfs), uses
genfs_contexts
[    2.803860] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
[    2.812224] SELinux: initialized (dev proc, type proc), uses genfs_contexts
[    2.820584] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
[    2.828671] SELinux: initialized (dev rootfs, type rootfs), uses
genfs_contexts
[    2.836629] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
[    3.640416] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[    3.778811] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[    3.792920] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[    8.328082] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[    9.578021] SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
[   10.554482] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs

I've been running the latest svn from tresys for(I think a week or so);
So the message might already be fixed.

regards;
-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
