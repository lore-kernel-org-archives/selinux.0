Subject: [PATCH] SELinux: open perm for sock files
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Thu, 05 Mar 2009 13:40:35 -0500
Message-Id: <1236278435.10235.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I did open permissions I didn't think any sockets would have an open.
Turns out AF_UNIX sockets can have an open when they are bound to the
filesystem namespace.  This patch adds a new SOCK_FILE__OPEN permission.
It's safe to add this as the open perms are already predicated on
capabilities and capabilities means we have unknown perm handling so
systems should be as backwards compatible as the policy wants them to
be.

https://bugzilla.redhat.com/show_bug.cgi?id=475224

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c                     |    2 ++
 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0081597..3fe2e12 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1801,6 +1801,8 @@ static inline u32 open_file_to_av(struct file *file)
 			av |= FIFO_FILE__OPEN;
 		else if (S_ISDIR(mode))
 			av |= DIR__OPEN;
+		else if (S_ISSOCK(mode))
+			av |= SOCK_FILE__OPEN;
 		else
 			printk(KERN_ERR "SELinux: WARNING: inside %s with "
 				"unknown mode:%o\n", __func__, mode);
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index c0c8854..c7531ee 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -24,6 +24,7 @@
    S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
    S_(SECCLASS_CHR_FILE, CHR_FILE__OPEN, "open")
    S_(SECCLASS_BLK_FILE, BLK_FILE__OPEN, "open")
+   S_(SECCLASS_SOCK_FILE, SOCK_FILE__OPEN, "open")
    S_(SECCLASS_FIFO_FILE, FIFO_FILE__OPEN, "open")
    S_(SECCLASS_FD, FD__USE, "use")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index 0ba79fe..0b8f9b2 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -174,6 +174,7 @@
 #define SOCK_FILE__SWAPON                         0x00004000UL
 #define SOCK_FILE__QUOTAON                        0x00008000UL
 #define SOCK_FILE__MOUNTON                        0x00010000UL
+#define SOCK_FILE__OPEN                           0x00020000UL
 #define FIFO_FILE__IOCTL                          0x00000001UL
 #define FIFO_FILE__READ                           0x00000002UL
 #define FIFO_FILE__WRITE                          0x00000004UL



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
