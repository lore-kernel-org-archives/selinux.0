Message-ID: <452A7504.5010304@hp.com>
Date: Mon, 09 Oct 2006 12:12:52 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        eparis@redhat.com, jbrindle@tresys.com, redhat-lspp@redhat.com
Subject: Re: [PATCH 1/1] selinux: secid reconciliation fixes V02
References: <36282A1733C57546BE392885C0618592015CFD4F@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CFD4F@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>Venkat Yekkirala wrote:
>>
>>>--- net-2.6.sid6/include/linux/security.h	2006-10-05 
>>
>>12:03:39.000000000 -0500
>>
>>>+++ net-2.6/include/linux/security.h	2006-10-08 
>>
>>14:10:49.000000000 -0500
>>
>>>@@ -67,6 +67,7 @@ struct xfrm_selector;
>>> struct xfrm_policy;
>>> struct xfrm_state;
>>> struct xfrm_user_sec_ctx;
>>>+struct net_device;
>>> 
>>> extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
>>> extern int cap_netlink_recv(struct sk_buff *skb, int cap);
>>>@@ -828,8 +829,8 @@ struct request_sock;
>>>  *	Sets the new child socket's sid to the openreq sid.
>>>  * @inet_conn_established:
>>>  *	Sets the connection's peersid to the secmark on skb.
>>>- * @req_classify_flow:
>>>- *	Sets the flow's sid to the openreq sid.
>>>+ * @igmp_classify_skb:
>>>+ *	Classifies an skb representing an igmp packet.
>>
>>I wonder if it might be cleaner to have a generic 
>>classify_skb() function?  That
>>seems to be more inline with what James commented on earlier 
>>and I'm almost
>>certain the netdev crowd would be much more open to a generic 
>>hook.  It
>>shouldn't be too expensive to check if the packet is an IGMP 
>>packet inside the hook.
> 
> 
> It wouldn't necessarily be clean in that you would have to put
> all the logic to determine what kind of packet it is inside the
> hook, if it's even possible to do it under all circumstances.

Yes, but the *interface* would be cleaner which was the point I was trying to
make.  There have been a lot of new LSM networking hooks introduced lately and I
thought it might be worthwhile to keep the interfaces as flexibile as possibile.

I guess we can always change it later if needed.

>>>+/*static inline void security_sk_classify_ipcm(struct sock *sk,	
>>>+					struct ipcm_cookie *ipc)
>>>+{
>>>+	security_ops->sk_getsecid(sk, &ipc->secid);
>>>+}*/
>>>+
>>
>>If this really isn't needed shouldn't we just remove the code 
>>altogether instead
>>of commenting it out?
> 
> Yes. If you could take it out, I would appreciate it. (let me know if
> you want a new patch with this taken out).

It's probably quickest if I just drop it.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
