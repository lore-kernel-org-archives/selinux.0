Message-ID: <36282A1733C57546BE392885C0618592015CFB5B@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: David Miller <davem@davemloft.net>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, eparis@redhat.com, johnpol@2ka.mipt.ru,
        herbert@gondor.apana.org.au
Subject: RE: [PATCH 0/3] Fix for IPsec leakage with SELinux enabled - V.03
Date: Thu, 5 Oct 2006 17:07:59 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > This version takes into account David Miller's comments
> > regarding treatment of security layer errors in the case
> > of socket policies. Specifically, these errors will be
> > treated like how these kind of errors are treated for
> > the main/sub policies, which is to return a full lookup
> > failure.
> 
> I only have patches "1" and "3" in my inbox, did you forget
> to send the second one out or are they simply misnumbered?
> 

My apologies. The second one is also numbered 1, but has the
following distinct subject line:
[PATCH 1/3] Fix for IPsec leakage with SELinux enabled - V.03: Fix xfrm code

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
