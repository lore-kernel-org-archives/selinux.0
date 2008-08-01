Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m71B3CL0005521
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 07:03:12 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m71B3BuZ026768
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 11:03:12 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m71B3BM1026150
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 07:03:11 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m71B3BN3002737
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 07:03:11 -0400
Received: from localhost.localdomain (vpn-12-105.rdu.redhat.com [10.11.12.105])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m71B3AJJ003297
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 07:03:10 -0400
Message-ID: <4892ED4B.8000104@redhat.com>
Date: Fri, 01 Aug 2008 07:02:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I have added group support to libselinux
Content-Type: multipart/mixed;
 boundary="------------000304020001000102020009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000304020001000102020009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

If you create an seusers file using the sudo syntax %groupname,
getseuserbyname will check the user's groups for a match.

Match sequence will be:

username exists
FIRST group match
default

I will be sending a separate patch to allow semanage to add %groupname
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiS7UsACgkQrlYvE4MpobPa7ACgwAZvdg8hD+KRT2hBY0dhna8o
tQ8AmwRgEatZmS8hUuw3Bx/uwdnyG4OG
=IRCg
-----END PGP SIGNATURE-----

--------------000304020001000102020009
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/seusers.c libselinux-2.0.70/src/seusers.c
--- nsalibselinux/src/seusers.c	2008-06-12 23:25:14.000000000 -0400
+++ libselinux-2.0.70/src/seusers.c	2008-08-01 06:53:03.000000000 -0400
@@ -89,6 +89,62 @@
 
 int require_seusers hidden = 0;
 
+#include <pwd.h>
+#include <grp.h>
+
+static gid_t get_default_gid(const char *name) {
+	struct passwd pwstorage, *pwent = NULL;
+	gid_t gid = -1;
+	/* Allocate space for the getpwnam_r buffer */
+	long rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (rbuflen <= 0) return -1;
+	char *rbuf = malloc(rbuflen);
+	if (rbuf == NULL) return -1;
+
+	int retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
+	if (retval == 0 || pwent != NULL) {
+		gid = pwent->pw_gid;
+	}
+	free(rbuf);
+	return gid;
+}
+
+static int check_group(const char *group, const char *name, const gid_t gid) {
+	int match = 0;
+	int i, ng = 0;
+	gid_t *groups = NULL;
+	struct group gbuf, *grent = NULL;
+
+	long rbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	if (rbuflen <= 0)
+		return 0;
+	char *rbuf = malloc(rbuflen);
+	if (rbuf == NULL)
+		return 0;
+
+	if (getgrnam_r(group, &gbuf, rbuf, rbuflen, 
+		       &grent) != 0)
+		goto done;
+
+	if (getgrouplist(name, gid, NULL, &ng) < 0) {
+		groups = (gid_t *) malloc(sizeof (gid_t) * ng);
+		if (!groups) goto done;
+		if (getgrouplist(name, gid, groups, &ng) < 0) goto done;
+	}
+
+	for (i = 0; i < ng; i++) {
+		if (grent->gr_gid == groups[i]) {
+			match = 1;
+			goto done;
+		}
+	}
+
+ done:
+	free(groups);
+	free(rbuf);
+	return match;
+}
+
 int getseuserbyname(const char *name, char **r_seuser, char **r_level)
 {
 	FILE *cfg = NULL;
@@ -101,9 +157,14 @@
 	char *username = NULL;
 	char *seuser = NULL;
 	char *level = NULL;
+	char *groupseuser = NULL;
+	char *grouplevel = NULL;
 	char *defaultseuser = NULL;
 	char *defaultlevel = NULL;
 
+	gid_t gid = get_default_gid(name);
+	if ( gid == (gid_t) -1 ) goto nomatch;
+
 	cfg = fopen(selinux_usersconf_path(), "r");
 	if (!cfg)
 		goto nomatch;
@@ -124,31 +185,48 @@
 		if (!strcmp(username, name))
 			break;
 
-		if (!defaultseuser && !strcmp(username, "__default__")) {
-			free(username);
-			defaultseuser = seuser;
-			defaultlevel = level;
+		if (username[0] == '%' && 
+		    !groupseuser && 
+		    check_group(&username[1], name, gid)) {
+				groupseuser = seuser;
+				grouplevel = level;
 		} else {
-			free(username);
-			free(seuser);
-			free(level);
+			if (!defaultseuser && 
+			    !strcmp(username, "__default__")) {
+				defaultseuser = seuser;
+				defaultlevel = level;
+			} else {
+				free(seuser);
+				free(level);
+			}
 		}
+		free(username);
+		username = NULL;
 		seuser = NULL;
 	}
 
-	if (buffer)
-		free(buffer);
+	free(buffer);
 	fclose(cfg);
 
 	if (seuser) {
 		free(username);
 		free(defaultseuser);
 		free(defaultlevel);
+		free(groupseuser);
+		free(grouplevel);
 		*r_seuser = seuser;
 		*r_level = level;
 		return 0;
 	}
 
+	if (groupseuser) {
+		free(defaultseuser);
+		free(defaultlevel);
+		*r_seuser = groupseuser;
+		*r_level = grouplevel;
+		return 0;
+	}
+
 	if (defaultseuser) {
 		*r_seuser = defaultseuser;
 		*r_level = defaultlevel;

--------------000304020001000102020009
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkiS7UsACgkQrlYvE4MpobPzrQCghBHPgID81uQTBg1NKXnFZWud+Y4AnR/+
WvfCzhQcGGi1f0Ybq5/jbhLM
--------------000304020001000102020009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
