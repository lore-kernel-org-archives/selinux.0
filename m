From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: ipsec and getpeercon()
Date: Tue, 5 Sep 2006 00:00:09 -0400
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov
References: <36282A1733C57546BE392885C061859201512DD1@chaos.tcs.tcs-sec.com> <44F8B50E.3060303@hp.com> <1157395888.10620.2.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157395888.10620.2.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200609050000.10205.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 04 September 2006 2:51 pm, Joshua Brindle wrote:
> On Fri, 2006-09-01 at 18:32 -0400, Paul Moore wrote:
> > Paul Moore wrote:
> > > Venkat Yekkirala wrote:
> > >>>Unfortunately, the fix
> > >>>is not immediately obvious.
> > >>
> > >>You would use the xfrm_sid and in it's absence the node
> > >>sid as the base sid.
> > >
> > > That is not the issue I am dealing with right now.
> > >
> > > I now have a solution in mind, however, it is doubtful I will have a
> > > chance to do any sort of testing on it before I leave tonight.  Once I
> > > can give it a quick test to verify that it doesn't break anything I'll
> > > post a patch for you and Joy to verify.
> >
> > Sorry for attaching the patch as an attachment but I'm in a rush to get
> > out of here ...
> >
> > This patch is against David Miller's net-2.6.19 tree from a day or two
> > ago, depending on your kernel you may have some fuzz when applying this
> > patch.  I've only done some quick functional tests, but it seems to
> > solve this problem.
> >
> > Joy, Venkat if you are able to test this and let me know the results I
> > would appreciate it.
> >
> > Thanks.
>
> I tried the (rebased patch below, there were some rejects when applying
> it to todays net-2.6.19) and got the same behavior as before:
>
> [root@joker-rawhide-clone ~]# ./server
> server: got connection from 10.1.13.104, root:system_r:unconfined_t:s0
>
> [root@joker-rawhide-clone ~]# runcon -t passwd_t ./server
> server: got connection from 10.1.13.104, root:system_r:passwd_t:s0

Thanks for giving the patch a try.  I'm confused as to why it didn't work for 
you, can you try it without IPsec configured to see what results you get 
(that is what I did and it worked fine)?

Thanks.

> my spd is the same as before:
> [root@joker-rawhide-clone ~]# setkey -DP
> 10.1.13.104[any] 10.1.13.100[any] any
>         in prio def ipsec
>         esp/transport//require
>         created: Sep  4 14:40:33 2006  lastused: Sep  4 14:41:38 2006
>         lifetime: 0(s) validtime: 0(s)
>         security context doi: 1
>         security context algorithm: 1
>         security context length: 33
>         security context: system_u:object_r:unlabeled_t:s0
>         spid=32 seq=2 pid=2384
>         refcnt=1
> 10.1.13.100[any] 10.1.13.104[any] any
>         out prio def ipsec
>         esp/transport//require
>         created: Sep  4 14:40:33 2006  lastused: Sep  4 14:41:38 2006
>         lifetime: 0(s) validtime: 0(s)
>         security context doi: 1
>         security context algorithm: 1
>         security context length: 33
>         security context: system_u:object_r:unlabeled_t:s0
>         spid=25 seq=1 pid=2384
>         refcnt=1
> 10.1.13.104[any] 10.1.13.100[any] any
>         fwd prio def ipsec
>         esp/transport//require
>         created: Sep  4 14:40:33 2006  lastused:
>         lifetime: 0(s) validtime: 0(s)
>         security context doi: 1
>         security context algorithm: 1
>         security context length: 33
>         security context: system_u:object_r:unlabeled_t:s0
>         spid=42 seq=0 pid=2384
>         refcnt=1
>
>
>
> diff --git a/include/net/cipso_ipv4.h b/include/net/cipso_ipv4.h
> index c7175e7..b2bd7a6 100644
> --- a/include/net/cipso_ipv4.h
> +++ b/include/net/cipso_ipv4.h
> @@ -211,6 +211,7 @@ int cipso_v4_socket_getopt(const struct
>  			   u32 *opt_len);
>  int cipso_v4_socket_getattr(const struct socket *sock,
>  			    struct netlbl_lsm_secattr *secattr);
> +int cipso_v4_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr
> *secattr); int cipso_v4_skbuff_getattr(const struct sk_buff *skb,
>  			    struct netlbl_lsm_secattr *secattr);
>  int cipso_v4_validate(unsigned char **option);
> @@ -229,6 +230,12 @@ static inline int cipso_v4_socket_setatt
>  	return -ENOSYS;
>  }
>
> +static inline int cipso_v4_sock_getattr(struct sock *sk,
> +					struct netlbl_lsm_secattr *secattr)
> +{
> +	return -ENOSYS;
> +}
> +
>  static inline int cipso_v4_socket_getattr(const struct socket *sock,
>  					  struct netlbl_lsm_secattr *secattr)
>  {
> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index 7cae730..6addb41 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -237,6 +237,8 @@ static inline void netlbl_secattr_free(s
>  #ifdef CONFIG_NETLABEL
>  int netlbl_socket_setattr(const struct socket *sock,
>  			  const struct netlbl_lsm_secattr *secattr);
> +int netlbl_sock_getattr(struct sock *sk,
> +			struct netlbl_lsm_secattr *secattr);
>  int netlbl_socket_getattr(const struct socket *sock,
>  			  struct netlbl_lsm_secattr *secattr);
>  int netlbl_skbuff_getattr(const struct sk_buff *skb,
> @@ -249,6 +251,12 @@ static inline int netlbl_socket_setattr(
>  	return -ENOSYS;
>  }
>
> +static inline int netlbl_sock_getattr(struct sock *sk,
> +				      struct netlbl_lsm_secattr *secattr)
> +{
> +	return -ENOSYS;
> +}
> +
>  static inline int netlbl_socket_getattr(const struct socket *sock,
>  					struct netlbl_lsm_secattr *secattr)
>  {
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 80a2a09..a3bae2c 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1486,43 +1486,40 @@ socket_setattr_failure:
>  }
>
>  /**
> - * cipso_v4_socket_getattr - Get the security attributes from a socket
> - * @sock: the socket
> + * cipso_v4_sock_getattr - Get the security attributes from a sock
> + * @sk: the sock
>   * @secattr: the security attributes
>   *
>   * Description:
> - * Query @sock to see if there is a CIPSO option attached to the socket
> and if - * there is return the CIPSO security attributes in @secattr. 
> Returns zero on - * success and negative values on failure.
> + * Query @sk to see if there is a CIPSO option attached to the sock and if
> + * there is return the CIPSO security attributes in @secattr.  This
> function + * requires that @sk be locked, or privately held, but it does
> not do any + * locking itself.  Returns zero on success and negative values
> on failure. *
>   */
> -int cipso_v4_socket_getattr(const struct socket *sock,
> -			    struct netlbl_lsm_secattr *secattr)
> +int cipso_v4_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr
> *secattr) {
>  	int ret_val = -ENOMSG;
> -	struct sock *sk;
>  	struct inet_sock *sk_inet;
>  	unsigned char *cipso_ptr;
>  	u32 doi;
>  	struct cipso_v4_doi *doi_def;
>
> -	sk = sock->sk;
> -	lock_sock(sk);
>  	sk_inet = inet_sk(sk);
>  	if (sk_inet->opt == NULL || sk_inet->opt->cipso == 0)
> -		goto socket_getattr_return;
> +		return -ENOMSG;
>  	cipso_ptr = sk_inet->opt->__data + sk_inet->opt->cipso -
>  		sizeof(struct iphdr);
>  	ret_val = cipso_v4_cache_check(cipso_ptr, cipso_ptr[1], secattr);
>  	if (ret_val == 0)
> -		goto socket_getattr_return;
> +		return ret_val;
>
>  	doi = ntohl(*(u32 *)&cipso_ptr[2]);
>  	rcu_read_lock();
>  	doi_def = cipso_v4_doi_getdef(doi);
>  	if (doi_def == NULL) {
>  		rcu_read_unlock();
> -		goto socket_getattr_return;
> +		return -ENOMSG;
>  	}
>  	switch (cipso_ptr[6]) {
>  	case CIPSO_V4_TAG_RBITMAP:
> @@ -1533,8 +1530,29 @@ int cipso_v4_socket_getattr(const struct
>  	}
>  	rcu_read_unlock();
>
> -socket_getattr_return:
> -	release_sock(sk);
> +	return ret_val;
> +}
> +
> +/**
> + * cipso_v4_socket_getattr - Get the security attributes from a socket
> + * @sock: the socket
> + * @secattr: the security attributes
> + *
> + * Description:
> + * Query @sock to see if there is a CIPSO option attached to the socket
> and if + * there is return the CIPSO security attributes in @secattr. 
> Returns zero on + * success and negative values on failure.
> + *
> + */
> +int cipso_v4_socket_getattr(const struct socket *sock,
> +			    struct netlbl_lsm_secattr *secattr)
> +{
> +	int ret_val;
> +
> +	lock_sock(sock->sk);
> +	ret_val = cipso_v4_sock_getattr(sock->sk, secattr);
> +	release_sock(sock->sk);
> +
>  	return ret_val;
>  }
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 0fd8aaa..54fb7de 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -85,6 +85,29 @@ socket_setattr_return:
>  }
>
>  /**
> + * netlbl_sock_getattr - Determine the security attributes of a sock
> + * @sk: the sock
> + * @secattr: the security attributes
> + *
> + * Description:
> + * Examines the given sock to see any NetLabel style labeling has been
> + * applied to the sock, if so it parses the socket label and returns the
> + * security attributes in @secattr.  Returns zero on success, negative
> values + * on failure.
> + *
> + */
> +int netlbl_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr
> *secattr) +{
> +	int ret_val;
> +
> +	ret_val = cipso_v4_sock_getattr(sk, secattr);
> +	if (ret_val == 0)
> +		return 0;
> +
> +	return netlbl_unlabel_getattr(secattr);
> +}
> +
> +/**
>   * netlbl_socket_getattr - Determine the security attributes of a socket
>   * @sock: the socket
>   * @secattr: the security attributes
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c index 910afa1..5497ad9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2462,12 +2462,23 @@ void selinux_netlbl_sock_graft(struct so
>  {
>  	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
>  	struct sk_security_struct *sksec = sk->sk_security;
> +	struct netlbl_lsm_secattr secattr;
> +	u32 nlbl_peer_sid;
> +
>
>  	if (sk->sk_family != PF_INET)
>  		return;
>
> +	netlbl_secattr_init(&secattr);
> +	if (netlbl_sock_getattr(sk, &secattr) == 0 &&
> +			selinux_netlbl_secattr_to_sid(NULL,
> +				&secattr,
> +				sksec->sid,
> +				&nlbl_peer_sid) == 0)
> +		sksec->peer_sid = nlbl_peer_sid;
> +	netlbl_secattr_destroy(&secattr, 0);
> +
>  	sksec->nlbl_state = NLBL_REQUIRE;
> -	sksec->peer_sid = sksec->sid;
>  	sksec->sclass = isec->sclass;
>
>  	/* Try to set the NetLabel on the socket to save time later, if we fail

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
