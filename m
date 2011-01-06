Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p067F6eP031566
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2011 02:15:06 -0500
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p067F4g6018180
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2011 07:15:05 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.197])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p067F19Z019668
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2011 16:15:01 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p067F1N14293 for selinux@tycho.nsa.gov; Thu, 6 Jan 2011 16:15:01 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
	by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id p067F1uH004142
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2011 16:15:01 +0900 (JST)
Message-ID: <4D256BE8.2010704@ak.jp.nec.com>
Date: Thu, 06 Jan 2011 16:14:48 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [libselinux] add db_language support on label_db.c
Content-Type: multipart/mixed;
 boundary="------------090904070709050201060206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090904070709050201060206
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch add support db_language object class
to the selabel_lookup(_raw) interfaces.
It is needed to inform object manager initial label of
procedural language object.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------090904070709050201060206
Content-Type: text/x-patch;
 name="libselinux-selabel.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-selabel.1.patch"

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 0435365..1a54307 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -128,6 +128,7 @@ void selabel_stats(struct selabel_handle *handle);
 #define SELABEL_DB_PROCEDURE	7
 #define SELABEL_DB_BLOB		8
 #define SELABEL_DB_TUPLE	9
+#define SELABEL_DB_LANGUAGE	10
 
 #ifdef __cplusplus
 }
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index e1bfab7..7afacf0 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -138,6 +138,8 @@ process_line(const char *path, char *line_buf, unsigned int line_num,
 		spec->type = SELABEL_DB_BLOB;
 	else if (!strcmp(type, "db_tuple"))
 		spec->type = SELABEL_DB_TUPLE;
+	else if (!strcmp(type, "db_language"))
+		spec->type = SELABEL_DB_LANGUAGE;
 	else {
 		selinux_log(SELINUX_WARNING,
 			    "%s:  line %d has invalid object type %s\n",

--------------090904070709050201060206--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
