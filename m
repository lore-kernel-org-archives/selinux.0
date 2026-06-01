Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBE3B9920
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323378; cv=none; b=QQy/1WHBoy0zPBF09+QDywuva/8pB8yFF+H2p0JDpsM9hU1MQIaqQJOU83i7Q0YJolnGhCCX/NtMrPL7/kUSF5PUbippLhiURuJuSv3MqtZ1z7SBlyvLzI5+JuBHVGuyIH7PKuWsmAoV/yCaRXK4xd8MYby+GEHjs/PSmD7V6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323378; c=relaxed/simple;
	bh=CKiBHWLf5ZTRmDUvM3u9AvcR5Fxv/vDVkaz7b9E1sc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHX7LtFOOYhoWb8ZHRw1jby2joFi1zeoFuwDZHOpvB3ymRxLrM4JBuQu5MW1KIp8BQ3ymrCci4IU/vzgQ77j/HZ59VWouqoChvIHxKSZUVarJHolk5+APpf7kRmtfOp+wuD3cGeTXCLJamgOwEgr7QBeGH2wX9Jpt8tsG0agZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2oe6pZq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2oe6pZq"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91550d518c0so146225485a.0
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323377; x=1780928177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7XV+paRiQmf+L469EAZFC2xlZeJ9koyBn4tRBYBmqc=;
        b=G2oe6pZqVGCCvkUA881J1Ne1TcVhfXofX011nbJV1W4VikQNCMJJklv9vXBkYxYY5G
         njXORXRpNo6wGQnZK8pDkaXY/E/1sQBsim984qFfGQXpsUZ0Bg9UwKknEZV+RqoQ8T03
         ygguleJ5dPyJhBBCLTPkk89tpJG62G+yUdSapd0/QbE/6aoIkqSdcuGpCrYzsxWI/PvD
         Q3w7xp1IJD3ppalmMxdZUtRFgivG6qHPjyiWK1+3W4QQ/S6FVqoD2sNMiynagsSD3KOP
         f+LtQc2DNRiQ4OlIXN2I3fYYm7zNM/hz6NaPItrbSE55ozkshmtyq7jDqN4kByGol/Zt
         Kwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323377; x=1780928177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g7XV+paRiQmf+L469EAZFC2xlZeJ9koyBn4tRBYBmqc=;
        b=CHVOhtee0DYyj6IR2NSc3Z68rbw41xyzVA21fB+64DrEDzdlsQgiWevXir97rmtsWc
         crX6oZZZk6vZWjFhYHu1KX8zxyzA0z2qFCTkxUlxyEDzcaeNY3dsJfmEazjXhG2QqjAN
         eG7fYsXFe09sYxzhYhSVI3YvJhp7BGQ0CEurykAuGSx2i7V81N45wNXIHPdgN+z1HyDT
         EYsKhPuRYSQ28b54BQwp0SeYpLYjY7ZowiJDOm7Gnv3FRNZnkoMri5nzNsTXQnOeJvHA
         pO5x+x0grUYqBFcpDLFwnbdDQWB919ooOFGL3lNN2hT2eALtkuCVP/G8ghvtlWuKMqLM
         6ULA==
X-Gm-Message-State: AOJu0YxTe9e5ik3Af9YKek5UD+MW3QN+jGERrETEHETiYfGbcc3ontjd
	4T3d+69ghEZeROWvabrn3BO3v1nW9Fq/PW+MMYO6bJsYHpsW+r/Bfz3eoOnxng==
X-Gm-Gg: Acq92OHlv1fZT+mB0iwxIiNlOBAxqdSYPt7eIl0CLpfDfdX9AYSiZQ21vI/2eoDgeP3
	h98FGM/Ve36ovRZCDrlUgm7x80pIPgM2Z1aZqcbpIjNxYzSVW9bIp2o5aHu0aReTdbxuma2MgHG
	kE8hOnEWaaHefG5Q0eCG0IXQ3UX11G9vE2uncp8c9FRDJPztL8rPCmlOBBKAggUCWC2KVlDKTXG
	gDmXUe17mFEuOyML5kOeWBeGo8xBGIE21BhhzFBJRNsHtJwnMu0n34eU3s+FOtc9hpFZAelMj7u
	P0FNDQJtWGZH3M7G89hIaJNENP2MZPa1rNxUy2VKDsZjHZzNyK2Ipzn2G+oxdB4hiKOn+AU2ibk
	wOdg7qUxUqnATOe+/MMLmW8ZO1iuXKgOApHajjCWKUu3R80Adojs+jlXs4uu+3Opio8DPvjGLzm
	rKHL78gbNTGPB4SkJ9aibaHHz1iFdSklfzIoDaPm6WuRisYDZkRN/2qISTVcJA2gDXmFcHPPTjD
	GrXUZHAaN6sv05jSazb4rRn5i93dDxJgGOwhg==
X-Received: by 2002:a05:620a:241a:20b0:914:c61f:c699 with SMTP id af79cd13be357-9153d938cd3mr1210546085a.13.1780323376779;
        Mon, 01 Jun 2026 07:16:16 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91570271853sm109607285a.24.2026.06.01.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:16:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 6/6] libselinux: label_support: move digest_add_specfile() bounds check
Date: Mon,  1 Jun 2026 10:15:52 -0400
Message-ID: <20260601141552.191733-6-stephen.smalley.work@gmail.com>
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

Move the bounds check before writing to the specfile_list[] array.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_support.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index d7636f87..ea2402e4 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -201,15 +201,14 @@ int  digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 			    from_addr, buf_len);
 
 	/* Now add path to list */
+	if (digest->specfile_cnt >= DIGEST_FILES_MAX) {
+		errno = EOVERFLOW;
+		return -1;
+	}
 	digest->specfile_list[digest->specfile_cnt] = strdup(path);
 	if (!digest->specfile_list[digest->specfile_cnt])
 		return -1;
 
 	digest->specfile_cnt++;
-	if (digest->specfile_cnt > DIGEST_FILES_MAX) {
-		errno = EOVERFLOW;
-		return -1;
-	}
-
 	return 0;
 }
-- 
2.54.0

