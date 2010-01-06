Subject: Error building the userspace tools
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Jan 2010 15:37:26 -0500
Message-ID: <1262810246.24200.51.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I don't know what the correct fix for this is, but when I make the
userspace tools with "make LIBDIR=/usr/lib64 SHLIBDIR=/lib64", I need
the patch below for everything to compile.

What I don't know is:
1)  Why is this only required when I am specifying lib64?
2)  Since it is libsemanage that is using libustr and libbz2, why does
semodule and setsebool need to specify them?

This occurs on Fedora 12.  Is the problem due to a difference in the way
Fedora is building the userspace tools?



diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index c96a286..feba570 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+LDLIBS = -lustr -lbz2 -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SEMODULE_OBJS = semodule.o
 
 all: semodule
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 556b780..214abc3 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+LDLIBS = -lustr -lbz2 -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SETSEBOOL_OBJS = setsebool.o
 
 all: setsebool
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
