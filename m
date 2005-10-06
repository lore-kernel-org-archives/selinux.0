Subject: RE: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, SELinux-dev@tresys.com
In-Reply-To: <1128546766.24059.239.camel@moss-spartans.epoch.ncsc.mil>
References: <200510031440.j93EebYs015780@gotham.columbia.tresys.com>
	 <1128354097.26285.126.camel@moss-spartans.epoch.ncsc.mil>
	 <1128366074.26285.210.camel@moss-spartans.epoch.ncsc.mil>
	 <1128546766.24059.239.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-Wpx11YgbcN9+1bDTrNmX"
Date: Thu, 06 Oct 2005 12:39:36 -0400
Message-Id: <1128616776.15836.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Wpx11YgbcN9+1bDTrNmX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-10-05 at 17:12 -0400, Stephen Smalley wrote:
> Updated patches below.  Back to preservebools as the only argument (and
> -b as the only option to load_policy), with localdefs determined
> from /etc/selinux/config (defaulting to enabled if not specified).
> Thus, when we cut over to the new infrastructure, we don't have to
> repatch /sbin/init again, but only change /etc/selinux/config to include
> SETLOCALDEFS=1.  Look sane?

I merged the selinux_mkload_policy function into libselinux 1.27.5.
However, when I went back and looked at the sysvinit-selinux.patch, it
occurred to me that we should also migrate the remaining logic in the
load_policy() function in that patch into a higher level libselinux
function built on top of selinux_mkload_policy.  While this logic is
specific to the initial policy load, it does contain SELinux-specific
logic that may change in the future (selinuxfs mount point or even the
existence of selinuxfs as a separate fs, interpretation of selinux
kernel command line arguments, handling of /etc/selinux/config).  Moving
it into libselinux also gave me the opportunity to do some cleanup of
the logic.  The new function is called selinux_init_load_policy(); patch
is attached and merged into libselinux 1.27.6.  Also attached is the
interdiff for the sysvinit-selinux.patch (also obsoletes
sysvinit-2.85-selgenusers.patch).

-- 
Stephen Smalley
National Security Agency

--=-Wpx11YgbcN9+1bDTrNmX
Content-Disposition: attachment; filename=libselinux-1.27.6.patch
Content-Type: text/x-patch; name=libselinux-1.27.6.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/ChangeLog,v
retrieving revision 1.147
retrieving revision 1.148
diff -u -p -r1.147 -r1.148
--- libselinux/ChangeLog	6 Oct 2005 11:40:41 -0000	1.147
+++ libselinux/ChangeLog	6 Oct 2005 16:00:26 -0000	1.148
@@ -1,3 +1,8 @@
+1.27.6 2005-10-06
+	* Added selinux_init_load_policy() function as an even higher level
+	interface for the initial policy load by /sbin/init.  This obsoletes
+	the load_policy() function in the sysvinit-selinux.patch. 
+
 1.27.5 2005-10-06
 	* Added selinux_mkload_policy() function as a higher level interface
 	for loading policy than the security_load_policy() interface.
Index: libselinux/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/VERSION,v
retrieving revision 1.65
retrieving revision 1.66
diff -u -p -r1.65 -r1.66
--- libselinux/VERSION	6 Oct 2005 11:40:41 -0000	1.65
+++ libselinux/VERSION	6 Oct 2005 16:00:27 -0000	1.66
@@ -1 +1 @@
-1.27.5
+1.27.6
Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.46
retrieving revision 1.47
diff -u -p -r1.46 -r1.47
--- libselinux/include/selinux/selinux.h	6 Oct 2005 11:40:41 -0000	1.46
+++ libselinux/include/selinux/selinux.h	6 Oct 2005 16:00:27 -0000	1.47
@@ -187,6 +187,24 @@ extern int security_load_policy(void *da
  */
 extern int selinux_mkload_policy(int preservebools);
 
+
+/* 
+ * Perform the initial policy load.
+ * This function determines the desired enforcing mode, sets the
+ * the *enforce argument accordingly for the caller to use, sets the 
+ * SELinux kernel enforcing status to match it, and loads the policy.
+ * It also internally handles the initial selinuxfs mount required to
+ * perform these actions.
+ *
+ * The function returns 0 if everything including the policy load succeeds.
+ * In this case, init is expected to re-exec itself in order to transition
+ * to the proper security context.
+ * Otherwise, the function returns -1, and init must check *enforce to
+ * determine how to proceed.  If enforcing (*enforce > 0), then init should
+ * halt the system.  Otherwise, init may proceed normally without a re-exec.
+ */
+extern int selinux_init_load_policy(int *enforce);
+
 /* Translate boolean strict to name value pair. */
 typedef struct {
 	char *name;
Index: libselinux/src/disable.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/disable.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -p -r1.1 -r1.2
--- libselinux/src/disable.c	20 Apr 2004 15:43:15 -0000	1.1
+++ libselinux/src/disable.c	6 Oct 2005 16:00:27 -0000	1.2
@@ -4,7 +4,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 #include "policy.h"
 #include <stdio.h>
 #include <limits.h>
@@ -29,3 +29,5 @@ int security_disable(void)
 
 	return 0;
 }
+hidden_def(security_disable)
+
Index: libselinux/src/init.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/init.c,v
retrieving revision 1.15
retrieving revision 1.16
diff -u -p -r1.15 -r1.16
--- libselinux/src/init.c	14 Sep 2005 19:51:33 -0000	1.15
+++ libselinux/src/init.c	6 Oct 2005 16:00:27 -0000	1.16
@@ -1,7 +1,6 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
@@ -11,6 +10,7 @@
 
 #include "dso.h"
 #include "policy.h"
+#include "selinux_internal.h"
 
 char *selinux_mnt = NULL;
 
@@ -73,6 +73,7 @@ void set_selinuxmnt(char *mnt)
 {
 	selinux_mnt = strdup(mnt);
 }
+hidden_def(set_selinuxmnt)
  
 int context_translations hidden;
 void *translation_lib_handle hidden;
Index: libselinux/src/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/load_policy.c,v
retrieving revision 1.6
retrieving revision 1.8
diff -u -p -r1.6 -r1.8
--- libselinux/src/load_policy.c	6 Oct 2005 11:40:41 -0000	1.6
+++ libselinux/src/load_policy.c	6 Oct 2005 16:18:13 -0000	1.8
@@ -2,9 +2,12 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <ctype.h>
+#include <string.h>
 #include <errno.h>
 #include "selinux_internal.h"
 #include <sepol/sepol.h>
@@ -105,4 +108,119 @@ close:
 	close(fd);
 	return rc;
 }
+hidden_def(selinux_mkload_policy)
 
+/*
+ * Mount point for selinuxfs. 
+ * This definition is private to the function below.
+ * Everything else uses the location determined during 
+ * libselinux startup via /proc/mounts (see init_selinuxmnt).  
+ * We only need the hardcoded definition for the initial mount 
+ * required for the initial policy load.
+ */
+#define SELINUXMNT "/selinux/"
+
+int selinux_init_load_policy(int *enforce)
+{
+	int rc = 0, orig_enforce = 0, seconfig = -2, secmdline = -1;
+	FILE *cfg;
+	char buf[4096];
+
+	/*
+	 * Get desired mode (disabled, permissive, enforcing) from 
+	 * /etc/selinux/config. 
+	 */
+	selinux_getenforcemode(&seconfig);
+
+	/* Check for an override of the mode via the kernel command line. */
+	rc = mount("none", "/proc", "proc", 0, 0);
+	cfg = fopen("/proc/cmdline", "r");
+	if (cfg) {
+		char *tmp;
+		if (fgets(buf, 4096, cfg) && 
+		    (tmp = strstr(buf,"enforcing="))) {
+			if (tmp == buf || isspace(*(tmp-1))) {
+				secmdline = atoi(tmp+sizeof("enforcing=")-1);
+			}
+		}
+		fclose(cfg);
+	}
+#define MNT_DETACH 2
+	if (rc == 0)
+		umount2("/proc", MNT_DETACH);
+
+	/* 
+	 * Determine the final desired mode.
+	 * Command line argument takes precedence, then config file. 
+	 */
+	if (secmdline >= 0)
+		*enforce = secmdline; 
+	else if (seconfig >= 0)
+		*enforce = seconfig;
+	else
+		*enforce = 0; /* unspecified or disabled */
+
+	/*
+	 * Check for the existence of SELinux via selinuxfs, and 
+	 * mount it if present for use in the calls below.  
+	 */
+	if (mount("none", SELINUXMNT, "selinuxfs", 0, 0) < 0) {
+		if (errno == ENODEV) {
+			/*
+			 * SELinux was disabled in the kernel, either
+			 * omitted entirely or disabled at boot via selinux=0.
+			 * This takes precedence over any config or
+			 * commandline enforcing setting.
+			 */
+			*enforce = 0;
+		}
+		goto noload;
+	}
+	set_selinuxmnt(SELINUXMNT);
+
+	/*
+	 * Note:  The following code depends on having selinuxfs 
+	 * already mounted and selinuxmnt set above.
+	 */
+
+	if (seconfig == -1) {
+		/* Runtime disable of SELinux. */
+		rc = security_disable();
+		if (rc == 0) {
+			/* Successfully disabled, so umount selinuxfs too. */
+			umount(SELINUXMNT);
+		}
+		/*
+		 * If we failed to disable, SELinux will still be 
+		 * effectively permissive, because no policy is loaded. 
+		 * No need to call security_setenforce(0) here.
+		 */
+		goto noload;
+	}
+
+	/*
+	 * If necessary, change the kernel enforcing status to match 
+	 * the desired mode. 
+	 */
+	orig_enforce = rc = security_getenforce();
+	if (rc < 0)
+		goto noload;
+	if (orig_enforce != *enforce) {
+		rc = security_setenforce(*enforce);
+		if (rc < 0)
+			goto noload;
+	}
+
+	/* Load the policy. */
+	return selinux_mkload_policy(0);
+
+noload:
+	/*
+	 * Only return 0 on a successful completion of policy load.
+	 * In any other case, we want to return an error so that init
+	 * knows not to proceed with the re-exec for the domain transition.
+	 * Depending on the *enforce setting, init will halt (> 0) or proceed
+	 * normally (otherwise).
+	 */
+	return -1;
+}
Index: libselinux/src/selinux_config.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_config.c,v
retrieving revision 1.18
retrieving revision 1.19
diff -u -p -r1.18 -r1.19
--- libselinux/src/selinux_config.c	6 Oct 2005 11:40:41 -0000	1.18
+++ libselinux/src/selinux_config.c	6 Oct 2005 16:00:27 -0000	1.19
@@ -117,6 +117,7 @@ int selinux_getenforcemode(int *enforce)
   }
   return ret;
 }
+hidden_def(selinux_getenforcemode)
 
 static char *selinux_policyroot = NULL;
 
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.11
retrieving revision 1.12
diff -u -p -r1.11 -r1.12
--- libselinux/src/selinux_internal.h	6 Oct 2005 11:40:41 -0000	1.11
+++ libselinux/src/selinux_internal.h	6 Oct 2005 16:00:27 -0000	1.12
@@ -1,6 +1,9 @@
 #include <selinux/selinux.h>
 #include "dso.h"
 
+hidden_proto(selinux_mkload_policy)
+hidden_proto(set_selinuxmnt)
+hidden_proto(security_disable)
 hidden_proto(security_policyvers)
 hidden_proto(security_load_policy)
 hidden_proto(security_get_boolean_active)
@@ -41,6 +44,7 @@ hidden_proto(setexeccon_raw)
 hidden_proto(getfscreatecon_raw)
 hidden_proto(setfscreatecon_raw)
 hidden_proto(security_getenforce)
+hidden_proto(security_setenforce)
 hidden_proto(selinux_binary_policy_path)
 hidden_proto(selinux_default_context_path)
 hidden_proto(selinux_failsafe_context_path)
@@ -54,6 +58,7 @@ hidden_proto(selinux_check_passwd_access
 hidden_proto(matchpathcon_init)
 hidden_proto(selinux_users_path)
 hidden_proto(selinux_usersconf_path);
+hidden_proto(selinux_getenforcemode);
 
 extern int context_translations hidden;
 extern int hidden trans_to_raw_context(char *trans, char **rawp);
Index: libselinux/src/setenforce.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/setenforce.c,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -p -r1.4 -r1.5
--- libselinux/src/setenforce.c	18 Dec 2003 17:33:47 -0000	1.4
+++ libselinux/src/setenforce.c	6 Oct 2005 16:00:27 -0000	1.5
@@ -4,7 +4,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 #include "policy.h"
 #include <stdio.h>
 #include <limits.h>
@@ -28,3 +28,4 @@ int security_setenforce(int value)
 
 	return 0;
 }
+hidden_def(security_setenforce)

--=-Wpx11YgbcN9+1bDTrNmX
Content-Disposition: attachment; filename=sysvinit-selinux.interdiff
Content-Type: text/x-patch; name=sysvinit-selinux.interdiff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -u sysvinit-2.85/src/init.c sysvinit-2.85/src/init.c
--- sysvinit-2.85/src/init.c	2004-08-12 06:25:30.166271148 -0400
+++ sysvinit-2.85/src/init.c	2005-10-06 11:17:41.000000000 -0400
@@ -48,10 +48,7 @@
 #include <stdarg.h>
 #include <sys/syslog.h>
 #include <sys/time.h>
-#include <sys/mman.h>
 #include <selinux/selinux.h>
-#include <sepol/sepol.h>
-#include <sys/mount.h>
 
 
 #ifdef __i386__
@@ -108,7 +105,6 @@
 int dfl_level = 0;		/* Default runlevel */
 sig_atomic_t got_cont = 0;	/* Set if we received the SIGCONT signal */
 sig_atomic_t got_signals;	/* Set if we received a signal. */
-int enforcing = -1;		/* SELinux enforcing mode */
 int emerg_shell = 0;		/* Start emergency shell? */
 int wrote_wtmp_reboot = 1;	/* Set when we wrote the reboot record */
 int wrote_utmp_reboot = 1;	/* Set when we wrote the reboot record */
@@ -193,146 +189,6 @@
 	{NULL,0}
 };
 
-/* Mount point for selinuxfs. */
-#define SELINUXMNT "/selinux/"
-
-static int load_policy(int *enforce) 
-{
-	int fd=-1,ret=-1;
-	int rc=0, orig_enforce;
-	struct stat sb;
-	void *map;
-	char policy_file[PATH_MAX];
-	int policy_version=0;
-	FILE *cfg;
-	char buf[4096];
-	int seconfig = -2;
-	
-	selinux_getenforcemode(&seconfig);
-
-	mount("none", "/proc", "proc", 0, 0);
-	cfg = fopen("/proc/cmdline","r");
-	if (cfg) {
-		char *tmp;
-		if (fgets(buf,4096,cfg) && (tmp = strstr(buf,"enforcing="))) {
-			if (tmp == buf || isspace(*(tmp-1))) {
-				enforcing=atoi(tmp+10);
-			}
-		}
-		fclose(cfg);
-	}
-#define MNT_DETACH 2
-	umount2("/proc",MNT_DETACH);
-	
-	if (enforcing >=0)
-		*enforce = enforcing;
-	else if (seconfig == 1)
-		*enforce = 1;
-	
-	if (mount("none", SELINUXMNT, "selinuxfs", 0, 0) < 0) {
-		if (errno == ENODEV) {
-			log(L_VB, "SELinux not supported by kernel: %s\n",SELINUXMNT,strerror(errno));
-			*enforce = 0;
-		} else {
-			log(L_VB, "Failed to mount %s: %s\n",SELINUXMNT,strerror(errno));
-		}
-		return ret;
-	}
-
-	set_selinuxmnt(SELINUXMNT); /* set manually since we mounted it */
-
-	policy_version=security_policyvers();
-	if (policy_version < 0) {
-		log(L_VB,  "Can't get policy version: %s\n", strerror(errno));
-		goto UMOUNT;
-	}
-  
-	orig_enforce = rc = security_getenforce();
-	if (rc < 0) {
-		log(L_VB,  "Can't get SELinux enforcement flag: %s\n", strerror(errno));
-		goto UMOUNT;
-	}
-	if (enforcing >= 0) {
-		*enforce = enforcing;
-	} else if (seconfig == -1) {
-		*enforce = 0;
-		rc = security_disable();
-		if (rc == 0) umount(SELINUXMNT);
-		if (rc < 0) {
-			rc = security_setenforce(0);
-			if (rc < 0) {
-				log(L_VB, "Can't disable SELinux: %s\n", strerror(errno));
-				goto UMOUNT;
-			}
-		}
-		ret = 0;
-		goto UMOUNT;
-	} else if (seconfig >= 0) {
-		*enforce = seconfig;
-		if (orig_enforce != *enforce) {
-			rc = security_setenforce(seconfig);
-			if (rc < 0) {
-				log(L_VB, "Can't set SELinux enforcement flag: %s\n", strerror(errno));
-				goto UMOUNT;
-			}
-		}
-	}
-
-	snprintf(policy_file,sizeof(policy_file),"%s.%d",selinux_binary_policy_path(),policy_version);
-	fd = open(policy_file, O_RDONLY);
-	if (fd < 0) {
-		/* Check previous version to see if old policy is available
-		 */
-		snprintf(policy_file,sizeof(policy_file),"%s.%d",selinux_binary_policy_path(),policy_version-1);
-		fd = open(policy_file, O_RDONLY);
-		if (fd < 0) {
-			log(L_VB,  "Can't open '%s.%d':  %s\n",
-			    selinux_binary_policy_path(),policy_version,strerror(errno));
-			goto UMOUNT;
-		}
-	}
-  
-	if (fstat(fd, &sb) < 0) {
-		log(L_VB, "Can't stat '%s':  %s\n",
-		    policy_file, strerror(errno));
-		goto UMOUNT;
-	}
-  
-	map = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if (map == MAP_FAILED) {
-		log(L_VB,  "Can't map '%s':  %s\n",
-		    policy_file, strerror(errno));
-		goto UMOUNT;
-	}
-
-
-	/* Set booleans based on a booleans configuration file. */
-	ret = sepol_genbools(map, sb.st_size, selinux_booleans_path());
-	if (ret < 0) {
-		if (errno == ENOENT || errno == EINVAL) {
-			/* No booleans file or stale booleans in the file; non-fatal. */
-			log(L_VB,"Warning!  Error while setting booleans:  %s\n"
-			    , strerror(errno));
-		} else {
-			log(L_VB,"Error while setting booleans:  %s\n", 
-			    strerror(errno));
-			goto UMOUNT;
-		}
-	}
-	log(L_VB, "Loading security policy\n");
-	ret=security_load_policy(map, sb.st_size);
-	if (ret < 0) {
-		log(L_VB, "security_load_policy failed\n");
-	}
-
-UMOUNT:
-	/*umount(SELINUXMNT); */
-	if ( fd >= 0) {
-		close(fd);
-	}
-	return(ret);
-}
-
 /*
  *	Sleep a number of seconds.
  *
@@ -2725,7 +2581,7 @@
 
   	if (getenv("SELINUX_INIT") == NULL) {
 	  putenv("SELINUX_INIT=YES");
-	  if (load_policy(&enforce) == 0 ) {
+	  if (selinux_init_load_policy(&enforce) == 0 ) {
 	    execv(myname, argv);
 	  } else {
 	    if (enforce > 0) {

--=-Wpx11YgbcN9+1bDTrNmX--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
