Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7636091
	for <selinux@vger.kernel.org>; Fri,  5 Jan 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hoMPPvb1"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so1531860a12.0
        for <selinux@vger.kernel.org>; Fri, 05 Jan 2024 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704479742; x=1705084542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLq8xHrlukb8pJR5MZ8K7ODG/GqH21ZgCqj6e8tL8P4=;
        b=hoMPPvb1T2e0wJv/PLnRkXN7xbjTV5kqwJFBxkn0pGhVU2cSzcFSbQaz6oPam/lMPE
         I0MyWE5eD8fvBdeLIP7bTPBgf7/VnBZy5tg5SUHvxysrG+0TQ1xgC4Ft4YlreMxMcpmF
         uLTlEzijEW+BD7aCOqOhQM1GOpK06sKk23RGUB0B3iJgiUHRiZtE0hwzPSmZ1z3OmANQ
         NYJ4O2ug+wumsuMEtPd1djDf9DrIPue9FgocXxbq+/jPRCL24pvFJXsdo19oXiSolaWA
         0juApZ8G5bW8sp5QEJCsYtZKxwDnOSAuZiBTn0VjLop1hAt+2c6zNTv73vhfZmvgiPJ+
         HOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479742; x=1705084542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLq8xHrlukb8pJR5MZ8K7ODG/GqH21ZgCqj6e8tL8P4=;
        b=FSkfR9Il+ioCN6Gp+NxjUsR9jN5qQIN93sNJDLq4ye1LhqwxHzsJj9eEm37+VbRXYf
         V8HqJbZk4aNoJGjKvRKUO/11Rcfskv33uRY5Vq27l6VvVvGA3kNrxU9Vj3IYCTuC2D9l
         O/vEsOcqvgJ+4Pzq2VSBt+Aq8ocd+sErQxKWGFSIop1nkqOvJxHtLG7pMpqC6gK3UJlW
         lgDsnJBx4YKiRc2IPEDaICdYcAW1detuGFmX5XWEsvp6dCNX4KVQOOeBxYwM1kvZUDor
         wixdfhcSOyqXhv/T4ACEoyDRAE8yjIH4Yff9EWG4YtJPaJoCi9v++wfouVmmPL/v+L2u
         eFTQ==
X-Gm-Message-State: AOJu0YwCrQxmaFQETKZczV2ySMJ5h2EhD6FSFc+dbmKFb10vlQFftDxX
	RJG4S95D/vyvX5h3sZW8ErwTD6k7ZkU=
X-Google-Smtp-Source: AGHT+IGz4dKOQxDmToaCLCwcR4j22KWUZw7cxFCgw/6e8E+A4vB3IcZnS2jhGRthjFAL3tJACBPCgg==
X-Received: by 2002:a50:871b:0:b0:557:34f5:2dd0 with SMTP id i27-20020a50871b000000b0055734f52dd0mr626561edb.36.1704479742355;
        Fri, 05 Jan 2024 10:35:42 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-008-063-036.77.8.pool.telefonica.de. [77.8.63.36])
        by smtp.gmail.com with ESMTPSA id ds9-20020a0564021cc900b0055267663784sm1231319edb.11.2024.01.05.10.35.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:35:41 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/4] libselinux: reorder calloc(3) arguments
Date: Fri,  5 Jan 2024 19:35:32 +0100
Message-ID: <20240105183534.1110639-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105183534.1110639-1-cgzones@googlemail.com>
References: <20240105183534.1110639-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The canonical order of calloc(3) parameters is the number of elements
first and the size of each element second.

Reported by GCC 14:

    is_customizable_type.c:43:45: warning: 'calloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/is_customizable_type.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index da301c60..0ae92c8d 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -39,9 +39,7 @@ static void customizable_init(void)
 	}
 
 	if (ctr) {
-		list =
-		    (char **) calloc(sizeof(char *),
-						  ctr + 1);
+		list = calloc(ctr + 1, sizeof(char *));
 		if (list) {
 			i = 0;
 			while (fgets_unlocked(buf, selinux_page_size, fp)
-- 
2.43.0

