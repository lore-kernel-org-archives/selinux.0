Subject: Re: [PATCH 2/2] userland support for new range_transition
	statements
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <44D0D516.5010906@trustedcs.com>
References: <44CA298B.7080706@trustedcs.com>
	 <1154438074.23513.30.camel@twoface.columbia.tresys.com>
	 <44D0D516.5010906@trustedcs.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 15:51:29 -0400
Message-Id: <1154548289.27457.96.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-02 at 11:38 -0500, Darrel Goeddel wrote:
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
> >>+       struct range_trans_rule *next;
> >>+} range_trans_rule_t;
> >>+
> > 
> > 
> > Are we sure that mls_range_t is semantic enough to store the rule, even
> > in a module situation where all the symbols are not present?
> 
> Hmmm...  I assume that you have MLS requirements in mind when you say that,
> especially the '.' notation.  The problem is that if we specify "s4:c0.c12" as
> the range, how do we know what will be between c0 and c12 (they are arbitrary
> names).  Are you suggesting possibly storing the string and figuring the whole
> thing out at expand time?
> 

Or storing the start and end of the range. This seems analogous to
attributes to me and we defer interpreting them until expand time.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
