From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 15/18] libselinux: label_file: struct reorg
Date: Fri, 31 Aug 2012 10:49:51 -0700
Message-Id: <1346435394-1954-15-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Use char instead of int, reorder to put the chars together.  Just litle
things.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 1208d8b..ef97213 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -12,11 +12,11 @@ struct spec {
 	char *type_str;		/* type string for diagnostic messages */
 	pcre *regex;		/* compiled regular expression */
 	pcre_extra *sd;		/* extra compiled stuff */
-	char regcomp;		/* regex_str has been compiled to regex */
 	mode_t mode;		/* mode format value */
 	int matches;		/* number of matching pathnames */
-	int hasMetaChars;	/* regular expression has meta-chars */
 	int stem_id;		/* indicates which stem-compression item */
+	char hasMetaChars;	/* regular expression has meta-chars */
+	char regcomp;		/* regex_str has been compiled to regex */
 };
 
 /* A regular expression stem */
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
