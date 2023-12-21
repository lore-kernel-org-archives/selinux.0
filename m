Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33C77F12
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bdVkLlnL"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-781001f5e96so82991585a.1
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197563; x=1703802363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFJqQfrNvmNe2/yeXs8ZSKTggsEQPBIpmD/8sAQBU78=;
        b=bdVkLlnLNLkUJUahuDvu2AnbKVbvcaMXPHh1PVFjiD9a7mGCd2E+Zx66Ez5iY8YA2C
         bMmQWMskb6Czvvghs36fvUzOLSn2/S6WlkRvi0iXBVUjwynJccFCjdZlRuBIAMxqZ8Fn
         dC2fJ3mEQUEjKm+UAi3hNWWiI+FQW8jhqD0G5nypCRTMBgYgUkJa2yOuADKgVdHlL+wI
         Hv6nUvOzsw0AwRwGS9RfpvUKI0aRlhKlmLGcLQVX+FS3WvQDID2LYptUopXaFYcKkpOt
         MpzGBpFeerbkmif4vmmMDl/I9cKXakVkB+NBqVfn8hvRMIED71g6Whw/OrYIrKY+CB5F
         S7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197563; x=1703802363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFJqQfrNvmNe2/yeXs8ZSKTggsEQPBIpmD/8sAQBU78=;
        b=PJA+aUrTLpsX2+zRFzAWJ6IAsD5WEekDgf4M+jVY37C43udaBmyzmKDkoY9WjYXyE3
         vFYQ+VZAGuVq6Y1cb+O/xpJqeOhjHiW6CZaAewvE5RYGa3B8mMRxdR+6oqSUYDymdnmR
         EbfIRzhwrvAKoPN5GoBSnN/RksV441LYaU82UBkwshbjdvJekmVYFSkFL+Uyn71pnfh0
         3PegjFmfDevl5oDYuuVN1nKbpLEUsgvEVJrRjVhYVSeucrWqe3fIJMuhEwddcX/oHFzs
         5UIEzRgM6AJkIkQIRQ0RMo9xiKMVsLatzvv8F1BjNC4yaBKpw4MUpir7qsEfRY43Z6y7
         WCUw==
X-Gm-Message-State: AOJu0YzQnanjomawH4f9GNdaJtO4psoFs8p2jbX5aqYkv1giACODbGvY
	Pk/X35qhJ3juJb5XWZeznu+aOQ0ddEdtXRHDZLc1aER3cg==
X-Google-Smtp-Source: AGHT+IFKdBN26iWv0n9dvYNvjzCZPr+1R/SH7eWTxUAgFINjRlOC0Z0qsMk10vlQ5A+I2HWl9NMASA==
X-Received: by 2002:a05:620a:89d:b0:781:2c24:6ace with SMTP id b29-20020a05620a089d00b007812c246acemr48864qka.87.1703197562705;
        Thu, 21 Dec 2023 14:26:02 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a110400b0078105826d55sm960103qkk.74.2023.12.21.14.26.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:02 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 01/15] selinux: fix style issues in security/selinux/include/audit.h
Date: Thu, 21 Dec 2023 17:18:44 -0500
Message-ID: <20231221222342.334026-18-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=paul@paul-moore.com; h=from:subject; bh=u88UAL5fNMnsh/AdypXqP9w1UNLbQ/7eMTLtXG0YC94=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLruUt7QK6qERbnAjbx7BEkt1oVbMyYNVGrL1 r3hieJcEFeJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS67gAKCRDqIPLalzeJ c3QzD/9rWcGDKOtlGiaw8ZRjQpzrvLmVJVnpVHZYhdrVQaeimN86lZTmWKeh+3nybWrPTla2AAn kWAABlCqEeQTquzX8MWVqlkDYzy6XVFwsKffZeegizhsmLM6dbxC14HJpl1yfezDNbe05gGYFn6 CaRmteJc7IJB4KgTB4P396niztbrWFs4ktQXvQD+u02NyJPj8bG+UCle3/HvgT5QyvGpe2OULKb zHkmvb+tga3g9WLKbiwbWKXVfmuZhLnqar2w7Wavq8lgCDHDaLNEGYyr9a5RFVkBLwbl40WEG5r sAXH9JdLCTWiLmVcFame/qbfwaJ8b2FNS7w8I/NqIFpqmkcwNbu3uW6CttDvebdLxi8FNr1XB/S NW5D1WXkXr69PF+VeQskcErdWf3CNwCNXe90Rkx4mZpTaDY19k2fGLrIVlPGx9w8Va6u8YoFnTj /6zyBg4dHKthER6J+s2goghK/Uc2EgY8Oqqdjih6EHKHh8AJx334LifhXwYoMk665B+BvNNUrz6 32y0HwfU22YrWU+3BdzuhXiz7sHB/o0fbyFqBtQmchssHq3GNhbLrYkwNpFRtCfB+GOSluLnYa6 JzHEik/ZoIw9bQG9Bw8h/Ug2UDKhC4nAEQlKTUVaFzkU5p7dOwu/0ATX6sWi3PnYJwNEwBlHZl9 VHJYuImiihQe/hA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/audit.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index d5495134a5b9..52aca71210b4 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -57,4 +57,3 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
 int selinux_audit_rule_known(struct audit_krule *rule);
 
 #endif /* _SELINUX_AUDIT_H */
-
-- 
2.43.0

