Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A81B4124;
	Mon, 16 Dec 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367295; cv=none; b=Q98soJ+oJY2D4G+q9aUjH1P6ArEgn5FPQHK5vl70iQf5jZkr+5+umws5LqV3vDEPsuCLnlCGwPmSLVSNbUNVqDQZFfK/+im8WJYqy7RxUbXrqlUWQdrK5mNX487AyLwbGyTP6YAKC/fw+b4+L0ixJEf4LerPXh9uU/X751TQNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367295; c=relaxed/simple;
	bh=89wQmN+Ig6V1v15w0SLK0D5mprUN9b+qXi40CENcsRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5Bi+5dTmta1ra/NVshRNFyJ5ulWcYO6+XR87nSVloN3Q9goJMp1re/8hIE1C+Go5ftdO3n2tqb4GFsXsGdCp02EXBWcmYIJy0GbP58LuY6OMhbewo0xN7IL7HhXUA28d6C7liaRiQ9vSwbNDmYzSuwMuUpAexTOY9moFVVvrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dii9qhSd; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dii9qhSd"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367289;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZYRXuxkm4pJxEq3S9zkEchRJCyA22U8DOKLICxGpBQ=;
	b=dii9qhSdHgmUw56N6971JttVdbhmm+TyHKmtwvQsvVLJ9ToVmweZQ0xBJ48Ournu3WoAGL
	EEkm4PZuALFsh50T6/QltIifdIgKWLGzvTEqY4c0/Plez/T9mkPOVY1qLZZEnkT9a0MU1R
	zpHcnFpkd3N49OHto5i6CoH+lYNVWgcSsLm4SHiJrjYo+ehhsLoFOV7ZNSDapKwh9/W3Wg
	bSMiQorABKcmeGYOFoqdS6+2HoxXIsbOhU4Dt19ra23gdFWoOdXFV8ixWiPkFnXwh0SrfL
	KFCTs692tleP6jT8owtQUftidP7hxDRnuPlo9pBmCJ/Da45nr8ZAGS6OChQXCA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Casey Schaufler <casey@schaufler-ca.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	John Johansen <john.johansen@canonical.com>,
	GUO Zihua <guozihua@huawei.com>
Subject: [RFC PATCH v2 04/22] selinux: rework match_ipv6_addrmask()
Date: Mon, 16 Dec 2024 17:40:02 +0100
Message-ID: <20241216164055.96267-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
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

Constify parameters, add size hints, and simplify control flow.

According to godbolt the same assembly is generated.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1c4ac392df2a..9bd14256a154 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2597,17 +2597,15 @@ int security_netif_sid(char *name, u32 *if_sid)
 	return rc;
 }
 
-static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
+static bool match_ipv6_addrmask(const u32 input[4], const u32 addr[4], const u32 mask[4])
 {
-	int i, fail = 0;
+	int i;
 
 	for (i = 0; i < 4; i++)
-		if (addr[i] != (input[i] & mask[i])) {
-			fail = 1;
-			break;
-		}
+		if (addr[i] != (input[i] & mask[i]))
+			return false;
 
-	return !fail;
+	return true;
 }
 
 /**
-- 
2.45.2

