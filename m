Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB7NbLCp031627
 for <selinux@tycho.nsa.gov>; Thu, 7 Dec 2017 18:37:21 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 3ytBjC4SQfz2SjHq
 for <selinux@tycho.nsa.gov>; Thu,  7 Dec 2017 23:37:19 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 3ytBjC3dtrz2SjHm
 for <selinux@tycho.nsa.gov>; Thu,  7 Dec 2017 23:37:19 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id j124so10053640lfg.2
 for <selinux@tycho.nsa.gov>; Thu, 07 Dec 2017 15:37:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171206101736.3217-1-richard_c_haines@btinternet.com>
References: <20171206101736.3217-1-richard_c_haines@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Dec 2017 18:37:16 -0500
Message-ID: <CAHC9VhSpDDEUOd2mBQ6DJMXeqW5O6xnxLJgXP-sb-bGu-TrwWw@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, marcelo.leitner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V2] selinux: Add SCTP support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 6, 2017 at 5:17 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> The SELinux SCTP implementation is explained in:
> Documentation/security/SELinux-sctp.rst
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes
> Remove lock from selinux_sctp_assoc_request()
> Fix selinux_sctp_sk_clone() kbuild test robot catch [1]
>
> [1] https://marc.info/?l=selinux&m=151198281817779&w=2
>
>  Documentation/security/SELinux-sctp.rst | 104 ++++++++++++
>  security/selinux/hooks.c                | 270 +++++++++++++++++++++++++++++---
>  security/selinux/include/classmap.h     |   2 +-
>  security/selinux/include/netlabel.h     |  20 ++-
>  security/selinux/include/objsec.h       |   4 +
>  security/selinux/netlabel.c             | 144 +++++++++++++++--
>  6 files changed, 512 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/security/SELinux-sctp.rst

I just went through these patches again, and I think they look pretty
good.  There is one small cosmetic nit (see below), but that should be
a quick fix.

As Dave already said, let's give the SCTP folks some time to look
things over before I merge anything.  If we haven't heard anything by
next week, I'll ping Vlad to see if I can get him to take a look.

> +/**
> + * selinux_netlbl_socket_connect - Label a client-side socket on connect
> + * @sk: the socket to label
> + * @addr: the destination address
> + *
> + * Description:
> + * Attempt to label a connected socket with NetLabel using the given address.
> + * Returns zero values on success, negative values on failure.
> + *
> + */
> +int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr *addr)
> +{
> +       int rc;
> +       struct sk_security_struct *sksec = sk->sk_security;
> +
> +       if (sksec->nlbl_state != NLBL_REQSKB &&
> +           sksec->nlbl_state != NLBL_CONNLABELED)
> +               return 0;
> +
> +       lock_sock(sk);
> +       rc = selinux_netlbl_socket_connect_helper(sk, addr);
>         release_sock(sk);
> +
> +       return rc;
> +}
> +
> +/**
> + * selinux_netlbl_sctp_socket_connect - Label an SCTP client-side socket on a
> + * connect
> + * @sk: the socket to label
> + * @addr: the destination address
> + *
> + * Description:
> + * Attempt to label a connected socket with NetLabel using the given address
> + * when called by the SCTP protocol layer. The situations handled are:
> + * sctp_connectx(3), sctp_sendmsg(3), sendmsg(2), whenever a new IP address
> + * is added or when a new primary address is selected. Note that an SCTP
> + * connect(2) call happens before the SCTP protocol layer and is handled via
> + * selinux_netlbl_socket_connect()
> + * Returns zero values on success, negative values on failure.
> + *
> + */
> +int selinux_netlbl_sctp_socket_connect(struct sock *sk, struct sockaddr *addr)
> +{
> +       int rc;
> +       struct sk_security_struct *sksec = sk->sk_security;
> +
> +       if (sksec->nlbl_state != NLBL_REQSKB &&
> +           sksec->nlbl_state != NLBL_CONNLABELED)
> +               return 0;
> +
> +       rc = selinux_netlbl_socket_connect_helper(sk, addr);
> +
>         return rc;
>  }

My apologies, I should have noticed this sooner ... If the only
difference between selinux_netlbl_socket_connect() and
selinux_netlbl_sctp_socket_connect() is that the SCTP variant takes a
lock, why not simply rename selinux_netlbl_sctp_socket_connect() to
selinux_netlbl_socket_connect_locked()?  There is nothing really SCTP
specific here, aside from the comment header, which should already be
covered elsewhere.

[NOTE TO MYSELF: pick shorter function names next time, oof.]

-- 
paul moore
www.paul-moore.com
