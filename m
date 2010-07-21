Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6LJ2AuJ030932
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2010 15:02:18 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6LJ1M92007795
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2010 19:01:22 GMT
Received: by iwn42 with SMTP id 42so8550750iwn.12
        for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2010 12:02:17 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 21 Jul 2010 14:02:17 -0500
Message-ID: <AANLkTi=JzoKZHuNgeBc2L7BnckXogMoaEEJLDbYL+-BR@mail.gmail.com>
Subject: [RFC PATCH 2/4] mcstrans: utilities
From: Xavier Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=005045013e15bf9ab4048bea7064
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--005045013e15bf9ab4048bea7064
Content-Type: text/plain; charset=ISO-8859-1

SELinux Project contribution of mcstrans. mcstrans is a userland package
specific to SELinux which allows system administrators to define sensitivity
levels and categories and provides a daemon for their translation into human
readable form. This version is a merge of Joe Nalls git tree (
http://github.com/joenall/mcstrans) and patches supplied by Dan Walsh and
others at RedHat.

Utilities.

---

 Makefile            |   41 +++++++++++++++++++++++++++++++++++++++++
 callgrind-mcstransd |    5 +++++
 transcon.c          |   30 ++++++++++++++++++++++++++++++
 untranscon.c        |   28 ++++++++++++++++++++++++++++
 valgrind-mcstransd  |    5 +++++
 5 files changed, 109 insertions(+)

diff --git a/policycoreutils/mcstrans/utils/Makefile
b/policycoreutils/mcstrans/utils/Makefile
new file mode 100644
index 0000000..1ffb027
--- /dev/null
+++ b/policycoreutils/mcstrans/utils/Makefile
@@ -0,0 +1,41 @@
+# Installation directories.
+PREFIX ?= $(DESTDIR)/usr
+BINDIR ?= $(PREFIX)/sbin
+
+ARCH = $(shell uname -i)
+ifeq "$(ARCH)" "x86_64"
+        # In case of 64 bit system, use these lines
+        LIBDIR=/usr/lib64
+else
+ifeq "$(ARCH)" "i686"
+        # In case of 32 bit system, use these lines
+        LIBDIR=/usr/lib
+else
+ifeq "$(ARCH)" "i386"
+        # In case of 32 bit system, use these lines
+        LIBDIR=/usr/lib
+endif
+endif
+endif
+
+
+CFLAGS ?= -Wall
+override CFLAGS += -I../src -D_GNU_SOURCE
+LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre
$(LIBDIR)/libsepol.a
+
+TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+
+all: $(TARGETS)
+
+install: all
+    -mkdir -p $(BINDIR)
+    install -m 755 $(TARGETS) $(BINDIR)
+
+test:
+    ./mlstrans-test-runner.py ../test/*.test
+
+clean:
+    rm -f $(TARGETS) *.o *~ \#*
+
+relabel:
+
diff --git a/policycoreutils/mcstrans/utils/callgrind-mcstransd
b/policycoreutils/mcstrans/utils/callgrind-mcstransd
new file mode 100644
index 0000000..f494b24
--- /dev/null
+++ b/policycoreutils/mcstrans/utils/callgrind-mcstransd
@@ -0,0 +1,5 @@
+#!/bin/bash
+service mcstrans stop
+cd ~root
+runcon -u system_u -r system_r -t setrans_t -l s15:c0.c1023 -- valgrind
--tool=callgrind /usr/src/redhat/BUILD/*/src/mcstransd
+run_init /etc/init.d/mcstrans start
diff --git a/policycoreutils/mcstrans/utils/transcon.c
b/policycoreutils/mcstrans/utils/transcon.c
new file mode 100644
index 0000000..5189f0f
--- /dev/null
+++ b/policycoreutils/mcstrans/utils/transcon.c
@@ -0,0 +1,30 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <errno.h>
+#include <string.h>
+#include <selinux/selinux.h>
+#include "mcstrans.h"
+
+void usage(const char *progname)
+{
+    fprintf(stderr, "usage:  %s context\n", progname);
+    exit(1);
+}
+
+int main(int argc, char **argv) {
+    security_context_t scon;
+    if ( argc != 2 ) usage(argv[0]);
+    if (init_translations()==0) {
+        if(trans_context(argv[1],&scon) == 0) {
+            printf("%s\n", scon);
+            freecon(scon);
+            return 0;
+        }
+    }
+    printf("Failed\n");
+    return -1;
+}
+
+
diff --git a/policycoreutils/mcstrans/utils/untranscon.c
b/policycoreutils/mcstrans/utils/untranscon.c
new file mode 100644
index 0000000..f47b6ea
--- /dev/null
+++ b/policycoreutils/mcstrans/utils/untranscon.c
@@ -0,0 +1,28 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <errno.h>
+#include <string.h>
+#include <selinux/selinux.h>
+#include "mcstrans.h"
+
+void usage(const char *progname)
+{
+    fprintf(stderr, "usage:  %s context\n", progname);
+    exit(1);
+}
+int main(int argc, char **argv) {
+    security_context_t scon;
+    if ( argc != 2 ) usage(argv[0]);
+    if (init_translations()==0) {
+        if(untrans_context(argv[1],&scon) == 0) {
+            printf("%s\n", scon);
+            freecon(scon);
+            return 0;
+        }
+    }
+    return -1;
+}
+
+
diff --git a/policycoreutils/mcstrans/utils/valgrind-mcstransd
b/policycoreutils/mcstrans/utils/valgrind-mcstransd
new file mode 100644
index 0000000..900c628
--- /dev/null
+++ b/policycoreutils/mcstrans/utils/valgrind-mcstransd
@@ -0,0 +1,5 @@
+#!/bin/bash
+service mcstrans stop
+#valgrind -v --leak-check=full --show-reachable=yes ../src/mcstransd
+runcon -u system_u -r system_r -t setrans_t -l s15:c0.c1023 -- valgrind -v
--leak-check=full --show-reachable=yes ../src/mcstransd
+run_init /etc/init.d/mcstrans start

--005045013e15bf9ab4048bea7064
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>SELinux Project contribution of mcstrans. mcstrans is a userland packag=
e specific to SELinux which allows system administrators to define sensitiv=
ity levels and categories and provides a daemon for their translation into =
human readable form. This version is a merge of Joe Nalls git tree (<a href=
=3D"http://github.com/joenall/mcstrans" target=3D"_blank">http://github.com=
/joenall/mcstrans</a>) and patches supplied by Dan Walsh and others at RedH=
at.<br>

<br>Utilities.<br><br>---<br><br>=A0Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 41 +++++++++++++++++++++++++++++++++++++++++<br>=A0callgrind-mc=
stransd |=A0=A0=A0 5 +++++<br>=A0transcon.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 30 ++++++++++++++++++++++++++++++<br>=A0untranscon.c=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 28 ++++++++++++++++++++++++++++<br>

=A0valgrind-mcstransd=A0 |=A0=A0=A0 5 +++++<br>=A05 files changed, 109 inse=
rtions(+)<br><br>diff --git a/policycoreutils/mcstrans/utils/Makefile b/pol=
icycoreutils/mcstrans/utils/Makefile<br>new file mode 100644<br>index 00000=
00..1ffb027<br>

--- /dev/null<br>+++ b/policycoreutils/mcstrans/utils/Makefile<br>@@ -0,0 +=
1,41 @@<br>+# Installation directories.<br>+PREFIX ?=3D $(DESTDIR)/usr<br>+=
BINDIR ?=3D $(PREFIX)/sbin<br>+<br>+ARCH =3D $(shell uname -i)<br>+ifeq &qu=
ot;$(ARCH)&quot; &quot;x86_64&quot;<br>

+=A0=A0=A0=A0=A0=A0=A0 # In case of 64 bit system, use these lines<br>+=A0=
=A0=A0=A0=A0=A0=A0 LIBDIR=3D/usr/lib64<br>+else<br>+ifeq &quot;$(ARCH)&quot=
; &quot;i686&quot;<br>+=A0=A0=A0=A0=A0=A0=A0 # In case of 32 bit system, us=
e these lines<br>+=A0=A0=A0=A0=A0=A0=A0 LIBDIR=3D/usr/lib<br>

+else<br>+ifeq &quot;$(ARCH)&quot; &quot;i386&quot;<br>+=A0=A0=A0=A0=A0=A0=
=A0 # In case of 32 bit system, use these lines<br>+=A0=A0=A0=A0=A0=A0=A0 L=
IBDIR=3D/usr/lib<br>+endif<br>+endif<br>+endif<br>+<br>+<br>+CFLAGS ?=3D -W=
all<br>+override CFLAGS +=3D -I../src -D_GNU_SOURCE<br>

+LDLIBS +=3D -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre=
 $(LIBDIR)/libsepol.a<br>+<br>+TARGETS=3D$(patsubst %.c,%,$(wildcard *.c))<=
br>+<br>+all: $(TARGETS) <br>+<br>+install: all<br>+=A0=A0=A0 -mkdir -p $(B=
INDIR)<br>

+=A0=A0=A0 install -m 755 $(TARGETS) $(BINDIR)<br>+<br>+test:<br>+=A0=A0=A0=
 ./mlstrans-test-runner.py ../test/*.test<br>+<br>+clean:<br>+=A0=A0=A0 rm =
-f $(TARGETS) *.o *~ \#*<br>+<br>+relabel:<br>+<br>diff --git a/policycoreu=
tils/mcstrans/utils/callgrind-mcstransd b/policycoreutils/mcstrans/utils/ca=
llgrind-mcstransd<br>

new file mode 100644<br>index 0000000..f494b24<br>--- /dev/null<br>+++ b/po=
licycoreutils/mcstrans/utils/callgrind-mcstransd<br>@@ -0,0 +1,5 @@<br>+#!/=
bin/bash<br>+service mcstrans stop<br>+cd ~root<br>+runcon -u system_u -r s=
ystem_r -t setrans_t -l s15:c0.c1023 -- valgrind=A0 --tool=3Dcallgrind /usr=
/src/redhat/BUILD/*/src/mcstransd<br>

+run_init /etc/init.d/mcstrans start<br>diff --git a/policycoreutils/mcstra=
ns/utils/transcon.c b/policycoreutils/mcstrans/utils/transcon.c<br>new file=
 mode 100644<br>index 0000000..5189f0f<br>--- /dev/null<br>+++ b/policycore=
utils/mcstrans/utils/transcon.c<br>

@@ -0,0 +1,30 @@<br>+#include &lt;unistd.h&gt;<br>+#include &lt;stdlib.h&gt=
;<br>+#include &lt;stdio.h&gt;<br>+#include &lt;getopt.h&gt;<br>+#include &=
lt;errno.h&gt;<br>+#include &lt;string.h&gt;<br>+#include &lt;selinux/selin=
ux.h&gt;<br>

+#include &quot;mcstrans.h&quot;<br>+<br>+void usage(const char *progname) =
<br>+{<br>+=A0=A0=A0 fprintf(stderr, &quot;usage:=A0 %s context\n&quot;, pr=
ogname);<br>+=A0=A0=A0 exit(1);<br>+}<br>+<br>+int main(int argc, char **ar=
gv) {<br>
+=A0=A0=A0 security_context_t scon;<br>
+=A0=A0=A0 if ( argc !=3D 2 ) usage(argv[0]);<br>+=A0=A0=A0 if (init_transl=
ations()=3D=3D0) {<br>+=A0=A0=A0 =A0=A0=A0 if(trans_context(argv[1],&amp;sc=
on) =3D=3D 0) {<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printf(&quot;%s\n&quot;, =
scon);<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 freecon(scon);<br>+=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 return 0;<br>

+=A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 }<br>+=A0=A0=A0 printf(&quot;Failed\n&=
quot;);<br>+=A0=A0=A0 return -1;<br>+}<br>+<br>+<br>diff --git a/policycore=
utils/mcstrans/utils/untranscon.c b/policycoreutils/mcstrans/utils/untransc=
on.c<br>new file mode 100644<br>

index 0000000..f47b6ea<br>--- /dev/null<br>+++ b/policycoreutils/mcstrans/u=
tils/untranscon.c<br>@@ -0,0 +1,28 @@<br>+#include &lt;unistd.h&gt;<br>+#in=
clude &lt;stdlib.h&gt;<br>+#include &lt;stdio.h&gt;<br>+#include &lt;getopt=
.h&gt;<br>

+#include &lt;errno.h&gt;<br>+#include &lt;string.h&gt;<br>+#include &lt;se=
linux/selinux.h&gt;<br>+#include &quot;mcstrans.h&quot;<br>+<br>+void usage=
(const char *progname) <br>+{<br>+=A0=A0=A0 fprintf(stderr, &quot;usage:=A0=
 %s context\n&quot;, progname);<br>

+=A0=A0=A0 exit(1);<br>+}<br>+int main(int argc, char **argv) {<br>+=A0=A0=
=A0 security_context_t scon;<br>+=A0=A0=A0 if ( argc !=3D 2 ) usage(argv[0]=
);<br>+=A0=A0=A0 if (init_translations()=3D=3D0) {<br>+=A0=A0=A0 =A0=A0=A0 =
if(untrans_context(argv[1],&amp;scon) =3D=3D 0) {<br>

+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printf(&quot;%s\n&quot;, scon);<br>+=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 freecon(scon);<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 re=
turn 0;<br>+=A0=A0=A0 =A0=A0=A0 }<br>+=A0=A0=A0 }<br>+=A0=A0=A0 return -1;<=
br>+}<br>+<br>+<br>diff --git a/policycoreutils/mcstrans/utils/valgrind-mcs=
transd b/policycoreutils/mcstrans/utils/valgrind-mcstransd<br>

new file mode 100644<br>index 0000000..900c628<br>--- /dev/null<br>+++ b/po=
licycoreutils/mcstrans/utils/valgrind-mcstransd<br>@@ -0,0 +1,5 @@<br>+#!/b=
in/bash<br>+service mcstrans stop<br>+#valgrind -v --leak-check=3Dfull --sh=
ow-reachable=3Dyes ../src/mcstransd<br>

+runcon -u system_u -r system_r -t setrans_t -l s15:c0.c1023 -- valgrind -v=
 --leak-check=3Dfull --show-reachable=3Dyes ../src/mcstransd<br>+run_init /=
etc/init.d/mcstrans start<br><br>

--005045013e15bf9ab4048bea7064--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
