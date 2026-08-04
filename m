Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FC34F46D
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867924; cv=none; b=dQ4Q4JQttj9OHuo03R+w0qJcXQ3EIVyuUhHvJgxkfIeqJWqWDNxf/iWXxHhkcSv6j+HWAVXWkT9BJtw6G9yZzwO8WQR6v8vwPShbV5o86zfecgvhQjYJFDbo0A9ffUvb4S3WtpnRHG5ApakyuJpAq6myTwZ0oAZf6wDbNq0d4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867924; c=relaxed/simple;
	bh=J02ULk01gHVvl90OZRBWcDcOqViSd+3f8HBxz5ECkaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z24Q+J7Er0uIvjImVPJt5CdVA+XQBDaLSG75eEgbQXti2ec9JNA5YL/xLi03i8dVhsN9CklrktNNThXPkDLJvFwthxzeOMa5etgVI0CqQeNWhjGZzg9lagjUXXsDaeedwXotQLF/R1Qyfq76SD56w/kjxMlxx2RFamt/ta8NUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPpa3Z49; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPpa3Z49"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so1392006d6.2
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785867920; x=1786472720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SZGpJc6c1BkjF/xUqR7rf1w6WRSi/QfhsrOxeXpbKLE=;
        b=pPpa3Z49/t60exqzPSTWZ+2mmfsEZRqdqkcDcDvE598xQ3gV0pGWiUCqbz8Vex33RH
         T5b28H4gYyJau6ABklPK4uLr2Nc5TuiRH2fDJa+xLTXZDjPr1oNfYa4TBGc33Y9c/xCV
         G5HmZ9IDaHba/WVyJY+bkSbJmZDAAKzRfvOjn7VUq7/k6RoTJwQPAlahgEySMpOJdHat
         Yl6G5ed6YCy6mXzHEv+aQMJLXo/RmDiqzGXEV5BV1B5FJCEP4mEPus7gceu0X2OVzQjH
         38SX5jAQkkb2hf4RGOjqiWFe5MO3IlwL/YL63IuHBypDiddZnnybPXnRkZBgnRL/r0+x
         m+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867920; x=1786472720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SZGpJc6c1BkjF/xUqR7rf1w6WRSi/QfhsrOxeXpbKLE=;
        b=QaP3DEuDvYVYEeNzHxE0aG6Vtp93UxdmwuglOHZ87lzFNmeboTImPFTIIIL6CPg3kD
         LHcHPwKQixDUwadPe0W+ko3dWqf2G87AbxQXDeLj0pdIpEWZvBXfRxaSturrF1fjm2Fl
         CMgoQWAuU4tuTjzh8gmRhLckx2rv1L2kcOLzYIewQbRkZ7IOpY3xuqhTx73PPNQ2e1/D
         F3Kb2ouTJpAAspWB6DRyytC+aXXclctDheEmuZEEsmTo/5ntVEyr3gnJBbu+hhM2uym+
         m7lqeiTTX7vO16szQNoOcY5yeISVLEO95T/vdAjTFh0YDBHkUj/gOuZRx6+x1NqS9VuD
         19Ww==
X-Gm-Message-State: AOJu0YyU0uLS1/To6emZ604+nzEV9wpBLtjLUyy3z5BPbRdceTXMJXTT
	5tO+dmQymPqAkqsUJiNaMZTcRFrt3vhqTIo9Pwry3xiF9nOWF+9NiAGV8I2T1Q==
X-Gm-Gg: AR+sD12oaIAj3hzmwB+uGNBWITTEKQtRmkf4bju7SyZ9aIU71+h8his6Sb/sPk8rja3
	FPeCVnyc6ypw7jXOL3S+PNcLFViKJ1wbcETH6TubN5aVqCOoPYGBq++270sfS5aeR7m00Ihh2BK
	4W2j+/64ZNO//pwsnU1wDQlp2OCIdVhRLwzkTfqxgfWXMyafYXQqdM6N6rQJg5CGpPQynP1Cky7
	RhUJZf5Clux349+vk/AnKOoVl/FOE8hUID+RIfaEsSoL/mfVTP8wAdZhS9wjCaAcrb7oqPGplgi
	zCJBSVWPa+3OS61KAPv2iRbBj4n0QPPEFg4Zi2y4Wv/Uby9RiYJthAW1yXxe5wi1XPPa9S+skvM
	pHcePQi2ty8+jaf8hyVOwr4JpKOSk7+Rb49p803kAt1SFM9lM8dw35zuGosHoCsoAQVKLcEFvXI
	zWBcTkbxSKUQHKYqse9MWxLV1lc3lNHDh5HSGOhecmE+cgxxSSU616hk8l56Fpwzgg4oZPED7U+
	l1bY5D1eJI=
X-Received: by 2002:a05:6214:2685:b0:8f1:8737:d794 with SMTP id 6a1803df08f44-9088126d7e3mr14208156d6.16.1785867920141;
        Tue, 04 Aug 2026 11:25:20 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9088008e6basm7463976d6.26.2026.08.04.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:25:19 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Non-mls polcies should not have any levels
Date: Tue,  4 Aug 2026 14:25:10 -0400
Message-ID: <20260804182510.27921-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A maliciously crafted non-mls policy could still have levels in it.
There is no validation of levels for a non-mls policy which could
cause a problem if those levels are processed somewhere in libsepol.

A non-mls policy should have no entries in the level symbol table,
so check that the symbol table is empty when validating and return
an error if it is not.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fc66a4c7..fa36950e 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1024,9 +1024,14 @@ static int validate_datum_array_entries(sepol_handle_t *handle,
 			&margs))
 		goto bad;
 
-	if (p->mls && hashtab_map(symtabs[SYM_LEVELS].table,
+	if (p->mls) {
+		if (hashtab_map(symtabs[SYM_LEVELS].table,
 				  validate_level_datum_wrapper, &margs))
-		goto bad;
+			goto bad;
+	} else {
+		if (symtabs[SYM_LEVELS].table->nel != 0)
+			goto bad;
+	}
 
 	if (hashtab_map(symtabs[SYM_CATS].table, validate_datum,
 			&flavors[SYM_CATS]))
-- 
2.55.0

