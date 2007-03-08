Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28ErZ8C005180
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:53:35 -0500
Received: from web51508.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l28ErXko006380
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:53:33 GMT
Date: Thu, 8 Mar 2007 06:53:23 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] Dropping support for disabling caching of context translations (CACHETRANS=0)
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1172667280.19041.450.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1609678577-1173365603=:17898"
Message-ID: <751432.17898.qm@web51508.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1609678577-1173365603=:17898
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

>So, is anyone using CACHETRANS=0?  Do we need to retain it going forward
>in the trunk?

Attaching a patch dropping this config option.

-Steve


 
____________________________________________________________________________________
Never miss an email again!
Yahoo! Toolbar alerts you the instant new Mail arrives.
http://tools.search.yahoo.com/toolbar/features/mail/
--0-1609678577-1173365603=:17898
Content-Type: text/x-patch; name="libselinux-2.0.4-cache.patch"
Content-Description: 3713336035-libselinux-2.0.4-cache.patch
Content-Disposition: inline; filename="libselinux-2.0.4-cache.patch"

diff -urp libselinux-2.0.4.orig/src/selinux_config.c libselinux-2.0.4/src/selinux_config.c
--- libselinux-2.0.4.orig/src/selinux_config.c	2007-03-08 09:42:08.000000000 -0500
+++ libselinux-2.0.4/src/selinux_config.c	2007-03-08 09:43:25.000000000 -0500
@@ -17,7 +17,6 @@
 #define SELINUXTAG "SELINUX="
 #define SETLOCALDEFS "SETLOCALDEFS="
 #define REQUIRESEUSERS "REQUIRESEUSERS="
-#define CACHETRANSTAG "CACHETRANS="
 
 /* Indices for file paths arrays. */
 #define BINPOLICY         0
@@ -174,10 +173,6 @@ static void init_selinux_config(void)
 					    sizeof(REQUIRESEUSERS) - 1)) {
 				value = buf_p + sizeof(REQUIRESEUSERS) - 1;
 				intptr = &require_seusers;
-			} else if (!strncmp(buf_p, CACHETRANSTAG,
-					    sizeof(CACHETRANSTAG) - 1)) {
-				value = buf_p + sizeof(CACHETRANSTAG) - 1;
-				intptr = &cache_trans;
 			} else {
 				continue;
 			}
diff -urp libselinux-2.0.4.orig/src/selinux_internal.h libselinux-2.0.4/src/selinux_internal.h
--- libselinux-2.0.4.orig/src/selinux_internal.h	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/selinux_internal.h	2007-03-08 09:46:45.000000000 -0500
@@ -80,4 +80,3 @@ hidden_proto(selinux_trans_to_raw_contex
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
-extern int cache_trans hidden;
diff -urp libselinux-2.0.4.orig/src/setrans_client.c libselinux-2.0.4/src/setrans_client.c
--- libselinux-2.0.4.orig/src/setrans_client.c	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/setrans_client.c	2007-03-08 09:46:23.000000000 -0500
@@ -24,8 +24,6 @@ static __thread security_context_t prev_
 static __thread security_context_t prev_r2t_trans = NULL;
 static __thread security_context_t prev_r2t_raw = NULL;
 
-int cache_trans hidden = 1;
-
 /*
  * setransd_open
  *
@@ -203,12 +201,10 @@ static int trans_to_raw_context(char *tr
 
 hidden void fini_context_translations(void)
 {
-	if (cache_trans) {
-		free(prev_r2t_trans);
-		free(prev_r2t_raw);
-		free(prev_t2r_trans);
-		free(prev_t2r_raw);
-	}
+	free(prev_r2t_trans);
+	free(prev_r2t_raw);
+	free(prev_t2r_trans);
+	free(prev_t2r_raw);
 }
 
 hidden int init_context_translations(void)
@@ -230,29 +226,26 @@ int selinux_trans_to_raw_context(securit
 		goto out;
 	}
 
-	if (cache_trans) {
-		if (prev_t2r_trans && strcmp(prev_t2r_trans, trans) == 0) {
-			*rawp = strdup(prev_t2r_raw);
-		} else {
-			free(prev_t2r_trans);
-			prev_t2r_trans = NULL;
-			free(prev_t2r_raw);
-			prev_t2r_raw = NULL;
-			if (trans_to_raw_context(trans, rawp))
-				*rawp = strdup(trans);
-			if (*rawp) {
-				prev_t2r_trans = strdup(trans);
-				if (!prev_t2r_trans)
-					goto out;
-				prev_t2r_raw = strdup(*rawp);
-				if (!prev_t2r_raw) {
-					free(prev_t2r_trans);
-					prev_t2r_trans = NULL;
-				}
+	if (prev_t2r_trans && strcmp(prev_t2r_trans, trans) == 0) {
+		*rawp = strdup(prev_t2r_raw);
+	} else {
+		free(prev_t2r_trans);
+		prev_t2r_trans = NULL;
+		free(prev_t2r_raw);
+		prev_t2r_raw = NULL;
+		if (trans_to_raw_context(trans, rawp))
+			*rawp = strdup(trans);
+		if (*rawp) {
+			prev_t2r_trans = strdup(trans);
+			if (!prev_t2r_trans)
+				goto out;
+			prev_t2r_raw = strdup(*rawp);
+			if (!prev_t2r_raw) {
+				free(prev_t2r_trans);
+				prev_t2r_trans = NULL;
 			}
 		}
-	} else if (trans_to_raw_context(trans, rawp))
-		*rawp = strdup(trans);
+	}
       out:
 	return *rawp ? 0 : -1;
 }
@@ -272,29 +265,26 @@ int selinux_raw_to_trans_context(securit
 		goto out;
 	}
 
-	if (cache_trans) {
-		if (prev_r2t_raw && strcmp(prev_r2t_raw, raw) == 0) {
-			*transp = strdup(prev_r2t_trans);
-		} else {
-			free(prev_r2t_raw);
-			prev_r2t_raw = NULL;
-			free(prev_r2t_trans);
-			prev_r2t_trans = NULL;
-			if (raw_to_trans_context(raw, transp))
-				*transp = strdup(raw);
-			if (*transp) {
-				prev_r2t_raw = strdup(raw);
-				if (!prev_r2t_raw)
-					goto out;
-				prev_r2t_trans = strdup(*transp);
-				if (!prev_r2t_trans) {
-					free(prev_r2t_raw);
-					prev_r2t_raw = NULL;
-				}
+	if (prev_r2t_raw && strcmp(prev_r2t_raw, raw) == 0) {
+		*transp = strdup(prev_r2t_trans);
+	} else {
+		free(prev_r2t_raw);
+		prev_r2t_raw = NULL;
+		free(prev_r2t_trans);
+		prev_r2t_trans = NULL;
+		if (raw_to_trans_context(raw, transp))
+			*transp = strdup(raw);
+		if (*transp) {
+			prev_r2t_raw = strdup(raw);
+			if (!prev_r2t_raw)
+				goto out;
+			prev_r2t_trans = strdup(*transp);
+			if (!prev_r2t_trans) {
+				free(prev_r2t_raw);
+				prev_r2t_raw = NULL;
 			}
 		}
-	} else if (raw_to_trans_context(raw, transp))
-		*transp = strdup(raw);
+	}
       out:
 	return *transp ? 0 : -1;
 }

--0-1609678577-1173365603=:17898--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
