Message-ID: <1516383672.2560.23.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 19 Jan 2018 12:41:12 -0500
In-Reply-To: <1516382386.2560.11.camel@tycho.nsa.gov>
References: <20180118215853.228182-1-salyzyn@android.com>
 <1516382386.2560.11.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] general protection fault in sock_has_perm
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2018-01-19 at 12:19 -0500, Stephen Smalley wrote:
> On Thu, 2018-01-18 at 13:58 -0800, Mark Salyzyn wrote:
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 14233 Comm: syz-executor2 Not tainted 4.4.112-g5f6325b
> > #28
> > task: ffff8801d1095f00 task.stack: ffff8800b5950000
> > RIP: 0010:[<ffffffff81b69b7e>]  [<ffffffff81b69b7e>]
> > sock_has_perm+0x1fe/0x3e0 security/selinux/hooks.c:4069
> > RSP: 0018:ffff8800b5957ce0  EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: 1ffff10016b2af9f RCX: ffffffff81b69b51
> > RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000010
> > RBP: ffff8800b5957de0 R08: 0000000000000001 R09: 0000000000000001
> > R10: 0000000000000000 R11: 1ffff10016b2af68 R12: ffff8800b5957db8
> > R13: 0000000000000000 R14: ffff8800b7259f40 R15: 00000000000000d7
> > FS:  00007f72f5ae2700(0000) GS:ffff8801db300000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000a2fa38 CR3: 00000001d7980000 CR4: 0000000000160670
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Stack:
> >  ffffffff81b69a1f ffff8800b5957d58 00008000b5957d30
> > 0000000041b58ab3
> >  ffffffff83fc82f2 ffffffff81b69980 0000000000000246
> > ffff8801d1096770
> >  ffff8801d3165668 ffffffff8157844b ffff8801d1095f00
> >  ffff880000000001
> > Call Trace:
> > [<ffffffff81b6a19d>] selinux_socket_setsockopt+0x4d/0x80
> > security/selinux/hooks.c:4338
> > [<ffffffff81b4873d>] security_socket_setsockopt+0x7d/0xb0
> > security/security.c:1257
> > [<ffffffff82df1ac8>] SYSC_setsockopt net/socket.c:1757 [inline]
> > [<ffffffff82df1ac8>] SyS_setsockopt+0xe8/0x250 net/socket.c:1746
> > [<ffffffff83776499>] entry_SYSCALL_64_fastpath+0x16/0x92
> > Code: c2 42 9b b6 81 be 01 00 00 00 48 c7 c7 a0 cb 2b 84 e8
> > f7 2f 6d ff 49 8d 7d 10 48 b8 00 00 00 00 00 fc ff df 48 89
> > fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 83 01 00
> > 00 41 8b 75 10 31
> > RIP  [<ffffffff81b69b7e>] sock_has_perm+0x1fe/0x3e0
> > security/selinux/hooks.c:4069
> > RSP <ffff8800b5957ce0>
> > ---[ end trace 7b5aaf788fef6174 ]---
> > 
> > In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE
> > socket
> > flag") and all the associated infrastructure changes to take
> > advantage
> > of a RCU grace period before freeing, there is a heightened
> > possibility that a security check is performed while an ill-timed
> > setsockopt call races in from user space.  It then is prudent to
> > null
> > check sk_security, and if the case, reject the permissions.
> > 
> > This adjustment is orthogonal to infrastructure improvements that
> > may
> > nullify the needed check, but should be added as good code hygiene.
> > 
> > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > Cc: Eric Paris <eparis@parisplace.org>
> > Cc: James Morris <james.l.morris@oracle.com>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: selinux@tycho.nsa.gov
> > Cc: linux-security-module@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > ---
> > This patch should be applied to all stable trees (author wants
> > minimum of 3.18, 4.4, 4.9 and 4.14)
> > 
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 8644d864e3c1..95d7c8143373 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4342,7 +4342,7 @@ static int sock_has_perm(struct sock *sk, u32
> > perms)
> >  	struct common_audit_data ad;
> >  	struct lsm_network_audit net = {0,};
> >  
> > -	if (sksec->sid == SECINITSID_KERNEL)
> > +	if (!sksec || sksec->sid == SECINITSID_KERNEL)
> >  		return 0;
> 
> The patch description says "null check the sk_security, and if the
> case, reject the permissions."  The patch code instead has it return
> 0/success, i.e. permission granted.  Which one is correct?  If we
> return -EACCES, then we might break userspace; if we return 0, we
> might
> be allowing an operation that should have been denied.  Both seem
> like
> losing propositions.
> 
> Could we instead have selinux_sk_free_security() defer freeing of the
> sock security blob to a call_rcu(), like we did for
> inode_free_security, or change the caller of it to not free it until
> the sock is truly freed?

On second thought, I don't quite understand the problem you are trying
to solve.  security_sk_free() is only called just prior to freeing the
sock by sk_prot_alloc() or sk_prot_free().  So if sk_security is NULL
in sock_has_perm(), then the sock is itself about to be or already
freed, and it isn't the sk_security that we ought to be worried about -
it is the sock itself that we shouldn't be using.  Or am I missing
something?

If we can't safely dereference the sock in these hooks, then that seems
to point back to the approach used in my original code, where in
ancient history I had sock_has_perm() take the socket and use its inode
i_security field instead of the sock.  commit
253bfae6e0ad97554799affa0266052968a45808 switched them to use the sock
instead.
