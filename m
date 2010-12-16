From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: define permissions for DCB netlink messages
Date: Thu, 16 Dec 2010 12:52:18 -0500
Message-Id: <1292521938-21874-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Commit 2f90b865 added two new netlink message types to the netlink route
socket.  SELinux has hooks to define if netlink messages are allowed to
be sent or received, but it did not know about these two new message
types.  By default we allow such actions so noone likely noticed.  This
patch adds the proper definitions and thus proper permissions
enforcement.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/nlmsgtab.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 75ec0c6..8b02b21 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -65,6 +65,8 @@ static struct nlmsg_perm nlmsg_route_perms[] =
 	{ RTM_NEWADDRLABEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELADDRLABEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETADDRLABEL,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_GETDCB,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_SETDCB,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 };
 
 static struct nlmsg_perm nlmsg_firewall_perms[] =
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
