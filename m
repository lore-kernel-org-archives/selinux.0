Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D43B8D7E
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323376; cv=none; b=PQo9vqYLrlJYZtj6ZFoHD0fg9CrP2W4y43WEH+7iucAr3k9cJTz14ZqyY1hSyzFG2NGIN0qjKWDZULLa+7dnqDkqXXA853rJAM0KCeV6WRcH9zh65U+mqS5y2LDXu6DbMldrDHd3PUIuUFHGVZgRn80TwctFOwZI5ajl3mXt98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323376; c=relaxed/simple;
	bh=MY/zmKCqaRsNOOfkAg2O8zZYX1SEcp1X7RCSm/ektxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuX8A8/1JRcTKYmdBrPyE/njr4ll277xbaTartHPYhLuv9DWkIxGqm2XAt+d1PDi54J/bpNEcwg86w/IUrKAu2kka/76K23W/fujUPgRXFh6fcnplxMhO5mQvD/bkBCaqtZOig6d7oCtxFfd5hQK5RDYyb5JLILi1Owekntn/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RywrkA3L; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RywrkA3L"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69e1eae4eb4so1114003eaf.2
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323374; x=1780928174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08UpdwEtZxQl8pUFp+HFIL1Dwlq8GQ7SYveiDRSwqMQ=;
        b=RywrkA3LCKdJyuxHP/gN8kJLEoP3ZuCrQnGjOeqhmREuBGR52TUxrExK+fqMcT88hT
         GkbI6S+vs0PwQQGOE/8zYdRh4eBn8hY5+fSR8E45Od79urGrvkF/URBpVdnnqNKDr+Y1
         G8v9zZ7tWNvWR+YpWqGrEbtS7en6zEAal2FGhL/O29uUTlKCrmx89C818fxnsjGQwEl3
         2/nMqEbQiwzM0Wab9Zm9poYcP/nXWFCuRJdSL5/09hAUU0rqnXgWZAmZQplKyTwv9koS
         CeguE8Komw3h+TzlEX4eGwYrdbif2uqdMQ8YjMfN8+Uxi8WVOts56sOCO7CUVVkGS3UD
         /K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323374; x=1780928174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08UpdwEtZxQl8pUFp+HFIL1Dwlq8GQ7SYveiDRSwqMQ=;
        b=Ucs/T/FGgZA5Q4JJ2qDR+nKpjV4wJBU6az4pPlDqRwCIRnOJ8yWUuCtu4MWsED0/ya
         DNXU1lcOcutwWFxXZm3kWZS7j8cVPlclXjPt9OXTO3RO6sptiJ3K5tNzVPerb9DvMkbE
         x+L/GpdXGiSfnsAVeqFr3SvbSCM6PqIzYNhgFbYJ4fXicR3egh1GexkFAxtI9NTcYWKD
         /zgTtsHiegNYIBeor+3o4bKl4XsTviBajAhFP+Yaq+cfII6P7m6vbmS0rNIGXb85eetH
         AiDkp+0x08uUiOmHS7tyA1GSd5vBtsk50bPuQ2mIhKX6uyuqE5feMfotlqgntVZ4CElP
         Y/mQ==
X-Gm-Message-State: AOJu0YyjohpEmG/nIUJ0DQNNxtZVj6QhfD02beQpIb6vPFdnGID69Tba
	4fJw4DFV7Iq3Xjsbv7iDD44EZF1q3MjdbmsklKWidJeqbLEncvW+TrmZ216hzg==
X-Gm-Gg: Acq92OG3mfO0u57S6KpppKH79ijK3H4MGKaIPueRv4p3GuJhM52Et9tMiaGUXejWK5g
	Cv0PIntiWcz2yrmqT+y/fP7c1bOHBiozcxQ18KwCR3scpa1Fdf5z4lgRaKN0nRSU+3UTDdXgkhn
	H3QhN7UjKuYyg56V3sVxJqz60Nx6mVfOqQ8OYmDY0OE/2D2Cc6LL6PIo4hV0i/9qQizrycX2eSm
	OZrlK0fP9rFO6CD9yOS6wGnujj0AufAUrz0F41r+eAr73KxunoHFTSmXr2Ect1fHxeXHqFpz2aN
	+ptvS4+tKGGu6CVkfv5+Hs1Io11HyqYfSM1bHycm+eOIl0DyiITfLKYL+QU+w6l4n5QX7sK13ok
	Sg5+1f1v/CBcX1Ej3uYjX8QxeWtGGfVhX/PhfO0T81a0M5B1wHagLOu6EeUEAVxyONlS/p3zUzU
	rjDwVUhVeoknIJuMHHdYtwN1Tio6UE4yaQ9YltMRDdw3r+xsJ3qmGYZkD+5tM9IJMmV5E/2TEEy
	CmfjVjpK0RDzH4F7gbzEPlUPN4hJtqJQzixtQ==
X-Received: by 2002:a05:6820:4c85:b0:694:9861:ec4d with SMTP id 006d021491bc7-69e103c288dmr5757315eaf.29.1780323373819;
        Mon, 01 Jun 2026 07:16:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91570271853sm109607285a.24.2026.06.01.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:16:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/6] libselinux: label_media/label_x: preserve errors from process_line
Date: Mon,  1 Jun 2026 10:15:49 -0400
Message-ID: <20260601141552.191733-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141552.191733-1-stephen.smalley.work@gmail.com>
References: <20260601141552.191733-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

status is reset to zero at the end of the first	pass, so we need to
set it to -1 again on error paths.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_media.c | 8 ++++++--
 libselinux/src/label_x.c     | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index be3df388..cc6759a4 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -125,8 +125,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		data->nspec = 0;
 		while (getline(&line_buf, &line_len, fp) > 0 &&
 		       data->nspec < maxnspec) {
-			if (process_line(path, line_buf, pass, ++lineno, rec))
+			if (process_line(path, line_buf, pass, ++lineno, rec)) {
+				status = -1;
 				goto finish;
+			}
 		}
 
 		if (pass == 0) {
@@ -135,8 +137,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				goto finish;
 			}
 			data->spec_arr = calloc(data->nspec, sizeof(spec_t));
-			if (data->spec_arr == NULL)
+			if (data->spec_arr == NULL) {
+				status = -1;
 				goto finish;
+			}
 			maxnspec = data->nspec;
 
 			status = fseek(fp, 0L, SEEK_SET);
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 5b0e4063..0af5eff5 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -152,8 +152,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		data->nspec = 0;
 		while (getline(&line_buf, &line_len, fp) > 0 &&
 		       data->nspec < maxnspec) {
-			if (process_line(path, line_buf, pass, ++lineno, rec))
+			if (process_line(path, line_buf, pass, ++lineno, rec)) {
+				status = -1;
 				goto finish;
+			}
 		}
 
 		if (pass == 0) {
@@ -162,8 +164,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				goto finish;
 			}
 			data->spec_arr = calloc(data->nspec, sizeof(spec_t));
-			if (data->spec_arr == NULL)
+			if (data->spec_arr == NULL) {
+				status = -1;
 				goto finish;
+			}
 			maxnspec = data->nspec;
 
 			status = fseek(fp, 0L, SEEK_SET);
-- 
2.54.0

