Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783935;
	b=zml5qrIAg7Kq86f/qFzTNRrRFHZkH4eegSXgSKBEAmG364cX1QqSX782tT3Yql1aojuk
	 iEHVOLMeOi+5h18XTqNZJ8yTk6B3hrN7VKpzhJLgFsgC/oCU4Izd5ZdcrysedM37cnasF
	 QY51MC3V4rGrMA5/6CFNI1Jbtz3Y4PHwbyMS1HFVDNOvWsMoqElnh+iHWUCLZaBKcBl39
	 0hWpwVqMdtBitPqsghiVL0LlLpzqH7DlnB7Qz/9B4Qr+qYf3+1rnhhsLH//F3nT2RQUls
	 2Ga4jM71U0hEDNF3orq4oFbnU/RKDsvT7ezY7ZHFe0xkapEnCr4lItLQ5+xPjShezBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Gj0u+Nfp6NsF/o9mJITWP+ndlH2sZ/QbfDTP9JCH8fI=;
	b=UzRx5cAuibu3Q9URd+YHXef+bu9wq8LTjmxPR+gilA/OMBCecBFrImylbXP9illIpyG9
	 Y9mUDiZ7CzMSqxqCKit3H9p/sWie8+VH0evJe1fJKJZSg1TIbh6ELZLIz5czm3VMskD8E
	 uE5AUixYi3gzZX1yjmUZja3qXAhkl8VynKWi6Pq/hyRdiBk1wuEIM9ryiZV5/rsHpKlzq
	 /rcCiz7ifFjStag7OnlBm99WjW8rNe9E37ijFP+2G4Y4JLmLiw1gnUftTKVa8166NgxMa
	 +PXRZ8DZqCiS9dbf+xvLPfohfKV3FNel91anibLCae/HShdppI3cvNu1X20E6L7GJKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SoQYdlYz;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3F606A31A
	for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 19:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C3F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SoQYdlYz
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93cb9e9405fso60760285a.2
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792783934; x=1793388734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gj0u+Nfp6NsF/o9mJITWP+ndlH2sZ/QbfDTP9JCH8fI=;
        b=SoQYdlYzUdILGsf7BdA6/DIsYONAGkgUxGop4MVqeOJ0ME2kNzIpv/+kQ3Do8JHqBj
         L2ug1Z+jeLWpNb7Pe3RNF7FgaQtysujbSVBSl+nayUvngbEwBWkIecVB33nTLS1mYEB4
         QqmO4dljk5yN6qmZFOi+WaSikdcP1NzcqAaBNVZawAdJttvuF4gcqNBlrvrhNRm+jyZh
         mEIw4OHJYaJCxg8Pk0ixbxvQU4+Zp1G6ZWM0vDl1rJ4ZQD7rpGhc+fVcrhsQ0GwWh3D1
         HsQLvHdGt0xkZFDNsdLPjFpUAAYvtQHplvYV7eyVDi4SlnJttgoX0XvVxiczipPAwfSf
         aFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783934; x=1793388734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gj0u+Nfp6NsF/o9mJITWP+ndlH2sZ/QbfDTP9JCH8fI=;
        b=JeRgAgdeaQ/iNSAk6ILHFFetSGM10zq7Qu95IrEsYaUnycdMpL9knbRfclVBz+sCA2
         0aiNzR3o0JQaw06Uw8yOnIbvd8vtUouUKCqgls8FKYMHLasOTsSxFVuAzWRB4GaZNmht
         +CNvQfn/P0a4WK6jeUYnx1mox2Tc1CBca8SvEgSAvEA4pRrhMHEQoKO1lNZNHT7EsZPT
         Sp8FgvdTnG7qNxDT5UTiRTvHlII1X4DO1mu9NPvTaq3qjoLP1MO4diWpt2nTnO29nEav
         lgOiMNZE45k8HOAq1+uvPhO/Gknx5d87aLDIYKczDmdpZMk/ti7NJ8uMAP/+V7KBZZBW
         W0wA==
X-Gm-Message-State: AFq9FYJN7RWzBdDKgH7zzzvAFE5GvSkmZahFwisvh1/GXku/BIeEdeS/
	qdUND5ZS19zjMa8vRp9yrDBkNjjbKXCg92RFJvq+56A9N8wXYDZny0auyGoKK8ii
X-Gm-Gg: AYBFou35nWBZLz/yHHJ/pRHlub568EFBDd6tzGorbWuq2RrnHvdDgMa+uFQVdNJX+Jx
	Q6dAZmso7WavpNf9s4xPFuE0i2XRF2zlGd1ZsyhKrUjXdpMwoANh+ykadZ/IfiOQoOvNPLxbZQy
	41whRgNVfSzs3XeqW+xYMGUdhw1hhCM5ZpQi0zSnN0s1Pr1hD67CyZ8DwftXvuxcOkypNumdD5n
	79TjJGu9/DA9pz5+z186J6NL4WGZkpz2ZT1pGD5wLuwL23onbqOICnfQxDGEyboRDh2KOr0LgAA
	hl2zSb7GRfPNk1i07vl2uD8G9PXKAmw4Ngf1T+mjpGG0UZaEr2WQOva+aecESw8U6NEC4IuZ4Sv
	AIabuMkzmb+t+5KhbQmN0b7mIG4EpvJ0HpRV9yO+yGw4SY4Q3NX1YZapLM4cH780xgjwlrEowL/
	RQZoMIHcagUDq0Wfup5hktw3xrKkZfuPzNuA0dtpR+XdDEvBgUVN7XtYIjJPYRo8Vr0BEcsUJTO
	UglioknXlHFkKWKraO+RCK3k8I0BcdfRZZeJq6qNy27wxb/iWuCG/lB38pKFhg/yGIeSvYUqRHr
	bH6UTreIeyCtbjG0ygwiC5WrEk4famv39iTvZX68GqeCqrnX4qWui24Z2U0um2fwE3ZgxafNElB
	HGRE7vv/LOoFndjtD0JJ+o55PZ7hqdTt7gHRH7sXoEA==
X-Received: by 2002:a05:620a:4728:b0:93f:2236:a61 with SMTP id af79cd13be357-940ef996db1mr2888385a.61.1792783933613;
        Fri, 23 Oct 2026 12:32:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b1c97esm94134785a.30.2026.10.23.12.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:32:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cathy.hu@suse.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: use the availabe user name when a join fails
Date: Fri, 23 Oct 2026 15:31:59 -0400
Message-ID: <20261023193159.63971-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A user join may only have an extra-data record. Its error diagnostic
unconditionally calls semanage_user_base_get_name(record1), which
dereferences a NULL base record before the logging callback runs.  An
allocation failure with diagnostics enabled therefore crashes instead
of returning an error.

Resolve the name from whichever input record exists before allocating
the joined record, and reuse that name in the error message. This
covers failure of the first allocation as well as later cleanup paths.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/user_record.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/user_record.c b/libsemanage/src/user_record.c
index 18d13e26..813924d2 100644
--- a/libsemanage/src/user_record.c
+++ b/libsemanage/src/user_record.c
@@ -255,9 +255,7 @@ int semanage_user_join(semanage_handle_t *handle,
 		       semanage_user_t **result)
 {
 	const char *name;
-	semanage_user_t *tmp_user = calloc(1, sizeof(semanage_user_t));
-	if (!tmp_user)
-		goto omem;
+	semanage_user_t *tmp_user;
 
 	/* Set the shared name from one of the records
 	 * (at least one is available) */
@@ -266,6 +264,10 @@ int semanage_user_join(semanage_handle_t *handle,
 	else
 		name = semanage_user_base_get_name(record1);
 
+	tmp_user = calloc(1, sizeof(semanage_user_t));
+	if (!tmp_user)
+		goto omem;
+
 	/* Join base record if it exists, create a blank one otherwise */
 	if (record1) {
 		if (semanage_user_base_clone(handle, record1, &tmp_user->base) <
@@ -305,8 +307,7 @@ omem:
 	ERR(handle, "out of memory");
 
 err:
-	ERR(handle, "could not join data records for user %s",
-	    semanage_user_base_get_name(record1));
+	ERR(handle, "could not join data records for user %s", name);
 	semanage_user_free(tmp_user);
 	return STATUS_ERR;
 }
-- 
2.56.0

