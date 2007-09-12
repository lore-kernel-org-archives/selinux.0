Subject: Class/permission discovery
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Jim Carter <jwcart2@epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 10:57:50 -0400
Message-Id: <1189609070.6806.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/show_bug.cgi?id=283231

When a legacy userspace object manager like dbusd invokes the AVC with
numeric class and permission values on a kernel that supports object
class and permission discovery, the AVC ultimately calls the
integer-to-string mapping functions, but the class information has not
yet been cached by libselinux (currently triggered upon a
string_to_security_class() call, requires the string name to look up the
entry in /selinux/class), so the lookup fails.

At least as a short term fix, fall back to the compat functions in this
case.

Index: libselinux/src/stringrep.c
===================================================================
--- libselinux/src/stringrep.c	(revision 2556)
+++ libselinux/src/stringrep.c	(working copy)
@@ -471,10 +471,9 @@
 
 	tclass = unmap_class(tclass);
 	node = get_class_cache_entry_value(tclass);
-	if (node == NULL) {
-		errno = EINVAL;
-		return NULL;
-	} else
+	if (node == NULL)
+		return security_class_to_string_compat(tclass);
+	else
 		return node->name;
 }
 
@@ -495,8 +494,7 @@
 			if ((1<<i) & av)
 				return node->perms[i];
 
-	errno = EINVAL;
-	return NULL;
+	return security_av_perm_to_string_compat(tclass,av);
 }
 
 int security_av_string(security_class_t tclass, access_vector_t av, char **res)

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
