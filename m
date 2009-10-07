Message-ID: <4ACCE820.4080007@tycho.nsa.gov>
Date: Wed, 07 Oct 2009 15:12:32 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: raw string_to_class/string_to_av_perm variants
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the first patch in a series to add dynamic class and permission 
remapping support.  The kernel has recently gained support for such 
remapping, where the class and permission values exposed in 
/selinux/class may change on policy reload.  Hence libselinux must do 
its own remapping in response to policy reloads.

This patch adds internal "raw" variants of string_to_security_class() 
and string_to_av_perm().  These are used by the mapping code when 
setting up a new mapping.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

  mapping.h   |   11 +++++++++++
  stringrep.c |   21 +++++++++++++++------
  2 files changed, 26 insertions(+), 6 deletions(-)


diff --git a/libselinux/src/mapping.h b/libselinux/src/mapping.h
index b96756b..b9e9c44 100644
--- a/libselinux/src/mapping.h
+++ b/libselinux/src/mapping.h
@@ -7,6 +7,17 @@
  #define _SELINUX_MAPPING_H_

  #include<selinux/selinux.h>
+#include "dso.h"
+
+/*
+ * Raw stringrep functions
+ */
+
+extern security_class_t
+string_to_security_class_raw(const char *s) hidden;
+
+extern access_vector_t
+string_to_av_perm_raw(security_class_t kclass, const char *s) hidden;

  /*
   * Get real, kernel values from mapped values
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index b19bce7..c82d07a 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -434,7 +434,7 @@ static const char *security_av_perm_to_string_compat(security_class_t tclass,
  	return NULL;
  }

-security_class_t string_to_security_class(const char *s)
+security_class_t string_to_security_class_raw(const char *s)
  {
  	struct discover_class_node *node;

@@ -453,31 +453,40 @@ security_class_t string_to_security_class(const char *s)
  		}
  	}

-	return map_class(node->value);
+	return node->value;
  }

-access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
+security_class_t string_to_security_class(const char *s)
+{
+	return map_class(string_to_security_class_raw(s));
+}
+
+access_vector_t string_to_av_perm_raw(security_class_t kclass, const char *s)
  {
  	struct discover_class_node *node;
-	security_class_t kclass = unmap_class(tclass);

  	__selinux_once(once, init_obj_class_compat);

  	if (obj_class_compat)
-		return map_perm(tclass, string_to_av_perm_compat(kclass, s));
+		return string_to_av_perm_compat(kclass, s);

  	node = get_class_cache_entry_value(kclass);
  	if (node != NULL) {
  		size_t i;
  		for (i=0; i<MAXVECTORS&&  node->perms[i] != NULL; i++)
  			if (strcmp(node->perms[i],s) == 0)
-				return map_perm(tclass, 1<<i);
+				return 1<<i;
  	}

  	errno = EINVAL;
  	return 0;
  }

+access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
+{
+	return map_perm(tclass, string_to_av_perm_raw(map_class(tclass), s));
+}
+
  const char *security_class_to_string(security_class_t tclass)
  {
  	struct discover_class_node *node;


-- 
Eamon Walsh<ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
