From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: define audit permissions for audit tree netlink
	messages
To: selinux@tycho.nsa.gov, linux-audit@redhat.com
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@redhat.com, sgrubb@redhat.com,
        viro@ZenIV.linux.org.uk
Date: Tue, 02 Jun 2009 17:01:16 -0400
Message-ID: <20090602210115.8797.11063.stgit@dhcp231-142.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Audit trees defined 2 new netlink messages but the netlink mapping tables for
selinux permissions were not set up.  This patch maps these 2 new operations
to AUDIT_WRITE.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/nlmsgtab.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index c6875fd..dd7cc6d 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -112,6 +112,8 @@ static struct nlmsg_perm nlmsg_audit_perms[] =
 	{ AUDIT_DEL_RULE,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
 	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_RELAY    },
 	{ AUDIT_SIGNAL_INFO,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
+	{ AUDIT_TRIM,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_MAKE_EQUIV,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
 	{ AUDIT_TTY_GET,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
 	{ AUDIT_TTY_SET,	NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT	},
 };


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
