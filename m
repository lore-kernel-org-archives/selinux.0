Message-ID: <4DC01640.9000206@redhat.com>
Date: Tue, 03 May 2011 10:50:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: Lennart Poettering <lennart@poettering.net>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: libselinux mountpoint changing patch.
Content-Type: multipart/mixed;
 boundary="------------070802060504090806040003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070802060504090806040003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The Fedora Distribution is looking to standardize kernel subsystem file
systems to be mounted under /sys/fs. They would like us to move /selinux
to /sys/fs/selinux.  This patch changes libselinux in the following ways:

1.  load_policy will first check if /sys/fs/selinux exists and mount the
selinuxfs at this location, if it does not exists it will fall back to
mounting the file system at /selinux (if it exists).

2.  The init functions of selinux will now check if /sys/fs/selinux is
mounted, if it is and has an SELinuxfs mounted on it, the code will then
check if the selinuxfs is mounted rw, if it is, libselinux will set the
mountpoint, if it is readonly, libselinux will return no mountpoint.  If
/sys/fs/selinux does not exists, the same check will be done for
/selinux and finally for an entry in /proc/mounts.

NOTE:  We added the check for RO, to allow tools like mock to be able to
tell a chroot that SELinux is disabled while enforcing it outside the
chroot.


# getenforce
Enabled
# mount -t selinuxfs -o remount,ro selinuxfs /var/chroot/selinux
# chroot /var/chroot
# getenforce
Disabled

3. In order to make this work, I needed to stop enabled from checking if
/proc/filesystem for entries if selinux_mnt did not exist.  Now enabeled
checks if selinux_mnt has been discovered otherwise it will report
selinux disabled.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3AFkAACgkQrlYvE4MpobNHEQCgqiU1yNXW/6hTX8VnzprqY/mY
xvIAoKVSas1YPoAjVozqOiqnDjWC3Ixq
=TZcV
-----END PGP SIGNATURE-----

--------------070802060504090806040003
Content-Type: text/plain;
 name="libselinux-mountpoint.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-mountpoint.patch"

diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
index b3c8c47..018c787 100644
--- a/libselinux/src/enabled.c
+++ b/libselinux/src/enabled.c
@@ -11,10 +11,6 @@
 
 int is_selinux_enabled(void)
 {
-	char *buf=NULL;
-	FILE *fp;
-	ssize_t num;
-	size_t len;
 	int enabled = 0;
 	security_context_t con;
 
@@ -32,37 +28,8 @@ int is_selinux_enabled(void)
 				enabled = 0;
 			freecon(con);
 		}
-		return enabled;
         }
 
-	/* Drop back to detecting it the long way. */
-	fp = fopen("/proc/filesystems", "r");
-	if (!fp)
-		return -1;
-
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-	while ((num = getline(&buf, &len, fp)) != -1) {
-		if (strstr(buf, "selinuxfs")) {
-			enabled = 1;
-			break;
-		}
-	}
-
-	if (num < 0)
-		goto out;
-
-	/* Since an selinux file system is available, we consider
-	 * selinux enabled. If getcon_raw fails, selinux is still
-	 * enabled. We only consider it disabled if no policy is loaded. */
-	if (getcon_raw(&con) == 0) {
-		if (!strcmp(con, "kernel"))
-			enabled = 0;
-		freecon(con);
-	}
-
-      out:
-	free(buf);
-	fclose(fp);
 	return enabled;
 }
 
diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index a948920..c18caff 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <stdio_ext.h>
 #include <dlfcn.h>
+#include <sys/statvfs.h>
 #include <sys/vfs.h>
 #include <stdint.h>
 #include <limits.h>
@@ -20,31 +21,46 @@ char *selinux_mnt = NULL;
 int selinux_page_size = 0;
 int obj_class_compat = 1;
 
-static void init_selinuxmnt(void)
-{
-	char *buf=NULL, *p;
-	FILE *fp=NULL;
+static int check_mountpoint(char *mntpath) {
 	struct statfs sfbuf;
 	int rc;
-	size_t len;
-	ssize_t num;
-	int exists = 0;
-
-	if (selinux_mnt)
-		return;
 
 	/* We check to see if the preferred mount point for selinux file
 	 * system has a selinuxfs. */
 	do {
-		rc = statfs(SELINUXMNT, &sfbuf);
+		rc = statfs(mntpath, &sfbuf);
 	} while (rc < 0 && errno == EINTR);
 	if (rc == 0) {
 		if ((uint32_t)sfbuf.f_type == (uint32_t)SELINUX_MAGIC) {
-			selinux_mnt = strdup(SELINUXMNT);
-			return;
+			struct statvfs vfsbuf;
+			rc = statvfs(mntpath, &vfsbuf);
+			if (rc == 0) {
+				if (!(vfsbuf.f_flag & ST_RDONLY)) {
+					selinux_mnt = strdup(mntpath);
+					return 0;
+				}
+			}
 		}
 	} 
 
+	return -1;
+}
+
+static void init_selinuxmnt(void)
+{
+	char *buf=NULL, *p;
+	FILE *fp=NULL;
+	size_t len;
+	ssize_t num;
+	int exists = 0;
+
+	if (selinux_mnt)
+		return;
+
+	if (check_mountpoint(SELINUXMNT) == 0) return;
+
+	if (check_mountpoint("/selinux") == 0) return;
+
 	/* Drop back to detecting it the long way. */
 	fp = fopen("/proc/filesystems", "r");
 	if (!fp)
@@ -87,7 +103,7 @@ static void init_selinuxmnt(void)
 
 	/* If we found something, dup it */
 	if (num > 0)
-		selinux_mnt = strdup(p);
+		check_mountpoint(p);
 
       out:
 	free(buf);
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 83d2143..4078f69 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -369,7 +369,17 @@ int selinux_init_load_policy(int *enforce)
 	 * Check for the existence of SELinux via selinuxfs, and 
 	 * mount it if present for use in the calls below.  
 	 */
-	if (mount("selinuxfs", SELINUXMNT, "selinuxfs", 0, 0) < 0 && errno != EBUSY) {
+	char *mntpoint = NULL;
+	if (mount("selinuxfs", SELINUXMNT, "selinuxfs", 0, 0) == 0 || errno == EBUSY) {
+		mntpoint = SELINUXMNT;
+	} else { 
+		/* check old mountpoint */
+		if (mount("selinuxfs", "/selinux", "selinuxfs", 0, 0) == 0 || errno == EBUSY) {
+			mntpoint = "/selinux";
+		}
+	} 
+
+	if (! mntpoint ) {
 		if (errno == ENODEV) {
 			/*
 			 * SELinux was disabled in the kernel, either
@@ -384,8 +394,8 @@ int selinux_init_load_policy(int *enforce)
 		}
                 
 		goto noload;
-	}
-	set_selinuxmnt(SELINUXMNT);
+	} 
+	set_selinuxmnt(mntpoint);
 
 	/*
 	 * Note:  The following code depends on having selinuxfs 
@@ -397,7 +407,7 @@ int selinux_init_load_policy(int *enforce)
 		rc = security_disable();
 		if (rc == 0) {
 			/* Successfully disabled, so umount selinuxfs too. */
-			umount(SELINUXMNT);
+			umount(selinux_mnt);
 			fini_selinuxmnt();
 		}
 		/*
diff --git a/libselinux/src/policy.h b/libselinux/src/policy.h
index 10e8712..76f968e 100644
--- a/libselinux/src/policy.h
+++ b/libselinux/src/policy.h
@@ -13,7 +13,7 @@
 #define SELINUX_MAGIC 0xf97cff8c
 
 /* Preferred selinux mount location */
-#define SELINUXMNT "/selinux"
+#define SELINUXMNT "/sys/fs/selinux"
 
 /* selinuxfs mount point */
 extern char *selinux_mnt;

--------------070802060504090806040003
Content-Type: application/pgp-signature;
 name="libselinux-mountpoint.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-mountpoint.patch.sig"

iEYEABECAAYFAk3AFkAACgkQrlYvE4MpobOBOwCaAiPuPefYxMjeX1bONdOl62abkW0AoLXG
55oLIDkKGFg1rcD/i0mHTdz1
--------------070802060504090806040003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
