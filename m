Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8IItwE4017951
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 14:55:58 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8IItPuA004971
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 18:55:25 GMT
Date: Mon, 18 Sep 2006 14:55:51 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [PATCH 7/7] secid reconciliation-v02: Enforcement for SELinux
In-Reply-To: <45019F72.2050708@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609181452300.5976@d.namei>
References: <45019F72.2050708@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Sep 2006, Venkat Yekkirala wrote:

> This defines SELinux enforcement of the 2 new LSM hooks.
> 

I think this looks ok in general (I have a couple more technical issues), 
athough I believe that Stephen has some question about policy 
construction.

Please rename these hooks:

	+ * @skb_policy_check:
	+ * @skb_netfilter_check

to:

	skb_flow_in
	skb_flow_out



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
