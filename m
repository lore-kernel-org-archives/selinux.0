From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] selinux: convert type_val_to_struct to flex_array
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Tue, 03 Aug 2010 15:44:52 -0400
Message-ID: <20100803194452.22236.49318.stgit@paris.rdu.redhat.com>
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
index 4ca9b5c..b7ef93e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -297,7 +297,11 @@ static int type_index(void *key, void *datum, void *datap)
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
@@ -474,11 +478,17 @@ static int policydb_index_others(struct policydb *p)
 	if (!p->user_val_to_struct)
 		goto out;
 
+	/* Yes, I want the sizeof the pointer, not the structure */
 	rc = -ENOMEM;
-	p->type_val_to_struct =
-		kmalloc(p->p_types.nprim * sizeof(*(p->type_val_to_struct)),
-			GFP_KERNEL);
-	if (!p->type_val_to_struct)
+	p->type_val_to_struct_array = flex_array_alloc(sizeof(struct type_dataum *),
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
@@ -689,7 +699,8 @@ void policydb_destroy(struct policydb *p)
 	kfree(p->class_val_to_struct);
 	kfree(p->role_val_to_struct);
 	kfree(p->user_val_to_struct);
-	kfree(p->type_val_to_struct);
+	if (p->type_val_to_struct_array)
+		flex_array_free(p->type_val_to_struct_array);
 
 	avtab_destroy(&p->te_avtab);
 
@@ -1608,7 +1619,10 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
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
index a1cf46e..060ae71 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -529,12 +529,18 @@ static void type_attribute_bounds_av(struct context *scontext,
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
 
@@ -827,7 +833,8 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 
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
