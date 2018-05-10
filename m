To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
 linux-security-module@vger.kernel.org, netdev <netdev@vger.kernel.org>
References: <1525788303-23244-1-git-send-email-alexey.kodanev@oracle.com>
 <CAHC9VhTACGPt2dSkUN9Efxs-HQVSAsxoiwPxHcujd++O-mMafg@mail.gmail.com>
 <1eb10913-8802-e2dd-68f0-9483435cd949@tycho.nsa.gov>
 <CAHC9VhT1+-ch1Ncv5YCNgu7tPnUj1Qx8S=a=q=Fn=Dwx4SnTKg@mail.gmail.com>
 <7fdbaf13-fea2-4a2c-213d-fa291db67081@tycho.nsa.gov>
 <CAHC9VhTNS-sEL2Az4hs1nmz7naqoyhiohzhPTrqp_M=_Ys1N6A@mail.gmail.com>
 <d637da77-2789-e08b-c78b-b48821cbf0fe@tycho.nsa.gov>
 <CAHC9VhSg9UAmXaK0xsy_h9HfzM4uUBqCNKN5qtf3hHLSi=ZENw@mail.gmail.com>
 <CAHC9VhRmX+Z+ignXXBrSGyUkpxudO76Fv-6o_My=skh-U8Ccgw@mail.gmail.com>
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Message-ID: <aab86e3c-0891-766b-53aa-ad471394ac46@oracle.com>
Date: Thu, 10 May 2018 12:28:57 +0300
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRmX+Z+ignXXBrSGyUkpxudO76Fv-6o_My=skh-U8Ccgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] selinux: add AF_UNSPEC and INADDR_ANY checks to
 selinux_socket_bind()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10.05.2018 01:02, Paul Moore wrote:
...
> I just had a better look at this and I believe that Alexey and Stephen
> are right: this is the best option.  My apologies for the noise
> earlier.  However, while looking at the code I think there are some
> additional necessary changes:
> 
> * In the case of an SCTP socket, we should return -EINVAL, just as we
> do with other address families.

Right.

> * While not strictly related to AF_UNSPEC, we really should be passing
> the address family of the sockaddr, and not the socket, to functions
> that need to interpret the bind address/port.

That looks like a correct solution. I guess we need the same fix for
sctp_connectx(), in selinux_socket_connect_helper().

> 
> I'm waiting for my kernel to compile so I haven't given this any
> sanity testing, but the patch below is what I think we need ...
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4cafe6a19167..5f30045b2053 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4576,6 +4576,7 @@ static int selinux_socket_post_create(struct socket *sock,
> int family,
> static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, i
> nt addrlen)
> {
>        struct sock *sk = sock->sk;
> +       struct sk_security_struct *sksec = sk->sk_security;
>        u16 family;
>        int err;
> 
> @@ -4587,13 +4588,13 @@ static int selinux_socket_bind(struct socket *sock, stru
> ct sockaddr *address, in
>        family = sk->sk_family;
>        if (family == PF_INET || family == PF_INET6) {
>                char *addrp;
> -               struct sk_security_struct *sksec = sk->sk_security;
>                struct common_audit_data ad;
>                struct lsm_network_audit net = {0,};
>                struct sockaddr_in *addr4 = NULL;
>                struct sockaddr_in6 *addr6 = NULL;
>                unsigned short snum;
>                u32 sid, node_perm;
> +               u16 family_sa = address->sa_family;
> 
>                /*
>                 * sctp_bindx(3) calls via selinux_sctp_bind_connect()
> @@ -4601,11 +4602,19 @@ static int selinux_socket_bind(struct socket *sock, stru
> ct sockaddr *address, in
>                 * need to check address->sa_family as it is possible to have
>                 * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
>                 */
> -               switch (address->sa_family) {
> +               switch (family_sa) {
> +               case AF_UNSPEC:
>                case AF_INET:
>                        if (addrlen < sizeof(struct sockaddr_in))
>                                return -EINVAL;
>                        addr4 = (struct sockaddr_in *)address;
> +                       if (family_sa == AF_UNSPEC) {
> +                               /* see "__inet_bind()", we only want to allow
> +                                * AF_UNSPEC if the address is INADDR_ANY */
> +                               if (addr4->sin_addr.s_addr != htonl(INADDR_ANY))
> +                                       goto err_af;
> +                               family_sa = AF_INET;
> +                       }
>                        snum = ntohs(addr4->sin_port);
>                        addrp = (char *)&addr4->sin_addr.s_addr;
>                        break;
> @@ -4617,15 +4626,14 @@ static int selinux_socket_bind(struct socket *sock, stru
> ct sockaddr *address, in
>                        addrp = (char *)&addr6->sin6_addr.s6_addr;
>                        break;
>                default:
> -                       /* Note that SCTP services expect -EINVAL, whereas
> -                        * others expect -EAFNOSUPPORT.
> -                        */
> -                       if (sksec->sclass == SECCLASS_SCTP_SOCKET)
> -                               return -EINVAL;
> -                       else
> -                               return -EAFNOSUPPORT;
> +                       goto err_af;
>                }
> 
> +               ad.type = LSM_AUDIT_DATA_NET;
> +               ad.u.net = &net;
> +               ad.u.net->sport = htons(snum);
> +               ad.u.net->family = family_sa;
> +

May be we could move setting ad.u.net->v{4|6}info.saddr here as well?


Will send a v2 of this patch so that SCTP socket returns EINVAL with
AF_UNSPEC. Should I prepare a patch with correcting 'ad.u.net->family'
and sel_netnode_sid()?  

Thanks,
Alexey

>                if (snum) {
>                        int low, high;
> 
> @@ -4637,10 +4645,6 @@ static int selinux_socket_bind(struct socket *sock, struc
> t sockaddr *address, in
>                                                      snum, &sid);
>                                if (err)
>                                        goto out;
> -                               ad.type = LSM_AUDIT_DATA_NET;
> -                               ad.u.net = &net;
> -                               ad.u.net->sport = htons(snum);
> -                               ad.u.net->family = family;
>                                err = avc_has_perm(&selinux_state,
>                                                   sksec->sid, sid,
>                                                   sksec->sclass,
> @@ -4672,16 +4676,11 @@ static int selinux_socket_bind(struct socket *sock, stru
> ct sockaddr *address, in
>                        break;
>                }
> 
> -               err = sel_netnode_sid(addrp, family, &sid);
> +               err = sel_netnode_sid(addrp, family_sa, &sid);
>                if (err)
>                        goto out;
> 
> -               ad.type = LSM_AUDIT_DATA_NET;
> -               ad.u.net = &net;
> -               ad.u.net->sport = htons(snum);
> -               ad.u.net->family = family;
> -
> -               if (address->sa_family == AF_INET)
> +               if (family_sa == AF_INET)
>                        ad.u.net->v4info.saddr = addr4->sin_addr.s_addr;
>                else
>                        ad.u.net->v6info.saddr = addr6->sin6_addr;
> @@ -4694,6 +4693,12 @@ static int selinux_socket_bind(struct socket *sock, struc
> t sockaddr *address, in
>        }
> out:
>        return err;
> +err_af:
> +       /* Note that SCTP services expect -EINVAL, others -EAFNOSUPPORT. */
> +       if (sksec->sclass == SECCLASS_SCTP_SOCKET)
> +               return -EINVAL;
> +       else
> +               return -EAFNOSUPPORT;
> }
> 
> /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
> 
