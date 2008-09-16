Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8GCulxo028132
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 08:56:47 -0400
Received: from g5t0007.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8GCulmS023969
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 12:56:47 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v6 07/16] smack: Fix missing calls to netlbl_skbuff_err()
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Date: Tue, 16 Sep 2008 08:56:32 -0400
Message-ID: <20080916125632.17132.61097.stgit@flek.lan>
In-Reply-To: <20080916124722.17132.38741.stgit@flek.lan>
References: <20080916124722.17132.38741.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Smack needs to call netlbl_skbuff_err() to let NetLabel do the necessary
protocol specific error handling.

Signed-off-by: Paul Moore <paul.moore@hp.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
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
