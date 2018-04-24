Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3OHtxb8023865
 for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2018 13:56:00 -0400
Received: by mail-lf0-f67.google.com with SMTP id v85-v6so50415lfa.13
 for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2018 10:55:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180423133015.5455-3-dh.herrmann@gmail.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
 <20180423133015.5455-3-dh.herrmann@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Apr 2018 13:55:31 -0400
Message-ID: <CAHC9VhSv6tacFb+nEs1cCUOj52Vu+wXD6ZPZ1r1W4pYXo0VJMQ@mail.gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
 teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
 davem@davemloft.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/3] net/unix: hook unix_socketpair() into LSM
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 23, 2018 at 9:30 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Use the newly created LSM-hook for unix_socketpair(). The default hook
> return-value is 0, so behavior stays the same unless LSMs start using
> this hook.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  net/unix/af_unix.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 68bb70a62afe..bc9705ace9b1 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1371,6 +1371,11 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  static int unix_socketpair(struct socket *socka, struct socket *sockb)
>  {
>         struct sock *ska = socka->sk, *skb = sockb->sk;
> +       int err;
> +
> +       err = security_unix_stream_socketpair(ska, skb);
> +       if (err)
> +               return err;

I recognize that AF_UNIX is really the only protocol that supports
socketpair(2) at the moment, but I like to avoid protocol specific LSM
hooks whenever possible.  Unless someone can think of a good
objection, I would prefer to see the hook placed in __sys_socketpair()
instead (and obviously drop the "unix_stream" portion from the hook
name).

>         /* Join our sockets back to back */
>         sock_hold(ska);
> --
> 2.17.0

-- 
paul moore
www.paul-moore.com
