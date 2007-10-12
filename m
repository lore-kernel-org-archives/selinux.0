Subject: Re: concept of a permissive domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <C33554AE.2F045%csellers@tresys.com>
References: <C33554AE.2F045%csellers@tresys.com>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 17:01:15 -0400
Message-Id: <1192222875.11886.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-12 at 16:43 -0400, Chad Sellers wrote:
> On 10/12/07 3:05 PM, "Karl MacMillan" <kmacmillan@mentalrootkit.com> wrote:
> 
> > On Fri, 2007-10-12 at 14:40 -0400, Chad Sellers wrote:
> >> On 10/12/07 9:50 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> >> 
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA1
> >>> 
> >>> I would like to get this moving again.
> >>> 
> >>> I believe we came to a conclusion that the permissive domain should be
> >>> specified in userspace/policy.  So the next question is who can make the
> >>> change and what is the syntax?
> >>> 
> >>> I see we can do this in two ways.
> >>> 
> >>> One we add a new access to the Process Class called Permissive;
> >>> Which would cause the kernel to put this domain in the permissive
> >>> domain.  I am sure Steven dislikes this suggestion.  :^)
> >>> 
> >>> 
> >>> The second solution is to add a new command to audit, dontaudit,
> >>> auditallow, nerverallow
> >>> 
> >>> So if we add permissiveallow or just permissive.
> >>> 
> >>> What does the syntax look like?
> >>> 
> >>> permissive httpd_t;
> >>> 
> >>> permissive httpd_t self:process *;
> >>> 
> >>> In order to implement this, we need to modify libsepol,
> >>> checkmodule/checkpolicy?
> >>> 
> >>> Anything else?
> >> 
> >> The kernel, for one. Both of these involve new policy constructs that the
> >> kernel would use. Or am I misunderstanding what you're saying?
> >> 
> >> The last message on this thread seems to be Karl's message talking about
> >> potentially doing this in userspace (meaning make libsemanage or something
> >> similar go through policy, allow everything for a domain, auditallow
> >> everything that's not explicitly allowed) and how this is possible but
> >> painful. Did I miss any later follow up to this? Where are we with respect
> >> to doing this in kernel vs. in policy?
> >> 
> >> I really don't care either way any more. My main concern is I want us to
> >> come up with something that doesn't create another new concept to confuse
> >> users. To me, this means either
> >> 1) matches unconfined_t, perhaps call it unconfined_audit and make a domain
> >> unconfined with auditallows. This could be done via Karl's earlier method.
> >> Admittedly, the tool to create the policy would not be easy.
> >> 2) permissive domain that is the same as global permissive. This could be
> >> done via an selinuxfs node (similar to global permissive) and made
> >> persistent by some sort of state in /etc/selinux (like global permissive).
> >> 
> >> I know I may be in the minority here, but I really think we should consider
> >> trying to minimize the differences in concepts we create as much as possible
> >> to avoid complexity creep.
> > 
> > Calling it a permissive domain uses the same concept as global
> > permissive - so I think that is natural. It does not, to me, mean that
> > it should be enabled in the same way as global permissive - that's just
> > an implementation detail. I think it is much better to put it in the
> > policy as that allows some sort of sane delivery mechanism.
> > 
> Calling it one thing and implementing it differently is fine as long as the
> implementation doesn't leak out to the user. And it will here. We're not
> exactly good at making leak-proof abstractions to begin with, but this is a
> case where the user will see a new statement in policy.
> 
> Think of this from the perspective of the user. We have to tell them that
> system-wide permissive is not part of policy, but is instead in a config
> file, done using setenforce, or done using selinuxfs, but per-domain
> permissive is not done by any of those methods, but instead is done in
> policy via a new language construct. This is confusing.

That doesn't seem too bad given that one is a global property of the
system and one is per-domain.  Especially since a permissive domain is
logically the same as an unconfined domain + a matching auditallow
statement for every allow statement.  Whether we implement it that way
or not is open to discussion.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
