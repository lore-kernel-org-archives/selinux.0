Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA08254
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 14:35:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA22347
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 18:34:34 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA22342
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2002 18:34:33 GMT
Date: Tue, 30 Jul 2002 14:34:58 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: proposed patch: policy management
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIGEAHKFAA.mayerf@tresys.com>
Message-ID: <Pine.GSO.4.33.0207301342510.1806-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 29 Jul 2002, Frank Mayer wrote:

> Attached is the proposed patch I promised for policy management.

Thanks for the patch.  Some comments are provided below.
You might also want to update to the head of the sourceforge selinux CVS
tree and generate your patches relative to it.

> ============================================================
> # change summary for policy management changes
>
> ./attrib.te:
> 	1. add policyfiles and login_context attribs

Why did you decide to group default_context_t and cron_context_t into
login_context?  The login and sshd programs only require read access to
default_context, while crond only requires read access to cron_context.
However, it is true that cron_context is expected to go away eventually
and default_context will be replaced by the more general configuration
for all daemons.

The purpose of the policyfiles attribute is unclear at present.  You only
use it for temporary rules in admin_macros.te to preserve the original
policy when these types had the sysadmfile attribute.  I'm a little uneasy
about grouping policy_src_t with the *_context_t types, since the former
defines the policy and the latter merely provides defaults that must still
be approved by the policy.

> ./types/security.te
> 	1, removed sysadmfile from policy_src_t and policy_config_t
> 	2. moved cron_context_t from crond.te
> 	3. added default_context_t
> 	4. added new attribs policyfiles and login_contexts as
> 	appropriate

The cron_context file is only meaningful if crond is being used, so it is
preferable to keep it in crond.te.

> ./domain/programs/login.te
> 	1. Gave local_login_t and remote_login_t read access to
> 	login_contexts files

As noted above, these domains only require access to default_context_t.

> ./domains/programs/initrc.te
> 	1. Gave initrc read access to login_contexts

Why do the init scripts need to read these files?

> ./domains/program/crond.te
> 	1. remove sysadmfile attrib from from cron_context_t
> 	2. add new attribs policyfiles and login_contexts
> 	3. move cron_context_t declaration to security.te
> 	4. Gave crond read access to cron_context_t (since we removed
> 	sysadmfile attrib)

Nit:  #4 was already present and is not part of the patch.

> ./domains/programs/sshd.te
>  	1. Gave sshd read access to login_contexts (though not sure
>  	sshd is using login contexts at this time?)

Both sshd_t and sshd_login_t should be granted read access to
default_context_t.  The sshd program (sshd_t) reads the file to
obtain the default user context.  If sshd is configured to use login (not
the default), then the login program is run in sshd_login_t and will try
to read the default user context.

> ./Makefile
> 	1. Fixed policy.conf target to make tmp a dependent target;
> 	and to install policy.conf
> 	2. Replaced policy target with testpolicy target to build a
> 	binary policy  without directly installing it (as a result of
> 	the new checkpolicy domain).
> 	3. Policy target now runs checkpolicy on installed policy.conf
> 	and outputs directly to the installed location (without gzip
> 	for now until zlib is incorporated directly into checkpolicy).
> 	ISSUE: Can't use install -m 644 -u root -o group; not sure
> 	of general solution, but for now depend upon umask defaults.
> 	4. Install target is now synonomous with policy target.
> 	5. New install-src target added to install policy source
> 	directory; a new system installtion procedure is probably
> 	needed to include this step on initial system build??

Conventionally, you should be able to do a 'make' without privileges
to build something and then do a 'make install' to install it, possibly
requiring privilege depending on where you install.  I see that you've
tried to preserve the ability to do a local build via the 'testpolicy'
target (nit: conflicts with an existing target I have for a test
configuration that differs from the example configuration), but I'd rather
just keep 'policy' as it is, and only change the 'install' target.

If you use the 'install-src' target, and subsequently perform all builds
from /etc/security/selinux/src/policy, you'll end up building policy.conf
in that directory and then "installing" it one level up.  Is that really
what you want?  I understand that you also want to support the situation
where the policy source is not installed, just policy.conf.

I suppose we could add -m, -o, and -g options directly to checkpolicy for
direct installation purposes.

It looks like the $(SRCINSTALLDIR) dependency and the install statement
associated with policy.conf really belong to $(POLICYCONF).  Right?

> changes to filecontexts:
> 	1. added checkpolicy.fc (new)
> 	2. added load_policy.fc (new)
> 	3. moved cron_context.conf labeling from crond.fc to types.fc
> 	4. within types.fc, added labels for following:
> 		/etc/security/selinux/src/
> 		/etc/security/default_context
> 		/etc/security/cron_context (from crond.fc)

As with the crond.te change, I don't think we want to move the
cron_context_t file context specification to types.fc, as it is only
relevant if you are using crond.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
