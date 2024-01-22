Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578273D0DA
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931723; cv=none; b=uIoWjfyHtspqsZCZsGNW4CpwlV3ebr6A3Q5jtmuDJh2tPJCyKIVCFLGN7pJ61k3TSRoO6CAkNQu5LvB2Ll5ioWCGAU6enf468NIAI/hZOmEn0LC7eEko/YcmXFYw79x9sPw/nFCWnyyhSBmvexRywPHsQQht5ABf2kjh9UJuJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931723; c=relaxed/simple;
	bh=dkPahv6YlZ/sYHbzgP3tzSi042jOjS5ANPVzjcsehA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGfovF6dnfEr+p2I8yVn/TLmXsVxbSxh7zYS0bW3KPeZG4eJlXPXY11EGxb4LghGndpAoE/QodTi9fZ341UqfFp/aKbkOJdaZTHg8+Vh4ot7dova9fuVKg7b4+7eR3yu5KHDuVcaJvcWfserQmecdtiFpCVIUXovh7rD3H4YoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fHqa85ej; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fHqa85ej"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2a17f3217aso296692866b.2
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931720; x=1706536520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7HKRji1/kZe1Ormy7Bw/moIWXmrlL/WSIe7DjRu+5k=;
        b=fHqa85ejzH8k4k9d14fSTJk09u+3OnWcggH6o/GhkvxG4MmK5cLSyp0yyBVXLz3ER0
         dTnl6h+shOkF2vNsfqDG/TTEmX9FVVEGt9zwDH+B+NksSacFQi50obDRAPHhhQZWprfh
         iXL6lWSmpe9/AtL17LIo2uJv7BdU2erBqavCmTDR510ICy6zG8hMNKEZNdN3yYqX//W2
         hb98RIyMQkML/riadAS0KwxvdmAtXukrWeJjty1/SRhSFFOowtMihhFcqbVztah/ceOZ
         mmglGNNJOF2c3SnmOPESoka0+sGGXAdNCIp0jQ4Lj0E0d96hHIKwclb8SBOKT8+27xDb
         VWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931720; x=1706536520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7HKRji1/kZe1Ormy7Bw/moIWXmrlL/WSIe7DjRu+5k=;
        b=o1R9luV0hhFnn+Z5mu0UN4bCAU2mEXV0pvw4+pIOZi2vxZExzWIdHT/cIS/nUxBTpe
         82MtpizpWk9glOaLk+33MetaVCMxlFn42AvJe+MRX+ZdntXfWdYTrXBFCPDPI9nkPSsj
         tT1G6/sdc+hFYJF6U7Q/QiK1qstLzVIiPKW74eOobnj98EQMl00QhykespNrLRVTlw4u
         8mXDJQT+1XXOV31h5wp33gJYmojSKgsb8ewsctJ+/QyOIiZZCWX6+fN0MkIQ3/0bTyyK
         m2fZPyCjvdv1Mi8Q48V4K6ofQcyvMcY4IGvwhyuMyX+Vpw8BCfRp98bR/hhM+sHyKvS5
         qEbg==
X-Gm-Message-State: AOJu0YyasLw/d2U+AOScuuYbBk8B28tpa1ODtNKuAcSHbaEm/g/dJPYI
	LMVE3XpZaSc1Mt1Z/+4AsoJfKyw6Y1bSyghGu16rRms1K2vVrnm58K8Ykz6F
X-Google-Smtp-Source: AGHT+IHZWQRMgLjCvTCOyDhA1RgZ4zdxdKVIe5JtktjXSzctRMME1q7kMwUZgoU8dSl3DObuRMtgzA==
X-Received: by 2002:a17:906:448f:b0:a2c:b5a1:f8 with SMTP id y15-20020a170906448f00b00a2cb5a100f8mr2142617ejo.37.1705931720479;
        Mon, 22 Jan 2024 05:55:20 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:20 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 13/15] checkpolicy: free temporary bounds type
Date: Mon, 22 Jan 2024 14:55:05 +0100
Message-ID: <20240122135507.63506-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Free the temporary bounds type in the error branches.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 119b7e36..464897cc 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -234,6 +234,7 @@ static int role_implicit_bounds(hashtab_t roles_tab,
 	if (!bounds) {
 		yyerror2("role %s doesn't exist, is implicit bounds of %s",
 			 bounds_id, role_id);
+		free(bounds_id);
 		return -1;
 	}
 
@@ -243,6 +244,7 @@ static int role_implicit_bounds(hashtab_t roles_tab,
 		yyerror2("role %s has inconsistent bounds %s/%s",
 			 role_id, bounds_id,
 			 policydbp->p_role_val_to_name[role->bounds - 1]);
+		free(bounds_id);
 		return -1;
 	}
 	free(bounds_id);
@@ -479,6 +481,7 @@ static int user_implicit_bounds(hashtab_t users_tab,
 	if (!bounds) {
 		yyerror2("user %s doesn't exist, is implicit bounds of %s",
 			 bounds_id, user_id);
+		free(bounds_id);
 		return -1;
 	}
 
@@ -488,6 +491,7 @@ static int user_implicit_bounds(hashtab_t users_tab,
 		yyerror2("user %s has inconsistent bounds %s/%s",
 			 user_id, bounds_id,
 			 policydbp->p_role_val_to_name[user->bounds - 1]);
+		free(bounds_id);
 		return -1;
 	}
 	free(bounds_id);
-- 
2.43.0

