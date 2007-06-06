Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56JCY7p029026
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 15:12:34 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l56JCVMB007649
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 19:12:31 GMT
Subject: [PATCH 2/5] libselinux: add object class discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 15:11:04 -0400
Message-Id: <1181157064.6578.37.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add object class discovery and caching of class and permission values.  When
the value of an object class is looked up, all the permission values are also
looked up and cached.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

---
 libselinux/src/stringrep.c |  162 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

Index: selinux-obj-class-discovery/libselinux/src/stringrep.c
===================================================================
--- selinux-obj-class-discovery.orig/libselinux/src/stringrep.c
+++ selinux-obj-class-discovery/libselinux/src/stringrep.c
@@ -1,6 +1,11 @@
 /*
  * String representation support for classes and permissions.
  */
+#include <sys/stat.h>
+#include <dirent.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <unistd.h>
 #include <errno.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -11,6 +16,7 @@
 #include <selinux/flask.h>
 #include <selinux/av_permissions.h>
 #include "selinux_internal.h"
+#include "policy.h"
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
@@ -143,6 +149,162 @@ static const struct av_inherit {
 
 #define NCLASSES ARRAY_SIZE(class_to_string)
 #define NVECTORS ARRAY_SIZE(av_perm_to_string)
+#define MAXVECTORS 8*sizeof(access_vector_t)
+
+struct discover_class_node {
+	char *name;
+	security_class_t value;
+	char **perms;
+
+	struct discover_class_node *next;
+};
+
+static struct discover_class_node *discover_class_cache = NULL;
+
+static struct discover_class_node * get_class_cache_entry_name(const char *s)
+{
+	struct discover_class_node *node = discover_class_cache;
+
+	for (; node != NULL && strcmp(s,node->name) != 0; node = node->next);
+
+	return node;
+}
+
+static struct discover_class_node * get_class_cache_entry_value(security_class_t c)
+{
+	struct discover_class_node *node = discover_class_cache;
+
+	for (; node != NULL && c != node->value; node = node->next);
+
+	return node;
+}
+
+static struct discover_class_node * discover_class(const char *s)
+{
+	int fd, ret;
+	char path[PATH_MAX];
+	char buf[20];
+	DIR *dir;
+	struct dirent *dentry;
+	size_t i;
+
+	struct discover_class_node *node;
+
+	if (!selinux_mnt) {
+		errno = ENOENT;
+		return NULL;
+	}
+
+	/* allocate a node */
+	node = malloc(sizeof(struct discover_class_node));
+	if (node == NULL)
+		return NULL;
+
+	/* allocate array for perms */
+	node->perms = calloc(NVECTORS,sizeof(char*));
+	if (node->perms == NULL)
+		goto err1;
+
+	/* load up the name */
+	node->name = strdup(s);
+	if (node->name == NULL)
+		goto err2;
+
+	/* load up class index */
+	snprintf(path, sizeof path, "%s/class/%s/index", selinux_mnt,s);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		goto err3;
+
+	memset(buf, 0, sizeof(buf));
+	ret = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (ret < 0)
+		goto err3;
+
+	if (sscanf(buf, "%u", (unsigned int*)&node->value) != 1)
+		goto err3;
+
+	/* load up permission indicies */
+	snprintf(path, sizeof path, "%s/class/%s/perms",selinux_mnt,s);
+	dir = opendir(path);
+	if (dir == NULL)
+		goto err3;
+
+	dentry = readdir(dir);
+	while (dentry != NULL) {
+		size_t value;
+		struct stat m;
+
+		snprintf(path, sizeof path, "%s/class/%s/perms/%s", selinux_mnt,s,dentry->d_name);
+		if (stat(path,&m) < 0)
+			goto err4;
+
+		if (m.st_mode & S_IFDIR) {
+			dentry = readdir(dir);
+			continue;
+		}
+
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			goto err4;
+
+		memset(buf, 0, sizeof(buf));
+		ret = read(fd, buf, sizeof(buf) - 1);
+		close(fd);
+		if (ret < 0)
+			goto err4;
+
+		if (sscanf(buf, "%u", (unsigned int *)&value) != 1)
+			goto err4;
+
+		node->perms[value-1] = strdup(dentry->d_name);
+		if (node->perms[value-1] == NULL)
+			goto err4;
+
+		dentry = readdir(dir);
+	}
+	closedir(dir);
+
+	node->next = discover_class_cache;
+	discover_class_cache = node;
+
+	return node;
+
+err4:
+	closedir(dir);
+	for (i=0; i<NVECTORS; i++)
+		free(node->perms[i]);
+err3:
+	free(node->name);
+err2:
+	free(node->perms);
+err1:
+	free(node);
+	return NULL;
+}
+
+void flush_class_cache(void)
+{
+	struct discover_class_node *cur = discover_class_cache, *prev = NULL;
+	size_t i;
+
+	while (cur != NULL) {
+		free(cur->name);
+
+		for (i=0 ; i<MAXVECTORS ; i++)
+			free(cur->perms[i]);
+
+		free(cur->perms);
+
+		prev = cur;
+		cur = cur->next;
+
+		free(prev);
+	}
+
+	discover_class_cache = NULL;
+}
 
 static security_class_t string_to_security_class_compat(const char *s)
 {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
