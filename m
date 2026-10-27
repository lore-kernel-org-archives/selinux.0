Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117968;
	b=BKLjredG8Kju9yY5AxYwgoDiMA5dzOKYep2jKYU2r8eW5o/Vh95jvTm+IrOarc29Gybh
	 ieWdJZGbcRIYBW+0V56BgcDZlFXGUWGQ+dG9es8UqoiB9kVTt+53h9NeLHet1dvR76XXo
	 lkydZ/qDB4TRsr1FQFbLotjn5MzpaXHFzr+RKghRoziXTvsQhVOSk5myxelrl7MXqgSQF
	 yJV4ZHXg6I7QOisJxtNGnrCOFr0AVA0bepfM0wr4tIzy2jWJMKrWgM/Kph3/o0gPdkcJh
	 FFcVIQeRojR5XPdKW/MgEXQbnU1Dc4iDjUvmPWbtQ3UArHSHT6C8ASa/kk/KaTPbOrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uX7zTXPMoTTrzSUQND3rna9LoLIRNzd5BVojybuq3FU=;
	b=Uev7dkLwRXyC9YRlzTSPEID7i2o87UpiOYPLQGcVasmQFv9cqqr2zOSWbDd4eVYEZNTE
	 6w4cLLbaWUUQLAAqgLghQa58KxVRXwYfZq38f92yAnom8mvv5AxTxGxkpMU0bXEEgpL40
	 JApKJ11bav6ZiRlHaVmkXIcRm5/3fR/RnZ/AlUzPkGsfynakiJ+5tAHko9+EP6PwfCa96
	 SrcJqFoywnZ4ceghSQ0gIL3K6C/3PRBKcJegTy95a8Oxk8I/E8qofBu4qs3s+JNtTPdaX
	 xqSsvKVBSKo76lcdalHimHyH4Y+ac12xYMltufy+3laVAFiz79uleFqXdY2OiL7T72w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PqSZVnEh;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762160A2602
	for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 16:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4762160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PqSZVnEh
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-536717a4d83so1094201cf.2
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117962; x=1793722762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uX7zTXPMoTTrzSUQND3rna9LoLIRNzd5BVojybuq3FU=;
        b=PqSZVnEhVkbbESN9SkM9dbp4X/EYhe5YvRqggHs9YVe8AyaV742QBYidARZUV46sw9
         ZmMsfNUpNZcSWj3wr7GaU9oFsCFNO0evyjZRsJoC4HWbqIkF7NSOK0jrNWxtRdKWSgSp
         crB94rlyt8upI+yNJDmrseWwVOmBgYTW/JPphwA4MwzuuxpDxt1uyyt/0tvFyUOGE3Sy
         soRW4oXwINoPXVCnt/TtPxp99+KVVfmXPFFGdKv1EhKQEshA2cBXzPBpkRz10L8YFXLc
         YoVE+XUvZYO+mk2SvEIQJgzXaI9uSH05+qsebbVCVA4WisceQXfd1n7mibOHa82mRIc7
         pEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117962; x=1793722762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uX7zTXPMoTTrzSUQND3rna9LoLIRNzd5BVojybuq3FU=;
        b=siUyYU832RCL1oq7PCUJV1C89X3AXXYvxi8FNzapjeOHGR0+bpMU4qoP3mtd5FdoPG
         IG6j32HFiV0DgszW/Iqsr71KXQNUTd0VKVBFzgp/KldyKV6+TgMyUZVnlOk68YGypJ+U
         DZDFmMkgaLn/iFukA8x/DoCxV71oTzoXjjYrWzIjptl7XTyDCrwTZIzxbiynxtcwmSLI
         /cmROYFqB/npjxyczP40cRnk4jLqfCo/95+XmH1m7dO0WBjtLXx1EQmAucCeNPKAGbkH
         QhugZmpQ8X1Bu+mH5gB8aqJeJH/xd5XcI7mJx8UT8bEmzqhX+GJngOoxFo3GhufgQ7/z
         AUzg==
X-Gm-Message-State: AFq9FYJx506bKFU+TLc3+Fv+2FVcy/Twi3hiyEQxIctvw8OtQA5l1bgn
	PztSzc9NXPjg7h6uT12tbeS/qsiF7zV8f4e+50GdwLaH4kESD/WkT5dCvDUOqfzS
X-Gm-Gg: AYBFou1jaf+Ra3YK5h6hIk9+ZVXJptYyIC3aD5NAnf8bSpyB/BWATZ09677Ug8hE0J9
	lFuM/qoia/BBfF/sW3CE0XbbMeQ8socjms178XXyQvXp9RmBVpjogaOObIVniJzlc1qR6fh4Bdx
	K4h4gJteUGuyqLJaG+3qeF3MmuiHmgSVIlGjhEHamhnUAsmlblriyg3YPz+x4FY9ensDTn4twg+
	hJcA9tFAmToMhnLC3h0/Arz3Bi1kqr4Rih2dtGLjUI5H33VIE8Tg7fDbYCdUIR2EuGUWH17DtDU
	2HwgKGZ+iyzXl5OvF1b8xWwc5P3HRBtOQl54BS+Emo8yZMl4hO5Y5aMElKxR7rFD/+Otz3p4QBA
	38Q+z6jEAUTcOwGHAQ/MHu1ECc0C1nLqkkdwyCGGmuIdT0e9jffl5bnItCI5onlFNK/GmvmdAMs
	wrfar8I890RxRyAtskFSoYl3dl+pH1mdi+YTpVXjnAwV6jR94K/BlJ1ZYCricaNDni7A43zBSai
	UwDGJ/yZ5E4Ly1fmi7uZ5JsC6hK8a+WQDeLPjHtTghigKDBtTV9ECzDD/OyJVs0fXQcrEyzFLsu
	+Yaa4pt5zpCoE1Im73Uv++lXfrXqbbfSzMBMlvibnQmhXzBeBpU3Jg3iLJE20kUhNYiIj2IEsVB
	kfnQx9sVzq3JHV9hX+d//tMv5MHgO5nvX/vknvjo3sg==
X-Received: by 2002:a05:620a:72c5:20b0:940:f53d:5eb with SMTP id af79cd13be357-940f53d147cmr1032844585a.35.1793117962178;
        Tue, 27 Oct 2026 09:19:22 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f06670d4sm1016862185a.14.2026.10.27.09.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:19:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Vaibhav Bhope <vbhope@redhat.com>
Subject: [PATCH] policycoreutils: fixfiles: honor last exclude line without newline
Date: Tue, 27 Oct 2026 12:18:34 -0400
Message-ID: <20261027161833.90630-2-stephen.smalley.work@gmail.com>
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

From: Vaibhav Bhope <vbhope@redhat.com>

exclude_dirs_from_relabelling() uses `while read`, which exits with
status 1 at EOF when the final line lacks a trailing newline, so that
entry is silently dropped from -e exclusions. Process the leftover
buffer with `|| [ -n "$i" ]` so the last path is still applied.

Signed-off-by: Vaibhav Bhope <vbhope@redhat.com>
---
 policycoreutils/scripts/fixfiles | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index e266da77..d6ce37aa 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -81,7 +81,7 @@ exclude_dirs_from_relabelling() {
     local f
     exclude_from_relabelling=
     f=$(selinux_resolve fixfiles_exclude_dirs) || return 0
-    while read i
+    while read -r i || [ -n "$i" ]
     do
 	# skip blank line and comment
 	# skip not absolute path
-- 
2.56.0

