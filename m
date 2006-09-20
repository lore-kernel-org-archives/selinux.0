Message-ID: <4511C4A8.2090709@hp.com>
Date: Wed, 20 Sep 2006 18:46:00 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH 7/7] secid reconciliation-v02: Enforcement for SELinux
References: <36282A1733C57546BE392885C061859201573267@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201573267@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>+static int selinux_skb_policy_check(struct sk_buff *skb, 
>>
>>unsigned short
>>
>>>family) +{
>>>+	u32 xfrm_sid, trans_sid;
>>>+	int err;
>>>+
>>>+	if (selinux_compat_net)
>>>+		return 1;
>>>+
>>>+	err = selinux_xfrm_decode_session(skb, &xfrm_sid, 0);
>>>+	BUG_ON(err);
>>
>>First, any reason against including the "struct sock *" in 
>>the LSM hook?  At a 
>>quick glance it looks like it is available at each place 
>>security_skb_policy_check() is invoked?  If there are no 
>>objections I would 
>>like to see it included in the hook.
>  
> There's no sock available (NULL) for forward, no-sock, time-wait cases, etc.

... which would be why I should have taken a closer look :)

> What you are trying to accomplish with the sock here anyway?

Actually this is no longer an issue because of something else - you can
ignore this now.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
