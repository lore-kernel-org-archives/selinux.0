Subject: [PATCH 2/3] SELinux: define mapping for new capabilities
To: selinux@tycho.nsa.gov
From: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov
Date: Wed, 06 Jun 2012 11:53:39 -0400
Message-ID: <20120606155339.32443.68410.stgit@paris.rdu.redhat.com>
In-Reply-To: <20120606155333.32443.15937.stgit@paris.rdu.redhat.com>
References: <20120606155333.32443.15937.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

New capabilities were added but the security list was never cc'd on the
patches.  I missed the patches and thus SELinux does not have the requisite
names to do userspace policy mapping.  Add those names.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/include/classmap.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 72c08b9..d76eb53 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -145,7 +145,8 @@ struct security_class_mapping secclass_map[] = {
 	    "node_bind", "name_connect", NULL } },
 	{ "memprotect", { "mmap_zero", NULL } },
 	{ "peer", { "recv", NULL } },
-	{ "capability2", { "mac_override", "mac_admin", "syslog", NULL } },
+	{ "capability2", { "mac_override", "mac_admin", "syslog", "wake_alarm",
+			   "epollwakeup", NULL } },
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket",
 	  { COMMON_SOCK_PERMS, NULL } },


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
