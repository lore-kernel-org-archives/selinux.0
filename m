Message-ID: <36282A1733C57546BE392885C0618592364669@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   "SE Linux (E-mail)"
	 <SELinux@tycho.nsa.gov>
Subject: [patch] libselinux malloc return value checking
Date: Mon, 23 Aug 2004 13:51:07 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C48939.C44E1810"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C48939.C44E1810
Content-Type: text/plain;
	charset="iso-8859-1"



The attached patch (against libselinux-1.16) adds return value checking
to malloc, strdup, etc.

Please apply.

  src/compute_user.c       |    4 ++++
  src/get_context_list.c   |    5 +++++
  src/matchpathcon.c       |    6 ++++--
  src/query_user_context.c |   10 ++++++++++
  4 files changed, 23 insertions(+), 2 deletions(-)




------_=_NextPart_000_01C48939.C44E1810
Content-Type: text/plain;
	name="malloc.patch"
Content-Disposition: attachment;
	filename="malloc.patch"

diff -Nur libselinux-1.16.orig/src/compute_user.c libselinux-1.16/src/compute_user.c
--- libselinux-1.16.orig/src/compute_user.c	2004-04-16 19:13:26.000000000 +0000
+++ libselinux-1.16/src/compute_user.c	2004-08-20 13:48:19.000000000 +0000
@@ -68,6 +68,10 @@
 		goto out3;
 	}
 	ucon = context_str(cs);
+	if(!ucon) {
+		ret = -1;
+		goto out3;
+	}
 
 	ary = malloc((nel+2)*sizeof(char*));
 	if (!ary) {
diff -Nur libselinux-1.16.orig/src/get_context_list.c libselinux-1.16/src/get_context_list.c
--- libselinux-1.16.orig/src/get_context_list.c	2004-05-27 16:47:02.000000000 +0000
+++ libselinux-1.16/src/get_context_list.c	2004-08-19 21:12:17.000000000 +0000
@@ -262,6 +262,9 @@
     if ((pos < length) && (pos >= 0))
     {
         ordered_list[pos] = strdup(new_item);
+        if(!ordered_list[pos])
+            return ret_val;
+
         ret_val = 0;
     }
 
@@ -378,6 +381,8 @@
  retry:
 	nlen = strlen(user)+1+plen+1;
 	*newcon = malloc(nlen);
+	if(!(*newcon))
+		return -1;
 	rc = snprintf(*newcon, nlen, "%s:%s", user, ptr);
 	if (rc < 0 || (size_t) rc >= nlen) {
 		free(*newcon);
diff -Nur libselinux-1.16.orig/src/matchpathcon.c libselinux-1.16/src/matchpathcon.c
--- libselinux-1.16.orig/src/matchpathcon.c	2004-05-27 16:40:12.000000000 +0000
+++ libselinux-1.16/src/matchpathcon.c	2004-08-19 20:49:22.000000000 +0000
@@ -89,10 +89,12 @@
 	}
 	if(num_stems == alloc_stems)
 	{
+		stem_t *tmp_arr;
 		alloc_stems = alloc_stems * 2 + 16;
-		stem_arr = realloc(stem_arr, sizeof(stem_t) * alloc_stems);
-		if(!stem_arr)
+		tmp_arr = realloc(stem_arr, sizeof(stem_t) * alloc_stems);
+		if(!tmp_arr)
 			return -1;
+		stem_arr = tmp_arr;
 	}
 	stem_arr[num_stems].len = stem_len;
 	stem_arr[num_stems].buf = malloc(stem_len + 1);
diff -Nur libselinux-1.16.orig/src/query_user_context.c libselinux-1.16/src/query_user_context.c
--- libselinux-1.16.orig/src/query_user_context.c	2004-03-03 18:59:05.000000000 +0000
+++ libselinux-1.16/src/query_user_context.c	2004-08-20 13:56:20.000000000 +0000
@@ -130,6 +130,9 @@
       new_context = context_new ("user:role:type:level");
     else
       new_context = context_new ("user:role:type");
+
+    if(!new_context)
+      return -1;
   
     while (!done)
     {
@@ -168,6 +171,11 @@
 
         /* Get the string value of the context and see if it is valid. */
         user_context = context_str(new_context);
+        if(!user_context)
+        {
+            context_free (new_context);
+            return -1;
+        }
         if (!security_check_context(user_context))
             done = 1;
         else 
@@ -176,5 +184,7 @@
 
     *newcon = strdup(user_context);
     context_free (new_context);
+    if(!(*newcon))
+        return -1;
     return 0;
 }

------_=_NextPart_000_01C48939.C44E1810--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
