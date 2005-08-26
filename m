Message-ID: <430F5C8B.3060102@redhat.com>
Date: Fri, 26 Aug 2005 14:16:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Problems with MCS/Targeted policy update.
References: <430C776B.4060309@redhat.com>
In-Reply-To: <430C776B.4060309@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080107010809070609050205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080107010809070609050205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Basically this patch checks to see if
mls and translation is enabled and the *getfilecon_raw returns a context 
without a level, it calls the untranslate function to try to get a 
level, with MCS this will get you a s0.  So we could put back the raw 
calls in rpm_execcon.

So we could have most contexts on disk without the s0 and the getfilecon 
raw call will return it.

Dan

-- 



--------------080107010809070609050205
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/context.c libselinux-1.25.4/src/context.c
--- nsalibselinux/src/context.c	2005-08-25 16:18:01.000000000 -0400
+++ libselinux-1.25.4/src/context.c	2005-08-26 12:02:38.000000000 -0400
@@ -181,16 +181,8 @@
 def_set(type,COMP_TYPE)
 def_set(role,COMP_ROLE)
 def_set(user,COMP_USER)
+def_set(range,COMP_RANGE)
 
-int context_range_set(context_t context,const char* str)
-{
-        context_private_t *n = context->ptr;
-        if ( ! n->component[COMP_RANGE] ) {
-                return 0;
-        } else {
-                return set_comp(n,COMP_RANGE,str);
-        }
-}
 hidden_def(context_range_set)
 
 #ifdef L1TEST
--- nsalibselinux/src/fgetfilecon.c	2005-08-25 16:18:01.000000000 -0400
+++ libselinux-1.25.4/src/fgetfilecon.c	2005-08-26 12:38:16.000000000 -0400
@@ -39,8 +39,21 @@
 out:			
 	if (ret < 0)
 		free(buf);
-	else
-		*context = buf;
+	else {
+ 		*context = buf;
+		/* The following code is to check if the 4th parameter on disk 
+		   has been set, if not attempt to untranslate it to get the 
+		   fourth parameter.  MCS Defaults 4th parameter to s0: */
+		if (mls_enabled && context_translations) {
+			int ctr=0, i=0;
+			for (i=0; i<size;i++) 
+				if (buf[i] && buf[i]==':') ctr++;
+			if (ctr<3) {
+				trans_to_raw_context(buf,context);
+				free(buf);
+			}
+		}
+	}
 	return ret;
 }
 hidden_def(fgetfilecon_raw)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c libselinux-1.25.4/src/getfilecon.c
--- nsalibselinux/src/getfilecon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.4/src/getfilecon.c	2005-08-26 12:28:58.000000000 -0400
@@ -39,8 +39,21 @@
 out:			
 	if (ret < 0)
 		free(buf);
-	else
-		*context = buf;
+	else {
+ 		*context = buf;
+		/* The following code is to check if the 4th parameter on disk 
+		   has been set, if not attempt to untranslate it to get the 
+		   fourth parameter.  MCS Defaults 4th parameter to s0: */
+		if (mls_enabled && context_translations) {
+			int ctr=0, i=0;
+			for (i=0; i<size;i++) 
+				if (buf[i] && buf[i]==':') ctr++;
+			if (ctr<3) {
+				trans_to_raw_context(buf,context);
+				free(buf);
+			}
+		}
+	}
 	return ret;
 }
 hidden_def(getfilecon_raw)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/init.c libselinux-1.25.4/src/init.c
--- nsalibselinux/src/init.c	2005-08-25 16:18:01.000000000 -0400
+++ libselinux-1.25.4/src/init.c	2005-08-26 12:06:08.000000000 -0400
@@ -119,11 +119,13 @@
 	}
 }
 
+int mls_enabled hidden;
 static void init_lib(void) __attribute__ ((constructor));
 static void init_lib(void)
 {
 	init_selinuxmnt();
 	init_translations();
+	mls_enabled=is_selinux_mls_enabled();
 }
 
 static void fini_lib(void) __attribute__ ((destructor));
--- nsalibselinux/src/lgetfilecon.c	2005-08-25 16:18:01.000000000 -0400
+++ libselinux-1.25.4/src/lgetfilecon.c	2005-08-26 12:38:12.000000000 -0400
@@ -39,8 +39,21 @@
 out:			
 	if (ret < 0)
 		free(buf);
-	else
-		*context = buf;
+	else {
+ 		*context = buf;
+		/* The following code is to check if the 4th parameter on disk 
+		   has been set, if not attempt to untranslate it to get the 
+		   fourth parameter.  MCS Defaults 4th parameter to s0: */
+		if (mls_enabled && context_translations) {
+			int ctr=0, i=0;
+			for (i=0; i<size;i++) 
+				if (buf[i] && buf[i]==':') ctr++;
+			if (ctr<3) {
+				trans_to_raw_context(buf,context);
+				free(buf);
+			}
+		}
+	}
 	return ret;
 }
 hidden_def(lgetfilecon_raw)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/query_user_context.c libselinux-1.25.4/src/query_user_context.c
--- nsalibselinux/src/query_user_context.c	2005-02-22 16:34:17.000000000 -0500
+++ libselinux-1.25.4/src/query_user_context.c	2005-08-26 12:06:47.000000000 -0400
@@ -122,7 +122,6 @@
     int  typelen = 100;
     char level[100];       /* The level requested by the user         */
     int  levellen = 100;
-    int mls_enabled = is_selinux_mls_enabled();
 
     context_t new_context;     /* The new context chosen by the user     */
     char *user_context = NULL; /* String value of the user's context     */
--- nsalibselinux/src/selinux_internal.h	2005-08-25 16:18:01.000000000 -0400
+++ libselinux-1.25.4/src/selinux_internal.h	2005-08-26 12:24:26.000000000 -0400
@@ -51,5 +51,10 @@
 hidden_proto(selinux_users_path)
 
 extern int context_translations hidden;
+extern int mls_enabled hidden;
 extern int hidden trans_to_raw_context(char *trans, char **rawp);
 extern int hidden raw_to_trans_context(char *raw, char **transp);
+extern int hidden internal_getfilecon_raw(
+	ssize_t (*func)(const char *, const char*, void *, size_t), 
+	const char *path, 
+	security_context_t *context);

--------------080107010809070609050205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
