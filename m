Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9JKCurT002714
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 16:12:56 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9JKBgvJ015556
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2004 20:11:42 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <20041019122034.F2357@build.pdx.osdl.net>
References: 
	 <Xine.LNX.4.44.0410191435350.29385-100000@thoron.boston.redhat.com>
	 <1098211939.29525.125.camel@moss-spartans.epoch.ncsc.mil>
	 <20041019120200.D2357@build.pdx.osdl.net>
	 <1098213269.29525.148.camel@moss-spartans.epoch.ncsc.mil>
	 <20041019122034.F2357@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1098216576.29525.178.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 16:09:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-19 at 15:20, Chris Wright wrote:
> > Not on this particular machine; NMI not supported for it.  Migrating to
> > different hardware to re-test.
> 
> Thanks, I had same problem (NMI not supported).

NMI Watchdog detected LOCKUP on CPU1, eip c030f99c, registers:
Modules linked in: md5 ipv6 parport_pc lp parport autofs4 nfs lockd sunrpc micro code dm_mod button battery ac uhci_hcd ehci_hcd snd_intel8x0 snd_ac97_codec snd_ pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore e1000 floppy ext3 jbd
CPU:    1
EIP:    0060:[<c030f99c>]    Not tainted VLI
EFLAGS: 00000086   (2.6.9-selinux1)
EIP is at _spin_lock+0x1c/0x50
eax: c1810060   ebx: c1810060   ecx: 00000000   edx: c1818060
esi: c1818060   edi: c18189c0   ebp: f70cfdf8   esp: f70cfdec
ds: 007b   es: 007b   ss: 0068
Process sshd (pid: 3325, threadinfo=f70cf000 task=c1a76890)
Stack: 00000020 c1810060 c1810060 f70cfe08 c012186b c1810060 c1818060 f70cfe34
       c0122314 00000002 00000065 00000001 00000000 00000001 00000001 c18189c0
       01419f60 799ab680 f70cfea4 c030ece0 c01483c7 00000001 c0363480 00000282
Call Trace:
 [<c0108e5a>] show_stack+0x7a/0x90
 [<c0108fe2>] show_registers+0x152/0x1d0
 [<c0109cf0>] die_nmi+0x50/0x80
 [<c011c2f7>] nmi_watchdog_tick+0x97/0xc0
 [<c0109d80>] default_do_nmi+0x60/0x100
 [<c0109e6f>] do_nmi+0x3f/0x50
 [<c0108b51>] nmi_stack_correct+0x1e/0x2e
 [<c012186b>] double_lock_balance+0x3b/0x50
 [<c0122314>] load_balance_newidle+0x54/0x90
 [<c030ece0>] schedule+0x760/0xb70
 [<c030f557>] schedule_timeout+0x67/0xc0
 [<c0176ada>] do_select+0x26a/0x2a0
 [<c0176d81>] sys_select+0x241/0x4f0
 [<c0107f11>] sysenter_past_esp+0x52/0x71
Code: 5d 89 c8 c3 8d 74 26 00 8d bc 27 00 00 00 00 55 89 e5 53 83 ec 08 89 c3 81  78 04 ad 4e ad de 75 14 f0 fe 0b 79 09 f3 90 80 3b 00 <7e> f9 eb f2 83 c4 08 5b  5d c3 c7 04 24 f3 4e 32 c0 8b 45 04 89
console shuts up ...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
