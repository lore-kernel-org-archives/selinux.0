Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 17:17:42 -0400
Message-Id: <1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 15:54 -0400, Stephen Smalley wrote:
> BTW, I now have everything building again (except semodule_link/expand,
> which I disabled for now), with semodule and semodule_package both using
> only shared libs, and trivial tests of semodule/semodule_package seem to
> be working as expected.

I've committed what I have so far to sourceforge (libsepol 1.9.14 which
contains a bug fix for my first commit, checkpolicy 1.27.8, libsemanage
1.3.10, policycoreutils 1.27.6), so you can grab it from there, but keep
in mind that this is work in progress, interfaces may yet change, may
cause your computer to explode, etc.

The old policydb internal headers are under include/sepol/policydb/.
New sepol/policydb.h and sepol/module.h headers contain the new (or
converted) public types and interfaces for the shared libsepol.  These
functions plus Ivan's functions have been added to libsepol.map so that
I can link semodule against the shared libsepol, although I may have
gone overboard in that list (and yes, the interfaces can still change;
this is just a snapshot).

I left struct sepol_module_package publically defined, just wrapping its
policydb pointer, since it didn't seem to expose any internals
otherwise, so libsemanage and others users can still directly reference
p->policy, p->file_contexts, and p->file_contexts_len (but not anything
within p->policy).  Let me know if you think it should be made
completely opaque (or send a patch); if so, we'll have to update its
users to use get/set methods any time they directly reference the
fields.  Note that the create method allocates the struct and creates
its policydb for it.  

I didn't do anything about handles yet.  Note that the interfaces vary
quite a bit in what they take, with some taking sepol_policydb's, others
taking sepol_policy_file's, and others taking sepol_module_package's,
and some taking a combination.  Plus Ivan's interfaces, some of which
take sepol_policydb's but others just taking his new record structures.
So it seems like a handle would have to be separated if it is going to
be universal to all of the interfaces.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
