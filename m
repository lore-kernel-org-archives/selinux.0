Subject: [PATCH] SELinux protection for exploiting null dereference using
	mmap
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, drepper@redhat.com, alan@redhat.com, roland@redhat.com,
        arjan@infradead.org, mingo@elte.hu, viro@zeniv.linux.org.uk,
        jmorris@namei.org, chrisw@redhat.com
Content-Type: text/plain
Date: Wed, 30 May 2007 17:48:33 -0400
Message-Id: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Assuming there is a kernel bug which includes a null dereference it may
allow for a process to place information on the first page on the system
and get the kernel to act in unintended ways.  This patch creates a new
LSM/SELinux hook which checks mmap operations to see if the user is
attempting to mmap the first page.  Other options might be to simply
disallow these operations completely through something like a sysctl but
the fine grained approach of SELinux makes it possible that an
application which actually requires this permission is allowed to
function while helping to reduce the impact of null dereference kernel
bugs in the future.

I'm willing to take a different approach to the problem if anyone has
any other suggestions, but I think that making the kernel a bit more
resilient to null dereference bugs is a good idea.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 include/linux/security.h                     |   11 +++++++++++
 mm/mmap.c                                    |    6 ++++++
 mm/mremap.c                                  |    6 ++++++
 mm/nommu.c                                   |    6 ++++++
 security/dummy.c                             |    6 ++++++
 security/selinux/hooks.c                     |    9 +++++++++
 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    1 +
 security/selinux/include/class_to_string.h   |    1 +
 security/selinux/include/flask.h             |    1 +
 10 files changed, 48 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9eb9e0f..11003cd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1240,6 +1240,7 @@ struct security_operations {
 	void (*file_free_security) (struct file * file);
 	int (*file_ioctl) (struct file * file, unsigned int cmd,
 			   unsigned long arg);
+	int (*mmap_zero) (void);
 	int (*file_mmap) (struct file * file,
 			  unsigned long reqprot,
 			  unsigned long prot, unsigned long flags);
@@ -1812,6 +1813,11 @@ static inline int security_file_ioctl (struct file *file, unsigned int cmd,
 	return security_ops->file_ioctl (file, cmd, arg);
 }
 
+static inline int security_mmap_zero (void)
+{
+	return security_ops->mmap_zero ();
+}
+
 static inline int security_file_mmap (struct file *file, unsigned long reqprot,
 				      unsigned long prot,
 				      unsigned long flags)
@@ -2487,6 +2493,11 @@ static inline int security_file_ioctl (struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static inline int security_mmap_zero (void)
+{
+	return 0;
+}
+
 static inline int security_file_mmap (struct file *file, unsigned long reqprot,
 				      unsigned long prot,
 				      unsigned long flags)
diff --git a/mm/mmap.c b/mm/mmap.c
index 68b9ad2..3c2c3f3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1026,6 +1026,12 @@ unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
 	error = security_file_mmap(file, reqprot, prot, flags);
 	if (error)
 		return error;
+
+	if (unlikely(addr < PAGE_SIZE)) {
+		error = security_mmap_zero();
+		if (error)
+			return error;
+	}
 		
 	/* Clear old maps */
 	error = -ENOMEM;
diff --git a/mm/mremap.c b/mm/mremap.c
index 5d4bd4f..9e76313 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -291,6 +291,12 @@ unsigned long do_mremap(unsigned long addr,
 		if ((addr <= new_addr) && (addr+old_len) > new_addr)
 			goto out;
 
+		if (unlikely(new_addr < PAGE_SIZE)) {
+			ret = security_mmap_zero();
+			if (ret)
+				goto out;
+			ret = -EINVAL;
+		}
 		ret = do_munmap(mm, new_addr, new_len);
 		if (ret)
 			goto out;
diff --git a/mm/nommu.c b/mm/nommu.c
index 2b16b00..eb6df72 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -643,6 +643,12 @@ static int validate_mmap_request(struct file *file,
 	if (ret < 0)
 		return ret;
 
+	if (unlikely(addr < PAGE_SIZE)) {
+		ret = security_mmap_zero();
+		if (ret)
+			return ret;
+	}
+
 	/* looks okay */
 	*_capabilities = capabilities;
 	return 0;
diff --git a/security/dummy.c b/security/dummy.c
index 8ffd764..13e30aa 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -418,6 +418,11 @@ static int dummy_file_ioctl (struct file *file, unsigned int command,
 	return 0;
 }
 
+static int dummy_mmap_zero (void)
+{
+	return 0;
+}
+
 static int dummy_file_mmap (struct file *file, unsigned long reqprot,
 			    unsigned long prot,
 			    unsigned long flags)
@@ -1022,6 +1027,7 @@ void security_fixup_ops (struct security_operations *ops)
 	set_to_dummy_if_null(ops, file_alloc_security);
 	set_to_dummy_if_null(ops, file_free_security);
 	set_to_dummy_if_null(ops, file_ioctl);
+	set_to_dummy_if_null(ops, mmap_zero);
 	set_to_dummy_if_null(ops, file_mmap);
 	set_to_dummy_if_null(ops, file_mprotect);
 	set_to_dummy_if_null(ops, file_lock);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad8dd4e..0166d5e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2567,6 +2567,14 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 	return 0;
 }
 
+static int selinux_mmap_zero(void)
+{
+	u32 sid = ((struct task_security_struct*)(current->security))->sid;
+
+	return avc_has_perm(sid, sid, SECCLASS_PROCESS_SPECIAL,
+			    PROCESS_SPECIAL__MMAP_ZERO, NULL);
+}
+
 static int selinux_file_mmap(struct file *file, unsigned long reqprot,
 			     unsigned long prot, unsigned long flags)
 {
@@ -4772,6 +4780,7 @@ static struct security_operations selinux_ops = {
 	.file_alloc_security =		selinux_file_alloc_security,
 	.file_free_security =		selinux_file_free_security,
 	.file_ioctl =			selinux_file_ioctl,
+	.mmap_zero =			selinux_mmap_zero,
 	.file_mmap =			selinux_file_mmap,
 	.file_mprotect =		selinux_file_mprotect,
 	.file_lock =			selinux_file_lock,
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index b83e740..b1322ca 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -158,3 +160,4 @@
    S_(SECCLASS_KEY, KEY__CREATE, "create")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
+   S_(SECCLASS_PROCESS_SPECIAL, PROCESS_SPECIAL__MMAP_ZERO, "mmap_zero")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index 5fee173..af001f8 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -823,3 +825,4 @@
 #define DCCP_SOCKET__NAME_BIND                    0x00200000UL
 #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
 #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
+#define PROCESS_SPECIAL__MMAP_ZERO                0x00000001UL
diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
index 3787990..802c796 100644
--- a/security/selinux/include/class_to_string.h
+++ b/security/selinux/include/class_to_string.h
@@ -63,3 +63,4 @@
     S_("key")
     S_(NULL)
     S_("dccp_socket")
+    S_("process_special")
diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
index 35f309f..274f206 100644
--- a/security/selinux/include/flask.h
+++ b/security/selinux/include/flask.h
@@ -49,6 +49,7 @@
 #define SECCLASS_PACKET                                  57
 #define SECCLASS_KEY                                     58
 #define SECCLASS_DCCP_SOCKET                             60
+#define SECCLASS_PROCESS_SPECIAL                         61
 
 /*
  * Security identifier indices for initial entities



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
