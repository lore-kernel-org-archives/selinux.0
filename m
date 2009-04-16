Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3G6kxct030302
	for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2009 02:46:59 -0400
Received: from atoll.udmvt.ru (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3G6ksjR027367
	for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2009 06:46:58 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n3G6kpIb056182
	for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2009 11:46:53 +0500 (SAMST)
	(envelope-from spg@udmvt.ru)
Date: Thu, 16 Apr 2009 11:46:50 +0500
From: Alexey S <selinux@udmvt.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: access(2) vs. SELinux
Message-ID: <20090416064650.GC9889@ruber.office.udmvt.ru>
References: <1239810710.27560.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1239810710.27560.53.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 15, 2009 at 11:51:50AM -0400, Stephen Smalley wrote:
> Per [1], the fact that SELinux applies the same read/write/execute
> checks in response to access(2) calls as it does for an actual open(2)
> for read/write or execve(2) for execute leads to huge numbers of
> spurious denials for applications such as nautilus that probe all files
> being listed.  dontaudit'ing of these denials is viewed as unacceptable
> as Dan wants to be able to see such denials upon the actual open(2) or
> execve(2) attempts.
> 
> If access(2) only returned the result of the DAC access checks and e.g.
> only checked getattr permission on access(2) calls (similar to stat(2)),
> then the read/write/execute MAC denials would not happen, but that would
> likely break the behavior of existing applications/libraries that use
> access(2) to decide whether to follow a privileged code path or fall
> back on an unprivileged code path (e.g. kerberos libraries).
> 
> Other suggested proposals included:
> - Using the _noaudit interface to suppress auditing of the
> read/write/execute checks when checking for access(2), although this
> requires reworking the underlying implementation so that we can
> distinguish access(2) from open(2) checking.  However, this could lead
> to silent failure of applications with no way to obtain any audit
> messages, and would provide an obvious way to probe for access without
> triggering audit.
I'm sure this is the only one correct solution, but it lacks some little piece:
it needs some global switch somewhere in /proc or /selinux that turns on/off
generation of audit messages by access(2) testing read/write/execute permissions.
This is the special case, that deserves it's own config option, IMHO.

...
> 
> Thoughts?
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=495211
> 
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

-- 
Alexey S

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
