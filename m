Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1IE4lEA022267
 for <selinux@tycho.nsa.gov>; Thu, 18 Feb 2016 09:04:48 -0500
Received: by mail-vk0-f47.google.com with SMTP id k196so45320869vka.0
 for <selinux@tycho.nsa.gov>; Thu, 18 Feb 2016 06:04:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56C5CCCF.4000400@tycho.nsa.gov>
References: <1455793448-26143-1-git-send-email-agruenba@redhat.com>
 <56C5CCCF.4000400@tycho.nsa.gov>
Date: Thu, 18 Feb 2016 15:04:45 +0100
Message-ID: <CAHc6FU6Yc832oQTcd7XsAJ5v=-0t46pJB6bL-OYQp7Gf9WFy-w@mail.gmail.com>
Subject: Re: [PATCH] selinux: Don't sleep inside inode_getsecid hook
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 18, 2016 at 2:53 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 02/18/2016 06:04 AM, Andreas Gruenbacher wrote:
>>
>> The inode_getsecid hook is called from contexts in which sleeping is not
>> allowed, so we cannot revalidate inode security labels from there. Use
>> the non-validating version of inode_security() instead.
>>
>> Reported-by: Benjamin Coddington <bcodding@redhat.com>
>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
>
> Offending caller is ima_match_rules?

The bug that Ben ran into was:

BUG: sleeping function called from invalid context at
security/selinux/hooks.c:260
 in_atomic(): 1, irqs_disabled(): 0, pid: 990, name: nfsd
 2 locks held by nfsd/990:
  #0:  (&u->readlock){+.+.+.}, at: [<ffffffff817eed53>]
unix_stream_sendpage+0x133/0x3c0
  #1:  (&(&u->lock)->rlock){+.+...}, at: [<ffffffff817eed75>]
unix_stream_sendpage+0x155/0x3c0
 CPU: 0 PID: 990 Comm: nfsd Tainted: G            E
4.5.0-rc4.deferred_unlock_v5 #30
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.7.5-20140709_153950- 04/01/2014
  0000000000000000 ffff880079153540 ffffffff813f6a83 ffff88007a8c5b00
  ffffffff81cee038 ffff880079153568 ffffffff810cf899 ffffffff81cee038
  0000000000000104 0000000000000000 ffff880079153590 ffffffff810cf999
Call Trace:
  [<ffffffff813f6a83>] dump_stack+0x85/0xc2
  [<ffffffff810cf899>] ___might_sleep+0x179/0x230
  [<ffffffff810cf999>] __might_sleep+0x49/0x80
  [<ffffffff8137d51c>] __inode_security_revalidate+0x4c/0x70
  [<ffffffff8137debc>] selinux_socket_getpeersec_dgram+0x5c/0xb0
  [<ffffffff813705e8>] security_socket_getpeersec_dgram+0x48/0x60
  [<ffffffff817ecb99>] maybe_init_creds+0x69/0x110
  [<ffffffff817eedad>] unix_stream_sendpage+0x18d/0x3c0
  [<ffffffff817eec20>] ? unix_release+0x30/0x30
  [<ffffffffa00820e5>] xs_sendpages+0x195/0x1e0 [sunrpc]
  [<ffffffffa0083ce1>] xs_local_send_request+0x61/0x160 [sunrpc]
  [<ffffffffa007fbdd>] xprt_transmit+0x6d/0x3d0 [sunrpc]
  [<ffffffffa007a019>] call_transmit+0x1b9/0x2a0 [sunrpc]
  [<ffffffffa0079e60>] ? call_connect_status+0x1f0/0x1f0 [sunrpc]
  [<ffffffffa0079e60>] ? call_connect_status+0x1f0/0x1f0 [sunrpc]
  [<ffffffffa0087061>] __rpc_execute+0xb1/0x550 [sunrpc]
  [<ffffffff810f2945>] ? wake_up_bit+0x25/0x30
  [<ffffffffa008a779>] rpc_execute+0x89/0x140 [sunrpc]
  [<ffffffffa007d550>] rpc_run_task+0x70/0x90 [sunrpc]
  [<ffffffffa007d5b3>] rpc_call_sync+0x43/0xb0 [sunrpc]
  [<ffffffffa0158efa>] gssp_accept_sec_context_upcall+0x21a/0x5a0 [auth_rpcgss]
  [<ffffffffa0158e23>] ? gssp_accept_sec_context_upcall+0x143/0x5a0
[auth_rpcgss]
  [<ffffffffa015a69a>] svcauth_gss_proxy_init+0xeb/0x1e7 [auth_rpcgss]
  [<ffffffffa0157bfa>] svcauth_gss_accept+0x57a/0xc90 [auth_rpcgss]
  [<ffffffffa0157bfa>] ? svcauth_gss_accept+0x57a/0xc90 [auth_rpcgss]
  [<ffffffffa0157b23>] ? svcauth_gss_accept+0x4a3/0xc90 [auth_rpcgss]
  [<ffffffff810f97e9>] ? __lock_is_held+0x49/0x70
  [<ffffffffa00917ea>] ? svc_authenticate+0xaa/0x100 [sunrpc]
  [<ffffffffa0091837>] svc_authenticate+0xf7/0x100 [sunrpc]
  [<ffffffffa008dd77>] svc_process_common+0x207/0x650 [sunrpc]
  [<ffffffffa008e2ee>] svc_process+0x12e/0x2e0 [sunrpc]
  [<ffffffffa00d57e9>] nfsd+0x199/0x2b0 [nfsd]
  [<ffffffffa00d5655>] ? nfsd+0x5/0x2b0 [nfsd]
  [<ffffffffa00d5650>] ? nfsd_destroy+0x190/0x190 [nfsd]
  [<ffffffff810c8aaf>] kthread+0xef/0x110
  [<ffffffff810c89c0>] ? kthread_create_on_node+0x200/0x200
  [<ffffffff8185d1df>] ret_from_fork+0x3f/0x70
  [<ffffffff810c89c0>] ? kthread_create_on_node+0x200/0x200

Andreas
