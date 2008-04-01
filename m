Subject: Need to break or reduce the dependency on a static libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>, Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain
Date: Tue, 01 Apr 2008 08:07:10 -0400
Message-Id: <1207051630.5610.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is likely my fault, but we're encountering increasing problems from
growth in the set of things that depend on the static libsepol whenever
we make a change to libsepol, particularly a policy version change.  We
now have (at least) the following dependencies on it:
checkpolicy (always true, not likely to go away)
libselinux (for the audit2why python binding module, which used to be
its own utility in policycoreutils)
setools

Does slide also have this dependency or is it clean?  Anything else to
worry about?

The result is that when a newer libsepol gets incorporated and
libselinux or setools does not, we encounter breakage (unable to find a
policy file they can read or unable to read the policy file at which
they are pointed) or confusion (reading an older policy file left around
from before the libsepol update) upon trying to use audit2why or
setools.

We ran into this problem twice in rawhide / F9, once upon the policy
capability support (policy.22) and now for permissive types (policy.23).

Only real way forward that I can see it to actually encapsulate the
interfaces required by audit2why and setools so that they can use the
shared libsepol.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
