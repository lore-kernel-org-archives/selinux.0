Message-ID: <36282A1733C57546BE392885C0618592015CF83F@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: johnpol@2ka.mipt.ru, herbert@gondor.apana.org.au, davem@davemloft.net,
        sds@tycho.nsa.gov, paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: RE: [PATCH] Fix for IPsec leakage with SELinux enabled - V.02
Date: Wed, 4 Oct 2006 09:58:15 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[ CCing selinux ]

Oops! Here's the explanation:

Currently when an IPSec policy rule doesn't specify a security
context, it is assumed to be "unlabeled" by SELinux, and so
the IPSec policy rule fails to match to a flow that it would
otherwise match to, unless one has explicitly added an SELinux
policy rule allowing the flow to "polmatch" to the "unlabeled"
IPSec policy rules. In the absence of such an explicitly added
SELinux policy rule, the IPSec policy rule fails to match and
so the packet(s) flow in clear text without the otherwise applicable
xfrm(s) applied.

The above SELinux behavior violates the SELinux security notion of
"deny by default" which should actually translate to "encrypt by
default" in the above case.

With this patch applied, SELinux "polmatching" of flows Vs. IPSec
policy rules will only come into play when there's a explicit context
specified for the IPSec policy rule (which also means there's corresponding
SELinux policy allowing appropriate domains/flows to polmatch to this
context).

> -----Original Message-----
> From: James Morris [mailto:jmorris@namei.org]
> Sent: Wednesday, October 04, 2006 8:03 AM
> To: Venkat Yekkirala
> Cc: johnpol@2ka.mipt.ru; herbert@gondor.apana.org.au;
> davem@davemloft.net; sds@tycho.nsa.gov; paul.moore@hp.com
> Subject: Re: [PATCH] Fix for IPsec leakage with SELinux enabled - V.02
> 
> 
> On Tue, 3 Oct 2006, Venkat Yekkirala wrote:
> 
> > Following is the patch that should prevent the kind of "leaks"
> > that Evgeniy reported that were ostyensibly caused by the current
> > labeled-ipsec design requiring rules to be added for ipsec policy
> > to match.
> 
> Also, I think some explanation of this patch would be useful.
> 
> -- 
> James Morris
> <jmorris@namei.org>
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
