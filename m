Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m85NNlJX031152
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 19:23:47 -0400
Received: from g4t0016.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m85NNlQ2002541
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 23:23:47 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v5 05/14] smack: Fix missing calls to netlbl_skbuff_err()
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Fri, 05 Sep 2008 19:23:44 -0400
Message-ID: <20080905232344.31840.60714.stgit@flek.lan>
In-Reply-To: <20080905231853.31840.57880.stgit@flek.lan>
References: <20080905231853.31840.57880.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Smack needs to call netlbl_skbuff_err() to let NetLabel do the necessary
protocol specific error handling.

Signed-off-by: Paul Moore <paul.moore@hp.com>
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
