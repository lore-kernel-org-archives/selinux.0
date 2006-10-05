Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95NUa2V007411
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 19:30:36 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95NTNqJ017267
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 23:29:23 GMT
Date: Thu, 5 Oct 2006 19:30:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: "David S. Miller" <davem@davemloft.net>, Paul Moore <paul.moore@hp.com>,
        netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        johnpol@2ka.mipt.ru, Herbert Xu <herbert@gondor.apana.org.au>
Subject: RE: [PATCH 1/3] Fix for IPsec leakage with SELinux enabled - V.03
In-Reply-To: <36282A1733C57546BE392885C0618592015CFB62@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0610051918080.26924@d.namei>
References: <36282A1733C57546BE392885C0618592015CFB62@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Oct 2006, Venkat Yekkirala wrote:

> > > -		if (xfrm_policy_match(pol, fl, type, family, dir)) {
> > > +		err = xfrm_policy_match(pol, fl, type, family, dir);
> > > +		if (err) {
> > > +			if (err == -ESRCH)
> > > +				continue;
> > > +			else {
> > > +				ret = ERR_PTR(err);
> > > +				goto fail;
> > > +			}
> > > +		} else {
> > 
> > Semantics issue: if the exact policy match fails with 
> > -EACCESS, should we 
> > then try an inexact match before failing?
> 
> I wonder what you mean by an inexact match here.

There are two policy chains in the kernel: 'bydst'for non-prefixed 
addresses (e.g. /32 or /128 nodes) and 'byidx' for prefixed addresses.

xfrm_policy_lookup_bytype() first checks for a non-prefixed match and then 
for a prefixed match with a higher priority mark.

So, I wonder if it makes sense to continue on to the prefixed lookup if we 
get an -EACCESS on the non-prefixed lookup.

Perhaps some further discussion on this with MLS folk is needed, but in 
any case, I don't think it should block this patchset going in as a 
bugfix, as the behavior can be changed in a further patch if required.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
