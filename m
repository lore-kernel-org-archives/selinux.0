Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88443290F;
	Mon, 15 Jul 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721007881; cv=none; b=C9vgKqndzB12d30EUGVoHiICT3Uiqem8FlVROziOANemY+cN/kBDfdNtOVV237SCu3I2rRyHfFbURZKfCEtUP2LUsnYg13dtYKq0oRLKa10L8sApZ9JX7Nb5F78OxjsTCOP7qvN3PNdLSS4s5GHiowiQJXHp1RbwAwDQQve3gpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721007881; c=relaxed/simple;
	bh=V62w8GmPEyje0BfH2PKxWDXBgc8ScthNi/hzQ10jYOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rKxmGNw95KnZhzPDMNyIGiJfmwKubqChjhqFmWCf1mjcYkl1jvRg5dDcOxIHqxyGtwaeeYcZb6zSGx8fpJ/av3uN0V+yUIL+sU/KVlhZQixrVh15HoO/6ihg7tdGsQNopvCnk41daGAlfYiGLR8CHhvSg2ioh2DU36XUY7iOl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp88t1721007824tvqed058
X-QQ-Originating-IP: Gpw8fkTxvPMza9jqqXkPs1WFicvFvYzz2LygZIJ7LEs=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jul 2024 09:43:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14221635385899329361
From: Canfeng Guo <guocanfeng@uniontech.com>
To: paul@paul-moore.com
Cc: stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Canfeng Guo <guocanfeng@uniontech.com>
Subject: [RPC] Topic: Issues and Testing Regarding SELinx AVC Cache Modification
Date: Mon, 15 Jul 2024 09:43:37 +0800
Message-Id: <20240715014337.11625-1-guocanfeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

When calling avc_insert to add nodes to the avc cache, they are inserted into
the head of the hash chain. Similarly, avc_calim_node removes nodes from
the head of the same chain. so, SElinux will delete the latest added cache
infromation.

I question whether the deletion logic proposed in the patch is more appropriate
than the current implementation, or whether alternative mechanisms such as
LRU caching are beneficial.

In my testing environment, I applied the above patch when avc_cache.solt and
cache_threshold were both set to 512 by default. I only have over 280 nodes
in my cache, and the longest observation length of the AVC cache linked list
is only 7 entries. Considering this small size, the cost of traversing the
list is minimal, and such modifications may not incur additional costs.

However, I don't know how to design a test case to verify its cost.
And I cannot prove that this patch is beneficial.

I attempted to simulate a more demanding scenario by increasing the cache_threshold
to 2048 in order to establish a longer linked list of AVC caches, but
I was unable to generate more than 2048 AVC records, possibly due to the need
for a highly complex environment with numerous different SID interactions.

Therefore, I have two questions:
The necessity of modification:
     Considering its potential impact on the cache performance of SELinx AVC,
     is it worth investing effort into this modification?, i think that in most cases,
     this modification is not necessart.
Verification method:
     If making such modifications is reasonable, how can I effectively
     measure its impact on system performance?

Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
---
 security/selinux/avc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 32eb67fb3e42..9999028660c9 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -477,6 +477,9 @@ static inline int avc_reclaim_node(void)
 
 		rcu_read_lock();
 		hlist_for_each_entry(node, head, list) {
+			while(node->next){
+				node = node->next;
+			}
 			avc_node_delete(node);
 			avc_cache_stats_incr(reclaims);
 			ecx++;
-- 
2.20.1

