Subject: Re: Added is_context_configurable function
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Colin Walters <walters@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41E54436.3080008@redhat.com>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <1105481440.24748.22.camel@nexus.verbum.private>
	 <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
	 <41E54436.3080008@redhat.com>
Content-Type: multipart/mixed; boundary="=-UkOkSJZqeK85i44aAb2s"
Message-Id: <1106234976.26753.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 Jan 2005 10:29:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-UkOkSJZqeK85i44aAb2s
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-01-12 at 10:37, Daniel J Walsh wrote:
> Patched for libselinux.
> 
> This patch changes the previous to rename configurable_contexts to 
> customizable_paths.
> 
> Also modifies matchpathcon to process file_contexts.local
> 
> So if a user wants to change the config file of a server to a different 
> location they can
> do something like the following
> 
> sed 's|/var/www|/usr/local/www/g' 
> /etc/selinux/targeted/context/file_context > 
> /etc/selinux/targeted/context/file_context.local
> 
> And then restorecon -R -v /usr/local/www

Thanks, merged into sourceforge CVS as of libselinux version 1.21.1,
along with the modifications below relative to your patch.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-UkOkSJZqeK85i44aAb2s
Content-Disposition: attachment; filename=libselinux-fixes.patch
Content-Type: text/x-patch; name=libselinux-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/is_customizable_type.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/is_customizable_type.c,v
retrieving revision 1.1
diff -u -p -r1.1 is_customizable_type.c
--- libselinux/src/is_customizable_type.c	19 Jan 2005 16:09:40 -0000	1.1
+++ libselinux/src/is_customizable_type.c	19 Jan 2005 16:25:03 -0000
@@ -5,36 +5,40 @@
 #include <string.h>
 #include <ctype.h>
 #include <pwd.h>
-#include <selinux/selinux.h>
+#include <limits.h>
+#include "selinux_internal.h"
+#include "context_internal.h"
 
 static int get_customizable_type_list (security_context_t **retlist)
 {
 	FILE *fp;
 	char buf[4097];
-	int ctr=0, i;
+	unsigned int ctr=0, i;
 	security_context_t *list=NULL;
 
 	fp = fopen(selinux_customizable_types_path(), "r");
 	if (!fp)
 		return -1;
 
-	while (fgets_unlocked(buf, 4096, fp)) {
+	while (fgets_unlocked(buf, 4096, fp) && ctr < UINT_MAX) {
 		ctr++;
 	}
 	rewind(fp);
 	if (ctr) {
-		list=(security_context_t *) calloc(sizeof(security_context_t *), ctr+1);
+		list=(security_context_t *) calloc(sizeof(security_context_t), ctr+1);
 		if (list) {
 		  i=0;
-		  while (fgets_unlocked(buf, 4096, fp)) {
+		  while (fgets_unlocked(buf, 4096, fp) && i < ctr) {
 		    buf[strlen(buf)-1]=0;
-		    list[i++]=(security_context_t) strdup(buf);
-		    if (i>ctr) { 
-		      /* Should never happen */
+		    list[i]=(security_context_t) strdup(buf);
+		    if (!list[i]) {
+		      unsigned int j;
+		      for (j = 0; j < i; j++) free(list[j]);
 		      free(list);
 		      list=NULL;
 		      break;
 		    }
+		    i++;
 		  }
 		}
 	}
@@ -49,20 +53,31 @@ static security_context_t *customizable_
 
 int is_context_customizable (security_context_t scontext) {
   int i;
-  char *ptr;
+  const char *type;
+  context_t c;
+
   if (! customizable_list) {
     if (get_customizable_type_list(&customizable_list)!=0) 
       return -1;
   }
-  
-  ptr=strrchr(scontext, ':');
-  if (ptr) {
-	  ptr++;
-  } else {
-	  ptr=scontext;
+
+  c = context_new(scontext);
+  if (!c)
+	  return -1;
+
+  type = context_type_get(c);
+  if (!type) {
+	  context_free(c);
+	  return -1;
   }
+  
   for (i = 0; customizable_list[i]; i++) {
-    if (strcmp(customizable_list[i],ptr) == 0) return 1;
+	  if (strcmp(customizable_list[i],type) == 0) {
+		  context_free(c);
+		  return 1;
+	  }
   }
+  context_free(c);
   return 0;
 }
+
Index: libselinux/src/selinux_config.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_config.c,v
retrieving revision 1.11
diff -u -p -r1.11 selinux_config.c
--- libselinux/src/selinux_config.c	19 Jan 2005 16:09:40 -0000	1.11
+++ libselinux/src/selinux_config.c	19 Jan 2005 16:14:54 -0000
@@ -215,6 +215,7 @@ const char *selinux_media_context_path()
 const char *selinux_customizable_types_path() {
   return get_path(CUSTOMIZABLE_TYPES);
 }
+hidden_def(selinux_customizable_types_path)
 
 const char *selinux_contexts_path() {
   return get_path(CONTEXTS_DIR);
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.2
diff -u -p -r1.2 selinux_internal.h
--- libselinux/src/selinux_internal.h	5 Oct 2004 20:31:50 -0000	1.2
+++ libselinux/src/selinux_internal.h	19 Jan 2005 16:12:17 -0000
@@ -20,3 +20,4 @@ hidden_proto(selinux_removable_context_p
 hidden_proto(selinux_file_context_path)
 hidden_proto(selinux_user_contexts_path)
 hidden_proto(selinux_booleans_path)
+hidden_proto(selinux_customizable_types_path)

--=-UkOkSJZqeK85i44aAb2s--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
