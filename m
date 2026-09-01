Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C33437455
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283300; cv=none; b=QgQwG+ym4kk3Oz07/U13Ti7XsOvh9UoWh7Ep1JvByVa/2MZ4PhHrmuGGYpVsM13VN/CCOvleGN0mKmJ1fBdQCBrIwuJmtaRbFt8a8xH9xLSzxToNgPmEmpba0NyKBQ4RUnR0+ElpvjiueluVjtQH9fOZSJc+GXMvGFBGKb6bxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283300; c=relaxed/simple;
	bh=4fVAO6wG63qDeeMBgxnHV6o8eNfF7a8niqbMaQ9Vd0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trnzZaBJ0a21qYC8EB9aRUwTVLMwnapE5i1YApKZ9roBI/vkQ3gmJSXGQ8XWiNmSlNmK6POx3HVFrmDg18fJrJg1A4AJWR6N2y3tR6J7Y1nQKHDvSLw4mlJMwfxDHClXLLENVLJBDSiCvUsMWoteqErzflGb7sNEqUA/AqTgxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdXldH6H; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdXldH6H"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cdffe8e3eso960966d6.2
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788283298; x=1788888098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BICnBN6KyV0n1BCaAVx/DZtuAmgWgfGgS/bugDuyx7s=;
        b=ZdXldH6HLboJHbXGKtxrVsUxWF6y0n8A9X3CBzsTstEZrOTJO+opnZcVo/hVla70Jw
         KD0+JG74E5AuMqXJMFRx6pRdG1uSfakSlULWyjpfO7ePFHPu+h4qtPEdEqI13mbkc8Ga
         4CzmdReN+dYT9WUYzVwLnOp8za+IcOP9RIdouR7gzHyjBUPXxpShPQc5XvBr/znPyFZN
         BNOguPxOFjGMNQYUsOYpvYn4jPLNxZyNvLNxgoxYLcEj/rWWjkiZDCQZzxUqHUG9MZDj
         4/Jq82gRQNpWK5JQw6ltn/Dt/5fyHsfnMZpRREdFeJ7ZWp2znp65iE5/AvaaaB1lVjF2
         aqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788283298; x=1788888098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BICnBN6KyV0n1BCaAVx/DZtuAmgWgfGgS/bugDuyx7s=;
        b=Ip3IbnBRR9ioDo8G3pdHb/SSbS5HR6hacCP+cq/qbQSrctaVGTmZhDZoQs56pIj26w
         IE++lYtDrt+L2iZn57KDYOrPjcoEZIBpcTAagCUz1hJ+cNSUWTCO/7R70msQB9j+i1ye
         BQB3BdGPfSrTk/9AllYiVuRl3iVltApNVHDbWgAkDSID1nSxH/5We3aNlpj35OuYHfgy
         aWRHn8rxtWWiJJ+6Ram1uqtQk3R1M4xFhutYEm74DPTc0vsRHRGR7elEIOOmvSHjnNGb
         obsq1+kd/zze+rS4Tm0b/SwW0ZwjwPVTnxGMT3SV9qdU3Y4LDEPhpJuGSctNYDaPo/Z0
         vBNg==
X-Gm-Message-State: AFuF++kov2mZF1qJagAE/vlQdcRCAbJy/hdB23lfdJT0uabcaQaaOShP
	5g5EbgKBwUzD92hSDCMjHLX+8sZ4wZVOtKBCQ3cHhZS5BuZfgib9zGc7CTWGoA==
X-Gm-Gg: AYBFou1ZDxStycvEds2eZCy/hpSl+qqXcbYydOqQFr+8j7wPWoJc2v4upUPhzNG863N
	DwQ8xUMrxSeswYEIJUT3bppuGcxYyL8aIKC+0CaQduoPfNTjAkHe2fu7TUl8hImj3O/yMIcUpfg
	dYylfyI8mRR8Z/Lj96r+YQiZ36pQXKlSIzqSP4Jj8OglYxop8jYidvlyxf2sjcKrKblssGag5EW
	xp4oqBMo+9sNIa4iTJhlPyKWG9X/5t2hohwe9dAGyYcXTn6ylCvPRqVhb5lbarlp176vsF/qcfj
	qRfx6KirTOTCTHYjKIMmOsXaOWSk7/nxnVev+HaaJzqc2dNMWJGPAJsYH+gH72dKgTHPk2ROF08
	UoEZstsXS3/DmlJGVc8mQyz4MWm15F8P/4NycZ/rwdiDUiBcuVxHHv4DLN3PnWyq5P3MpC8LLhD
	GaPMW4/wODjqA5CeELKdETPcEZwZIde8fnL+OR9QqlXViTsuBbteI7EngVwdk6UFhRHsYnt/btC
	fmKKoYqnGk=
X-Received: by 2002:a05:6214:85d3:10b0:90c:e141:b1d8 with SMTP id 6a1803df08f44-90ce141b315mr353189866d6.16.1788283297776;
        Tue, 01 Sep 2026 10:21:37 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ceaf94d8dsm98237476d6.1.2026.09.01.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:21:37 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Validate the genfs file type class
Date: Tue,  1 Sep 2026 13:21:27 -0400
Message-ID: <20260901172127.12583-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like file contexts, genfscon rules can have an optional file type.
These file types are mapped to the value of the corresponding
security class. If no file type is given, then the value is set to
0. During validation the value is verified to be either 0 or a valid
value for a class, but not all security classes correspond to a file
type.

When validating a policy, verify that the value is either 0 or the
name of the class with that value corresponds to a file type.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5fd64b12..34182e8e 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1628,6 +1628,19 @@ bad:
 	return -1;
 }
 
+static int validate_genfs_class(uint32_t sclass, const policydb_t *p)
+{
+	const char *class_name = p->p_class_val_to_name[sclass - 1];
+
+	if (strcmp(class_name, "file") && strcmp(class_name, "dir") &&
+	    strcmp(class_name, "chr_file") && strcmp(class_name, "blk_file") &&
+	    strcmp(class_name, "sock_file") &&
+	    strcmp(class_name, "fifo_file") && strcmp(class_name, "lnk_file"))
+		return -1;
+
+	return 0;
+}
+
 static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 			  validate_t flavors[])
 {
@@ -1639,10 +1652,13 @@ static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 			if (validate_context(&octx->context[0], flavors,
 					     p->mls))
 				goto bad;
-			if (octx->v.sclass &&
-			    validate_value(octx->v.sclass,
-					   &flavors[SYM_CLASSES]))
-				goto bad;
+			if (octx->v.sclass) {
+				if (validate_value(octx->v.sclass,
+						   &flavors[SYM_CLASSES]))
+					goto bad;
+				if (validate_genfs_class(octx->v.sclass, p))
+					goto bad;
+			}
 		}
 
 		if (validate_string_field(genfs->fstype))
-- 
2.55.0

