Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCCF400978
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141379; cv=none; b=diWjqevdoQ7X+LaNC+Gl8rKkppJD2YzsDHJgzeHPDemL3tUBSQ6j2WRgTNMM0/4fzuVnUmsbU1WDSE0p4Xiq0opT2J0JxVnWup8EDfL/jJnV6UlW2hkVbl4sHDxqlqBl5iLE8Ptnh9Xf46mbN0q9AtlJobKwtLjz68Iexd1sbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141379; c=relaxed/simple;
	bh=NVhZzLSpB42Q+xrduN39KH/Aeufp48c8JBgnKotM1UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jbr4RKbYPkH1E/MHct/Q7ommQ1fsWn2Z8YTWOwtemiXhKYwWdTpjg8kvP29A1lMNMMcPDCh5R2R/mDEY/lA6oB+A82GYcESxCZLpXS1XrOTioUxEpBCTJJs6/Gto5ELOYkRIMwv9f1rilSKlA+v/WF7AKUXESTiJaSHCQDkL1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOlag88P; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOlag88P"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8e5be46f663so17515206d6.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141375; x=1784746175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4WW6Ie6bk6Y03vKR0nNOTAaGCn/OG7d9mLbOWlz2eRM=;
        b=mOlag88Py2FfFyx0oszZ4c7N+1CqXyIc6FNtvTjKdX2axGzoEouClppGKWCx6xOjAd
         5/dfbVKlKySBBWdqaPyws7NAZmD57c38Cpnsov817amLU8cdp9+ginOmfbjntQ/C/IOi
         sNS82dVEAAvsMfy7OUUet3GS2p8KxTycDTfKCOYxBJXi1nJeiHBjBiZyLVvvOd0Xnmyw
         0Cc7Ew1a7t5391juAy8Rcr9HZoNULImEHVngY/duWODBVt/m7VxrBVLJLU9RjMqaZz1k
         nVs3HqkTV45wIUIxATaG47CTLvvfBFj64ob58zZd3A5gZCMoXdbDaE2NAZUbyKHVf/uC
         zdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141375; x=1784746175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4WW6Ie6bk6Y03vKR0nNOTAaGCn/OG7d9mLbOWlz2eRM=;
        b=gSHjFoSF0XCGfnwiTHzJnS8hJe6laC9VF2JpkVZsDL4OPMSHsL/pGWbrc+fzx1yfxz
         slcRPKL+iupH2zhj+tFZ0AEWXlC1bY0E1S/QraBgMUf0sZTLVOntuBk+ykAXpiOSVS7h
         qAk/opFBKHz41t5VL+h5QI7VAFtijU4jPMoq8M7XNEvH1b16OHRid7wADhJdmhK8E3Fs
         juVP3KAdVPIq38iC49Hzvw7eWtTWSu1L1a4wAHKeoKQ0T+XWINh1iNOEplyCk5IpdJwf
         zEINPLME/ZSIA+ygriem5Dtk5fwTj3y2vADRAk+LA26BNucSKx6ify39Fw+mR0/nz74V
         2esA==
X-Gm-Message-State: AOJu0YwPKEedhjAiBhFBouvhqzG0wO02rgRlTe8aFU/CFVIH+7oDhGI9
	ozFW4QZy2KRjRJ0R2NulYPb7DXPx6iNc739kl5I3filHWUwxKLqPOdYODdT5cg==
X-Gm-Gg: AfdE7cnb5yQtcKAFNPJIVgJ2mGyWhnckphb/L1zekMHdZ39RNifZbB0sXZk/6f++Qof
	4g8iahbief/JA0NNEgQZ8pxZLUu3EgT9Vjep8/SfvRtKyrhR3dEWIRpY3CpXErHgWfhmtsxcMgI
	g+/6LEEXAZP1BzahkCskUUy+s0qLvUjZqpvpueUGNP4pwljEwz1X7ENvcn3Tyg7w1442t23/32i
	mh/D6WAlnqWlLnUws5/Yoh04GTP4eGyq3ati/mVIp5R2lBrrpjC7SXqyS+a/NrA5+IhTXRhz0fw
	0TpAljzinAiI7tZEH8kHTfJJcsaAywyHbv0RsQOfOeMzsl//xa14UrwGahSATkxaY0Ywro+t1LJ
	lw81sDej8m/NaQ+nbM3y6e7YeTfKVrUsIdtmgefPgnG1iuW6rlhI6iZ1MgQEXRfvxx9DP+xV1vR
	lPZBSC/j+31mZe9FFz0wEiSycL6fXv7gbe+x/yeEJb1FHa2sPxcuchGILM9B7FYiNTBtDH/exaJ
	IGeBKgPYPFlBHsm
X-Received: by 2002:a05:6214:3d8b:b0:8ee:b05c:596f with SMTP id 6a1803df08f44-903ffe7a3eamr209311626d6.29.1784141374572;
        Wed, 15 Jul 2026 11:49:34 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm198015696d6.42.2026.07.15.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:49:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/5] libselinux: label_file: check next_entry() when skipping
Date: Wed, 15 Jul 2026 14:49:11 -0400
Message-ID: <20260715184914.45524-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
References: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a file_contexts.bin file has a different regex version or
architecture string length, load_mmap_common() skips over the string
and treats it as a mismatch. However, the skip is not checked, so a
length that exceeds the remaining mapping de-synchronizes the
parser. Every subsequent read is still bounds checked so there is no
OOB read but the file will be mis-parsed rather than cleanly rejected.
Check the call to next_entry() when skipping and handle as an error.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0c0499eb..427e4071 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -963,7 +963,9 @@ FUZZ_EXTERN int load_mmap(FILE *fp, const size_t len,
 		 * Skip the entry and conclude that we have
 		 * a mismatch, which is not fatal.
 		 */
-		next_entry(NULL, mmap_area, pcre_ver_len);
+		rc = next_entry(NULL, mmap_area, pcre_ver_len);
+		if (rc < 0)
+			goto err;
 		goto end_version_check;
 	}
 
@@ -1005,7 +1007,9 @@ end_version_check:
 		 * Skip the entry and conclude that we have
 		 * a mismatch, which is not fatal.
 		 */
-		next_entry(NULL, mmap_area, pcre_arch_len);
+		rc = next_entry(NULL, mmap_area, pcre_arch_len);
+		if (rc < 0)
+			goto err;
 		goto end_arch_check;
 	}
 
-- 
2.55.0

