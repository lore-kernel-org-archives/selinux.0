MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH RETRY 2/3] Optionally expand neverallows
Date: Fri, 28 Jul 2006 09:33:00 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832A96D@exchange.columbia.tresys.com>
In-Reply-To: <1154089017.31881.22.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <kmacmillan@mentalrootkit.com>,
        "Jeremy Mowery" <jmowery@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Thu, 2006-07-27 at 14:34 -0400, Joshua Brindle wrote:
> > Index: trunk/libsepol/src/link.c
> > ===================================================================
> > --- trunk/libsepol/src/link.c	(revision 951)
> > +++ trunk/libsepol/src/link.c	(working copy)
> > @@ -965,8 +965,7 @@
> >  			    
> module->map[SYM_CLASSES][cur_perm->class - 1];
> >  			assert(new_perm->class);
> >  
> > -			if (new_rule->
> > -			    specified & (AVRULE_AV | 
> AVRULE_NEVERALLOW)) {
> > +			if (new_rule->specified & (AVRULE_AV)) {
> >  				for (i = 0;
> >  				     i <
> >  				     
> module->perm_map_len[cur_perm->class - 1];
> > 
> > 
> > > Hmm...do you want alwaysexpand = 1 for the do_neverallow case?
> > > Otherwise, type attributes might not get expanded.  Does 
> > > expand_avtab_insert need to know about AVTAB_NEVERALLOW?
> > 
> > No, apol doesn't always want the attributes expanded out, 
> it knows how 
> > to deal with attributes.
> 
> Hmm...but is apol ok with the fact that attributes will be 
> expanded in some cases here, since we always expand attributes for:
> - type rules
> - self rules
> - type sets that have negative sets (-) or flags (~)
> 
> I'm not sure I understand what apol wants as output; at 
> present, it will get a mixture of expanded and unexpanded attributes.
> 

Not a problem, apol is using the avtab to quickly find rules
(semantically) and resolve them to syntactic source lines if possible.
If the syntactic match doesn't match what the user requested (eg., it is
an indirect match but the user didn't request that) it can filter it out
at that time. The avtab is just a way of quickly looking up the rules
(which is also why they wanted neverallows in the avtab).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
