Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB4LQFaf014161
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2013 16:26:21 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
	Wed, 4 Dec 2013 14:26:19 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B0DE23E40026
	for <selinux@tycho.nsa.gov>; Wed,  4 Dec 2013 14:26:16 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rB4JOLiB11206944
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2013 20:24:25 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rB4LQCFr016836
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2013 14:26:12 -0700
Received: from [9.2.54.88] (dhcp-9-2-203-236.watson.ibm.com [9.2.54.88])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id rB4LQCeB016803
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2013 14:26:12 -0700
Message-ID: <1386192372.20519.91.camel@dhcp-9-2-203-236.watson.ibm.com>
Subject: kmemleak: filename_trans_read()?
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: SELinux List <selinux@tycho.nsa.gov>
Date: Wed, 04 Dec 2013 16:26:12 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

After enabling CONFIG_HAVE_DEBUG_KMEMLEAK and CONFIG_DEBUG_KMEMLEAK to
resolve the IMA memory leaks, I'm seeing some SELinux memory leaks.

With SELinux targeted policy enabled (fedora 18 permissive mode?) with a
linux-3.12.2/linux-3.13-rc2, /sys/kernel/debug/kmemleak contains
repeated backtraces for ft, otype, and name, allocated in
filename_trans_read().  I'm not sure why.  The policy is loaded
properly.  If it wasn't, then policydb_destroy() would have called
filenametr_destroy() to free the memory.  Is anyone else seeing this?

Here's an abbreviated /sys/kernel/debug/kmemleak log:

unreferenced object 0xffff8800d7f9daa0 (size 32):
  comm "systemd", pid 1, jiffies 4294669861 (age 7313.936s)
  hex dump (first 32 bytes):
    e2 03 00 00 32 10 00 00 4e 00 00 00 00 00 00 00  ....2...N.......
    d8 5a f6 d7 00 88 ff ff 00 00 00 00 00 00 00 00  .Z..............
  backtrace:
    [<ffffffff816412db>] kmemleak_alloc+0x5b/0xc0
    [<ffffffff81180b27>] kmem_cache_alloc_trace+0xd7/0x230
    [<ffffffff812acfe3>] policydb_read+0xad3/0x11a0
    [<ffffffff812b1bc9>] security_load_policy+0x59/0x530
    [<ffffffff812a4e9c>] sel_write_load+0x9c/0x730
    [<ffffffff8119a635>] vfs_write+0xc5/0x1e0
    [<ffffffff8119ab22>] SyS_write+0x52/0xa0
    [<ffffffff81657992>] system_call_fastpath+0x16/0x1b
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff8800d7f65ad0 (size 8):
  comm "systemd", pid 1, jiffies 4294669861 (age 7313.936s)
  hex dump (first 8 bytes):
    a9 0f 00 00 00 88 ff ff                          ........
  backtrace:
    [<ffffffff816412db>] kmemleak_alloc+0x5b/0xc0
    [<ffffffff81180b27>] kmem_cache_alloc_trace+0xd7/0x230
    [<ffffffff812ad005>] policydb_read+0xaf5/0x11a0
    [<ffffffff812b1bc9>] security_load_policy+0x59/0x530
    [<ffffffff812a4e9c>] sel_write_load+0x9c/0x730
    [<ffffffff8119a635>] vfs_write+0xc5/0x1e0
    [<ffffffff8119ab22>] SyS_write+0x52/0xa0
    [<ffffffff81657992>] system_call_fastpath+0x16/0x1b
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff8800d7f65ad8 (size 8):
  comm "systemd", pid 1, jiffies 4294669861 (age 7313.936s)
  hex dump (first 8 bytes):
    70 67 5f 74 65 6d 70 00                          pg_temp.
  backtrace:
    [<ffffffff816412db>] kmemleak_alloc+0x5b/0xc0
    [<ffffffff811811e8>] __kmalloc+0xe8/0x260
    [<ffffffff812ad040>] policydb_read+0xb30/0x11a0
    [<ffffffff812b1bc9>] security_load_policy+0x59/0x530
    [<ffffffff812a4e9c>] sel_write_load+0x9c/0x730
    [<ffffffff8119a635>] vfs_write+0xc5/0x1e0
    [<ffffffff8119ab22>] SyS_write+0x52/0xa0
    [<ffffffff81657992>] system_call_fastpath+0x16/0x1b
    [<ffffffffffffffff>] 0xffffffffffffffff

$ addr2line -e vmlinux ffffffff812acfe3
/home/zohar/src/kernel/linux-stable/security/selinux/ss/policydb.c:1903
$ addr2line -e vmlinux ffffffff812ad005
/home/zohar/src/kernel/linux-stable/security/selinux/ss/policydb.c:1908
$ addr2line -e vmlinux ffffffff812ad040
/home/zohar/src/kernel/linux-stable/security/selinux/ss/policydb.c:1919

thanks,

Mimi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
