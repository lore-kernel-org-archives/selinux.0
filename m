Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sP009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:25 -0400
Received: by mail-wi0-f170.google.com with SMTP id em10so1605040wid.5
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:31 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.30
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:31 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 14/20] libsemanage: fix gcc -Wwrite-strings warnings
Date: Sun, 14 Sep 2014 23:41:45 +0200
Message-Id: <1410730911-14512-15-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsemanage/src/conf-parse.y | 4 ++--
 libsemanage/src/utilities.c  | 6 +++---
 libsemanage/src/utilities.h  | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 76eb645c3349..84bc48b4f7e0 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -32,7 +32,7 @@
 #include <string.h>
 
 extern int semanage_lex();                /* defined in conf-scan.c */
-int semanage_error(char *msg);
+int semanage_error(const char *msg);
 
 extern FILE *semanage_in;
 extern char *semanage_text;
@@ -442,7 +442,7 @@ void semanage_conf_destroy(semanage_conf_t * conf)
 	}
 }
 
-int semanage_error(char *msg)
+int semanage_error(const char *msg)
 {
 	fprintf(stderr, "error parsing semanage configuration file: %s\n", msg);
 	parse_errors++;
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index a340fc858c46..f48ffa489d14 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -31,7 +31,7 @@
 #define TRUE 1
 #define FALSE 0
 
-char *semanage_findval(char *file, char *var, char *delim)
+char *semanage_findval(const char *file, const char *var, const char *delim)
 {
 	FILE *fd;
 	char *buff = NULL;
@@ -134,7 +134,7 @@ char *semanage_split(const char *str, const char *delim)
 	return retval;
 }
 
-int semanage_list_push(semanage_list_t ** list, char *data)
+int semanage_list_push(semanage_list_t ** list, const char *data)
 {
 	semanage_list_t *temp = NULL;
 
@@ -185,7 +185,7 @@ void semanage_list_destroy(semanage_list_t ** list)
 	}
 }
 
-semanage_list_t *semanage_list_find(semanage_list_t * l, char *data)
+semanage_list_t *semanage_list_find(semanage_list_t * l, const char *data)
 {
 	if (!data)
 		return NULL;
diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
index b81e54eb6cc7..5fa15efd08d0 100644
--- a/libsemanage/src/utilities.h
+++ b/libsemanage/src/utilities.h
@@ -52,7 +52,7 @@ typedef struct list {
  *
  *	   NULL for error (out of memory, etc)
  */
-char *semanage_findval(char *file, char *var, char *delim) WARN_UNUSED;
+char *semanage_findval(const char *file, const char *var, const char *delim) WARN_UNUSED;
 
 /**
  * @param str   string to test
@@ -88,11 +88,11 @@ char *semanage_split(const char *str, const char *delim) WARN_UNUSED;
  * Functions allocate memory.  Must be free'd with
  * either semanage_list_pop until list == NULL or semanage_list_destroy()
  */
-int semanage_list_push(semanage_list_t ** list, char *data) WARN_UNUSED;
+int semanage_list_push(semanage_list_t ** list, const char *data) WARN_UNUSED;
 char *semanage_list_pop(semanage_list_t ** list);
 void semanage_list_destroy(semanage_list_t ** list);
 semanage_list_t *semanage_list_find(semanage_list_t * l,
-				    char *data) WARN_UNUSED;
+				    const char *data) WARN_UNUSED;
 int semanage_list_sort(semanage_list_t ** l) WARN_UNUSED;
 /* function to compare 2 semanage_list_t nodes,
  * returns strcmp(x->data, y->data)
-- 
2.1.0
