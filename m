Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU4FWih012379
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:15:32 -0500
Received: from facesaver.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAU4DntE021534
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 04:13:49 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU4AQnV015081
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:10:26 -0500
Subject: [PATCH 3/5] libselinux: class and av_perm to string functions
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
In-Reply-To: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-tK4ZaXzdRtKkxgWhyGmk"
Date: Wed, 29 Nov 2006 23:15:31 -0500
Message-Id: <1164860131.2794.210.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tK4ZaXzdRtKkxgWhyGmk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New helper functions to convert from class and av_permission values to
string representations.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

---
 libselinux/include/selinux/selinux.h |   12 +-
 libselinux/src/avc.c                 |   99 +++++++++++++++++++
 2 files changed, 109 insertions(+), 2 deletions(-)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-tK4ZaXzdRtKkxgWhyGmk
Content-Disposition: attachment; filename=label3.patch
Content-Type: text/x-patch; name=label3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2116)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -277,13 +277,21 @@
 
 /* Common helpers */
 
-/* Return the security class value for a given class name. */
+/* Convert between security class values and string names */
 	extern security_class_t string_to_security_class(const char *name);
+	extern const char *security_class_to_string(security_class_t cls);
 
-/* Return an access vector for a given class and permission name. */
+/* Convert between individual access vector permissions and string names */
+	extern const char *security_av_perm_to_string(security_class_t tclass,
+						      access_vector_t perm);
 	extern access_vector_t string_to_av_perm(security_class_t tclass,
 						 const char *name);
 
+/* Returns an access vector in a string representation.  User must free the
+ * returned string via free(). */
+	extern int security_av_string(security_class_t tclass,
+				      access_vector_t av, char **result);
+
 /* Display an access vector in a string representation. */
 	extern void print_access_vector(security_class_t tclass,
 					access_vector_t av);
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2116)
+++ libselinux/src/avc.c	(working copy)
@@ -1338,6 +1338,105 @@
 	return 0;
 }
 
+const char *security_class_to_string(security_class_t tclass)
+{
+	tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
+	return class_to_string_data.str + class_to_string[tclass];
+}
+
+const char *security_av_perm_to_string(security_class_t tclass,
+				       access_vector_t av)
+{
+	const u16 *common_pts_idx = 0;
+	access_vector_t common_base = 0;
+	unsigned int i;
+
+	if (!av)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
+		if (av_inherit[i].tclass == tclass) {
+			common_pts_idx =
+			    &common_perm_to_string.data[av_inherit[i].
+							common_pts_idx];
+			common_base = av_inherit[i].common_base;
+			break;
+		}
+	}
+
+	if (av < common_base) {
+		i = 0;
+		while (!(av & 1)) {
+			av >>= 1;
+			i++;
+		}
+		return common_perm_to_string_data.str + common_pts_idx[i];
+	}
+
+	for (i = 0; i < NVECTORS; i++) {
+		if (av_perm_to_string[i].tclass == tclass &&
+		    av_perm_to_string[i].value == av)
+			return av_perm_to_string_data.str
+				+ av_perm_to_string[i].nameidx;
+	}
+
+	return NULL;
+}
+
+int security_av_string(security_class_t tclass, access_vector_t av, char **res)
+{
+	unsigned int i = 0;
+	size_t len = 5;
+	access_vector_t tmp = av;
+	int rc = 0;
+	const char *str;
+	char *ptr;
+
+	/* first pass computes the required length */
+	while (tmp) {
+		if (tmp & 1) {
+			str = security_av_perm_to_string(tclass, av & (1<<i));
+			if (str)
+				len += strlen(str) + 1;
+			else {
+				rc = -1;
+				errno = EINVAL;
+				goto out;
+			}
+		}
+		tmp >>= 1;
+		i++;
+	}
+
+	*res = malloc(len);
+	if (!*res) {
+		rc = -1;
+		goto out;
+	}
+
+	/* second pass constructs the string */
+	i = 0;
+	tmp = av;
+	ptr = *res;
+
+	if (!av) {
+		sprintf(ptr, "null");
+		goto out;
+	}
+
+	ptr += sprintf(ptr, "{ ");
+	while (tmp) {
+		if (tmp & 1)
+			ptr += sprintf(ptr, "%s ", security_av_perm_to_string(
+					       tclass, av & (1<<i)));
+		tmp >>= 1;
+		i++;
+	}
+	sprintf(ptr, "}");
+out:
+	return rc;
+}
+
 void print_access_vector(security_class_t tclass, access_vector_t av)
 {
 	const u16 *common_pts_idx = 0;

--=-tK4ZaXzdRtKkxgWhyGmk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
