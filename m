Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T/KcrVdR"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D8F4
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a29c7eefso7625701e87.1
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701195820; x=1701800620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFyQ53dDVlwujwxUmvBXTBWl0nCizpACNjGojvAvwQg=;
        b=T/KcrVdRwUh79e38mCr4wKRJT6vxiIZcnuBURvFLsnnFwSnajrrmKQUdKgF4E3YE5u
         QrWdjy8RRtXSP7z2hTucKUZBCA7e+Pakh9mJrL5xdfuaRo69LhvrJ4+S4v3HVLLgAS+9
         YNy1e0UbU93kdVuRN3e/LCNAXmhwjVbXw+JqbsSXWkS0T6aXzxCoExyvm7AaFNQkOneG
         0wqf3l6vkckqrwRFQ5HVNIv8cKMZc7L4hnFd4YwPion2gz/tEdC3plhAPxWlR8g8i1by
         Tz7kVAp8f9QcVRm1Knmy24+cycA7NcTtDR0RatB+IgJc2ajlg1WWf1ulxhMOsqy8ADnm
         H7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195820; x=1701800620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFyQ53dDVlwujwxUmvBXTBWl0nCizpACNjGojvAvwQg=;
        b=Oq4sSupOXWsZCkBN+AKs6sCd+eYmyQCKVzWRLLIt4scME7yJ9IVs9scBsvqYmC6AHs
         0un4OetCDjd3LnUBCpF0wK7OqeyTTDYYr5Sxotf9P/TENHVYdZs3dV7x+BXXL+lC9RXL
         yn/yxpxppvJxLo2sDHs5TJMPt03L83yLLVf1+1ufH93wVyNtsFt0e7+bdiSekqKh1YOI
         ITquNNwcz7EaLnHJJXjaL50F1MgArGAiJbeg2eBNn7e3HqwJ5yf+Y1nBrV2YJ53ffNGC
         C65gMcggdrVZGIXvp3kxEFg87uw60GAdTwg219F+04SCB1XiVu1eB+KWyiSL4cJuHOGl
         G4LQ==
X-Gm-Message-State: AOJu0YyOctJ3Ebct98VYO5Fey8jEugk6oJqQ96cCgq0XhW9GOrb9T8oW
	8qOQTR+4NvG/SaOJEvUPV8ACRCqpCRI=
X-Google-Smtp-Source: AGHT+IGrxBVQvv6xPeCvW2T6OyKiPzf+gZ7RJK2WlmRyPPkFyYAQdgKwIV8YWBZQlBfByOGdBAB6rw==
X-Received: by 2002:a19:ac47:0:b0:509:2b82:385c with SMTP id r7-20020a19ac47000000b005092b82385cmr6853950lfc.61.1701195819856;
        Tue, 28 Nov 2023 10:23:39 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-003-184-154.77.3.pool.telefonica.de. [77.3.184.154])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709067d8b00b009dddec5a96fsm7122024ejo.170.2023.11.28.10.23.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:23:39 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/7] libsepol: validate conditional type rules have a simple default type
Date: Tue, 28 Nov 2023 19:23:28 +0100
Message-ID: <20231128182334.57740-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Similar to unconditional avtab keys check the default type of type av
rules are a simple type, not an attribute.
Since extended permission rules are not allowed in conditional policies
this check does not need to be performed.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 8b87675f..c2f19fa0 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -885,14 +885,21 @@ static int validate_cond_av_list(sepol_handle_t *handle, const cond_av_list_t *c
 
 	for (; cond_av; cond_av = cond_av->next) {
 		for (avtab_ptr = cond_av->node; avtab_ptr; avtab_ptr = avtab_ptr->next) {
-			if (validate_avtab_key(&avtab_ptr->key, 1, p, flavors)) {
-				ERR(handle, "Invalid cond av list");
-				return -1;
-			}
+			const avtab_key_t *key = &avtab_ptr->key;
+			const avtab_datum_t *datum = &avtab_ptr->datum;
+
+			if (validate_avtab_key(key, 1, p, flavors))
+				goto bad;
+			if ((key->specified & AVTAB_TYPE) && validate_simpletype(datum->data, p, flavors))
+				goto bad;
 		}
 	}
 
 	return 0;
+
+bad:
+	ERR(handle, "Invalid cond av list");
+	return -1;
 }
 
 static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule, int conditional, const policydb_t *p, validate_t flavors[])
-- 
2.43.0

