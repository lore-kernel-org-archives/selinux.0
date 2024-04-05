Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168616FF41
	for <selinux@vger.kernel.org>; Fri,  5 Apr 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332244; cv=none; b=hLNBBbyR0++vNYuj9Iq7e9ZlHpu3Cty/zUXy4CvhVjwlWBR8PIbp0PAjTy/5KialVVREW9NFeZfVOrUDSfTBHRUuenoZe6XmZ+lpne/qSDQ8HAMxggR1ouf+3kBPUQhpKs/PHX5gBEPWd4GAC4MSq8tzDDxvREKMGcEvWb32XcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332244; c=relaxed/simple;
	bh=Gv/fJlJ3mfBhk6l8a5NGyTgsSle77m1evsLyVnaHjN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZzKJfc5wYmn3XAyeEWUgziZ+3YD5nnda8KxzHvsO9YSvZ+9rJsK930y02EyNAwpNpmTvsGUxuZIeDlJuV3jYTkSfHSBc+ctH6apwK2cAds1NBoNUqphCuSQswOKf44QmNt5jvRSlOVgUIFJn6MYKhpZ2EkjJ9uRJD79GRjoJg5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VLb7BdyE; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VLb7BdyE"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712332238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D4QrOavOqfb19KGkE05NRrQiGyIJet0DDswwdD6Ytzg=;
	b=VLb7BdyEnOY2FLHdJSD9fuIg9fB9ru/7xZIbSOpkg49pDMXB2KVKO+jjdsT8THVDTxDFoj
	eBToyqXv+6dAOUKEsNYUdjWfzF3IWfcgXg3Gy6gkOXIOG5AtefQ79m5NPCkgXL4okHsG+i
	LfE/469GzRBTbwi+uJ9p6o8om2zso7rn7yD/5L3SvSTXIKvps9b618pJQi6rDa3Lk/HLQL
	x55+HiTc42m4f8oFDenCI66QAgPytpX3mrSQI46sXuB/3+nmIF01AZHXQJ3yXP9Ra3+nez
	5guly612c7eh/zbiFtMcmFOpaa+RLAWDLKXW5d09gv4pPoK3Va19PuYAuWYhsw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] selinux: pre-allocate the status page
Date: Fri,  5 Apr 2024 17:50:33 +0200
Message-ID: <20240405155033.249321-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Since the status page is currently only allocated on first use, the
sequence number of the initial policyload (i.e. 1) is not stored,
leading to the observable sequence of 0, 2, 3, 4, ...

Try to pre-allocate the status page during the initialization of the
selinuxfs, so selinux_status_update_policyload() will set the sequence
number.

This brings the status page to return the actual sequence number for the
initial policy load, which is also observable via the netlink socket.
I could not find any occurrence where userspace depends on the actual
value returned by selinux_status_policyload(3), thus the breakage should
be unnoticed.

Reported-by: Milos Malik
Closes: https://lore.kernel.org/selinux/87o7fmua12.fsf@redhat.com/
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: ignore allocation failure
---
 security/selinux/selinuxfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 7e9aa5d151b4..e172f182b65c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2163,6 +2163,12 @@ static int __init init_sel_fs(void)
 		return err;
 	}
 
+	/*
+	 * Try to pre-allocate the status page, so the sequence number of the
+	 * initial policy load can be stored.
+	 */
+	(void) selinux_kernel_status_page();
+
 	return err;
 }
 
-- 
2.43.0

