From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: drop secondary_ops->sysctl
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Wed, 29 Apr 2009 14:00:25 -0400
Message-ID: <20090429180025.22109.45638.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We are still calling secondary_ops->sysctl even though the capabilities
module does not define a sysctl operation.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 796c16f..9af6624 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2050,10 +2050,6 @@ static int selinux_sysctl(ctl_table *table, int op)
 	u32 tsid, sid;
 	int rc;
 
-	rc = secondary_ops->sysctl(table, op);
-	if (rc)
-		return rc;
-
 	sid = current_sid();
 
 	rc = selinux_sysctl_get_sid(table, (op == 0001) ?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
