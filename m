Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5P5b84i021144
 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2014 01:37:09 -0400
Received: from athena.localnet (unknown [10.10.10.1])
 by smtp.sws.net.au (Postfix) with ESMTP id ACEC020D38
 for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2014 15:37:06 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
To: SELinux <selinux@tycho.nsa.gov>
Subject: strange AVC message
Date: Wed, 25 Jun 2014 15:37:05 +1000
Message-ID: <1819763.ezDbQfm0U1@russell.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Reply-To: russell@coker.com.au
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

[  224.130031] audit: type=1400 audit(1403673275.109:5): avc:  denied  { 
0x800000 } for  pid=2112 comm="systemd-udevd" name="cpufreq" dev="dm-0" 
ino=3357 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 
tcontext=system_u:object_r:unlabeled_t:s0 tclass=file

I'm occasionally seeing messages like the above after booting the Debian 
kernel 3.14.7 with BTRFS for the root filesystem.  By "like the above" I mean 
it refers to a (somewhat random) directory under /lib/modules with a tcontext 
of unlabeled_t being accessed by systemd-udevd.

/backup/2014-06-23/lib/modules/3.14-1-amd64/kernel/drivers/cpufreq
/lib/modules/3.14-1-amd64/kernel/drivers/cpufreq

The inum 3357 matches the above two files where /backup/2014-06-23 is a 
subvolume that is a snapshot of / .  The latter file name has the correct 
context while the former is unlabeled_t.

[  197.649359] audit: type=1400 audit(1403674422.633:4): avc:  denied  { 
0x800000 } for  pid=2101 comm="systemd-udevd" name="pci" dev="dm-0" ino=3387 
scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 
tcontext=system_u:object_r:unlabeled_t:s0 tclass=file

As a test I deleted all snapshots and rebooted a couple of times, then I saw 
the above message.

Note that I can't rule out the possibility of a BTRFS bug.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
