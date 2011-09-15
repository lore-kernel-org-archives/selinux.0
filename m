Subject: [PATCH] policycoreutils: fix sandbox Makefile
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        guido@trentalancia.com
In-Reply-To: <CACLa4ptONKKd2t6eM+CUPeWOWKjrCteiZFFTYYTRwCKiHfROog@mail.gmail.com>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <CACLa4ptONKKd2t6eM+CUPeWOWKjrCteiZFFTYYTRwCKiHfROog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Sep 2011 13:13:55 -0400
Message-ID: <1316106835.16483.32.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix sandbox Makefile so that make DESTDIR=~/out install works again.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 policycoreutils/sandbox/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/sandbox/Makefile b/policycoreutils/sandbox/Makefile
index 21df0c4..4566810 100644
--- a/policycoreutils/sandbox/Makefile
+++ b/policycoreutils/sandbox/Makefile
@@ -2,6 +2,7 @@
 PREFIX ?= ${DESTDIR}/usr
 INITDIR ?= ${DESTDIR}/etc/rc.d/init.d/
 SYSCONFDIR ?= ${DESTDIR}/etc/sysconfig
+LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/bin
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
@@ -13,7 +14,7 @@ LDLIBS += -lselinux -lcap-ng
 all: sandbox seunshare sandboxX.sh start
 
 seunshare: seunshare.o $(EXTRA_OBJS)
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS) -L$(LIBDIR)
 
 install: all
 	-mkdir -p $(BINDIR)



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
