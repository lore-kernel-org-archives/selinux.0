Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB91NoTc009271
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2013 20:25:35 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
	Sun, 8 Dec 2013 18:23:33 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 02ED53E40026
	for <selinux@tycho.nsa.gov>; Sun,  8 Dec 2013 18:23:30 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rB8NLaeG9306568
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2013 00:21:36 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rB91NTkY008651
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2013 18:23:29 -0700
Message-ID: <1386552208.16232.8.camel@dhcp-9-2-203-236.watson.ibm.com>
Subject: Re: kmemleak: filename_trans_read()?
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Eric Paris <eparis@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, SELinux List <selinux@tycho.nsa.gov>
Date: Sun, 08 Dec 2013 20:23:28 -0500
In-Reply-To: <1386546367.19762.3.camel@localhost>
References: <1386192372.20519.91.camel@dhcp-9-2-203-236.watson.ibm.com>
	 <CACLa4ptpQj2NR6f_DnRYnRqpx9mJeFcD8uLGAQ2c=coSCsYwrw@mail.gmail.com>
	 <1534592.gDiucM3RBN@sifl> <1386546367.19762.3.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, 3505 lines of -EEXIST.  

# rpm -qf /etc/selinux/targeted/policy/policy.27
selinux-policy-targeted-3.11.1-106.fc18.noarch

Mimi

On Sun, 2013-12-08 at 18:46 -0500, Eric Paris wrote: 
> Maybe an EEXIST?  ENOMEM seems like something else on the box would
> quickly fail.  These things aren't huge allocations...
> 
> EEXIST should be caught in userspace though and should be an invalid
> policy (as I recall at least)
> 
> Mimi, can you test a kernel that just printk's on failure of that
> function?  Is that easy for you?
> 
> On Fri, 2013-12-06 at 17:54 -0500, Paul Moore wrote:
> > On Friday, December 06, 2013 08:57:51 AM Eric Paris wrote:
> > > Hmmm, it could happen if hashtab_insert failed...
> > > 
> > > I wonder why we don't check the return value there....
> > 
> > I noticed the same thing when Mimi and I were talking about this offline.  
> > Although, I've got to think that if the hash insert operation was failing we 
> > would notice it as the loaded policy would be wonky, wouldn't it?
> > 
> > > On Wed, Dec 4, 2013 at 4:26 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > > > Hi,
> > > > 
> > > > After enabling CONFIG_HAVE_DEBUG_KMEMLEAK and CONFIG_DEBUG_KMEMLEAK to
> > > > resolve the IMA memory leaks, I'm seeing some SELinux memory leaks.
> > > > 
> > > > With SELinux targeted policy enabled (fedora 18 permissive mode?) with a
> > > > linux-3.12.2/linux-3.13-rc2, /sys/kernel/debug/kmemleak contains
> > > > repeated backtraces for ft, otype, and name, allocated in
> > > > filename_trans_read().  I'm not sure why.  The policy is loaded
> > > > properly.  If it wasn't, then policydb_destroy() would have called
> > > > filenametr_destroy() to free the memory.  Is anyone else seeing this?
> > > > 
> > > > Here's an abbreviated /sys/kernel/debug/kmemleak log:
> > > > 
> > > > unreferenced object 0xffff8800d7f9daa0 (size 32):
> > > >   comm "systemd", pid 1, jiffies 4294669861 (age 7313.936s)
> > > >   
> > > >   hex dump (first 32 bytes):
> > > >     e2 03 00 00 32 10 00 00 4e 00 00 00 00 00 00 00  ....2...N.......
> > > >     d8 5a f6 d7 00 88 ff ff 00 00 00 00 00 00 00 00  .Z..............
> > > >   
> > > >   backtrace:
> > > >     [<ffffffff816412db>] kmemleak_alloc+0x5b/0xc0
> > > >     [<ffffffff81180b27>] kmem_cache_alloc_trace+0xd7/0x230
> > > >     [<ffffffff812acfe3>] policydb_read+0xad3/0x11a0
> > > >     [<ffffffff812b1bc9>] security_load_policy+0x59/0x530
> > > >     [<ffffffff812a4e9c>] sel_write_load+0x9c/0x730
> > > >     [<ffffffff8119a635>] vfs_write+0xc5/0x1e0
> > > >     [<ffffffff8119ab22>] SyS_write+0x52/0xa0
> > > >     [<ffffffff81657992>] system_call_fastpath+0x16/0x1b
> > > >     [<ffffffffffffffff>] 0xffffffffffffffff
> > > > 
> > > > unreferenced object 0xffff8800d7f65ad0 (size 8):
> > > >   comm "systemd", pid 1, jiffies 4294669861 (age 7313.936s)
> > > >   
> > > >   hex dump (first 8 bytes):
> > > >     a9 0f 00 00 00 88 ff ff                          ........
> > > >   
> > > >   backtrace:
> > > >     [<ffffffff816412db>] kmemleak_alloc+0x5b/0xc0
> > > >     [<ffffffff81180b27>] kmem_cache_alloc_trace+0xd7/0x230
> > > >     [<ffffffff812ad005>] policydb_read+0xaf5/0x11a0
> > > >     [<ffffffff812b1bc9>] security_load_policy+0x59/0x530
> > > >     [<ffffffff812a4e9c>] sel_write_load+0x9c/0x730
> > > >     [<ffffffff8119a635>] vfs_write+0xc5/0x1e0
> > > >     [<ffffffff8119ab22>] SyS_write+0x52/0xa0
> > > >     [<ffffffff81657992>] system_call_fastpath+0x16/0x1b
> > > >     [<ffffffffffffffff>] 0xffffffffffffffff
> > > > 
> > > > unreferenced object 0xffff8800d7f65ad8 (size 8):
> > > >   comm "systemd", pid 1, jiffies 4294669861 (age 7313.936s)
> > > >   
> > > >   hex dump (first 8 bytes):
> > > >     70 67 5f 74 65 6d 70 00                          pg_temp.
> > > >   
> > > >   backtrace:
> > > >     [<ffffffff816412db>] kmemleak_alloc+0x5b/0xc0
> > > >     [<ffffffff811811e8>] __kmalloc+0xe8/0x260
> > > >     [<ffffffff812ad040>] policydb_read+0xb30/0x11a0
> > > >     [<ffffffff812b1bc9>] security_load_policy+0x59/0x530
> > > >     [<ffffffff812a4e9c>] sel_write_load+0x9c/0x730
> > > >     [<ffffffff8119a635>] vfs_write+0xc5/0x1e0
> > > >     [<ffffffff8119ab22>] SyS_write+0x52/0xa0
> > > >     [<ffffffff81657992>] system_call_fastpath+0x16/0x1b
> > > >     [<ffffffffffffffff>] 0xffffffffffffffff
> > > > 
> > > > $ addr2line -e vmlinux ffffffff812acfe3
> > > > /home/zohar/src/kernel/linux-stable/security/selinux/ss/policydb.c:1903
> > > > $ addr2line -e vmlinux ffffffff812ad005
> > > > /home/zohar/src/kernel/linux-stable/security/selinux/ss/policydb.c:1908
> > > > $ addr2line -e vmlinux ffffffff812ad040
> > > > /home/zohar/src/kernel/linux-stable/security/selinux/ss/policydb.c:1919
> > > > 
> > > > thanks,
> > > > 
> > > > Mimi
> > > > 
> > > > 
> > > > --
> > > > This message was distributed to subscribers of the selinux mailing list.
> > > > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> > > > with the words "unsubscribe selinux" without quotes as the message.
> > > 
> > > --
> > > This message was distributed to subscribers of the selinux mailing list.
> > > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> > > with the words "unsubscribe selinux" without quotes as the message.
> > 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
