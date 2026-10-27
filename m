Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110469;
	b=HFaSgNfDNeFA7liuyIuyxaPAzffCVSiAvtAZbpQi+wzB0zJqZDrMhw+juOy+SgzhtqqE
	 IJWlxltn5boloNhx7wsJf6lYo/m/AJHSDS8eUsDfyibgZD4BmeabZcdXu+2eyba6es5RA
	 Pr8WHiPuMiDvXnJYDIHwSO1A1+qJVztkXiJcs4F6tvVs+Q2waiuiG2n0DSvJW5TswnmWy
	 rR8RfefunrDeQhueBVJISf3lkM+tY4SMb21QkE12Rv4K6m+bXDe/JS4+xGLjVAclS8IIY
	 HEv1Eaxy5BUshtPyyIFJ/Esvjae1SbLxE9Cf5yo37J/Hdoa/AOCQvez54bLvFC87Tqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=o9eYwoqwqQJO7xVJ5DPfPLTw/QOp6/ugGij7crj0Cqk=;
	b=VvW3bitWpptvKBz3LYWI9o0uOI6/OKj7RWH644koGmmC7ldtKVI3Be1ElAJ/SZdSDMjh
	 oQivdk7As3g1JeDcdZYghGf7SOYq35jYRNlUo9JitGPTCWHwiZgCvfi1lUTT44pmAuX10
	 arJDLfAo0rfyyQuQYQX3W97vvbgiuXy2f8Sr8h9OkUbTklhUUAxbPmN/c/776LK97n3Wg
	 d6jrgZE5LSHpVDXdVzO9brjfNRxKCw6H7FBHwIGNriHvjQ4DWMFq6ZMVfsJpYq65j9pCu
	 qJJkoRMbV648hw7louJEVVlS/+YOlMhrory8g/NtUJ8tasf9PDHEcRr9x8G72UwCJ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OTGL1S5s;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080A606A320
	for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 14:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4080A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OTGL1S5s
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-917a6dccc60so11410566d6.0
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793110468; x=1793715268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o9eYwoqwqQJO7xVJ5DPfPLTw/QOp6/ugGij7crj0Cqk=;
        b=OTGL1S5sUAtJbeky5R11wa4Qr+hZGskDVlwxrhAqXPWpNz7XpG3lEw3G4Wrr5n9cdI
         OpX45mbMpxpTPUP3ApJ0KyyqvxT7z5bDAiQvBC5O4uB80BXsSze4sGOdT7kRYDonfebg
         dgqEblxyiShdTqqBQ3W2afJjhXvrewsLR8cXiNzl8fZuYoOYiEg5MMURAiSh4kTxNNd0
         HOtlXB0qnUs6CYEemznMiOJpHg/CYTZPtFQ1F8kf5LANXlRoGePtIJx+ygCvfa2fr7t0
         x7WzzsE4AM1Pnn598fHCWHZgACtAsGMgTu8NWIMVTPHbK62gxMWPPkPK61WOnyqMA5QX
         V3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110468; x=1793715268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9eYwoqwqQJO7xVJ5DPfPLTw/QOp6/ugGij7crj0Cqk=;
        b=q49AU3xn8gUok254uBpcXYSDgVIgJ/DOuFkEsYDNSJi4bosWqBKNKGSXd9vYJ70GDe
         cRXKQ7QH8Tyt+mHU5PDNOVVbmD+8gdm599bShgR0Kfmv9a3Z+ury0HfCk7wtdbDggFad
         2GNKJQNJVBqGed5KNOfvB4XIUpBChl+K9Ex4tQfXNAO1xYPy4Gbdr96yVuM4OhrmxF96
         z00oLKeagAas5pk9Ya0adfWnnRoZ5GE8q2IIdUrxqQePYWB/+T79Vs6jfD1dd7LvcVuz
         zR0TpQenowpwNo9X0HBVYtTQ1yOf0UeDaa6yKmThuo7PYYgqedj6cy1UIBzq7fi/RNYD
         5G/w==
X-Gm-Message-State: AFq9FYJ84t0ddGuxcYYHVUN1paX0s9xg/ShnlMGvCayW6y3gdnaps1Bk
	jIHER048RYPZCPw1hoA5xB050h8oxH0AtH5ILqQm3fUDpSr+WgRBWf1PKJxSrVnP
X-Gm-Gg: AYBFou1WKRVgT1gB50IFZYgCbm6AX7uUhbZMYrz0od7EwicFfpD7MG1Y0dEOxDAKqgZ
	23VO9iyPgDlYXQ8YxuOfiRn/SHkBL60ywOYsIuFKSHYxU43QeW88wQGodJEbboaQWlFvj4/TIqW
	R5mehDXKTw60JhpLWu0MO4iKm3sTSH5zKm0D3MjRxTQPs9rroFc003F+E+qUSxWDAVGWomrUqWk
	gg71ehSJKEFSCHf7eRAQdwB2NeITzYRnuwU5zNTE5FktW6S+yH+hYL4bk7rqozBiXIMU+KzUbsa
	4GaEh2D4/oQw7R0iHFtcXQgsR3ze5naTtJCZTkUiu2Y9ZVjKhYVWwfEDt6LGe1xJyMsZYqdZtx3
	Yls24BlqYEkG5SkZfBUwqyZpx5emKk/eZG9G4W4i8Yv44fyi5C2FknEvH3O9MYYt9Z46g8e/mdx
	E+1fTjlcTp/IqaJOgntrhHxLV2pIR3ztepQ0BMrzDK14WNA6tJq+QltoDqEZHSruAfE5FAK6GmM
	RUcpS1k8srFMvymat2a//hvQVhXITSbJfrk2qSl42GnvLTCNhYFD1mkVHSjI9dfWHSaZcwOsRtC
	DswdLje/cIOWse2Md4uAGqFc8/Z2qwdu5fl+/v6846BNXhx/Qs0gdKKI32LeUyf0e6bRgq/E9np
	B0NA1VbRW7JAy8sJGnQWSQKSGFDgLCxafwVv0IIujGFSpixGSck1p1oDFMqTEhjHgo2Oo/3v7PQ
	9Xx4WV8vd1hJH4744=
X-Received: by 2002:a05:6214:21e2:b0:91c:61c3:c044 with SMTP id 6a1803df08f44-91c6d366293mr48862666d6.7.1793110467885;
        Tue, 27 Oct 2026 07:14:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c4789e21csm102349376d6.0.2026.10.27.07.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:14:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] CONTRIBUTING.md: sync with Contributing wiki page
Date: Tue, 27 Oct 2026 10:14:13 -0400
Message-ID: <20261027141413.89975-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync the content with the Contributing wiki page, which also
included information about submitting patches via git send-email.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 CONTRIBUTING.md | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 7ec8cb0f..17bd7d98 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -3,6 +3,9 @@
 Contributing to the SELinux userspace project is a similar process to
 other open source projects. Bug reports, new features to the existing
 code, additional tools, or updated documentation are all welcome.
+Before undertaking a new task, it is a good idea to first post to the
+selinux@vger.kernel.org mailing list to see if anyone else is already
+working on it.
 
 You can find a list of open issues to the SELinux userspace code at
 https://github.com/SELinuxProject/selinux/issues
@@ -59,6 +62,20 @@ When preparing patches, please follow these guidelines:
 When adding new, large features or tools it is best to discuss the
 design on the mailing list prior to submitting the patch.
 
+See [git-send-email](https://git-scm.com/docs/git-send-email) and
+[submitting-patches](https://docs.kernel.org/process/submitting-patches.html)
+for how to configure git-send-email for sending patches inline within
+email messages as required by the SELinux maintainers.
+
+You will send the patch via git send-email to the
+[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org) mailing
+list. The command below is for sending the topmost patch from your
+repository; if you need to send more than one patch or you are sending
+a patch from a file instead, you will need to adjust the command line
+accordingly.
+
+    git send-email --subject-prefix="PATCH userspace" -1 --to=selinux@vger.kernel.org
+
 ## Development Repository
 
 To get a copy of the SELinux userland repository you can
-- 
2.56.0

