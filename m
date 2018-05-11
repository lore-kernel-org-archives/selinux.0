Message-ID: <1526068608.27442.3.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Alexey Kodanev <alexey.kodanev@oracle.com>, selinux@tycho.nsa.gov
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 linux-security-module@vger.kernel.org, netdev <netdev@vger.kernel.org>
Date: Fri, 11 May 2018 20:56:48 +0100
In-Reply-To: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/3] selinux: add AF_UNSPEC and INADDR_ANY
 checks to selinux_socket_bind()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2018-05-11 at 20:15 +0300, Alexey Kodanev wrote:
> Commit d452930fd3b9 ("selinux: Add SCTP support") breaks
> compatibility
> with the old programs that can pass sockaddr_in structure with
> AF_UNSPEC
> and INADDR_ANY to bind(). As a result, bind() returns EAFNOSUPPORT
> error.
> This was found with LTP/asapi_01 test.
> 
> Similar to commit 29c486df6a20 ("net: ipv4: relax AF_INET check in
> bind()"), which relaxed AF_INET check for compatibility, add
> AF_UNSPEC
> case to AF_INET and make sure that the address is INADDR_ANY.
> 
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> 
> v2: As suggested by Paul:
>     * return EINVAL for SCTP socket if sa_family is AF_UNSPEC and
>       address is not INADDR_ANY
>     * add new 'sa_family' variable so that it equals either AF_INET
>       or AF_INET6. Besides, it it will be used in the next patch that
>       fixes audit record.
> 
>  security/selinux/hooks.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4cafe6a..1ed7004 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4576,6 +4576,7 @@ static int selinux_socket_post_create(struct
> socket *sock, int family,
>  static int selinux_socket_bind(struct socket *sock, struct sockaddr
> *address, int addrlen)
>  {
>  	struct sock *sk = sock->sk;
> +	struct sk_security_struct *sksec = sk->sk_security;
>  	u16 family;
>  	int err;
>  
> @@ -4587,11 +4588,11 @@ static int selinux_socket_bind(struct socket
> *sock, struct sockaddr *address, in
>  	family = sk->sk_family;
>  	if (family == PF_INET || family == PF_INET6) {
>  		char *addrp;
> -		struct sk_security_struct *sksec = sk->sk_security;
>  		struct common_audit_data ad;
>  		struct lsm_network_audit net = {0,};
>  		struct sockaddr_in *addr4 = NULL;
>  		struct sockaddr_in6 *addr6 = NULL;
> +		u16 family_sa = address->sa_family;
>  		unsigned short snum;
>  		u32 sid, node_perm;
>  
> @@ -4601,11 +4602,20 @@ static int selinux_socket_bind(struct socket
> *sock, struct sockaddr *address, in
>  		 * need to check address->sa_family as it is
> possible to have
>  		 * sk->sk_family = PF_INET6 with addr->sa_family =
> AF_INET.
>  		 */
> -		switch (address->sa_family) {
> +		switch (family_sa) {
> +		case AF_UNSPEC:
>  		case AF_INET:
>  			if (addrlen < sizeof(struct sockaddr_in))
>  				return -EINVAL;
>  			addr4 = (struct sockaddr_in *)address;
> +			if (family_sa == AF_UNSPEC) {
> +				/* see __inet_bind(), we only want
> to allow
> +				 * AF_UNSPEC if the address is
> INADDR_ANY
> +				 */
> +				if (addr4->sin_addr.s_addr !=
> htonl(INADDR_ANY))
> +					goto err_af;
> +				family_sa = AF_INET;
> +			}
>  			snum = ntohs(addr4->sin_port);
>  			addrp = (char *)&addr4->sin_addr.s_addr;
>  			break;
> @@ -4617,13 +4627,7 @@ static int selinux_socket_bind(struct socket
> *sock, struct sockaddr *address, in
>  			addrp = (char *)&addr6->sin6_addr.s6_addr;
>  			break;
>  		default:
> -			/* Note that SCTP services expect -EINVAL,
> whereas
> -			 * others expect -EAFNOSUPPORT.
> -			 */
> -			if (sksec->sclass == SECCLASS_SCTP_SOCKET)
> -				return -EINVAL;
> -			else
> -				return -EAFNOSUPPORT;
> +			goto err_af;
>  		}
>  
>  		if (snum) {
> @@ -4681,7 +4685,7 @@ static int selinux_socket_bind(struct socket
> *sock, struct sockaddr *address, in
>  		ad.u.net->sport = htons(snum);
>  		ad.u.net->family = family;
>  
> -		if (address->sa_family == AF_INET)
> +		if (family_sa == AF_INET)
>  			ad.u.net->v4info.saddr = addr4-
> >sin_addr.s_addr;
>  		else
>  			ad.u.net->v6info.saddr = addr6->sin6_addr;
> @@ -4694,6 +4698,11 @@ static int selinux_socket_bind(struct socket
> *sock, struct sockaddr *address, in
>  	}
>  out:
>  	return err;
> +err_af:
> +	/* Note that SCTP services expect -EINVAL, others
> -EAFNOSUPPORT. */
> +	if (sksec->sclass == SECCLASS_SCTP_SOCKET)
> +		return -EINVAL;
> +	return -EAFNOSUPPORT;
>  }
>  
>  /* This supports connect(2) and SCTP connect services such as
> sctp_connectx(3)

Tested all three patches with no unexpected problems on kernel from [1]
using:

1) lksctp-tools - Passed except test_1_to_1_events as per [2]
2) sctp-tests - As above
3) selinux-testsuite with my SCTP patch [3] - Passes all sctp and
inet_socket tests.
4) The LTP "./runltp -pq -f connect-syscall" (see [4]) - Passes

[1] https://github.com/SELinuxProject/selinux-kernel/tree/next
[2] https://github.com/sctp/lksctp-tools/issues/24
[3] https://marc.info/?l=selinux&m=152156947715709&w=2
[4] https://marc.info/?l=selinux&m=151990968221563&w=2
