Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3535C1BD
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613513; cv=none; b=aEYeGXLrmP2m5nfL4QHiRggHiPJdtqxb0my2Z30GIQFY6Q1gYd3RU/gshZ+s0Fpq3e56OCuZnU4tccayxpwIuM/uNXlz+vuXxuuzxJWyupVnadeAJG60fWsBDi04u/56N5OUr2rUztkZlCKFNQk83C2Brgd5NhKBLpZeLkerMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613513; c=relaxed/simple;
	bh=hxs/lPjo/RxfEF9xhuFHAozA5lp0sDkjGEfmDBPXmDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuGP/lZ4RtBWbRKLvSRyBqJbNomOHJSvHHMC3hmOc5EWm+NFWox664aZYF17+5NmC5q7KYFImv0DD1DEtEqAdiv3AoH986st1MsRCwb2xsoPKOC/UdRTJhr+PJT29g1EorWbkQSeewb3VcPOSXuGTIBc4VmltCh5E4ab7ZHX6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1PDe3t6; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1PDe3t6"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8db35680d0cso204756d6.1
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613511; x=1782218311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygbXKJR4v8ARlGiPyqQlMNZwbXsm4MbvkaRXxbjXHRc=;
        b=C1PDe3t6J4zh3WDQlpIQZnPWvtHBBXXzSoWQY9/Qlbm5C6ewi8rgjva3VKJQG2xEm7
         0egstXQrRlBFeHmrJ5niqvGnEZHVcjzT8XCX2cTK3S0bdZew4qOwYgMEWe+cXpMQr1RO
         TDgxEERvtpMEk3fVKmg+EM8nFbam3C5dl6KSuCAMRSTV0tDiXML/qBbVYmFr7CnJWwNk
         BIOhUZcjNF6rgC4zFjj9F+xZ08kWJB+oT1gqa/B5dSBHvHnbuad1IfW8SFBL3eoRqhFs
         omxZuv6LlqH12Ny2dNFNfhbEzVSBPzJWB8G2cudJZHvo2NoXAfDSrkdznpiUGK2i3gMb
         Y7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613511; x=1782218311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygbXKJR4v8ARlGiPyqQlMNZwbXsm4MbvkaRXxbjXHRc=;
        b=spd92OUmncIiS4qJZf1PcXIlQRdwguYGCjqg8M8o+0qcgddR1EcPYns6eMRa4vily1
         tYS/HsgRUPi7lICzvzfOqumDwZTg6NxsrkCO8rLGP+otYz+FJ6wg18ZPWWwJJspUL3TH
         AbZNzKFppRzsotByQ7K4ADJTe6E/xZjKd4zC2aUQyi0aOHJU5lqzufNvcfVfiEZD4H66
         xjUb4fwbC8IzI42FFURvAQ6YrimgAJksvZtNK4JeCc8Eatqed8BgCQDHGbC5Mpb4lYUd
         8SnVtKk+OVFnD1VN0vQeYD+qf8SnuPfbOoufH9f4hjIGPXtZF9i8Wu9WDgTwor74l4wm
         cxzg==
X-Gm-Message-State: AOJu0Yzao8Ca2WL1Ut6WwgFL+W11vqMahTch/GKp6TVhovm9gU1mF6Oz
	nkOjtq5zusy9tj15FqhGKegQPy+OOUs5g6NNG0C5BSu4w1QgSIW3irGDWwIy7A==
X-Gm-Gg: Acq92OEmh9QCyKW1MHDXjWXVd7khrMh9BccmgaFpVUzTyDUTymGC95rFox2zTMvsDe1
	BlSNHT38jen3nnr1cFWlS9PBEITMoocCUaoqwntrTDWwmHxiFVS/7NvdxPHJt+ICXz153Aky0/7
	oEeKyYJz4V7mpTFzuWrnBDdZGZpV35jsREtIzdInEoh7BmWwD7IQEVqdbnzAKWhNKAIamZK+2pR
	SdXSs0xxniGU1FxBo6DkeyIqO7dB7k6bymfjQ2FSAeSw+wGIqxWFWrdb92Ri/QM+rIdPrr+GPen
	zbadDEfgWkdzy4Nw8NgZhCHu5a3L77Gnuuefsu4nGcjAH9cSc2aJGVneIVA4MuVYEXqDJnkESCV
	ealzbZOgkM1i9TTpPm3BCHDzBfM2+4AbKxmMFlyQAhjTNYHD6KgeHAbf5XnLe0v9OENxfSpGJ25
	evJCzbwxjmgdU34QYzl6vIVn2NilqCB+o5h5l66fbdBP9i1H7b9PgccDwprJLl+zO881nE9oXZ0
	7BHJy1ujKtQuIFOx6NXTx0X5cI=
X-Received: by 2002:a05:620a:8085:b0:915:8a4e:768a with SMTP id af79cd13be357-91c2e422b9cmr445655185a.14.1781613511493;
        Tue, 16 Jun 2026 05:38:31 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f019aasm1396033385a.13.2026.06.16.05.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:38:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] libsepol: null-terminate temporary buffer in mls_to_string
Date: Tue, 16 Jun 2026 08:38:16 -0400
Message-ID: <20260616123816.52192-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

mls_to_string() allocates a temporary buffer of
mls_compute_context_len() + 1 bytes and fills it with
mls_sid_to_context(), which writes exactly mls_compute_context_len()
bytes and does not NUL-terminate. The buffer is then passed to
strcpy(), but its last byte is never set, so the copy reads past the
written MLS data (an uninitialized byte and then out of bounds) and
can write past the end of the destination buffer. Terminate the buffer
before the copy, matching context_to_string().

Fixes: https://github.com/SELinuxProject/selinux/pull/527
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libsepol/src/mls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index 1cc4e881..ab382e96 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -50,6 +50,7 @@ int mls_to_string(sepol_handle_t *handle, const policydb_t *policydb,
 	ptr = (char *)malloc(len);
 	if (ptr == NULL)
 		goto omem;
+	ptr[len - 1] = '\0';
 
 	/* Final string w/ ':' cut off */
 	ptr2 = (char *)malloc(len - 1);
-- 
2.54.0

