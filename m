Subject: Re: [PATCH] SELinux protection for exploiting null dereference
	using mmap
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, drepper@redhat.com,
        alan@redhat.com, roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, chrisw@redhat.com
In-Reply-To: <Line.LNX.4.64.0705301954080.19731@d.namei>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
	 <Line.LNX.4.64.0705301954080.19731@d.namei>
Content-Type: text/plain
Date: Thu, 31 May 2007 01:46:02 -0400
Message-Id: <1180590362.3969.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 20:07 -0400, James Morris wrote:
> On Wed, 30 May 2007, Eric Paris wrote:

> > +	return avc_has_perm(sid, sid, SECCLASS_PROCESS_SPECIAL,
> > +			    PROCESS_SPECIAL__MMAP_ZERO, NULL);
> 
> A new class for this seems odd. 
> 
> Is this class likely to be used for other similar checks?  I think it at 
> least needs a better name.

suggestions for a better name from anyone?  Originally I thought of
using the process class but one of the biggest reasons for a new class
was the common occurance of grantings for 

something_t self: process *

since this isn't a permission which is actually only affecting the
process itself its a little different.  This permission is actually
limiting the effect of a kernel bug not restricting a process from
dealing with its own resources.

He's a quick patch which I only checked by booting and testing with
MAP_FIXED, no mremap testing....

It doesn't address the question of 'is 1 page enough'   Anyone with a
good suggestion of how much is enough?  Or a reasonable idea on how to
make something like this configureable if we can't agree on a single
number?

-Eric

 include/linux/security.h                         |   17 +++++++---
 mm/mmap.c                                        |    4 +-
 mm/mremap.c                                      |    4 ++
 mm/nommu.c                                       |    2 +-
 security/dummy.c                                 |    4 ++-
 security/selinux/hooks.c                         |   15 +++++++--
 security/selinux/include/av_perm_to_string.h     |    1 +
 security/selinux/include/av_permissions.h        |    1 +
 security/selinux/include/class_to_string.h       |    1 +
 security/selinux/include/flask.h                 |    1 +
 11 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9eb9e0f..0aba455 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1240,9 +1240,11 @@ struct security_operations {
 	void (*file_free_security) (struct file * file);
 	int (*file_ioctl) (struct file * file, unsigned int cmd,
 			   unsigned long arg);
+	int (*mmap_zero) (void);
 	int (*file_mmap) (struct file * file,
-			  unsigned long reqprot,
-			  unsigned long prot, unsigned long flags);
+			  unsigned long reqprot, unsigned long prot,
+			  unsigned long flags, unsigned long addr,
+			  unsigned long addr_only);
 	int (*file_mprotect) (struct vm_area_struct * vma,
 			      unsigned long reqprot,
 			      unsigned long prot);
@@ -1814,9 +1816,12 @@ static inline int security_file_ioctl (struct file *file, unsigned int cmd,
 
 static inline int security_file_mmap (struct file *file, unsigned long reqprot,
 				      unsigned long prot,
-				      unsigned long flags)
+				      unsigned long flags,
+				      unsigned long addr,
+				      unsigned long addr_only)
 {
-	return security_ops->file_mmap (file, reqprot, prot, flags);
+	return security_ops->file_mmap (file, reqprot, prot, flags, addr,
+					addr_only);
 }
 
 static inline int security_file_mprotect (struct vm_area_struct *vma,
@@ -2489,7 +2494,9 @@ static inline int security_file_ioctl (struct file *file, unsigned int cmd,
 
 static inline int security_file_mmap (struct file *file, unsigned long reqprot,
 				      unsigned long prot,
-				      unsigned long flags)
+				      unsigned long flags,
+				      unsigned long addr,
+				      unsigned long addr_only)
 {
 	return 0;
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 68b9ad2..bce4995 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1023,10 +1023,10 @@ unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
 		}
 	}
 
-	error = security_file_mmap(file, reqprot, prot, flags);
+	error = security_file_mmap(file, reqprot, prot, flags, addr, 0);
 	if (error)
 		return error;
-		
+
 	/* Clear old maps */
 	error = -ENOMEM;
 munmap_back:
diff --git a/mm/mremap.c b/mm/mremap.c
index 5d4bd4f..ecb15e4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -291,6 +291,10 @@ unsigned long do_mremap(unsigned long addr,
 		if ((addr <= new_addr) && (addr+old_len) > new_addr)
 			goto out;
 
+		ret = security_file_mmap(0, 0, 0, 0, new_addr, 1);
+		if (ret)
+			goto out;
+
 		ret = do_munmap(mm, new_addr, new_len);
 		if (ret)
 			goto out;
diff --git a/mm/nommu.c b/mm/nommu.c
index 2b16b00..6f8ddee 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -639,7 +639,7 @@ static int validate_mmap_request(struct file *file,
 	}
 
 	/* allow the security API to have its say */
-	ret = security_file_mmap(file, reqprot, prot, flags);
+	ret = security_file_mmap(NULL, 0, 0, 0, addr, 1);
 	if (ret < 0)
 		return ret;
 
diff --git a/security/dummy.c b/security/dummy.c
index 8ffd764..365c4db 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -420,7 +420,9 @@ static int dummy_file_ioctl (struct file *file, unsigned int command,
 
 static int dummy_file_mmap (struct file *file, unsigned long reqprot,
 			    unsigned long prot,
-			    unsigned long flags)
+			    unsigned long flags,
+			    unsigned long addr,
+			    unsigned long addr_only)
 {
 	return 0;
 }
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad8dd4e..86ea5a5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2568,14 +2568,23 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 }
 
 static int selinux_file_mmap(struct file *file, unsigned long reqprot,
-			     unsigned long prot, unsigned long flags)
+			     unsigned long prot, unsigned long flags,
+			     unsigned long addr, unsigned long addr_only)
 {
-	int rc;
+	int rc = 0;
+	u32 sid = ((struct task_security_struct*)(current->security))->sid;
 
-	rc = secondary_ops->file_mmap(file, reqprot, prot, flags);
+	rc = secondary_ops->file_mmap(file, reqprot, prot, flags, addr,
+				      addr_only);
 	if (rc)
 		return rc;
 
+	if (addr < PAGE_SIZE)
+		rc = avc_has_perm(sid, sid, SECCLASS_PROCESS_SPECIAL,
+				  PROCESS_SPECIAL__MMAP_ZERO, NULL);
+	if (rc || addr_only)
+		return rc;
+
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
diff --git a/security/selinux/include/av_inherit.h b/security/selinux/include/av_inherit.h
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index b83e740..5f65bf2 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -158,3 +158,4 @@
    S_(SECCLASS_KEY, KEY__CREATE, "create")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
+   S_(SECCLASS_PROCESS_SPECIAL, PROCESS_SPECIAL__MMAP_ZERO, "mmap_zero")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index 5fee173..0ac3f63 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -823,3 +823,4 @@
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
diff --git a/security/selinux/include/common_perm_to_string.h b/security/selinux/include/common_perm_to_string.h
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
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
