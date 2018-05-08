Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w48H5r9l026343
 for <selinux@tycho.nsa.gov>; Tue, 8 May 2018 13:05:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 40gQqM5VnYz2Sj57
 for <selinux@tycho.nsa.gov>; Tue,  8 May 2018 17:05:51 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 40gQqM1c4Jz2Sj52
 for <selinux@tycho.nsa.gov>; Tue,  8 May 2018 17:05:51 +0000 (UTC)
Received: by mail-lf0-f49.google.com with SMTP id y72-v6so33171833lfd.2
 for <selinux@tycho.nsa.gov>; Tue, 08 May 2018 10:05:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525788303-23244-1-git-send-email-alexey.kodanev@oracle.com>
References: <1525788303-23244-1-git-send-email-alexey.kodanev@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 May 2018 13:05:48 -0400
Message-ID: <CAHC9VhTACGPt2dSkUN9Efxs-HQVSAsxoiwPxHcujd++O-mMafg@mail.gmail.com>
To: Alexey Kodanev <alexey.kodanev@oracle.com>,
 Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 linux-security-module@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: add AF_UNSPEC and INADDR_ANY checks to
 selinux_socket_bind()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 8, 2018 at 10:05 AM, Alexey Kodanev
<alexey.kodanev@oracle.com> wrote:
> Commit d452930fd3b9 ("selinux: Add SCTP support") breaks compatibility
> with the old programs that can pass sockaddr_in with AF_UNSPEC and
> INADDR_ANY to bind(). As a result, bind() returns EAFNOSUPPORT error.
> It was found with LTP/asapi_01 test.
>
> Similar to commit 29c486df6a20 ("net: ipv4: relax AF_INET check in
> bind()"), which relaxed AF_INET check for compatibility, add AF_UNSPEC
> case to AF_INET and make sure that the address is INADDR_ANY.
>
> Also, in the end of selinux_socket_bind(), instead of adding AF_UNSPEC
> to 'address->sa_family == AF_INET', verify AF_INET6 first.
>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  security/selinux/hooks.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Thanks for finding and reporting this regression.

I think I would prefer to avoid having to duplicate the
AF_UNSPEC/INADDR_ANY checking logic in the SELinux hook, even though
it is a small bit of code and unlikely to change.  I'm wondering if it
would be better to check both the socket and sockaddr address family
in the main if conditional inside selinux_socket_bind(), what do you
think?  Another option would be to go back to just checking the
soackaddr address family; we moved away from that for a reason which
escapes at the moment (code cleanliness?), but perhaps that was a
mistake.

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a19167..a3789b167667 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4577,6 +4577,7 @@ static int selinux_socket_bind(struct socket *sock, struc>
{
       struct sock *sk = sock->sk;
       u16 family;
+       u16 family_sa;
       int err;

       err = sock_has_perm(sk, SOCKET__BIND);
@@ -4585,7 +4586,9 @@ static int selinux_socket_bind(struct socket *sock, struc>

       /* If PF_INET or PF_INET6, check name_bind permission for the port. */
       family = sk->sk_family;
-       if (family == PF_INET || family == PF_INET6) {
+       family_sa = address->sa_family;
+       if ((family == PF_INET || family == PF_INET6) &&
+           (family_sa == PF_INET || family_sa == PF_INET6)) {
               char *addrp;
               struct sk_security_struct *sksec = sk->sk_security;
               struct common_audit_data ad;
@@ -4601,7 +4604,7 @@ static int selinux_socket_bind(struct socket *sock, struc>
                * need to check address->sa_family as it is possible to have
                * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
                */
-               switch (address->sa_family) {
+               switch (family_sa) {
               case AF_INET:
                       if (addrlen < sizeof(struct sockaddr_in))
                               return -EINVAL;

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4cafe6a..649a3be 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4602,10 +4602,16 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>                  * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
>                  */
>                 switch (address->sa_family) {
> +               case AF_UNSPEC:
>                 case AF_INET:
>                         if (addrlen < sizeof(struct sockaddr_in))
>                                 return -EINVAL;
>                         addr4 = (struct sockaddr_in *)address;
> +
> +                       if (address->sa_family == AF_UNSPEC &&
> +                           addr4->sin_addr.s_addr != htonl(INADDR_ANY))
> +                               return -EAFNOSUPPORT;
> +
>                         snum = ntohs(addr4->sin_port);
>                         addrp = (char *)&addr4->sin_addr.s_addr;
>                         break;
> @@ -4681,10 +4687,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>                 ad.u.net->sport = htons(snum);
>                 ad.u.net->family = family;
>
> -               if (address->sa_family == AF_INET)
> -                       ad.u.net->v4info.saddr = addr4->sin_addr.s_addr;
> -               else
> +               if (address->sa_family == AF_INET6)
>                         ad.u.net->v6info.saddr = addr6->sin6_addr;
> +               else
> +                       ad.u.net->v4info.saddr = addr4->sin_addr.s_addr;
>
>                 err = avc_has_perm(&selinux_state,
>                                    sksec->sid, sid,
> --
> 1.8.3.1
>

-- 
paul moore
www.paul-moore.com
