Subject: Re: Questions regarding loadable policy modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Dave Quigley <dquigley@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <1171039284.21799.30.camel@sgc.columbia.tresys.com>
References: <f888952b0702071358p74576f3by6641c1a0df4893e6@mail.gmail.com>
	 <1171039284.21799.30.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 13:20:33 -0500
Message-Id: <1171045233.4975.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-02-09 at 11:41 -0500, Christopher J. PeBenito wrote:
> On Wed, 2007-02-07 at 16:58 -0500, Dave Quigley wrote:
> > I have a few questions about loadable policy modules in SELinux.  It
> > has been mentioned before that certain policy language constructs
> > can't be used within a loadable policy module. Is there a list
> > somewhere for what these are?
> 
> Not that I know of.  I believe the list is:
> 
> object class definition (adding a class and perms)
> genfscon
> portcon
> nodecon
> netifcon
> fs_use_*
> constraints (regular and mls)
> initial sids
> mls component declarations
> - sensitivities
> - categories
> - dominance
> - levels

Or put another way, a non-base module can (presently) only contain TE
and RBAC declarations and rules, and user declarations.

> > I have read through the section on the reference policy in SELinux by
> > Example and it mainly describes a Monolithic policy build. The main
> > question I have about using a modular policy is what in the system is
> > responsible for making sure the proper modules are loaded if you use
> > this method?
> 
> The admin and/or package manager inserts policy modules into the module
> store with the semodule program, which does several things:

Not sure if he was asking about the mechanism or how one ensures that
dependencies are met (that responsibility falls upon the admin or
package manager; the mechanism just checks that dependencies are met).

> > My final question is what exactly are the semantics and implementation
> > details of the policy_module keyword and what ramifications are there
> > for having your policy consist of many policy modules. I know each
> > file in the reference policy has a policy_module macro at the
> > beginning but I am talking about on a much finer granularity that
> > currently exists. Does the policy_module keyword provide some sort of
> > isolation for a module?
> 
> Its a macro that expands to nothing for monolithic policy and the
> modular policy's base module.  For loadable modules, it provides the
> module name and version (which are required for loadable modules), plus
> adds a require{} block with kernel object classes and their permissions
> (and sensitivities and categories for MLS/MCS) for convenience.  You can
> see the implementation at the top of the
> policy/support/loadable_module.spt.

Just to note - the module construct does not provide isolation
presently.  Reference policy uses a number of conventions to provide
genuine modularity, but those aren't enforced by the policy toolchain
currently.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
