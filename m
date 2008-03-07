Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m27HlZMi026178
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 12:47:35 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m27HlXYd006850
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 17:47:33 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m27HOtlf026771
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 12:24:55 -0500
From: Steve Grubb <sgrubb@redhat.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] audit tty selinux permission
Date: Fri, 7 Mar 2008 12:24:33 -0500
Cc: James Morris <jmorris@redhat.com>, Eric Paris <eparis@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200803071224.33871.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Dan had mentioned that he wanted a new selinux permission to separate 
the ability to turn on tty auditing from the ability of setting audit rules.
It looks to me like the process that reads also writes, so only one new
permission is needed.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>


 security/selinux/include/av_permissions.h |    1 +
 security/selinux/nlmsgtab.c               |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -urp linux-2.6.24.x86_64.orig/security/selinux/include/av_permissions.h linux-2.6.24.x86_64/security/selinux/include/av_permissions.h
--- linux-2.6.24.x86_64.orig/security/selinux/include/av_permissions.h	2008-03-06 17:13:22.000000000 -0500
+++ linux-2.6.24.x86_64/security/selinux/include/av_permissions.h	2008-03-06 17:41:29.000000000 -0500
@@ -702,6 +702,7 @@
 #define NETLINK_AUDIT_SOCKET__NLMSG_WRITE         0x00800000UL
 #define NETLINK_AUDIT_SOCKET__NLMSG_RELAY         0x01000000UL
 #define NETLINK_AUDIT_SOCKET__NLMSG_READPRIV      0x02000000UL
+#define NETLINK_AUDIT_SOCKET__NLMSG_TTY           0x04000000UL
 #define NETLINK_IP6FW_SOCKET__IOCTL               0x00000001UL
 #define NETLINK_IP6FW_SOCKET__READ                0x00000002UL
 #define NETLINK_IP6FW_SOCKET__WRITE               0x00000004UL
diff -urp linux-2.6.24.x86_64.orig/security/selinux/nlmsgtab.c linux-2.6.24.x86_64/security/selinux/nlmsgtab.c
--- linux-2.6.24.x86_64.orig/security/selinux/nlmsgtab.c	2008-03-06 17:13:22.000000000 -0500
+++ linux-2.6.24.x86_64/security/selinux/nlmsgtab.c	2008-03-06 17:41:09.000000000 -0500
@@ -110,8 +110,8 @@ static struct nlmsg_perm nlmsg_audit_per
 	{ AUDIT_DEL_RULE,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
 	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_RELAY    },
 	{ AUDIT_SIGNAL_INFO,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
-	{ AUDIT_TTY_GET,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
-	{ AUDIT_TTY_SET,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_TTY_GET,	NETLINK_AUDIT_SOCKET__NLMSG_TTY      },
+	{ AUDIT_TTY_SET,	NETLINK_AUDIT_SOCKET__NLMSG_TTY      },
 };
 
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
