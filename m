Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927D2046B2;
	Tue, 18 Mar 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286901; cv=none; b=ZXumY2H+gvATTOvN1wmdBEiHJLLeUdKIpY9f8eBNOXpZ14Gs1RFb5MhpMqZ5KMZlsZEepB0xSHJPZsk+YX00SjPaObci3LpL8hyf8uutatrabwYg1UAdSf8eIczTYo546RQ1tWYsNrzkC7MTyaB8x09NZsUhOeug+CSr/uD/A/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286901; c=relaxed/simple;
	bh=uvMHnXlZ6C++Ug/lwkoepOst++U5iRmTmeQR1KQbFUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNEA3mzYYvPfexVxUzVH5ugkiu6FkElDTrVwfTOdA0Lh+OpnSwNt9ok2QNP5GFUSAbfbo6cq7dB7t/Zjp+lmA/Lfo3oaU/VB2MDZ9J3dBkLw2OyVJoyoCNSZUyhB1plEsXIvYmXV4NhemOEdTvhcOg1frBMdho62x26o+vikNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=psFYS8UF; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="psFYS8UF"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1742286896;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJzsqiQzoZATgBAE4Jue8N4gJvoM7rHqr8Tb1P4sHhw=;
	b=psFYS8UFIpnjhHKJqGbH6vEcTh1oryH0xoSlQOuQbaMTh6V2SznjISDh+ZpjsilbAHGuNB
	wE/8/tPSWEbOVfwViors8rlfRtXKpRlz19S3+z+zNA7uPVbIh6cXOvseski7H/U4b5cd5s
	hADT6w4q/P7UNSRLL+MvQ9nsrHFAXLt2PSJH7rsdeEc3dqMup3MjEybcIZDbimh37Dlq6a
	ae1dqFCqGIQ8eaiz1bzJ4VyxxGMud07Y0CaGUIIGO4gtyPeggOsAGn2sYFUIahs1Eq91qM
	kexL9JoBTbd1Qt5LV5xk+KXrr0Izrc3vBNrfxqDCy5k8ARbYPjJZPdzVOUloQw==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	GUO Zihua <guozihua@huawei.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] selinux: improve network lookup failure warnings
Date: Tue, 18 Mar 2025 09:33:31 +0100
Message-ID: <20250318083422.21489-3-cgoettsche@seltendoof.de>
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

Rate limit the warnings and include additional available information.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/netif.c   | 8 ++++----
 security/selinux/netnode.c | 4 ++--
 security/selinux/netport.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 43a0d3594b72..38fdba1e64bf 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -141,8 +141,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 
 	dev = dev_get_by_index(ns, ifindex);
 	if (unlikely(dev == NULL)) {
-		pr_warn("SELinux: failure in %s(), invalid network interface (%d)\n",
-			__func__, ifindex);
+		pr_warn_ratelimited("SELinux: failure in %s(), invalid network interface (%d)\n",
+				    __func__, ifindex);
 		return -ENOENT;
 	}
 
@@ -169,8 +169,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	spin_unlock_bh(&sel_netif_lock);
 	dev_put(dev);
 	if (unlikely(ret))
-		pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
-			__func__, ifindex);
+		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network interface label (%d):  %d\n",
+				    __func__, ifindex, ret);
 	return ret;
 }
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 8bb456d80dd5..76cf531af110 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -228,8 +228,8 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
 
 	spin_unlock_bh(&sel_netnode_lock);
 	if (unlikely(ret))
-		pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
-			__func__);
+		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network node label (%d):  %d\n",
+				    __func__, family, ret);
 	return ret;
 }
 
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 7d2207384d40..dadf14984fb4 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -162,8 +162,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 out:
 	spin_unlock_bh(&sel_netport_lock);
 	if (unlikely(ret))
-		pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
-			__func__);
+		pr_warn_ratelimited("SELinux: failure in %s(), unable to determine network port label (%d:%d):  %d\n",
+				    __func__, protocol, pnum, ret);
 	return ret;
 }
 
-- 
2.49.0

