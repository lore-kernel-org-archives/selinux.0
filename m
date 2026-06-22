Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88C3161A3;
	Mon, 22 Jun 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140414; cv=none; b=IbCDpo4r+sQ09Xm6FnU+itIh/iJuEuvFKHTGAAa2beV+5mzlt3+f5nGpX3SsQlVoFYm+ZitxslLR4CY7cHVUFWjeETS3m+LbfaKpNtSJ6yF3Ql/pmWrdec5uqw1pJ1AIi/dBG3thaxuPuCk/xmyg3wsqsEzGWYwCuF58Rc6Kfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140414; c=relaxed/simple;
	bh=VEbitypmM0KPiOmV2k048fs3HPPQBOI9tvjTU42Em9s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XKM4htY/baJPjkMv0RfF0TkQwUb9MjCmNmHsIMBooROaxjfgVq/0GBwlIgmNB42lvA8qTfq55urJu8rZ31e6j4XUeq6hLDJEXfmLdsmoF0HBWJNTTSfrVJckL1dX4AbJpxr3Kh4n0qxEcA4pc4X5OzzqnGDKe218jnVUcN9P3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=Rmn0G0pu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ViC4vNUM; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="Rmn0G0pu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ViC4vNUM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id B91991300475;
	Mon, 22 Jun 2026 11:00:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 11:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1782140411; x=1782144011; bh=JeT6ZI1VJv4VcgJcw1HZwtPrn5lf+WHS
	XQl+O8OjyPc=; b=Rmn0G0puBBDFnPGt/rUad+cXJ/D+92FQioqKxseeM+raI5aJ
	d6ZiRr3ru3IXnqD6Ea++tUIaBbvq+eaSd5k0bBS/wERpVin0/cImHCJNqZcWooX6
	KfoSGB1OGKde9q1mPCG100aEAyudcATJ04y/lXINaiCT3Cazb+rNo/Dxy5PYlym7
	rSZNpVqJH49noV3PcoX2Usetz3nxcdNEB0Hgcd1keW8TiTbVkxL0uqcDLsSNVlZ1
	ZaInKBSbgIeTmSqKbnDSULNeOdlPbnry/6wvqQBK0y0VJyFeQ9xBV7dfwncPaK5N
	ZUiU9XMzy7VinSHaG+fI1mcqfCo/dnD2ycSoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782140411; x=
	1782144011; bh=JeT6ZI1VJv4VcgJcw1HZwtPrn5lf+WHSXQl+O8OjyPc=; b=V
	iC4vNUMv5cXyt7pw66LUgGo6ywbFq89T3xCbWfh9jr6XU8OoVdp2wiXPCMeFx+8b
	5g29/fYRKx5mvKpJTat72RcmL19NRrHJ8Tm+6IwXDbOd7vWop3dLRML4LrYUrHRF
	jqy2Z36of8FyzE5PiffeFOf80dirarZRqscP00o8e+2+BHTumqYn7MzeywJFYKPU
	wpdv3SbBa0Mln85W2jVbtyfenjfN9z59FNMcwYStF+uBlVKet4axIZP2C3D0NsKy
	S8D5CBCWSnfrbLvJegnZumYvLQpDKrAhGXRzTyqEu1FDaKrfAwcDMeQJ7VHAsdiq
	Ll2rbyOdZcpB8n7JnD0xw==
X-ME-Sender: <xms:-k05au-yjYAp8drRic1tuJ681hE43_hwu8X8RpFHOn7lZKyne8GHqQ>
    <xme:-k05apoInNBOjqYemoX3jRw3aEz5Buznspd-cpOivOEs9LoyI3k7_SxCB9Uz3AOFu
    5rrqmu-c0Ud8AnJWC65sZTCoIeQD5GcU_us4cx-JCQ6J3nhrfeTOuI>
X-ME-Received: <xmr:-k05ajB8Kooo0xp6GDMRv1T9djxAJjzRsN4ZygjUzhdJ8sjYbTs8mQDu1HQ>
X-ME-Proxy-Cause: dmFkZTFFvahTI8O3H44ePGhZp6eGlFn3MPUZbeALJwUvRUA0820Hdfud9NKk3JZ0t5rmcW
    BWgSmLuBc8uyH2X2St6OIgD7PrSogduPJcCrq/rkx2IhIixdcHf/JMkaKplpm4bcqk4wPF
    hFIN4xFhkyFen3PKI0DkaI96XCa9huRKQzVHwAIIMNryCV07ytmYhi2C4PJKOay1T8s7TF
    SLbcvxdKMy1zPs+Stc3TQwrTqkRe2d3W/RTn7OC/6CHirKdLfEqB/argGy5y5OJjRC5OHa
    36HHsSX0+6Tm+6U97ZhQMYl6Q0K2apaZIl1qGMKM0+7JVJ/65VSaUtGpmDCRGRa0wOxhGB
    +mcFjIl7c1zoIu0rv+dChIdAYpex5ZiVBYeEUAcuNyh8ej/79mn242vVxBUa6AZDnzsYOM
    /gjjhTiTjDh+XubPdh7S97HEONgsyCV4fZNRPNWLtdKt39qNOABwjdLlTSue36bRa8FyTy
    fahn7xGM5HN2OLQBOH3g84kl7dQOXGFB2xPYbPheRHM9qbD/6ROE1CdFxCxxUwc5fo/2oc
    Y/dDgzgXT4fY7AFbLyaxC02FRO+och1quH22mMyV508qrHc2C6xVHbGCjzyi05IaI2tMbd
    OmZ+d9rno+QUDoyh1A8XBJTuXUwKm2njo3PBzHuUZQ0uc7WIYC5drEBnVsoQ
X-ME-Proxy: <xmx:-k05arwEuBp9-x3F5LpvykvEYfBMpt3dD5YNUolcldWpD_JsNtwR5w>
    <xmx:-k05ag3ILgU6IkZ3NsQ-xliuxXx4dbOMO-LHE0y9FPpjEPMZRam3Jw>
    <xmx:-k05arxJUn2fgD5O6ZItMLjNWgBG6Gc_P8PqnauAryzSZv8i40_Omw>
    <xmx:-k05anEhTZMJym5XxzGySK5XHWun-YfE376YsINlWNbBOorSgOnxog>
    <xmx:-005aghlmGOGEXyGBBkknguI8K-94vtABrLDI8zJ2RP9FB0q7_DLHZKt>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 11:00:10 -0400 (EDT)
Date: Mon, 22 Jun 2026 10:00:07 -0500
From: Ian Bridges <icb@fastmail.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
Message-ID: <ajlN94VO7BYNUTAy@dev>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the deprecated strlcat() API[1], replace the
strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
seq_buf, which tracks the write position and remaining space internally.

The seven open-coded WARN_ON(rc >= buf_len) truncation checks become a
single seq_buf_has_overflowed() check after the string is built. The
kzalloc() and its exact-size computation are unchanged, so the
measurement string passed to IMA is unchanged.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
 security/selinux/ima.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index aa34da9b0aeb..3d81093d16aa 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -9,6 +9,7 @@
  */
 #include <linux/vmalloc.h>
 #include <linux/ima.h>
+#include <linux/seq_buf.h>
 #include "security.h"
 #include "ima.h"
 
@@ -21,8 +22,9 @@
 static char *selinux_ima_collect_state(void)
 {
 	const char *on = "=1;", *off = "=0;";
+	struct seq_buf s;
 	char *buf;
-	int buf_len, len, i, rc;
+	int buf_len, len, i;
 
 	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
 
@@ -34,33 +36,24 @@ static char *selinux_ima_collect_state(void)
 	if (!buf)
 		return NULL;
 
-	rc = strscpy(buf, "initialized", buf_len);
-	WARN_ON(rc < 0);
+	seq_buf_init(&s, buf, buf_len);
 
-	rc = strlcat(buf, selinux_initialized() ? on : off, buf_len);
-	WARN_ON(rc >= buf_len);
+	seq_buf_puts(&s, "initialized");
+	seq_buf_puts(&s, selinux_initialized() ? on : off);
 
-	rc = strlcat(buf, "enforcing", buf_len);
-	WARN_ON(rc >= buf_len);
+	seq_buf_puts(&s, "enforcing");
+	seq_buf_puts(&s, enforcing_enabled() ? on : off);
 
-	rc = strlcat(buf, enforcing_enabled() ? on : off, buf_len);
-	WARN_ON(rc >= buf_len);
-
-	rc = strlcat(buf, "checkreqprot", buf_len);
-	WARN_ON(rc >= buf_len);
-
-	rc = strlcat(buf, checkreqprot_get() ? on : off, buf_len);
-	WARN_ON(rc >= buf_len);
+	seq_buf_puts(&s, "checkreqprot");
+	seq_buf_puts(&s, checkreqprot_get() ? on : off);
 
 	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
-		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
-		WARN_ON(rc >= buf_len);
-
-		rc = strlcat(buf, selinux_state.policycap[i] ? on : off,
-			buf_len);
-		WARN_ON(rc >= buf_len);
+		seq_buf_puts(&s, selinux_policycap_names[i]);
+		seq_buf_puts(&s, selinux_state.policycap[i] ? on : off);
 	}
 
+	WARN_ON(seq_buf_has_overflowed(&s));
+
 	return buf;
 }
 
-- 
2.47.3

