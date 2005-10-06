Subject: Re: getseuserbyname patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43455A9C.7030901@redhat.com>
References: <43398EB2.1050100@redhat.com>
	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
	 <433BEB18.7000703@redhat.com>
	 <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>
	 <433C06F0.3020804@redhat.com>  <433C3C5A.4000104@redhat.com>
	 <1128028887.27495.184.camel@moss-spartans.epoch.ncsc.mil>
	 <1128354729.26285.137.camel@moss-spartans.epoch.ncsc.mil>
	 <1128356967.26285.154.camel@moss-spartans.epoch.ncsc.mil>
	 <1128604584.15836.67.camel@moss-spartans.epoch.ncsc.mil>
	 <43452647.4050205@redhat.com>
	 <1128605898.15836.79.camel@moss-spartans.epoch.ncsc.mil>
	 <43452C1F.5070708@redhat.com>
	 <1128617540.15836.141.camel@moss-spartans.epoch.ncsc.mil>
	 <43455A9C.7030901@redhat.com>
Content-Type: multipart/mixed; boundary="=-FJulXTHI+2nDap2E2GbQ"
Date: Thu, 06 Oct 2005 14:33:46 -0400
Message-Id: <1128623626.15836.149.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FJulXTHI+2nDap2E2GbQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-10-06 at 13:10 -0400, Daniel J Walsh wrote:
> BTW:  I would like to rename seusers.conf to seusers and put it in 
> /etc/selinux/TYPE/seusers
> 
> I also am upping sensitivity level to s15 and category to c255, in the 
> latest policy and changing the range lines appropriately.
> As proposed by Steve Grubb.
> 
> As soon as a libselinux changes show up I will put in patch to 
> pam_selinux to allow level selection.

Hmm...ok.  Patch below should alter the error handling for no seusers,
and move it under $SELINUXTYPE.


-- 
Stephen Smalley
National Security Agency

--=-FJulXTHI+2nDap2E2GbQ
Content-Disposition: attachment; filename=libselinux-1.27.7.patch
Content-Type: text/x-patch; name=libselinux-1.27.7.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/ChangeLog,v
retrieving revision 1.148
retrieving revision 1.149
diff -u -p -r1.148 -r1.149
--- libselinux/ChangeLog	6 Oct 2005 16:00:26 -0000	1.148
+++ libselinux/ChangeLog	6 Oct 2005 18:19:32 -0000	1.149
@@ -1,3 +1,9 @@
+1.27.7 2005-10-06
+	* Changed getseuserbyname to fall back to the Linux username and
+	NULL level if seusers config file doesn't exist unless 
+	REQUIRESEUSERS=1 is set in /etc/selinux/config.
+	* Moved seusers.conf under $SELINUXTYPE and renamed to seusers.
+
 1.27.6 2005-10-06
 	* Added selinux_init_load_policy() function as an even higher level
 	interface for the initial policy load by /sbin/init.  This obsoletes
Index: libselinux/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/VERSION,v
retrieving revision 1.66
retrieving revision 1.67
diff -u -p -r1.66 -r1.67
--- libselinux/VERSION	6 Oct 2005 16:00:27 -0000	1.66
+++ libselinux/VERSION	6 Oct 2005 18:19:32 -0000	1.67
@@ -1 +1 @@
-1.27.6
+1.27.7
Index: libselinux/src/file_path_suffixes.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/file_path_suffixes.h,v
retrieving revision 1.5
retrieving revision 1.6
diff -u -p -r1.5 -r1.6
--- libselinux/src/file_path_suffixes.h	17 Feb 2005 15:21:06 -0000	1.5
+++ libselinux/src/file_path_suffixes.h	6 Oct 2005 18:19:32 -0000	1.6
@@ -11,3 +11,4 @@ S_(MEDIA_CONTEXTS, "/contexts/files/medi
 S_(REMOVABLE_CONTEXT, "/contexts/removable_context")
 S_(CUSTOMIZABLE_TYPES, "/contexts/customizable_types")
 S_(USERS_DIR, "/users/")
+S_(SEUSERS, "/seusers")
Index: libselinux/src/selinux_config.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_config.c,v
retrieving revision 1.19
retrieving revision 1.20
diff -u -p -r1.19 -r1.20
--- libselinux/src/selinux_config.c	6 Oct 2005 16:00:27 -0000	1.19
+++ libselinux/src/selinux_config.c	6 Oct 2005 18:19:32 -0000	1.20
@@ -11,11 +11,11 @@
 
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
-#define SELINUXUSERS SELINUXDIR "seusers.conf"
 #define SELINUXDEFAULT "targeted"
 #define SELINUXTYPETAG "SELINUXTYPE="
 #define SELINUXTAG "SELINUX="
 #define SETLOCALDEFS "SETLOCALDEFS="
+#define REQUIRESEUSERS "REQUIRESEUSERS="
 
 /* Indices for file paths arrays. */
 #define BINPOLICY         0
@@ -30,7 +30,8 @@
 #define REMOVABLE_CONTEXT 9
 #define CUSTOMIZABLE_TYPES    10
 #define USERS_DIR         11
-#define NEL               12
+#define SEUSERS           12
+#define NEL               13
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -121,13 +122,13 @@ hidden_def(selinux_getenforcemode)
 
 static char *selinux_policyroot = NULL;
 
-static void init_selinux_policyroot(void) __attribute__ ((constructor));
+static void init_selinux_config(void) __attribute__ ((constructor));
 
-static void init_selinux_policyroot(void)
+static void init_selinux_config(void)
 {
-  int i;
+  int i, *intptr;
   size_t rootlen, len;
-  char *line_buf = NULL, *buf_p;
+  char *line_buf = NULL, *buf_p, *value;
   FILE *fp;
 
   if (selinux_policyroot) return;
@@ -165,17 +166,25 @@ static void init_selinux_policyroot(void
 				  return;
 			  snprintf(selinux_policyroot, rootlen, "%s%s", 
 				   SELINUXDIR, type);
+			  continue;
 		  } else if (!strncmp(buf_p, SETLOCALDEFS, 
 				      sizeof(SETLOCALDEFS)-1)) {
-			  char *value;
 			  value = buf_p + sizeof(SETLOCALDEFS)-1;
-			  if (isdigit(*value)) 
-				  load_setlocaldefs = atoi(value);
-			  else if (strncasecmp(value, "true", sizeof("true")-1))
-				  load_setlocaldefs = 1;
-			  else if (strncasecmp(value, "false", sizeof("false")-1))
-				  load_setlocaldefs = 0;
+			  intptr = &load_setlocaldefs;
+		  } else if (!strncmp(buf_p, REQUIRESEUSERS, 
+				      sizeof(REQUIRESEUSERS)-1)) {
+			  value = buf_p + sizeof(REQUIRESEUSERS)-1;
+			  intptr = &require_seusers;
+		  } else {
+			  continue;
 		  }
+
+		  if (isdigit(*value)) 
+			  *intptr = atoi(value);
+		  else if (strncasecmp(value, "true", sizeof("true")-1))
+			  *intptr = 1;
+		  else if (strncasecmp(value, "false", sizeof("false")-1))
+			  *intptr = 0;
 	  }
 	  free(line_buf);
 	  fclose(fp);
@@ -281,7 +290,7 @@ const char *selinux_users_path() {
   return get_path(USERS_DIR);
 }
 const char *selinux_usersconf_path() {
-  return SELINUXUSERS;
+  return get_path(SEUSERS);
 }
 
 hidden_def(selinux_users_path)
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.12
retrieving revision 1.13
diff -u -p -r1.12 -r1.13
--- libselinux/src/selinux_internal.h	6 Oct 2005 16:00:27 -0000	1.12
+++ libselinux/src/selinux_internal.h	6 Oct 2005 18:19:32 -0000	1.13
@@ -65,4 +65,4 @@ extern int hidden trans_to_raw_context(c
 extern int hidden raw_to_trans_context(char *raw, char **transp);
 
 extern int load_setlocaldefs hidden;
-
+extern int require_seusers hidden;
Index: libselinux/src/seusers.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/seusers.c,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -p -r1.3 -r1.4
--- libselinux/src/seusers.c	3 Oct 2005 17:06:16 -0000	1.3
+++ libselinux/src/seusers.c	6 Oct 2005 18:19:33 -0000	1.4
@@ -81,6 +81,8 @@ err:
 	return -2; /* error */
 }
 
+int require_seusers hidden = 0;
+
 int getseuserbyname(const char *name, char **r_seuser, char **r_level) {
 	FILE *cfg=NULL;
 	size_t size=0;
@@ -96,8 +98,16 @@ int getseuserbyname(const char *name, ch
         char *defaultlevel=NULL;
 
 	cfg = fopen(selinux_usersconf_path(), "r");
-	if (!cfg) 
-		return -1;
+	if (!cfg) {
+		if (require_seusers)
+			return -1;
+		/* Fall back to the Linux username and no level. */
+		*r_seuser = strdup(name);
+		if (!(*r_seuser))
+			return -1;
+		*r_level = NULL;
+		return 0;
+	}
 
 	while (getline(&buffer, &size, cfg) > 0) {
 		++lineno;

--=-FJulXTHI+2nDap2E2GbQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
