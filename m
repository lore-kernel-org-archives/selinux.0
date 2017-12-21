Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBLKfk1L004140
 for <selinux@tycho.nsa.gov>; Thu, 21 Dec 2017 15:41:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3z2k7v6yWnz1pJRj
 for <selinux@tycho.nsa.gov>; Thu, 21 Dec 2017 20:41:31 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3z2k7v5Jc1z1pJFM
 for <selinux@tycho.nsa.gov>; Thu, 21 Dec 2017 20:41:31 +0000 (UTC)
Received: by mail-lf0-f45.google.com with SMTP id r143so29270781lfe.13
 for <selinux@tycho.nsa.gov>; Thu, 21 Dec 2017 12:41:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <94eb2c0d010a8dcf040560c0cdf5@google.com>
References: <94eb2c0d010a8dcf040560c0cdf5@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Dec 2017 15:40:28 -0500
Message-ID: <CAHC9VhT5qK4nUmWo5Pksq0rsxa6Wk7wBEa0Gn41pNx5oS_NDCQ@mail.gmail.com>
To: syzbot
 <bot+904436b33e141b4f4c57c1ddc94199ffd2e34b9d@syzkaller.appspotmail.com>
Cc: elfring@users.sourceforge.net, Eric Paris <eparis@parisplace.org>,
 gregkh@linuxfoundation.org, James Morris <james.l.morris@oracle.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 pombredanne@nexb.com, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Subject: Re: BUG: unable to handle kernel NULL pointer dereference
 in sidtab_search_core
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 20, 2017 at 2:48 AM, syzbot
<bot+904436b33e141b4f4c57c1ddc94199ffd2e34b9d@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
>
>
> SELinux: security_compute_sid:  unrecognized SID 1
> SELinux: security_compute_sid:  unrecognized SID 1
> SELinux: security_compute_sid:  unrecognized SID 1
> SELinux: security_compute_sid:  unrecognized SID 1
> SELinux: security_compute_sid:  unrecognized SID 1
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
> IP: sidtab_search_core+0x88/0x110 security/selinux/ss/sidtab.c:100
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 4252 Comm: kworker/u4:1 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:sidtab_search_core+0x88/0x110 security/selinux/ss/sidtab.c:100
> RSP: 0018:ffffc900028abc18 EFLAGS: 00010293
> RAX: ffff8802131a87c0 RBX: 0000000000000001 RCX: ffffffff8165d978
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff83fd17a0
> RBP: ffffc900028abc40 R08: 0000000000000001 R09: 0000000000000001
> R10: ffffc900028abbe0 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000001 R14: 0000000000000000 R15: ffff880214d93800
> FS:  0000000000000000(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000001 CR3: 0000000214e31000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  sidtab_search+0x1f/0x30 security/selinux/ss/sidtab.c:111
>  security_compute_sid.part.11+0xe2/0x710 security/selinux/ss/services.c:1618
>  security_compute_sid+0x92/0xa0 security/selinux/ss/services.c:1598
>  security_transition_sid+0x57/0x70 security/selinux/ss/services.c:1764
>  selinux_bprm_set_creds+0x215/0x2f0 security/selinux/hooks.c:2423
>  security_bprm_set_creds+0x41/0x60 security/security.c:332
>  prepare_binprm+0xae/0x1f0 fs/exec.c:1561
>  do_execveat_common.isra.30+0x6f7/0xb90 fs/exec.c:1784
>  do_execve+0x31/0x40 fs/exec.c:1848
>  call_usermodehelper_exec_async+0x104/0x190 kernel/umh.c:100
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
> Code: 8b 5b 50 48 85 db 75 e5 e8 e6 c9 c5 ff 49 8b 5f 18 48 85 db 75 10 eb
> 43 e8 d6 c9 c5 ff 48 8b 5b 50 48 85 db 74 35 e8 c8 c9 c5 ff <44> 8b 23 41 83
> fc 02 76 e4 e8 ba c9 c5 ff 41 83 fc 03 75 1c 48
> RIP: sidtab_search_core+0x88/0x110 security/selinux/ss/sidtab.c:100 RSP:
> ffffc900028abc18
> CR2: 0000000000000001
> ---[ end trace 571c0ea6c6959387 ]---
> Kernel panic - not syncing: Fatal exception
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

Based on the reproducer and the stack trace, I'm guessing the system
is attempting to load a kernel module for a a defined, but unloaded,
protocol.  Looking quickly at the SELinux bprm and sidtab code,
nothing obvious is jumping out at me.  Considering the number of false
positives I've been seeing from syzbot lately, I'm assuming this is
more of the same.

> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>
> syzbot will keep track of this bug report.
> Once a fix for this bug is merged into any tree, reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.



-- 
paul moore
www.paul-moore.com
