Date: Fri, 22 Dec 2017 11:05:17 -0600
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
 <bot+904436b33e141b4f4c57c1ddc94199ffd2e34b9d@syzkaller.appspotmail.com>
Cc: elfring@users.sourceforge.net, eparis@parisplace.org,
 gregkh@linuxfoundation.org, james.l.morris@oracle.com,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, pombredanne@nexb.com, sds@tycho.nsa.gov,
 selinux@tycho.nsa.gov, serge@hallyn.com,
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Message-ID: <20171222170517.GA588@zzz.localdomain>
References: <94eb2c0d010a8dcf040560c0cdf5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <94eb2c0d010a8dcf040560c0cdf5@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference
 in sidtab_search_core
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 19, 2017 at 11:48:02PM -0800, syzbot wrote:
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

The reproducer for this is using AF_ALG and binding to the
"pcrypt(gcm_base(ctr(aes-aesni),ghash-generic))" algorithm, so it's very likely
running into the pcrypt_free() bug which is causing slab cache corruption:

https://groups.google.com/forum/#!topic/syzkaller-bugs/NKn_ivoPOpk

https://patchwork.kernel.org/patch/10126761/

So let's mark it as a duplicate:

#syz dup: KASAN: use-after-free Read in __list_del_entry_valid (2)
