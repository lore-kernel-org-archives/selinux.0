Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0CGQ3QF016079
 for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2017 11:26:04 -0500
Received: by mail-ua0-f194.google.com with SMTP id 96so2013303uaq.2
 for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2017 08:26:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484170434-12803-1-git-send-email-sds@tycho.nsa.gov>
References: <1484170434-12803-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Jan 2017 11:26:01 -0500
Message-ID: <CAHC9VhQY5NU_YwHKEz7ymt7jZnEdARrmeS5qRHNVzbcXmikGMQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: drop unused socket security classes
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 11, 2017 at 4:33 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Several of the extended socket classes introduced by
> commit da69a5306ab92e07 ("selinux: support distinctions
> among all network address families") are never used because
> sockets can never be created with the associated address family.
> Remove these unused socket security classes.  The removed classes
> are bridge_socket for PF_BRIDGE, ib_socket for PF_IB, and mpls_socket
> for PF_MPLS.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c            | 6 ------
>  security/selinux/include/classmap.h | 6 ------
>  2 files changed, 12 deletions(-)

Thanks for the follow-up, merged.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 720dbd0..a5398fe 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1353,8 +1353,6 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
>                         return SECCLASS_IPX_SOCKET;
>                 case PF_NETROM:
>                         return SECCLASS_NETROM_SOCKET;
> -               case PF_BRIDGE:
> -                       return SECCLASS_BRIDGE_SOCKET;
>                 case PF_ATMPVC:
>                         return SECCLASS_ATMPVC_SOCKET;
>                 case PF_X25:
> @@ -1373,10 +1371,6 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
>                         return SECCLASS_PPPOX_SOCKET;
>                 case PF_LLC:
>                         return SECCLASS_LLC_SOCKET;
> -               case PF_IB:
> -                       return SECCLASS_IB_SOCKET;
> -               case PF_MPLS:
> -                       return SECCLASS_MPLS_SOCKET;
>                 case PF_CAN:
>                         return SECCLASS_CAN_SOCKET;
>                 case PF_TIPC:
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 0dfd26d..7898ffa 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -183,8 +183,6 @@ struct security_class_mapping secclass_map[] = {
>           { COMMON_SOCK_PERMS, NULL } },
>         { "netrom_socket",
>           { COMMON_SOCK_PERMS, NULL } },
> -       { "bridge_socket",
> -         { COMMON_SOCK_PERMS, NULL } },
>         { "atmpvc_socket",
>           { COMMON_SOCK_PERMS, NULL } },
>         { "x25_socket",
> @@ -203,10 +201,6 @@ struct security_class_mapping secclass_map[] = {
>           { COMMON_SOCK_PERMS, NULL } },
>         { "llc_socket",
>           { COMMON_SOCK_PERMS, NULL } },
> -       { "ib_socket",
> -         { COMMON_SOCK_PERMS, NULL } },
> -       { "mpls_socket",
> -         { COMMON_SOCK_PERMS, NULL } },
>         { "can_socket",
>           { COMMON_SOCK_PERMS, NULL } },
>         { "tipc_socket",
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
