Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01247
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 12:08:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA17979
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 17:07:33 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA17974
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 17:07:32 GMT
Date: Wed, 10 Jan 2001 12:07:56 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>
cc: selinux@tycho.nsa.gov
Subject: RE: Security enhancements, et al
In-Reply-To: <A0669F3E0A6B3448A962DC6141E6C7A6144156@mis1>
Message-ID: <Pine.SOL.3.95.1010110113143.16290N-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Wed, 10 Jan 2001, Belmonte, Christopher wrote:

> Is anyone currently using the Rule Set Based Access Control linux security
> extension? I am curious on how it compares to SELinux.

Just FYI, the question of how SELinux compares with RSBAC has
been previously asked and answered on the selinux mailing list and on the
linux-kernel mailing list. You can find an unofficial archive of the 
selinux mailing list at http://marc.theaimsgroup.com/?l=selinux.  An
official archive should be forthcoming soon.

RSBAC appears to have similar goals to the Security-Enhanced
Linux. Like the Security-Enhanced Linux, it separates policy from
enforcement and supports a variety of security policies.  The
two systems are based on different architectures.  RSBAC is based
on the Generalized Framework for Access Control (GFAC).  SELinux
is based on the Flask security architecture.  The Flask Security 
Architecture paper on the Background page discusses the relationship
between the GFAC and Flask.  The two systems provide a different set of
interfaces for obtaining security policy decisions, and a different set of
controls for the kernel services.  The interfaces and controls for SELinux
are described in detail in the documentation on the Documentation
page (http://www.nsa.gov/selinux/docs.html).

> Does anyone have any idea why it has taken so long the release of SELinux?
> I'm assuming that maybe it was due to a source code audit... the man pages
> for many of the commands added by SELinux show updates from 1997-1999 (sorry
> if this has been changed in the current version).

As I recall, the actual development of the SELinux prototype did not start
until September 1999.  Some of the man pages are derived from existing
man pages since they describe extensions to an existing command or
call, so they may still have older dates in them.  Other man pages
may have unintentionally been left with an older date from an
existing man page used as a template.  In addition to developing
the kernel security features, a significant amount of time was
spent on developing the example security policy configuration for
the system.

Although the Linux implementation of the security architecture is
relatively young, it draws from several research prototypes of the security
architecture in the Mach and Fluke research operating systems.  These 
prior prototypes are described in published papers and reports
accessible via the DTOS and Flask links on the Background web page
(http://www.nsa.gov/selinux/background.html).  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
