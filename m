Subject: Re: Labeling only policy and problems with booleans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, fireflier-devel@lists.sourceforge.net,
        marius@cs.utt.ro
In-Reply-To: <200604262113.01211.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <200604232258.14004.edwin.torok@level7.ro>
	 <1146058670.28745.117.camel@moss-spartans.epoch.ncsc.mil>
	 <200604262113.01211.edwin@gurde.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 26 Apr 2006 15:26:44 -0400
Message-Id: <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-26 at 21:13 +0300, Török Edwin wrote:
> The policy where I had unconfined linked (boolean not working) 
> http://edwintorok.googlepages.com/policybad.tar.gz
> 
> The policy where I didn't have unconfined linked: 
> http://edwintorok.googlepages.com/policyok.tar.gz

sediff of these two policies shows a _lot_ of differences, including 107
added types in the "bad" policy.  Are you sure they are identical except
for linking unconfined?  What is in that module (source)?

I do see an allow unconfined_t security_t:security load_policy under a
different boolean in the "bad" policy; looks like a boolean mapping
problem at link time.  We did see those when the optionals-in-base
support was first merged, so the Debian checkpolicy might have an issue
there, but that should have been resolved in 1.30.3 or newer, built
against libsepol 1.12.3 or newer.

> kernel messages: http://edwintorok.googlepages.com/messages
> full build directory: http://edwintorok.googlepages.com/refpolicy.tgz

This one returned a 404 error.

> Let me know if anything else is needed to trace the problem.
> 
> There is another thing that worries me.
> I was able to do mknod xx c 1 2  creating an equivalent of /dev/kmem, and it 
> wasn't labeled memory_device_t, it was labeled unlabeled_t.
> So I guess giving access to unlabeled_t files is very dangerous (as you say 
> below). I assume one could exploit this by writing a program that creates a 
> kmem equivalent, and then he can do anything he wishes, including replacing 
> policy, loading another kernel module, patch syscalls...., am I right?

Not entirely.  Keep in mind that opening the memory devices requires
CAP_SYS_RAWIO, so you also need the SELinux sys_rawio permission in the
capability class to make use of such a device node even if you can
create one.  However, ensuring a consistent label on devices
irrespective of filesystem node used to access them would be nice; there
has been some consideration of labeling the internal objects rather than
just the filesystem nodes and applying access control at that layer to
ensure consistent control.  In the meantime, be careful about who you
allow to create device nodes and who you allow sys_rawio in your policy.

> What is the best practice to do when: most of the programs  on the system will 
> run as unconfined_t, so they'll all have the same (default) label (on my 
> system file_t seems to be the default label) except:

If you don't assign an xattr, then SELinux uses the context associated
with the 'file' initial SID in initial_sid_contexts as the default label
for the file.

>  - devices in /dev (handled by udev policy?)
>  - selinux policy loading programs (loadpolicy, semodule)
> But I do want to be able to label individual files (when fireflier generates 
> policies for them).
> 
> If I don't run setfiles, and I run restorecon only for the: selinux policy 
> loading programs, and fireflier, will that be safe? (will an unlabeled 
> program be able to gain access to another domain besides unconfined_t)
> Also, should I consider doing the policy loading myself in fireflier (via 
> libselinux,libsemanage...) instead of relying on an external program?

Normative pattern is to install policy modules via semodule, which calls
libsemanage to perform the actual installation and loading of policy.
libsemanage uses the external programs as appropriate.  Then you just
have to invoke restorecon as appropriate to label the desired files.
Using the external program is preferred, and may be enforced via policy
under some policies.

> Ok. But let me clarify, by unconfined_t I don't mean unconfined_t from the 
> targeted policy, since that has policy loading allowed. 
> I want to allow unconfined_t everything except:
>  - loading policy
>  - changing labels
>  - kernel module loading (boolean controlled, if I get booleans working)
>  - changing iptables rules
>  - writing to raw memory
> Fireflier doesn't aim to be a full security solution, I just want it to create 
> proper labels for skfilter to use, and as such there should be no way for an 
> unconfined_t process to change labels/load policy. 

I'm not certain how useful this is, as there are obvious bypasses here
unless you start dealing with all of the dependencies for the associated
programs and their data, e.g. can unconfined_t still update glibc?  At
which point unconfined_t becomes a misnomer and you start approximating
the strict policy more and more.

> I intend to use neverallow to catch policy generation bugs, and ...policy 
> creating logic errors. Also will it stop somebody from loading  a policy 
> module that overrides my restrictions?

semodule/libsemanage should end up rejecting a module if it violates a
neverallow rule in the base or any other module, so in one sense, yes.
But keep in mind that if the person loading the policy module has the
ability to manipulate the module store, then they can always
remove/replace the module that has those assertions, so you have to
ensure non-bypassability there.  Ultimately, libsemanage will interface
to a policy management daemon that will enforce such restriction more
strongly, with the policy ensuring that the daemon can't be bypassed to
directly manipulate the store.

> How can I create a type that is structurally equivalent? (read all rules 
> associated with that type from the binary policy, and generate 
> allow/transition/etc. rules based on them?)

Usually we do this by defining interfaces/macros in the policy itself,
and then instantiating multiple types from it.  Rather than trying to
automatically infer it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
