Message-Id: <200603221555.k2MFtoNq001984@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <sds@tycho.nsa.gov>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>,
        "'Selinux-Dev'" <selinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] extending the libsepol API
Date: Wed, 22 Mar 2006 10:55:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1143031866.28120.140.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > As for the limited number of accessor functions that currently exist,
> > (users, booleans, etc.) we feel that the current design metaphors don't
> fit
> > well with our requirements and we are not sure what to do about them
> long
> > term as we are presenting something very different, and as I said we are
> > concerned about consistency.  There are several long-term options: 1.
> > Deprecate them in source and keep them for ABI stability, 2. Don't do
> number
> > 1 ;)
> 
> Can you clarify why you feel that the current APIs don't meet your
> requirements?

We originally started with the current way of creating opaque keys from
string values and found that the key concept did not scale very well when we
get to accessing rules.  For example, if a type is subtracted in a rule,
does that type appear in the key?  One of our main goals is to make the API
as consistent as possible so we didn't want to try and force the key concept
across the rest of the API as it didn't seem to fit.

In the current implementation there is an issue of who owns the memory in a
key.  The key_create() functions just copy the pointer and not the contents
of the string, so a key 'object' can live longer than the string used to
create it and thus is easily misused by users of the library.  Additionally,
we thought the memory and programming overhead involved in creating, and
destroying the keys was undesirable and not necessary.  For example when we
start iterating over all the types in all the rules of the policy, using
keys can get expensive.  

Kevin Carr
Tresys Technology
410.290.1411 x137



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
