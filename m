Subject: Re: matchpathcon_init overhead
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
   Tom London <selinux@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <438EFDB3.3040004@redhat.com>
References: <1133385496.26593.405.camel@moss-spartans.epoch.ncsc.mil>
	 <438E23C6.6040509@redhat.com>
	 <1133439793.26593.410.camel@moss-spartans.epoch.ncsc.mil>
	 <438EFDB3.3040004@redhat.com>
Content-Type: multipart/mixed; boundary="=-6xDCbv7hS/8OORjH2P5J"
Date: Thu, 01 Dec 2005 09:24:08 -0500
Message-Id: <1133447048.26593.442.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6xDCbv7hS/8OORjH2P5J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-12-01 at 08:42 -0500, Daniel J Walsh wrote:
> I was just thinking of the case of install.  If you using install for 
> installing /usr/share/mypackage/myfile,
> I guess you could submit /usr as the device, but you are still going to 
> get a hell of a lot of matches.

I expected install to pass the full destination path as the "prefix",
i.e. /usr/share/mypackage/myfile or at least /usr/share/mypackage.  The
prefix can be any path, even a complete one.

>   Then
> there is the case of you installing into /mydir/mypackage, and /mydir 
> would be submitted and probably match nothing, so
> what happens then.  May be we want both options.  One for udev and one 
> for apps apps that use matchpathcon like install.

Ok.  Attached is a patch relative to the prior one for libselinux that
also makes the context validation/canonicalization optional at
matchpathcon_init time, deferring it to a successful matchpathcon by
default unless a new flag is set via set_matchpathcon_flags.  This
avoids any need to change the majority of users (rpm, udev,
install, ...) to pick up the new behavior.  Also attached is a patch for
setfiles that sets the flag so that it retains the original behavior of
validating/canonicalizing during init.  Seems like restorecon should
have the same behavior as install, since it is often used selectively on
a few files, so I didn't patch it.  Seem sane?

-- 
Stephen Smalley
National Security Agency

--=-6xDCbv7hS/8OORjH2P5J
Content-Disposition: attachment; filename=matchpathcon.diff2
Content-Type: text/x-patch; name=matchpathcon.diff2; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.52
diff -u -p -r1.52 selinux.h
--- libselinux/include/selinux/selinux.h	1 Dec 2005 13:29:04 -0000	1.52
+++ libselinux/include/selinux/selinux.h	1 Dec 2005 13:33:44 -0000
@@ -293,6 +293,7 @@ extern void set_matchpathcon_canoncon(in
 /* Set flags controlling operation of matchpathcon_init or matchpathcon. */
 #define MATCHPATHCON_BASEONLY 1 /* Only process the base file_contexts file. */
 #define MATCHPATHCON_NOTRANS  2 /* Do not perform any context translation. */
+#define MATCHPATHCON_VALIDATE 4 /* Validate/canonicalize contexts at init time. */
 extern void set_matchpathcon_flags(unsigned int flags);
 
 /* Load the file contexts configuration specified by 'path'
Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.35
diff -u -p -r1.35 matchpathcon.c
--- libselinux/src/matchpathcon.c	1 Dec 2005 13:29:04 -0000	1.35
+++ libselinux/src/matchpathcon.c	1 Dec 2005 14:01:36 -0000
@@ -84,7 +84,10 @@ static int default_canoncon(const char *
 	if (security_canonicalize_context(*context, &tmpcon) < 0) {
 		if (errno == ENOENT)
 			return 0;
-		myprintf("%s:  line %u has invalid context %s\n", path, lineno, *context);
+		if (lineno)
+			myprintf("%s:  line %u has invalid context %s\n", path, lineno, *context);
+		else
+			myprintf("%s:  invalid context %s\n", path, *context);
 		return 1;
 	}
 	free(*context);
@@ -116,6 +119,7 @@ typedef struct spec {
 	char *regex_str;	/* regular expession string for diagnostic messages */
 	char *type_str;		/* type string for diagnostic messages */
 	char *context;		/* context string */
+	int context_valid;      /* context string has been validated/canonicalized */
 	regex_t regex;		/* compiled regular expression */
 	mode_t mode;		/* mode format value */
 	int matches;		/* number of matching pathnames */
@@ -599,14 +603,17 @@ static int process_line( const char *pat
 			}
 
 skip_trans:
-			if (myinvalidcon) {
-				/* Old-style validation of context. */
-				if (myinvalidcon(path, lineno, context)) 
-					return 0;
-			} else {
-				/* New canonicalization of context. */
-				if (mycanoncon(path, lineno, &context))
-					return 0;
+			if (myflags & MATCHPATHCON_VALIDATE) {
+				if (myinvalidcon) {
+					/* Old-style validation of context. */
+					if (myinvalidcon(path, lineno, context)) 
+						return 0;
+				} else {
+					/* New canonicalization of context. */
+					if (mycanoncon(path, lineno, &context))
+						return 0;
+				}
+				spec_arr[nspec].context_valid = 1;
 			}
 		}
 
@@ -813,11 +820,28 @@ int matchpathcon(const char *name, 
 		return -1;
 	}
 
+	if (!spec_arr[i].context_valid) {
+		if (myinvalidcon) {
+			/* Old-style validation of context. */
+			if (myinvalidcon("file_contexts", 0, spec_arr[i].context))
+				goto bad;
+		} else {
+			/* New canonicalization of context. */
+			if (mycanoncon("file_contexts", 0, &spec_arr[i].context))
+				goto bad;
+		}
+		spec_arr[i].context_valid = 1;
+	}
+
 	*con = strdup(spec_arr[i].context);
 	if (!(*con))
 		return -1;
 
 	return 0;
+
+bad:
+	errno = EINVAL;
+	return -1;
 }
 
 int matchpathcon_index(const char *name, 

--=-6xDCbv7hS/8OORjH2P5J
Content-Disposition: attachment; filename=setfiles.diff
Content-Type: text/x-patch; name=setfiles.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/setfiles/setfiles.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setfiles/setfiles.c,v
retrieving revision 1.39
diff -u -p -r1.39 setfiles.c
--- policycoreutils/setfiles/setfiles.c	8 Nov 2005 19:31:26 -0000	1.39
+++ policycoreutils/setfiles/setfiles.c	1 Dec 2005 13:45:24 -0000
@@ -417,6 +417,9 @@ int main(int argc, char **argv)
 
 	memset(excludeArray,0, sizeof(excludeArray));
 
+	/* Validate all file contexts during matchpathcon_init. */
+	set_matchpathcon_flags(MATCHPATHCON_VALIDATE);
+
 	/* Process any options. */
 	while ((opt = getopt(argc, argv, "Fc:dlnqrsvWe:o:")) > 0) {
 		switch (opt) {
@@ -443,7 +446,7 @@ int main(int argc, char **argv)
 			/* Only process the specified file_contexts file, not
 			   any .homedirs or .local files, and do not perform
 			   context translations. */
-			set_matchpathcon_flags(MATCHPATHCON_BASEONLY|MATCHPATHCON_NOTRANS);
+			set_matchpathcon_flags(MATCHPATHCON_BASEONLY|MATCHPATHCON_NOTRANS|MATCHPATHCON_VALIDATE);
 			
 			break;
 		}

--=-6xDCbv7hS/8OORjH2P5J--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
