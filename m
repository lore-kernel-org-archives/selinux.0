Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EB3164A1
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254396; cv=none; b=JtFHx+LG4gONM2mEZGMiAkFBlN34bHxnUk3G9o6Wk/xxnKC01BunHG2YoPXjLcscpzURYtg1d/lPwXlhd5vz3uJlj4Bo4hLikaScr5IU6mAQ14ozzxhQIGB6imNKO6KYLXLwkqS1rfMjf9zvUHpybhgTzx2401LsdOoXOUkoonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254396; c=relaxed/simple;
	bh=zx3WubZPys3qQZ9hjzoig3BrUfn76syHM4LUOku80x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7u0Q4Ka9A4EelABPxCr2XZVRmsd+SUSJrYdaWrlhuyrEWRojUv5zmKdA/qiEa3qYP7NsQF18/WDj1uC5auvF/VgWFyvGjmj1wXIkAt8JLKNDzplItmPXtMBofddqjpkAVYDiktHWpVSwAJ036BmxsVzmFOwrKNjCuXAe9TbbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuFzr/K3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rJo1z+9+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuFzr/K3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rJo1z+9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIxEocxEapJW7yU9OtfyLhPCnRBq6fT8ce1CcmY6sug=;
	b=cuFzr/K3/lCCNtXG9TWhKNqpWtuEBrQD8jPV3o6pv52qBZxjwahEFo/uOAaIsAFQhaqjIo
	NjyFGCLpVymV/0325dM3aEhd3YLHHSW7S57yKdqlLkjAPJWkfjZ2kr8NOqyh+vktnKL016
	ihNfMfd7M+PkFRqeu/fgEDMPV1XYaKI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-OIjn5z7DPTmUYuWiOzPFPQ-1; Mon, 16 Feb 2026 10:06:33 -0500
X-MC-Unique: OIjn5z7DPTmUYuWiOzPFPQ-1
X-Mimecast-MFC-AGG-ID: OIjn5z7DPTmUYuWiOzPFPQ_1771254392
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4376b624589so3254730f8f.3
        for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771254392; x=1771859192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIxEocxEapJW7yU9OtfyLhPCnRBq6fT8ce1CcmY6sug=;
        b=rJo1z+9+eVKxNpXT8hTbok3DlMsug39L9ZmZyXs8HXxMd5/qwbco2B5rsHfcj0DZK9
         l4dTUsA+rf1eHjjv9PBumTPUlfehW2Iyx6NjDvxxUQub90GfycXtkcrdkuzzp0Zprglc
         eOl8DHs8/ZZiamLGufa7JU8q6lxi/Nyu1t5yitPT5QJFs9Yh8hHckRxTwVP2Z5b8DQY0
         LkDJM5sjXzbsNSO2RaYHLtetNaXYr3TrjL/vPnXKQZUjcPx0ezMq2ybtGQ3N/7PIMy8u
         hREpb4n9EBeXeeH7pZF9kIE88FhagCxpQzaJWrY+bITz8g9JrMs7ipDRF+e3pvgXfT0d
         HrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254392; x=1771859192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIxEocxEapJW7yU9OtfyLhPCnRBq6fT8ce1CcmY6sug=;
        b=fhrmilMGyQaRqEfb6yybRMdBGkmIOLwCD2BrLpf3Kw97V2z1Ui03zDHb+onSYDQ0yI
         nWlx1ddYAKQuN+hjNre601sDK4S5C2yP01JDd0WXyNYTcfLMoA/jSb1LyQ4Qt+4j0wpT
         ZAeGF2qCq0hW8BxeCiXQAiAU752E/UH9KAOQjltss9dNV6FXIIP+ORiJtOpT1YXj2UHm
         YH0PCkUa+hp34wKhpQvowC6S3b3T6IixU8Dg5LYnypz4Hm19h21h0hWynrwAvw7oNueX
         0vOIY9D+bomF4UbBg5TPgrIQQk4Qb8k66v6afDxF1FyoGlMskfnYiSHwr6B+31Xc7aZf
         7Wow==
X-Forwarded-Encrypted: i=1; AJvYcCVAF+dw7mctFPfPT7OFqEfalQNuyPdVHDXzKAucXDgcob2JN6EGueIXctLsLzuk48rNtqz2mwJL@vger.kernel.org
X-Gm-Message-State: AOJu0YyMK2kRk4uLLdURbNWbCOrpQr1pcplalB2CP/fCgbNgyutJjB13
	0stAIEsyDri1QhM6p0LYZ4eusGAOYeR8FyTlVXpljS1HDle6c/Xnu1KIYfqO1kNkQMqZ5fLyQiN
	LuM+O0MgZ4flmWgkbD+kIyMNcYXoEPVGfFLncu/h96vZmciYvZPr+wKdCYDQ=
X-Gm-Gg: AZuq6aJeUY+FXPjI+rJApRtT8OWys2I17wv0C5Tp09VroH7d8C1ZKh9ZobQji3heahs
	PKoI8qIhmcy9gF+Tbg3xxWEHLxADsVEgiKUiCjslvixrAUCv855vCI5N7MSRDh2XWJISzpd0pLK
	BgZ/mmM4qHahvEGLHF5rr9NjIumh8FW9KU4BGi2tuu/HLysTHkaWY8cmFgG7JhNV5XJHN+w6hDw
	L3Fvvnrd0TPd0UV7XUWo8j3PHzzRIEhEsWzuy/G8gNh522skL5kh3nxQuah2LbL8UF/Eo1D2OZX
	5eMyLjVhh4leAZtxoaJJ8vbmkhkN50f/ASrRurH+AWRugRTY6iDGnUs9e7bfQIHaRanBTPVICLM
	TsrnT9pC7d9EUI8hLU2IbvGqDmS6AiKXkClzuKq/tqhMg6N23
X-Received: by 2002:a05:6000:420a:b0:437:6758:ce75 with SMTP id ffacd0b85a97d-43796ac216amr22698933f8f.23.1771254392019;
        Mon, 16 Feb 2026 07:06:32 -0800 (PST)
X-Received: by 2002:a05:6000:420a:b0:437:6758:ce75 with SMTP id ffacd0b85a97d-43796ac216amr22698863f8f.23.1771254391533;
        Mon, 16 Feb 2026 07:06:31 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:30 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fanotify: call fanotify_events_supported() before path_permission() and security_path_notify()
Date: Mon, 16 Feb 2026 16:06:25 +0100
Message-ID: <20260216150625.793013-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216150625.793013-1-omosnace@redhat.com>
References: <20260216150625.793013-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter trigger LSM (e.g. SELinux) checks, which will log a denial
when permission is denied, so it's better to do them after validity
checks to avoid logging a denial when the operation would fail anyway.

Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc filesystem")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9c9fca2976d2b..bfc4d09e6964a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1210,6 +1210,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 
 		*path = fd_file(f)->f_path;
 		path_get(path);
+		ret = 0;
 	} else {
 		unsigned int lookup_flags = 0;
 
@@ -1219,22 +1220,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 			lookup_flags |= LOOKUP_DIRECTORY;
 
 		ret = user_path_at(dfd, filename, lookup_flags, path);
-		if (ret)
-			goto out;
 	}
-
-	/* you can only watch an inode if you have read permissions on it */
-	ret = path_permission(path, MAY_READ);
-	if (ret) {
-		path_put(path);
-		goto out;
-	}
-
-	ret = security_path_notify(path, mask, obj_type);
-	if (ret)
-		path_put(path);
-
-out:
 	return ret;
 }
 
@@ -2058,6 +2044,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			goto path_put_and_out;
 	}
 
+	/* you can only watch an inode if you have read permissions on it */
+	ret = path_permission(&path, MAY_READ);
+	if (ret)
+		goto path_put_and_out;
+
+	ret = security_path_notify(&path, mask, obj_type);
+	if (ret)
+		goto path_put_and_out;
+
 	if (fid_mode) {
 		ret = fanotify_test_fsid(path.dentry, flags, &__fsid);
 		if (ret)
-- 
2.53.0

