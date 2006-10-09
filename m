Message-ID: <36282A1733C57546BE392885C0618592015CFD4D@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: David Miller <davem@davemloft.net>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, eparis@redhat.com, johnpol@2ka.mipt.ru,
        herbert@gondor.apana.org.au
Subject: RE: [PATCH 0/3] Fix for IPsec leakage with SELinux enabled - V.03
Date: Mon, 9 Oct 2006 11:42:18 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > My apologies. The second one is also numbered 1, but has the
> > following distinct subject line:
> > [PATCH 1/3] Fix for IPsec leakage with SELinux enabled - 
> V.03: Fix xfrm code
> 
> I definitely deleted one of them, since I usually get N copies
> of very single patch posting and two of them looked identical:)

I guess this is probably the reason why I don't see the fix in net-2.6.git
yet :) I will resend the patchset with the subject titles fixed up since
it needs to be in 2.6.19.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
