Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C833D903C
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603967; cv=none; b=jLWB13PbgQ6HpTcLrnbdr21Omr7ojG/WfyN3LXMmnBmHdCExHT0jIWf3VCNCpFX7l6Dcdw6udKlSJJ+H9DB1LHUiR2ABKKL28eyDPW0Glhuy0OT9OB0zgCXNo2cJof5YUU0RqIB+5r0IBdnhudhXHVS1K+PIPuswargFvh4Ppwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603967; c=relaxed/simple;
	bh=wm6ccKxv6LkAgeRCOgyRIT4mh4Cw+JtyimC33B01K5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCfGh42L9e3gDjjPkynkxI9AThNmsQ59S8P0aro8eP/JUgvla8qdhQUZzafQC0XkGE2n2pSZe+lJoVg76mX/CAQl9oEY0zDrb2/ekEgPWRLxlGWdxHVoMZwjckCUXn3Y5w7OrenS8uCg0Gya3jqYob21D9qhXi4JZhi/8FNzM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCfZF15m; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCfZF15m"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91578122305so183093885a.0
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780603963; x=1781208763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=peRkZa8Mkalv+uVNdPLlF1Kq7vEaO7KhdptPz5sS4Vs=;
        b=oCfZF15mXsrsZ30XQHqvCcYI6WmgXauZhfrtRTKXXFE38gX8ZPt6BOZZyv+mekRk1u
         o2WaUMRdYHwPbJXvKvWX/4mqnwZRSGaVdZ+gPXxRL/+YiOpqXoZYfiIoIKvdj1qHmGT7
         K/IjP9HSMRvo9mhMQaFaNq3gN6WqSsvOpt63H1qENj3ZchMh64Q3tg9sBI5sxhaYrhfi
         GOmGrIicLIqasBzdavuaARpxkBezFaJQPGZ3D8N8L71NsIQDz+eDD1qoDRaTp1sdz7pd
         YlgIFtuTXtAAGHAVeYSwlTx5gadjpg+hRJBIK1pY32kRAVekLVAGC2J2ZOiPhxxpWslB
         hbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780603963; x=1781208763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peRkZa8Mkalv+uVNdPLlF1Kq7vEaO7KhdptPz5sS4Vs=;
        b=QS2SyIaeJE5qWRe2jCYOr91umuk3lrLDSGJjvzawmWEOxuS5BxB9eLCMj/V4bgzqSM
         k86jyy3ANg6u5CTI52OYoa0UmozzyvZEZoqxH0P5HNwc/mCN3Cj+4qPkuRuPbASdhzMp
         NMCxb7w7nG6nDiYiQUgxy5sxvzKhOgcyo9IHFlXkboj7FGEDwXKC2c35MO2e+QYnKYKZ
         XMB/855m6jrIDuk9hfhegdazU4RqcvZjgIowmoKY/dkhxJqF6szek8O6jFCK/T8WFP4G
         bO7PkEyxStcscwjOtoKyaQxfQrGJhaF527WhHQ4okkbtPSpb9RKJ9Bz01MqbFQuSDwYg
         S5SQ==
X-Gm-Message-State: AOJu0Ywfmsjz3W1gAwl1r0cIW65f0wggOsSlNvirXH5Krl/whTtOb01z
	arNvUCzeVRsxr8jmqYO+tSym6f1QChzIAef+WRvvJc7yKT8A7X8X9Qabye6ixA==
X-Gm-Gg: Acq92OEzJlpNhqEt4pPh7WhsjlmYTs5kU7kcLkQBOn0AhoGrWWVYES1cXYhMmGwzzXx
	FIj0CvUEYzhBELZxt9p4NY7LICisFiwaixrKDjYvkaJMd48idw15dgOTMB4TQDref2pa/0kHDtI
	eBnk16YTvyADQceahT+7cflRjwnlVWZvkTHx49UfUtIrBkVwO3gX7CENXuhlmaZZejWmNIDxkak
	co6lYlcIYHVBkhc5HTe8M74rfhX5laTNgDLSwi0N720E/A+KDzycAD+vnJiy7yI65e3rj4tgmpu
	r9Xe3Xp8VYbTmapGR1icgevBelDMGtZNfy2j336lJfPYhQxD9Gy3tNyzFOhHXYu7f2eEHY+VWyj
	SwZ/B4QWl2oqK5KJ/2VcPyOhZThw67yZfXHU75xHD24L7maPAkqbWj0eQjPOIIt8XY6ICdfmLlc
	dQuc+G2nJuKsTb0CUb6v6zVmKrrrX46jTR1mFFdg0HgyeoKdYJgO812Xs08MEeyggwzz0=
X-Received: by 2002:a05:620a:6011:b0:915:9bc2:8019 with SMTP id af79cd13be357-915a9dcbc87mr126013585a.53.1780603962871;
        Thu, 04 Jun 2026 13:12:42 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a009fe7sm664981285a.8.2026.06.04.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:12:42 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Ensure dst gets set when copying range transitions
Date: Thu,  4 Jun 2026 16:12:28 -0400
Message-ID: <20260604201228.61342-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there are no range transition rules or an error occurs when
malloc'ing the first rule, dst will never get set.

Set dst to NULL immiediately and when exiting upon an error after
the range transition rule list has been destroyed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 004bb61a..70742fc8 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1498,6 +1498,7 @@ static int copy_range_trans_list(range_trans_rule_t *rules,
 {
 	range_trans_rule_t *rule, *new_rule = NULL;
 
+	*dst = NULL;
 	for (rule = rules; rule; rule = rule->next) {
 		new_rule = (range_trans_rule_t *)malloc(
 			sizeof(range_trans_rule_t));
@@ -1528,6 +1529,7 @@ static int copy_range_trans_list(range_trans_rule_t *rules,
 cleanup:
 	ERR(state->handle, "Out of memory!");
 	range_trans_rule_list_destroy(new_rule);
+	*dst = NULL;
 	return -1;
 }
 
-- 
2.54.0

