Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h548n0I4021168
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 04:49:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h548mRss006755
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 08:48:27 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
	by jazzswing.ncsc.mil  with ESMTP id h548mQhY006747
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 08:48:26 GMT
Received: from localhost (unknown [127.0.0.1])
	by mail.vegaa.de (Postfix) with ESMTP id AF1A217409F
	for <selinux@tycho.nsa.gov>; Wed,  4 Jun 2003 10:48:32 +0200 (CEST)
Received: from mail.dr-baldeweg.de (pD9E8779B.dip.t-dialin.net [217.232.119.155])
	by mail.vegaa.de (Postfix) with ESMTP id EC217174010
	for <selinux@tycho.nsa.gov>; Wed,  4 Jun 2003 10:48:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.dr-baldeweg.de (Postfix) with ESMTP id 325A715424
	for <selinux@tycho.nsa.gov>; Wed,  4 Jun 2003 10:48:25 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: SELinux <selinux@tycho.nsa.gov>
Subject: file labels during init process
Date: Wed, 4 Jun 2003 10:48:19 +0200
MIME-Version: 1.0
Message-Id: <200306041048.19435.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This days I install the january release of SELinux on my SuSE 8.1.

Today I found this log message:
avc:  denied  { search } for  pid=1 exe=/sbin/init path=/var/log 
dev=03:09 ino=6 scontext=system_u:system_r:init_t 
tcontext=system_u:object_r:file_t tclass=dir

I have a problem with this entry. The complete filesystem is labeled 
correct. The partition hda7 mounted as /var/log is also labled with 
the correct type. Could it be that the init process access the 
filesystem before the labels "grasp"?

part of the boot messages:
<6>Security Scaffold v1.0.0 initialized
<6>SELinux:  Initializing.
<6>SELinux:  Starting in permissive mode
<6>SELinux:  Registered NetFilter hooks
<6>There is already a security framework initialized, 
register_security failed.
<6>Failure registering capabilities with the kernel
<6>selinux_register_security:  Registering secondary module 
capability
<6>Capability LSM initialized
<6>SELinux:  Completing initialization.
<4>security:  loading policy configuration from 
/etc/security/selinux/policy.12
<4>security:  3 users, 5 roles, 904 types
<4>security:  29 classes, 159756 rules
<6>SELinux: initialized (dev 03:09, type reiserfs), uses PSIDs
<6>SELinux: initialized (dev 00:06, type devpts), uses transition 
SIDs
<6>SELinux: initialized (dev 00:05, type pipefs), uses task SIDs
<6>SELinux: initialized (dev 00:04, type tmpfs), uses transition 
SIDs
<6>SELinux: initialized (dev 00:03, type sockfs), uses task SIDs
<6>SELinux: initialized (dev 00:02, type proc), uses genfs_contexts
<6>SELinux: initialized (dev 00:01, type bdev), not configured for 
labeling
<6>SELinux: initialized (dev 00:00, type rootfs), not configured for 
labeling
<6>Freeing unused kernel memory: 244k freed
<4>avc:  denied  { search } for  pid=1 exe=/sbin/init path=/var/log 
dev=03:09 ino=6 scontext=system_u:system_r:init_t 
tcontext=system_u:object_r:file_t tclass=dir
<6>Adding Swap: 264088k swap-space (priority 42)
<6>SELinux: initialized (dev 03:01, type ext2), uses PSIDs
<4>reiserfs: checking transaction log (device 03:05) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<6>SELinux: initialized (dev 03:05, type reiserfs), uses PSIDs
<4>reiserfs: checking transaction log (device 03:07) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<6>SELinux: initialized (dev 03:07, type reiserfs), uses PSIDs
<4>reiserfs: checking transaction log (device 03:08) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<6>SELinux: initialized (dev 03:08, type reiserfs), uses PSIDs
<4>reiserfs: checking transaction log (device 03:06) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<6>SELinux: initialized (dev 03:06, type reiserfs), uses PSIDs



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
