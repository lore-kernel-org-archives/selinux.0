Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB43DFTt022184
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 22:13:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB3N3vsY025409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 18:03:57 -0500
Subject: [PATCH] selinux: ensure that the cached NetLabel secattr matches
 the desired SID
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 03 Dec 2013 18:03:36 -0500
Message-ID: <20131203230336.14618.71483.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In selinux_netlbl_skbuff_setsid() we leverage a cached NetLabel
secattr whenever possible.  However, we never check to ensure that
the desired SID matches the cached NetLabel secattr.  This patch
checks the SID against the secattr before use and only uses the
cached secattr when the SID values match.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/netlabel.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 6235d05..0364120 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -101,6 +101,32 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 }
 
 /**
+ * selinux_netlbl_sock_getattr - Get the cached NetLabel secattr
+ * @sk: the socket
+ * @sid: the SID
+ *
+ * Query the socket's cached secattr and if the SID matches the cached value
+ * return the cache, otherwise return NULL.
+ *
+ */
+static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
+							const struct sock *sk,
+							u32 sid)
+{
+	struct sk_security_struct *sksec = sk->sk_security;
+	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
+
+	if (secattr == NULL)
+		return NULL;
+
+	if ((secattr->flags & NETLBL_SECATTR_SECID) &&
+	    (secattr->attr.secid == sid))
+		return secattr;
+
+	return NULL;
+}
+
+/**
  * selinux_netlbl_cache_invalidate - Invalidate the NetLabel cache
  *
  * Description:
@@ -224,7 +250,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 		struct sk_security_struct *sksec = sk->sk_security;
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
-		secattr = sksec->nlbl_secattr;
+		secattr = selinux_netlbl_sock_getattr(sk, sid);
 	}
 	if (secattr == NULL) {
 		secattr = &secattr_storage;
@@ -410,6 +436,9 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 	     sksec->nlbl_state == NLBL_CONNLABELED)) {
 		netlbl_secattr_init(&secattr);
 		lock_sock(sk);
+		/* call the netlabel function directly as we want to see the
+		 * on-the-wire label that is assigned via the socket's options
+		 * and not the cached netlabel/lsm attributes */
 		rc = netlbl_sock_getattr(sk, &secattr);
 		release_sock(sk);
 		if (rc == 0)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
