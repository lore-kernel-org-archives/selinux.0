Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r329fIvQ020078
	for <selinux@tycho.nsa.gov>; Tue, 2 Apr 2013 05:41:18 -0400
Date: Tue, 2 Apr 2013 11:41:05 +0200
From: Laurent Bigonville <bigon@debian.org>
To: Eric Paris <eparis@parisplace.org>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>
Subject: Re: File context not applied due to regex ordering
Message-ID: <20130402114105.1356b034@soldur.bigon.be>
In-Reply-To: <CACLa4psh+Litc-ko0g7NhQ3BDYRX7_BX1TZqzg4uxYVhZ3VQzw@mail.gmail.com>
References: <20130321123256.198ba5b6@soldur.bigon.be>
	<5159AEA8.2090004@tresys.com>
	<20130401185508.3d15476e@fornost.bigon.be>
	<CACLa4psh+Litc-ko0g7NhQ3BDYRX7_BX1TZqzg4uxYVhZ3VQzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/px+j9mghLB7Ql6pjev042F7"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--MP_/px+j9mghLB7Ql6pjev042F7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Mon, 1 Apr 2013 13:40:46 -0400,
Eric Paris <eparis@parisplace.org> a =E9crit :

> I feel like we talked about it...  Regex ordering is a bit tricky.  I
> think I hacked up a patch which added an additional tie breaker step
> with the total number of 'non-regex' type characters being used.  It's
> been long lost though...
>=20
> Do you still have that hack around?  Maybe we can see what others
> think?

I definitely have a bad memory...

I grepped my IRC logs and found this patch[0] from you at the date of
the 28th of Sept 2012.

Cheers

Laurent Bigonville

[0] http://fpaste.org/p48W/

--MP_/px+j9mghLB7Ql6pjev042F7
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=selinux_regex_stem.patch

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index cd7ce68..5ee3b9f 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -128,6 +128,7 @@ typedef struct semanage_file_context_node {
 	char *context;
 	int path_len;
 	int effective_len;
+	int nonmeta_len;
 	int type_len;
 	int context_len;
 	int meta;		/* position of first meta char in path, -1 if none */
@@ -2000,6 +2001,12 @@ static int semanage_fc_compare(semanage_file_context_node_t * a,
 	if (b->meta < a->meta)
 		return 1;
 
+	/* total number of non meta chars? */
+	if (a->nonmeta_len < b->nonmeta_len)
+		return -1;
+	if (b->nonmeta_len < a->nonmeta_len)
+		return 1;
+
 	/* Check to see if either a or b have a shorter string
 	 *  length than the other. */
 	if (a->effective_len < b->effective_len)
@@ -2110,6 +2117,24 @@ static void semanage_fc_merge_sort(semanage_file_context_bucket_t * master)
 	}
 }
 
+static int is_meta_char(char c)
+{
+	switch (c) {
+	case '.':
+	case '^':
+	case '$':
+	case '?':
+	case '*':
+	case '+':
+	case '|':
+	case '[':
+	case '(':
+	case '{':
+		return 1;
+	}
+	return 0;
+}
+
 /* Compute the location of the first regular expression 
  *   meta character in the path of the given node, if it exists. 
  * On return:
@@ -2127,25 +2152,15 @@ static void semanage_fc_find_meta(semanage_file_context_node_t * fc_node)
 	 *  spec_hasMetaChars in matchpathcon.c from
 	 *  libselinux-1.22. */
 	while (fc_node->path[c] != '\0') {
-		switch (fc_node->path[c]) {
-		case '.':
-		case '^':
-		case '$':
-		case '?':
-		case '*':
-		case '+':
-		case '|':
-		case '[':
-		case '(':
-		case '{':
+		if (is_meta_char(fc_node->path[c])) {
 			fc_node->meta = c - escape_chars;
 			return;
-		case '\\':
+		}
+		if (fc_node->path[c] == '\\') {
 			/* If an escape character is found,
 			 *  skip the next character. */
 			c++;
 			escape_chars++;
-			break;
 		}
 
 		c++;
@@ -2208,7 +2223,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 	ssize_t sanity_check;
 	const char *line_buf, *line_end;
 	char *sorted_buf_pos;
-	int escape_chars, just_saw_escape;
+	int escape_chars, just_saw_escape, meta_chars;
 
 	semanage_file_context_node_t *temp;
 	semanage_file_context_node_t *head;
@@ -2291,10 +2306,13 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 		temp->next = NULL;
 
 		/* Extract the regular expression from the line. */
+		meta_chars = 0;
 		escape_chars = 0;
 		just_saw_escape = 0;
 		start = i;
 		while (i < line_len && (!isspace(line_buf[i]))) {
+			if (is_meta_char(line_buf[i]))
+				meta_chars++;
 			if (line_buf[i] == '\\') {
 				if (!just_saw_escape) {
 					escape_chars++;
@@ -2399,6 +2417,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 		/* Initialize the data about the file context. */
 		temp->path_len = regex_len;
 		temp->effective_len = regex_len - escape_chars;
+		temp->nonmeta_len = regex_len - escape_chars - meta_chars;
 		temp->type_len = type_len;
 		temp->context_len = context_len;
 		semanage_fc_find_meta(temp);

--MP_/px+j9mghLB7Ql6pjev042F7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
