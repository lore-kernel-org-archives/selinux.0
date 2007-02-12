Message-ID: <45D084AF.8020405@redhat.com>
Date: Mon, 12 Feb 2007 10:15:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: get_default_context_with_level seems to be broken in libselinux.
Content-Type: multipart/mixed;
 boundary="------------040402050702000207040704"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040402050702000207040704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bugzilla's 211827 224637 
<https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=224637>

Show that the values after the comma are being dropped.

Adding the attached patch fixes the problem.

But I am not sure of the intended use of this code.  The current code 
does not work and looks like it never worked.  Was there an intention 
that this would work differently?


Dan



--------------040402050702000207040704
Content-Type: text/x-patch;
 name="default_level.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="default_level.patch"

--- libselinux-1.33.4/src/get_context_list.c~	2007-01-11 14:01:23.000000000 -0500
+++ libselinux-1.33.4/src/get_context_list.c	2007-02-09 15:43:31.000000000 -0500
@@ -381,12 +381,16 @@
 {
 	security_context_t *conary;
 	int rc;
-
+	context_t con;
 	rc = get_ordered_context_list_with_level(user, level, fromcon, &conary);
 	if (rc <= 0)
 		return -1;
 
-	*newcon = strdup(conary[0]);
+	con = context_new(conary[0]);
+	context_range_set(con, level);
+	*newcon = strdup(context_str(con));
+	context_free(con);
+
 	freeconary(conary);
 	if (!(*newcon))
 		return -1;

--------------040402050702000207040704--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
