Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1NIKDmr001961
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 13:20:13 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1NIFNuD022329
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 18:15:23 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j1NIJQ68009294
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 13:19:26 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j1NIJQHt009293
	for selinux@tycho.nsa.gov; Wed, 23 Feb 2005 13:19:26 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1N6mXdW028407
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 01:48:34 -0500 (EST)
Received: from mail02.infosat.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1N6k6at007237
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 06:46:08 GMT
Received: from [196.38.110.14] (HELO mail01.infosat.net)
  by mail02.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with ESMTP id 208197921 for selinux@tycho.nsa.gov; Wed, 23 Feb 2005 08:45:52 +0200
Received: from [66.18.72.157] (HELO hivsa.com)
  by mail01.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with SMTP id 646269367 for selinux@tycho.nsa.gov; Wed, 23 Feb 2005 08:45:50 +0200
From: Jayendren Anand Maduray <jayendren@hivsa.com>
Reply-To: jayendren@mweb.co.za
To: russell@coker.com.au
Subject: Re: fc3 - password change problem - syslog and portmapper
Date: Wed, 23 Feb 2005 08:44:19 +0200
Cc: jayendren@mweb.co.za, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200502220809.40631.jayendren@hivsa.com> <200502221151.19612.jayendren@hivsa.com> <200502222347.02398.russell@coker.com.au>
In-Reply-To: <200502222347.02398.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502230844.19180.jayendren@hivsa.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!
tried restorecon, here is the output:

[root@shiva jay]# restorecon /etc/passwd
[root@shiva jay]# passwd
Changing password for user root.
New UNIX password:
Retype new UNIX password:
passwd: Authentication failure
[root@shiva jay]#

here is dmesg:
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda5, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured for 
labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts

For Syslogd:
syslogd: error while loading shared libraries: /lib/ld-linux.so.2: cannot 
apply additional memory protection after relocation

For portmap:
error while loading shared libraries: libnsl.so.1:
cannot open shared object file: No such file or directory.


On Tuesday 22 February 2005 14:46, Russell Coker wrote:
> restorecon /etc/passwd

-- 
Jayendren Anand Maduray
Microsoft Certified Professional
Network Plus
IT Administrator  

Perinatal HIV Research Unit
Old Potch Road
Chris Hani Baragwanath Hospital
Soweto
South Africa

Tel: +27 11 989 9776
Tel: +27 11 989 9999
Fax: +27 11 938 3973
Cel: 082 22 774 94

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
