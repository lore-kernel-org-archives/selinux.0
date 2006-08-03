MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] userland support for new range_transition statements
Date: Thu, 3 Aug 2006 11:55:46 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832ACA7@exchange.columbia.tresys.com>
In-Reply-To: <44D0D516.5010906@trustedcs.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Darrel Goeddel" <dgoeddel@TrustedCS.com>
Cc: "SELinux List" <SELinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
> 
> Joshua Brindle wrote:
> > On Fri, 2006-07-28 at 11:13 -0400, Darrel Goeddel wrote:
> > 
> >>Index: libsepol/include/sepol/policydb/policydb.h
> >>===================================================================
> >>--- libsepol/include/sepol/policydb/policydb.h  (revision 38)
> >>+++ libsepol/include/sepol/policydb/policydb.h  (working copy)
> > 
> > 
> >>+typedef struct range_trans_rule {
> >>+       type_set_t stypes;
> >>+       type_set_t ttypes;
> >>+       class_perm_node_t *classes;     /* only class is used */
> >>+       mls_range_t trange;
> >>+       struct range_trans_rule *next; } range_trans_rule_t;
> >>+
> > 
> > 
> > Are we sure that mls_range_t is semantic enough to store 
> the rule, even
> > in a module situation where all the symbols are not present?
> 
> Hmmm...  I assume that you have MLS requirements in mind when 
> you say that,
> especially the '.' notation.  The problem is that if we 
> specify "s4:c0.c12" as
> the range, how do we know what will be between c0 and c12 
> (they are arbitrary
> names).  Are you suggesting possibly storing the string and 
> figuring the whole
> thing out at expand time?
> 
> We could also make sensitivity and category names 
> non-arbitrary and force the 
> naming convention of s# and c# ;)  Translations take care of 
> human-readable for
> us now...
> 

I understand the desire to do this and chances are the sensitivies and
categories in the policy will never change but I'd also like to stay
away from hard coded policy logic (I'm sure others feel the same way). I
think we are going to have to just store the levels as strings in the
modular format and do sanity checks at expand time (eg., if s12-s0 is in
a policy it will compile fine but the expander will bail). 

I'm not really sure where the best place to do this is, one option is to
use the entire range "s0-s12.c1.c12" as the symbol key in the level
symtab (very strange and awkward, I don't really like it). Otherwise we
can add a string to range_trans_rule_t and store it there, also
non-standard. When doing this we should go ahead and fix user as well
since users aren't allowed in mls modules now.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
