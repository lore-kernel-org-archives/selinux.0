Subject: [PATCH] SELinux: shrink sizeof av_inhert selinux_class_perm and
 context
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Fri, 02 Jan 2009 17:40:06 -0500
Message-Id: <1230936006.8510.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I started playing with pahole today and decided to put it against the
selinux structures.  Found we could save a little bit of space on x86_64
(and no harm on i686) just reorganizing some structs.

Object size changes:
av_inherit: 24 -> 16
selinux_class_perm: 48 -> 40
context: 80 -> 72

Admittedly there aren't many of av_inherit or selinux_class_perm's in
the kernel (33 and 1 respectively) But the change to the size of struct
context reverberate out a bit.  I can get some hard number if they are
needed, but I don't see why they would be.  We do change which cacheline
context->len and context->str would be on, but I don't see that as a
problem since we are clearly going to have to load both if the context
is to be of any value.  I've run with the patch and don't seem to be
having any problems.

An example of what's going on using struct av_inherit would be:

form: to: 
struct av_inherit {			struct av_inherit {
	u16 tclass;				const char **common_pts;
	const char **common_pts;		u32 common_base;
	u32 common_base;			u16 tclass;
};

(notice all I did was move u16 tclass to the end of the struct instead
of the beginning)

Memory layout before the change:
struct av_inherit {
	u16 tclass; /* 2 */
	/* 6 bytes hole */
	const char** common_pts; /* 8 */
	u32 common_base; /* 4 */
	/* 4 byes padding */

	/* size: 24, cachelines: 1 */
	/* sum members: 14, holes: 1, sum holes: 6 */
	/* padding: 4 */
};

Memory layout after the change:
struct av_inherit {
	const char ** common_pts; /* 8 */
	u32 common_base; /* 4 */
	u16 tclass; /* 2 */
	/* 2 bytes padding */

	/* size: 16, cachelines: 1 */
	/* sum members: 14, holes: 0, sum holes: 0 */
	/* padding: 2 */
};

Signed-off-by: Eric Paris <eparis@redhat.com>

---

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d43bd6b..eb41f43 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -53,18 +53,20 @@ static const char *class_to_string[] = {
 #undef S_
 
 static const struct av_inherit av_inherit[] = {
-#define S_(c, i, b) { c, common_##i##_perm_to_string, b },
+#define S_(c, i, b) {	.tclass = c,\
+			.common_pts = common_##i##_perm_to_string,\
+			.common_base =  b },
 #include "av_inherit.h"
 #undef S_
 };
 
 const struct selinux_class_perm selinux_class_perm = {
-	av_perm_to_string,
-	ARRAY_SIZE(av_perm_to_string),
-	class_to_string,
-	ARRAY_SIZE(class_to_string),
-	av_inherit,
-	ARRAY_SIZE(av_inherit)
+	.av_perm_to_string = av_perm_to_string,
+	.av_pts_len = ARRAY_SIZE(av_perm_to_string),
+	.class_to_string = class_to_string,
+	.cts_len = ARRAY_SIZE(class_to_string),
+	.av_inherit = av_inherit,
+	.av_inherit_len = ARRAY_SIZE(av_inherit)
 };
 
 #define AVC_CACHE_SLOTS			512
diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index c0d314d..bb1ec80 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -17,16 +17,16 @@ struct av_perm_to_string {
 };
 
 struct av_inherit {
-	u16 tclass;
 	const char **common_pts;
 	u32 common_base;
+	u16 tclass;
 };
 
 struct selinux_class_perm {
 	const struct av_perm_to_string *av_perm_to_string;
 	u32 av_pts_len;
-	const char **class_to_string;
 	u32 cts_len;
+	const char **class_to_string;
 	const struct av_inherit *av_inherit;
 	u32 av_inherit_len;
 };
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 658c2bd..d9dd7a2 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -27,9 +27,9 @@ struct context {
 	u32 user;
 	u32 role;
 	u32 type;
+	u32 len;        /* length of string in bytes */
 	struct mls_range range;
 	char *str;	/* string representation if context cannot be mapped. */
-	u32 len;        /* length of string in bytes */
 };
 
 static inline void mls_context_init(struct context *c)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
