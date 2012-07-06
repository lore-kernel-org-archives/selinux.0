From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Subject: [PATCH 1/2] SELinux: include definition of new capabilities
Date: Fri,  6 Jul 2012 14:13:29 -0400
Message-Id: <1341598410-29965-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The kernel has added CAP_WAKE_ALARM and CAP_EPOLLWAKEUP.  We need to
define these in SELinux so they can be mediated by policy.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/include/classmap.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index b8c5372..0b04fd9 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -145,7 +145,9 @@ struct security_class_mapping secclass_map[] = {
 	    "node_bind", "name_connect", NULL } },
 	{ "memprotect", { "mmap_zero", NULL } },
 	{ "peer", { "recv", NULL } },
-	{ "capability2", { "mac_override", "mac_admin", "syslog", NULL } },
+	{ "capability2",
+	  { "mac_override", "mac_admin", "syslog", "wake_alarm", "epollwakeup",
+	    NULL } },
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
