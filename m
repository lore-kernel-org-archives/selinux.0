Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EB39F17F
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090259; cv=none; b=TQ4+N9f89VnePQmg09dg2enRZbnx/0prxnuIW3qe9NSyZR4bwc0ByGGPrWBLLlhDQqHjyfotkHGyKmZE1iq2gEV0U6AICFqy/YrBZGurloxw0I/4ySkl1Zld7pJIw13NClcRmWuzzsADZiXp/aXJ4m/2A0LZ7wyhDlPXSGpMzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090259; c=relaxed/simple;
	bh=9rMKB+yiCTPa7YfIyxTYueMs9mXitTxDefIy8NSE4Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjJwdsNzepHPzzu8/P5JtRd6XYL+I0N66sCDW4HDR8BGhR0Pl/XACaBM2mJveKVmSFNWROzkC8oX8I8PcRGb5MPzc7qajWDLrGTPKZkK7jMz07C7kv6risWpmhd9rqONj+BcCP8JypmK4ZIajHnu6qvN+jPOlf6fwPxz0koJQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERGtlPBj; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERGtlPBj"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910a0cb7cso3258385a.0
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790090257; x=1790695057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CC+qaaNDePQadEYR6lMtXs2aM+k6Kj4a5LbmdFNDkIk=;
        b=ERGtlPBjcuDK1d54krVKNIH+BbxjPgCMc7TsBIVyqF/J+wafGXc1wk7IfxwUyl/eu4
         apaWlWIIDLWFo8IG+5Nks7HrlOSXdz3EB6RmiiyEyNGX/Ep+TYotvSL0xB93aJ2SlBBE
         oj10ylXIgVzmYHPPdnJPZbEG2L7jDMzoz0gegFynDSYhA1VFuqhpiExnm4HTOyRAdTkk
         Ifl8YnXEReJhhwayExXAHK1Ql+Ip2llXsstiqueVdBbxZEQ8zfjGwgLE9leAZZA4bDfI
         J3OXAMiYU2+YUe+BmCX6epHHHSn6mG1MPtVOF0G3f8jb4eJa1B3OdAxZq1vk2WaSjR6t
         etFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090257; x=1790695057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CC+qaaNDePQadEYR6lMtXs2aM+k6Kj4a5LbmdFNDkIk=;
        b=fJcHHPxFIdDCFExErYhdOMqprPQo6POPqdWtw6rZgvrSeQw6NqThhZLJWSKXKuDXkV
         S1rWphIWoGMTbwM2Jx47TF7UfecTyKTl0iNzakJqdYecAo59c7kdP1I3wiYXuVu7DiEv
         OB8BgRdq5b7UlhzEUrLbx90hVUHCNP8h7MCb6qNMxzAQmZ4j9i9vvkH3jfok9ffBMvK6
         jEd4vddbTal4nmjWttURRJtmH0yrohCJmw9pOOcQSLDf1GX8MTBS68kFlAKvVZ0TJw1b
         fRLGvbTu4yPVrviXfAvtnTjlYVvgmzvfO8eEZhTvZeO5ZQDW7BHGpmRjlYIuHdM4T2vK
         JcVg==
X-Gm-Message-State: AFuF++mli8o58HK0t3dYcbzzEisHtTCv7bWqQGh+jBk0mij7b5gcMh2r
	IychtG4CLri5zU32fK/3tw2jRwM/YJ7tFiLRVlEDRr4MsM2r586q5e7CSI07mQ==
X-Gm-Gg: AYBFou0RVTVUfggHEsthvQJ5gq4bosGPmgdfNQHuO8so2hBWPIK4wXo7qSIrTGgc92Q
	DL9uWyncHDzRMHajli8pEr6a7QN6UIhpTV4SWxaagEp4OM2EKofozdyCPTpC9tTRdKon/1UXH5r
	cnmHsNvtwWoIE2KG//dM/uxUcsvki5B+CgjsclpRyxkgoId9Oj/l+NovHDZVvBm1suU3fE5aSqp
	jX+Og+H2KUZr5+QSP4lzVSCNsi4sfUf7r1LAR7D7ol+gOWbq+eiv5Uu/81oH+IN1uzaYp/XY3I4
	I1ZCWc4Y8Qi2H5jPJlKi6z6Q6aqHkzv4cmtdw3g25jyE9jg99NqFjPgEYCIdVbX9R25pl2Sye5h
	nq6ha08z8zZfj5p+/oZHdlZ2ZgStv2jRrF+ITrykWDFd4c0JpdMYY4Y6PW2Bqv/32R9VW7RTF9c
	AcGuw4EwzlYdlkUE9qUU4Q9VFq5sYjF4Hqp87OsM+MX+HMCWWo8tl96BTu3U62/U8hDrnY01Kjo
	WDGTMF3n+s74PzFtAYA3FoVBgZ7k6Ug0JpaQfAqJA8OujfofuGHMUxTimbmgMaBorVG/GmKPSdZ
X-Received: by 2002:a05:620a:46a1:b0:93b:d7a2:83d4 with SMTP id af79cd13be357-93c15f2ea2emr594999885a.67.1790090257110;
        Tue, 22 Sep 2026 08:17:37 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d22e33esm167955885a.39.2026.09.22.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:17:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] policycoreutils/newrole: search fallback location for newrole_pam.conf
Date: Tue, 22 Sep 2026 11:17:19 -0400
Message-ID: <20260922151720.46824-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922151720.46824-1-stephen.smalley.work@gmail.com>
References: <20260922151720.46824-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

newrole_pam.conf is optional and lives directly under /etc/selinux,
outside the active policy root. On a stateless install a vendor may
ship it under /usr/lib/selinux; try that as a fallback so per-command
PAM service mappings are honored there too.

The fallback list is a build-time constant
(PAM_SERVICE_CONFIG_FALLBACKS) rather than a libselinux call for the
same reason as restorecond: the file is per-installation, not per-
policy-type, so selinux_policy_open() would not remap it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/newrole/newrole.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 741d30a1..0c19d4d4 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -100,6 +100,9 @@
 
 #ifdef USE_PAM
 #define PAM_SERVICE_CONFIG "/etc/selinux/newrole_pam.conf"
+#ifndef PAM_SERVICE_CONFIG_FALLBACKS
+#define PAM_SERVICE_CONFIG_FALLBACKS "/usr/lib/selinux/newrole_pam.conf"
+#endif
 #endif
 
 #define DEFAULT_PATH "/usr/bin:/bin"
@@ -249,9 +252,8 @@ static int reqsymcmp(hashtab_t h __attribute__((unused)),
 static hashtab_t app_service_names = NULL;
 #define PAM_SERVICE_SLOTS 64
 
-static int process_pam_config(FILE *cfg)
+static int process_pam_config(const char *config_file_path, FILE *cfg)
 {
-	const char *config_file_path = PAM_SERVICE_CONFIG;
 	char *line_buf = NULL;
 	unsigned long lineno = 0;
 	size_t len = 0;
@@ -305,16 +307,20 @@ err:
  */
 static int read_pam_config(void)
 {
-	const char *config_file_path = PAM_SERVICE_CONFIG;
+	static const char *paths[] = { PAM_SERVICE_CONFIG,
+				       PAM_SERVICE_CONFIG_FALLBACKS, NULL };
 	FILE *cfg = NULL;
-	cfg = fopen(config_file_path, "r");
+	unsigned int i;
+
+	for (i = 0; paths[i] && !cfg; i++)
+		cfg = fopen(paths[i], "re");
 	if (!cfg)
 		return 0; /* This configuration is optional. */
 	app_service_names =
 		hashtab_create(reqsymhash, reqsymcmp, PAM_SERVICE_SLOTS);
 	if (!app_service_names)
 		goto err;
-	if (process_pam_config(cfg))
+	if (process_pam_config(paths[i], cfg))
 		goto err;
 	fclose(cfg);
 	return 0;
-- 
2.55.0

