Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA09106
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 16:07:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA27226
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 20:05:35 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id UAA27222 for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 20:05:35 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: RE: proposed patch: policy management
Date: Tue, 30 Jul 2002 16:09:53 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIAEAOKFAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0207301342510.1806-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, further comments are below.

> > ./attrib.te:
> > 	1. add policyfiles and login_context attribs
>
> Why did you decide to group default_context_t and cron_context_t into
> login_context?  The login and sshd programs only require read access to
> default_context, while crond only requires read access to cron_context.
> However, it is true that cron_context is expected to go away eventually
> and default_context will be replaced by the more general configuration
> for all daemons.

I'm looking ahead at policy management tools and capabilities.
So for example a tool which manages user account aspects of a security
policy and runs in its own domain (e.g., as we're trying to do with our
seuser tool) must have the ability to write all "login context" files.
I can imagine all sorts of new and different login context files being
created in the future (e.g., a separate file for sshd); I just wanted
a single reference for any and all for those cases where write access to
all need be granted.

> The purpose of the policyfiles attribute is unclear at present.  You only
> use it for temporary rules in admin_macros.te to preserve the original
> policy when these types had the sysadmfile attribute.

Again I was looking forward to tools that must access policy files.
However, originally I have policy_src_t and policy_config_t linked
together and then decided to remove the config (binary) files.  This
along with your point below that the context files really aren't policy
files makes me agree that policy_src_t suffices in and of itself.

> I'm a little uneasy
> about grouping policy_src_t with the *_context_t types, since the former
> defines the policy and the latter merely provides defaults that must still
> be approved by the policy.

See above.  Agreed.

Aside:  Interesting I read into your comments a desire to limit
the use attributes.  I would think that generous use of attributes would
be encouraged as a way of providing logical affinity, if for nothing else,
than for human analysis purposes.  They're certainly harmless.  At some
point where we have fancy policy editors, I envision attributes being widely
used as a means of providing the user with means of associating
types, even if the attribute is not used in a rule.

> > ./types/security.te
> > 	1, removed sysadmfile from policy_src_t and policy_config_t
> > 	2. moved cron_context_t from crond.te
> > 	3. added default_context_t
> > 	4. added new attribs policyfiles and login_contexts as
> > 	appropriate
>
> The cron_context file is only meaningful if crond is being used, so it is
> preferable to keep it in crond.te.

I guess I don't have a strong issue here.  From a security management
perspective it seems logical to group and collect the "login contexts"
files together in the policy.  But modularity of the policy for
install options is as compelling, even more so in the current
structure of the make directory.

Interesting that we can't do the same with default_context since
login isn't the only program expected to use it.  Is there a better
place for it than security.te?

> > ./domain/programs/login.te
> > 	1. Gave local_login_t and remote_login_t read access to
> > 	login_contexts files
>
> As noted above, these domains only require access to default_context_t.

OK, though I can imagine a day when there might be several
different types of login context files depending on the type of
login or user account management.  Reading the contexts files was less
of a concern than having the attribute for granting write access to
policy editors.

> > ./domains/programs/initrc.te
> > 	1. Gave initrc read access to login_contexts
>
> Why do the init scripts need to read these files?

Not sure, we had the same question here.  We seemed to keep getting
audit messages if we didn't have this.  Since initrc previously has
access to the context files (since there were admfiles), it may not
have arisen before.  I will test again and let you know if indeed initrc
keeps complaining about access to these file.

> > ./Makefile
> > 	1. Fixed policy.conf target to make tmp a dependent target;
> > 	and to install policy.conf
> > 	2. Replaced policy target with testpolicy target to build a
> > 	binary policy  without directly installing it (as a result of
> > 	the new checkpolicy domain).
> > 	3. Policy target now runs checkpolicy on installed policy.conf
> > 	and outputs directly to the installed location (without gzip
> > 	for now until zlib is incorporated directly into checkpolicy).
> > 	ISSUE: Can't use install -m 644 -u root -o group; not sure
> > 	of general solution, but for now depend upon umask defaults.
> > 	4. Install target is now synonomous with policy target.
> > 	5. New install-src target added to install policy source
> > 	directory; a new system installtion procedure is probably
> > 	needed to include this step on initial system build??

First let me say that I struggled with the make file and welcome
suggestions.  Most issues result from a struggle with two distinct
perspective: 1) initial install and development for which the make file
is best suited, and 2) as an operational management tool that must abide by
the DTE policy where using make is more problematic.

> Conventionally, you should be able to do a 'make' without privileges
> to build something and then do a 'make install' to install it, possibly
> requiring privilege depending on where you install.  I see that you've
> tried to preserve the ability to do a local build via the 'testpolicy'
> target (nit: conflicts with an existing target I have for a test
> configuration that differs from the example configuration), but I'd rather
> just keep 'policy' as it is, and only change the 'install' target.

That makes sense; what that really means is policy target will build a
temporary policy (once I fix the policy.conf issue below), and install
will rebuild the policy this time directly into the installed location.
It also means you can't build a test policy from the sysadm_t domain, as
this will cause checkpolicy to change domain (but as you said, policy
should be used without privilege).  This also climates test-policy.

> If you use the 'install-src' target, and subsequently perform all builds
> from /etc/security/selinux/src/policy, you'll end up building policy.conf
> in that directory and then "installing" it one level up.  Is that really
> what you want?  I understand that you also want to support the situation
> where the policy source is not installed, just policy.conf.

Vacillation my part!  Originally I had the $(POLICYCONF) target dependent
on policy.conf and install it.  I remember changing it for a reason that I
believe has to do with the policy target per above.  Right now I think what
I originally planned was correct, as it allowed one to build a test policy
without privilege from a local policy.conf file.  The install target would
be
dependent on the $(POLICYCONF) target which would install it in the
selinux/src
directory.  Given your suggestion about install and policy, this should
work.  I'll look at it again.

> I suppose we could add -m, -o, and -g options directly to checkpolicy for
> direct installation purposes.

Again I'm not sure how compelling this is, but at some point that might
be useful (along with inclusion of zlib).  Protection bits and DTE are
orthogonal, and we probably shouldn't have a situation where one
prevents us from doing what's correct in the other.  Not sure of priority.

> It looks like the $(SRCINSTALLDIR) dependency and the install statement
> associated with policy.conf really belong to $(POLICYCONF).  Right?

Yes, see above.  That's what I originally had and not exactly sure why
I changed it.

> > changes to filecontexts:
> > 	1. added checkpolicy.fc (new)
> > 	2. added load_policy.fc (new)
> > 	3. moved cron_context.conf labeling from crond.fc to types.fc
> > 	4. within types.fc, added labels for following:
> > 		/etc/security/selinux/src/
> > 		/etc/security/default_context
> > 		/etc/security/cron_context (from crond.fc)
>
> As with the crond.te change, I don't think we want to move the
> cron_context_t file context specification to types.fc, as it is only
> relevant if you are using crond.

Ok per above.  What about default_context...does that belong in security.te
and types.fc?





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
