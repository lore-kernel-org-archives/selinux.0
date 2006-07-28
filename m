Message-ID: <44CA2919.4010708@trustedcs.com>
Date: Fri, 28 Jul 2006 10:11:21 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH 0/2] new and improved range_transition statements
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This following patches allow for specification of security classes for
range_transition statements in the policy.  This is intended to address
a solution for RedHat Bugzilla #185436.

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185436

While working on this format change to allow class specification, it was
noted that the current range_transition handling in the policy toolchain was
not ideal.  It expanded things at compile time and there was no way to get
these statements into policy modules.  So, in addition to changing the kernel
policy format and base policy format in a trivial manner to support the
desired functionality, I also tried to make the base and module formats more
robust when handling range_transition rules.  Hopefully, this format will
allow for range_transition statements in modules with additional work for
libsepol in the (near?) future.  I will defer the toolchain gurus on the
completeness of my approach ;)  This patch set has been tested in the
following configurations:

old kernel / all old policy - sure glad that worked
old kernel / old format modules generating a new format kernel policy that
  is automatically downgraded at load time
old kernel / new format modules generating a new format kernel policy that
  is automatically downgraded at load time
new kernel / old format modules generating a new format kernel policy
old kernel / new format modules generating a new format kernel policy

The old style statements (without class specification) are correctly
interpreted as applying to the "process" class.  Old and new style statements
can be used together happily.  Duplicate and conflicting rules are properly
handled when expanding the rules with dups being dropped and conflicts
resulting in an error.  Also, a kernel policy that contains range_transitions
for classes other than "process" will have those transition rules dropped when
it is downgraded, but all "process" rules will remain as the old format supports
them.

The kernel change is fairly simple.  Sure would be nice to get that into 2.6.18
since it is for a bug fix...

The toolchain changes are a bit more complex, although it sure seems a lot easier
than it did when I started looking at the code.  I'd appreciate some scrutiny of
this, especially in the area of future support for range_transition statements in
policy modules.  I feel that will be very necessary and I hope to ease that path
with the format change.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
