Message-ID: <4523CAEB.4070200@hp.com>
Date: Wed, 04 Oct 2006 10:53:31 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        eparis@redhat.com
Subject: Re: [PATCH 1/1] secid reconcialiation: Replace unlabeled_t with	the
 network_t
References: <45231F6F.4030509@trustedcs.com>  <4523C655.7010008@hp.com> <1159973254.14831.71.camel@sgc>
In-Reply-To: <1159973254.14831.71.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-10-04 at 10:33 -0400, Paul Moore wrote:
> 
>>Venkat Yekkirala wrote:
>>
>>>The following replaces unlabeled_t with network_t for
>>>better characterization of the flow out/in checks in
>>>SELinux, as well as to allow for mls packets to
>>>flow out/in from the network since network_t would allow
>>>the full range of MLS labels, as opposed to the unlabeled init sid
>>>that only allows system-hi.
>>>
>>>Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
>>>---
>>>This is an incremental patch the secid-reconcilation v4 patchset.
>>>
>>>--- net-2.6.sid3/security/selinux/hooks.c	2006-10-01 15:43:12.000000000 -0500
>>>+++ net-2.6/security/selinux/hooks.c	2006-10-03 16:43:21.000000000 -0500
>>>@@ -3703,7 +3703,8 @@ static int selinux_skb_flow_in(struct sk
>>> 	err = selinux_xfrm_decode_session(skb, &xfrm_sid, 0);
>>> 	BUG_ON(err);
>>> 
>>>-	err = avc_has_perm(xfrm_sid, skb->secmark, SECCLASS_PACKET,
>>>+	err = avc_has_perm(xfrm_sid, skb->secmark? : SECINITSID_NETMSG,
>>>+					SECCLASS_PACKET,
>>> 					PACKET__FLOW_IN, NULL);
>>> 	if (err)
>>> 		goto out;
>>>@@ -3900,7 +3901,7 @@ static unsigned int selinux_ip_postroute
>>> 				skb->secmark = sksec->sid;
>>> 			}
>>> 		}
>>>-		err = avc_has_perm(skb->secmark, SECINITSID_UNLABELED,
>>>+		err = avc_has_perm(skb->secmark, SECINITSID_NETMSG,
>>> 				   SECCLASS_PACKET, PACKET__FLOW_OUT, &ad);
>>> 	}
>>> out:
>>
>>Considering the above change, I wonder if it would also make sense to
>>update the secmark to SECINITSID_UNLABELED in the abscence of any
>>external labeling (labeled IPsec or NetLabel)?
>  
> Wouldn't that make secmark useless in the non labeled networking case?
> 

Sorry, I didn't do a very good job explaining things in my first email
so let me try it again ...

If there is no external labeling, i.e. labeled IPsec or NetLabel, *and*
the secmark is equal to zero/SECSID_NULL I think it might be a good idea
to set the secmark to SECINITSID_NETMSG.

This not affect either local or external labels if they are present, but
if both are not it would give the secmark some meaningful value.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
