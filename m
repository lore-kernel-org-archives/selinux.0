Message-ID: <43F5E12E.70003@trustedcs.com>
Date: Fri, 17 Feb 2006 08:43:58 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: Re: [RFC] [PATCH]
References: <43F49805.2000109@trustedcs.com>	 <1140113563.12655.140.camel@moss-spartans.epoch.ncsc.mil>	 <43F4DBE0.3060204@trustedcs.com> <1140122205.12655.171.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1140122205.12655.171.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-02-16 at 14:09 -0600, Darrel Goeddel wrote:
> 
>>True on role dominance.  No on constraint_expr_eval - I'll give it a look.
> 
> 
> Note that we'd still want separate audit representation (so that we
> don't expose the constraint representation directly to audit), but could
> convert it to constraint form during rule setup and then just feed it to
> constraint_expr_eval or some common helper.
> 
> 
>>I'll add some comments for that.  A rule will get reprocessed when a new
>>policy is loaded (triggered by the seqno check in security_aurule_match).
>>That will then reset the au_skip field appropriately.  The idea behind this
>>is to allow a rule to be present for a type, role, etc. that does not exist
>>in the current policy, but they are never processed.  If the item is included
>>in a policy that is loaded later, the rule will be setup completely and
>>activated (au_skip = 0).  Conversely, if an item disappears, the rule is
>>just inactivated.
>>
>>This give the same behavior as the other audit rule fields.  For example, a
>>rule can be there for a uid that is not used on the system and it will simply
>>never match.  If that uid is later used on the system, the rule will then be
>>used.  Same goes for inums that aren't used and probably most other fields...
> 
> 
> True, but seems prone to error, e.g. user typo on a name or user using
> an obsolete name never knows he made a mistake.  Unless auditctl itself
> does validity checking, which requires it to interact with
> libsemanage/libsepol.
> 

Yes it does, but that seems to be the nature of the beast with the audit rules.
If we perform the validity check at this level, we may bonk rules that we really
do want to enforce.  There is also the question of how to handle a situation
like the following:

- we have an audit filter set up for matching the role darrel_r
- we load a policy that does not have darrel_r
- we reload the original policy

In the current scheme, the rule would simply become inactive when the policy
does not contain the target, and it would be reactivated when a policy that
did contain the target was loaded.  We would never miss an action involving
darrel_r.

If we needed to toss out the darrel_r rule because it became invalid, later
operations involving darrel_r would go unaudited unless the audit rules
are reloaded along with a policy reload.  Do we want to marry policy loads
with audit filter loads (and how would we know which filter to load anyway)?

It would seem to me that we need the current functionality of keeping all rules
that are set up and revalidating them upon policy loads.  If we don't do it here,
it would need to be done at the audit layer - it might not be as pretty there.

As the policy becomes more dynamic (adding/removing policy modules, etc.) this
would become more of a problem.

Anybody else have an idea on this (Steve G)?  Am I being to paranoid about usage?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
