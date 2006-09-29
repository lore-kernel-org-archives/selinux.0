Message-ID: <451D94DB.1010605@hp.com>
Date: Fri, 29 Sep 2006 17:49:15 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, method@gentoo.org, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 1/1] NetLabel: secid reconciliation support
References: <36282A1733C57546BE392885C0618592015CF3A5@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CF3A5@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>@@ -3672,16 +3674,20 @@ static int selinux_skb_flow_in(struct sk
>> 	if (err)
>> 		goto out;
>> 
>>-	if (xfrm_sid) {
>>-		err = security_transition_sid(xfrm_sid, skb->secmark,
>>-						
>>SECCLASS_PACKET, &trans_sid);
>>-		if (err)
>>-			goto out;
>>+	if (xfrm_sid)
>>+		skb->secmark = xfrm_sid;
>> 
>>-		skb->secmark = trans_sid;
>>-	}
>>+	err = selinux_netlbl_skb_sid(skb, skb->secmark, &nlbl_sid);
> 
> 
> I take it nlbl_sid here will be 0 if netlabel is NOT configured
> for the traffic correct?

That would be the desired behavior yes, however, in verifying this
against the
patch I posted I noticed that the dummy function in
security/selinux/include/selinux_netlabel.h is wrong - it should be replaced
with the following (I mistakenly set it to SECINITSID_UNLABELED):

static inline int selinux_netlbl_skb_sid(struct sk_buff *skb,
                                         u32 base_sid,
                                         u32 *sid)
{
        *sid = 0;
        return 0;
}

>>--- net-2.6.orig/security/selinux/ss/mls.c
>>+++ net-2.6/security/selinux/ss/mls.c
>>@@ -547,7 +547,7 @@ int mls_compute_sid(struct context *scon
>> 				                     
> 
> &rtr->target_range);
> 
>> 			}
>> 		}
>>-		else if (tclass == SECCLASS_PACKET)
>>+		if (tclass == SECCLASS_PACKET)
> 
> 
> What's the purpose of getting rid of "else" above?

Fix a compile problem - the braces above the else belong to a for loop.
 Feel free to disregard this, it was one of the changes I had to make to
your patch to get it to compile against the latest net-2.6 tree.

> I haven't reviewed the netlbl native changes, but the hooks.c changes
> seem ok to me.

Okay, if you have any other questions you know where to find me.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
