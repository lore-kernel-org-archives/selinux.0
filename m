From: Paul Moore <paul.moore@hp.com>
To: jmorris@namei.org
Subject: Re: [PATCH] SELinux: Correct the NetLabel locking for the sk_security_struct
Date: Mon, 25 Feb 2008 11:42:09 -0500
Cc: sds@tycho.nsa.gov, eparis@redhat.com, selinux@tycho.nsa.gov
References: <Xine.LNX.4.64.0802260044410.24574@us.intercode.com.au> <20080225164033.31345.24622.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080225164033.31345.24622.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802251142.09548.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 25 February 2008 11:40:33 am Paul Moore wrote:
> The RCU/spinlock locking approach for the nlbl_state in the
> sk_security_struct was almost certainly overkill.  This patch removes
> both the RCU and spinlock locking, relying on the existing socket
> locks to handle the case of multiple writers.  This change also makes
> several code reductions possible.
>
> Less locking, less code - it's a Good Thing.
>
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Hmm, I was playing around with annotations and it looks like it didn't 
come through ... this patch is compile tested only.

> ---
>
>  security/selinux/hooks.c            |    4 +-
>  security/selinux/include/netlabel.h |   16 -------
>  security/selinux/include/objsec.h   |    1
>  security/selinux/netlabel.c         |   81
> ++++++----------------------------- 4 files changed, 15
> insertions(+), 87 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 75c2e99..2caf519 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -280,7 +280,7 @@ static int sk_alloc_security(struct sock *sk, int
> family, gfp_t priority) ssec->sid = SECINITSID_UNLABELED;
>  	sk->sk_security = ssec;
>
> -	selinux_netlbl_sk_security_init(ssec, family);
> +	selinux_netlbl_sk_security_reset(ssec, family);
>
>  	return 0;
>  }
> @@ -4120,7 +4120,7 @@ static void selinux_sk_clone_security(const
> struct sock *sk, struct sock *newsk) newssec->peer_sid =
> ssec->peer_sid;
>  	newssec->sclass = ssec->sclass;
>
> -	selinux_netlbl_sk_security_clone(ssec, newssec);
> +	selinux_netlbl_sk_security_reset(newssec, newsk->sk_family);
>  }
>
>  static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
> diff --git a/security/selinux/include/netlabel.h
> b/security/selinux/include/netlabel.h index 00a2809..9a9e7cd 100644
> --- a/security/selinux/include/netlabel.h
> +++ b/security/selinux/include/netlabel.h
> @@ -41,10 +41,6 @@ void selinux_netlbl_cache_invalidate(void);
>
>  void selinux_netlbl_sk_security_reset(struct sk_security_struct
> *ssec, int family);
> -void selinux_netlbl_sk_security_init(struct sk_security_struct
> *ssec, -				     int family);
> -void selinux_netlbl_sk_security_clone(struct sk_security_struct
> *ssec, -				      struct sk_security_struct *newssec);
>
>  int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
>  				 u16 family,
> @@ -73,18 +69,6 @@ static inline void
> selinux_netlbl_sk_security_reset( {
>  	return;
>  }
> -static inline void selinux_netlbl_sk_security_init(
> -	                                       struct sk_security_struct
> *ssec, -					       int family)
> -{
> -	return;
> -}
> -static inline void selinux_netlbl_sk_security_clone(
> -	                                    struct sk_security_struct
> *ssec, -					    struct sk_security_struct *newssec)
> -{
> -	return;
> -}
>
>  static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
>  					       u16 family,
> diff --git a/security/selinux/include/objsec.h
> b/security/selinux/include/objsec.h index c6c2bb4..0b74077 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -120,7 +120,6 @@ struct sk_security_struct {
>  		NLBL_REQUIRE,
>  		NLBL_LABELED,
>  	} nlbl_state;
> -	spinlock_t nlbl_lock;		/* protects nlbl_state */
>  #endif
>  };
>
> diff --git a/security/selinux/netlabel.c
> b/security/selinux/netlabel.c index 0fa2be4..ccf71f6 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -69,9 +69,7 @@ static int selinux_netlbl_sidlookup_cached(struct
> sk_buff *skb, *
>   * Description:
>   * Attempt to label a socket using the NetLabel mechanism using the
> given - * SID.  Returns zero values on success, negative values on
> failure.  The - * caller is responsibile for calling rcu_read_lock()
> before calling this - * this function and rcu_read_unlock() after
> this function returns. + * SID.  Returns zero values on success,
> negative values on failure. *
>   */
>  static int selinux_netlbl_sock_setsid(struct sock *sk, u32 sid)
> @@ -86,11 +84,8 @@ static int selinux_netlbl_sock_setsid(struct sock
> *sk, u32 sid) if (rc != 0)
>  		goto sock_setsid_return;
>  	rc = netlbl_sock_setattr(sk, &secattr);
> -	if (rc == 0) {
> -		spin_lock_bh(&sksec->nlbl_lock);
> +	if (rc == 0)
>  		sksec->nlbl_state = NLBL_LABELED;
> -		spin_unlock_bh(&sksec->nlbl_lock);
> -	}
>
>  sock_setsid_return:
>  	netlbl_secattr_destroy(&secattr);
> @@ -129,45 +124,6 @@ void selinux_netlbl_sk_security_reset(struct
> sk_security_struct *ssec, }
>
>  /**
> - * selinux_netlbl_sk_security_init - Setup the NetLabel fields
> - * @ssec: the sk_security_struct
> - * @family: the socket family
> - *
> - * Description:
> - * Called when a new sk_security_struct is allocated to initialize
> the NetLabel - * fields.
> - *
> - */
> -void selinux_netlbl_sk_security_init(struct sk_security_struct
> *ssec, -				     int family)
> -{
> -	/* No locking needed, we are the only one who has access to ssec */
> -	selinux_netlbl_sk_security_reset(ssec, family);
> -	spin_lock_init(&ssec->nlbl_lock);
> -}
> -
> -/**
> - * selinux_netlbl_sk_security_clone - Copy the NetLabel fields
> - * @ssec: the original sk_security_struct
> - * @newssec: the cloned sk_security_struct
> - *
> - * Description:
> - * Clone the NetLabel specific sk_security_struct fields from @ssec
> to - * @newssec.
> - *
> - */
> -void selinux_netlbl_sk_security_clone(struct sk_security_struct
> *ssec, -				      struct sk_security_struct *newssec)
> -{
> -	/* We don't need to take newssec->nlbl_lock because we are the only
> -	 * thread with access to newssec, but we do need to take the RCU
> read -	 * lock as other threads could have access to ssec */
> -	rcu_read_lock();
> -	selinux_netlbl_sk_security_reset(newssec, ssec->sk->sk_family);
> -	rcu_read_unlock();
> -}
> -
> -/**
>   * selinux_netlbl_skbuff_getsid - Get the sid of a packet using
> NetLabel * @skb: the packet
>   * @family: protocol family
> @@ -221,12 +177,8 @@ void selinux_netlbl_sock_graft(struct sock *sk,
> struct socket *sock) struct netlbl_lsm_secattr secattr;
>  	u32 nlbl_peer_sid;
>
> -	rcu_read_lock();
> -
> -	if (sksec->nlbl_state != NLBL_REQUIRE) {
> -		rcu_read_unlock();
> +	if (sksec->nlbl_state != NLBL_REQUIRE)
>  		return;
> -	}
>
>  	netlbl_secattr_init(&secattr);
>  	if (netlbl_sock_getattr(sk, &secattr) == 0 &&
> @@ -239,8 +191,6 @@ void selinux_netlbl_sock_graft(struct sock *sk,
> struct socket *sock) * here we will pick up the pieces in later calls
> to
>  	 * selinux_netlbl_inode_permission(). */
>  	selinux_netlbl_sock_setsid(sk, sksec->sid);
> -
> -	rcu_read_unlock();
>  }
>
>  /**
> @@ -254,16 +204,13 @@ void selinux_netlbl_sock_graft(struct sock *sk,
> struct socket *sock) */
>  int selinux_netlbl_socket_post_create(struct socket *sock)
>  {
> -	int rc = 0;
>  	struct sock *sk = sock->sk;
>  	struct sk_security_struct *sksec = sk->sk_security;
>
> -	rcu_read_lock();
> -	if (sksec->nlbl_state == NLBL_REQUIRE)
> -		rc = selinux_netlbl_sock_setsid(sk, sksec->sid);
> -	rcu_read_unlock();
> +	if (sksec->nlbl_state != NLBL_REQUIRE)
> +		return 0;
>
> -	return rc;
> +	return selinux_netlbl_sock_setsid(sk, sksec->sid);
>  }
>
>  /**
> @@ -288,21 +235,21 @@ int selinux_netlbl_inode_permission(struct
> inode *inode, int mask) if (!S_ISSOCK(inode->i_mode) ||
>  	    ((mask & (MAY_WRITE | MAY_APPEND)) == 0))
>  		return 0;
> +
>  	sock = SOCKET_I(inode);
>  	sk = sock->sk;
>  	sksec = sk->sk_security;
> -
> -	rcu_read_lock();
> -	if (sksec->nlbl_state != NLBL_REQUIRE) {
> -		rcu_read_unlock();
> +	if (sksec->nlbl_state != NLBL_REQUIRE)
>  		return 0;
> -	}
> +
>  	local_bh_disable();
>  	bh_lock_sock_nested(sk);
> -	rc = selinux_netlbl_sock_setsid(sk, sksec->sid);
> +	if (likely(sksec->nlbl_state == NLBL_REQUIRE))
> +		rc = selinux_netlbl_sock_setsid(sk, sksec->sid);
> +	else
> +		rc = 0;
>  	bh_unlock_sock(sk);
>  	local_bh_enable();
> -	rcu_read_unlock();
>
>  	return rc;
>  }
> @@ -385,7 +332,6 @@ int selinux_netlbl_socket_setsockopt(struct
> socket *sock, struct sk_security_struct *sksec = sk->sk_security;
>  	struct netlbl_lsm_secattr secattr;
>
> -	rcu_read_lock();
>  	if (level == IPPROTO_IP && optname == IP_OPTIONS &&
>  	    sksec->nlbl_state == NLBL_LABELED) {
>  		netlbl_secattr_init(&secattr);
> @@ -396,7 +342,6 @@ int selinux_netlbl_socket_setsockopt(struct
> socket *sock, rc = -EACCES;
>  		netlbl_secattr_destroy(&secattr);
>  	}
> -	rcu_read_unlock();
>
>  	return rc;
>  }



-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
