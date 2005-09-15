Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <4329235B.6030109@cornell.edu>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>
	 <432799F0.7060706@cornell.edu>
	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>
	 <432823F0.3030803@tresys.com>
	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>
	 <43283772.7070603@tresys.com>
	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>
	 <432842D4.3070905@tresys.com>
	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>
	 <43284A6B.8080507@tresys.com>  <43287BDC.1090004@cornell.edu>
	 <1126727413.12299.208.camel@moss-spartans.epoch.ncsc.mil>
	 <432888C8.3090700@cornell.edu>  <4329235B.6030109@cornell.edu>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 08:22:46 -0400
Message-Id: <1126786966.10727.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-15 at 03:31 -0400, Ivan Gyurdiev wrote:
> Ivan Gyurdiev wrote:
> > All of them? For example, the policydb.c code just changed to use 
> > DEBUG...
> > policydb_read()
> > policydb_write()
> > everything else...
> 
> 
> Well... I guess those would be in the static library. In fact, the 
> shared library doesn't provide a whole lot of functionality right now:
> 
>   global: sepol_genbools*; sepol_set_policydb_from_file; 
> sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers;

That's right.  Remember, libsepol is just a blob of code taken from
checkpolicy so that we could allow very limited re-use of its knowledge
of policy internals by specific programs that (unlike checkpolicy) were
not themselves tightly coupled to policy internals.  libsepol was
originally created to allow init and load_policy to patch the in-memory
policy for local boolean settings, then later leveraged to allow
setfiles to validate file_contexts against a binary policy during policy
builds, and then later leveraged to allow init and load_policy to patch
the in-memory policy for local user settings.

> So, if you deprecate the shared sepol_gen*, you're left 
> with...sepol_check_context (which makes use of sepol_context_to_sid, and 
> sepol_ctx_*)... and also sepol_set_policydb_from_file (which I think 
> should also be deprecated, along with the global policydb).
> 
> Why are we making this a static library again?

If we separate the kernel binary policy file from the rpm-managed one,
and push all policy changes (including local boolean and user settings
as well as module management) through the policy toolchain to rebuild
the kernel binary policy file, then init and load_policy no longer need
libsepol at all.  So the only user left of the shared libsepol is
setfiles, which might mean that we do keep a shared libsepol just for
it, but limited to those two interfaces (and a global policydb presents
no problem there nor should it for the userspace security server as we
don't need per-thread settings for it, so I see no value in changing
it).

On the other hand, libsemanage incorporates libsepol, currently
statically, and if libsemanage eventually provides a shared library,
then we will another "shared" instance of libsepol, just hidden behind
the libsemanage interface.  Tresys already moved the module read/write
code from libsemanage to libsepol, so possibly with just a little more
work, libsemanage could be made less tightly coupled to libsepol
internals and use a shared libsepol instead of incorporating libsepol
directly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
