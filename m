Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UHV8Kb027198
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:31:08 -0400
Received: from facesaver.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UHV8nf009411
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 17:31:08 GMT
Received: from [144.51.25.7] (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id l2UHV7a4009836
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:31:08 -0400
Message-ID: <460D495B.3060000@tycho.nsa.gov>
Date: Fri, 30 Mar 2007 13:31:07 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libselinux: string and compute_create functions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some new interfaces for libselinux, supporting userspace object managers:

1. class,av to string functions, completing the set.

2. "avc_compute_create" convenience interface to security_compute_create,
taking userspace AVC SID's instead of security context strings.

3. man pages for these.



--
 include/selinux/selinux.h |   12 ++++-
 src/avc.c                 |   99 
++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 2 deletions(-)

--
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c    (revision 2307)
+++ libselinux/src/avc.c    (working copy)
@@ -1338,6 +1338,105 @@
     return 0;
 }
 
+const char *security_class_to_string(security_class_t tclass)
+{
+    tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
+    return class_to_string_data.str + class_to_string[tclass];
+}
+
+const char *security_av_perm_to_string(security_class_t tclass,
+                       access_vector_t av)
+{
+    const uint16_t *common_pts_idx = 0;
+    access_vector_t common_base = 0;
+    unsigned int i;
+
+    if (!av)
+        return NULL;
+
+    for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
+        if (av_inherit[i].tclass == tclass) {
+            common_pts_idx =
+                &common_perm_to_string.data[av_inherit[i].
+                            common_pts_idx];
+            common_base = av_inherit[i].common_base;
+            break;
+        }
+    }
+
+    if (av < common_base) {
+        i = 0;
+        while (!(av & 1)) {
+            av >>= 1;
+            i++;
+        }
+        return common_perm_to_string_data.str + common_pts_idx[i];
+    }
+
+    for (i = 0; i < NVECTORS; i++) {
+        if (av_perm_to_string[i].tclass == tclass &&
+            av_perm_to_string[i].value == av)
+            return av_perm_to_string_data.str
+                + av_perm_to_string[i].nameidx;
+    }
+
+    return NULL;
+}
+
+int security_av_string(security_class_t tclass, access_vector_t av, 
char **res)
+{
+    unsigned int i = 0;
+    size_t len = 5;
+    access_vector_t tmp = av;
+    int rc = 0;
+    const char *str;
+    char *ptr;
+
+    /* first pass computes the required length */
+    while (tmp) {
+        if (tmp & 1) {
+            str = security_av_perm_to_string(tclass, av & (1<<i));
+            if (str)
+                len += strlen(str) + 1;
+            else {
+                rc = -1;
+                errno = EINVAL;
+                goto out;
+            }
+        }
+        tmp >>= 1;
+        i++;
+    }
+
+    *res = malloc(len);
+    if (!*res) {
+        rc = -1;
+        goto out;
+    }
+
+    /* second pass constructs the string */
+    i = 0;
+    tmp = av;
+    ptr = *res;
+
+    if (!av) {
+        sprintf(ptr, "null");
+        goto out;
+    }
+
+    ptr += sprintf(ptr, "{ ");
+    while (tmp) {
+        if (tmp & 1)
+            ptr += sprintf(ptr, "%s ", security_av_perm_to_string(
+                           tclass, av & (1<<i)));
+        tmp >>= 1;
+        i++;
+    }
+    sprintf(ptr, "}");
+out:
+    return rc;
+}
+
 void print_access_vector(security_class_t tclass, access_vector_t av)
 {
     const uint16_t *common_pts_idx = 0;
Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h    (revision 2307)
+++ libselinux/include/selinux/selinux.h    (working copy)
@@ -277,13 +277,21 @@
 
 /* Common helpers */
 
-/* Return the security class value for a given class name. */
+/* Convert between security class values and string names */
     extern security_class_t string_to_security_class(const char *name);
+    extern const char *security_class_to_string(security_class_t cls);
 
-/* Return an access vector for a given class and permission name. */
+/* Convert between individual access vector permissions and string names */
+    extern const char *security_av_perm_to_string(security_class_t tclass,
+                              access_vector_t perm);
     extern access_vector_t string_to_av_perm(security_class_t tclass,
                          const char *name);
 
+/* Returns an access vector in a string representation.  User must free the
+ * returned string via free(). */
+    extern int security_av_string(security_class_t tclass,
+                      access_vector_t av, char **result);
+
 /* Display an access vector in a string representation. */
     extern void print_access_vector(security_class_t tclass,
                     access_vector_t av);

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
