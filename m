Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h6sPjcF3"
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66113D63
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:43 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9fa2714e828so799332166b.1
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701195822; x=1701800622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+y4ySQ75FEkbGcypJPO7ndJB+RNgGPOpkBKbmn80fzI=;
        b=h6sPjcF3nWKlnzPhDXOq/sGOmq5ZauQ60sFUwZv4g6DRnHkaBGi1IAWzsp2owdcpcd
         6BZhqWeE5CCKYtcWEOZZNGxnrtZAqFFPHFJSxM2zfhqpL5x9jTj+PiQN16Y2al9FcUCt
         gkNgSp4x6IdW6m8aQd6Z17Ag9hR2cWq+m433rRO2G7DvatAp4juG2QPoxABUlrUNplTN
         bm7S7GUvVA9tT5dI9eYyBzhuAvxhYqzm10BWsQdTB0buxWYh/J+VeHFOg4VDpQvaa0tq
         bQ/bnuJUFg96+1GQt+RSBeT0eR0RqVLoa+kgLWKTbD3V+gUPUxQpA58aERLhrLrNSaRT
         6kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195822; x=1701800622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y4ySQ75FEkbGcypJPO7ndJB+RNgGPOpkBKbmn80fzI=;
        b=kofHxkjUOsYDkbxA1hEDUvTBdGImjDVpudYiPRUsLDZuLYk5NUL9V0PrAYQluozRfI
         zGFqHobb1WntxhdxbLhZQxKXCGfjPPdMELpmqBJ0/00F38TkNtmiAStZTvvlRXL3aN4O
         Cqq/1NhAZMVx+AiS4dUjtG9nAFzUcAMlKxivM0CxZNWfxJHM1fcILHKlcF5dxd4RiMFG
         4ld6xrfVLLjMfL3vMAcAzPAljBQ4m5LJ7b8V5Yb+TPx1qY/NDo1daE9+dLTTUCotsEkL
         xpCFV+QiWSj9DbLKpZfrZpOqLYy/2RmYs0exmUMm3kH9jFHKkdEldfdRm89b6d6L9Qei
         HVmA==
X-Gm-Message-State: AOJu0YzYDYk7aQhEKbhbdmRbys1H+GlMMm615fi8nmrHUaL8NxEoqrOH
	9bpvWXzbS3AsWb6SxJhEOg12+4KZRYY=
X-Google-Smtp-Source: AGHT+IHIQy3v7Kooe1OH8MZfSBEuNKuj9v7vkbkQ7xeUGO/RYaqF3HFlwnwyxGfJDX2CwzFF8npiHA==
X-Received: by 2002:a17:906:590e:b0:a04:837e:a955 with SMTP id h14-20020a170906590e00b00a04837ea955mr11071655ejq.32.1701195821678;
        Tue, 28 Nov 2023 10:23:41 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-003-184-154.77.3.pool.telefonica.de. [77.3.184.154])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709067d8b00b009dddec5a96fsm7122024ejo.170.2023.11.28.10.23.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:23:41 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 5/7] libsepol: reject invalid class datums
Date: Tue, 28 Nov 2023 19:23:32 +0100
Message-ID: <20231128182334.57740-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128182334.57740-1-cgzones@googlemail.com>
References: <20231128182334.57740-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Internally class values are stored in multiple placed in a 16-bit wide
integer.  Reject class values exceeding the maximum representable value.
This avoids truncations in the helper
policydb_string_to_security_class(), which gets called before validation
of the policy:

    policydb.c:4082:9: runtime error: implicit conversion from type 'uint32_t' (aka 'unsigned int') of value 2113929220 (32-bit, unsigned) to type 'sepol_security_class_t' (aka 'unsigned short') changed the value to 4 (16-bit, unsigned)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c          | 2 ++
 libsepol/src/policydb_validate.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6ba4f916..f10a8a95 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2255,6 +2255,8 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 
 	len2 = le32_to_cpu(buf[1]);
 	cladatum->s.value = le32_to_cpu(buf[2]);
+	if (cladatum->s.value > UINT16_MAX)
+		goto bad;
 
 	if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index c2f19fa0..bd8e9f8f 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -389,7 +389,7 @@ static int validate_common_datum_wrapper(__attribute__((unused)) hashtab_key_t k
 
 static int validate_class_datum(sepol_handle_t *handle, const class_datum_t *class, validate_t flavors[])
 {
-	if (validate_value(class->s.value, &flavors[SYM_CLASSES]))
+	if (class->s.value > UINT16_MAX || validate_value(class->s.value, &flavors[SYM_CLASSES]))
 		goto bad;
 	if (class->comdatum && validate_common_datum(handle, class->comdatum, flavors))
 		goto bad;
-- 
2.43.0

