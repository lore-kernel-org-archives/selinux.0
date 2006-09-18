Message-ID: <36282A1733C57546BE392885C061859201572F5D@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [PATCH 7/7] secid reconciliation-v02: Enforcement for SELinux
Date: Mon, 18 Sep 2006 15:15:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Fri, 8 Sep 2006, Venkat Yekkirala wrote:
> 
> > +	if (selinux_compat_net) {
> > +		err = selinux_xfrm_decode_session(skb, &peersid, 0);
> > +		BUG_ON(err);
> 
> I'm pretty sure this should not be a BUG_ON.  IIUC, you want 
> to panic the 
> kernel because one of the nested SAs has a different security context.

No, we are sending in 0 for the ckall param by which we are telling
the function NOT to do any checks, but to simply set the return param
peersid to the secid on the first xfrm if any and succeed by returning 0.
Must not fail.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
