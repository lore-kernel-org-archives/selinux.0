Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA26886
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 16:05:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA29130
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 20:05:21 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA29126
	for <selinux@tycho.nsa.gov>; Tue, 2 Jul 2002 20:05:21 GMT
Date: Tue, 2 Jul 2002 16:05:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Warren Lerner <wdl@zai.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux fresh out of the box problems...
In-Reply-To: <1025635710.1253.12.camel@montyburns>
Message-ID: <Pine.GSO.4.33.0207021531310.18606-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 2 Jul 2002, Warren Lerner wrote:

> I have recently done a fresh install of Red Hat 7.2.  At the conclusion
> of this install, I did a fresh install of SELinux utilizing the "make
> quickinstall" method.  After installation, I reboot and receive many AVC
> messages.  Here is a small sample:
>
>  kernel: avc:  denied  { execute } for  pid=1 exe=/sbin/init
> path=/lib/i686/libc-2.2.5.so dev=03:42 ino=737295
> scontext=system_u:system_r:init_t tcontext=system_u:object_r:writeable_t
> tclass=file

This file clearly has the wrong type, writeable_t instead of shlib_t.
I'm not sure why this would have happened.  Try running 'make relabel' and
then run ls --context on the file again to see whether it still has this
type.

> kernel: avc:  denied  { write } for  pid=1 exe=/sbin/init dev=00:08
> ino=1 scontext=system_u:system_r:init_t
> tcontext=system_u:object_r:devfs_t tclass=dir

We don't use devfs ourselves, so the example policy configuration is
very incomplete with respect to supporting devfs usage.  We have been
merging many of Russell Coker's changes back into the example policy for
future releases, and these changes will help with devfs support since he
seems to be using devfs.  Feel free to submit patches to devfs_contexts
and to the TE configuration to improve support for devfs.  At least some
of the audit messages you posted have already been addressed by Russell's
changes.

> 1.  Can I install SELiunx with no modifications do an avc_toggle and
> have a working system?

If the example policy happens to cover all of the services that you
want to run and meets your security goals, then yes.  Otherwise, no.
The example policy is only intended to help demonstrate the system and to
provide people with a starting point for developing their own policies.

> 2.  Why do I receive AVC messages from SELinux before I have done an
> avc_toggle?

Read the README.  As it states, the module will log permission failures
but not enforce them while in permissive mode (i.e. before running
avc_toggle).  This allows you to determine what additional permissions are
needed for your system and to update your policy accordingly.

> 3.  Is there a basic policy available for download that addresses the
> "average" user's security    needs?

Define "average" user.

> 4.  Is there a GUI available for policy.conf modification that makes
> understanding the file easier?

Not within the upstream SELinux distribution.  However, Tresys has
developed some tools (see http://www.tresys.com/selinux) that operate
on policy.conf, and UNT has developed a TE browser
(http://cops.csci.unt.edu/projects/selinux) that operates on
the binary policy.

Please be sure to read the Configuring the SELinux Policy report,
which is available in the distribution and from the web site.

> 5.  What is the minimum that must be done in order to have SELinux
> function as intended?

"as intended"?  By whom?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
