Message-ID: <49D175C6.2050001@ak.jp.nec.com>
Date: Tue, 31 Mar 2009 10:45:42 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: method@manicmethod.com, jmorris@namei.org, selinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Permissive domain in userspace (Re: Some ideas in SE-PostgreSQL
 enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CB3CEB.1070505@ak.jp.nec.com> <49CD8E68.9090004@tycho.nsa.gov> <49D034B9.9080406@ak.jp.nec.com>
In-Reply-To: <49D034B9.9080406@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------030905030709010002000902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030905030709010002000902
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

KaiGai Kohei wrote:
> If we have an entry something like "/selinux/permissive" to return
> whether the given domain is permissive or not, I think we don't need
> to have the flags field on security_compute_av(). It can be checked
> on the creation of userspace avc entry, and checked it on later access
> controls.

The attached patch exposes a new entry in selinuxfs, which enables
userspace stuff to make a query whether the given context is permissive
domain, or not.
If the given context is permissive domain, userspace stuffs can mark
its entry as a permissive one on creation of avc entries, to avoid
policy enforcement on permissive domains.

It now checks security:{check_context} permission, but it should be
discussed what permission to be checked here.

The attached check_permissive.c is an example to use the interface.

  [kaigai@saba ~]$ ./check_permissive staff_u:staff_r:staff_t:s0
  staff_u:staff_r:staff_t:s0 is a permissive domain
  [kaigai@saba ~]$ ./check_permissive user_u:user_r:user_t:s0
  user_u:user_r:user_t:s0 is NOT a permissive domain

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------030905030709010002000902
Content-Type: text/x-patch;
 name="kernel-interface-permissive-domain.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-interface-permissive-domain.1.patch"

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 security/selinux/selinuxfs.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index d3c8b98..10accc0 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -122,6 +122,7 @@ enum sel_inos {
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
 	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
 	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
+	SEL_PERMISSIVE,	/* check whether permissive domain or not */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -513,6 +514,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size);
+static ssize_t sel_write_permissive(struct file *file, char *buf, size_t size);
 
 static ssize_t (*write_op[])(struct file *, char *, size_t) = {
 	[SEL_ACCESS] = sel_write_access,
@@ -521,6 +523,7 @@ static ssize_t (*write_op[])(struct file *, char *, size_t) = {
 	[SEL_USER] = sel_write_user,
 	[SEL_MEMBER] = sel_write_member,
 	[SEL_CONTEXT] = sel_write_context,
+	[SEL_PERMISSIVE] = sel_write_permissive,
 };
 
 static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
@@ -841,6 +844,26 @@ out:
 	return length;
 }
 
+static ssize_t sel_write_permissive(struct file *file, char *buf, size_t size)
+{
+	u32 sid;
+	ssize_t rc;
+
+	/*
+	 * MEMO: Is it correct to check security:{check_context} here?
+	 * Or, we should add something like security:{check_permissive}?
+	 */
+	rc = task_has_security(current, SECURITY__CHECK_CONTEXT);
+	if (rc)
+		return rc;
+
+	rc = security_context_to_sid(buf, size, &sid);
+	if (rc < 0)
+		return rc;
+
+	return security_permissive_sid(sid);
+}
+
 static struct inode *sel_make_inode(struct super_block *sb, int mode)
 {
 	struct inode *ret = new_inode(sb);
@@ -1668,6 +1691,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
+		[SEL_PERMISSIVE] = {"permissive", &transaction_ops, S_IRUGO|S_IWUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);

--------------030905030709010002000902
Content-Type: text/plain;
 name="check_permissive.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="check_permissive.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmlu
Zy5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxz
eXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlIDxzZWxpbnV4L3Nl
bGludXguaD4KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCWNvbnN0IGNo
YXIgKnBhdGggPSAiL3NlbGludXgvcGVybWlzc2l2ZSI7CglpbnQgZmQsIHJjOwoKCWlmIChh
cmd2WzFdID09IE5VTEwpIHsKCQlmcHJpbnRmKHN0ZGVyciwgInVzYWdlOiAlcyA8Y29udGV4
dD5cbiIsIGFyZ3ZbMF0pOwoJCXJldHVybiAtMTsKCX0KCglmZCA9IG9wZW4ocGF0aCwgT19S
RFdSKTsKCWlmIChmZCA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgImNvdWxkIG5vdCBvcGVu
ICVzICglcylcbiIsCgkJCXBhdGgsIHN0cmVycm9yKGVycm5vKSk7CgkJcmV0dXJuIC0xOwoJ
fQoKCXJjID0gd3JpdGUoZmQsIGFyZ3ZbMV0sIHN0cmxlbihhcmd2WzFdKSk7CglpZiAocmMg
PCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJlcnJvcjogd3JpdGUoJyVzJywgJyVzJykgKCVz
KVxuIiwKCQkJcGF0aCwgYXJndlsxXSwgc3RyZXJyb3IoZXJybm8pKTsKCQlyZXR1cm4gLTE7
Cgl9CgoJcHJpbnRmKCIlcyBpcyAlcyBwZXJtaXNzaXZlIGRvbWFpblxuIiwKCSAgICAgICBh
cmd2WzFdLCByYyA/ICJhIiA6ICJOT1QgYSIpOwoKCWNsb3NlKGZkKTsKCglyZXR1cm4gMDsK
fQo=
--------------030905030709010002000902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
