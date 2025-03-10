Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996B33991
	for <selinux@vger.kernel.org>; Mon, 10 Mar 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614865; cv=none; b=JMyDsIg6tH7wBFhCwI6iG4Vj0txeYfBjsS4ewW6Z0YGMxQ5HHMG4yzl1p2asVft3iI+tpmoCoxOlxRtmI0EvulSie1qaItrrv+vrTTmReoG81vUIK+s80uFv3wH4H6pZllc6RIfEWt190G5VjCKdgoXtYTeKmrRpGrR0O8BJm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614865; c=relaxed/simple;
	bh=nIzgCTZUY/o3WMjPpkdjsfJ383w3eJ0nzN/Cklt6ooQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTzjVVRtxtfdzDpDbuMLru8Z31oXiUxVVl6HUEDBPWsx1kl7/SXRbwo7Wp5U4s420Ha3r/N8EvogLP94hYqmHilS8UDI9yxWZZ5Slwdwm6ov3SE5IAbbBm6EsKhaQRO0JqGjtqQTbJQsEf3ixbrKBSMnZUTNmdSQe6WpucWkkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THaY3Ukt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THaY3Ukt"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c547932d2eso96570785a.0
        for <selinux@vger.kernel.org>; Mon, 10 Mar 2025 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741614862; x=1742219662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ki66pE2CpFI23vkmcFdiU3TPsm0t6J1ofXV46IXgXVw=;
        b=THaY3UktElzEs5f0HWZwcfQ0JANeumD7JAL/quHa6UlTSN3+0uhDfzHiMGdRJo1YD5
         2mQwUwZOlTvzZd/MOhLEzmp1azYjwM/7kT8yWS9B1yXXPLU2Lqb8BgndCiEnrPfeX0hQ
         7Hgrtv7MwvgE25rydHXk7GLJlR+XiGnAz2KgT8Zkc8oD5Dj2yvJs9e1O0+7ZydOChcHD
         Gch922yx4LcJ6HFYSazh10KILSBVMdOpxJNLXwz2y2T+LUxt+7UlLE4I3lbJ1U8KN2zX
         FlGEWg6bY6XPBN7Qc2gKTVbduAnrfzqLpEKLtVgfKUiKk1mpQEGyspzalp3ZHPXWBXah
         hcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614862; x=1742219662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ki66pE2CpFI23vkmcFdiU3TPsm0t6J1ofXV46IXgXVw=;
        b=D2O2lEkjUooZJZVRwC4djdubcwuHGdRvCeDtDLcQfjlHHfVDRNOEvDGwD1QxYDVwjo
         hxgZujLJhh7PyRMTqlloycupPs16CnmuUIL5z+eL6ppHKJxDQ6QFH5soc5EVFpSCD/L+
         AHyd0ObP+DtvUjbpvH46vqAwlrInotY5myVCWhPKVZdx8Usc+nB3EmZMFr2l4Pd8zbBA
         thxEuhpIc/pl5cz7hJ7c/LdJfgTcu21wXeUrTcUXIRtS1M0bnsrL7tqsUtYXF+jOCVcH
         c1rgu7Fso1IhNQddyjEJ9LsI4doaovLI6QY23MuuTRwzh3bCHCWrBu+TaxPu1uaEXZDf
         a3vw==
X-Gm-Message-State: AOJu0YzbiTdMKScVky4xeiXsTYME6K3Y3haqaCpJbRbL5b65thmlIA0n
	zgtgoU0UJNK1ZyBO73WAwPV8NcV4DSt+mbTeiP9NL9Wo4PR9BTma7n8njg==
X-Gm-Gg: ASbGncsg+2NcGjAJnoes+Yy8O7tqCLdhmG6Wk6xxIvRwL7nnsuZRVBki0pL0XgsSDHl
	IQHejSp4azPMiPscx0XmVX9oFyETmVX2bGx0VvYHIrk7lZixj1OvQUVUUsivQR8Kq6D9RaUC+L7
	5gULJGObBQoGhaUHOasANB+9hi3aRJVp1wqyYdRjxOhhLwyWfVPA5v9Do9btFm0eYNZZpoXNyke
	4zGTucsNAsff9539Ep604NkdcOjtE1+qC9Z3JcpnO+jDaGg0KxrD8GxOERSvIT3aneBzi+hXadq
	mTcErrZ1rtTCU5tp09+pcFzxejK+YMFKS/v9IhFyxvDOQOCbv3yzh66gFxcCuSM3NW9Uh2mokDI
	6piFREPplsXedDadKcXbZld0qIyPwH7++y66/V7k/jvI1igEAu7yS5Ql93Q==
X-Google-Smtp-Source: AGHT+IHkzK3/G6MxRDaLY0ORMGWt1L4tbVZGWa7D2zLDRs3NXk110429doTKQfKH3gN3r8CkeF57MQ==
X-Received: by 2002:a05:620a:838e:b0:7c5:3e22:616e with SMTP id af79cd13be357-7c53e226288mr1513852485a.56.1741614861749;
        Mon, 10 Mar 2025 06:54:21 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54b916f6bsm261833185a.30.2025.03.10.06.54.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2025 06:54:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mailmap: map my old email addresses
Date: Mon, 10 Mar 2025 09:54:04 -0400
Message-ID: <20250310135404.22385-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map old email addresses that are no longer in use to my current
email address.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index ae0adc499f4a..850221fcd63f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -677,6 +677,8 @@ Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundation.org>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@osdl.org>
 Stephen Hemminger <stephen@networkplumber.org> <sthemmin@microsoft.com>
 Stephen Hemminger <stephen@networkplumber.org> <sthemmin@vyatta.com>
+Stephen Smalley <stephen.smalley.work@gmail.com> <sds@epoch.ncsc.mil>
+Stephen Smalley <stephen.smalley.work@gmail.com> <sds@tycho.nsa.gov>
 Steve Wise <larrystevenwise@gmail.com> <swise@chelsio.com>
 Steve Wise <larrystevenwise@gmail.com> <swise@opengridcomputing.com>
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com> <subashab@codeaurora.org>
-- 
2.47.1

