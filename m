Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
In-Reply-To: <01df01c4c336$4facc6f0$1e0c010a@columbia.tresys.com>
References: <01df01c4c336$4facc6f0$1e0c010a@columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099660308.6373.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 08:11:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 07:52, Frank Mayer wrote:
> However, this would also require some additional kernel features to support
> "dynamic context" (as does the current proposal).  In particular something in a
> process security context that would define the upper bound in the hierarchy for
> a context switch, and some type of rule enhancement (probably to
> type_transition) to define the upper bound context for a given entry point (or
> we could assume that the starting domain type is the upper bound and no lower
> bound is required).

The current proposal only requires a small change to the setprocattr
hook function and a new permission to be defined.  Policy can then
dictate the "upper bound" via the dyntransition permissions.  Higher
level policy language constructs and corresponding compiler enforcement
of restrictions can certainly be considered in the future, but is not
necessary in the kernel.  Whether or not there should also be an
entrypoint check between the new context and the current executable is
open to discussion; my concerns with such a check are:
1) Such a check is misleading, as you aren't actually guaranteed that
the new context will be running from the current executable (as opposed
to any other executable code mapped into memory, e.g. shared library,
anonymous memory set up by the caller).  This opens a separate
discussion of what checking SELinux should be doing on mmap/mprotect of
anonymous memory and of private file mappings to prohibit execution of
writable memory to most processes; at present, SELinux only does the
file-based checking for mmap/mprotect.
2) Such a check is also misleading in that entrypoint permission
normally implies that the new context is entered by the initialization
code of that particular program, whereas we have no such guarantee here.

Consequently, I'm not clear that the existing transitive relationship (A
can execute E, A can dyntransition to B, therefore B can be entered from
E) isn't sufficient (and more accurate).

> In any case, this would require some patience before dynamic contexts are
> available in order to develop the language constructs and new kernel support for
> context change (probably a couple of months).  Are we prepared to wait a little
> longer for the more constrained mechanism?

I don't think we need to do so.  Kernel mechanism can go in now, better
support in userspace for constraining it can come later.  No different
than the fact that the primitive kernel permission checks for exec-based
transitions or other operations do not enforce any particular policy on
such transitions/operations; the policy is defined separately.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
