Message-ID: <452A7013.8050509@hp.com>
Date: Mon, 09 Oct 2006 11:51:47 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        eparis@redhat.com, jbrindle@tresys.com, redhat-lspp@redhat.com
Subject: Re: [PATCH 1/1] selinux: secid reconciliation fixes V02
References: <452A6A2F.3040202@trustedcs.com>
In-Reply-To: <452A6A2F.3040202@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> --- net-2.6.sid6/include/linux/security.h	2006-10-05 12:03:39.000000000 -0500
> +++ net-2.6/include/linux/security.h	2006-10-08 14:10:49.000000000 -0500
> @@ -67,6 +67,7 @@ struct xfrm_selector;
>  struct xfrm_policy;
>  struct xfrm_state;
>  struct xfrm_user_sec_ctx;
> +struct net_device;
>  
>  extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
>  extern int cap_netlink_recv(struct sk_buff *skb, int cap);
> @@ -828,8 +829,8 @@ struct request_sock;
>   *	Sets the new child socket's sid to the openreq sid.
>   * @inet_conn_established:
>   *	Sets the connection's peersid to the secmark on skb.
> - * @req_classify_flow:
> - *	Sets the flow's sid to the openreq sid.
> + * @igmp_classify_skb:
> + *	Classifies an skb representing an igmp packet.

I wonder if it might be cleaner to have a generic classify_skb() function?  That
seems to be more inline with what James commented on earlier and I'm almost
certain the netdev crowd would be much more open to a generic hook.  It
shouldn't be too expensive to check if the packet is an IGMP packet inside the hook.

>   * @skb_flow_in:
>   *	Checks to see if security policy would allow skb into the system
>   *	while also reconciling the xfrm secid, cipso, etc, if any, and
> @@ -1385,9 +1386,10 @@ struct security_operations {
>  					struct request_sock *req);
>  	void (*inet_csk_clone)(struct sock *newsk, const struct request_sock *req);
>  	void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
> -	void (*req_classify_flow)(const struct request_sock *req, struct flowi *fl);
> +	void (*igmp_classify_skb)(struct sk_buff *skb);
>  	int (*skb_flow_in)(struct sk_buff *skb, unsigned short family);
> -	int (*skb_flow_out)(struct sk_buff *skb, u32 nf_secid);
> +	int (*skb_flow_out)(struct sk_buff *skb, u32 nf_secid,
> +			const struct net_device *out, unsigned short family);
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
>  #ifdef CONFIG_SECURITY_NETWORK_XFRM
> @@ -2953,14 +2955,20 @@ static inline void security_sk_clone(con
>  	return security_ops->sk_clone_security(sk, newsk);
>  }
>  
> +/*static inline void security_sk_classify_ipcm(struct sock *sk,	
> +					struct ipcm_cookie *ipc)
> +{
> +	security_ops->sk_getsecid(sk, &ipc->secid);
> +}*/
> +

If this really isn't needed shouldn't we just remove the code altogether instead
of commenting it out?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
