Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p649LYMR019289
	for <selinux@tycho.nsa.gov>; Mon, 4 Jul 2011 05:21:41 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p649LWVp005130
	for <selinux@tycho.nsa.gov>; Mon, 4 Jul 2011 09:21:33 GMT
Received: by iwn37 with SMTP id 37so5518291iwn.12
        for <selinux@tycho.nsa.gov>; Mon, 04 Jul 2011 02:21:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1309346239.4648.23.camel@mattotaupa>
References: <1309346239.4648.23.camel@mattotaupa>
Date: Mon, 4 Jul 2011 05:21:31 -0400
Message-ID: <CACLa4psPMHy86CwM3-yHdF4UCE8j0sQHSDE7hF3QkS6Fgao=Bg@mail.gmail.com>
Subject: Re: Linux kernel 2.6.32 from Debian Squeeze and Xen: SELinux seems to
 hang around 10 minutes during boot
From: Eric Paris <eparis@parisplace.org>
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 29, 2011 at 7:17 AM, Paul Menzel
<paulepanter@users.sourceforge.net> wrote:
> Dear SELinux folks,
>
>
> I hope this is the correct list for users to report problems.
>
> Running a Xen dom0 with Debian Squeeze with
>
>        ii  linux-image-2.6.32-5-xen-amd64          2.6.32-35                    Linux 2.6.32 for 64-bit PCs, Xen dom0 support
>
> and passing `selinux=1` (from `/proc/cmdline`) to the command line the boot hangs for around ten minutes.
>
> `dmesg` has the following messages.
>
>        […]
>        [    2.204014] Calibrating delay loop (skipped), value calculated using timer frequency.. 5346.75 BogoMIPS (lpj=10693504)
>        [    2.204026] Security Framework initialized
>        [    2.204031] SELinux:  Initializing.
>        [    2.204037] SELinux:  Starting in permissive mode
>        [    2.205178] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
>        [    2.207298] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
>        [    2.208088] Mount-cache hash table entries: 256
>        [    2.208212] Initializing cgroup subsys ns
>        [    2.208215] Initializing cgroup subsys cpuacct
>        [    2.208219] Initializing cgroup subsys devices
>        [    2.208222] Initializing cgroup subsys freezer
>        [    2.208224] Initializing cgroup subsys net_cls
>        [    2.208255] CPU: L1 I cache: 32K, L1 D cache: 32K
>        [    2.208257] CPU: L2 cache: 256K
>        [    2.208258] CPU: L3 cache: 8192K
>        [    2.208262] CPU 0/0x0 -> Node 0
>        [    2.208264] CPU: Unsupported number of siblings 16
>        [    2.208267] mce: CPU supports 9 MCE banks
>        [    2.208288] Performance Events: unsupported p6 CPU model 26 no PMU driver, software events only.
>        [    2.208300] SMP alternatives: switching to UP code
>        [    2.229476] ACPI: Core revision 20090903
>        [    2.260346]   alloc irq_desc for 2302 on node -1
>        [    2.260348]   alloc kstat_irqs on node -1
>        [    2.260355]   alloc irq_desc for 2301 on node -1
>        [    2.260357]   alloc kstat_irqs on node -1
>        [    2.260361]   alloc irq_desc for 2300 on node -1
>        [    2.260362]   alloc kstat_irqs on node -1
>        [    2.260366]   alloc irq_desc for 2299 on node -1
>        [    2.260367]   alloc kstat_irqs on node -1
>        [    2.260512] installing Xen timer for CPU 1
>        [    2.260515]   alloc irq_desc for 2298 on node -1
>        [    2.260517]   alloc kstat_irqs on node -1
>        [    2.260538] SMP alternatives: switching to SMP code
>        […]
>        [    2.427623] msgmni has been set to 13460
>        [    2.427689] SELinux:  Registering netfilter hooks
>        [    2.428038] alg: No test for stdrng (krng)
>        [    2.428087] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
>        […]
>        [    9.023551] type=1404 audit(1309247866.082:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
>        [    9.137904] SELinux: 8192 avtab hash slots, 26860 rules.
>        [    9.142904] SELinux: 8192 avtab hash slots, 26860 rules.
>        [    9.143463] SELinux:  6 users, 6 roles, 1240 types, 38 bools, 1 sens, 1024 cats
>        [    9.143466] SELinux:  77 classes, 26860 rules
>        [    9.144719] SELinux:  Completing initialization.
>        [    9.144721] SELinux:  Setting up existing superblocks.
>        [    9.144859] SELinux: initialized (dev md0, type ext3), uses xattr
>        [    9.144936] SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
>        [    9.144942] SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
>        [    9.144951] SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
>        [    9.144956] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition SIDs
>        [    9.144960] SELinux: initialized (dev devpts, type devpts), uses transition SIDs
>        [    9.144965] SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
>        [    9.144969] SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts
>        [    9.144971] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
>        [    9.144975] SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
>        [    9.145038] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
>        [    9.145041] SELinux: initialized (dev devtmpfs, type devtmpfs), uses transition SIDs
>        [    9.145379] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
>        [    9.145385] SELinux: initialized (dev proc, type proc), uses genfs_contexts
>        [    9.145391] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
>        [    9.145394] SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
>        [    9.145397] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
>        [    9.235165] type=1403 audit(1309247866.294:3): policy loaded auid=4294967295 ses=4294967295
>        [    9.538501] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
>        [    9.893428] udev[445]: starting version 164
>        [   10.253325] ACPI: WMI: Mapper loaded
>        […]
>        [   11.034386] No connectors reported connected with modes
>        [   11.034392] [drm] Initialized nouveau 0.0.15 20090420 for 0000:02:00.0 on minor 0
>        [   11.099470] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
>        [  624.864340] Adding 1048568k swap on /dev/mapper/xkcd-dom0--swap.  Priority:-1 extents:1 across:1048568k
>        […]

I'm sorry to say, nothing about this leads me to believe that this is
a kernel or selinux problem.  In the kernel the time consuming thing
about SELinux (loading the policy) finished at 9.023551.  Starting
swap is something userspace does, which means that something in
userspace (which obviously wouldn't show up in dmesg, but might show
up on the console or in the messages log) is most likely reason for
the hang.  I'd look at userspace messages to look for the hangup
rather than the kernel an SELinux...    I could be wrong, but nothing
in this particular log looks like SELinux is causing your hangups.....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
