Message-ID: <36282A1733C57546BE392885C0618592B93140@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh
	 <dwalsh@redhat.com>
Cc: Darrel Goeddel <DGoeddel@TrustedCS.com>,
   Daniel J Walsh
	 <Dan-Walsh@comcast.net>, SELinux <SELinux@tycho.nsa.gov>
Subject: RE: Category Translation patch for MCS/MLS Policy
Date: Mon, 15 Aug 2005 16:35:06 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5A1D8.D271FA20"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5A1D8.D271FA20
Content-Type: text/plain;
	charset="iso-8859-1"


Attached is a patch to dlopen libselinux from procps and call getpidcon.
This patch is relative to procps-3.2.5-6.3 (from Fedora Updates).

-Chad

Stephen Smalley wrote:

> 
> IIRC, at present, procps doesn't use libselinux at all; procps directly
> reads /proc/pid/attr/current and displays that value, since procps
> already deals directly with /proc/pid entries and the maintainer
> preferred to avoid a dependency of procps on libselinux (but was willing
> to accept a dlopen of libselinux if we were to create such a patch, as
> long as procps continues to work in the absence of libselinux).  Hence,
> without further changes, procps won't perform any translation at all.
> 
> -- 
> Stephen Smalley
> National Security Agency
>  


------_=_NextPart_000_01C5A1D8.D271FA20
Content-Type: application/octet-stream;
	name="procps-3.2.5-libselinux.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="procps-3.2.5-libselinux.patch"

diff -Nur procps-3.2.5.orig/ps/module.mk procps-3.2.5/ps/module.mk=0A=
--- procps-3.2.5.orig/ps/module.mk	2004-07-14 22:20:06.000000000 =
+0000=0A=
+++ procps-3.2.5/ps/module.mk	2005-05-09 19:46:22.000000000 +0000=0A=
@@ -20,7 +20,7 @@=0A=
 TARFILES +=3D $(PSSRC) $(addprefix ps/,$(PS_X))=0A=
 =0A=
 ps/ps: $(PSOBJ) $(LIBPROC)=0A=
-	$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -o $@ $^=0A=
+	$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -o $@ $^ -ldl=0A=
 =0A=
 # This just adds the stacktrace code=0A=
 ps/debug: $(PSOBJ) stacktrace.o $(LIBPROC)=0A=
diff -Nur procps-3.2.5.orig/ps/output.c procps-3.2.5/ps/output.c=0A=
--- procps-3.2.5.orig/ps/output.c	2005-01-14 19:06:19.000000000 =
+0000=0A=
+++ procps-3.2.5/ps/output.c	2005-08-10 20:54:47.000000000 +0000=0A=
@@ -53,6 +53,7 @@=0A=
 #include <sys/mman.h>=0A=
 #include <time.h>=0A=
 #include <unistd.h>=0A=
+#include <dlfcn.h>=0A=
 =0A=
 #include "../proc/readproc.h"=0A=
 #include "../proc/sysinfo.h"=0A=
@@ -1094,31 +1095,34 @@=0A=
 =0A=
 // move the bulk of this to libproc sometime=0A=
 static int pr_context(char *restrict const outbuf, const proc_t =
*restrict const pp){=0A=
-  char filename[48];=0A=
+  static int (*ps_getpidcon)(pid_t pid, char **context) =3D 0;=0A=
+  static int tried_load =3D 0;=0A=
   size_t len;=0A=
-  ssize_t num_read;=0A=
-  int fd;=0A=
+  char *context;=0A=
 =0A=
-// wchan file is suitable for testing=0A=
-//snprintf(filename, sizeof filename, "/proc/%d/wchan", pp->tgid);=0A=
-snprintf(filename, sizeof filename, "/proc/%d/attr/current", =
pp->tgid);=0A=
-=0A=
-  fd =3D open(filename, O_RDONLY, 0);=0A=
-  if(likely(fd=3D=3D-1)) goto fail;=0A=
-  num_read =3D read(fd, outbuf, 666);=0A=
-  close(fd);=0A=
-  if(unlikely(num_read<=3D0)) goto fail;=0A=
-  outbuf[num_read] =3D '\0';=0A=
-=0A=
-  len =3D 0;=0A=
-  while(outbuf[len]>' ' && outbuf[len]<=3D'~') len++;=0A=
-  outbuf[len] =3D '\0';=0A=
-  if(len) return len;=0A=
-=0A=
-fail:=0A=
-  outbuf[0] =3D '-';=0A=
-  outbuf[1] =3D '\0';=0A=
-  return 1;=0A=
+  if(!ps_getpidcon && !tried_load){=0A=
+    void *handle =3D dlopen("libselinux.so.1", RTLD_NOW);=0A=
+    if(handle){=0A=
+      dlerror();=0A=
+      ps_getpidcon =3D dlsym(handle, "getpidcon");=0A=
+      if(dlerror())=0A=
+        ps_getpidcon =3D 0;=0A=
+    }=0A=
+    tried_load++;=0A=
+  }=0A=
+  if(ps_getpidcon && !ps_getpidcon(pp->tgid, &context)){=0A=
+    size_t max_len =3D OUTBUF_SIZE-1;=0A=
+    len =3D strlen(context);=0A=
+    if(len > max_len) len =3D max_len;=0A=
+    memcpy(outbuf, context, len);=0A=
+    outbuf[len] =3D '\0';=0A=
+    free(context);=0A=
+  }else{=0A=
+    outbuf[0] =3D '-';=0A=
+    outbuf[1] =3D '\0';=0A=
+    len =3D 1;=0A=
+  }=0A=
+  return len;=0A=
 }=0A=
 =0A=
 =0A=

------_=_NextPart_000_01C5A1D8.D271FA20--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
