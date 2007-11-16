Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAGLZxxN027252
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 16:36:00 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAGLZwsk015647
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 21:35:59 GMT
Subject: [PATCH] SELinux: return EOPNOTSUPP not ENOTSUPP
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tcho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Fri, 16 Nov 2007 16:35:56 -0500
Message-Id: <1195248956.2924.93.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ENOTSUPP is not a valid error code in the kernel (it is defined in some
NFS internal error codes and has been improperly used other places).  In
the !CONFIG_SECURITY_SELINUX case though it is possible that we could
return this from selinux_audit_rule_init().  This patch just returns the
userspace valid EOPNOTSUPP.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 include/linux/selinux.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index d1b7ca6..6080f73 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -136,7 +136,7 @@ static inline int selinux_audit_rule_init(u32 field, u32 op,
                                           char *rulestr,
                                           struct selinux_audit_rule **rule)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline void selinux_audit_rule_free(struct selinux_audit_rule *rule)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
