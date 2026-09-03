Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A464BD113
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446600; cv=none; b=noS9mFRUEY6KUF/pc3sxZArVbnSIwlOWZOQRoleCyBImNJreCSJfXmC1DsV2y1Z73o6nAcDZrWJvQlBmu7XewCHIyWVYmP3odzzerS0+W3hOCkrjDIxxxUiq37I/zka6GLaI98Esvij2viInXGpilcgocl9sS+frGSHIaQUen9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446600; c=relaxed/simple;
	bh=Za3Pm1c9xvF9/g+4ZjqMiUwDNNG2c+WrxK33XeENKLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RciedadFG6vUEIRVO8u/ppWoxNdabSZmIM9sivNFLOyiy3S7NDYKFbkVX1WcdlgxyUx3Rinho7QXn6cumxIVEwetzkn0f0CfDiQND24gFBiNmxP8HtFtlUGrO1Rjoa42RcslTEO+kFsJpDJVgxII7xVXIUXxEjopRkl3+4wu0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCU9WlCr; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCU9WlCr"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0006ea8eso31183161cf.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446591; x=1789051391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOBHURzAroS3rEr3maxAI2CZOiOoxkWCaR/nAi9sdAE=;
        b=VCU9WlCruwVZp6zuVei5ya7whSYt7+PdBO9kxnGj60ZDFJZPS8oJZJpeWgrVGSA9B1
         WU3mBoCbodE6uvQz9U1FPLeH9pI5Eum/dBFlSsOeEPzH50GJcwGEHjRJLzIPenGX4O1S
         IVDXmAyTraja9X4YEbSgpiMNq5tZGT4xwDJUZGQowLuI9QGcOWV5VTKZbJIOutyBMnOv
         zhjd3FeKeko1qrtOsh2p3Jr/oor/b9lcAZcPDpYx79vhDlICUb04MvpkmmYmBL+SNdal
         WNKYRVubmPQiApiHptoZeb4rNfbC7VD7DM5neL6Vh44UgjuxTlCM0f84xIRl570fxDPK
         bRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446591; x=1789051391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOBHURzAroS3rEr3maxAI2CZOiOoxkWCaR/nAi9sdAE=;
        b=Tq9dDVRykcn7xsg0GyYBQNPYIEtY4telAtifvb3ZfRmUE+w8eua3zpLm1HVO+wwNBd
         pv3utlyB1sNjJB4fN//ojc/8yO+sQ4om4L9WL1icyrRl1AJ/JsiV7fqHqkQCZo39i/eX
         K+eVQ2tTNWl7n10ba7wPnmarRFJgZHMsslTr6Iye7LxjcmnvEULAQqIXqcvfT/wm+Dxb
         Uy8FSx5lzYv8wxHUr1hXKxD16CNneXyIirTwicUqaJhLtq8tFM91kJcPaYhZQRb9fYqt
         5L5iPpKRSwCVoz3vmu+OCD/+e2EXG4HJIKof68QVyL0+rwzWirmt/E/4ou/BPDcOpLjs
         HvxA==
X-Gm-Message-State: AFuF++lyEZybfmh5aIXn0jqI8gHlM+KkG2vNhA/XG1ezGvOe1YpiCrgB
	DUjDytArfnrZu7W0QJfu0XYQsPadXTGfWKzmcVr1/rMmFG5cup9E1N0pML+Dxg==
X-Gm-Gg: AYBFou37TFhUOg8aAEw/8kycfDyWQzMU5QxGOvvLk6trtjpwm62BsKJJ80xRTXdQoAJ
	4MMk42uPNem2RkbiD+2UfswCY8rWN6tfkDfVv1Hml5G+odhaieJ/BhqvSSW/iaNFeEa9ZtTvm6d
	cyJQO4d820bmxdJZ+vc9LM/wJCigDjSiOpq1n43izk7DqeHqq3lsfyLXLO0v9vqXDj39N2ZPfwQ
	EZb41Eq83g0d9XDeatH0najH1MlHTfqwiwkGG3wUdmIIWyZ2X0W9/MTCLBAcIWrTGr8hHxgB1Mt
	Oe2WQV6PJL+3AjbKLGBgdRrC/DSXWdMsYL4UmSnEO/bNAGd2iz1xcEoyBg6Qd5Otp/Ddxy2aPIU
	unRwd/AAIJ0hS7c8SwfU93639b5HGCW+u/thiiYuBlvujisruUdKekNzCteTC3HefAJ7TOLlwuh
	1tlA3X4MG40o7fErHJvvmAxc1sq64jLv7uwN1kdcOrpoi83Nyupt2UEaiTvThEQhbXUDIl2/N/F
	JS/+5ieRjQFBp2fX0pw+Z3jaznb6drvCflAhjJZ3VgliaWFHBzbV9u2iUtdbZlI
X-Received: by 2002:a05:622a:4c8f:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-53036b946a7mr173282121cf.3.1788446589535;
        Thu, 03 Sep 2026 07:43:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:43:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 5/9] libsemanage: create the writable store skeleton on first transaction
Date: Thu,  3 Sep 2026 10:34:30 -0400
Message-ID: <20260903143433.19810-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
References: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semodule calls semanage_set_create_store(1) so the writable store is
populated at connect time, but semanage does not, so a fresh system
with only a ro-store-root the first 'semanage <object> -a' fails at
the transaction-lock or the sandbox copy.

Any transaction needs the writable skeleton so create it at the top of
semanage_direct_begintrans() rather than depending on the caller.
semanage_create_store() is idempotent so semodule is unaffected.

After this the sandbox copies an empty active/ (just modules/) the
missing computed-file check in semanage_direct_commit() forces a full
rebuild, list_all()/get_cil_paths() draw the module set from the
read-only roots, and commit_sandbox() renames the freshly-created
active/ to previous/ before installing the new one.

Read-only callers that never begin a transaction still need the
read lock; that is handled separately.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index a930dac1..5646d451 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -405,6 +405,19 @@ static int semanage_direct_disconnect(semanage_handle_t *sh)
 
 static int semanage_direct_begintrans(semanage_handle_t *sh)
 {
+	/*
+	 * A caller that never calls semanage_set_create_store()
+	 * may be running against a fresh writable store that has
+	 * no active/ tree yet. Any transaction needs a writable
+	 * skeleton - <root>/<type>/, active/, active/modules/ and
+	 * the read lock - so create it here rather than failing at
+	 * the trans-lock open or the sandbox copy.
+	 * semanage_create_store() is idempotent.
+	 */
+	if (semanage_create_store(sh, 1) < 0) {
+		return -1;
+	}
+
 	if (semanage_get_trans_lock(sh) < 0) {
 		return -1;
 	}
-- 
2.55.0

