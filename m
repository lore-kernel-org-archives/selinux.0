Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA10815
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 10:51:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA26249
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 14:51:00 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA26244
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 14:50:59 GMT
Date: Fri, 8 Jun 2001 10:50:32 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Zachary Uram <zu22@andrew.cmu.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: hello?
In-Reply-To: <Pine.GSO.4.21L.0106071705030.6921-100000@unix3.andrew.cmu.edu>
Message-ID: <Pine.SOL.3.95.1010608102947.15810H-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 7 Jun 2001, Zachary Uram wrote:

> do you have guid that shows how to build/patch your source code
> into an exiting Linux kernel. 

You can apply the kernel patch available on the download page
to an ordinary 2.4.3 kernel from www.kernel.org.  But you
are better off simply downloading the complete package and
following the INSTALL instructions.  Do you have a specific
reason why you want to patch some other version/variant of
the Linux kernel?

> what is expected completion date for the user and administrative
> guides?

As far as I know, no one is working on such guides currently.

> is this more secure than OpenBSD?

They aren't really comparable.  SELinux is NOT a secure
Linux distribution.  It is a reference implementation
of a flexible access control architecture in the Linux
kernel, and an example security policy configuration that
shows how to use those controls.  The access controls can
confine the actions of any process, including superuser
processes, so the potential damage that can be done by
exploiting a flaw in an application can be strictly limited
and so that users can be protected against malicious software.
Some modified applications are provided to help demonstrate
some of the kernel features, but they are not integral to the
system.  SELinux is more analagous to the TrustedBSD project than to
the OpenBSD project.  The OpenBSD project is focused on a BSD
distribution that is free from known security problems and that 
incorporates cryptographic mechanisms.  Hopefully, some of the
TrustedBSD project work will filter over to the OpenBSD project
as well, so that similar access controls will become available
in OpenBSD.

> can i use this in an existing Debian distribution?

We've only used it with RedHat distributions (originally 6.1
and 6.2, and lately with 7.1).  I would expect that you could
use it with a Debian distribution, but you would have to
adapt the build/install process, account for differences
in the modified applications, and adjust the policy
configuration for a Debian environment.

> i see no activity in list archives since april,

The archives at the NSA web site are only updated
when a new release is made.  You can fetch more up-to-date
archives via email to majordomo or you can access an
unofficial archive at http://marc.theaimsgroup.com/?l=selinux.

> is this effort still active?

The effort is active, but it is in a new phase.  
The original SELinux prototype was presented to the
Linux kernel developers at the Linux Kernel Summit.
Based on their feedback, we are now working with
the recently started Linux Security Modules (LSM) effort
to transfer the SELinux functionality into a security
module that works with LSM and to ensure that the LSM
framework will support SELinux.  We haven't been doing
any new development on the old prototype lately.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
