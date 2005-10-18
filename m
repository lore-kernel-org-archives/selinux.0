From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@namei.org>
Subject: Re: MLS context?
Date: Tue, 18 Oct 2005 21:33:45 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>
References: <200510152027.59150.russell@coker.com.au> <1129553314.26309.13.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.63.0510171039370.23131@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.63.0510171039370.23131@excalibur.intercode>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510182133.56086.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 18 October 2005 00:43, James Morris <jmorris@namei.org> wrote:
> > > What is the canonical term for the MLS part of the policy?  Currently
> > > I've been using the term "MLS context" to refer to the combination of
> > > level (or range of levels) and categories (if there are any).
> > >
> > > Is this an OK term?  If not then what should I use?
> >
> > The correct term would be the "MLS range", where:
> > a) the range includes a low level and a high level, with the high
> > defaulting to the low if unspecified,
> > b) each level consists of a sensitivity and an optional set of
> > categories, e.g. s0:c0,c3 is a level consisting of sensitivity s0 and
> > category set {c0, c3}.
>
> I also simply use 'MLS field', as it's a field of the security context.

However it is two fields, the level/range and the optional categories.

> > > Also what term should I use for the human-readable version of the above
> > > as taken from /etc/mcs.conf?
> >
> > For MCS, it could just be something like "Compartment name" or similar,
> > as it is a translation of the compartment set to a human-readable name.
>
> I've been using MCS category.
>
> There's another use of 'compartment' which is synonymous with 'security
> level', so I avoid the term.

True, "compartment" is used in many different contexts so using category 
instead makes sense.  Also you have defined "MCS" as "multi-category 
security" not "multi-compartment security"...

Of course "MCS categories" is probably better as there are usually more than 
one.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
