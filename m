Subject: Re: [PATCH] SELinux: requesting no permissions in
	avc_has_perm_noaudit is a BUG()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1205284238.5297.142.camel@localhost.localdomain>
References: <1205259574.5297.107.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0803120916170.21778@us.intercode.com.au>
	 <Xine.LNX.4.64.0803120924590.26039@us.intercode.com.au>
	 <1205284238.5297.142.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 09:05:19 -0400
Message-Id: <1205327119.23866.221.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 21:10 -0400, Eric Paris wrote:
> On Wed, 2008-03-12 at 09:26 +1100, James Morris wrote:
> > On Wed, 12 Mar 2008, James Morris wrote:
> > 
> > > Applied to 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm
> > 
> > Just saw this during boot.
> > 
> > [    8.238863] ------------[ cut here ]------------
> > [    8.239762] kernel BUG at security/selinux/avc.c:874!
> > [    8.239762] invalid opcode: 0000 [1] SMP 
> > [    8.239762] CPU 2 
> > [    8.239762] Modules linked in: ipv6 cpufreq_ondemand acpi_cpufreq freq_table dm_mirror dm_multipath kvm_intel kvm rtc
> > _cmos rtc_core serio_raw pcspkr rtc_lib e1000e button pata_acpi [last unloaded: microcode]
> > [    8.239762] Pid: 1795, comm: mdadm Not tainted 2.6.25-rc4 #19
> > [    8.239762] RIP: 0010:[<ffffffff80319c4c>]  [<ffffffff80319c4c>] avc_has_perm_noaudit+0x31/0x43c
> > [    8.239762] RSP: 0018:ffff81007ad3dc28  EFLAGS: 00010246
> > [    8.239762] RAX: ffff81007ad3dd58 RBX: 000000000000000a RCX: 0000000000000000
> > [    8.239762] RDX: 000000000000000a RSI: 000000000000001b RDI: 000000000000007a
> > [    8.239762] RBP: ffff81007ad3dcc8 R08: 0000000000000000 R09: ffff81007ad3dcf8
> > [    8.239762] R10: ffff81007ad3dbd4 R11: 0000000000000246 R12: ffff81007dc1e170
> > [    8.239762] R13: 000000000000001b R14: 000000000000001b R15: 000000000000007a
> > [    8.239762] FS:  00007fc4cfc1c6f0(0000) GS:ffff81007f8dd768(0000) knlGS:0000000000000000
> > [    8.239762] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> > [    8.239762] CR2: 00000000004239b7 CR3: 000000007adb8000 CR4: 00000000000026e0
> > [    8.239762] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    8.239762] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > [    8.239762] Process mdadm (pid: 1795, threadinfo ffff81007ad3c000, task ffff81007ba3a180)
> > [    8.239762] Stack:  ffff81007ad3dca8 ffff81007ad3dcf8 000000007ad3dcb8 ffff810000000000
> > [    8.239762]  ffff81007ad3dc68 0000007a802a54cd ffffffffffffffff ffffffef00000000
> > [    8.239762]  ffff810000000001 ffffffff802a7e65 ffff81007f81c168 ffff81007ad3dcb8
> > [    8.239762] Call Trace:
> > [    8.239762]  [<ffffffff802a7e65>] ? link_path_walk+0xbd/0xcd
> > [    8.239762]  [<ffffffff8031ab34>] avc_has_perm+0x2e/0x5e
> > [    8.239762]  [<ffffffff8031b9ca>] inode_has_perm+0x6b/0x7a
> > [    8.239762]  [<ffffffff8031f242>] selinux_dentry_open+0x6a/0x73
> > [    8.239762]  [<ffffffff8031742e>] security_dentry_open+0x11/0x13
> > [    8.239762]  [<ffffffff8029c69a>] __dentry_open+0xce/0x1d3
> > [    8.239762]  [<ffffffff8029c838>] nameidata_to_filp+0x2e/0x40
> > [    8.239762]  [<ffffffff8029c880>] do_filp_open+0x36/0x46
> > [    8.239762]  [<ffffffff804a9da3>] ? _spin_unlock+0x26/0x2a
> > [    8.239762]  [<ffffffff8029c5b1>] ? get_unused_fd_flags+0x113/0x121
> > [    8.239762]  [<ffffffff8029c8e1>] do_sys_open+0x51/0xd2
> > [    8.239762]  [<ffffffff8029c98b>] sys_open+0x1b/0x1d
> > [    8.239762]  [<ffffffff8020bf7b>] system_call_after_swapgs+0x7b/0x80
> > [    8.239762] 
> > [    8.239762] 
> > [    8.239762] Code: 41 89 ff 41 56 41 89 f6 41 55 41 54 53 89 d3 48 83 ec 78 89 8d 78 ff ff ff 44 89 85 74 ff ff ff 4c 89 8d 68 ff ff ff 85 c9 75 04 <0f> 0b eb fe b9 02 00 00 00 31 d2 49 c7 c1 50 9c 31 80 41 b8 01 
> > [    8.239762] RIP  [<ffffffff80319c4c>] avc_has_perm_noaudit+0x31/0x43c
> > [    8.239762]  RSP <ffff81007ad3dc28>
> > [    8.239769] ---[ end trace ca143223eefdc828 ]---
> 
> 
> How the heck does mdadm call sys_open without read or write?

Indeed - that is a bug.

And without Eric's patch, it should have been turned into a denial for
the existing code, so it would have failed, just not as spectacularly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
