Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JKKJrT002814
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 16:20:20 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JKKIS7006936
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 20:20:18 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <1098216576.29525.178.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com>
	 <1098211939.29525.125.camel@moss-spartans.epoch.ncsc.mil>
	 <20041019120200.D2357@build.pdx.osdl.net>
	 <1098213269.29525.148.camel@moss-spartans.epoch.ncsc.mil>
	 <20041019122034.F2357@build.pdx.osdl.net>
	 <1098216576.29525.178.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 16:17:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 16:09, Stephen Smalley wrote:
> NMI Watchdog detected LOCKUP on CPU1, eip c030f99c, registers:

Sorry, that one wasn't very useful.  Re-tried, got a nicer one.
Not sure why the audit_log_end_irq calls don't show up in the call
trace.

NMI Watchdog detected LOCKUP on CPU0, eip c030f99c, registers:
Modules linked in: md5 ipv6 parport_pc lp parport autofs4 nfs lockd
sunrpc microcode dm_mod button battery ac uhci_hcd ehci_hcd snd_intel8x0
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd
soundcore e1000 floppy ext3 jbd
CPU:    0
EIP:    0060:[<c030f99c>]    Not tainted VLI
EFLAGS: 00000086   (2.6.9-selinux1)
EIP is at _spin_lock+0x1c/0x50
eax: c1810060   ebx: c1810060   ecx: 00000000   edx: f7a67e48
esi: c1810060   edi: f7f45630   ebp: f7a67df8   esp: f7a67dec
ds: 007b   es: 007b   ss: 0068
Process source (pid: 3589, threadinfo=f7a67000 task=f78d8d70)
Stack: ffffffff fffffffd c03fe100 f7a67e10 c0120806 f7a67e48 f7a67000
00000046
       00000001 f7a67e58 c0120ed1 c0141faf f7a67e50 f7a67e4c c032d4a9
000002ab
       f7d92800 00000000 f7a67e3c c0142025 00000000 0000000f f7f45630
00000086
Call Trace:
 [<c0108e5a>] show_stack+0x7a/0x90
 [<c0108fe2>] show_registers+0x152/0x1d0
 [<c0109cf0>] die_nmi+0x50/0x80
 [<c011c2f7>] nmi_watchdog_tick+0x97/0xc0
 [<c0109d80>] default_do_nmi+0x60/0x100
 [<c0109e6f>] do_nmi+0x3f/0x50
 [<c0108b51>] nmi_stack_correct+0x1e/0x2e
 [<c0120806>] task_rq_lock+0x36/0x70
 [<c0120ed1>] try_to_wake_up+0x21/0x2a0
 [<c012b72d>] __tasklet_schedule+0x7d/0x80
 [<c01b8a5b>] avc_audit_helper+0x14b/0xb90
 [<c01b9513>] avc_audit_irq+0x33/0x40
 [<c01b9e0a>] avc_has_perm_irq+0x5a/0x69
 [<c01be630>] selinux_task_setscheduler+0x40/0x50
 [<c0122fd6>] setscheduler+0x126/0x220
 [<c0107f11>] sysenter_past_esp+0x52/0x71
Code: 5d 89 c8 c3 8d 74 26 00 8d bc 27 00 00 00 00 55 89 e5 53 83 ec 08
89 c3 81 78 04 ad 4e ad de 75 14 f0 fe 0b 79 09 f3 90 80 3b 00 <7e> f9
eb f2 83 c4 08 5b 5d c3 c7 04 24 f3 4e 32 c0 8b 45 04 89
console shuts up ...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
