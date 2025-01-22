Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394221480F
	for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561518; cv=none; b=qpHoDg3wE0pRgxQCiS4dW4mI3BVEoLejMG2eDTzFmymtPqDh5hdtLxlPFUxSqiDMzyNUkVpt9ZrZAhMF8Fa5eS4439tC5v4EMYw/yA3YCfv2AHVNCJF8uqXkl+5mwQMweOCLTaq4MeE4hAIf66pck1ZEEsof3GmdCUtSaDkKkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561518; c=relaxed/simple;
	bh=2vK65G44pI1Oc83GR4KGSjOkJ/besk6BZqdDJAUrduQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGBAKDeDRA/ziYdRzQ5d4nKJU/435too7Kn42ttFsGTHnUT2lWJXve3oWeT73c5XNRKvVjhAGTCCQ6kaqjta3nByBCxAT2giRjOxu67LcwEyUFcUg8REtxMeKFA7CN1M63qjnsoz0VMoyP6QsU4hhhKgcopobqTTLsYp66JE0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlJARbeG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlJARbeG"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678664e22fso66606391cf.2
        for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737561516; x=1738166316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viZnlb67uueETqgOooAl7SAHpyQ1JWqquVT+RaRgddo=;
        b=VlJARbeGH3deXUcnWvCXgAn03rCgPMVENAj10vO4ywUA4vLtdSc9gnYCxh33c0whYW
         oaCX/mgbgAwXnPf37nltrUmpT4UTuWhFfa2GfINtJ+/nI+Au61dXYUGw/eSxBeTNK7AL
         gdVoJ2VuhTS7HmP7MgT9npYmW5vAhgW6BEodCvB9VvdueX/r/FfewegTWVsyvy+JvBFx
         kxmjQG6NlvXm99oohxHe4hhnfC0EzAJCCllKbN/IIz51ikJkHuYTWOxfAfgOdLfInpHS
         WK9WOOq+TuBRJDEI19mkqWDU/pENkLxD87/joroNn/jibO44GWnefskxuBvk985aBt9R
         +SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737561516; x=1738166316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viZnlb67uueETqgOooAl7SAHpyQ1JWqquVT+RaRgddo=;
        b=HXuHo/n2N42jagNOm/3TjGsNdvujAWMUNPWjQeLIW5H9haUJ8xt5PSXWjmC7LY5+oO
         ASf+9Im2LBJ+vCm6UAMZKAP2pl3eVFTMbEER/Gzvuv6KoYnjsj1yEsuu6XWD58naX3IW
         9j1rD1ZnGzZJkoceF3AQa3RoJ0USDWjpmUrtocICLtBDJiQssMqokKXIgqWDuzxLhnwz
         AGGernlogij3/5s2b+Pvzl5WGp+qf+GBRRI8NFAW3cvkVqYzJGPxkmpmWMG2z8kkJLIG
         InCrRRX/rYCPU5jTS6CO85Gwn15rTNIu+Nm0a0WDbJgIkj76jo+4d58gF8xqvipV2MpY
         Ispw==
X-Gm-Message-State: AOJu0Yxou9tI0ncTZ0bTzQ3F57VNlv2N+pvIn/xURTV4bAR/CSAowaDN
	uG+N2LwJx5s7TZWOn0gHxDvecN8HY5bTXE7XitbWDvbD0cA9baWVhpSbEg==
X-Gm-Gg: ASbGncscBWEZ4qzjhccUaw2AF1q7QLPqCNre5EUL4+9totoWdZqlpYaxPOjo1007V5x
	bn79zrF/6DDNl0wHcWjXp3MyNwrql1+/y4wh/+zJwr4D350e3vOLihF+y+LtrxusvwxuiIG5eNi
	6f8C32LxZrXg1swJhWi3N8dTbkz0qR+nCLXy9huw7JVUfJQnRG0hD2/EhphfvLfvqrh00RSUR4D
	eoXHpja6KDCHgjnbxIGV9I6GJUWFKvFAhT4zgxV4OBEblcV09AFp8rJB4WYpC2OVzQNrT/UAOCL
	Xx/v72dtn5vRhbDp0ek4y8en42I=
X-Google-Smtp-Source: AGHT+IFImQX2V9Lh758QjTpF3VflkClJ+St8Jb8Fka/lYw7XQW1WrGAPaXNKnZHnXP8UAgv5PWBBGg==
X-Received: by 2002:ac8:7d82:0:b0:467:5e61:c116 with SMTP id d75a77b69052e-46e12a1e36cmr262117041cf.7.1737561515712;
        Wed, 22 Jan 2025 07:58:35 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e258c82a6sm45631041cf.59.2025.01.22.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:58:35 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: lautrbach@redhat.com,
	James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 2/2] libsemanage: Set new restorecon handle before doing restorecon
Date: Wed, 22 Jan 2025 10:58:28 -0500
Message-ID: <20250122155828.151233-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122155828.151233-1-jwcart2@gmail.com>
References: <20250122155828.151233-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In semanage_setfiles(), need to reset the restorecon handle to make
sure restorecon is not operating on old selabel data.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsemanage/src/semanage_store.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 2ca2e900..cf9aa809 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -3012,9 +3012,14 @@ log_callback_mute(__attribute__((unused)) int type, __attribute__((unused)) cons
 void semanage_setfiles(semanage_handle_t * sh, const char *path){
 	struct stat sb;
 	int fd;
+	struct selabel_handle *sehandle;
+
 	union selinux_callback cb_orig = selinux_get_callback(SELINUX_CB_LOG);
 	union selinux_callback cb = { .func_log = log_callback_mute };
 
+	sehandle = selinux_restorecon_default_handle();
+	selinux_restorecon_set_sehandle(sehandle);
+
 	/* Mute all logs */
 	selinux_set_callback(SELINUX_CB_LOG, cb);
 
-- 
2.48.1

