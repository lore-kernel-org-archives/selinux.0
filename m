Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t95KfAff000795
 for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2015 16:41:16 -0400
Subject: [RFC PATCH v2 1/5] kdbus: add creator credentials to the endpoints
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov
Date: Mon, 05 Oct 2015 16:41:12 -0400
Message-ID: <20151005204112.32023.67760.stgit@localhost>
In-Reply-To: <20151005203358.32023.88592.stgit@localhost>
References: <20151005203358.32023.88592.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In order to effectively enforce LSM based access controls we need to
have more information about the kdbus endpoint creator than the
uid/gid currently stored in the kdbus_node_type struct.  This patch
replaces the uid/gid values with a reference to the node creator's
credential struct which serves the needs of both the kdbus DAC access
controls as well as the LSM's access controls.

Two macros have also been created, kdbus_node_[uid,gid](), which can
be used to easily extract the euid/egid information from the new
credential reference.  The effective uid/gid is used as it was used
in all areas of the previous kdbus code except for areas where the
uid/gid was never set beyond the basic initialization to zero/root;
I expect this was a bug that was never caught as the node creator in
these cases was always expect to be root.

Signed-off-by: Paul Moore <pmoore@redhat.com>

---
ChangeLog:
- v2
 * Initial draft
---
 ipc/kdbus/bus.c      |   13 +++++--------
 ipc/kdbus/endpoint.c |   14 ++++----------
 ipc/kdbus/endpoint.h |    3 +--
 ipc/kdbus/fs.c       |    4 ++--
 ipc/kdbus/node.c     |   11 ++++-------
 ipc/kdbus/node.h     |    5 +++--
 6 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/ipc/kdbus/bus.c b/ipc/kdbus/bus.c
index a67f825..0cb9501 100644
--- a/ipc/kdbus/bus.c
+++ b/ipc/kdbus/bus.c
@@ -65,8 +65,7 @@ static void kdbus_bus_release(struct kdbus_node *node, bool was_active)
 static struct kdbus_bus *kdbus_bus_new(struct kdbus_domain *domain,
 				       const char *name,
 				       struct kdbus_bloom_parameter *bloom,
-				       const u64 *pattach_owner,
-				       u64 flags, kuid_t uid, kgid_t gid)
+				       const u64 *pattach_owner, u64 flags)
 {
 	struct kdbus_bus *b;
 	u64 attach_owner;
@@ -81,7 +80,8 @@ static struct kdbus_bus *kdbus_bus_new(struct kdbus_domain *domain,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	ret = kdbus_verify_uid_prefix(name, domain->user_namespace, uid);
+	ret = kdbus_verify_uid_prefix(name, domain->user_namespace,
+				      current_euid());
 	if (ret < 0)
 		return ERR_PTR(ret);
 
@@ -93,8 +93,6 @@ static struct kdbus_bus *kdbus_bus_new(struct kdbus_domain *domain,
 
 	b->node.free_cb = kdbus_bus_free;
 	b->node.release_cb = kdbus_bus_release;
-	b->node.uid = uid;
-	b->node.gid = gid;
 	b->node.mode = S_IRUSR | S_IXUSR;
 
 	if (flags & (KDBUS_MAKE_ACCESS_GROUP | KDBUS_MAKE_ACCESS_WORLD))
@@ -374,7 +372,7 @@ struct kdbus_bus *kdbus_cmd_bus_make(struct kdbus_domain *domain,
 	bus = kdbus_bus_new(domain,
 			    argv[1].item->str, &argv[2].item->bloom_parameter,
 			    argv[3].item ? argv[3].item->data64 : NULL,
-			    cmd->flags, current_euid(), current_egid());
+			    cmd->flags);
 	if (IS_ERR(bus)) {
 		ret = PTR_ERR(bus);
 		bus = NULL;
@@ -393,8 +391,7 @@ struct kdbus_bus *kdbus_cmd_bus_make(struct kdbus_domain *domain,
 		goto exit;
 	}
 
-	ep = kdbus_ep_new(bus, "bus", cmd->flags, bus->node.uid, bus->node.gid,
-			  false);
+	ep = kdbus_ep_new(bus, "bus", cmd->flags, false);
 	if (IS_ERR(ep)) {
 		ret = PTR_ERR(ep);
 		ep = NULL;
diff --git a/ipc/kdbus/endpoint.c b/ipc/kdbus/endpoint.c
index 44e7a20..1ba5d51 100644
--- a/ipc/kdbus/endpoint.c
+++ b/ipc/kdbus/endpoint.c
@@ -74,8 +74,6 @@ static void kdbus_ep_release(struct kdbus_node *node, bool was_active)
  * @bus:		The bus this endpoint will be created for
  * @name:		The name of the endpoint
  * @access:		The access flags for this node (KDBUS_MAKE_ACCESS_*)
- * @uid:		The uid of the node
- * @gid:		The gid of the node
  * @is_custom:		Whether this is a custom endpoint
  *
  * This function will create a new endpoint with the given
@@ -84,8 +82,7 @@ static void kdbus_ep_release(struct kdbus_node *node, bool was_active)
  * Return: a new kdbus_ep on success, ERR_PTR on failure.
  */
 struct kdbus_ep *kdbus_ep_new(struct kdbus_bus *bus, const char *name,
-			      unsigned int access, kuid_t uid, kgid_t gid,
-			      bool is_custom)
+			      unsigned int access, bool is_custom)
 {
 	struct kdbus_ep *e;
 	int ret;
@@ -96,7 +93,7 @@ struct kdbus_ep *kdbus_ep_new(struct kdbus_bus *bus, const char *name,
 	 */
 	if (is_custom) {
 		ret = kdbus_verify_uid_prefix(name, bus->domain->user_namespace,
-					      uid);
+					      current_euid());
 		if (ret < 0)
 			return ERR_PTR(ret);
 	}
@@ -109,8 +106,6 @@ struct kdbus_ep *kdbus_ep_new(struct kdbus_bus *bus, const char *name,
 
 	e->node.free_cb = kdbus_ep_free;
 	e->node.release_cb = kdbus_ep_release;
-	e->node.uid = uid;
-	e->node.gid = gid;
 	e->node.mode = S_IRUSR | S_IWUSR;
 	if (access & (KDBUS_MAKE_ACCESS_GROUP | KDBUS_MAKE_ACCESS_WORLD))
 		e->node.mode |= S_IRGRP | S_IWGRP;
@@ -207,7 +202,7 @@ bool kdbus_ep_is_privileged(struct kdbus_ep *ep, struct file *file)
 bool kdbus_ep_is_owner(struct kdbus_ep *ep, struct file *file)
 {
 	return !ep->user &&
-		(uid_eq(file->f_cred->euid, ep->bus->node.uid) ||
+		(uid_eq(file->f_cred->euid, kdbus_node_uid(&ep->bus->node)) ||
 		 kdbus_ep_is_privileged(ep, file));
 }
 
@@ -245,8 +240,7 @@ struct kdbus_ep *kdbus_cmd_ep_make(struct kdbus_bus *bus, void __user *argp)
 
 	item_make_name = argv[1].item->str;
 
-	ep = kdbus_ep_new(bus, item_make_name, cmd->flags,
-			  current_euid(), current_egid(), true);
+	ep = kdbus_ep_new(bus, item_make_name, cmd->flags, true);
 	if (IS_ERR(ep)) {
 		ret = PTR_ERR(ep);
 		ep = NULL;
diff --git a/ipc/kdbus/endpoint.h b/ipc/kdbus/endpoint.h
index e0da59f..c537779 100644
--- a/ipc/kdbus/endpoint.h
+++ b/ipc/kdbus/endpoint.h
@@ -56,8 +56,7 @@ struct kdbus_ep {
 	container_of((_node), struct kdbus_ep, node)
 
 struct kdbus_ep *kdbus_ep_new(struct kdbus_bus *bus, const char *name,
-			      unsigned int access, kuid_t uid, kgid_t gid,
-			      bool policy);
+			      unsigned int access, bool policy);
 struct kdbus_ep *kdbus_ep_ref(struct kdbus_ep *ep);
 struct kdbus_ep *kdbus_ep_unref(struct kdbus_ep *ep);
 
diff --git a/ipc/kdbus/fs.c b/ipc/kdbus/fs.c
index 09c4809..68818a8 100644
--- a/ipc/kdbus/fs.c
+++ b/ipc/kdbus/fs.c
@@ -204,8 +204,8 @@ static struct inode *fs_inode_get(struct super_block *sb,
 	inode->i_mapping->a_ops = &empty_aops;
 	inode->i_mode = node->mode & S_IALLUGO;
 	inode->i_atime = inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	inode->i_uid = node->uid;
-	inode->i_gid = node->gid;
+	inode->i_uid = kdbus_node_uid(node);
+	inode->i_gid = kdbus_node_gid(node);
 
 	switch (node->type) {
 	case KDBUS_NODE_DOMAIN:
diff --git a/ipc/kdbus/node.c b/ipc/kdbus/node.c
index 89f58bc..cd0c1a0 100644
--- a/ipc/kdbus/node.c
+++ b/ipc/kdbus/node.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/cred.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/kdev_t.h>
@@ -170,13 +171,7 @@
  *                         node initialization. They must remain constant. If
  *                         NULL, they're skipped.
  *
- *     * node->mode: filesystem access modes
- *       node->uid:  filesystem owner uid
- *       node->gid:  filesystem owner gid
- *                   These fields must be set by the node owner during node
- *                   initialization. They must remain constant and may be
- *                   accessed by other callers to properly initialize
- *                   filesystem nodes.
+ *     * node->creds: The credentials of the node's creator
  *
  *     * node->id: This is an unsigned 32bit integer allocated by an IDA. It is
  *                 always kept as small as possible during allocation and is
@@ -293,6 +288,7 @@ void kdbus_node_init(struct kdbus_node *node, unsigned int type)
 	mutex_init(&node->lock);
 	node->id = 0;
 	node->type = type;
+	node->creds = get_current_cred();
 	RB_CLEAR_NODE(&node->rb);
 	node->children = RB_ROOT;
 	init_waitqueue_head(&node->waitq);
@@ -433,6 +429,7 @@ struct kdbus_node *kdbus_node_unref(struct kdbus_node *node)
 		WARN_ON(atomic_read(&node->active) != KDBUS_NODE_DRAINED);
 		WARN_ON(!RB_EMPTY_NODE(&node->rb));
 
+		put_cred(node->creds);
 		if (node->free_cb)
 			node->free_cb(node);
 		if (safe.id > 0)
diff --git a/ipc/kdbus/node.h b/ipc/kdbus/node.h
index 970e02b..d52e1c2 100644
--- a/ipc/kdbus/node.h
+++ b/ipc/kdbus/node.h
@@ -41,8 +41,7 @@ struct kdbus_node {
 	kdbus_node_free_t free_cb;
 	kdbus_node_release_t release_cb;
 	umode_t mode;
-	kuid_t uid;
-	kgid_t gid;
+	const struct cred *creds;
 
 	/* valid once linked */
 	char *name;
@@ -57,6 +56,8 @@ struct kdbus_node {
 };
 
 #define kdbus_node_from_rb(_node) rb_entry((_node), struct kdbus_node, rb)
+#define kdbus_node_uid(_node)     ((_node)->creds->euid)
+#define kdbus_node_gid(_node)     ((_node)->creds->egid)
 
 extern struct ida kdbus_node_ida;
 
