Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i756WUrT003474
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 02:32:30 -0400 (EDT)
Received: from markus.schuldei.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i756WSZl012289
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 06:32:29 GMT
Date: Wed, 4 Aug 2004 01:31:15 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: Russell Coker <rcoker@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: problems with selinux-policy-default 1:1.14-2
Message-ID: <20040803233114.GQ1828@markus.schuldei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

installing on a selinx kernel gives me this:

=============================
petrus:~# apt-get install selinux-policy-default
Reading Package Lists... Done
Building Dependency Tree... Done
The following NEW packages will be installed:
  selinux-policy-default
0 upgraded, 1 newly installed, 0 to remove and 7 not upgraded.
Need to get 0B/193kB of archives.
After unpacking 4129kB of additional disk space will be used.
Selecting previously deselected package selinux-policy-default.
(Reading database ... 32354 files and directories currently installed.)
Unpacking selinux-policy-default (from .../selinux-policy-default_1%3a1.14-2_all.deb) ...
Setting up selinux-policy-default (1.14-2) ...
make: *** /etc/selinux/src: No such file or directory.  Stop.
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 2
"/bin/run-parts --arg=selinux-policy-default /etc/dpkg/postinst.d" failed: 256
dpkg: error processing selinux-policy-default (--configure):
 1Error running trigger postinst: No such file or directory
Errors were encountered while processing:
 selinux-policy-default
E: Sub-process /usr/bin/dpkg returned an error code (1)
petrus:~# l /etc/selinux/
total 20
drwxr-xr-x    4 root     root         4096 Aug  4 00:57 .
drwxr-xr-x   70 root     root         4096 Aug  4 00:57 ..
-rw-r--r--    1 root     root          120 Aug  2 09:28 config
drwxr-xr-x    2 root     root         4096 Aug  4 00:57 contexts
drwxr-xr-x    2 root     root         4096 Aug  2 09:28 policy
lrwxrwxrwx    1 root     root           33 Aug  4 00:57 src -> /usr/share/selinux/policy/current
petrus:~# l /usr/share/selinux/policy
total 12
drwxr-xr-x    3 root     root         4096 Aug  4 00:57 .
drwxr-xr-x    3 root     root         4096 Aug  4 00:57 ..
drwxr-xr-x    9 root     root         4096 Aug  4 00:57 default
==========================

src is a dangeling symlink.

changing it to point to /usr/share/selinux/policy/default 
lets me run into this error:

======================
petrus:~# rm /etc/selinux/src
petrus:~# ln -s /usr/share/selinux/policy/default /etc/selinux/src
petrus:~# apt-get install selinux-policy-default
Reading Package Lists... Done
Building Dependency Tree... Done
selinux-policy-default is already the newest version.
0 upgraded, 0 newly installed, 0 to remove and 7 not upgraded.
1 not fully installed or removed.
Need to get 0B of archives.
After unpacking 0B of additional disk space will be used.
Setting up selinux-policy-default (1.14-2) ...
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
security:  4 users, 6 roles, 1327 types, 1 bools
security:  52 classes, 188841 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 18) to /etc/selinux/policy/policy.18
make: *** No rule to make target `file_contexts/program/webalizer.fc', needed by `file_contexts/file_contexts'.  Stop.
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 2
"/bin/run-parts --arg=selinux-policy-default /etc/dpkg/postinst.d" failed: 256
dpkg: error processing selinux-policy-default (--configure):
 1Error running trigger postinst: No such file or directory
Errors were encountered while processing:
 selinux-policy-default
E: Sub-process /usr/bin/dpkg returned an error code (1)
======================

creating that file

=======================
petrus:~# touch /etc/selinux/src/file_contexts/program/webalizer.fc
=======================

lets me start the selection process.

this procedure was necessary after i attempted to install
selinux-policy-default on a non-selinux kernel. Then everything
worked fine untill i failed at the same point then now, after
going through the whole selection process:

=======================
Installing the new SE Linux policy
mount: none already mounted or /selinux busy
dpkg: error processing selinux-policy-default (--configure):
 subprocess post-installation script returned error exit status 32
Errors were encountered while processing:
 selinux-policy-default
E: Sub-process /usr/bin/dpkg returned an error code (1)
=======================

i am aware of the thread on this list where similar progress had
been made and at this point the discussion did not focus on how
to get around this error but if it was good or not to have
selinux in the fstab. in my case the package (or rather russel)
took care of that and there is the line

========================
none            /selinux        selinuxfs       noauto  0 0
========================

in my fstab.

how can i successfully create a policy anyway?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
