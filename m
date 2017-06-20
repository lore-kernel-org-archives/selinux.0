Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KE7Vh9007848
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 10:07:33 -0400
From: Patrick Steinhardt <ps@pks.im>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] genhomedircon: avoid use of non-standard `getpwent_r`
Date: Tue, 20 Jun 2017 16:07:03 +0200
Message-Id: <e9a72b068ca86d433ee52a877dad98bc410c39a0.1497967444.git.ps@pks.im>
In-Reply-To: <cover.1497967444.git.ps@pks.im>
References: <cover.1497967444.git.ps@pks.im>
In-Reply-To: <cover.1497967444.git.ps@pks.im>
References: <cover.1497967444.git.ps@pks.im>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The `getpwent_r` function is a non-standard but re-entrant version of
the sdardardized `getpwent` function. Next to the benefit of being
re-entrant, though, it avoids compilation with libc implementations that
do not provide this glibc-specific extension, for example musl libc.

As the code is usually not run in a threaded environment, it is save to
use the non-reentrant version, though. As such, convert code to use
`getpwent` instead to fix building with other libc implementations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 libsemanage/src/genhomedircon.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index e8c95ee4..f58c17ce 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -295,9 +295,8 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	long rbuflen;
 	uid_t temp, minuid = 500, maxuid = 60000;
 	int minuid_set = 0;
-	struct passwd pwstorage, *pwbuf;
+	struct passwd *pwbuf;
 	struct stat buf;
-	int retval;
 
 	path = semanage_findval(PATH_ETC_USERADD, "HOME", "=");
 	if (path && *path) {
@@ -369,7 +368,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	if (rbuf == NULL)
 		goto fail;
 	setpwent();
-	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) {
+	while ((pwbuf = getpwent()) != NULL) {
 		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
@@ -413,7 +412,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		path = NULL;
 	}
 
-	if (retval && retval != ENOENT) {
+	if (errno && errno != ENOENT) {
 		WARN(s->h_semanage, "Error while fetching users.  "
 		     "Returning list so far.");
 	}
@@ -1064,10 +1063,7 @@ static int get_group_users(genhomedircon_settings_t * s,
 	long grbuflen;
 	char *grbuf = NULL;
 	struct group grstorage, *group = NULL;
-
-	long prbuflen;
-	char *pwbuf = NULL;
-	struct passwd pwstorage, *pw = NULL;
+	struct passwd *pw = NULL;
 
 	grbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
 	if (grbuflen <= 0)
@@ -1104,15 +1100,8 @@ static int get_group_users(genhomedircon_settings_t * s,
 		}
 	}
 
-	prbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
-	if (prbuflen <= 0)
-		goto cleanup;
-	pwbuf = malloc(prbuflen);
-	if (pwbuf == NULL)
-		goto cleanup;
-
 	setpwent();
-	while ((retval = getpwent_r(&pwstorage, pwbuf, prbuflen, &pw)) == 0) {
+	while ((pw = getpwent()) != NULL) {
 		// skip users who also have this group as their
 		// primary group
 		if (lfind(pw->pw_name, group->gr_mem, &nmembers,
@@ -1131,7 +1120,6 @@ static int get_group_users(genhomedircon_settings_t * s,
 	retval = STATUS_SUCCESS;
 cleanup:
 	endpwent();
-	free(pwbuf);
 	free(grbuf);
 
 	return retval;
-- 
2.13.1
