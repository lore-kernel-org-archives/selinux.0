Message-ID: <44F318A2.60100@trustedcs.com>
Date: Mon, 28 Aug 2006 11:24:02 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: [PATCH 0/3] range_transition revisited
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The kernel portion of the range_transition work has been included in the -mm
tree and should go into 2.6.19.  I hope that I finally some userspace patches
that are acceptable to take advantage of that kernel patch...

The first patch is just an update of the last patch posted to this list:
http://marc.theaimsgroup.com/?l=selinux&m=115471167305358&w=2
This is just an update to the latest svn tree - no logic changes.  I separated
this out because it seemed that everyone was good with this code.

The second patch addresses the question "Is an mls_range_t semantic enough for
use in modules?".  Unfortunately, the answer was no.

The third patch used the new semantic MLS representation for storing user's MLS
data in modules.  This format will allow users in MLS modules in the future.

Note that these patches are intended to go together.  There are two new ideas
put into the modular policy version, but the number is only bumped once.  Once
again, I think that the policy formats are ready to go and should support
everything we could ever possibly want in the future (well a few things anyway).

As before, this patch only addresses the necessary format changes to get modular
support for range_transition statements (and now users).  However, it does allow
immediate use of the extended range_transition statements where they were valid
before.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
