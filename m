Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7400gHa014188
	for <selinux@tycho.nsa.gov>; Sun, 3 Aug 2003 20:00:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h73NxSFB009031
	for <selinux@tycho.nsa.gov>; Sun, 3 Aug 2003 23:59:28 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h73NxSGD009028
	for <selinux@tycho.nsa.gov>; Sun, 3 Aug 2003 23:59:28 GMT
Subject: SELinux-2.6-PPC
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1059955240.2997.75.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 03 Aug 2003 19:00:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First of all, congrats to the NSA guys for getting SELinux merged into
the linus tree.  Thanks for all your hard work.  I've got a SELinux
kernel running on my PPC now, so we'll see how it goes on a new arch.

I've got a quick question about the new userland, are all of the future
releases planned to have the split up libselinux, checkpolicy,
policycoreutils, etc packages?  I just want to be sure; I don't want to
create packages for these, and then find that future releases get
remerged into a new selinux-small :)


Linux version 2.6.0-test2-bk3 (root@beta) (gcc version 3.2.3 20030422
(Gentoo Linux 1.4 3.2.3-r2, propolice)
Found a Grand Central mac-io controller, rev: 2, mapped at 0xfdf00000
PowerMac motherboard: Unknown PowerSurge
Cache coherency enabled for bandit/PSX
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/sda9 ro l2cr=0xab000000 console=tty0
console=ttyS0,38400
l2cr set to ab000000
System has 32 possible interrupts
PID hash table entries: 2048 (order 11: 16384 bytes)
GMT Delta read from XPRAM: -360 minutes, DST: off
via_calibrate_decr: ticks per jiffy = 131246 (787481 ticks)
Console: colour dummy device 80x25
Calibrating delay loop... 1048.57 BogoMIPS
Memory: 255808k available (1812k kernel code, 740k data, 276k init, 0k
highmem)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
