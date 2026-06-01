Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790853B47C1
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323386; cv=none; b=JTxzmg+dJZXbW4v2gCWrRla/r0CjubZ2phU0Twog6QC/ZhpW5oLtPYOVhgWqeIT7wpB6CqymgS295rU3KJiLtqfiBolO8LmWFGjmn/FxCOlJpVW3+XvR9jNYBJIpP/pr+VnmeSV3nb7OExoRTBIllFidMkboqW4lqfmONOEsGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323386; c=relaxed/simple;
	bh=lpdmmDbcFGbdQieOIvl2XsFnANrMdeLTQggTRgItFuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jv164C+ce12M6fWcG9QiL6411QBd4CQud3bfAiR+csO3wnpPBMmH0xxUEDndB1Ets/DzlIsQnNhVGrQkuj5iukcIYlhIN6PwU6QHFDfHRkdn5aJnsar/uuzIuRZfHee/EUpr+9LziL8R5mhFbyyTHnC5ps8entreiKmDb/CDZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrAVdgkB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrAVdgkB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914b4be9c4bso937408885a.0
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323384; x=1780928184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO4T2msHrlEg8RTOl3BCnKX59QitBtU1/JL2oJP/UNA=;
        b=KrAVdgkBpxfNDH1/fmHCEg4p5UnMB4huC/dM5o8SWASGeIP6exGM2b4cSZDGHK12hp
         i9vhsnbyRASrYlxJ9SAHUDleeQcDt2dhDuZmBxCjVBfwpudO/2i8CI2jspX8aCeY2r7v
         qeZK8ZbEb4HxjwjK6MUEi5r2Be0AOs0dsTjc+LdpJqDZwVx0TqMUrKV3fKv7uErnSwAP
         TkF8CAcnGUha1+Xe6nFbNT3jCp8cspqWU7+cNB9Dx5BZMZXAhm23YeFffPqwUqQIwihA
         bwO1Xd+Bvx3ma4JKD9fAWxW5nZ3M7RSIArSwfhfO1CPD9QOA1zgR8y4IRLNKew5tzhZz
         kZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323384; x=1780928184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sO4T2msHrlEg8RTOl3BCnKX59QitBtU1/JL2oJP/UNA=;
        b=gZv01aWrOD5ZUITzHF3rBBSiSveBVNr2bd5pGCes8i5OYrySn1wxgyaj3dMq2ed2Ti
         HCLVbMVA62mpU6QBD4hD5iPjPlqiUBUa+Ne3o3F5iP5OAWmzIajqUUIl14Whk7n06fWC
         RFkuaQ+RdZ687DfIF7cjRjA0rCLBEiEkVbczCmUAFuXX8LVfGkQHrSuHd4yI9nA3HlDX
         0EKfSJs7H+117KO6fiuXyJvzRH+CU7lK5Qc4P9qVeyqUc/5OTu9LNi1jTj1LzL7Ab7yA
         zlEdT81xcmA4lFxzjj8EWWx4MTqBWB/0Y2sP0+tEsQaSZ5OUvdAIHW6HfGJYRIYn8xna
         wKSg==
X-Gm-Message-State: AOJu0YzqfsLMprZnzPW+LfIp/g3+5OBZfZwJ/44fjbFtElTxuAJAXhR1
	KkYTddzSFZqEldkkEjmAMkmnBPiE8ccrvDpwFT97R8N8MnuBc5oOiEYP8+H3Ng==
X-Gm-Gg: Acq92OGcunvKN3Yi4nDdyl7wL9Ur8OmQWcEa8rVLQ7z7A3Zi8/iOqrLkZjp5kH5ZWbD
	KtiVZ/WDV/dbDWkdvfTxa1eAgTa7SRxTTAGCGaSiu1Hub4nNX8OaXzn8/wPEHpA0hzpI18hc7p2
	1cLn0TCis2G8UarBcoB6v5muYeIG8Du9juIpfgt6rFU0LbO1EkDVJV6Q5RceDzTsL4JnkooyC3j
	XkXiDG8MWBe46Bi/1ZkhPyKiShehgsyx3tp5updOUaHkWhPuoD3kpm6qL2/PzkUJsHxYrh/yz8W
	IO7Rli3rp+a+qReBazCgSdBI3FQUz10i7kXxB/+MwHgq1enwKq71DWfkJSjs1qZqfz+I9F/BVhP
	uAciDKLmbdVdLEXryqGXnvp9Fq3wGISKoyO5jouEdoG+xEWe+ynTCtBn4JBu4oIUrpBZXqDFDbQ
	iSVvCpYjsDW9uYHBxzlerr59B9R3CMKpgcdgjOUJWDUQbAQqQ9QtVrU46+UluDuW7TkBmJkEhM/
	dat6nufFK+4pvmBZ4yY2+h02lSjwvnHWvnLYtu69QWJwP/z
X-Received: by 2002:a05:620a:2854:b0:914:cc9d:e28 with SMTP id af79cd13be357-9153d9c2af6mr1722175885a.6.1780323375261;
        Mon, 01 Jun 2026 07:16:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91570271853sm109607285a.24.2026.06.01.07.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:16:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 5/6] libselinux: label_x: do not leak memory on an invalid type
Date: Mon,  1 Jun 2026 10:15:51 -0400
Message-ID: <20260601141552.191733-5-stephen.smalley.work@gmail.com>
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

Do not leak memory on an invalid type.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 0af5eff5..e24024ee 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -78,6 +78,9 @@ static int process_line(const char *path, const char *line_buf, int pass,
 			selinux_log(SELINUX_WARNING,
 				    "%s:  line %u has invalid object type %s\n",
 				    path, lineno, type);
+			free(type);
+			free(key);
+			free(context);
 			return 0;
 		}
 		data->spec_arr[data->nspec].key = key;
-- 
2.54.0

