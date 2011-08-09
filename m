From: <rongqing.li@windriver.com>
To: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>, <sds@tycho.nsa.gov>
Subject: [PATCH 1/6] Security: define security_sk_getsecid.
Date: Tue, 9 Aug 2011 15:28:25 +0800
Message-ID: <1312874910-31010-2-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1312874910-31010-1-git-send-email-rongqing.li@windriver.com>
References: <1312874910-31010-1-git-send-email-rongqing.li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Roy.Li <rongqing.li@windriver.com>

Define security_sk_getsecid to get the security id of a sock.

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
---
 include/linux/security.h |    6 ++++++
 security/security.c      |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ebd2a53..739ac39 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2560,6 +2560,7 @@ int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl);
+void security_sk_getsecid(struct sock *sk, u32 *secid);
 void security_req_classify_flow(const struct request_sock *req, struct flowi *fl);
 void security_sock_graft(struct sock*sk, struct socket *parent);
 int security_inet_conn_request(struct sock *sk,
@@ -2701,6 +2702,11 @@ static inline void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
 }
 
+static inline void security_sk_getsecid(struct sock *sk, u32 *secid)
+{
+	*secid = 0;
+}
+
 static inline void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
 {
 }
diff --git a/security/security.c b/security/security.c
index 0e4fccf..b0e0825 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1104,6 +1104,12 @@ void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
+void security_sk_getsecid(struct sock *sk, u32 *secid)
+{
+	security_ops->sk_getsecid(sk, secid);
+}
+EXPORT_SYMBOL(security_sk_getsecid);
+
 void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
 {
 	security_ops->req_classify_flow(req, fl);
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
