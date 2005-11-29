Subject: Re: [ SEPOL ] Check if policy file is MLS enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1133275280.26593.92.camel@moss-spartans.epoch.ncsc.mil>
References: <438452BD.30101@cornell.edu> <43846B71.6000806@tresys.com>
	 <4384732F.90808@cornell.edu>
	 <1133206135.348.222.camel@moss-spartans.epoch.ncsc.mil>
	 <438B7549.6000600@cornell.edu>
	 <1133275280.26593.92.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 09:45:11 -0500
Message-Id: <1133275511.26593.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-29 at 09:41 -0500, Stephen Smalley wrote:
> On Mon, 2005-11-28 at 16:23 -0500, Ivan Gyurdiev wrote:
> > >>> A much better way to do this would be to extract the header reading 
> > >>> from policydb_read and make a helper function that does it. You will 
> > >>> still be able to do a partial parse of the binary but only 1 function 
> > >>> will have to be changed when a format change happens.
> > >>>       
> > >> That's true.. will fix.
> > >>     
> > >
> > > Other issue here (as noted off-list) is whether this should be acting on
> > > a module/policy file directly or on a module package file.  The latter
> > > seems more suitable for use by libsemanage, like the existing _info
> > > interface.
> > >
> > >   
> > We could put the fields that get_package_info returns into a structure, 
> > and add the mls status to those?
> 
> Actually, given that the MLS-enabled code in libsemanage already
> gracefully handles the case where the MLS range is omitted, why not just
> remove the conditional altogether and avoid the need for this interface
> in sepol?

Patch below.

Index: libsemanage/src/seusers_file.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/seusers_file.c,v
retrieving revision 1.10
diff -u -p -r1.10 seusers_file.c
--- libsemanage/src/seusers_file.c	7 Nov 2005 21:51:26 -0000	1.10
+++ libsemanage/src/seusers_file.c	29 Nov 2005 14:40:34 -0000
@@ -80,23 +80,21 @@ static int seuser_parse(
 	free(str);
 	str = NULL;
 
-	if (is_selinux_mls_enabled()) {
-		if (parse_skip_space(handle, info) < 0)
-			goto err;
-		if (parse_optional_ch(info, ':') == STATUS_NODATA)
-			goto out;
-		if (parse_skip_space(handle, info) < 0)
-			goto err;
-
-		/* NOTE: does not allow spaces/multiline */
-		if (parse_fetch_string(handle, info, &str, ' ') < 0)
-			goto err;
-
-		if (semanage_seuser_set_mlsrange(handle, seuser, str) <  0)
-			goto err;
-		free(str);
-		str = NULL;
-	}
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (parse_optional_ch(info, ':') == STATUS_NODATA)
+		goto out;
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+
+	/* NOTE: does not allow spaces/multiline */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+
+	if (semanage_seuser_set_mlsrange(handle, seuser, str) <  0)
+		goto err;
+	free(str);
+	str = NULL;
 
 	if (parse_assert_space(handle, info) < 0)
 		goto err; 
Index: libsemanage/src/users_file.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/users_file.c,v
retrieving revision 1.19
diff -u -p -r1.19 users_file.c
--- libsemanage/src/users_file.c	7 Nov 2005 21:51:26 -0000	1.19
+++ libsemanage/src/users_file.c	29 Nov 2005 14:41:12 -0000
@@ -148,41 +148,38 @@ static int user_parse(
 	} while (islist);
 
 	/* Handle mls */
-	if (is_selinux_mls_enabled()) {
+	/* Parse level header */
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (parse_optional_str(info, "level") == STATUS_NODATA)
+		goto semicolon;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	/* NOTE: does not allow spaces/multiline */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_user_set_mlslevel(handle, user, str) < 0)
+		goto err;
+	free(str);
+	str = NULL;
 
-		/* Parse level header */
-		if (parse_skip_space(handle, info) < 0)
-			goto err;
-		if (parse_optional_str(info, "level") == STATUS_NODATA)
-			goto semicolon;
-		if (parse_assert_space(handle, info) < 0)
-			goto err;
-
-		/* NOTE: does not allow spaces/multiline */
-		if (parse_fetch_string(handle, info, &str, ' ') < 0)
-			goto err;
-		if (semanage_user_set_mlslevel(handle, user, str) < 0)
-			goto err;
-		free(str);
-		str = NULL;
-
-		/* Parse range header */
-		if (parse_assert_space(handle, info) < 0)
-			goto err;
-		if (parse_assert_str(handle, info, "range") < 0)
-			goto err;
-		if (parse_assert_space(handle, info) < 0)
-			goto err;
-
-		/* NOTE: does not allow spaces/multiline */
-		if (parse_fetch_string(handle, info, &str, ';') < 0)
-			goto err;
-		if (semanage_user_set_mlsrange(handle, user, str) < 0)
-			goto err;
-
-		free(str);
-		str = NULL;
-	}
+	/* Parse range header */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_assert_str(handle, info, "range") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	/* NOTE: does not allow spaces/multiline */
+	if (parse_fetch_string(handle, info, &str, ';') < 0)
+		goto err;
+	if (semanage_user_set_mlsrange(handle, user, str) < 0)
+		goto err;
+
+	free(str);
+	str = NULL;
 
 	/* Check for semicolon */
 	semicolon:

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
