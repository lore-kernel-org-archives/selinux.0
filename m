Message-ID: <43F8A847.8010709@cornell.edu>
Date: Sun, 19 Feb 2006 12:17:59 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Chris PeBenito <pebenito@gentoo.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net>	 <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org>	 <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org>	 <43F5E97B.8060102@cornell.edu> <43F5EB83.30402@gentoo.org>	 <43F5EE32.5080101@cornell.edu>  <43F64063.4040601@cornell.edu> <1140288277.18548.28.camel@gorn.pebenito.net> <43F77E2B.3050108@cornell.edu> <43F86035.1010401@cornell.edu> <43F8A2AC.9070601@tresys.com>
In-Reply-To: <43F8A2AC.9070601@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------080506060007060800020904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080506060007060800020904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> It's an invalid context, I don't think there is anything you *can* do 
> except fatally error. Consider what would happen if there was a proper 
> MLS context with multiple levels on an MCS policy...
Well, in that case, patch attached. Also fixes printing of mls_range in 
the error case for seuser_validate.
Applies on top of the previous one.

That leaves the semanage tool to audit and fix for non-MLS issues.



--------------080506060007060800020904
Content-Type: text/x-patch;
 name="libsemanage.sepol.mls_fix2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.sepol.mls_fix2.diff"

diff -Naurp --exclude Makefile --exclude 'fcontext*' --exclude libselinux --exclude genhomedircon.c --exclude direct_api.c --exclude-from excludes old/libsemanage/src/seusers_local.c new/libsemanage/src/seusers_local.c
--- old/libsemanage/src/seusers_local.c	2006-02-17 16:29:48.000000000 -0500
+++ new/libsemanage/src/seusers_local.c	2006-02-19 12:11:55.000000000 -0500
@@ -126,6 +126,7 @@ static int validate_handler(
 		if (sepol_mls_contains(handle->sepolh, policydb, 
 			user_mls_range, mls_range, &mls_ok) < 0)
 			goto err;
+
 		if (!mls_ok) {
 			ERR(handle, "MLS range %s for Unix user %s "
 			     "exceeds allowed range %s for SELinux user %s",
@@ -133,24 +134,29 @@ static int validate_handler(
 			goto invalid;
 		}
 
-	} else if (mls_range)
-		WARN(handle, "MLS is disabled, MLS range %s "
-			"Unix user %s ignored", mls_range, name);
+	} else if (mls_range) {
+		ERR(handle, "MLS is disabled, but MLS range %s "
+			"was found for Unix user %s", mls_range, name);
+		goto invalid;
+	}
 
 	semanage_user_key_free(key);
 	semanage_user_free(user);
 	return 0;
 
 	err:
-	ERR(handle, "could not check if the seuser mapping "
-		"%s -> (%s, %s) is valid", name, sename, mls_range);
+	ERR(handle, "could not check if seuser mapping for %s is valid", name);
 	semanage_user_key_free(key);
 	semanage_user_free(user);
 	return -1;
 
 	invalid:
-	ERR(handle, "seuser mapping %s -> (%s, %s) is invalid",
-		name, sename, mls_range);
+	if (mls_range)
+		ERR(handle, "seuser mapping [%s -> (%s, %s)] is invalid",
+			name, sename, mls_range);
+	else 
+		ERR(handle, "seuser mapping [%s -> %s] is invalid",
+			name, sename);
 	semanage_user_key_free(key);
 	semanage_user_free(user);
 	return -1;
diff -Naurp --exclude Makefile --exclude 'fcontext*' --exclude libselinux --exclude genhomedircon.c --exclude direct_api.c --exclude-from excludes old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2006-01-06 09:36:28.000000000 -0500
+++ new/libsepol/src/context.c	2006-02-19 12:06:45.000000000 -0500
@@ -194,12 +194,11 @@ int context_from_record(
 
 	/* MLS */
 	if (mls && !policydb->mls) {
-		WARN(handle, "mls context \"%s\" ignored, since "
-				"mls is disabled", mls);
-		mls = NULL;
+		ERR(handle, "MLS is disabled, but MLS context \"%s\" found", mls);
+		goto err_destroy;
 	}
 	else if (!mls && policydb->mls) {
-	 	ERR(handle, "mls is enabled, but no mls context found");
+	 	ERR(handle, "MLS is enabled, but no MLS context found");
 		goto err_destroy;
 	}
 	if (mls && (mls_from_string(handle, policydb, mls, scontext) < 0)) 
diff -Naurp --exclude Makefile --exclude 'fcontext*' --exclude libselinux --exclude genhomedircon.c --exclude direct_api.c --exclude-from excludes old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2006-02-17 16:29:48.000000000 -0500
+++ new/libsepol/src/users.c	2006-02-19 12:07:32.000000000 -0500
@@ -219,10 +219,10 @@ int sepol_user_modify(
 		}
 		context_destroy(&context);
 
-	} else {
-		if (cmls_level != NULL || cmls_range != NULL)
-			WARN(handle, "MLS is disabled, MLS level/range "
-				"ignored for user %s", cname);
+	} else if (cmls_level != NULL || cmls_range != NULL) {
+		ERR(handle, "MLS is disabled, but MLS level/range "
+			"was found for user %s", cname);
+		goto err;
 	}
 
 	/* If there are no errors, and this is a new user, add the user to policy */

--------------080506060007060800020904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
