Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA7IMAMA026139
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 13:22:10 -0500 (EST)
Subject: [Fwd: [patch 1/1] selinux:  Extend selinuxfs context interface]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 07 Nov 2005 13:12:20 -0500
Message-Id: <1131387140.20591.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI, this patch has been submitted upstream in response to the
previously raised issue with needing to canonicalize contexts for
matchpathcon et al.

-------- Forwarded Message --------
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris
<jmorris@namei.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 1/1] selinux: Extend selinuxfs context interface
Date: Mon, 07 Nov 2005 12:25:51 -0500

This patch extends the selinuxfs context interface to allow return the
canonical form of the context to userspace.  Please apply, for 2.6.15 if
possible.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@namei.org>

---

 security/selinux/selinuxfs.c |   45 ++++++++++++++++++-------------------------
 1 files changed, 19 insertions(+), 26 deletions(-)

Index: linux-2.6/security/selinux/selinuxfs.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/selinuxfs.c,v
retrieving revision 1.56
diff -u -p -r1.56 selinuxfs.c
--- linux-2.6/security/selinux/selinuxfs.c	31 Oct 2005 15:36:31 -0000	1.56
+++ linux-2.6/security/selinux/selinuxfs.c	31 Oct 2005 18:55:23 -0000
@@ -271,46 +271,38 @@ static struct file_operations sel_load_o
 	.write		= sel_write_load,
 };
 
-
-static ssize_t sel_write_context(struct file * file, const char __user * buf,
-				 size_t count, loff_t *ppos)
-
+static ssize_t sel_write_context(struct file * file, char *buf, size_t size)
 {
-	char *page;
-	u32 sid;
+	char *canon;
+	u32 sid, len;
 	ssize_t length;
 
 	length = task_has_security(current, SECURITY__CHECK_CONTEXT);
 	if (length)
 		return length;
 
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-	if (*ppos != 0) {
-		/* No partial writes. */
-		return -EINVAL;
-	}
-	page = (char*)get_zeroed_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-	length = -EFAULT;
-	if (copy_from_user(page, buf, count))
-		goto out;
+	length = security_context_to_sid(buf, size, &sid);
+	if (length < 0)
+		return length;
 
-	length = security_context_to_sid(page, count, &sid);
+	length = security_sid_to_context(sid, &canon, &len);
 	if (length < 0)
+		return length;
+
+	if (len > SIMPLE_TRANSACTION_LIMIT) {
+		printk(KERN_ERR "%s:  context size (%u) exceeds payload "
+		       "max\n", __FUNCTION__, len);
+		length = -ERANGE;
 		goto out;
+	}
 
-	length = count;
+	memcpy(buf, canon, len);
+	length = len;
 out:
-	free_page((unsigned long) page);
+	kfree(canon);
 	return length;
 }
 
-static struct file_operations sel_context_ops = {
-	.write		= sel_write_context,
-};
-
 static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 				     size_t count, loff_t *ppos)
 {
@@ -375,6 +367,7 @@ static ssize_t (*write_op[])(struct file
 	[SEL_RELABEL] = sel_write_relabel,
 	[SEL_USER] = sel_write_user,
 	[SEL_MEMBER] = sel_write_member,
+	[SEL_CONTEXT] = sel_write_context,
 };
 
 static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
@@ -1220,7 +1213,7 @@ static int sel_fill_super(struct super_b
 	static struct tree_descr selinux_files[] = {
 		[SEL_LOAD] = {"load", &sel_load_ops, S_IRUSR|S_IWUSR},
 		[SEL_ENFORCE] = {"enforce", &sel_enforce_ops, S_IRUGO|S_IWUSR},
-		[SEL_CONTEXT] = {"context", &sel_context_ops, S_IRUGO|S_IWUGO},
+		[SEL_CONTEXT] = {"context", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_ACCESS] = {"access", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_CREATE] = {"create", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_RELABEL] = {"relabel", &transaction_ops, S_IRUGO|S_IWUGO},

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
