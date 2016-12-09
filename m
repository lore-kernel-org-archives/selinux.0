Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB9Nt1Rt030046
 for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2016 18:55:03 -0500
Received: by mail-ua0-f173.google.com with SMTP id 51so32718951uai.1
 for <selinux@tycho.nsa.gov>; Fri, 09 Dec 2016 15:55:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481233436-18410-1-git-send-email-sds@tycho.nsa.gov>
References: <1481233436-18410-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Dec 2016 18:54:59 -0500
Message-ID: <CAHC9VhRx4RAKd2+mctFyNK0SwQwiB1jsfXows48L2Vn4ReP+=g@mail.gmail.com>
Subject: Re: [PATCH] selinux: handle ICMPv6 consistently with ICMP
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net,
 richard_c_haines@btinternet.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Dec 8, 2016 at 4:43 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit 79c8b348f215 ("selinux: support distinctions among all network
> address families") mapped datagram ICMP sockets to the new icmp_socket
> security class, but left ICMPv6 sockets unchanged.  This change fixes
> that oversight to handle both kinds of sockets consistently.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Merged, thanks for fixing this.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8a90a0b..b508a5a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1295,7 +1295,8 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
>                 case SOCK_DGRAM:
>                         if (default_protocol_dgram(protocol))
>                                 return SECCLASS_UDP_SOCKET;
> -                       else if (extsockclass && protocol == IPPROTO_ICMP)
> +                       else if (extsockclass && (protocol == IPPROTO_ICMP ||
> +                                                 protocol == IPPROTO_ICMPV6))
>                                 return SECCLASS_ICMP_SOCKET;
>                         else
>                                 return SECCLASS_RAWIP_SOCKET;
> --
> 2.7.4
>

-- 
paul moore
www.paul-moore.com
