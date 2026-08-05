Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8082345741
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941063; cv=none; b=jxEuP4pGU1j7B809YIs+isago+BwMM6ZRLn35AfYPdKcwk1lN0hm5lxa0Nisu5js7ENMt8q3TNmab1BU00/seLwxX2949BUaNZwMKUXZmTocr5dD6tkOtslrL6W7eQc4M3dShaZkqqn3r07kz+fDs8kcsV4rzz9E/r6qyHiEPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941063; c=relaxed/simple;
	bh=XCLk6jIIgYdHIBI1LGZfTNRjwSkvRRngJSDKFQ8VxV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxrIqtMubo7k4D1XWNDe4rOgELgeh38vm/uPYGmnFGLJA/XWyYRP3sO3WwiyDDSVwqalQmJFJR1sgx3z1jaCXXRvPi9RLxsF9GRTmGGrfbnRT17xlGEKFpaZJtFC31SAL+buQLA27P7C/ruY6Ca6vCf9BA//hCU8Qcl0xbY0nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9z2vwPi; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9z2vwPi"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c45c580so6415931cf.0
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785941060; x=1786545860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHxTEG+KuwbOCF1YIBC2fJVA36QHHI9bt8Jj24RK39c=;
        b=M9z2vwPiNs+DxzJAgrksPmyz9N3SlWx1n5TXdJZD4mtVAswptEwBYtO28UFVMSbu1F
         Gc4AJMekDKa0gEvGH/4qE5cdBKJcWwtfk0IbtjzIzc9d/kDbDkqXADvraS38B3FXO5Rp
         sfQFwiREbxLl07wQEPwp/KbYP2Mt7xG5p9oiVTpG23+baAVwtSmU0LRnMk2XTXIcseRL
         hM8F+BxGngrhILO5yEl2iP//IgHIWf3UxzDY+fLy8CDKUldqjApdY6WYefMrvpl2zXIf
         Yvv1VZZhJeBY/93VshZ5ApEGiL+BztQbPvFLaN10Q6HnZn7+bijp77r7USVd9OYZEq6/
         ZLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941060; x=1786545860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHxTEG+KuwbOCF1YIBC2fJVA36QHHI9bt8Jj24RK39c=;
        b=JnObr5YyGARBBmzmyYkCwNDoWcD6GRo2loyylzemz4lmNLgM96fVs/OHERKC7nvr5n
         a+VkUe/fOMhDa5aL5OGwoSOIHpmnvd2KhaUGziFPCdHaf9wZEOdK1/yTtvE3AfANbqnV
         tC+S/W5dQMHPo8AnjzqN2XJVo8H4MKwTijqpQJ+0hTUqJ0cP5ygRF2Ycntu37nw7QN38
         TQYu+FIu0QHEr+zQnNNq3tDZ8bKSdopFplqS148ZXKLn+eOVmkOCEHyatcJmG+C2TC9f
         FtcUZ+xs9a2vxGBdmIA5qFUbLopeURoQ13weLSmi6gRdhdlLx6V3H2Ouo8bKZqZ46Rak
         NXoA==
X-Gm-Message-State: AOJu0YyNBoYHbGxDLYKPaXjvA1sLJtnbqEiGhyIL3qQmyaWM9m2nbi37
	MR/fw91fbIEJfBmDaVdIDI33oTKg11xPRCYi7wXCXNIYA477oRBx2Pn/M/XIhg==
X-Gm-Gg: AR+sD11g4gINcZxHAb8zaEZgEkwmzihzBEwDXTEq5ZvPApI7yla3VJx/XPxvgjbkY3S
	rt+Ih0i4BXu2NkFWJ3Uw7bgpvHi+JV4hNKsg8kdFlQ9rVCcUQPVPwhk92n0Ug8kP3griAr5st6d
	UEE3Bmj7FVjsdZZE75teoTu6pzYDDgvmFEEthTOX7HnqnAm6evNPU2SuO/pCHrh0YTUmhSiAaZK
	FF87ZEf0C4hPimncX1KQAiImQknkkur+tOzZF2cI5Zl1PNKm/u8SEQWlWIvkLZ9/grOcmRPmThg
	kzx4MbW8i9nashdlU72O8awcn2/cO3AS/fFDGWEZrOt4z/DsczZNZcTCr/D3iBMZxZ64l839CEK
	A+qsr2M05IcjKf1phzrQuuZqaZsj35eeXaUGahHwXWBLh0+ZdyZDYLfAQyZpxn5ox3CQ2egK6wq
	M+y8I4WDdTD9Se68BLHmZaPo+m/+jFz3LYPX43+wSAtxuGUSsqcWen9n6kf052htLLvE1uZXc0T
	KBS1nYXsUoecN9JRcq004KSVM61Vd0FYlZW+YpilwHgpGoMWMY86ztsrzUijOTt
X-Received: by 2002:a05:622a:5811:b0:51c:ba69:7e02 with SMTP id d75a77b69052e-52ce6146f39mr71057611cf.31.1785941060448;
        Wed, 05 Aug 2026 07:44:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce8975b3dsm21669371cf.30.2026.08.05.07.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:44:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Chen Gong <reister@ruc.edu.cn>
Subject: [PATCH 1/2] libsepol: validate type datum value even for aliases
Date: Wed,  5 Aug 2026 10:44:00 -0400
Message-ID: <20260805144401.55963-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate type datum values even for aliases. The corresponding change
was already made in the kernel's type_index() function.

Reported-by: Chen Gong <reister@ruc.edu.cn>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index a42fdf98..44e26f4f 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1109,9 +1109,10 @@ static int type_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	typdatum = (type_datum_t *)datum;
 	p = (policydb_t *)datap;
 
+	if (!value_isvalid(typdatum->s.value, p->p_types.nprim))
+		return -EINVAL;
+
 	if (typdatum->primary) {
-		if (!value_isvalid(typdatum->s.value, p->p_types.nprim))
-			return -EINVAL;
 		if (p->p_type_val_to_name[typdatum->s.value - 1] != NULL)
 			return -EINVAL;
 		p->p_type_val_to_name[typdatum->s.value - 1] = (char *)key;
-- 
2.55.0

