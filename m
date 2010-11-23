From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/4] selinux: convert type_val_to_struct to flex_array
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Tue, 23 Nov 2010 11:52:33 -0500
Message-ID: <20101123165233.4489.32957.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101123165227.4489.29282.stgit@paris.rdu.redhat.com>
References: <20101123165227.4489.29282.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In rawhide type_val_to_struct will allocate 26848 bytes, an order 3
allocations.  While this hasn't been seen to fail it isn't outside the
realm of possibiliy on systems with severe memory fragmentation.  Convert
to flex_array so no allocation will ever be bigger than PAGE_SIZE.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |   28 +++++++++++++++++++++-------
 security/selinux/ss/policydb.h |    2 +-
 security/selinux/ss/services.c |   17 ++++++++++++-----
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 6ad73e8..af41fdf 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -307,7 +307,11 @@ static int type_index(void *key, void *datum, void *datap)
 		    || typdatum->bounds > p->p_types.nprim)
 			return -EINVAL;
 		p->p_type_val_to_name[typdatum->value - 1] = key;
-		p->type_val_to_struct[typdatum->value - 1] = typdatum;
+		/* this flex array was all preallocated, this cannot fail */
+		if (flex_array_put_ptr(p->type_val_to_struct_array,
+				       typdatum->value - 1, typdatum,
+				       GFP_KERNEL | __GFP_ZERO))
+			BUG();
 	}
 
 	return 0;
@@ -484,11 +488,17 @@ static int policydb_index_others(struct policydb *p)
 	if (!p->user_val_to_struct)
 		goto out;
 
+	/* Yes, I want the sizeof the pointer, not the structure */
 	rc = -ENOMEM;
-	p->type_val_to_struct =
-		kmalloc(p->p_types.nprim * sizeof(*(p->type_val_to_struct)),
-			GFP_KERNEL);
-	if (!p->type_val_to_struct)
+	p->type_val_to_struct_array = flex_array_alloc(sizeof(struct type_datum *),
+						       p->p_types.nprim,
+						       GFP_KERNEL | __GFP_ZERO);
+	if (!p->type_val_to_struct_array)
+		goto out;
+
+	rc = flex_array_prealloc(p->type_val_to_struct_array, 0,
+				 p->p_types.nprim - 1, GFP_KERNEL | __GFP_ZERO);
+	if (rc)
 		goto out;
 
 	rc = -ENOMEM;
@@ -699,7 +709,8 @@ void policydb_destroy(struct policydb *p)
 	kfree(p->class_val_to_struct);
 	kfree(p->role_val_to_struct);
 	kfree(p->user_val_to_struct);
-	kfree(p->type_val_to_struct);
+	if (p->type_val_to_struct_array)
+		flex_array_free(p->type_val_to_struct_array);
 
 	avtab_destroy(&p->te_avtab);
 
@@ -1618,7 +1629,10 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 			return -EINVAL;
 		}
 
-		upper = p->type_val_to_struct[upper->bounds - 1];
+		upper = flex_array_get_ptr(p->type_val_to_struct_array,
+					   upper->bounds - 1);
+		BUG_ON(!upper);
+
 		if (upper->attribute) {
 			printk(KERN_ERR "SELinux: type %s: "
 			       "bounded by attribute %s",
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 95d3d7d..9826a92 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -217,7 +217,7 @@ struct policydb {
 	struct class_datum **class_val_to_struct;
 	struct role_datum **role_val_to_struct;
 	struct user_datum **user_val_to_struct;
-	struct type_datum **type_val_to_struct;
+	struct flex_array *type_val_to_struct_array;
 
 	/* type enforcement access vectors and transitions */
 	struct avtab te_avtab;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ab6dbce..afcbc19 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -530,12 +530,18 @@ static void type_attribute_bounds_av(struct context *scontext,
 	struct context lo_scontext;
 	struct context lo_tcontext;
 	struct av_decision lo_avd;
-	struct type_datum *source
-		= policydb.type_val_to_struct[scontext->type - 1];
-	struct type_datum *target
-		= policydb.type_val_to_struct[tcontext->type - 1];
+	struct type_datum *source;
+	struct type_datum *target;
 	u32 masked = 0;
 
+	source = flex_array_get_ptr(policydb.type_val_to_struct_array,
+				    scontext->type - 1);
+	BUG_ON(!source);
+
+	target = flex_array_get_ptr(policydb.type_val_to_struct_array,
+				    tcontext->type - 1);
+	BUG_ON(!target);
+
 	if (source->bounds) {
 		memset(&lo_avd, 0, sizeof(lo_avd));
 
@@ -828,7 +834,8 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 
 	index = new_context->type;
 	while (true) {
-		type = policydb.type_val_to_struct[index - 1];
+		type = flex_array_get_ptr(policydb.type_val_to_struct_array,
+					  index - 1);
 		BUG_ON(!type);
 
 		/* not bounded anymore */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
