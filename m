Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAU0MsjZ020209
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 19:22:54 -0500
To: James Morris <james.l.morris@oracle.com>, Paul Moore
 <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, LSM <linux-security-module@vger.kernel.org>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
Date: Wed, 29 Nov 2017 16:22:41 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1711292113350.7808@localhost>
Content-Type: text/plain; charset=utf-8
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/29/2017 2:26 AM, James Morris wrote:
> I'm seeing a kernel stack corruption bug (detected via gcc) when running 
> the SELinux testsuite on a 4.15-rc1 kernel, in the 2nd inet_socket test:
>
> https://github.com/SELinuxProject/selinux-testsuite/blob/master/tests/inet_socket/test
>
>   # Verify that unauthorized client cannot communicate with the server.
>   $result = system
>   "runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
>
> This correctlly causes an access control error in the Netlabel code, and 
> the bug seems to be triggered during the ICMP send:
>
> ...<SNIP>...
>
> This is mostly reliable, and I'm only seeing it on bare metal (not in a 
> virtualbox vm).
>
> The SELinux skb parse error at the start only sometimes appears, and 
> looking at the code, I suspect some kind of memory corruption being the 
> cause at that point (basic packet header checks).
>
> I bisected the bug down to the following change:
>
> commit bffa72cf7f9df842f0016ba03586039296b4caaf
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Sep 19 05:14:24 2017 -0700
>
>     net: sk_buff rbnode reorg
>     ...
>
>
> Anyone else able to reproduce this, or have any ideas on what's happening?

I have also bisected a problem to this change. I do not have a trace
because the problem manifests as a hard system hang without a trace
being presented. The issue arises when Smack attempts to relabel a TCP
socket using netlbl_sock_setattr().

I see that there is a proposed fix later in the thread, but I don't see
the patch. Could you send it to me, so I can try it on my problem?

Thank you.

>
>
>
> - James
