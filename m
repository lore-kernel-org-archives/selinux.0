Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2UL7xcg005755
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2010 17:08:01 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o2UL6to0000406
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2010 21:06:55 GMT
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH] Add implicit lib requirements to LDLIBS
Date: Tue, 30 Mar 2010 17:08:39 -0400
Message-Id: <1269983319-10453-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fedora 13 changed their linker behavior to not link indirect libraries.
See information at: http://fedoraproject.org/wiki/UnderstandingDSOLinkChange

Resent, it doesn't look like it made it to the list the first time (and the subject had a typo)

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 policycoreutils/semodule/Makefile  |    2 +-
 policycoreutils/setsebool/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index c96a286..a0bbc21 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+LDLIBS = -lsepol -lselinux -lsemanage -lbz2 -lustr -L$(LIBDIR) 
 SEMODULE_OBJS = semodule.o
 
 all: semodule
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 556b780..1b89d5c 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+LDLIBS = -lsepol -lselinux -lsemanage -lbz2 -lustr -L$(LIBDIR)
 SETSEBOOL_OBJS = setsebool.o
 
 all: setsebool
-- 
1.7.0.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
