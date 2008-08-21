Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7LLQDoP015440
	for <selinux@tycho.nsa.gov>; Thu, 21 Aug 2008 17:26:13 -0400
Received: from g1t0029.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7LLQCO4017021
	for <selinux@tycho.nsa.gov>; Thu, 21 Aug 2008 21:26:13 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v3 04/13] smack: Fix missing calls to netlbl_skbuff_err()
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Thu, 21 Aug 2008 17:26:08 -0400
Message-ID: <20080821212608.7951.11115.stgit@flek.lan>
In-Reply-To: <20080821210239.7951.59652.stgit@flek.lan>
References: <20080821210239.7951.59652.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Smack needs to call netlbl_skbuff_err() to let NetLabel do the necessary
protocol specific error handling.

Signed-off-by: XXX
---

 security/smack/smack_lsm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 87d7541..6e2dc0b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2179,7 +2179,10 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	 * This is the simplist possible security model
 	 * for networking.
 	 */
-	return smk_access(smack, ssp->smk_in, MAY_WRITE);
+	rc = smk_access(smack, ssp->smk_in, MAY_WRITE);
+	if (rc != 0)
+		netlbl_skbuff_err(skb, rc, 0);
+	return rc;
 }
 
 /**


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
