Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97B1D1500;
	Fri, 15 Nov 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677836; cv=none; b=MWLK3nsFlh5Esu/O5TU2IzO73snRPIsGZM2PS6vF2om0d5ULni22kNM+COlzzZTPdGFJMRTpmhd8zmu1AfjkvsdHJbc+cgnxo9xR8grOIorj4qn+qqujHLVbGaGD879rA4FFd1zFQP9xQljlU9FTLRJLG4KZ3NlYalqKGeyDpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677836; c=relaxed/simple;
	bh=0xzg6/jljQnPgRhD/DzOQa6siBbdEeRG5Lul37FDM0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCgI2/GXKVK3Hdn4lIbket1p9FQBUjyqGr83urrllYFur186uhX8QPZcTlnwgXnZMOvGZgc/G5G6LeA1WL6RkhzsPzxGnYO2sfbstCbSkuLi8jwLlaHlt9g6L7zM+wbms3sInsHQfyIeeZojUBqqRVLCF7ICyVQQt6bcaxeU+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KKBixVh/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KKBixVh/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677833;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxiVbSbQHzHHpMI+yHbhWaVuWX/4H8f/Tr7fVYn5bM4=;
	b=KKBixVh/0JgYqiWvZCMLFo3c/k/e9nhwrmKwrkyqHNc8N2ykVUB+6ILlG2ZHm+XhSWBQki
	vtXIbTm/XMdKN9ey1snTehR/fHFMeNKrOCTGJbCGOhGJIFxxjxGpMm/YoawCljoEbgdIwF
	4KhaZpQjtR2eCBbHdc6emEIewf3jL0ZpL02w7SV63K0oKsA0Ne8FZ3grxEFQkO8Ox0biZ4
	IBYs9J4tHqc0mucATYScSGdBNLnJhjN0hlxfW1F7AdHO+IKU72vi8ecE6+zbQGK1FeeQnT
	+vSPLNfq3dWQfi3X/IF/DaWNpcmqD4PIxSb7yo+zxUE32F+cnpjal/pc710VnQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 16/22] selinux: check type attr map overflows
Date: Fri, 15 Nov 2024 14:35:35 +0100
Message-ID: <20241115133619.114393-16-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
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

Validate that no types with an invalid too high ID are present in the
attribute map.  Gaps are still not checked.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 1768ac4ecc2c..9b2eae70e2dc 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2941,6 +2941,11 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			if (rc)
 				goto bad;
 		}
+
+		rc = -EINVAL;
+		if (ebitmap_highest_set_bit(e) >= p->p_types.nprim)
+			goto bad;
+
 		/* add the type itself as the degenerate case */
 		rc = ebitmap_set_bit(e, i, 1);
 		if (rc)
-- 
2.45.2

