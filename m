Subject: Re: concept of a permissive domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1192216021.11886.39.camel@moss-spartans.epoch.ncsc.mil>
References: <C33537E7.2F014%csellers@tresys.com>
	 <1192216021.11886.39.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 15:30:31 -0400
Message-Id: <1192217431.11886.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-12 at 15:07 -0400, Stephen Smalley wrote:
> On Fri, 2007-10-12 at 14:40 -0400, Chad Sellers wrote:
> > On 10/12/07 9:50 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> > 
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > I would like to get this moving again.
> > > 
> > > I believe we came to a conclusion that the permissive domain should be
> > > specified in userspace/policy.  So the next question is who can make the
> > > change and what is the syntax?
> > > 
> > > I see we can do this in two ways.
> > > 
> > > One we add a new access to the Process Class called Permissive;
> > > Which would cause the kernel to put this domain in the permissive
> > > domain.  I am sure Steven dislikes this suggestion.  :^)
> > > 
> > > 
> > > The second solution is to add a new command to audit, dontaudit,
> > > auditallow, nerverallow
> > > 
> > > So if we add permissiveallow or just permissive.
> > > 
> > > What does the syntax look like?
> > > 
> > > permissive httpd_t;
> > > 
> > > permissive httpd_t self:process *;
> > > 
> > > In order to implement this, we need to modify libsepol,
> > > checkmodule/checkpolicy?
> > > 
> > > Anything else?
> > 
> > The kernel, for one. Both of these involve new policy constructs that the
> > kernel would use. Or am I misunderstanding what you're saying?
> > 
> > The last message on this thread seems to be Karl's message talking about
> > potentially doing this in userspace (meaning make libsemanage or something
> > similar go through policy, allow everything for a domain, auditallow
> > everything that's not explicitly allowed) and how this is possible but
> > painful. Did I miss any later follow up to this? Where are we with respect
> > to doing this in kernel vs. in policy?
> > 
> > I really don't care either way any more. My main concern is I want us to
> > come up with something that doesn't create another new concept to confuse
> > users. To me, this means either
> > 1) matches unconfined_t, perhaps call it unconfined_audit and make a domain
> > unconfined with auditallows. This could be done via Karl's earlier method.
> > Admittedly, the tool to create the policy would not be easy.
> 
> Two possible stumbling blocks there:
> 1) auditallow will audit every permission check, while permissive only
> audits the first occurrence (for a given source context, target context,
> target class triple, which may actually cover multiple processes and/or
> objects).  The permissive behavior was designed to avoid flooding the
> audit logs with duplicate information, but it does have the disadvantage
> that we don't see every denial, which could be useful when trying to
> generate a policy from the auxiliary audit information beyond just the
> contexts and classes (e.g. if you want to do pattern matching ala MITRE
> Polgen on application behavior).  Also, the flooding problem is somewhat
> alleviated by the recent change to not recheck on every read/write but
> only when necessary, although that only dealt with read/write, not e.g.
> socket sends and receives.
> 
> 2) auditallow yields avc granted messages, whereas all policy tools
> today look for avc denied messages.  And we use auditallow statements in
> policy today to catch certain important events, so we'd have to make
> sure that the tools don't accidentally generate from those audit
> messages (well, I suppose they would be redundant and filterable on
> domain).
> 
> > 2) permissive domain that is the same as global permissive. This could be
> > done via an selinuxfs node (similar to global permissive) and made
> > persistent by some sort of state in /etc/selinux (like global permissive).
> 
> That would be more like today's permissive mode, but as others have
> pointed out, the per-domain permissive mode is more like an unconfined
> domain and it would be useful to be able to see it in the policy for
> analysis and management purposes.

Possible stumbling blocks on the second (kernel) approach:
1) It doesn't address userspace object managers at all - we'd have to
change libselinux too, and provide a selinuxfs interface for checking
whether a context is permissive.
2) It doesn't provide any flexibility in what we allow to the domain,
merely "if the source context has domain X, allow it", versus the more
granular control we have in defining unconfined domains today.  That of
particular concern if some checks don't quite follow the conventional
subject-object form.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
