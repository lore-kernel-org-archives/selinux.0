Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HKV4cl029334
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 16:31:04 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6HKV3XA013821
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 20:31:03 GMT
Subject: [PATCH 4/6] netfilter integration: add netfilter contexts sorting
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 16:32:35 -0400
Message-Id: <1153168355.10090.49.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add sorting function for netfilter contexts.

 libsemanage/src/direct_api.c     |    9 +
 libsemanage/src/semanage_store.c |  189 +++++++++++++++++++++++++++++++++++++--
 libsemanage/src/semanage_store.h |    6 +
 3 files changed, 198 insertions(+), 6 deletions(-)

diff -purN trunk/libsemanage/src/direct_api.c newtrunk/libsemanage/src/direct_api.c
--- trunk/libsemanage/src/direct_api.c	2006-07-14 11:41:59.614597000 -0400
+++ newtrunk/libsemanage/src/direct_api.c	2006-07-14 11:15:36.000000000 -0400
@@ -580,6 +580,15 @@ static int semanage_direct_commit(semana
 				goto cleanup;
 		}
 
+		/* Netfilter Contexts */
+		/* Sort the netfilter contexts. */
+		if (semanage_nc_sort
+		    (sh, sepol_module_package_get_netfilter_contexts(base),
+		     sepol_module_package_get_netfilter_contexts_len(base),
+		     &sorted_nc_buffer, &sorted_nc_buffer_len) == -1) {
+			goto cleanup;
+		}
+
 		/* Write the contexts to a single file.  The buffer returned by
 		 * the sort function has a trailing \0 character, which we do
 		 * NOT want to write out to disk, so we pass sorted_fc_buffer_len-1. */
diff -purN trunk/libsemanage/src/semanage_store.c newtrunk/libsemanage/src/semanage_store.c
--- trunk/libsemanage/src/semanage_store.c	2006-07-14 11:41:59.614597000 -0400
+++ newtrunk/libsemanage/src/semanage_store.c	2006-07-14 11:19:15.000000000 -0400
@@ -2,6 +2,7 @@
  *	    Joshua Brindle <jbrindle@tresys.com>
  *	    Jason Tang <jtang@tresys.com>
  *          Christopher Ashworth <cashworth@tresys.com>
+ *          Chris PeBenito <cpebenito@tresys.com>
  *
  * Copyright (C) 2004-2006 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat, Inc.
@@ -133,6 +134,14 @@ typedef struct semanage_file_context_buc
 	struct semanage_file_context_bucket *next;
 } semanage_file_context_bucket_t;
 
+/* A node used in a linked list of netfilter rules.
+ */
+typedef struct semanage_netfilter_context_node {
+	char *rule;
+	size_t rule_len;
+	struct semanage_netfilter_context_node *next;
+} semanage_netfilter_context_node_t;
+
 /* Initialize the paths to config file, lock files and store root.
  */
 static int semanage_init_paths(const char *root)
@@ -1917,7 +1926,7 @@ static void semanage_fc_find_meta(semana
 }
 
 /* Replicates strchr, but limits search to buf_len characters. */
-static char *semanage_fc_strnchr(const char *buf, size_t buf_len, char c)
+static char *semanage_strnchr(const char *buf, size_t buf_len, char c)
 {
 	size_t idx = 0;
 
@@ -1939,7 +1948,7 @@ static char *semanage_fc_strnchr(const c
  * Used in the context of a file context char buffer that we will be 
  * parsing and sorting.
  */
-static char *semanage_fc_get_line_end(const char *buf, size_t buf_len)
+static char *semanage_get_line_end(const char *buf, size_t buf_len)
 {
 	char *line_end = NULL;
 
@@ -1948,11 +1957,11 @@ static char *semanage_fc_get_line_end(co
 	if (buf_len <= 0)
 		return NULL;
 
-	line_end = semanage_fc_strnchr(buf, buf_len, '\n');
+	line_end = semanage_strnchr(buf, buf_len, '\n');
 	if (!line_end)
-		line_end = semanage_fc_strnchr(buf, buf_len, '\r');
+		line_end = semanage_strnchr(buf, buf_len, '\r');
 	if (!line_end)
-		line_end = semanage_fc_strnchr(buf, buf_len, EOF);
+		line_end = semanage_strnchr(buf, buf_len, EOF);
 
 	return line_end;
 }
@@ -2008,7 +2017,7 @@ int semanage_fc_sort(semanage_handle_t *
 	/* Parse the char buffer into a semanage_file_context_node_t linked list. */
 	line_buf = buf;
 	buf_remainder = buf_len;
-	while ((line_end = semanage_fc_get_line_end(line_buf, buf_remainder))) {
+	while ((line_end = semanage_get_line_end(line_buf, buf_remainder))) {
 		line_len = line_end - line_buf + 1;
 		sanity_check = buf_remainder - line_len;
 		buf_remainder = buf_remainder - line_len;
@@ -2277,3 +2286,171 @@ int semanage_fc_sort(semanage_handle_t *
 
 	return 0;
 }
+
+/********************* functions that sort netfilter contexts *********************/
+
+#define NC_PRIORITY_MAX 9
+static void semanage_nc_destroy_ruletab(semanage_netfilter_context_node_t *
+					ruletab[NC_PRIORITY_MAX][2])
+{
+	semanage_netfilter_context_node_t *curr, *next;
+	int i;
+
+	for (i = 0; i < NC_PRIORITY_MAX; i++) {
+		for (curr = ruletab[i][0]; curr != NULL; curr = next) {
+			next = curr->next;
+			free(curr->rule);
+			free(curr);
+		}
+	}
+}
+
+/*  Entry function for sorting a set of netfilter context lines.
+ *  Returns 0 on success, -1 on failure.
+ *  Allocates a buffer pointed to by sorted_buf that contains the sorted lines.
+ *  sorted_buf_len is set to the size of this buffer.
+ *  This buffer is guaranteed to have a final \0 character. 
+ *  This buffer must be released by the caller.
+ */
+int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
+		     char **sorted_buf, size_t * sorted_buf_len)
+{
+
+	/* parsing bits */
+	size_t line_len, buf_remainder, i, offset;
+	const char *line_buf, *line_end;
+	char *endptr;
+	long int val;
+
+	/* ruletab bits */
+	/* keep track of the head (index 0) and tail (index 1) with this array */
+	semanage_netfilter_context_node_t *ruletab[NC_PRIORITY_MAX][2];
+	semanage_netfilter_context_node_t *curr, *node;
+	int priority;
+
+	/* sorted buffer bits */
+	char *sorted_buf_pos;
+	size_t count;
+
+	/* initialize ruletab */
+	memset(ruletab, 0,
+	       NC_PRIORITY_MAX * 2 *
+	       sizeof(semanage_netfilter_context_node_t *));
+
+	/* while lines to be read */
+	line_buf = buf;
+	buf_remainder = buf_len;
+	while ((line_end = semanage_get_line_end(line_buf, buf_remainder))) {
+		line_len = line_end - line_buf + 1;
+		buf_remainder = buf_remainder - line_len;
+
+		if (line_len == 0 || line_len == 1) {
+			line_buf = line_end + 1;
+			continue;
+		}
+
+		/* Skip the whitespace at the front of the line. */
+		for (i = 0; i < line_len; i++) {
+			if (!isspace(line_buf[i]))
+				break;
+		}
+
+		/* Check for a blank line. */
+		if (i >= line_len) {
+			line_buf = line_end + 1;
+			continue;
+		}
+
+		/* Check if the line is a comment. */
+		if (line_buf[i] == '#') {
+			line_buf = line_end + 1;
+			continue;
+		}
+
+		/* extract priority */
+		val = strtol(line_buf, &endptr, 10);
+		if (line_buf == endptr) {
+			ERR(sh, "Netfilter context line missing priority.");
+			semanage_nc_destroy_ruletab(ruletab);
+			return -1;
+		}
+
+		/* priority shifted down by one to make 0-indexed */
+		if (val < 1)
+			priority = 0;
+		else if (val > NC_PRIORITY_MAX)
+			priority = NC_PRIORITY_MAX - 1;
+		else
+			priority = val - 1;
+
+		/* skip over whitespace */
+		for (offset = endptr - line_buf;
+		     offset < line_len && isspace(line_buf[offset]); offset++) ;
+
+		/* load rule into node */
+		node = (semanage_netfilter_context_node_t *)
+		    malloc(sizeof(semanage_netfilter_context_node_t));
+		if (!node) {
+			ERR(sh, "Failure allocating memory.");
+			semanage_nc_destroy_ruletab(ruletab);
+			return -1;
+		}
+
+		node->rule =
+		    (char *)strndup(line_buf + offset, line_len - offset);
+		node->rule_len = line_len - offset;
+		node->next = NULL;
+
+		if (!node->rule) {
+			ERR(sh, "Failure allocating memory.");
+			free(node);
+			semanage_nc_destroy_ruletab(ruletab);
+			return -1;
+		}
+
+		/* add node to rule table */
+		if (ruletab[priority][0] && ruletab[priority][1]) {
+			/* add to end of list, update tail pointer */
+			ruletab[priority][1]->next = node;
+			ruletab[priority][1] = node;
+		} else {
+			/* this list is empty, make head and tail point to the node */
+			ruletab[priority][0] = ruletab[priority][1] = node;
+		}
+
+		line_buf = line_end + 1;
+	}
+
+	/* First, calculate how much space we'll need for 
+	 * the newly sorted block of data.  (We don't just
+	 * use buf_len for this because we have extracted
+	 * comments and whitespace.)  Start at 1 for trailing \0 */
+	count = 1;
+	for (i = 0; i < NC_PRIORITY_MAX; i++)
+		for (curr = ruletab[i][0]; curr != NULL; curr = curr->next)
+			count += curr->rule_len;
+
+	/* Allocate the buffer for the sorted list. */
+	*sorted_buf = calloc(count, sizeof(char));
+	if (!*sorted_buf) {
+		ERR(sh, "Failure allocating memory.");
+		semanage_nc_destroy_ruletab(ruletab);
+		return -1;
+	}
+	*sorted_buf_len = count;
+
+	/* write out rule buffer */
+	sorted_buf_pos = *sorted_buf;
+	for (i = 0; i < NC_PRIORITY_MAX; i++) {
+		for (curr = ruletab[i][0]; curr != NULL; curr = curr->next) {
+			/* put rule into buffer */
+			snprintf(sorted_buf_pos, curr->rule_len + 1, "%s\n", curr->rule);	/* +1 for newline */
+			sorted_buf_pos = sorted_buf_pos + curr->rule_len;
+		}
+	}
+
+	/* free ruletab */
+	semanage_nc_destroy_ruletab(ruletab);
+
+	return 0;
+}
diff -purN trunk/libsemanage/src/semanage_store.h newtrunk/libsemanage/src/semanage_store.h
--- trunk/libsemanage/src/semanage_store.h	2006-07-14 11:41:59.614597000 -0400
+++ newtrunk/libsemanage/src/semanage_store.h	2006-07-14 11:15:32.000000000 -0400
@@ -116,4 +116,10 @@ int semanage_fc_sort(semanage_handle_t *
 		     size_t buf_len,
 		     char **sorted_buf, size_t * sorted_buf_len);
 
+/* sort netfilter context routines */
+int semanage_nc_sort(semanage_handle_t * sh,
+		     const char *buf,
+		     size_t buf_len,
+		     char **sorted_buf, size_t * sorted_buf_len);
+
 #endif


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
