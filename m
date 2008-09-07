Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m87KPVLH010385
	for <selinux@tycho.nsa.gov>; Sun, 7 Sep 2008 16:25:31 -0400
Received: from mail.cpcug.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m87KOplB003822
	for <selinux@tycho.nsa.gov>; Sun, 7 Sep 2008 20:24:51 GMT
Subject: I hope the user guide will explain what to do with a message such
	as this one
From: "Stanley A. Klein" <sklein@cpcug.org>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Sun, 07 Sep 2008 16:25:21 -0400
Message-Id: <1220819121.7524.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running Centos 5.2 and since a recent upgrade have been getting a
screen containing the information I've copied below.  The suggestions on
the screen for fixing the problem are unhelpful.  (I've found this to
generally be the case with other similar screens I occasionally get when
running applications.)

This is all happening down in the system.  I have no idea what is going
on there, what the relevant applications are trying to do, or why they
are being blocked from doing it.

I hope the user guide will provide clear information on what to do when
these kinds of messages occur.


Stan Klein

-----------------------------------------------------------------------------

SELinux is preventing perl (logwatch_t) "getattr" to /root
(user_home_dir_t). 

Detailed Description:
SELinux denied access requested by perl. It is not expected that this
access is required by perl and this access may signal an intrusion
attempt. It is also possible that the specific version or configuration
of the application is causing it to require additional access. 

Allowing Access

Sometimes labeling problems can cause SELinux denials. You could try to
restore the default system file context for /root, restorecon -v '/root'
If this does not work, there is currently no automatic way to allow this
access. Instead, you can generate a local policy module to allow this
access - see FAQ Or you can disable SELinux protection altogether.
Disabling SELinux protection is not recommended. Please file a bug
report against this package. 

Additional Information
Source Context:  system_u:system_r:logwatch_t:SystemLow-SystemHigh
Target Context:  root:object_r:user_home_dir_t
Target Objects:  /root [ dir ]
Source:  0logwatch
Source Path:  /usr/bin/perl
Port:  <Unknown>
Host:  localhost.localdomain
Source RPM Packages:  perl-5.8.8-10.el5_2.3
Target RPM Packages:  filesystem-2.4.0-1.el5.centos
Policy RPM:  selinux-policy-2.4.6-137.1.el5
Selinux Enabled:  True
Policy Type:  targeted
MLS Enabled:  True
Enforcing Mode:  Enforcing
Plugin Name:  catchall_file
Host Name:  localhost.localdomain
Platform:  Linux localhost.localdomain 2.6.18-92.1.6.el5 #1 SMP Wed Jun
25 13:49:24 EDT 2008 i686 i686
Alert Count:  281
First Seen:  Sun 29 Jun 2008 11:32:46 AM EDT
Last Seen:  Sun 07 Sep 2008 11:57:17 AM EDT
Local ID:  404a8dd6-c7da-4ad0-bd2e-af87ab7fd144
Line Numbers:  
Raw Audit Messages :
host=localhost.localdomain type=AVC msg=audit(1220803037.282:24): avc:
denied { getattr } for pid=3570 comm="perl" path="/root" dev=hdb1
ino=2875137 scontext=system_u:system_r:logwatch_t:s0-s0:c0.c1023
tcontext=root:object_r:user_home_dir_t:s0 tclass=dir 

host=localhost.localdomain type=SYSCALL msg=audit(1220803037.282:24):
arch=40000003 syscall=195 success=no exit=-13 a0=81e8be0 a1=819b0c8
a2=a70ff4 a3=81e8be0 items=0 ppid=3568 pid=3570 auid=4294967295 uid=0
gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none)
ses=4294967295 comm="perl" exe="/usr/bin/perl"
subj=system_u:system_r:logwatch_t:s0-s0:c0.c1023 key=(null) 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
