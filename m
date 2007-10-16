Subject: kernel flask headers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 16 Oct 2007 11:11:27 -0400
Message-Id: <1192547487.8702.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On the refpolicy trunk, if you run make in refpolicy/policy/flask and
try to use the resulting kernel headers, the kernel won't build.

Looks like flask.py is inserting S_(0, 0, 0) lines into av_inherit.h,
which isn't valid in the kernel's definition of S_() there.  Should just
omit the line altogether I would expect.

Also, we don't presently seem to have a way of marking common
definitions as userspace-only and omitting them from the kernel's
headers, so it is adding the common database definitions
(unnecessarily).

I noticed because I was looking at introducing a capability2 class and
vector to deal with the upper end of 64-bit capabilities, but the
problem occurs without any changes to the flask files at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
