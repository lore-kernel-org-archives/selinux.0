Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12IZF53024816
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 13:35:16 -0500 (EST)
Subject: Re: New patch for fixfiles sed script
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <42011203.3010005@redhat.com>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200DC75.1070009@redhat.com>
	 <1107360761.890.234.camel@moss-spartans.epoch.ncsc.mil>
	 <4201012F.6040604@redhat.com>  <42011203.3010005@redhat.com>
Content-Type: multipart/mixed; boundary="=-zBTQr7ExJh47bkIc4iJ2"
Message-Id: <1107368924.890.298.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 13:28:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-zBTQr7ExJh47bkIc4iJ2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-02-02 at 12:46, Daniel J Walsh wrote:
> Ok how about this patch.
> 
> Added -e flag for restorecon

Merged along with the attached patch as of policycoreutils 1.21.11.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-zBTQr7ExJh47bkIc4iJ2
Content-Disposition: attachment; filename=policycoreutils-nsa.patch
Content-Type: text/x-patch; name=policycoreutils-nsa.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/restorecon/restorecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/restorecon/restorecon.c,v
retrieving revision 1.25
diff -u -p -r1.25 restorecon.c
--- policycoreutils/restorecon/restorecon.c	2 Feb 2005 18:09:33 -0000	1.25
+++ policycoreutils/restorecon/restorecon.c	2 Feb 2005 18:19:16 -0000
@@ -50,7 +50,7 @@ static int force=0;
 static int excludeCtr=0;
 struct edir {
 	char *directory;
-        int size;
+        size_t size;
 };
 static struct edir excludeArray[MAX_EXCLUDES];
 static int add_exclude(const char *directory) {
@@ -68,6 +68,12 @@ static int add_exclude(const char *direc
     fprintf(stderr, "\"%s\" is not a Directory: mode %o\n", directory,sb.st_mode);
     return 1;
   }
+
+  if (excludeCtr == MAX_EXCLUDES) {
+    fprintf(stderr, "Maximum excludes %d exceeded.\n", MAX_EXCLUDES);
+    return 1;
+  }
+
    excludeArray[excludeCtr].directory = strdup(directory);
   if (!excludeArray[excludeCtr].directory) {
     fprintf(stderr, "Out of memory.\n");
@@ -75,10 +81,6 @@ static int add_exclude(const char *direc
   }
   excludeArray[excludeCtr++].size = strlen(directory);
 
-  if (excludeCtr > MAX_EXCLUDES) {
-    fprintf(stderr, "Maximum excludes %d exceeded.\n", MAX_EXCLUDES);
-    return 1;
-  }
   return 0;
 }
 static int exclude(const char *file) {
Index: policycoreutils/setfiles/setfiles.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setfiles/setfiles.c,v
retrieving revision 1.30
diff -u -p -r1.30 setfiles.c
--- policycoreutils/setfiles/setfiles.c	2 Feb 2005 18:09:37 -0000	1.30
+++ policycoreutils/setfiles/setfiles.c	2 Feb 2005 18:20:18 -0000
@@ -83,7 +83,7 @@ static int force=0;
 static int excludeCtr=0;
 struct edir {
 	char *directory;
-        int size;
+        size_t size;
 };
 static struct edir excludeArray[MAX_EXCLUDES];
 
@@ -131,6 +131,12 @@ static int add_exclude(const char *direc
 	        fprintf(stderr, "\"%s\" is not a Directory: mode %o\n", directory,sb.st_mode);
 	        return 1;
 	}
+
+	if (excludeCtr == MAX_EXCLUDES) {
+	        fprintf(stderr, "Maximum excludes %d exceeded.\n", MAX_EXCLUDES);
+	        return 1;
+	}
+
 	excludeArray[excludeCtr].directory = strdup(directory);
 	if (!excludeArray[excludeCtr].directory) {
 	        fprintf(stderr, "Out of memory.\n");
@@ -138,10 +144,6 @@ static int add_exclude(const char *direc
 	}
 	excludeArray[excludeCtr++].size = strlen(directory);
 	
-	if (excludeCtr > MAX_EXCLUDES) {
-	        fprintf(stderr, "Maximum excludes %d exceeded.\n", MAX_EXCLUDES);
-	        return 1;
-	}
 	return 0;
 }
 

--=-zBTQr7ExJh47bkIc4iJ2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
