Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f4/a3D5c"
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB62137
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a06e59384b6so747675766b.1
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701195820; x=1701800620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFDLLt/375wCQgHOdKHJ5Anh2TUSppV9LZ8vI/kMKUw=;
        b=f4/a3D5cfGSKGJqax2ONZHwGCj7gqpY8Y3E+LNjDjPRE17s7NGbLsb6Q6Z4/AaN0CD
         YBwNb8iy8+4h2CipMVsp4OFfQPM4LIYWbUrYZeqdKtr7H8jLmF7f62yKy+Jtef7EjQU/
         L0cNeuIzX5SaXRZ8ruXNaYkfivT28wks/EOlQgktImHpfqhWunQEJrZ8q4B3yxWjP0ST
         iflSVyIgdyhiBqCZYKY4hTtMrcjvPp5/8lrqJJG02CB15ifs2ipL2REYirb6Szl5tmYU
         Y5KD2LTbhN6lepnmhc1Wqb6CsugQUP56v4lWgxoFoimR4y3/2jXdT9Y23gNDQukg6P5T
         3bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195820; x=1701800620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFDLLt/375wCQgHOdKHJ5Anh2TUSppV9LZ8vI/kMKUw=;
        b=BWaDTA3LKx1m/RSK/qFqTGM3xEPwcTpz7P/XvcdZ94yAL41Zv8R/UO1wDdagiCK2kA
         wCuOjlhey+0XZA3ga5vfwRCCflZxerzAHnpFuf5XiQOjuC5wuwQrBPeWU68x/cOYRMaU
         WxsQsUHefLjDU3QNz246v+0rIG976H+1wHG5Fof7IBgfpOVFXs5/3B7/l9mju7wKSXTm
         JwDIw1zKklZRkAKRZqiQC4tLHa6h8RAIc6lX32EMpBcxHHZ0v60XHc23GHgfWw21ycIC
         CcxefI8LAqYVxR9CU1ADGNfYd9lEDbhvgAacbvfn5vrHAi7rsc9K+Mo/m6ef1rZh+1N/
         0Dyw==
X-Gm-Message-State: AOJu0Yz41DMpoxbY/2XJv+kOaFONZ1Q+Oy3JbMNwwRUs/5EBEZbtJLWG
	DDABI96JWbF4Ip1C3CybVlxb9pEaptA=
X-Google-Smtp-Source: AGHT+IFi10z/6a+jL6/YJtfbSZwNCEudJlBPpd1aPvXyD75U3SKaBJ723x+K8PMYZxMHGgNcs6TKkA==
X-Received: by 2002:a17:906:39c9:b0:a01:d364:ddaf with SMTP id i9-20020a17090639c900b00a01d364ddafmr11190168eje.51.1701195820320;
        Tue, 28 Nov 2023 10:23:40 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-003-184-154.77.3.pool.telefonica.de. [77.3.184.154])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709067d8b00b009dddec5a96fsm7122024ejo.170.2023.11.28.10.23.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:23:40 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/7] libsepol: use correct type to avoid truncations
Date: Tue, 28 Nov 2023 19:23:29 +0100
Message-ID: <20231128182334.57740-2-cgzones@googlemail.com>
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

Avoid truncations of the read 32 bit unsigned integer:

    conditional.c:764:8: runtime error: implicit conversion from type 'uint32_t' (aka 'unsigned int') of value 3758096384 (32-bit, unsigned) to type 'int' changed the value to -536870912 (32-bit, signed)
    conditional.c:831:8: runtime error: implicit conversion from type 'uint32_t' (aka 'unsigned int') of value 4280295456 (32-bit, unsigned) to type 'int' changed the value to -14671840 (32-bit, signed)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/conditional.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 24380ea0..420c7b6c 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -746,8 +746,8 @@ static int expr_isvalid(policydb_t * p, cond_expr_t * expr)
 
 static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)
 {
-	uint32_t buf[2];
-	int len, i, rc;
+	uint32_t buf[2], i, len;
+	int rc;
 	cond_expr_t *expr = NULL, *last = NULL;
 
 	rc = next_entry(buf, fp, sizeof(uint32_t));
@@ -821,8 +821,8 @@ static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)
 int cond_read_list(policydb_t * p, cond_list_t ** list, void *fp)
 {
 	cond_node_t *node, *last = NULL;
-	uint32_t buf[1];
-	int i, len, rc;
+	uint32_t buf[1], i, len;
+	int rc;
 
 	rc = next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
-- 
2.43.0

