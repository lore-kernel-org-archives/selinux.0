Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBII0eRb008176
	for <selinux@tycho.nsa.gov>; Thu, 18 Dec 2003 13:00:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBIHxijx008785
	for <selinux@tycho.nsa.gov>; Thu, 18 Dec 2003 17:59:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBIHxiSR008782
	for <selinux@tycho.nsa.gov>; Thu, 18 Dec 2003 17:59:44 GMT
Subject: Re: [patch] Change libselinux to discover selinuxfs mount point
	via /proc/mounts (Was:  Re: Information about selinuxfs)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1071243803.14716.49.camel@moss-spartans.epoch.ncsc.mil>
References: <3FD9B8F2.7030100@ipen.br>
	 <1071236618.14716.21.camel@moss-spartans.epoch.ncsc.mil>
	 <1071243803.14716.49.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-RhjSzBseHmCv4qJDkzHR"
Message-Id: <1071770414.9102.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 18 Dec 2003 13:00:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-RhjSzBseHmCv4qJDkzHR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-12-12 at 10:43, Stephen Smalley wrote:
> The attached patch makes the change described above to libselinux.  A
> constructor function determines the selinuxfs mount point from
> /proc/mounts during initialization, and this mount point directory is
> then used by the libselinux functions.  This eliminates the need to
> rebuild libselinux in the future if the mount point changes.

Dan Walsh pointed out that this patch to libselinux breaks the
SELinux-patched /sbin/init program, because:
a) when the init_selinuxmnt() constructor runs for /sbin/init, selinuxfs
has not yet been mounted, so selinux_mnt cannot be determined,
b) even if init_selinuxmnt() were explicitly called by /sbin/init after
performing the mount, it still cannot obtain the information from
/proc/mounts because /proc is not mounted yet.

An updated sysvinit-selinux.patch is attached; this patch causes
/sbin/init to explicitly set selinux_mnt to avoid this problem.  Dan has
updated RPMs on his page (under ftp://people.redhat.com/dwalsh/SELinux).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-RhjSzBseHmCv4qJDkzHR
Content-Disposition: attachment; filename=sysvinit-selinux.patch
Content-Type: text/plain; name=sysvinit-selinux.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- sysvinit-2.85/src/Makefile.selinux	2003-12-18 10:59:15.184561444 -0500
+++ sysvinit-2.85/src/Makefile	2003-12-18 10:59:15.645514208 -0500
@@ -32,7 +32,7 @@
 all:		$(PROGS)
 
 init:		init.o init_utmp.o
-		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o
+		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o -lselinux
 
 halt:		halt.o ifdown.o hddown.o utmp.o reboot.h
 		$(CC) $(LDFLAGS) -o $@ halt.o ifdown.o hddown.o utmp.o
@@ -62,7 +62,7 @@
 		$(CC) $(LDFLAGS) -o $@ bootlogd.o
 
 init.o:		init.c init.h set.h reboot.h
-		$(CC) -c $(CFLAGS) init.c
+		$(CC) -c $(CFLAGS) -DWITH_SELINUX init.c
 
 utmp.o:		utmp.c init.h
 		$(CC) -c $(CFLAGS) utmp.c
--- sysvinit-2.85/src/init.c.selinux	2003-12-18 10:59:15.590519844 -0500
+++ sysvinit-2.85/src/init.c	2003-12-18 11:01:06.370705686 -0500
@@ -78,6 +78,81 @@
 			sigemptyset(&sa.sa_mask); \
 			sigaction(sig, &sa, NULL); \
 		} while(0)
+#ifdef WITH_SELINUX
+#include <sys/mman.h>
+#include <selinux/selinux.h>
+#include <sys/mount.h>
+
+static int load_policy(int *enforce) 
+{
+  int fd=-1,ret=-1;
+  int rc=0;
+  struct stat sb;
+  void *map;
+  char policy_file[PATH_MAX];
+  int policy_version=0;
+  extern char *selinux_mnt;
+
+  log(L_VB, "Loading security policy\n");
+  if (mount("none", SELINUXMNT, "selinuxfs", 0, 0) < 0) {
+    if (errno == ENODEV) {
+      log(L_VB, "SELinux not supported by kernel: %s\n",SELINUXMNT,strerror(errno));
+    } 
+    else {
+      log(L_VB, "Failed to mount %s: %s\n",SELINUXMNT,strerror(errno));
+      return ret;
+    }
+    return ret; /* Never gets here */
+  }
+
+  selinux_mnt = SELINUXMNT; /* set manually since we mounted it */
+
+  policy_version=security_policyvers();
+  if (policy_version < 0) {
+    log(L_VB,  "Can't get policy version: %s\n", strerror(errno));
+    goto UMOUNT;
+  }
+  
+  rc=security_getenforce();
+  if (rc < 0) {
+    log(L_VB,  "Can't get SELinux enforcement flag: %s\n", strerror(errno));
+    goto UMOUNT;
+  } 
+  *enforce=rc;
+
+  snprintf(policy_file,sizeof(policy_file),"%s.%d",SELINUXPOLICY,policy_version);
+  fd = open(policy_file, O_RDONLY);
+  if (fd < 0) {
+    log(L_VB,  "Can't open '%s':  %s\n",
+	    policy_file, strerror(errno));
+    goto UMOUNT;
+  }
+  
+  if (fstat(fd, &sb) < 0) {
+    log(L_VB, "Can't stat '%s':  %s\n",
+	    policy_file, strerror(errno));
+    goto UMOUNT;
+  }
+  
+  map = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, fd, 0);
+  if (map == MAP_FAILED) {
+    log(L_VB,  "Can't map '%s':  %s\n",
+	    policy_file, strerror(errno));
+    goto UMOUNT;
+  }
+  ret=security_load_policy(map, sb.st_size);
+  if (ret < 0) {
+    log(L_VB, "security_load_policy failed\n");
+  }
+
+ UMOUNT:
+  /*umount(SELINUXMNT); */
+  if ( fd >= 0) {
+    close(fd);
+  }
+  return(ret);
+}
+#endif
 
 /* Version information */
 char *Version = "@(#) init " VERSION "  " DATE "  miquels@cistron.nl";
@@ -2576,6 +2651,20 @@
 		maxproclen += strlen(argv[f]) + 1;
 	}
 
+#ifdef WITH_SELINUX
+  	if (getenv("SELINUX_INIT") == NULL) {
+	  putenv("SELINUX_INIT=YES");
+	  int enforce=0;
+	  if (load_policy(&enforce) == 0 ) {
+	    execv(myname, argv);
+	  } else {
+	    if (enforce) 
+	      /* SELinux in enforcing mode but load_policy failed */
+	      exit(1);
+	  }
+	}
+#endif
+  
 	/* Start booting. */
 	argv0 = argv[0];
 	argv[1] = NULL;

--=-RhjSzBseHmCv4qJDkzHR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
