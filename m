Subject: [PATCH 3/5] libselinux: security_class_to_string helper function
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
In-Reply-To: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-Kxal/bUxdklqpi3CKMFq"
Date: Thu, 16 Nov 2006 16:54:10 -0500
Message-Id: <1163714050.15225.134.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Kxal/bUxdklqpi3CKMFq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

A new helper function that converts from class value to class name.  

Note that this patch and further patches will apply with -p0 to the
selinux directory, while the two previous patches apply with -p0 to
selinux/libselinux.

---
 libselinux/include/selinux/selinux.h |    3 ++-
 libselinux/src/avc.c                 |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-Kxal/bUxdklqpi3CKMFq
Content-Description: 
Content-Disposition: inline; filename=label3.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2092)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -277,8 +277,9 @@
 
 /* Common helpers */
 
-/* Return the security class value for a given class name. */
+/* Convert between security class values and string class names */
 	extern security_class_t string_to_security_class(const char *name);
+	extern const char *security_class_to_string(security_class_t cls);
 
 /* Return an access vector for a given class and permission name. */
 	extern access_vector_t string_to_av_perm(security_class_t tclass,
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2092)
+++ libselinux/src/avc.c	(working copy)
@@ -149,6 +149,14 @@
 #undef S_
 };
 
+#define CLASS_UPPER_BOUND (sizeof(class_to_string)/sizeof(u16))
+
+const char *security_class_to_string(security_class_t cls)
+{
+	cls = (cls > 0 && cls < CLASS_UPPER_BOUND) ? cls : 0;
+	return class_to_string_data.str + class_to_string[cls];
+}
+
 #define AVC_CACHE_SLOTS		512
 #define AVC_CACHE_MAXNODES	410
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

--=-Kxal/bUxdklqpi3CKMFq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
