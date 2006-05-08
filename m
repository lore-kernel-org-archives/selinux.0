Subject: Re: [PATCH] fix warnings in selinux-usr
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>,
        selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1147094001.32719.12.camel@jackjack.columbia.tresys.com>
References: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>
	 <1147092580.23640.15.camel@moss-spartans.epoch.ncsc.mil>
	 <1147094001.32719.12.camel@jackjack.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-IHq6HdH6YEqpDBcr0rrm"
Date: Mon, 08 May 2006 11:16:10 -0400
Message-Id: <1147101370.32719.30.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IHq6HdH6YEqpDBcr0rrm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-05-08 at 09:13 -0400, Karl MacMillan wrote:
> On Mon, 2006-05-08 at 08:49 -0400, Stephen Smalley wrote:
> > On Fri, 2006-05-05 at 12:18 -0400, Karl MacMillan wrote:
> > > Steve,
> > > 
> > > Attached is a patch that fixes many warnings that have crept into the
> > > selinux-usr code over time, making it difficult to ascertain whether
> > > code changes have introduced new warnings.
> > > 
> > > Fixing some of the warnings required the introduction of unsafe casts,
> > > but those casts were occurring implicitly anyway (see
> > > libsemanage/src/booleans_policydb.c for an example).
> > > 
> > > I fixed one of the long standing lex warnings that has always been
> > > irritating, but I was unable to fix the warnings in the semanage
> > > configuration file parser. That parser should not rewritten to remove
> > > the lex dependency in the future anyway.
> > 
> > Merged, although some of the changes seemed unnecessary to me (e.g. it
> > is ok to name a variable 'index', and the compiler will let you know if
> > you then try to use it as a function in the same scope),
> 
> Sure, but my goal was simply to get rid or warnings. For me, constant
> warnings makes it much harder to scan the compiler output for problems.
> 
> >  and leaving the
> > libsemanage warnings was intentional by Ivan to flag the fact that we
> > are making an assumption about the equivalence between the libsemanage
> > and libsepol structs.
> 
> Again, I wanted to suppress these warnings. Additionally, I think that
> it makes it clearer in the code that something bad is going on.
> 
> >   The patch also included some changes that
> > appeared to be unrelated to fixing warnings, like moving code from
> > util.c to policydb.c 
> 
> I should have tagged this as an additional change. Those functions were
> already prototyped in policydb.h and were not really "utility"
> functions. I noticed the problem when fixing a warning so I went ahead
> and made the change.
> 
> > and upgrading the scope of role/user statements
> > from SCOPE_REQ to SCOPE_DECL automatically,
> 
> Hmm . . . this must have been in the local copy I started from. Josh, is
> this change correct?
> 

Looks like I cut-and-paste from the wrong window. Attached is a patch to
revert this change until we have had a chance to test it for
side-effects.

Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com

> >  and adding the -a option to
> > semodule_expand.
> > 
> 
> Again, should have tagged this. I added this while doing some debugging
> and forgot about it.
> 
> Karl
> 


--=-IHq6HdH6YEqpDBcr0rrm
Content-Disposition: attachment; filename=revert-decl-upgrade-20060508.diff
Content-Type: text/x-patch; name=revert-decl-upgrade-20060508.diff; charset=utf-8
Content-Transfer-Encoding: base64

ZGlmZiAtLWV4Y2x1ZGU9LnN2biAtcHJ1TiAuLi8uLi90cnVuay9saWJzZXBvbC9zcmMvcG9saWN5
ZGIuYyAuL2xpYnNlcG9sL3NyYy9wb2xpY3lkYi5jDQotLS0gLi4vLi4vdHJ1bmsvbGlic2Vwb2wv
c3JjL3BvbGljeWRiLmMJMjAwNi0wNS0wOCAxMDo0NjozOS4wMDAwMDAwMDAgLTA0MDANCisrKyAu
L2xpYnNlcG9sL3NyYy9wb2xpY3lkYi5jCTIwMDYtMDUtMDggMTE6MTA6MjMuMDAwMDAwMDAwIC0w
NDAwDQpAQCAtMTExOCw3ICsxMTE4LDcgQEAgaW50IHN5bXRhYl9pbnNlcnQocG9saWN5ZGJfdCAq
cG9sLCB1aW50Mw0KICAgICAgICAgICAgICAgICBpZiAoc3ltICE9IFNZTV9ST0xFUyAmJiBzeW0g
IT0gU1lNX1VTRVJTKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC0yOw0KICAg
ICAgICAgICAgICAgICB9DQotICAgICAgICAgICAgICAgCXNjb3BlX2RhdHVtLT5zY29wZSA9IFND
T1BFX0RFQ0w7IA0KKyAgICAgICAgICAgICAgICANCiAgICAgICAgIH0NCiAgICAgICAgIGVsc2Ug
aWYgKHNjb3BlX2RhdHVtLT5zY29wZSAhPSBzY29wZSkgew0KICAgICAgICAgICAgICAgICAvKiBz
Y29wZSBkb2VzIG5vdCBtYXRjaCAqLw0K


--=-IHq6HdH6YEqpDBcr0rrm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
