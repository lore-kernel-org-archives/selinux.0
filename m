Subject: Re: New patch for fixfiles sed script
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107368924.890.298.camel@moss-spartans.epoch.ncsc.mil>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200DC75.1070009@redhat.com>
	 <1107360761.890.234.camel@moss-spartans.epoch.ncsc.mil>
	 <4201012F.6040604@redhat.com>  <42011203.3010005@redhat.com>
	 <1107368924.890.298.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1107369819.890.314.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 13:43:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-02 at 13:28, Stephen Smalley wrote:
> On Wed, 2005-02-02 at 12:46, Daniel J Walsh wrote:
> > Ok how about this patch.
> > 
> > Added -e flag for restorecon
> 
> Merged along with the attached patch as of policycoreutils 1.21.11.

Naturally, I noticed two other issues after committing:
1) restorecon/setfiles should just warn about non-existing directories
for -e, not bail out, as their absence just guarantees the exclusion and
use by scripts like fixfiles -C could very easily occur on a system that
was missing one of the typical directories.
2) restorecon was calling exclude() on the filename before realpath()
was applied, and was also incrementing the error count upon an exclude.

Patch below should fix.

Index: policycoreutils/restorecon/restorecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/restorecon/restorecon.c,v
retrieving revision 1.26
diff -u -r1.26 restorecon.c
--- policycoreutils/restorecon/restorecon.c	2 Feb 2005 18:26:21 -0000	1.26
+++ policycoreutils/restorecon/restorecon.c	2 Feb 2005 18:37:04 -0000
@@ -61,12 +61,12 @@
     return 1;
   }
   if(lstat(directory, &sb)) {
-    fprintf(stderr, "Directory \"%s\" not found.\n", directory);
-    return 1;
+    fprintf(stderr, "Directory \"%s\" not found, ignoring.\n", directory);
+    return 0;
   }
   if ((sb.st_mode & S_IFDIR) == 0 ) {
-    fprintf(stderr, "\"%s\" is not a Directory: mode %o\n", directory,sb.st_mode);
-    return 1;
+    fprintf(stderr, "\"%s\" is not a Directory: mode %o, ignoring\n", directory,sb.st_mode);
+    return 0;
   }
 
   if (excludeCtr == MAX_EXCLUDES) {
@@ -130,9 +130,6 @@
   if (len > 0 && filename[len-1]=='/' && (strcmp(filename,"/") != 0)) {
     filename[len-1]=0;
   }
-  if (excludeCtr > 0 && exclude(filename)) {
-      return 1;
-  }
   if (lstat(filename, &st)!=0) {
     fprintf(stderr,"lstat(%s) failed: %s\n", filename,strerror(errno));
     return 1;
@@ -170,6 +167,9 @@
     }
     filename = p;
   }
+  if (excludeCtr > 0 && exclude(filename)) {
+      return 0;
+  }
   retval = matchpathcon(filename, st.st_mode, &scontext);
   if (retval < 0) {
     if (errno == ENOENT)
Index: policycoreutils/setfiles/setfiles.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setfiles/setfiles.c,v
retrieving revision 1.31
diff -u -r1.31 setfiles.c
--- policycoreutils/setfiles/setfiles.c	2 Feb 2005 18:26:24 -0000	1.31
+++ policycoreutils/setfiles/setfiles.c	2 Feb 2005 18:37:48 -0000
@@ -124,12 +124,12 @@
 		return 1;
 	}
 	if(lstat(directory, &sb)) {
-	        fprintf(stderr, "Directory \"%s\" not found.\n", directory);
-	        return 1;
+	        fprintf(stderr, "Directory \"%s\" not found, ignoring.\n", directory);
+	        return 0;
 	}
 	if ((sb.st_mode & S_IFDIR) == 0 ) {
-	        fprintf(stderr, "\"%s\" is not a Directory: mode %o\n", directory,sb.st_mode);
-	        return 1;
+	        fprintf(stderr, "\"%s\" is not a Directory: mode %o, ignoring\n", directory,sb.st_mode);
+	        return 0;
 	}
 
 	if (excludeCtr == MAX_EXCLUDES) {


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
