Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677083D3A3
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931723; cv=none; b=RJ/CQcLs2CoYrS1fltiECTaNOH++3ri/Lao54V1oDVPkALMHaHVZuShNexfWjPpTAtvnHNVVFk4baRTYYK2Nlb+JmJKVfgByqp3foI8DR7RZCIHZ5DErc2YXJRHTzYjMYGrkCrjoRlmiVEQRbOowwC4LyhIzmFZ2g47xhgwb8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931723; c=relaxed/simple;
	bh=xhn+8jUT8th3hE8JwOy2XbqFh+qS8P95Akm+M37soW8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8rFhkqdaBqa116fmM26iRGJIy5tuU21PyKM+kqnMD92EXEie9tEla9y2Zo7mk1PY61+jcBymKyuWsReZ3kKNBmlFLPnvItbgPq63NsmWL1XbgeKNClaUp1HOn0GtzpjrjCA92ORx2rjOP56haw5x1iLwN/Q3gFjKiK/x3oSjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WPpvtEwN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WPpvtEwN"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2dd05e02ffso308929466b.3
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931719; x=1706536519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAeqFywBfGyeKbKZ+sd3RLTsD3xWpoqy6omXgHlygBU=;
        b=WPpvtEwNmGQdHfOCA11qi3fgcqxPDQ7QlWCrqqeUJ+W5V5AUfBG3onDiAGf+jN9MB4
         Zvz4ownMjXo7yaOhjtVZlPtg2zBwBn19wq/uzz+9GufZBJ/JES+O6WYON7l2QNfWrzvA
         BMnX63KzjmaczNakZIYGcjnTXvJoSrHjNxcc0WSuJiegdMqpdYr0kkwW4dIwdrC/2kOe
         29h13vOVh6LYEhN+qfZWX8WxUkxfD3hIpzSutyiGqiLbmfnWM0hZUkVq6Q/mh075J7+f
         fUIOkGf2zEMNzW6+j7fyO8i8Dy6EtdwlgjbW9A2s8xaAIG8cNSoDrsMz0M7Hs0QdEksn
         jENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931719; x=1706536519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAeqFywBfGyeKbKZ+sd3RLTsD3xWpoqy6omXgHlygBU=;
        b=pFE8u4BDocN44toh3foI7HST6amZ7Iddp9AQwU6Vnrl9P8NHeeE+y8oZEK0f3TIoUL
         1RR4+7VeJZlAm1dcjqRkJjhxtaOXkudk3SqOh45czswNHwba2yuhcTLl2eXLF1B8DN3F
         bydBbJz4hQifNdoUEJ5rBMMhAl5KEYpKZJMwUHrNFGhIebcD6yZVuq8oSRc0osmgzEFm
         HERn5PThjkOlipQIWUMXvRviHh+FVTpr98X0/sdIRBN30zZByjWf5Gceniv7igPiQhrn
         wBSQ3XX8v/hNHw0fkx5wBtalNRCGfuqX3jajFRY9iwP32ieXPSr32G6vLWKr+uamh7WL
         493Q==
X-Gm-Message-State: AOJu0YxeWQ5DmamWnvt+HXF1y9Nz+yL6iru1HE8AcIhth6J+7KYsrDkM
	RXvOqHHuWQvfQPY2wITzhKlIsB+0NBBCJsZVaX9HxDA1lQuJafM7f7PT7iMe
X-Google-Smtp-Source: AGHT+IFW0yHoZyPazfr2klGVvXLK095fqumAvEfKZoP8y5XFRja0DuJg0B5f5cI3GOZAatYgLOXsuw==
X-Received: by 2002:a17:906:6854:b0:a2e:81d4:524e with SMTP id a20-20020a170906685400b00a2e81d4524emr1496927ejs.12.1705931719434;
        Mon, 22 Jan 2024 05:55:19 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:19 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 11/15] checkpolicy: fix use-after-free on invalid sens alias
Date: Mon, 22 Jan 2024 14:55:03 +0100
Message-ID: <20240122135507.63506-11-cgzones@googlemail.com>
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

During compilation sensitivity aliases share the level with their prime
sensitivity, until after the level has been fully defined they are
deduplicated.  If an error happens by that time the cleanup will free
the shared level multiple times, leading to a use-after-free.

Make use of the added new member of the struct level_datum.

Example policy:

    class c sid e class c{i}sensitivity S alias L;

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c | 7 +++++++
 checkpolicy/policy_define.c           | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index 0d749a02..d0221f3f 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -134,6 +134,13 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __att
 {
 	const level_datum_t *levdatum = (level_datum_t *) datum;
 
+	if (levdatum->copy) {
+		fprintf(stderr,
+			"Error:  sensitivity %s is still a copy!\n",
+			key);
+		abort();
+	}
+
 	// TODO: drop member defined if proven to be always set
 	if (!levdatum->isalias && !levdatum->defined) {
 		fprintf(stderr,
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 44236797..360cff68 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -756,6 +756,7 @@ int define_sens(void)
 	}
 	level_datum_init(datum);
 	datum->isalias = FALSE;
+	datum->copy = FALSE;
 	datum->level = level;
 
 	ret = declare_symbol(SYM_LEVELS, id, datum, &value, &value);
@@ -795,6 +796,7 @@ int define_sens(void)
 		}
 		level_datum_init(aliasdatum);
 		aliasdatum->isalias = TRUE;
+		aliasdatum->copy = TRUE;
 		aliasdatum->level = level;
 
 		ret = declare_symbol(SYM_LEVELS, id, aliasdatum, NULL, &value);
@@ -1035,6 +1037,7 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
 			return -1;
 		}
 		levdatum->level = newlevel;
+		levdatum->copy = FALSE;
 	}
 	return 0;
 }
-- 
2.43.0

