Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56JD2he029089
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 15:13:02 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l56JCuXZ010950
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 19:12:57 GMT
Subject: [PATCH 3/5] libselinux: add string<->value functions that use
	discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 15:11:30 -0400
Message-Id: <1181157090.6578.38.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add new value->name, name->value functions that use object class discovery.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

---
 libselinux/src/stringrep.c |   56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

Index: selinux-obj-class-discovery/libselinux/src/stringrep.c
===================================================================
--- selinux-obj-class-discovery.orig/libselinux/src/stringrep.c
+++ selinux-obj-class-discovery/libselinux/src/stringrep.c
@@ -407,6 +407,62 @@ static const char *security_av_perm_to_s
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
+		if (node == NULL)
+			return 0;
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
+	return 0;
+}
+
+const char *security_class_to_string(security_class_t tclass)
+{
+	struct discover_class_node *node;
+
+	node = get_class_cache_entry_value(tclass);
+	if (node == NULL)
+		return NULL;
+	else
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
