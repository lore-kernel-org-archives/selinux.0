Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5GN7t8v007148
 for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2015 19:07:56 -0400
Received: by oiyy130 with SMTP id y130so5425508oiy.0
 for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2015 16:07:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434482150-25603-1-git-send-email-sds@tycho.nsa.gov>
References: <1434482150-25603-1-git-send-email-sds@tycho.nsa.gov>
Date: Tue, 16 Jun 2015 19:07:54 -0400
Message-ID: <CAHC9VhSDTHhQKSAiiBHu4wrWrnZH26Q53yLWhUVGobZnH6d3Dg@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/tipc: initialize security state for new
 connection socket
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 16, 2015 at 3:15 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Calling connect() with an AF_TIPC socket would trigger a series
> of error messages from SELinux along the lines of:
> SELinux: Invalid class 0
> type=AVC msg=audit(1434126658.487:34500): avc:  denied  { <unprintable> }
>   for pid=292 comm="kworker/u16:5" scontext=system_u:system_r:kernel_t:s0
>   tcontext=system_u:object_r:unlabeled_t:s0 tclass=<unprintable>
>   permissive=0
>
> This was due to a failure to initialize the security state of the new
> connection sock by the tipc code, leaving it with junk in the security
> class field and an unlabeled secid.  Add a call to security_sk_clone()
> to inherit the security state from the parent socket.
>
> Reported-by: Tim Shearer <tim.shearer@overturenetworks.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Just one small comment about spacing, but it's cosmetic, feel free to
ignore.  See below.

Acked-by: Paul Moore <paul@paul-moore.com>

> ---
>
> This is an RFC before sending this to netdev and the tipc maintainers.
> Under separate cover, I also submitted two patches for selinux that
> should avoid having a sclass of 0 for any sockets (so we will at least
> get printable output and can even work around such denials by allowing
> access to unlabeled_t:socket) and that will BUG_ON if we ever encounter
> a 0 class value again, but this change is still needed to properly label
> the new connection sock with something other than unlabeled.   I am
> not entirely comfortable with the fact that we might need to sprinkle
> these security_sk_clone() calls throughout the various network
> protocol implementations; I think this is a consequence of switching
> from using the socket inode security structure to using the sock security
> structure in the generic socket layer hooks; we could ensure that the
> socket inode security structure was initialized in selinux_socket_accept()
> but cannot do the same for the sock, which is allocated by the network
> protocol implementation, without hooking the network protocol implementations.
> I see no better option, but am open to suggestions.

>From a SELinux perspective I like using the sock security blob over
the inode security blob when we are talking about sockets, however, I
share your frustration about having to instrument the individual
protocols.  Unfortunately, I have yet to think of a better solution
that isn't prone to abuse; if someone else has a good idea, I too
would be very interested in hearing about it.

>  net/tipc/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index 46b6ed5..77cfe3a 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -2008,6 +2008,8 @@ static int tipc_accept(struct socket *sock, struct socket *new_sock, int flags)
>         if (res)
>                 goto exit;

I might remove the vertical space here, between the tipc_sk_create()
error handling and the security_sk_clone() so it lumps the alloc/init
stuff together.

> +       security_sk_clone(sock->sk, new_sock->sk);
> +
>         new_sk = new_sock->sk;
>         new_tsock = tipc_sk(new_sk);
>         msg = buf_msg(buf);

-- 
paul moore
www.paul-moore.com
