Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l57Dg6AD013967
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 09:42:06 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l57Dg4Be028854
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 13:42:04 GMT
Subject: [PATCH 3/5] libselinux: add string<->value functions that use
	discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:40:45 -0400
Message-Id: <1181223645.6578.85.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add new value->name, name->value functions that use object class discovery.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

---
 libselinux/src/stringrep.c |   61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

Index: selinux-obj-class-discovery/libselinux/src/stringrep.c
===================================================================
--- selinux-obj-class-discovery.orig/libselinux/src/stringrep.c
+++ selinux-obj-class-discovery/libselinux/src/stringrep.c
@@ -413,6 +413,67 @@ static const char *security_av_perm_to_s
 	return NULL;
 }
 
+security_class_t string_to_security_class(const char *s)
+{
+	struct discover_class_node *node;
+
+	node = get_class_cache_entry_name(s);
+	if (node == NULL) {
+		node = discover_class(s);
+
+		if (node == NULL) {
+			errno = EINVAL;
+			return 0;
+		}
+	}
+
+	return node->value;
+}
+
+access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
+{
+	struct discover_class_node *node;
+
+	node = get_class_cache_entry_value(tclass);
+	if (node != NULL) {
+		size_t i;
+		for (i=0; i<MAXVECTORS && node->perms[i] != NULL; i++)
+			if (strcmp(node->perms[i],s) == 0)
+				return (1<<i);
+	}
+
+	errno = EINVAL;
+	return 0;
+}
+
+const char *security_class_to_string(security_class_t tclass)
+{
+	struct discover_class_node *node;
+
+	node = get_class_cache_entry_value(tclass);
+	if (node == NULL) {
+		errno = EINVAL;
+		return NULL;
+	} else
+		return node->name;
+}
+
+const char *security_av_perm_to_string(security_class_t tclass,
+				       access_vector_t av)
+{
+	struct discover_class_node *node;
+	size_t i;
+
+	node = get_class_cache_entry_value(tclass);
+	if (av && node)
+		for (i = 0; i<MAXVECTORS; i++)
+			if ((1<<i) & av)
+				return node->perms[i];
+
+	errno = EINVAL;
+	return NULL;
+}
+
 int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 {
 	unsigned int i = 0;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
