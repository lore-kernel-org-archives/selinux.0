Subject: Re: concept of a permissive domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <46E98E93.40206@redhat.com>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <46E6FB25.5070507@redhat.com>
	 <1189545987.4823.6.camel@localhost.localdomain>
	 <1189692512.18713.61.camel@moss-spartans.epoch.ncsc.mil>
	 <1189694812.3538.20.camel@localhost.localdomain>
	 <1189695443.18713.95.camel@moss-spartans.epoch.ncsc.mil>
	 <46E98E93.40206@redhat.com>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 15:38:18 -0400
Message-Id: <1189712298.18713.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-13 at 15:25 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Thu, 2007-09-13 at 10:46 -0400, Karl MacMillan wrote:
> >> On Thu, 2007-09-13 at 10:08 -0400, Stephen Smalley wrote:
> >>> On Tue, 2007-09-11 at 17:26 -0400, Karl MacMillan wrote:
> >>>> On Tue, 2007-09-11 at 16:31 -0400, Daniel J Walsh wrote:
> >>>> [...]
> >>>>> One other feature/requirement would be to not override dontaudit rules.
> >>>>> So if I have a domain in permissive mode and I have a dontaudit rule  on
> >>>>> reading /etc/shadow.  The app should still be denied reading
> >>>>> /etc/shadow.  (This is not a show stopper, but would allow us to force
> >>>>> apps to take the code paths they will take in enforcing mode.)
> >>>> This isn't specific to per-domain permissive, right? It would be useful
> >>>> in general for permissive.
> >>> I would be opposed to such a change, as it is a semantic change to what
> >>> dontaudit means.
> >>>
> >>> Keep in mind that allow, auditallow, and dontaudit/auditdeny are all
> >>> independent of one another today and none of them imply the other, e.g.
> >>> 	allow a b:file read;
> >>> 	auditallow a b:file *;
> >>> 	dontaudit a b:file *;
> >>> is perfectly valid and means:
> >>> - Let a read files labeled b,
> >>> - Audit all permission grantings from a to files labeled b,
> >>> - Don't audit any permission denials from a to files labeled b.
> >>>
> >> I agree that changing the dontaudit semantic has problems - however the
> >> reason Dan suggested is still valid. Currently, generating policy in
> >> permissive mode can lead to bogus or overly permissive policy. It would
> >> be nice to have some solution to that problem.
> > 
> > Can't you handle that in the tool, by giving matching interfaces with
> > dontaudit rules precedence over ones with allow rules and asking the
> > user?
> > 
> > I'd actually rather see an improved capability for (more easily)
> > generating policy incrementally in enforcing mode.  That would make it
> > more suitable for production use and avoid the problem above.
> > 
> Said large financial institution rols out policy for managing huge money
> transactions in permissive mode.   Policy build with a pam for verifying
> users.

Note that I said it would be better to provide a capability to let
people develop policy incrementally while in enforcing mode, not
permissive mode.

> Users selected app_uses_pam in policy design tool.
> 
> Tool adds
> 
> dontaudit financeapp_t shadow_t:file r_file_perms;
> 
> App in permissive mode reads shadow perms.  Dontaudit covers it up.

So don't do that.  Don't include new dontaudit rules while generating
policy in permissive mode, and let the user decide whether to select the
dontaudit branch or the allow branch in the final form of the generated
policy.  For that matter, we should really minimize use of dontaudit
rules whenever possible - if we can fix the code to _default_ to the
less privileged code path and only try the more privileged code path if
it truly needs it, then we should do that.

> App runs for three months.  policy writer sees no avc messages for a
> long time,  Thinks everything is fine.
> 
> Turns on enforcing mode, app tries to authenticate on mysql, gets
> denials apps blow up, millions lost, people say selinux sucks, policy
> writer is fired.
> 
> If I want the current behavior to see full permissive mode, I can
> semodule -DB or build my policy without dontaudit.
> 
> permissive mode not following code path of dontaudit would causes major
> problems.

Let me say it again - dontaudit rules don't affect whether or not
something is allowed in SELinux today; they are NOT deny rules.  If you
want deny rules, add those (gasp).  Permissive mode is simply following
the code path of allowing everything, as requested.

> fired.

You can't fire me that easily.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
