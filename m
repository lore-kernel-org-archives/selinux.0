Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961E79DD9
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705795; cv=none; b=FJxzarBPZnB5gJ6h6ijlXiN1sOKHjOoIqgkW1l5pH4m0nGLV6ps2NpDsBCXW7vdS9pDRBzELwd5BACmNpk/6GNQN0/huLgaxMDB6+pSZ4r9N9ZuOB5py+I8Rq/oBwRjZvhYAY/Pl3y82onMfrDkp/iQRXBBRjkZxJOz+JT+aWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705795; c=relaxed/simple;
	bh=un8fF5Vli12ssR2aE2IKT3DPB9zNkOQurQ+OL9fUgq0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQ7VJqzNPDvehCqLTCeLNabBejYv56jsEW1geBoBA2uC0CtJElJBK2WfMQcWTAzfmc0UAE9y5Zi0O1rD4sxpwUswwbDVHkWHeeGn//BXXBspW5J2C3cpKExT+6vQ6p731AC0ouiwLFb3bYMx7lO1nUOgMGkLGDf6nKZhqs7eg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=On0Iw468; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="On0Iw468"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55f496d60e4so2280072a12.2
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 04:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706705792; x=1707310592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1zcABY/nnqoyzjwHyVxEoDLV3Ze/r3j1cZ+0Kxx9/c=;
        b=On0Iw468+Hzah/y/6JiBmhN2fGwB+XOZ6WGDV4b+bKUUSs0kWYuvZN2SeSdKeCFkXx
         ZB1mczK0+cLaMqC+G2nDu8U98DcOZFOt875ef8QPPU561dqHqxb3D9h6NTuFM7dx5WId
         wyojpG1d266iwP9n4zooLyd0wwMqJhjQQ1a16hFrEaASDO7w4PX1ekyD9zGCfOyJQyTc
         hhl3eXgnc/F789XUng1Km26mQ3hIBV9fPQ3ZfFbFm39g22eXvYfV3V84QA0MNjBBn9sM
         oaqw4EvWTQ+3DdIBDzrxDeLUgg6a/HFWPpLkdL8EDQFd/0lWuHyjR03va4VG2A7jedk1
         YdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705792; x=1707310592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1zcABY/nnqoyzjwHyVxEoDLV3Ze/r3j1cZ+0Kxx9/c=;
        b=i+UJgih53Iz2CCr0ICzGfNpuzbStAHxjczXDj9Lb2w2Bqh6ztnUauFMyexjo4hg0vO
         i+I12Xc2Fh2yHDpk9ZPYKXyaldP7F9a4kPDCaqZKWYHdoG5Pqqr6zVYjfb1C/sYPjG0P
         prEgAv2RnAeE5eFmIZepPZksuGB1Z9rDmNloz1W6VKqrHEODKWAyKLUtchOKq3ANSO3B
         20JJ5bRwElIXCzHvYbfWUDHia6ZKpa4+i9WQot8h5U4EH8ixPadrZLdcrbVS8nELgHKc
         Vg55Ut4dRqKTJgTVdomjsvYqre/p0Jo3vavv+2Px5tBRBTQidRPN+TPKSa+YOT7LF3aL
         U19A==
X-Gm-Message-State: AOJu0YwpwfstRI1L65qHHsfWlzJea8pSjPeJUAcCraTiXYi7oN1oJ1NT
	XJDNIx2/h7ioHkDMv5CagIXJVZqboq56U44xhwUPVL2i0dSOlSilinoA/H9e
X-Google-Smtp-Source: AGHT+IGNSI+wJubwdKLO/n9D59kFD1soe90G12Akpi+UPenbiYDQuuswbMyZaEP02jsJBqOMAKiRww==
X-Received: by 2002:a17:906:40d7:b0:a36:95cd:5e69 with SMTP id a23-20020a17090640d700b00a3695cd5e69mr281562ejk.64.1706705791727;
        Wed, 31 Jan 2024 04:56:31 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a34b15c5cedsm6248843ejb.170.2024.01.31.04.56.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:56:31 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/3] mcstrans: ensure transitivity in compare functions
Date: Wed, 31 Jan 2024 13:56:12 +0100
Message-ID: <20240131125623.45758-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131125623.45758-1-cgzones@googlemail.com>
References: <20240131125623.45758-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ensure comparison functions used by qsort(3) fulfill transitivity, since
otherwise the resulting array might not be sorted correctly or worse[1]
in case of integer overflows.

[1]: https://www.qualys.com/2024/01/30/qsort.txt

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mcstrans.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index af3f507e..fded3235 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -952,9 +952,13 @@ find_in_hashtable(const char *range, domain_t *domain, context_map_node_t **tabl
 	return trans;
 }
 
+#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
+
 static int
 string_size(const void *p1, const void *p2) {
-	return strlen(*(char **)p2) - strlen(*(char **)p1);
+	size_t len1 = strlen(*(const char *const *)p2);
+	size_t len2 = strlen(*(const char *const *)p1);
+	return spaceship_cmp(len1, len2);
 }
 
 static int
@@ -965,7 +969,7 @@ word_size(const void *p1, const void *p2) {
 	int w2_len=strlen(w2->text);
 	if (w1_len == w2_len)
 		return strcmp(w1->text, w2->text);
-	return (w2_len - w1_len);
+	return spaceship_cmp(w2_len, w1_len);
 }
 
 static void
-- 
2.43.0

