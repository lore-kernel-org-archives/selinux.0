Subject: Re: MLS context?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200510152027.59150.russell@coker.com.au>
References: <200510152027.59150.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 08:48:34 -0400
Message-Id: <1129553314.26309.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-10-15 at 20:27 +1000, Russell Coker wrote:
> What is the canonical term for the MLS part of the policy?  Currently I've 
> been using the term "MLS context" to refer to the combination of level (or 
> range of levels) and categories (if there are any).
> 
> Is this an OK term?  If not then what should I use?

The correct term would be the "MLS range", where:
a) the range includes a low level and a high level, with the high
defaulting to the low if unspecified,
b) each level consists of a sensitivity and an optional set of
categories, e.g. s0:c0,c3 is a level consisting of sensitivity s0 and
category set {c0, c3}.

> Also it has to be short.  I am NOT going to say "MLS range and optional 
> categories" 100 times in the course of a talk.  Two words is the maximum, if 
> there is no canonical term for this then we need to make something up.
> 
> Also what term should I use for the human-readable version of the above as 
> taken from /etc/mcs.conf?

For MCS, it could just be something like "Compartment name" or similar,
as it is a translation of the compartment set to a human-readable name.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
