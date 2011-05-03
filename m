Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p43DKI2w019427
	for <selinux@tycho.nsa.gov>; Tue, 3 May 2011 09:20:18 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p43DKHww006187
	for <selinux@tycho.nsa.gov>; Tue, 3 May 2011 13:20:17 GMT
Subject: [GIT PULL REQUEST] selinux tree for linus
From: Eric Paris <eparis@redhat.com>
To: jmorris@namei.org
Cc: selinux@tycho.nsa.gov
Date: Tue, 03 May 2011 09:20:15 -0400
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1304428816.10692.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This pull request includes 3 patch which should be sent to Linus.  The
first fixes the security checks used to determine if creates are allowed
when using filename transitions introduced in this cycle.  The second
patch does not itself fix a regression but is required for the third,
which fixes an issue in which policy will not load on some distros
(gentoo is an example) on the 2.6.38 kernel due to the change to use
flex_array.

-Eric

The following changes since commit fe3fa43039d47ee4e22caf460b79b62a14937f79:

  Merge branch 'master' of git://git.infradead.org/users/eparis/selinux into next (2011-03-08 11:38:10 +1100)

are available in the git repository at:

  git://git.infradead.org/users/eparis/selinux.git for-linus

Eric Paris (3):
      SELinux: pass last path component in may_create
      flex_array: flex_array_prealloc takes a number of elements, not an end
      flex_arrays: allow zero length flex arrays

 Documentation/flexible-arrays.txt |    4 ++--
 include/linux/flex_array.h        |    2 +-
 lib/flex_array.c                  |   24 ++++++++++++++++++------
 security/selinux/hooks.c          |    3 ++-
 security/selinux/ss/policydb.c    |    6 +++---
 5 files changed, 26 insertions(+), 13 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
