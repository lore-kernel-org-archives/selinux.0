Subject: Re: Latest policycoreutils patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43CE9152.1030708@cornell.edu>
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com>
	 <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com>
	 <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com>
	 <43CDE7ED.4020908@cornell.edu> <43CE6261.8030204@redhat.com>
	 <43CE824E.6010904@cornell.edu>  <43CE8520.5050008@cornell.edu>
	 <1137609022.8926.194.camel@moss-spartans.epoch.ncsc.mil>
	 <43CE8AB3.1070103@cornell.edu>
	 <1137610343.8926.202.camel@moss-spartans.epoch.ncsc.mil>
	 <43CE9152.1030708@cornell.edu>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 14:32:13 -0500
Message-Id: <1137612733.8926.225.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-18 at 12:04 -0700, Ivan Gyurdiev wrote:
> Is there a problem with making some of those store files world-readable, 
> and making changes to allow lock files to be written by ordinary users 
> somehow. I don't understand why the selinux copy if the data is 
> readable, but the semanage copy is not, if they contain the same thing.

I view libsemanage as the management interface only, and thus naturally
restricted to privileged entities.  Certain files are then exported
outside of the module store for use by a variety of programs that only
want read access and nothing more.  We _could_ make some of the store
files readable, but I doubt we want to allow lock file creation.

In general, the protection of the module store needs more thought, at
least in terms of the security contexts on its files, as it contains
multiple files that ultimately end up with different SELinux security
contexts when they are installed (e.g. policy ends up as
policy_config_t, file_contexts as file_context_t, seusers as
selinux_config_t) and may have different protection requirements.
Easiest approach is to just label the entire module store with a type
that is at least as restrictive as the most restrictive type on any
installed file.  policy_config_t has typically been the most restrictive
type (under strict policy), as the fewest number of programs need to
read it and it contains the policy state.  file contexts is more widely
accessed, although it can still be viewed as potentially sensitive.  I'm
not sure that leaving seusers in selinux_config_t (the default due to
directory inheritance at creation) is a good idea, as that could also be
sensitive (identifying what users are authorized for admin roles).

> Libsemanage has an interface for that kind of thing already - why can't 
> that be used? I'm starting to get confused about the difference between 
> all those libraries again. If libselinux is to be used on runtime, and 
> libsemanage on persistent policy, then how do you explain the need for 
> active booleans backend in libsemanage?

For management purposes, it makes sense.  And in general, viewing and
modifying booleans both seem like management functions rather than
ordinary user functions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
