Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776A440A24
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753196; cv=none; b=rhJCXJ9fmvrvqbNFGJv/4Crkugm56DtH8Pxo720x0v1BpwxzKNVRNcG8QkgR8dXvEFuqbslBEvRhSBj+E/zfwKxYmq/fs11TGJILxASOzTpy8CPs/Dz52qb+r+LwZIh6zJEvk0wjfD8CmWsZDex6pQGmmrDUpqglIDp1E/X0lUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753196; c=relaxed/simple;
	bh=qPMDNn8oFvFTk/i3JeBZgHY0WwcJ7jtEHLpiEcXN85I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGvPbNyzMdhDWLqUgj0A5u6tx97PlnIUB5Q8yhNGwE/iry/rwDgGCd3mCjGMeWC/hbpDelJAisLGxmkcsDicf8AWXAl2NrAJ7u1e4kO6hYJ+GK6QFqNLg8id+FyeYug2P5Lqs0rkU+k2A9XovZi151r0tgaf2ZEdrgyXy52oI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyCErK1V; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyCErK1V"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5c9211d2so80258685a.1
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787753194; x=1788357994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ignQM7I6wpHjmg0x3pKm+pbyPC3kO/+h3mGgIkuewY=;
        b=KyCErK1ViNZ8dOt8fImnSbUcB7ozIrsfpm6/WOZC8Vuk3LHj5jOlWMmzxIvHyO2DXk
         VcnEuo5LGFc5t7EW8qR6PtHv01iiXb5A79hVLduSzu1kD9h5cllgxuUEmgBtEILcHQT6
         DkpivOAf1V756wfH+PQT3abK/30tvIeU6JAc9LfU0K9MCfbrZ94xTS8q0lNya+NWIOr2
         gsF9VOw7nfplqEHBdIElY0d8lCaVWdHznNW8OyOhDPjTgq/HFCy04v0yUxk3yq5VD8Nx
         wvyQmMNGTQu90Vuk/u9MfpRP/oJul3UBAxBqKlSSSEtOEujuMnz03RVvoHsAImSZAMVN
         pdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787753194; x=1788357994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ignQM7I6wpHjmg0x3pKm+pbyPC3kO/+h3mGgIkuewY=;
        b=PNzqWfRav9Sn9lX7OF5VBaR8PbLc5GBfxaqqBfbWLs2SkdatuYs92U5bS3Zh/wBS5j
         UzwPPV83+UDScwbaHDgwJhw01SG5x1X6LPpFgqhrt1GTlR1NnIcyuH6MLSmuu2IF07DY
         pZXEQ28pV5m+avbzgxGVfoXhMUoSOI2HfwEPqAXsbl6IhbP2tVzMK85toRKvjakIzRVM
         Km6STbavb+j1l2qIHC2CRZOoPIMwiV+kQ0KJjVKd+pORuzcskcIdStCs1i5ksIlSbE6z
         0WRHRG6QK0DKrUmndfXAi9zHuPFJsCVGo262LRUZc9NfitAWMDR/3+3NN6817uCSfB38
         mhLQ==
X-Gm-Message-State: AFuF++k9yhA1TxUhRaPZpmqUlcdCso2++b9vIzwNrW4p8UkRt7QGRxvL
	aD9VObrPTcUb7JuxhOdb7jr8ToPUXyR7RaiKVpkA4IZKD33FsYqaeK+BCPx53A==
X-Gm-Gg: AR+sD11o5qcYtRZGwr2xU9AnpmnXTRtOv89+DdskJSIv+0RsYkcyhl7QM+QIhSeKGF8
	HJ4ps5pvmcoXIXzCJY9y7nI2AsKYmizCiChUd+szAZEOg69TvBDZrV8h3bHOeT4/9NWYiESujZu
	FSyYwROuqmM1KwqI7hxXJYU07xoGYvlEKLp5c5mPDKZWMcvUfYpMc9M634ZhI5asoa+WaukS5Ys
	IK+CjnNMJ6hGaKeKS/osEIsjV6rs8EkFOZOVB1tSuuK+g8mq0D0AL7wpMuCm+Sq5QjXNbF+N4Kn
	/YnrEZBao01PJJ29B1PkapZZSfiRGOs1HukgVWry9r76WJBtKkKooW2Bz9a43fshGoNMcKAJlh+
	kCi01CYJQWBu5CRlXUcihiTLmHTwFS9hMc3wH4Em1wuOG91eCsPQzBIuvlvTiiOMks5ySZCN4ji
	WJVw1v5LfI4c7Y4S45mr9IqG78JuDZh09e0EXNiJeXgUzFYhYfeZYVzDMLY6ygnST8Ypyd6VFrX
	8qtsl66N1eFO9sIdmjSe+ZpopdstY09pfd3yxXijbSTO/TGk+oGslNwhfHew3yVUbboh9PUvO9r
	BQYGxyR9r3+jSgUATLos0+9em0Y=
X-Received: by 2002:a05:620a:29d2:b0:937:7836:14ff with SMTP id af79cd13be357-937804b39dbmr552443585a.33.1787753193083;
        Wed, 26 Aug 2026 07:06:33 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e64fa07sm213624685a.34.2026.08.26.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:06:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: setrans_client: free daemon response on error
Date: Wed, 26 Aug 2026 10:06:26 -0400
Message-ID: <20260826140626.40798-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

receive_response() writes the allocated response buffer into *outp on
any successful read, regardless of the ret_val the daemon reported.
The static helpers then propagate ret_val as their own return, so on a
translation failure the caller sees a non-zero return with *outp still
pointing at the empty response, and selinux_raw_to_trans_context() or
selinux_trans_to_raw_context() overwrite it with strdup() of the
input (i.e. they fall back to the identity function for translations).

Free and NULL the response on non-zero ret_val so the helpers hold the
same *outp is NULL on any non-zero return invariant as their other
error paths.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/setrans_client.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index b0adb308..46cbde79 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -218,6 +218,10 @@ static int raw_to_trans_context(const char *raw, char **transp)
 		goto out;
 
 	ret = ret_val;
+	if (ret) {
+		free(*transp);
+		*transp = NULL;
+	}
 out:
 	close(fd);
 	return ret;
@@ -243,6 +247,10 @@ static int trans_to_raw_context(const char *trans, char **rawp)
 		goto out;
 
 	ret = ret_val;
+	if (ret) {
+		free(*rawp);
+		*rawp = NULL;
+	}
 out:
 	close(fd);
 	return ret;
@@ -269,6 +277,10 @@ static int raw_context_to_color(const char *raw, char **colors)
 		goto out;
 
 	ret = ret_val;
+	if (ret) {
+		free(*colors);
+		*colors = NULL;
+	}
 out:
 	close(fd);
 	return ret;
-- 
2.55.0

