Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3G7NXZ015699
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 11:07:23 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3G7NJZ029196
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 16:07:23 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
In-Reply-To: <20041103155537.GD5061@lkcl.net>
References: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com>
	 <1099342548.21386.239.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101225820.GP9643@lkcl.net>
	 <200411021930.iA2JURrg028137@turing-police.cc.vt.edu>
	 <20041103155537.GD5061@lkcl.net>
Content-Type: text/plain
Message-Id: <1099497817.1213.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 11:03:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 10:55, Luke Kenneth Casson Leighton wrote:
> On Tue, Nov 02, 2004 at 02:30:26PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > Not true at all - just because the only things passed to the execve()
> > syscall are the argv[] and envp[] arrays doesn't mean that it's the
> > only resources passed to the post-exec code:
> > 
> > 1) Open file descriptors, unless flagged as close-on-exec
> > 2) ulimit/umask settings
> > 3) Posix 1.e attributes (modulo the active/permitted/inherited changes)
> > 4) The current working directory
> > 5) Any namespaces created by mount --bind, clone(CLONE_FS), and friends.
> > 
> > And probably a bunch of other stuff I'm forgetting.  There's PLENTY of
> > places to accidentally leak stuff up/down across an exec() call....
> 
> thank you for correcting me.
> 
> i trust that all these things are covered in some way by
> SE/Linux - from what i can gather, the open file descriptors
> definitely are, yes?

SELinux performs a number of checks on an exec-based context transition,
including open file descriptors, controlling tty, signal-related state,
and resource limits.  Such checks have to be carefully balanced against
application compatibility concerns (but policy can handle this on a
selective basis) and against the potential for a security flaw to arise
from unexpected state sanitization (e.g. you set resource limits prior
to running some application to bound its resources, but it runs in a
different domain and the policy forces a reset of its resource limits to
protect it against subversion by the caller, thereby leading to it
running with greater limits than desired - this too can be addressed by
policy).  Some state sanitization need to be handled by glibc (e.g. LD_*
variable purging), and this is done via the AT_SECURE mechanism.  Some
state sanitization ultimately requires application knowledge and has to
be done by the particular application during startup.

We don't apply checking to every piece of state inherited on exec, as
certain forms of manipulation should be countered by existing access
checks (e.g. namespace manipulation already requires a capability to
perform, and namespace manipulation may trick the application into
accessing the wrong file, but it won't let the application access any
file beyond its permissions) and since it isn't always clear what to do
if a given piece of state couldn't be inherited (merely resetting to
some sane default may introduce a vulnerability of its own, e.g.
breaking out of a namespace set up by a caller).  But no matter how
"leaky" exec may be, it is far less "leaky" than seteuid, where you have
no control over inheritance or initialization of the new domain.


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
