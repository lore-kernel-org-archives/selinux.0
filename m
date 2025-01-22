Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A0211475
	for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561517; cv=none; b=BdyA0iPZMnKbYlrMZqtj4u7c5j9hSrggupdKdBAydI/okxXPcSqMegjpRIKOAw1uw13xepU1s0LEPklg3TiQ9pdMmp92Rh9WUZf5evObxkKUGNV/swl1UFoQS374MA2Cn6WSEw2YZwU4r9514n70lPjvfdamilns8dg9ZhFb73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561517; c=relaxed/simple;
	bh=EdoKCudbs7wOkERq3yGIL0fdnADusR95cThWen+Rtqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YinFDie2K+rZhfAQZ5hTjs3PC8Zc1JBBvmq11OspwTQpoT4BIaS5rW1kJ+dpCaorga9hrZDTpSbTZYiQXl5u1MWhafzwa5Kn2WSfZmedBlEn/f/vuaLOZXNuu6hb9s2msiEHS/nLY92NxDNuh3M0dWrOA+h8yHnQFfAaiCYn6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJgEK7cg; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJgEK7cg"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6e9317a2aso92351685a.0
        for <selinux@vger.kernel.org>; Wed, 22 Jan 2025 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737561514; x=1738166314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aqafnrpvjgDELsY5yxzw5WgsqDwJrIfGcb7Ss5vTLk=;
        b=GJgEK7cg87EGL2LJIx9luUQRXJUkYW3SqJTJFURQTKu5lQTZcJMGlznm3fB9kUsYYa
         NPINwAWltgtiu2y92fz8D2uV8KxwxiAUeepyeJmdKbScY7fUktV5YHPTWPPsHDXmFMyC
         A3U1QKjVB/D8O9cjn48ulSUqEaeL9w69m9ggtmkBC519ySo6CIhfAypayK+DKxwdiT2y
         HtM3BC2xCCzg72905CLoDzJB9ducpmHdnUxCmaF7ND1KSz+8P9GGTuBaAxj6EmFyW31a
         4ICYmJNPUygHVIaY53izdMixzm3zyCinOlMC+zCjZcOTH/2+UBQmIQMYnjg0bSus8wdE
         CMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737561514; x=1738166314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aqafnrpvjgDELsY5yxzw5WgsqDwJrIfGcb7Ss5vTLk=;
        b=HV4Y0xiauE0BpJSmU97gm+1EDaWD8ghoqNpCeJg3qJG2c2asDM+/EeCxIY8jUbwSqR
         NYR4ycBn6OMk1VzO2heb5xrHVlgnvLdWdGlLrl8TQEBzkd6W+8+IZ/1ki7wd8/tQPn4y
         wWsSFxEvIbsenwtJp+OE1+ROVwnmS/MMuOlDF9OPXDpI0Bbu9d+2WjXPx/5lztTuwcb5
         SZn3n4OTSeUprzXe7GqFsFmXT0Cst3OalFqUiFpRWMI1j2VnNWugwtTjxvSIKnWamYtQ
         cjVu2/+r8JspuXql5tLZPhR9TtaL9+FKqH5HjEAm5+gKrNbPXDHdfgoYeUdmSPrgNe7k
         IhdA==
X-Gm-Message-State: AOJu0YxUeN/9FioH60AUAHWHBD2SDyl2srpH8MGPCdTTw4tgLUOBAQvn
	KtFkLgZJbSYhlb3Cbcs5nv20GSPLhM3C9LRIsO7QzAHZp519ycH2WSavwg==
X-Gm-Gg: ASbGncuqGNeRIEjLzGFJBJLjj7RD0onsm5gtYk79iyMkO2+pWDN4gPHnxMZlMyB6Hcc
	p/F9KPhOhQYr/CEIzyYfn2zglbgAaDYJ0zIL0whfcXLTZHJyr8p4x5vAYxGSEG1L8DwEcgptDEA
	qLEzkwdh1tdjuun8d0jIFZ83JoX6U+i5Wz9l2xkk02qSkdRqNWtAqYM4uGalbntc08b8k4nzyc3
	Lohp+QVQnww9/6mWUDvUyc5sNFwBQHC/dzoNQK9qqMmn1LSaYW4bVZ65iajR7+aRJdemRZElMUh
	M0/q4pUO25XD33BZau/kWkpTGRg=
X-Google-Smtp-Source: AGHT+IEs5fOSph3loQIkjPgAgmcCg4iZ4uxvsmSVN1bwFDV04T9U6JP/mQP+Z5eBSkhO15rvlcKXwg==
X-Received: by 2002:a05:620a:601a:b0:7b7:12e:48eb with SMTP id af79cd13be357-7be638cb078mr3491898585a.17.1737561514501;
        Wed, 22 Jan 2025 07:58:34 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e258c82a6sm45631041cf.59.2025.01.22.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:58:34 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: lautrbach@redhat.com,
	James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 1/2] libselinux: Close old selabel handle when setting a new one
Date: Wed, 22 Jan 2025 10:58:27 -0500
Message-ID: <20250122155828.151233-2-jwcart2@gmail.com>
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

In selinux_restorecon_set_sehandle(), close the old selabel handle
(if it exists) before setting the new one.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index bc6ed935..ab1c5216 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1367,6 +1367,10 @@ void selinux_restorecon_set_sehandle(struct selabel_handle *hndl)
 	unsigned char *fc_digest;
 	size_t num_specfiles, fc_digest_len;
 
+	if (fc_sehandle) {
+		selabel_close(fc_sehandle);
+	}
+
 	fc_sehandle = hndl;
 	if (!fc_sehandle)
 		return;
-- 
2.48.1

