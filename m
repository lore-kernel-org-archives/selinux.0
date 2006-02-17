Message-ID: <43F64063.4040601@cornell.edu>
Date: Fri, 17 Feb 2006 16:30:11 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>, Chris PeBenito <pebenito@gentoo.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net> <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org> <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org> <43F5E97B.8060102@cornell.edu> <43F5EB83.30402@gentoo.org> <43F5EE32.5080101@cornell.edu>
In-Reply-To: <43F5EE32.5080101@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------090509090209010000050204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090509090209010000050204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>
> ======================
> So, your seuser has an mls range, which causes a crash, because 
> libsemanage doesn't handle that case very well.
> I will patch the library to prevent that crash, but for the moment I 
> suggest you get rid of the end colon.
>
Let me know if this patch works out for you...



--------------090509090209010000050204
Content-Type: text/x-patch;
 name="libsemanage.sepol.more_mls_checks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.sepol.more_mls_checks.diff"

diff -Naurp --exclude libselinux --exclude genhomedircon.c --exclude direct_api.c --exclude-from excludes old/libsemanage/src/seusers_local.c new/libsemanage/src/seusers_local.c
--- old/libsemanage/src/seusers_local.c	2006-01-27 15:44:09.000000000 -0500
+++ new/libsemanage/src/seusers_local.c	2006-02-17 16:19:06.000000000 -0500
@@ -114,8 +114,8 @@ static int validate_handler(
 	}
 
 	/* Verify that the mls range is valid, and that it's contained
-	 * within the (SELinux) user mls range */
-	if (mls_range) {
+	 * within the (SELinux) user mls range. This range is optional */
+	if (mls_range && sepol_policydb_mls_enabled(policydb)) {		
 
 		if (semanage_user_query(handle, key, &user) < 0)
 			goto err;
@@ -127,12 +127,15 @@ static int validate_handler(
 			user_mls_range, mls_range, &mls_ok) < 0)
 			goto err;
 		if (!mls_ok) {
-			ERR(handle, "mls range %s for Unix user %s "
-				"exceeds allowed range %s for SELinux user %s",
-				mls_range, name, user_mls_range, sename);
+			ERR(handle, "MLS range %s for Unix user %s "
+			     "exceeds allowed range %s for SELinux user %s",
+			      mls_range, name, user_mls_range, sename);
 			goto invalid;
 		}
-	}
+
+	} else if (mls_range)
+		WARN(handle, "MLS is disabled, MLS range %s "
+			"Unix user %s ignored", mls_range, name);
 
 	semanage_user_key_free(key);
 	semanage_user_free(user);
@@ -153,6 +156,10 @@ static int validate_handler(
 	return -1;
 }
 
+/* This function may not be called outside a transaction, or 
+ * it will (1) deadlock, because iterate is not reentrant outside
+ * a transaction, and (2) be racy, because it makes multiple dbase calls */
+
 int hidden semanage_seuser_validate_local(
 	semanage_handle_t* handle,	
 	const sepol_policydb_t* policydb) {
diff -Naurp --exclude libselinux --exclude genhomedircon.c --exclude direct_api.c --exclude-from excludes old/libsepol/include/sepol/policydb.h new/libsepol/include/sepol/policydb.h
--- old/libsepol/include/sepol/policydb.h	2005-10-18 10:08:39.000000000 -0400
+++ new/libsepol/include/sepol/policydb.h	2006-02-17 16:21:01.000000000 -0500
@@ -124,6 +124,7 @@ extern int sepol_policydb_to_image(sepol
 				   void **newdata, 
 				   size_t *newlen);
 
-#endif
-
+extern int sepol_policydb_mls_enabled(
+	const sepol_policydb_t* p);
 
+#endif
diff -Naurp --exclude libselinux --exclude genhomedircon.c --exclude direct_api.c --exclude-from excludes old/libsepol/src/policydb_public.c new/libsepol/src/policydb_public.c
--- old/libsepol/src/policydb_public.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/policydb_public.c	2006-02-17 16:21:09.000000000 -0500
@@ -159,3 +159,8 @@ int sepol_policydb_to_image(sepol_handle
 	return policydb_to_image(handle, &p->p, newdata, newlen);
 }
 
+int sepol_policydb_mls_enabled(
+	const sepol_policydb_t* p)  {
+
+	return p->p.mls;
+}
diff -Naurp --exclude libselinux --exclude genhomedircon.c --exclude direct_api.c --exclude-from excludes old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2006-01-13 08:35:51.000000000 -0500
+++ new/libsepol/src/users.c	2006-02-17 16:12:48.000000000 -0500
@@ -218,6 +218,11 @@ int sepol_user_modify(
 			goto err;
 		}
 		context_destroy(&context);
+
+	} else {
+		if (cmls_level != NULL || cmls_range != NULL)
+			WARN(handle, "MLS is disabled, MLS level/range "
+				"ignored for user %s", cname);
 	}
 
 	/* If there are no errors, and this is a new user, add the user to policy */

--------------090509090209010000050204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
