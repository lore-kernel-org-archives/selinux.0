Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9VLXYeC030044
	for <selinux@tycho.nsa.gov>; Tue, 31 Oct 2006 16:33:34 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9VLVvsE025093
	for <selinux@tycho.nsa.gov>; Tue, 31 Oct 2006 21:31:57 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id k9VLWBZ9023825
	for <selinux@tycho.nsa.gov>; Tue, 31 Oct 2006 16:32:11 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id k9VLWBUS023824
	for selinux@tycho.nsa.gov; Tue, 31 Oct 2006 16:32:11 -0500
In-Reply-To: <45466350.5020203@trustedcs.com>
References: <45466350.5020203@trustedcs.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BB15F670-BA6A-47BD-BF04-37A7B9206D87@cse.psu.edu>
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov, latten@austin.ibm.com,
        hallyn@elg11.watson.ibm.com
From: Trent Jaeger <tjaeger@cse.psu.edu>
Subject: Re: Question on checks against unlabeled
Date: Mon, 30 Oct 2006 15:58:59 -0500
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The intention was to prevent the case that a machine can communicate  
to another machine w/o IPsec, but it has processes that must not use  
unencrypted and/or unlabeled communication.  Thus, it was required  
that a process (actually a socket) that sends w/o IPsec must be able  
to communicate with unlabeled security associations.

If we can make it more explicit that a socket requires IPsec or not,  
then we may not need this check.  We can check on process's access to  
socket.  I'll think about how we could do this.

Regards,
Trent.

On Oct 30, 2006, at 3:40 PM, Venkat Yekkirala wrote:

> Hi Trent et al,
>
> I have a question on the following checks in security/selinux/xfrm.c:
>
> Specifically, there's a check against unlabeled_t even when there's
> no association involved. Is this really intended in the sense of  
> meeting
> a goal such as a process should always use labeled ipsec or was the  
> intention
> to actually use unlabeled_t only when there's an SA being used, but  
> it's
> not labeled.
>
> Thanks,
>
> venkat
>
> int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
>                                 struct avc_audit_data *ad)
> {
>         int i, rc = 0;
>         struct sec_path *sp;
>         u32 sel_sid = SECINITSID_UNLABELED;
>
>         sp = skb->sp;
>
>         if (sp) {
>                 for (i = 0; i < sp->len; i++) {
>                         struct xfrm_state *x = sp->xvec[i];
>
>                         if (x && selinux_authorizable_xfrm(x)) {
>                                 struct xfrm_sec_ctx *ctx = x- 
> >security;
>                                 sel_sid = ctx->ctx_sid;
>                                 break;
>                         }
>                 }
>         }
>
>         rc = avc_has_perm(isec_sid, sel_sid, SECCLASS_ASSOCIATION,
> /*
>  * POSTROUTE_LAST hook's XFRM processing:
>  * If we have no security association, then we need to determine
>  * whether the socket is allowed to send to an unlabelled destination.
>  * If we do have a authorizable security association, then it has  
> already been
>  * checked in xfrm_policy_lookup hook.
>  */
> int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
>                                         struct avc_audit_data *ad)
> {
>         struct dst_entry *dst;
>         int rc = 0;
>
>         dst = skb->dst;
>
>         if (dst) {
>                 struct dst_entry *dst_test;
>
>                 for (dst_test = dst; dst_test != 0;
>                      dst_test = dst_test->child) {
>                         struct xfrm_state *x = dst_test->xfrm;
>
>                         if (x && selinux_authorizable_xfrm(x))
>                                 goto out;
>                 }
>         }
>
>         rc = avc_has_perm(isec_sid, SECINITSID_UNLABELED,  
> SECCLASS_ASSOCIATION,
>                           ASSOCIATION__SENDTO, ad);
> out:
>         return rc;
> }

----------------------------------------------
Trent Jaeger, Associate Professor
Pennsylvania State University, CSE Dept
346A IST Bldg, University Park, PA 16802
Email: tjaeger@cse.psu.edu
Ph: (814) 865-1042, Fax: (814) 865-3176



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
