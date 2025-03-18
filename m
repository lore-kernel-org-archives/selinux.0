Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751B2054E1;
	Tue, 18 Mar 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286906; cv=none; b=KQnnUNHpZcWhXiCr5chVmwHlm3MHj6zSh06S7T1969hkH4uTKFyU/JOqP9mwNkSXe8clynygZChPLAK5nH98tYkWRH3mKEEqaOqYl7/3Ecxgv/zSV+Chn2GkhopoThzzBKjXTSN5VWgxEMv5eiUHEEDcaTxvEoxDqVgeoPMxCOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286906; c=relaxed/simple;
	bh=2AWMJbH51prcLuG/a3sS1hKTbUteeKt3MLJWU8+bklE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJNn/Ik7fA0X03VVJY6Z3eIFPYryL3Ppk6YjINJDDRADb0Siq237PNEYR1usr69ijPuAfjhosXHRFP/mXg9maWmeP3TzFs6ZnM6nfc/IhpQaAwLU449dFohMI1k+GgjqVnQ5OkX7oI3WMVADeYwlEV30w9xmxXR+ZJLq+WGxBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=k2JotuSK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="k2JotuSK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1742286902;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esfaz6XL2nBXvGJhNIRzr33HjxNzNLMTAs0zGyZIVN8=;
	b=k2JotuSK88WkB3a57lsdN6eoD/Nszik8apJo2iUlLxHP2wCHryejyg/fbnz3OvY80txVFY
	YijRnNOJqh3cM9nRYIgX8wBMuNYnPq8ChjuAX5RnPDFZAc3eWjRqIV/0PGQ+7r//5Wm6Qn
	XkF84NooWihmoKHP/GbbT/MJDezMu0wGXRZQSG8s6wYikKZyB6EAaLErIaQf3c7fFLwdZW
	KB3m82hlkutF/E1w+2vIKZrxn3Suxk45s4tmO3q5NQms1INJG5BejYiCkEO5HdJbSVtr2p
	Qc871CltJQsft/k3xv9BxUABwQSn3NpgVnhaOuzsvgaitLMNwUTcOwDbX3gp5g==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>,
	Chen Zhou <chenzhou10@huawei.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] selinux: unify OOM handling in network hashtables
Date: Tue, 18 Mar 2025 09:33:32 +0100
Message-ID: <20250318083422.21489-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-1-cgoettsche@seltendoof.de>
References: <20250318083422.21489-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

For network objects, like interfaces, nodes, port and InfiniBands, the
object to SID lookup is cached in hashtables.  OOM during such hashtable
additions of new objects is considered non-fatal and the computed SID is
simply returned without adding the compute result into the hash table.

Actually ignore OOM in the InfiniBand code, despite the comment already
suggesting to do so.  This reverts commit c350f8bea271 ("selinux: Fix
error return code in sel_ib_pkey_sid_slow()").

Add comments in the other places.

Use kmalloc() instead of kzalloc(), since all members are initialized on
success and the data is only used in internbal hash tables, so no risk
of information leakage to userspace.

Fixes: c350f8bea271 ("selinux: Fix error return code in sel_ib_pkey_sid_slow()")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ibpkey.c  | 11 +++++------
 security/selinux/netif.c   |  6 +++++-
 security/selinux/netnode.c |  5 ++++-
 security/selinux/netport.c |  6 +++++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 94f3eef22bad..470481cfe0e8 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -130,7 +130,7 @@ static int sel_ib_pkey_sid_slow(u64 subnet_prefix, u16 pkey_num, u32 *sid)
 {
 	int ret;
 	struct sel_ib_pkey *pkey;
-	struct sel_ib_pkey *new = NULL;
+	struct sel_ib_pkey *new;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sel_ib_pkey_lock, flags);
@@ -146,12 +146,11 @@ static int sel_ib_pkey_sid_slow(u64 subnet_prefix, u16 pkey_num, u32 *sid)
 	if (ret)
 		goto out;
 
-	/* If this memory allocation fails still return 0. The SID
-	 * is valid, it just won't be added to the cache.
-	 */
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	if (!new) {
-		ret = -ENOMEM;
+		/* If this memory allocation fails still return 0. The SID
+		 * is valid, it just won't be added to the cache.
+		 */
 		goto out;
 	}
 
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 38fdba1e64bf..2ab7fe9e1ea2 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -156,7 +156,11 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	ret = security_netif_sid(dev->name, sid);
 	if (ret != 0)
 		goto out;
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+
+	/* If this memory allocation fails still return 0. The SID
+	 * is valid, it just won't be added to the cache.
+	 */
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	if (new) {
 		new->nsec.ns = ns;
 		new->nsec.ifindex = ifindex;
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 76cf531af110..15fdf385062e 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -201,7 +201,10 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
 		return 0;
 	}
 
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	/* If this memory allocation fails still return 0. The SID
+	 * is valid, it just won't be added to the cache.
+	 */
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	switch (family) {
 	case PF_INET:
 		ret = security_node_sid(PF_INET,
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index dadf14984fb4..648c2bce83a7 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -151,7 +151,11 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 	ret = security_port_sid(protocol, pnum, sid);
 	if (ret != 0)
 		goto out;
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+
+	/* If this memory allocation fails still return 0. The SID
+	 * is valid, it just won't be added to the cache.
+	 */
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	if (new) {
 		new->psec.port = pnum;
 		new->psec.protocol = protocol;
-- 
2.49.0

