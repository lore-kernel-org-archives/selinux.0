Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: <cpebenito@tresys.com>
Cc: <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>, <latten@austin.ibm.com>,
        <hallyn@elg11.watson.ibm.com>, "'Trent Jaeger'" <tjaeger@cse.psu.edu>
Subject: RE: Question on checks against unlabeled
Date: Tue, 31 Oct 2006 09:14:40 -0600
Message-ID: <000101c6fcff$498e9960$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <BB15F670-BA6A-47BD-BF04-37A7B9206D87@cse.psu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Chris,

I am looking for some input :) from your (policywriter's) end on the
following:

I have code that now "selects" a labeled association that has the same label
as the socket, when the socket "polmatches" a "labeled" SPD rule.

There's also the following check in the kernel currently:
allow socket_t unlabeled_t:association { sendto }

The intent as explained below by Trent is to make sure a socket can
"use" an "non-labeled" association in the following cases:

a. socket matches a "non-labeled" SPD rule and hence is using a non-labeled
IPSec SA.

b. no IPSec SA being used by the socket.


We have the following choices:

1. We retain the sendto check against unlabeled_t in the above scenarios (a
and b).

2. We restrict the sendto check only to scenario "a" where we in fact have
an
   association (albeit a "non-labeled" SA).

3. We eliminate the sendto check for both the scenarios.

4. We retain the check for both, but for consistency we also do the
following
   check after we "select" a labeled SA.

   allow socket_t self:association { sendto };

   IOW, your policy will always need to have one of the following:
   allow socket_t self:association { sendto } where a "labeled" SA can be
used.
   allow socket_t unlabeled_t:association { sendto } where an "non-labeled"
SA or no SA at all is permitted for the socket.

What's your preference?

> -----Original Message-----
> From: Trent Jaeger [mailto:tjaeger@cse.psu.edu]
> Sent: Monday, October 30, 2006 2:59 PM
> To: Venkat Yekkirala
> Cc: sds@tycho.nsa.gov; selinux@tycho.nsa.gov; latten@austin.ibm.com;
> hallyn@elg11.watson.ibm.com
> Subject: Re: Question on checks against unlabeled
>
>
> The intention was to prevent the case that a machine can communicate
> to another machine w/o IPsec, but it has processes that must not use
> unencrypted and/or unlabeled communication.  Thus, it was required
> that a process (actually a socket) that sends w/o IPsec must be able
> to communicate with unlabeled security associations.
>
> If we can make it more explicit that a socket requires IPsec or not,
> then we may not need this check.  We can check on process's
> access to
> socket.  I'll think about how we could do this.
>
> Regards,
> Trent.
>
> On Oct 30, 2006, at 3:40 PM, Venkat Yekkirala wrote:
>
> > Hi Trent et al,
> >
> > I have a question on the following checks in
> security/selinux/xfrm.c:
> >
> > Specifically, there's a check against unlabeled_t even when there's
> > no association involved. Is this really intended in the sense of
> > meeting
> > a goal such as a process should always use labeled ipsec or
> was the
> > intention
> > to actually use unlabeled_t only when there's an SA being
> used, but
> > it's
> > not labeled.
> >
> > Thanks,
> >
> > venkat
> >
> > int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
> >                                 struct avc_audit_data *ad)
> > {
> >         int i, rc = 0;
> >         struct sec_path *sp;
> >         u32 sel_sid = SECINITSID_UNLABELED;
> >
> >         sp = skb->sp;
> >
> >         if (sp) {
> >                 for (i = 0; i < sp->len; i++) {
> >                         struct xfrm_state *x = sp->xvec[i];
> >
> >                         if (x && selinux_authorizable_xfrm(x)) {
> >                                 struct xfrm_sec_ctx *ctx = x-
> > >security;
> >                                 sel_sid = ctx->ctx_sid;
> >                                 break;
> >                         }
> >                 }
> >         }
> >
> >         rc = avc_has_perm(isec_sid, sel_sid, SECCLASS_ASSOCIATION,
> > /*
> >  * POSTROUTE_LAST hook's XFRM processing:
> >  * If we have no security association, then we need to determine
> >  * whether the socket is allowed to send to an unlabelled
> destination.
> >  * If we do have a authorizable security association, then it has
> > already been
> >  * checked in xfrm_policy_lookup hook.
> >  */
> > int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
> >                                         struct avc_audit_data *ad)
> > {
> >         struct dst_entry *dst;
> >         int rc = 0;
> >
> >         dst = skb->dst;
> >
> >         if (dst) {
> >                 struct dst_entry *dst_test;
> >
> >                 for (dst_test = dst; dst_test != 0;
> >                      dst_test = dst_test->child) {
> >                         struct xfrm_state *x = dst_test->xfrm;
> >
> >                         if (x && selinux_authorizable_xfrm(x))
> >                                 goto out;
> >                 }
> >         }
> >
> >         rc = avc_has_perm(isec_sid, SECINITSID_UNLABELED,
> > SECCLASS_ASSOCIATION,
> >                           ASSOCIATION__SENDTO, ad);
> > out:
> >         return rc;
> > }
>
> ----------------------------------------------
> Trent Jaeger, Associate Professor
> Pennsylvania State University, CSE Dept
> 346A IST Bldg, University Park, PA 16802
> Email: tjaeger@cse.psu.edu
> Ph: (814) 865-1042, Fax: (814) 865-3176
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
