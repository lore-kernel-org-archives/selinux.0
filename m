Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FGWDI4019268
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 12:32:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4FGWDVG028509
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 16:32:13 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h4FGWAL9028500 for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 16:32:11 GMT
Subject: slow application of contexts in devfs?
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <1053003033.4729.674.camel@moss-huskers.epoch.ncsc.mil>
References: <3EC2792D.1020209@yahoo.it>
	 <200305150539.40186.russell@coker.com.au>  <3EC2C366.5060901@yahoo.it>
	 <1053003033.4729.674.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1053016311.20932.17.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 15 May 2003 11:31:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running the 2003040709 lsm and selinux patches on a stock kernel,
and I'm seeing some weird behavior on devfs.  When starting up, it seems
that its taking a long time for the contexts to be correctly set on
devfs files (in this case /dev/log).  Here's the appropriate segment of
the kernel messages.  You can see that the policy is loaded, and devfs
is set up using genfs_contexts.  Then shortly later after devfs is
mounted, devfsd gets a denial writing to /dev/log, because its still
labeled as device_t

SELinux:  Completing initialization.
security:  loading policy configuration from
/etc/security/selinux/policy.12
security:  4 users, 5 roles, 467 types
security:  29 classes, 34324 rules
SELinux: initialized (dev 03:03, type ext3), uses PSIDs
SELinux: initialized (dev 00:08, type devpts), uses transition SIDs
SELinux: initialized (dev 00:07, type devfs), uses genfs_contexts
SELinux: initialized (dev 00:06, type binfmt_misc), not configured for
labeling
SELinux: initialized (dev 00:05, type pipefs), uses task SIDs
SELinux: initialized (dev 00:04, type tmpfs), uses transition SIDs
SELinux: initialized (dev 00:03, type sockfs), uses task SIDs
SELinux: initialized (dev 00:02, type proc), uses genfs_contexts
SELinux: initialized (dev 00:01, type bdev), not configured for labeling
SELinux: initialized (dev 00:00, type rootfs), not configured for
labeling
Mounted devfs on /dev
Freeing unused kernel memory: 280k freed
avc:  denied  { write } for  pid=148 exe=/sbin/devfsd path=/log
dev=00:07 ino=421 scontext=system_u:system_r:devfsd_t
tcontext=system_u:object_r:device_t tclass=sock_file


Now, I've verified that the genfscon does exist, grepped out of
policy.conf:

genfscon devfs /log                     system_u:object_r:devlog_t


Its also not just devfsd getting denials, there is a denial on syslog
later on in the boot process.  By the time the machine is done starting
up, /dev/log does have the right context:

srw-rw-rw-  root     root     system_u:object_r:devlog_t       /dev/log

-- 
Chris PeBenito
<pebenito@ieee.org>
AIM: PeBenito78
ICQ#: 10434387

"Engineering does not require science. Science helps
a lot, but people built perfectly good brick walls 
long before they knew why cement works."-Alan Cox

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
