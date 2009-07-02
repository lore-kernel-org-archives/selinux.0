Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n625W54F013504
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 01:32:05 -0400
Received: from wa-out-1112.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n625VmvW014582
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 05:31:48 GMT
Received: by wa-out-1112.google.com with SMTP id k17so271606waf.18
        for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2009 22:32:03 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 4/8] SELinux netlabel.c non trivial fixes.
Date: Wed,  1 Jul 2009 22:32:43 -0700
Message-Id: <1246512767-2999-5-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
References: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Fix a comment to sound better.
Fix some comments.
---
 security/selinux/netlabel.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 2e98441..7868ea2 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -167,7 +167,7 @@ void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec)
  *
  * Description:
  * Call the NetLabel mechanism to get the security attributes of the given
- * packet and use those attributes to determine the correct context/SID to
+ * packet and use those attributes to determine the correct context/SID to be
  * assign to the packet.  Returns zero on success, negative values on failure.
  *
  */
@@ -216,8 +216,8 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	struct netlbl_lsm_secattr *secattr = NULL;
 	struct sock *sk;
 
-	/* if this is a locally generated packet check to see if it is already
-	 * being labeled by it's parent socket, if it is just exit */
+	/* If this is a locally generated packet check to see if it is already
+	 * being labeled by it's parent socket, if it is just exit. */
 	sk = skb->sk;
 	if (sk != NULL) {
 		struct sk_security_struct *sksec = sk->sk_security;
@@ -444,9 +444,9 @@ int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr *addr)
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
-	/* connected sockets are allowed to disconnect when the address family
+	/* Connected sockets are allowed to disconnect when the address family
 	 * is set to AF_UNSPEC, if that is what is happening we want to reset
-	 * the socket */
+	 * the socket. */
 	if (addr->sa_family == AF_UNSPEC) {
 		netlbl_sock_delattr(sk);
 		sksec->nlbl_state = NLBL_REQSKB;
-- 
1.6.3.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
