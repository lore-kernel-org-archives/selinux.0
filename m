Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD52F692D;
	Wed, 22 Oct 2025 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118069; cv=none; b=JJjvuBVuCE4Mwdw26+LSe5AYncdtSUAtchuWeH1YGP4c1a6tBMbMq5jCvVWnF3Ic9pzAKjjV7rAOkxder7nxZUt+/HmKlcjKC1pc/s0spX9vZKVjHJKjw8YF7zIoJM3JLjKgTbicSnT8Jku2QNfovfR8SZQ6KYdRDuyBuzOMk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118069; c=relaxed/simple;
	bh=wmBsN+nYF5w2nv3f6w1WyQtDDiJghpBuJ0uLM6ic6bY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndchcSTCUBQVp6nVdsuKdO9L2YWQu4hgnq5rOKu/SoANm98RB/P5GARzWRxwBnu+qmne4uiQGSwvQQ3JClmhEwFi3EAXd84g999ruMgGUs/1nGWMjt8A+gUlGJPsIOg1g4wBJwkjQfGmvPesA6egJAORk5DF9m8yJ9OIt21ER+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BhZfxNHa; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BhZfxNHa"
X-UUID: 98f00670af1811f0ae1e63ff8927bad3-20251022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9c11skWlcBrFfxSYse2dgS/l/ws/5SueoJHq0on6oNU=;
	b=BhZfxNHawsebvQAm2DVzx4b7RgGDNIt1pg6ndgwXWi4DJ+vsNAbcSgm/8oyhJWQDwAWZY/kkIRVHDPf4ZOcmMtbUbJ2uMMxkbuVeldc/cnEV82MrFByy/dMKajjIHx/zBSnHViRS7rFua8GDUhVGLD7TeTrFYzlJAH/Pm5d4x8U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:e0f06d7c-2766-4e93-9a91-072835f13a3e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e228b458-98d8-4d0a-b903-bc96efd77f78,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 98f00670af1811f0ae1e63ff8927bad3-20251022
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 253924129; Wed, 22 Oct 2025 15:27:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 22 Oct 2025 15:27:40 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 22 Oct 2025 15:27:40 +0800
From: <xion.wang@mediatek.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <huadian.liu@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>, <selinux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] selinux: export current_sid API for use in other kernel modules
Date: Wed, 22 Oct 2025 15:27:18 +0800
Message-ID: <20251022072729.14820-2-xion.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251022072729.14820-1-xion.wang@mediatek.com>
References: <20251022072729.14820-1-xion.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Xion Wang <xion.wang@mediatek.com>

Convert current_sid from static inline to a global
function and export it with EXPORT_SYMBOL.
This allows other kernel modules to retrieve
the SELinux security ID of the current task.

Signed-off-by: Xion Wang <xion.wang@mediatek.com>
---
 security/selinux/hooks.c          | 11 +++++++++++
 security/selinux/include/objsec.h | 12 ++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dfc22da42f30..0c128f323332 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -229,6 +229,17 @@ static inline u32 cred_sid(const struct cred *cred)
 	return tsec->sid;
 }
 
+/*
+ * get the subjective security ID of the current task
+ */
+u32 current_sid(void)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+
+	return tsec->sid;
+}
+EXPORT_SYMBOL(current_sid);
+
 static void __ad_net_init(struct common_audit_data *ad,
 			  struct lsm_network_audit *net,
 			  int ifindex, struct sock *sk, u16 family)
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2d5139c6d45b..787a0cd74ff0 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -202,16 +202,6 @@ selinux_ipc(const struct kern_ipc_perm *ipc)
 	return ipc->security + selinux_blob_sizes.lbs_ipc;
 }
 
-/*
- * get the subjective security ID of the current task
- */
-static inline u32 current_sid(void)
-{
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
-
-	return tsec->sid;
-}
-
 static inline struct superblock_security_struct *
 selinux_superblock(const struct super_block *superblock)
 {
@@ -265,4 +255,6 @@ selinux_bpf_token_security(struct bpf_token *token)
 	return token->security + selinux_blob_sizes.lbs_bpf_token;
 }
 #endif /* CONFIG_BPF_SYSCALL */
+
+u32 current_sid(void);
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.45.2

