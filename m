Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YHzTxlAh"
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4C418D
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso74585a12.1
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701195821; x=1701800621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RnimM5kvNkVrioMB7LfLRR0IMws4pz6347/ilPQEl8=;
        b=YHzTxlAhMO8CNdxHKlG0cpZGbBVOdY3A6/s+h0ZczCQ9064Z0gnedB8MMAy3PBkcdf
         tpRCbeh9ZZZVr/z+x2tvdwXEmjFxcaRIOrW1Mf0lGQ6V6TeUUHUGb6jEwlxKTTcmrl6y
         1P42v2W56rlZTJMkAGwzaDBWKXB7Ri5AEDkdJbe7P8HPCd6qTVvvFyG1HGC99RTqJqUp
         hAMwkuoCm7+woQaL5Vl3kgr95iBEoiWP1tMt3X1b8fQKm32IIAcF8nT/UIOZWOlo3XQs
         3OnOJzvA+pld9vYpR77uWRUadjAidtHDMffGcZGwYy5DjaHcxHqSOs4JW7wW33PAHg6A
         F69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195821; x=1701800621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RnimM5kvNkVrioMB7LfLRR0IMws4pz6347/ilPQEl8=;
        b=Xiw4DX3VT5DnJaHLhI8KkdneVbgqcH0QHcZRQgmklyXuYqwn2rdR4FjD2CaaAcx4JS
         6/pYWp1K3FHppLnVkeEIddnw0JDVcpGca3rrOAjDKeW5He1Ft+Uq4H78U1bCZQJUrhd/
         zJhxR/J7ffkYI7V/sMagpgQFfmffwL+ikVh7LCEOp65Ngs7fDOgFc7QHENfhUi/dQq8R
         91Vx1vwDVUEcevCSp3ASX1PoS7PcKstMVNzbi7q/ONHsPwvFbifkR3fvwQD5KwYxPCjk
         Fy5L8tbLyLko3XSCp8GyjlRGtMIJt50C/wYtsF3evMvizc0BvPwITpbR6YSjYA4Rgb3K
         IsZQ==
X-Gm-Message-State: AOJu0YwsOYdPs7IGqou+DofayzxeuWittAF09oVZv+FjGviOdQGlKmd4
	uCIQQ4Htw3q1MlDArj5IoMTw9hM+Xm8=
X-Google-Smtp-Source: AGHT+IE+J1Pd4Go84bDd/90cHhPV+Q+baouxkyIMazLEMxf+9LxSQwwjBV93qXBdIjI0nmHJxt4uZA==
X-Received: by 2002:a17:906:3ca:b0:9fe:ae1b:77bc with SMTP id c10-20020a17090603ca00b009feae1b77bcmr14289602eja.34.1701195820753;
        Tue, 28 Nov 2023 10:23:40 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-003-184-154.77.3.pool.telefonica.de. [77.3.184.154])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709067d8b00b009dddec5a96fsm7122024ejo.170.2023.11.28.10.23.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:23:40 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/7] checkpolicy/dismod: avoid duplicate initialization and fix module linking
Date: Tue, 28 Nov 2023 19:23:30 +0100
Message-ID: <20231128182334.57740-3-cgzones@googlemail.com>
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

Avoid duplicate policydb initialization when reading a kernel policy.
One caller, main(), already performs the initialization.  The other one,
link_module(), needs to do it also for the module policy case.

Also set the target platform to enable module linking.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/test/dismod.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 9f4a669b..ac2d61d2 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -824,10 +824,6 @@ static int read_policy(char *filename, policydb_t * policy, int verbose)
 		package->policy = NULL;
 		sepol_module_package_free(package);
 	} else {
-		if (policydb_init(policy)) {
-			fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
-			exit(1);
-		}
 		retval = policydb_read(policy, &f, verbose);
 	}
 	fclose(in_fp);
@@ -856,9 +852,15 @@ static void link_module(policydb_t * base, FILE * out_fp, int verbose)
 		return;
 	}
 
+	if (policydb_init(mods)) {
+		fprintf(stderr, "Out of memory!\n");
+		exit(1);
+	}
+
 	/* read the binary policy */
 	if (verbose)
 		fprintf(out_fp, "Reading module...\n");
+	policydb_set_target_platform(mods, base->target_platform);
 	if (read_policy(module_name, mods, verbose)) {
 		fprintf(stderr,
 			"%s:  error(s) encountered while loading policy\n",
-- 
2.43.0

