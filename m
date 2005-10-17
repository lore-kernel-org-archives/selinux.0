Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9HEjUNs028576
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 10:45:31 -0400 (EDT)
Received: from mail25.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9HEgjSN004581
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 14:42:45 GMT
Date: Mon, 17 Oct 2005 10:43:05 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: MLS context?
In-Reply-To: <1129553314.26309.13.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.63.0510171039370.23131@excalibur.intercode>
References: <200510152027.59150.russell@coker.com.au>
 <1129553314.26309.13.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Oct 2005, Stephen Smalley wrote:

> On Sat, 2005-10-15 at 20:27 +1000, Russell Coker wrote:
> > What is the canonical term for the MLS part of the policy?  Currently I've 
> > been using the term "MLS context" to refer to the combination of level (or 
> > range of levels) and categories (if there are any).
> > 
> > Is this an OK term?  If not then what should I use?
> 
> The correct term would be the "MLS range", where:
> a) the range includes a low level and a high level, with the high
> defaulting to the low if unspecified,
> b) each level consists of a sensitivity and an optional set of
> categories, e.g. s0:c0,c3 is a level consisting of sensitivity s0 and
> category set {c0, c3}.

I also simply use 'MLS field', as it's a field of the security context.

> > Also what term should I use for the human-readable version of the above as 
> > taken from /etc/mcs.conf?
> 
> For MCS, it could just be something like "Compartment name" or similar,
> as it is a translation of the compartment set to a human-readable name.

I've been using MCS category.

There's another use of 'compartment' which is synonymous with 'security 
level', so I avoid the term.

(Where security level = sensitivity + categories).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
