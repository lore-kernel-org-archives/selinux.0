From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v2 PATCH 3/3] SELinux: Compute SID for the newly created socket
Date: Wed,  2 Mar 2011 13:32:34 +0800
Message-Id: <1299043954-21877-3-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1299043954-21877-2-git-send-email-qingtao.cao@windriver.com>
References: <1299043954-21877-2-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The security context for the newly created socket shares the same
user, role and MLS attribute as its creator but may have a different
type, which could be specified by a type_transition rule in the relevant
policy package.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 security/selinux/hooks.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c8d6992..f086541 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3644,9 +3644,15 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 
 /* socket security operations */
 
-static u32 socket_sockcreate_sid(const struct task_security_struct *tsec)
+static int socket_sockcreate_sid(const struct task_security_struct *tsec,
+				 u16 secclass, u32 *socksid)
 {
-	return tsec->sockcreate_sid ? : tsec->sid;
+	if (tsec->sockcreate_sid > SECSID_NULL) {
+		*socksid = tsec->sockcreate_sid;
+		return 0;
+	}
+
+	return security_transition_sid(tsec->sid, tsec->sid, secclass, socksid);
 }
 
 static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
@@ -3670,12 +3676,16 @@ static int selinux_socket_create(int family, int type,
 	const struct task_security_struct *tsec = current_security();
 	u32 newsid;
 	u16 secclass;
+	int rc;
 
 	if (kern)
 		return 0;
 
-	newsid = socket_sockcreate_sid(tsec);
 	secclass = socket_type_to_security_class(family, type, protocol);
+	rc = socket_sockcreate_sid(tsec, secclass, &newsid);
+	if (rc)
+		return rc;
+
 	return avc_has_perm(tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
 }
 
@@ -3687,12 +3697,16 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	struct sk_security_struct *sksec;
 	int err = 0;
 
+	isec->sclass = socket_type_to_security_class(family, type, protocol);
+
 	if (kern)
 		isec->sid = SECINITSID_KERNEL;
-	else
-		isec->sid = socket_sockcreate_sid(tsec);
+	else {
+		err = socket_sockcreate_sid(tsec, isec->sclass, &(isec->sid));
+		if (err)
+			return err;
+	}
 
-	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->initialized = 1;
 
 	if (sock->sk) {
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
