Message-ID: <436AEFAF.9070400@cornell.edu>
Date: Fri, 04 Nov 2005 00:20:47 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE 3 ] Fix evil strtol bug (breaks booleans)
Content-Type: multipart/mixed;
 boundary="------------080703070601060207020706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080703070601060207020706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I mentioned earlier that strtol wasn't behaving according to manpage. 
That's actually not true - it works fine, and that was just covering up 
a much worse bug. The bug caused fetch_int() to always return 0, and as 
a result to reset all booleans to 0. It wasn't noticed, because my test 
boolean was explicitly set to 1, and I wasn't paying attention to the 
other one that I have in booleans.local.

Changes:
- fix the bug (pass right value into strtol)
- remove errno printing - the errno doesn't make any sense most of the time


--------------080703070601060207020706
Content-Type: text/x-patch;
 name="libsemanage.fix_strtol_bug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fix_strtol_bug.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/parse_utils.c new/libsemanage/src/parse_utils.c
--- old/libsemanage/src/parse_utils.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/parse_utils.c	2005-11-04 00:06:18.000000000 -0500
@@ -256,10 +256,10 @@ int parse_fetch_int(
 		goto err;
 	}
 
-	value = strtol(info->ptr, &test, 10);
+	value = strtol(str, &test, 10);
 	if (*test != '\0') {
-		ERR(handle, "could not parse numeric value: %s (%s: %u)\n%s",
-			strerror(errno), info->filename, 
+		ERR(handle, "could not parse numeric value \"%s\": "
+			"(%s: %u)\n%s", str, info->filename, 
 			info->lineno, info->orig_line);
 		goto err;
 	}

--------------080703070601060207020706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
