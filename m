Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7FFuY89030038
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:56:34 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7FFuIFK020494
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 15:56:20 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k7FFuUNp012376
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:56:30 -0400 (EDT)
Date: Tue, 15 Aug 2006 10:56:15 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Subject: [RFC Patch 1/3] Context Mounts and Unsupported Contexts: kernel
Message-Id: <20060815105615.82a6a474.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__15_Aug_2006_10_56_15_-0500_nz_SIruuDgaAyI5+"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Tue__15_Aug_2006_10_56_15_-0500_nz_SIruuDgaAyI5+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This patch modifies selinux_sb_copy_data() so that it will only take an 
option after seeing a ',' if it hasn't seen a quote or if the quotes are 
matched.  When it does take the option, if the option is an selinux option 
then it calls a new function take_selinux_option().  This new function will 
strip the quotes and replace the previously used comma separator with a '|'.  
try_context_mount() was modified to look for the '|' as the separator 
instead of ','.

 linux-2.6.17/security/selinux/hooks.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

--Multipart=_Tue__15_Aug_2006_10_56_15_-0500_nz_SIruuDgaAyI5+
Content-Type: text/x-patch;
 name="linux-2.6-quoted_context.patch"
Content-Disposition: attachment;
 filename="linux-2.6-quoted_context.patch"
Content-Transfer-Encoding: 7bit

diff --git a/linux-2.6.17.i686/security/selinux/hooks.c b/linux-2.6.17.i686/security/selinux/hooks.c
index 93bc2df..378d90c 100644
--- a/linux-2.6.17.i686/security/selinux/hooks.c
+++ b/linux-2.6.17.i686/security/selinux/hooks.c
@@ -398,7 +398,7 @@ static int try_context_mount(struct supe
 		/* Standard string-based options. */
 		char *p, *options = data;
 
-		while ((p = strsep(&options, ",")) != NULL) {
+		while ((p = strsep(&options, "|")) != NULL) {
 			int token;
 			substring_t args[MAX_OPT_ARGS];
 
@@ -1949,11 +1949,34 @@ static inline void take_option(char **to
 	*to += len;
 }
 
+static inline void take_selinux_option(char **to, char *from, int *first, 
+		                       int len)
+{
+	int current_size = 0;
+
+	if (!*first) {
+		**to = '|';
+		*to += 1;
+	}
+	else
+		*first = 0;
+
+	while (current_size < len) {
+		if (*from != '"') {
+			**to = *from;
+			*to += 1;
+		}
+		from += 1;
+		current_size += 1;
+	}
+}
+
 static int selinux_sb_copy_data(struct file_system_type *type, void *orig, void *copy)
 {
 	int fnosec, fsec, rc = 0;
 	char *in_save, *in_curr, *in_end;
 	char *sec_curr, *nosec_save, *nosec;
+	int open_quote = 0;
 
 	in_curr = orig;
 	sec_curr = copy;
@@ -1975,11 +1998,18 @@ static int selinux_sb_copy_data(struct f
 	in_save = in_end = orig;
 
 	do {
-		if (*in_end == ',' || *in_end == '\0') {
+		if (*in_end == '"') {
+			if (open_quote == 0)
+				open_quote -= 1;
+			else
+				open_quote += 1;
+		}
+		if (((*in_end == ',') && (open_quote == 0)) ||
+				*in_end == '\0') {
 			int len = in_end - in_curr;
 
 			if (selinux_option(in_curr, len))
-				take_option(&sec_curr, in_curr, &fsec, len);
+				take_selinux_option(&sec_curr, in_curr, &fsec, len);
 			else
 				take_option(&nosec, in_curr, &fnosec, len);
 

--Multipart=_Tue__15_Aug_2006_10_56_15_-0500_nz_SIruuDgaAyI5+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
