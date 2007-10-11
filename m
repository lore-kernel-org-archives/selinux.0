Message-ID: <470E5904.9080204@tycho.nsa.gov>
Date: Thu, 11 Oct 2007 13:10:28 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: stringrep / mapping fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On one of the paths through security_class_to_string, the unmapping is
done twice.  Same with security_av_perm_to_string.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 stringrep.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)


Index: libselinux/src/stringrep.c
===================================================================
--- libselinux/src/stringrep.c	(revision 2644)
+++ libselinux/src/stringrep.c	(working copy)
@@ -370,8 +370,6 @@
 
 static const char *security_class_to_string_compat(security_class_t tclass)
 {
-	tclass = unmap_class(tclass);
-
 	if (tclass > 0 && tclass < NCLASSES)
 		return class_to_string_data.str + class_to_string[tclass];
 
@@ -386,9 +384,6 @@
 	access_vector_t common_base = 0;
 	unsigned int i;
 
-	av = unmap_perm(tclass, av);
-	tclass = unmap_class(tclass);
-
 	if (!av)
 		return NULL;
 
@@ -466,10 +461,11 @@
 {
 	struct discover_class_node *node;
 
+	tclass = unmap_class(tclass);
+
 	if (obj_class_compat)
 		return security_class_to_string_compat(tclass);
 
-	tclass = unmap_class(tclass);
 	node = get_class_cache_entry_value(tclass);
 	if (node == NULL)
 		return security_class_to_string_compat(tclass);
@@ -483,11 +479,12 @@
 	struct discover_class_node *node;
 	size_t i;
 
+	av = unmap_perm(tclass, av);
+	tclass = unmap_class(tclass);
+
 	if (obj_class_compat)
 		return security_av_perm_to_string_compat(tclass,av);
 
-	av = unmap_perm(tclass, av);
-	tclass = unmap_class(tclass);
 	node = get_class_cache_entry_value(tclass);
 	if (av && node)
 		for (i = 0; i<MAXVECTORS; i++)

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
