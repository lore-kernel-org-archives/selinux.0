Message-ID: <436BA8E6.8030508@cornell.edu>
Date: Fri, 04 Nov 2005 13:31:02 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Assert whitespace between records
Content-Type: multipart/mixed;
 boundary="------------090903020505040408070204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090903020505040408070204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch will assert there is whitespace between seuser, boolean, 
interface, and port records (assert whitespace after each record). This 
has no effect on ports and interfaces, because they already check for 
that when looking for where the context ends (added for clarity only). 
Users don't require a space, because they have a semicolon.

In the case of seusers, this prevents parser confusion when MLS is 
disabled, and we encounter an MLS context:
a:b:c - complain about lack of whitespace, rather than treating the ":" 
as the next seuser, and saying something like: nonempty string expected, 
or whatever...

In the case of booleans, this change will consider a=TRUEb=false or 
things like that as a parse error.

This change will succeed on the last record, and at the end of each 
line, because the terminating '\0' is considered whitespace - it's 
present on all lines, including the last one. It will not succeed if you 
called skip_space right before that, because that zeros the buffer on 
EOF (intentionally).


--------------090903020505040408070204
Content-Type: text/x-patch;
 name="libsemanage.space_between_records.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.space_between_records.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libselinux/src/seusers.c new/libselinux/src/seusers.c
--- old/libselinux/src/seusers.c	2005-11-04 10:13:47.000000000 -0500
+++ new/libselinux/src/seusers.c	2005-11-04 13:05:10.000000000 -0500
@@ -45,7 +45,6 @@ static int process_seusers(const char *b
 	if (!end) {
 		mls_found = 0;
 
-		/* MLS is disabled, so :level suffix not required. */
 		end = start;
 		while (*end && !isspace(*end))
 			end++;
@@ -55,9 +54,10 @@ static int process_seusers(const char *b
 	seuser = strdup(start);
 	if (!seuser)
 		goto err;
-
+	
+	/* Skip MLS if disabled, or missing. */
 	if (!mls_enabled || !mls_found)
-		goto out; /* skip any MLS level */
+		goto out;
 
 	start = ++end;
 	while (*end && !isspace(*end))
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/booleans_file.c new/libsemanage/src/booleans_file.c
--- old/libsemanage/src/booleans_file.c	2005-11-04 03:03:26.000000000 -0500
+++ new/libsemanage/src/booleans_file.c	2005-11-04 13:14:51.000000000 -0500
@@ -87,6 +87,9 @@ static int bool_parse(
 	}
 	semanage_bool_set_value(boolean, value);
 
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
 	return STATUS_SUCCESS;
 
 	last:
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-11-04 03:03:26.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-11-04 13:22:57.000000000 -0500
@@ -127,6 +127,9 @@ static int iface_parse(
 	semanage_iface_set_msgcon(iface, con);
 	con = NULL;
 
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
 	return STATUS_SUCCESS;
 
 	last:
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-11-04 03:03:26.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-11-04 13:13:43.000000000 -0500
@@ -134,6 +134,9 @@ static int port_parse(
 	semanage_port_set_con(port, con);
 	con = NULL;
 
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
 	return STATUS_SUCCESS;
 
 	last:
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-11-04 03:03:26.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-11-04 13:12:33.000000000 -0500
@@ -96,7 +96,10 @@ static int seuser_parse(
 			goto err;
 		free(str);
 		str = NULL;
-	} 
+	}
+
+	if (parse_assert_space(handle, info) < 0)
+		goto err; 
 	
 	out:
 	return STATUS_SUCCESS;

--------------090903020505040408070204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
