Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
In-Reply-To: <01e001c4c337$9ce64210$1e0c010a@columbia.tresys.com>
References: <01e001c4c337$9ce64210$1e0c010a@columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099660413.6373.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 08:13:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 08:01, Frank Mayer wrote:
> True.  The actual enforcement of the switch-in-hierarchy constraint could be
> enforced entirely within the policy compiler (a weak security enforcement, but
> strong convention enforcement), which eventually would be overcome by an actual
> running policy server (a strong security enforcement).  However we could also
> design the kernel's context switching capability to understand name hierarchy,
> maintain upper bounds for processes, and enforce it strongly in the kernel
> (e.g., by using the starting type for a new process as its upper bound in a name
> hierarchy).  The latter approach seems a stronger security mechanism, allowing
> much of what is desired while maintaining a great deal of conceptual commonality
> with the current tranquility model (IMHO). 

That starts to move policy into the kernel mechanism.  Consider the
parallel for exec-based transitions; would we want the kernel mechanism
for exec-based transitions to fundamentally limit the relationship
between the old and new contexts?  That is more like the POSIX.1e
capability model, where you have a hardwired evolution logic for
capabilities upon exec, but that leads to all kinds of problems, as one
size doesn't fit all.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
