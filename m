Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88KAANw032759
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 16:10:10 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88K9jW3022172
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 20:09:45 GMT
Date: Fri, 8 Sep 2006 16:10:07 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [PATCH 2/7] secid reconciliation-v02: Add LSM hooks
In-Reply-To: <45019F5C.3030102@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609081609210.7675@d.namei>
References: <45019F5C.3030102@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Sep 2006, Venkat Yekkirala wrote:

> Add skb_policy_check and skb_netfilter_check hooks to LSM to enable
> reconciliation of the various security identifiers as well as enforce
> flow control on inbound (INPUT/FORWARD) and outbound (OUTPUT/FORWARD)
> traffic.

Is there any way you can send patches without "format=flowed" in the 
content-type?  On two mailers I've tried, the patches get mangled.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
