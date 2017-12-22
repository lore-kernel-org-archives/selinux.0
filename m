Date: Fri, 22 Dec 2017 16:14:39 -0600
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
 <bot+d10271989aa91b0c140f6c218c5537f942888ce2@syzkaller.appspotmail.com>
Cc: danielj@mellanox.com, dledford@redhat.com, eparis@parisplace.org,
 james.l.morris@oracle.com, junil0814.lee@lge.com,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 mka@chromium.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 selinux@tycho.nsa.gov, serge@hallyn.com, syzkaller-bugs@googlegroups.com
Message-ID: <20171222221439.GA28786@zzz.localdomain>
References: <001a113f9ae0812d650560f4a1d6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001a113f9ae0812d650560f4a1d6@google.com>
Subject: Re: BUG: unable to handle kernel paging request in
 security_compute_sid
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 22, 2017 at 01:38:01PM -0800, syzbot wrote:
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
> BUG: unable to handle kernel paging request at 00000000830e2118
> IP: security_compute_sid.part.11+0x418/0x710
> security/selinux/ss/services.c:1640
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 3391 Comm: kworker/u4:0 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:security_compute_sid.part.11+0x418/0x710
> security/selinux/ss/services.c:1640
> RSP: 0018:ffffc90001993c70 EFLAGS: 00010293
> RAX: ffff880216ba0800 RBX: 0000000000000002 RCX: ffffffff81667b88
> RDX: 0000000000000000 RSI: 0000000000000005 RDI: ffffffff83fd17a0
> RBP: ffffc90001993d20 R08: 0000000000000001 R09: 0000000000000001
> R10: ffffc90001993be0 R11: 0000000000000000 R12: ffff88021694f188
> R13: 0000000000000010 R14: ffff880216592388 R15: 00000000830e20e0
> FS:  0000000000000000(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000830e2118 CR3: 000000000301e001 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  security_compute_sid+0x92/0xa0 security/selinux/ss/services.c:1598
>  security_transition_sid+0x57/0x70 security/selinux/ss/services.c:1764
>  selinux_bprm_set_creds+0x215/0x2f0 security/selinux/hooks.c:2423
>  security_bprm_set_creds+0x41/0x60 security/security.c:332
>  prepare_binprm+0xae/0x1f0 fs/exec.c:1561
>  do_execveat_common.isra.30+0x6f7/0xb90 fs/exec.c:1784
>  do_execve+0x31/0x40 fs/exec.c:1848
>  call_usermodehelper_exec_async+0x104/0x190 kernel/umh.c:100
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
> Code: 40 74 15 41 83 fd 10 74 0f e8 d5 27 c5 ff 4d 85 ff 75 33 e9 6f 02 00
> 00 e8 c6 27 c5 ff 4d 85 ff 0f 84 e6 02 00 00 e8 b8 27 c5 ff <41> 80 7f 38 02
> 0f 84 5c 01 00 00 e8 a8 27 c5 ff 41 8b 06 89 45
> RIP: security_compute_sid.part.11+0x418/0x710
> security/selinux/ss/services.c:1640 RSP: ffffc90001993c70
> CR2: 00000000830e2118
> ---[ end trace fe59d8175af57ffc ]---
> Kernel panic - not syncing: Fatal exception
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 

This is yet another one where the reproducer is using AF_ALG and binding to the
"pcrypt(gcm_base(ctr(aes-aesni),ghash-generic))" algorithm, so it's running into
the pcrypt_free() bug which is causing slab cache corruption:

https://groups.google.com/forum/#!topic/syzkaller-bugs/NKn_ivoPOpk

https://patchwork.kernel.org/patch/10126761/

So let's mark it as a duplicate:

#syz dup: KASAN: use-after-free Read in __list_del_entry_valid (2)

I wonder if it would be of any help to disable slab cache merging, i.e. set
CONFIG_SLAB_MERGE_DEFAULT=n?  That would reduce the number of duplicate reports,
though perhaps at the risk of hiding bugs.

Eric
