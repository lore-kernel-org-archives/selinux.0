Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o29KBJWH006404
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 15:11:19 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o29KBkKP015460
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 20:11:46 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id o29KAfIv024374
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 15:10:41 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id o29KAfS7024372
	for selinux@tycho.nsa.gov; Tue, 9 Mar 2010 15:10:41 -0500
Message-ID: <4B96AAA7.5090909@tycho.nsa.gov>
Date: Tue, 09 Mar 2010 15:08:07 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com> <4B14396A.9000207@tycho.nsa.gov> <4B8C7D8C.9060803@ak.jp.nec.com> <4B9584A3.1070603@tycho.nsa.gov> <4B9598F1.50309@ak.jp.nec.com> <4B95A2D2.3080101@tycho.nsa.gov> <4B95A780.8050300@ak.jp.nec.com>
In-Reply-To: <4B95A780.8050300@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/08/2010 08:42 PM, KaiGai Kohei wrote:

diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
new file mode 100644
index 0000000..fa41b59
--- /dev/null
+++ b/libselinux/src/label_db.c
@@ -0,0 +1,334 @@
+/*
+ * Media contexts backend for DB objects
+ *
+ * Author: KaiGai Kohei <kaigai@ak.jp.nec.com>

[snip]

+static int
+process_line(const char *path, char *line_buf, unsigned int line_num,
+	     catalog_t *catalog)
+{
+	spec_t	       *spec = &catalog->specs[catalog->nspec];
+	char	       *type, *key, *context, *temp;
+	int		items;
+
+	/* Cut off comments */
+	temp = strchr(line_buf, '#');
+	if (temp)
+		*temp = '\0';
+
+	/*
+	 * Every entry must have the following format
+	 *   <object class> <object name> <security context>
+	 */
+	type = key = context = temp = NULL;
+	items = sscanf(line_buf, "%as %as %as %as",
+		       &type, &key, &context, &temp);


What is the meaning of the fourth "temp" argument here. Aren't lines
only supposed to have three entries? Please remove this if it is not needed.


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
