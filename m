Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC53E485
	for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328236; cv=none; b=E5u9OYG4SaXCVBQSutUEZI0UyvNURbp4W8OZfmUR3mcH2qFKLlUybFkGmSZv29/LPzHFA8HN/tnMet3uFpHhzboPDdCWlHwBZtvbNYRmnYzMs00daXB2vItNhx64FwXepP2hnBJBcZG6daQAyqmCW/Kebfwt91K3BEo8bQ5IUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328236; c=relaxed/simple;
	bh=YNkYPrG7fvZxEtzqy9wPNMC5SdohhkDdgdldd5C6QqI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgQ2lGxs2Pj5VdklNXGZO9o8tzCr3JP5fY8FmMFB9/6BlALHgltX8hT8S3XYsqn7+7uNj2NBLJZJekdsfawUgB705FVHJAY218QHdKPI7BIPEgvIBozJ+IcAYIO6b2cYQbKoL7g48QSnojtNCC4MA3kO9tukbeBvmRgM0KDDbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=erDwSIiC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="erDwSIiC"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a446b5a08f0so143694366b.1
        for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710328233; x=1710933033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9qC+iM2S2WUfE9gOxWe3reFZNxsGfGHkcrkvT+r35U=;
        b=erDwSIiC/UxM5kARqfALLHrfT9EboURg2U7YjdGnDJjQkfePwdKOHZTk5RpOTshDog
         4GoYc+t7R0A+s5La/2XjKazXjXhIhCatMSZwJQYXBGZa5utABgAxsb26Blh8T8/QD8FT
         xXk6Cds7XnMQ50MzkG8/wDzkwEqA2wo32ftdiIYV9ZQynvTnPfpxdkDJat9gvE75MmnC
         A1q54Edyw94xhNHf0QpbNuAXegaffvNCcTUVRESfVk1IQq/mSSFDF1fQFQYD7pkhAAmg
         Rq0M+0m1P+GdfDy1/AxUdrgHThk4Z0+CwPo2EaeS1r+qtk7d9DaMlhyJehMONm3xxkEN
         +YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328233; x=1710933033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9qC+iM2S2WUfE9gOxWe3reFZNxsGfGHkcrkvT+r35U=;
        b=t+5vfhNWw6m0xig/KunQIdD4aQJAuc6kBMTEWJ8cLK36L3KGat6ZAaQnjyzP2ScKe6
         oSCnMuR3yRq4/MF0pno3l67S0faCLID92EKAD1ISAO/Z5DmRBGSA70PijkBgc2y85dqU
         o6JDdpBqbEbM37DgaZNS/DSa/+t0Hw4G/+JU4wOx0rMTebNYIqzPKBqAU6AvRNmvphA6
         H9p6K0owFl+ea8aM8dB8vZgRQdvzAFKPZ5ashte50rVZ6FkghMccon0xPDtm5bJoQOFH
         BFPb097sAxmVmYI3g9VNMP9Hc7AfsBhRsaCuV3D71IDFUR5wbe+WE4HaVPxXS2mUwuqf
         z0sg==
X-Gm-Message-State: AOJu0YwoEmWkptYrhRGNErNiOwcPtnpBhHbbhEc3vXabrQcnr/cRI8SZ
	Z26mePP5UvTYDgJkS2OO2zvvTDrrbO6lI1k6jFFRREYiDgCsn64oSOWUwzKe8Wk=
X-Google-Smtp-Source: AGHT+IGzvtYzlVh49SzGFMjN9id44od63FEUUSE5fyFiTfhqJRm+j/8l2YAkdKEJmj86/BKrR7ReVA==
X-Received: by 2002:a17:907:d50a:b0:a3e:4d7c:9ce1 with SMTP id wb10-20020a170907d50a00b00a3e4d7c9ce1mr2383664ejc.21.1710328232806;
        Wed, 13 Mar 2024 04:10:32 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-077-001-104-044.77.1.pool.telefonica.de. [77.1.104.44])
        by smtp.gmail.com with ESMTPSA id hg22-20020a1709072cd600b00a463c821e4dsm1794319ejc.10.2024.03.13.04.10.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:10:32 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/5] libselinux/utils/selabel_digest: avoid buffer overflow
Date: Wed, 13 Mar 2024 12:10:23 +0100
Message-ID: <20240313111025.43720-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313111025.43720-1-cgzones@googlemail.com>
References: <20240313111025.43720-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In case the specfiles have very long paths or there are too many abort
instead of writing past the stack buffer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_digest.c | 45 ++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index db0d443a..64051070 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -66,7 +66,7 @@ int main(int argc, char **argv)
 
 	char cmd_buf[4096];
 	char *cmd_ptr;
-	char *sha1_buf;
+	char *sha1_buf = NULL;
 
 	struct selabel_handle *hnd;
 	struct selinux_opt selabel_option[] = {
@@ -167,23 +167,50 @@ int main(int argc, char **argv)
 	printf("calculated using the following specfile(s):\n");
 
 	if (specfiles) {
-		cmd_ptr = &cmd_buf[0];
-		sprintf(cmd_ptr, "/usr/bin/cat ");
-		cmd_ptr = &cmd_buf[0] + strlen(cmd_buf);
+		size_t cmd_rem = sizeof(cmd_buf);
+		int ret;
+
+		if (validate) {
+			cmd_ptr = &cmd_buf[0];
+			ret = snprintf(cmd_ptr, cmd_rem, "/usr/bin/cat ");
+			if (ret < 0 || (size_t)ret >= cmd_rem) {
+				fprintf(stderr, "Could not format validate command\n");
+				rc = -1;
+				goto err;
+			}
+			cmd_ptr += ret;
+			cmd_rem -= ret;
+		}
 
 		for (i = 0; i < num_specfiles; i++) {
-			sprintf(cmd_ptr, "%s ", specfiles[i]);
-			cmd_ptr += strlen(specfiles[i]) + 1;
+			if (validate) {
+				ret = snprintf(cmd_ptr, cmd_rem, "%s ", specfiles[i]);
+				if (ret < 0 || (size_t)ret >= cmd_rem) {
+					fprintf(stderr, "Could not format validate command\n");
+					rc = -1;
+					goto err;
+				}
+				cmd_ptr += ret;
+				cmd_rem -= ret;
+			}
+
 			printf("%s\n", specfiles[i]);
 		}
-		sprintf(cmd_ptr, "| /usr/bin/openssl dgst -sha1 -hex");
 
-		if (validate)
+		if (validate) {
+			ret = snprintf(cmd_ptr, cmd_rem, "| /usr/bin/openssl dgst -sha1 -hex");
+			if (ret < 0 || (size_t)ret >= cmd_rem) {
+				fprintf(stderr, "Could not format validate command\n");
+				rc = -1;
+				goto err;
+			}
+
 			rc = run_check_digest(cmd_buf, sha1_buf, digest_len);
+		}
 	}
 
-	free(sha1_buf);
 err:
+	free(sha1_buf);
 	selabel_close(hnd);
 	return rc;
 }
-- 
2.43.0

