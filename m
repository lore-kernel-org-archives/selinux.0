Message-ID: <1348085999.12435.1.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: clean up in android.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 19 Sep 2012 16:19:59 -0400
In-Reply-To: <1348083729.11612.4.camel@moss-pluto.epoch.ncsc.mil>
References: 
	<CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
	 <1347975644.29192.15.camel@moss-pluto.epoch.ncsc.mil>
	 <1348083729.11612.4.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-XjAwTkjMEfsTmR7xKmax"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XjAwTkjMEfsTmR7xKmax
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-19 at 15:42 -0400, Stephen Smalley wrote:
> On Tue, 2012-09-18 at 09:40 -0400, Stephen Smalley wrote:
> > I think the setcon and setfilecon2 code could be further unified so that
> > the entire logic for matching an entry is encapsulated in a single
> > helper function that takes a bool argument indicating whether it is
> > looking for a domain or type entry.
> 
> So the attached patch does the first part above - unify the seapp
> context lookup logic from setcon and setfilecon2, without making any
> changes to how the username mapping is performed.
> 
> > We might also want to reconsider how we map the app usernames to a
> > string for seapp_contexts.  I just remapped the new format to the app_
> > prefix so that there would be no breakage going from ICS to JB, but it
> > is a bit misleading.

And attached is a second patch on top of the first that reworks the
mapping of UIDs to avoid the use of getpwuid() and name parsing
altogether.

> > 
> > I also think we might want to revisit how we compute the level.
> > Rather than only setting a single category, we might want to compute a
> > category pair based on the UID to increase the number of possible unique
> > levels and avoid any risk that we will run out of unique levels for a
> > large number of installed apps.  For comparison, libvirt assigns a
> > randomly selected category pair for virtual machines and I heard
> > recently that OpenShift is mapping UIDs to category pairs.  
> > 
> 

-- 
Stephen Smalley
National Security Agency

--=-XjAwTkjMEfsTmR7xKmax
Content-Disposition: attachment; filename="libselinux-uidmapping.diff"
Content-Type: text/x-patch; name="libselinux-uidmapping.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/src/android.c b/src/android.c
index 3c9cb6e..1ed6184 100644
--- a/src/android.c
+++ b/src/android.c
@@ -17,6 +17,7 @@
 #include <selinux/android.h>
 #include <selinux/label.h>
 #include <selinux/avc.h>
+#include <private/android_filesystem_config.h>
 #include "callbacks.h"
 #include "selinux_internal.h"
 
@@ -281,45 +282,35 @@ static int seapp_context_lookup(int kind,
 				const char *pkgname,
 				context_t ctx)
 {
-	const char *username;
+	const char *username = NULL;
 	char *end = NULL;
 	struct passwd *pw;
 	struct seapp_context *cur;
 	int i;
-	unsigned long id = 0;
-
-	pw = getpwuid(uid);
-	if (!pw)
-		goto err;
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
+	size_t n;
+	uid_t appid = 0;
+
+	appid = uid % AID_USER;
+	if (appid < AID_APP) {
+		for (n = 0; n < android_id_count; n++) {
+			if (android_ids[n].aid == appid) {
+				username = android_ids[n].name;
+				break;
+			}
 		}
+		if (!username)
+			goto err;
+	} else if (appid < AID_ISOLATED_START) {
+		username = "app_";
+		appid -= AID_APP;
+	} else {
+		username = "isolated";
+		appid -= AID_ISOLATED_START;
 	}
 
+	if (appid >= MLS_CATS)
+		goto err;
+
 	for (i = 0; i < nspec; i++) {
 		cur = seapp_contexts[i];
 
@@ -373,7 +364,7 @@ static int seapp_context_lookup(int kind,
 		if (cur->levelFromUid) {
 			char level[255];
 			snprintf(level, sizeof level, "%s:c%lu",
-				 context_range_get(ctx), id);
+				 context_range_get(ctx), appid);
 			if (context_range_set(ctx, level))
 				goto oom;
 		} else if (cur->level) {

--=-XjAwTkjMEfsTmR7xKmax--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
