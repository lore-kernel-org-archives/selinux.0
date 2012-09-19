Message-ID: <1348083729.11612.4.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: clean up in android.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 19 Sep 2012 15:42:09 -0400
In-Reply-To: <1347975644.29192.15.camel@moss-pluto.epoch.ncsc.mil>
References: 
	<CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
	 <1347975644.29192.15.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-z8BYbnNLqtCpCGXxJRcI"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-z8BYbnNLqtCpCGXxJRcI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-09-18 at 09:40 -0400, Stephen Smalley wrote:
> I think the setcon and setfilecon2 code could be further unified so that
> the entire logic for matching an entry is encapsulated in a single
> helper function that takes a bool argument indicating whether it is
> looking for a domain or type entry.

So the attached patch does the first part above - unify the seapp
context lookup logic from setcon and setfilecon2, without making any
changes to how the username mapping is performed.

> We might also want to reconsider how we map the app usernames to a
> string for seapp_contexts.  I just remapped the new format to the app_
> prefix so that there would be no breakage going from ICS to JB, but it
> is a bit misleading.
> 
> I also think we might want to revisit how we compute the level.
> Rather than only setting a single category, we might want to compute a
> category pair based on the UID to increase the number of possible unique
> levels and avoid any risk that we will run out of unique levels for a
> large number of installed apps.  For comparison, libvirt assigns a
> randomly selected category pair for virtual machines and I heard
> recently that OpenShift is mapping UIDs to category pairs.  
> 

-- 
Stephen Smalley
National Security Agency

--=-z8BYbnNLqtCpCGXxJRcI
Content-Disposition: attachment; filename="libselinux-unifysetconsetfilecon.diff"
Content-Type: text/x-patch; name="libselinux-unifysetconsetfilecon.diff";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/src/android.c b/src/android.c
index af6c79c..3c9cb6e 100644
--- a/src/android.c
+++ b/src/android.c
@@ -272,33 +272,22 @@ static void seapp_context_init(void)
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 
-int selinux_android_setfilecon2(const char *pkgdir,
-				const char *pkgname,
+#define SEAPP_TYPE 1
+#define SEAPP_DOMAIN 2
+static int seapp_context_lookup(int kind,
+				uid_t uid,
+				int isSystemServer,
 				const char *seinfo,
-				uid_t uid)
+				const char *pkgname,
+				context_t ctx)
 {
 	const char *username;
-	char *orig_ctx_str = NULL, *ctx_str, *end = NULL;
-	context_t ctx = NULL;
+	char *end = NULL;
 	struct passwd *pw;
 	struct seapp_context *cur;
-	int i, rc;
+	int i;
 	unsigned long id = 0;
 
-	if (is_selinux_enabled() <= 0)
-		return 0;
-
-	__selinux_once(once, seapp_context_init);
-
-	rc = getfilecon(pkgdir, &ctx_str);
-	if (rc < 0)
-		goto err;
-
-	ctx = context_new(ctx_str);
-	orig_ctx_str = ctx_str;
-	if (!ctx)
-		goto oom;
-
 	pw = getpwuid(uid);
 	if (!pw)
 		goto err;
@@ -334,8 +323,7 @@ int selinux_android_setfilecon2(const char *pkgdir,
 	for (i = 0; i < nspec; i++) {
 		cur = seapp_contexts[i];
 
-		/* isSystemServer=true is only for app process labeling. */
-		if (cur->isSystemServer)
+		if (cur->isSystemServer != isSystemServer)
 			continue;
 
 		if (cur->user) {
@@ -358,7 +346,9 @@ int selinux_android_setfilecon2(const char *pkgdir,
 				continue;
 		}
 
-		if (!cur->type)
+		if (kind == SEAPP_TYPE && !cur->type)
+			continue;
+		else if (kind == SEAPP_DOMAIN && !cur->domain)
 			continue;
 
 		if (cur->sebool) {
@@ -372,8 +362,13 @@ int selinux_android_setfilecon2(const char *pkgdir,
 			}
 		}
 
-		if (context_type_set(ctx, cur->type))
-			goto oom;
+		if (kind == SEAPP_TYPE) {
+			if (context_type_set(ctx, cur->type))
+				goto oom;
+		} else if (kind == SEAPP_DOMAIN) {
+			if (context_type_set(ctx, cur->domain))
+				goto oom;
+		}
 
 		if (cur->levelFromUid) {
 			char level[255];
@@ -389,6 +384,55 @@ int selinux_android_setfilecon2(const char *pkgdir,
 		break;
 	}
 
+	if (kind == SEAPP_DOMAIN && i == nspec) {
+		/*
+		 * No match.
+		 * Fail to prevent staying in the zygote's context.
+		 */
+		selinux_log(SELINUX_ERROR,
+			    "%s:  No match for app with uid %d, seinfo %s, name %s\n",
+			    __FUNCTION__, uid, seinfo, pkgname);
+
+		if (security_getenforce() == 1)
+			goto err;
+	}
+
+	return 0;
+err:
+	return -1;
+oom:
+	return -2;
+}
+
+int selinux_android_setfilecon2(const char *pkgdir,
+				const char *pkgname,
+				const char *seinfo,
+				uid_t uid)
+{
+	char *orig_ctx_str = NULL, *ctx_str;
+	context_t ctx = NULL;
+	int rc;
+
+	if (is_selinux_enabled() <= 0)
+		return 0;
+
+	__selinux_once(once, seapp_context_init);
+
+	rc = getfilecon(pkgdir, &ctx_str);
+	if (rc < 0)
+		goto err;
+
+	ctx = context_new(ctx_str);
+	orig_ctx_str = ctx_str;
+	if (!ctx)
+		goto oom;
+
+	rc = seapp_context_lookup(SEAPP_TYPE, uid, 0, seinfo, pkgname, ctx);
+	if (rc == -1)
+		goto err;
+	else if (rc == -2)
+		goto oom;
+
 	ctx_str = context_str(ctx);
 	if (!ctx_str)
 		goto oom;
@@ -431,13 +475,9 @@ int selinux_android_setcontext(uid_t uid,
 			       const char *seinfo,
 			       const char *pkgname)
 {
-	const char *username;
-	char *orig_ctx_str = NULL, *ctx_str, *end = NULL;
+	char *orig_ctx_str = NULL, *ctx_str;
 	context_t ctx = NULL;
-	unsigned long id = 0;
-	struct passwd *pw;
-	struct seapp_context *cur;
-	int i, rc;
+	int rc;
 
 	if (is_selinux_enabled() <= 0)
 		return 0;
@@ -453,104 +493,11 @@ int selinux_android_setcontext(uid_t uid,
 	if (!ctx)
 		goto oom;
 
-	pw = getpwuid(uid);
-	if (!pw)
+	rc = seapp_context_lookup(SEAPP_DOMAIN, uid, isSystemServer, seinfo, pkgname, ctx);
+	if (rc == -1)
 		goto err;
-	username = pw->pw_name;
-
-	if (!strncmp(username, "app_", 4)) {
-		id = strtoul(username + 4, NULL, 10);
-		if (id >= MLS_CATS)
-			goto err;
-	} else if (username[0] == 'u' && isdigit(username[1])) {
-		unsigned long unused;
-		unused = strtoul(username+1, &end, 10);
-		if (end[0] != '_' || end[1] == 0)
-			goto err;
-		if (end[1] == 'a' && isdigit(end[2])) {
-			id = strtoul(end + 2, NULL, 10);
-			if (id >= MLS_CATS/2)
-				goto err;
-			/* regular app UID */
-			username = "app_";
-		} else if (end[1] == 'i' && isdigit(end[2])) {
-			id = strtoul(end + 2, NULL, 10);
-			if (id >= MLS_CATS/2)
-				goto err;
-			/* isolated service */
-			id += MLS_CATS/2;
-			username = "app_";
-		} else {
-			username = end + 1;
-		}
-	}
-
-	for (i = 0; i < nspec; i++) {
-		cur = seapp_contexts[i];
-
-		if (cur->isSystemServer != isSystemServer)
-			continue;
-		if (cur->user) {
-			if (cur->prefix) {
-				if (strncasecmp(username, cur->user, cur->len-1))
-					continue;
-			} else {
-				if (strcasecmp(username, cur->user))
-					continue;
-			}
-		}
-		if (cur->seinfo) {
-			if (!seinfo || strcasecmp(seinfo, cur->seinfo))
-				continue;
-		}
-		if (cur->name) {
-			if (!pkgname || strcasecmp(pkgname, cur->name))
-				continue;
-		}
-
-		if (!cur->domain)
-			continue;
-
-		if (cur->sebool) {
-			int value = security_get_boolean_active(cur->sebool);
-			if (value == 0)
-				continue;
-			else if (value == -1) {
-				selinux_log(SELINUX_ERROR, \
-				"Could not find boolean: %s ", cur->sebool);
-                                goto err;
-                        }
-                }
-
-		if (context_type_set(ctx, cur->domain))
-			goto oom;
-
-		if (cur->levelFromUid) {
-			char level[255];
-			snprintf(level, sizeof level, "%s:c%lu",
-				 context_range_get(ctx), id);
-			if (context_range_set(ctx, level))
-				goto oom;
-		} else if (cur->level) {
-			if (context_range_set(ctx, cur->level))
-				goto oom;
-		}
-
-		break;
-	}
-
-	if (i == nspec) {
-		/*
-		 * No match. 
-		 * Fail to prevent staying in the zygote's context.
-		 */
-		selinux_log(SELINUX_ERROR,
-			    "%s:  No match for app with uid %d, seinfo %s, name %s\n",
-			    __FUNCTION__, uid, seinfo, pkgname);
-
-		rc = (security_getenforce() == 0) ? 0 : -1;
-		goto out;
-	}
+	else if (rc == -2)
+		goto oom;
 
 	ctx_str = context_str(ctx);
 	if (!ctx_str)

--=-z8BYbnNLqtCpCGXxJRcI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
