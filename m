Message-ID: <36282A1733C57546BE392885C0618592015CFD4F@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        eparis@redhat.com, jbrindle@tresys.com, redhat-lspp@redhat.com
Subject: RE: [PATCH 1/1] selinux: secid reconciliation fixes V02
Date: Mon, 9 Oct 2006 12:01:54 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Venkat Yekkirala wrote:
> > --- net-2.6.sid6/include/linux/security.h	2006-10-05 
> 12:03:39.000000000 -0500
> > +++ net-2.6/include/linux/security.h	2006-10-08 
> 14:10:49.000000000 -0500
> > @@ -67,6 +67,7 @@ struct xfrm_selector;
> >  struct xfrm_policy;
> >  struct xfrm_state;
> >  struct xfrm_user_sec_ctx;
> > +struct net_device;
> >  
> >  extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
> >  extern int cap_netlink_recv(struct sk_buff *skb, int cap);
> > @@ -828,8 +829,8 @@ struct request_sock;
> >   *	Sets the new child socket's sid to the openreq sid.
> >   * @inet_conn_established:
> >   *	Sets the connection's peersid to the secmark on skb.
> > - * @req_classify_flow:
> > - *	Sets the flow's sid to the openreq sid.
> > + * @igmp_classify_skb:
> > + *	Classifies an skb representing an igmp packet.
> 
> I wonder if it might be cleaner to have a generic 
> classify_skb() function?  That
> seems to be more inline with what James commented on earlier 
> and I'm almost
> certain the netdev crowd would be much more open to a generic 
> hook.  It
> shouldn't be too expensive to check if the packet is an IGMP 
> packet inside the hook.

It wouldn't necessarily be clean in that you would have to put
all the logic to determine what kind of packet it is inside the
hook, if it's even possible to do it under all circumstances.

> 
> >   * @skb_flow_in:
> >   *	Checks to see if security policy would allow skb into the system
> >   *	while also reconciling the xfrm secid, cipso, etc, if any, and
> > @@ -1385,9 +1386,10 @@ struct security_operations {
> >  					struct request_sock *req);
> >  	void (*inet_csk_clone)(struct sock *newsk, const struct 
> request_sock *req);
> >  	void (*inet_conn_established)(struct sock *sk, struct 
> sk_buff *skb);
> > -	void (*req_classify_flow)(const struct request_sock 
> *req, struct flowi *fl);
> > +	void (*igmp_classify_skb)(struct sk_buff *skb);
> >  	int (*skb_flow_in)(struct sk_buff *skb, unsigned short family);
> > -	int (*skb_flow_out)(struct sk_buff *skb, u32 nf_secid);
> > +	int (*skb_flow_out)(struct sk_buff *skb, u32 nf_secid,
> > +			const struct net_device *out, unsigned 
> short family);
> >  #endif	/* CONFIG_SECURITY_NETWORK */
> >  
> >  #ifdef CONFIG_SECURITY_NETWORK_XFRM
> > @@ -2953,14 +2955,20 @@ static inline void security_sk_clone(con
> >  	return security_ops->sk_clone_security(sk, newsk);
> >  }
> >  
> > +/*static inline void security_sk_classify_ipcm(struct sock *sk,	
> > +					struct ipcm_cookie *ipc)
> > +{
> > +	security_ops->sk_getsecid(sk, &ipc->secid);
> > +}*/
> > +
> 
> If this really isn't needed shouldn't we just remove the code 
> altogether instead
> of commenting it out?

Yes. If you could take it out, I would appreciate it. (let me know if
you want a new patch with this taken out).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
