Message-ID: <45466350.5020203@trustedcs.com>
Date: Mon, 30 Oct 2006 14:40:48 -0600
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: tjaeger@cse.psu.edu
CC: sds@tycho.nsa.gov, selinux@tycho.nsa.gov, latten@austin.ibm.com,
        hallyn@elg11.watson.ibm.com
Subject: Question on checks against unlabeled
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Trent et al,

I have a question on the following checks in security/selinux/xfrm.c:

Specifically, there's a check against unlabeled_t even when there's
no association involved. Is this really intended in the sense of meeting
a goal such as a process should always use labeled ipsec or was the intention
to actually use unlabeled_t only when there's an SA being used, but it's
not labeled.

Thanks,

venkat

int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
                                struct avc_audit_data *ad)
{
        int i, rc = 0;
        struct sec_path *sp;
        u32 sel_sid = SECINITSID_UNLABELED;

        sp = skb->sp;

        if (sp) {
                for (i = 0; i < sp->len; i++) {
                        struct xfrm_state *x = sp->xvec[i];

                        if (x && selinux_authorizable_xfrm(x)) {
                                struct xfrm_sec_ctx *ctx = x->security;
                                sel_sid = ctx->ctx_sid;
                                break;
                        }
                }
        }

        rc = avc_has_perm(isec_sid, sel_sid, SECCLASS_ASSOCIATION,
/*
 * POSTROUTE_LAST hook's XFRM processing:
 * If we have no security association, then we need to determine
 * whether the socket is allowed to send to an unlabelled destination.
 * If we do have a authorizable security association, then it has already been
 * checked in xfrm_policy_lookup hook.
 */
int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
                                        struct avc_audit_data *ad)
{
        struct dst_entry *dst;
        int rc = 0;

        dst = skb->dst;

        if (dst) {
                struct dst_entry *dst_test;

                for (dst_test = dst; dst_test != 0;
                     dst_test = dst_test->child) {
                        struct xfrm_state *x = dst_test->xfrm;

                        if (x && selinux_authorizable_xfrm(x))
                                goto out;
                }
        }

        rc = avc_has_perm(isec_sid, SECINITSID_UNLABELED, SECCLASS_ASSOCIATION,
                          ASSOCIATION__SENDTO, ad);
out:
        return rc;
}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
