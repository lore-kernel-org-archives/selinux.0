Date: Thu, 28 Sep 2006 08:20:45 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com, jmorris@namei.org,
        chanson@TrustedCS.com, dgoeddel@TrustedCS.com
Subject: [Patch 1/3] SELinux: add support for quoted context mount option
Message-Id: <20060928082045.d52f4de8.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A collision is occuring between security contexts that contain a comma 
and the comma that is used to separate options for mount.  To resolve 
the collision the patch introduces support for quoting the context mount 
option.

The routine selinux_sb_copy_data() was modified to mark a flag value 
when it runs across a '"'.  This flag value is consulted each time a 
comma is encountered during the processing of the mount options.  If 
the flag indicates that the current option contains a quote it will 
move on to the next character.  If the flag indicates that there is 
either a matched set of quotes or no quotes at all then the option 
is taken.  If the option happens to be an selinux option then the new 
routine take_selinux_option() is called.  take_selinux_option() will 
copy the option to the previously allocated selinux data page.  While 
it is doing the copying it will skip any quotes present in the option 
so the data page contains only the raw unquoted context.  The previously 
used comma separator between options in the selinux data page was 
replaced with a '|' character to allow try_context_mount() to properly 
extract whole context option strings as well.

Signed-off-by: Cory Olmo <colmo@TrustedCS.com>
---

 hooks.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)


--- linux-2.6.18.fc6t3/security/selinux/hooks.c	2006-09-21 13:57:29.000000000 -0500
+++ linux-2.6.18/security/selinux/hooks.c	2006-09-21 14:04:07.000000000 -0500
@@ -398,7 +398,7 @@ static int try_context_mount(struct supe
 		/* Standard string-based options. */
 		char *p, *options = data;
 
-		while ((p = strsep(&options, ",")) != NULL) {
+		while ((p = strsep(&options, "|")) != NULL) {
 			int token;
 			substring_t args[MAX_OPT_ARGS];
 
@@ -1955,11 +1955,34 @@ static inline void take_option(char **to
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
@@ -1981,11 +2004,15 @@ static int selinux_sb_copy_data(struct f
 	in_save = in_end = orig;
 
 	do {
-		if (*in_end == ',' || *in_end == '\0') {
+		if (*in_end == '"') {
+			open_quote = !open_quote;
+		}
+		if ((*in_end == ',' && open_quote == 0) ||
+				*in_end == '\0') {
 			int len = in_end - in_curr;
 
 			if (selinux_option(in_curr, len))
-				take_option(&sec_curr, in_curr, &fsec, len);
+				take_selinux_option(&sec_curr, in_curr, &fsec, len);
 			else
 				take_option(&nosec, in_curr, &fnosec, len);
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
