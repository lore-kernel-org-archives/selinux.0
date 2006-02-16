Subject: Re: [RFC] [PATCH]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <43F4DBE0.3060204@trustedcs.com>
References: <43F49805.2000109@trustedcs.com>
	 <1140113563.12655.140.camel@moss-spartans.epoch.ncsc.mil>
	 <43F4DBE0.3060204@trustedcs.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 15:36:45 -0500
Message-Id: <1140122205.12655.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-16 at 14:09 -0600, Darrel Goeddel wrote:
> True on role dominance.  No on constraint_expr_eval - I'll give it a look.

Note that we'd still want separate audit representation (so that we
don't expose the constraint representation directly to audit), but could
convert it to constraint form during rule setup and then just feed it to
constraint_expr_eval or some common helper.

> I'll add some comments for that.  A rule will get reprocessed when a new
> policy is loaded (triggered by the seqno check in security_aurule_match).
> That will then reset the au_skip field appropriately.  The idea behind this
> is to allow a rule to be present for a type, role, etc. that does not exist
> in the current policy, but they are never processed.  If the item is included
> in a policy that is loaded later, the rule will be setup completely and
> activated (au_skip = 0).  Conversely, if an item disappears, the rule is
> just inactivated.
> 
> This give the same behavior as the other audit rule fields.  For example, a
> rule can be there for a uid that is not used on the system and it will simply
> never match.  If that uid is later used on the system, the rule will then be
> used.  Same goes for inums that aren't used and probably most other fields...

True, but seems prone to error, e.g. user typo on a name or user using
an obsolete name never knows he made a mistake.  Unless auditctl itself
does validity checking, which requires it to interact with
libsemanage/libsepol.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
