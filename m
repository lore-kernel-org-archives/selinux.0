Subject: object context records for Xen
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>, Chad Sellers <csellers@tresys.com>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
Content-Type: text/plain
Date: Fri, 21 Aug 2009 10:42:13 -0400
Message-Id: <1250865733.2390.85.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Xen needs its own object context (ocontext) records in the policy for
various resources (pirq, iomem, ioport, device), and has no need for the
Linux object context records other than initial SIDs.  Thus, rather than
just add new OCON_ indices and waste space in both the Linux and Xen
policies, I'd like to be able to interpret OCON_ indices differently
depending on some other value in the policy that identifies the target
kernel (Linux, Xen, FreeBSD, Solaris, ...). Possible ways to identify
the target kernel within the policy image:

- Use different policydb strings ("SE Linux", "Xen Flask", ...) in the
header.  I already introduced support for at least one other policydb
string ("Flask") in policydb_read() in libsepol so that we didn't have
to use "SE Linux" as the string in the OpenSolaris FMAC policy files.
Each kernel would only need to support reading files with its own string
identifier and would reject all others.  Only libsepol would support all
of them for reading and writing.

- Use the config flags in the header.  We are presently only using 3
bits in the config field (MLS, reject_unknown, allow_unknown), so we can
easily use a bit for each target kernel.  Not very general/scalable, but
it isn't clear that we need this for very many cases.

- Introduce an entirely new field to the header to select the target
kernel.  In which case it could just be an unsigned integer with defined
values for Linux, Solaris, Xen, FreeBSD, etc.  This is the only one that
absolutely requires a new policy version (policy.25).

Other aspects of the policy might likewise get interpreted differently
based on the target kernel, such as policy capabilities (the current
ones are very Linux-specific).

Then we'd have to decide how we want to drive selection of the target
kernel when building the policy; it could be an option to
checkpolicy/checkmodule (ala MLS and handle_unknown behavior) or it
could be an actual directive within the source policy configuration.

Thoughts?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
