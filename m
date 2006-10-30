Subject: [PATCH] libsepol users in non-mls policy bugfix
From: Joshua Brindle <jbrindle@tresys.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 08:59:22 -0500
Message-Id: <1162216762.3236.3.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug where adding a user in a non-mls module would
cause a segfault at link time.


diff -pruN trunk/libsepol/src/link.c user_mls_fix/libsepol/src/link.c
--- trunk/libsepol/src/link.c	2006-10-28 15:35:26.000000000 -0400
+++ user_mls_fix/libsepol/src/link.c	2006-10-28 15:26:44.000000000 -0400
@@ -994,11 +994,15 @@ static int user_fix_callback(hashtab_key
 		goto cleanup;
 	}
 
-	if (mls_range_convert(&user->range, &new_user->range, mod))
-		goto cleanup;
+	if (mod->policy->mls) {
 
-	if (mls_level_convert(&user->dfltlevel, &new_user->dfltlevel, mod))
-		goto cleanup;
+		if (mls_range_convert(&user->range, &new_user->range, mod))
+			goto cleanup;
+
+		if (mls_level_convert(&user->dfltlevel, &new_user->dfltlevel, mod))
+			goto cleanup;
+
+	}
 
 	return 0;
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
