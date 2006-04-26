From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Labeling only policy and problems with booleans
Date: Wed, 26 Apr 2006 23:08:16 +0300
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, fireflier-devel@lists.sourceforge.net,
        marius@cs.utt.ro
References: <200604021240.21290.edwin@gurde.com> <200604262113.01211.edwin@gurde.com> <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604262308.16575.edwin@gurde.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 April 2006 22:26, Stephen Smalley wrote:
>
> sediff of these two policies shows a _lot_ of differences, including 107
> added types in the "bad" policy.  Are you sure they are identical except
> for linking unconfined?  What is in that module (source)?
Hmm, that is *bad*. The module source is in the refpolicy.tgz.
I linked unconfined _and_ all its dependencies (which is quite a lot, from 
memory:
init,udev,userdomain,locallogin,libraries,storage,miscfiles,authlogin,...)
>
> I do see an allow unconfined_t security_t:security load_policy under a
> different boolean in the "bad" policy; looks like a boolean mapping
> problem at link time.  We did see those when the optionals-in-base
> support was first merged, so the Debian checkpolicy might have an issue
> there, but that should have been resolved in 1.30.3 or newer, built
> against libsepol 1.12.3 or newer.
I'll try upgrading libsepol in fc5, and I'll also try to build 
checkpolicy+libsepol manually from the latest sources. I'll let you know 
(possibbly tomorrow) if this makes a difference.
btw, wouldn't it be nice for checkpolicy to have a --version option, currently 
I have to use apt-cache policy for debian, rpm -q for redhat, etc. to find 
out which version I have.
>
> > kernel messages: http://edwintorok.googlepages.com/messages
> > full build directory: http://edwintorok.googlepages.com/refpolicy.tgz
Upload size limit :(, try this one:
http://projects.emerge.upt.ro/Kernel-Dev/browser/fireflier/refpolicy.tgz?format=raw
>
> This one returned a 404 error.
>
> > Let me know if anything else is needed to trace the problem.
> >
> > There is another thing that worries me.
> > I was able to do mknod xx c 1 2  creating an equivalent of /dev/kmem, and
> > it wasn't labeled memory_device_t, it was labeled unlabeled_t.
> > So I guess giving access to unlabeled_t files is very dangerous (as you
> > say below). I assume one could exploit this by writing a program that
> > creates a kmem equivalent, and then he can do anything he wishes,
> > including replacing policy, loading another kernel module, patch
> > syscalls...., am I right?
>
> Not entirely.  Keep in mind that opening the memory devices requires
> CAP_SYS_RAWIO, so you also need the SELinux sys_rawio permission in the
> capability class to make use of such a device node even if you can
> create one.  However, ensuring a consistent label on devices
> irrespective of filesystem node used to access them would be nice; there
> has been some consideration of labeling the internal objects rather than
> just the filesystem nodes and applying access control at that layer to
> ensure consistent control.  
That would be nice. Then device under /dev would automatically get the correct 
label? It would also eliminate a few bootstrapping problems (currently I have 
to reboot using init=/bin/sh, relabel /dev, and then reboot&relabel after 
udev is up).
> In the meantime, be careful about who you 
> allow to create device nodes and who you allow sys_rawio in your policy.
Ok
>
>
> >  - devices in /dev (handled by udev policy?)
> >  - selinux policy loading programs (loadpolicy, semodule)
> > But I do want to be able to label individual files (when fireflier
> > generates policies for them).
> >
> > If I don't run setfiles, and I run restorecon only for the: selinux
> > policy loading programs, and fireflier, will that be safe? (will an
> > unlabeled program be able to gain access to another domain besides
> > unconfined_t) Also, should I consider doing the policy loading myself in
> > fireflier (via libselinux,libsemanage...) instead of relying on an
> > external program?
>
> Normative pattern is to install policy modules via semodule, which calls
> libsemanage to perform the actual installation and loading of policy.
> libsemanage uses the external programs as appropriate.  Then you just
> have to invoke restorecon as appropriate to label the desired files.
> Using the external program is preferred, and may be enforced via policy
> under some policies.
I'll use semodule then. Would it make sense to add file integrity check to 
fireflier (checksum/secure hash/digital signature)? (for checking if semodule 
is actually what it should be)
>
> > Ok. But let me clarify, by unconfined_t I don't mean unconfined_t from
> > the targeted policy, since that has policy loading allowed.
> > I want to allow unconfined_t everything except:
> >  - loading policy
> >  - changing labels
> >  - kernel module loading (boolean controlled, if I get booleans working)
> >  - changing iptables rules
> >  - writing to raw memory
> > Fireflier doesn't aim to be a full security solution, I just want it to
> > create proper labels for skfilter to use, and as such there should be no
> > way for an unconfined_t process to change labels/load policy.
>
> I'm not certain how useful this is, as there are obvious bypasses here
> unless you start dealing with all of the dependencies for the associated
> programs and their data, e.g. can unconfined_t still update glibc?  At
> which point unconfined_t becomes a misnomer and you start approximating
> the strict policy more and more.
Like I said, fireflier is going to deal with the networking part only. I just 
wanted to add some simple protection to prevent simple bypasses. By simple I 
mean those that can be done instantly: if somebody loads a policy it has 
bypassed fireflier. OTOH if he wouldn't have had fireflier installed, 
somebody could have just flushed the iptables rules.
So maybe I'll focus on the networking part, and label transition part only, 
and _not_ think of N possible ways to punch holes in the system, if somebody 
really wants to.

So the only kind of protection that still makes sense, and would be easy to do 
(I hope) is to prevent programs from switching contexts(AFAIK there are some 
libselinux functions, that can be called to do that switch).
>
> > I intend to use neverallow to catch policy generation bugs, and ...policy
> > creating logic errors. Also will it stop somebody from loading  a policy
> > module that overrides my restrictions?
>
> semodule/libsemanage should end up rejecting a module if it violates a
> neverallow rule in the base or any other module, so in one sense, yes.
> But keep in mind that if the person loading the policy module has the
> ability to manipulate the module store, then they can always
> remove/replace the module that has those assertions, so you have to
> ensure non-bypassability there.
I didn't mean to protect against malicious users with neverallow. I only 
wanted to give the user/sysadmin a warning, that he breaks some rules he has 
previously set: so that he doesn't "by accident" invalidate fireflier's 
rules.
> Ultimately, libsemanage will interface 
> to a policy management daemon that will enforce such restriction more
> strongly, with the policy ensuring that the daemon can't be bypassed to
> directly manipulate the store.
>
> > How can I create a type that is structurally equivalent? (read all rules
> > associated with that type from the binary policy, and generate
> > allow/transition/etc. rules based on them?)
>
> Usually we do this by defining interfaces/macros in the policy itself,
> and then instantiating multiple types from it.  Rather than trying to
> automatically infer it.
Right, but in that case you are writing the policy, you are designing the 
policy. Considering the scenario I gave earlier, if the user/admin had known 
that he needs separate rules for those 2 programs, he wouldn't have put them 
in the same domain. Maybe it is just too complicated to handle this 
automatically, and fireflier should do just this:
  - let the user know what is the  domain of the program(s) accessing that 
socket
 - let the user decide if he wants _all_ the programs in that domain to give 
access, and if not (here comes the change):
      - let fireflier create a new type, that the user will(could) customize 
later
      - use a predefined domain (already in policy)
     - let the user modify the policy that only those programs remain in the 
same domain, that need same access rights

When fireflier creates a type, it would be based on unconfined_t by default.

After all, if the user has Selinux enabled on his system: 
 - he either knows how to write selinux policies, so he can customize the .te 
generated by fireflier
, or he uses a distro where the policy has already been written (properly), in 
which case he should choose from a list of predefined domains only




Edwin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
