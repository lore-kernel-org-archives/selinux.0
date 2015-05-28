Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4SI6vCp015735
 for <selinux@tycho.nsa.gov>; Thu, 28 May 2015 14:06:57 -0400
Date: Thu, 28 May 2015 20:06:48 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SELinux <selinux@tycho.nsa.gov>
Subject: getpidcon() behaviour when other LSM is enabled
Message-ID: <20150528200648.6fb9e949@fornost.bigon.be>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/+zU/knW3Ak9yLKI2Rwu280Y"
Cc: 786956@bugs.debian.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--MP_/+zU/knW3Ak9yLKI2Rwu280Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

In procps(-ng)[0] when the use of libselinux is enabled at build time,
it always uses getpidcon() even if an other (or no) LSM is enabled.

I tried to use getpidcon() (via the cmd tool getpidcon) with apparmor
enabled instead of selinux, and it returned the apparmor context.
Is this expected and can we rely on this?

Otherwise, I've prepared the attached patch. Would this patch be
acceptable?

Cheers,

Laurent Bigonville

[0] https://gitlab.com/procps-ng/procps/blob/master/ps/output.c#L1237
--MP_/+zU/knW3Ak9yLKI2Rwu280Y
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=procps_libselinux.patch

diff --git a/ps/output.c b/ps/output.c
index 326dbe7..fd28924 100644
--- a/ps/output.c
+++ b/ps/output.c
@@ -1232,67 +1232,69 @@ _pr_ns(utsns, UTSNS);
 /****************** FLASK & seLinux security stuff **********************/
 // move the bulk of this to libproc sometime
 
-#if !ENABLE_LIBSELINUX
-
-static int pr_context(char *restrict const outbuf, const proc_t *restrict const pp){
-  char filename[48];
-  size_t len;
-  ssize_t num_read;
-  int fd;
-
-// wchan file is suitable for testing
-//snprintf(filename, sizeof filename, "/proc/%d/wchan", pp->tgid);
-snprintf(filename, sizeof filename, "/proc/%d/attr/current", pp->tgid);
-
-  fd = open(filename, O_RDONLY, 0);
-  if(likely(fd==-1)) goto fail;
-  num_read = read(fd, outbuf, 666);
-  close(fd);
-  if(unlikely(num_read<=0)) goto fail;
-  outbuf[num_read] = '\0';
-
-  len = 0;
-  while(outbuf[len]>' ' && outbuf[len]<='~') len++;
-  outbuf[len] = '\0';
-  if(len) return len;
-
-fail:
-  outbuf[0] = '-';
-  outbuf[1] = '\0';
-  return 1;
-}
-
-#else
-
 // This needs more study, considering:
 // 1. the static linking option (maybe disable this in that case)
 // 2. the -z and -Z option issue
 // 3. width of output
 static int pr_context(char *restrict const outbuf, const proc_t *restrict const pp){
+  static void (*ps_freecon)(char*) = 0;
   static int (*ps_getpidcon)(pid_t pid, char **context) = 0;
+  static int (*ps_is_selinux_enabled)(void) = 0;
   static int tried_load = 0;
+  static int selinux_enabled = 0;
   size_t len;
   char *context;
 
+#if ENABLE_LIBSELINUX
   if(!ps_getpidcon && !tried_load){
     void *handle = dlopen("libselinux.so.1", RTLD_NOW);
     if(handle){
+      ps_freecon = dlsym(handle, "freecon");
+      if(dlerror())
+        ps_freecon = 0;
       dlerror();
       ps_getpidcon = dlsym(handle, "getpidcon");
       if(dlerror())
         ps_getpidcon = 0;
+      ps_is_selinux_enabled = dlsym(handle, "is_selinux_enabled");
+      if(dlerror())
+        ps_is_selinux_enabled = 0;
+      else
+        selinux_enabled = ps_is_selinux_enabled();
     }
     tried_load++;
   }
-  if(ps_getpidcon && !ps_getpidcon(pp->tgid, &context)){
+#endif
+  if(ps_getpidcon && selinux_enabled && !ps_getpidcon(pp->tgid, &context)){
     size_t max_len = OUTBUF_SIZE-1;
     len = strlen(context);
     if(len > max_len) len = max_len;
     memcpy(outbuf, context, len);
     if (outbuf[len-1] == '\n') --len;
     outbuf[len] = '\0';
-    free(context);
+    ps_freecon(context);
   }else{
+    char filename[48];
+    ssize_t num_read;
+    int fd;
+
+// wchan file is suitable for testing
+//snprintf(filename, sizeof filename, "/proc/%d/wchan", pp->tgid);
+    snprintf(filename, sizeof filename, "/proc/%d/attr/current", pp->tgid);
+
+    fd = open(filename, O_RDONLY, 0);
+    if(likely(fd==-1)) goto fail;
+    num_read = read(fd, outbuf, 666);
+    close(fd);
+    if(unlikely(num_read<=0)) goto fail;
+    outbuf[num_read] = '\0';
+
+    len = 0;
+    while(outbuf[len]>' ' && outbuf[len]<='~') len++;
+    outbuf[len] = '\0';
+    if(len) return len;
+
+  fail:
     outbuf[0] = '-';
     outbuf[1] = '\0';
     len = 1;
@@ -1300,9 +1302,6 @@ static int pr_context(char *restrict const outbuf, const proc_t *restrict const
   return len;
 }
 
-#endif
-
-
 ////////////////////////////// Test code /////////////////////////////////
 
 // like "args"

--MP_/+zU/knW3Ak9yLKI2Rwu280Y--
