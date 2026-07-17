Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9CD429827
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298828; cv=none; b=W0y9bgfmryYBabNoLyDmpVhZ7blSJTeZB39m2zz4FOy6RrZzqi7QKX7TI9uzdFDV1k0VwjCQqyOdgsc33mcwu8F94VCXqHevP8CQiu6Vp2jeFIjzegLFBYINRUh7HpZqDYa4ehJG11HVml56jjzZpIZ5FgBnUtDTW9bGDNkomzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298828; c=relaxed/simple;
	bh=WmWomNXfTj87nUSOarXdG6HRQ+Xd0EHOqlNL/0RHt94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyoE7Ixj0fccT4xIv4/YiRyvbIbo5Au6gYWUhb58NVxTpfxGeILPhQKfN5cHAdP/9dm1YIsjhsfpxb5plgxVzstXUu20xPDnqJaoT22+r2Gdz4Ew7JkXVLfqOkH0fYW8S7UDZAi7lbqUm5lMQMvA+nr4jUGEPb1KRxPcKV9KHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN4oGbfH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN4oGbfH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2a818fc4so65570571cf.2
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784298826; x=1784903626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+eWTktQxMlegytuZr1Cs9lM308FPxEQwRod+jr1/x4A=;
        b=nN4oGbfHswe3V1pZj1QdLWXoRbb9uG+IOK2YgL5DhyzRaDLs4wgAKiGlRsuChqcBqw
         zGAibz6PfJZu8/qqLfdK0g9iEwnpWF7eKFtp7BYxAeoEUyvTmSxMl8XgkID4yBWS1iDM
         NFRsR5CwjDcgYa9Fvxw2FC60Lqdq5qTWjHuRxIfJLpvzVDJAWSmZ7TLsTzUzMCIINq3e
         9NdO3PtQntM1OVHAET9oASuYxbDjSGduGhdAWS4F70lYg+RDCHEH0VtRBI4NNRCTkNvu
         KSkpF+3G1FMMC6TLnIIfHoK5tXe/rAg+jMxAZ3lvZw0OCmATIByaz54dM+jgBrbSrLyb
         MBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784298826; x=1784903626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+eWTktQxMlegytuZr1Cs9lM308FPxEQwRod+jr1/x4A=;
        b=hAUFbIIoYovDw39+RkC7cFkuB2vzM5pg8XfR5E8lQzBPnHDEmHsOH1gg8QMOzmY0GH
         JZLS9Y459eruYFPP1NbiVVpKmZ63W2ZPskeXeqfHqzGNaM5PY2zdNxS6MpkrySN4igi3
         qLK+JAQwtstTfxA5+rZz4l0C6pVmqT68mMsZDyVNOIOLMTGcx2ngj5XAy0v5ee0YxslF
         H+O1iopjc55L7dpFuQ52NiZOgGuj8BqhXjfyXWCXcDM49RlpgIfPLsdfb3CbmHnWJLvp
         NbWM3Y8itnYejqUajsyU9Ac++mZct46m1W7ng1qcUu3IVADv5xxn9dDmce5bq3gDDEk+
         YygQ==
X-Gm-Message-State: AOJu0YymiOaGKiK7isXYlXcryFH/hzwL6SvKCtRumAfl7xQn1RShwY67
	eOW/Bp1KzEWLE9ZcaMo+V5dfo1xTKnM8OyiY1i1Pf9S9xb+hbuNR9qtoKufvuA==
X-Gm-Gg: AfdE7cmj3X5S08SUF0g8FANI/jB+w7xDjpvMStGtS2FwiMCarHmWHO0tKPou0V2MJ44
	r9dFhRtDTRJKY6JuiM5l+Y9rdB5N1yKYNyU5thxBP2CQ2aBUgF1gSr+pkUQlqkd5a6DuHCNPfdh
	nbUEVcEHAdJ23WsJ0ZHkcBEvULSE2OlpYJBoU+/wc07FOXv+zG1iw62A0uYcyUPsyCMkr3ONnpI
	6GnNLjo91FvHSTyKW/QKZ+agaOTF+EtfBgImuP7ubYII7Pdb2FSINrLU5R9NOsde5FfybVh8bS5
	dazMnnMSb6qiz+q6WyIU3cjT0Htx4eRGd09TzkP97W/Q1PRIEUuLevY2FO9xDj8SK0/VEecz5a0
	5kWUwdPpV46cwdbPduiIv13TM4zgFsoM3sfH4bCei49QnpxRr0Dh4BYar3hV6gbHqIrhmtNjfzE
	1qf0NDPPPaYcQmUL3gmpmeuVPIjihEZud9hUvYtFw3GWtNdl6MfFjDEnNUvgo0/Y9EBbxOVt2Rt
	ny19TvpDYyFUtbX
X-Received: by 2002:a05:622a:124d:b0:51a:8c97:9383 with SMTP id d75a77b69052e-5213e0871b6mr27528881cf.58.1784298826111;
        Fri, 17 Jul 2026 07:33:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-521502b92acsm13852051cf.30.2026.07.17.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:33:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] libselinux: selabel_digest -v: handle unexpected output
Date: Fri, 17 Jul 2026 10:33:30 -0400
Message-ID: <20260717143330.18119-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717143330.18119-1-stephen.smalley.work@gmail.com>
References: <20260717143330.18119-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selabel_digest -v runs openssl to obtain a digest for validation but
doesn't correctly handle the case where no output is
produced. Initialize the buffer and reject unexpected output.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/utils/selabel_digest.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 2c395db6..689ca7f4 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -39,10 +39,17 @@ static int run_check_digest(const char *cmd, const char *selabel_digest,
 	}
 
 	/* Only expect one line "(stdin)= x.." so read and find first space */
+	files_digest[0] = '\0';
 	while (fgets(files_digest, sizeof(files_digest) - 1, fp) != NULL)
 		;
 
 	files_ptr = strstr(files_digest, " ");
+	if (!files_ptr) {
+		fprintf(stderr, "Unexpected output from '%s': %s\n", cmd,
+			files_digest);
+		pclose(fp);
+		return -1;
+	}
 
 	rc = strncmp(selabel_digest, files_ptr + 1, digest_len * 2);
 	if (rc) {
-- 
2.55.0

