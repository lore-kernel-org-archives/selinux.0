Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49012F25
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408297; cv=none; b=hRFabshN3dbgwRVWCpzlezfpgXRpVkH4D+aW4xRHFYU6d45glRJ/g7nJBdL4tTLgDZqvA6DmUCyNZjh7/dYeUcsHAdJ8NGnpoSH3FE/N0mX11mR86Z3NuiTAHqGQUDQPyL1tmuoZJlQhwFrdVE3MQEeqP92C25x9cz1Y7WjbUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408297; c=relaxed/simple;
	bh=4jx6IFb7Jnk2qHAI6WtCObOAbC/yp65QCwvQxJ7DCKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APS6901Xkh72A5ZwQ3t3gbVhSUcDAf394pp9kYuIzJajkHD+LeP29VfggaUnc/jNkcl5LxNptD5KEiAgiRvYlNr8OXj9Wu/lN0EnFyBiEAX+duydDwL9Y4ROg8VXrEmLUPwivOazphL2NDHkJk/hqr+dMET0pgW+RDgWYImyW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=bpDoYlbI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="bpDoYlbI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714408285;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QNSLkeZhj4T5NYT9kGk/QXIuzrRgomeqYZapPph7v+g=;
	b=bpDoYlbIt3DjTHuuiZapRxJ5Dg4KabMGBtKguuwei/bNmTxhzmN/0mX0Tol0cD2w6YcMuE
	km1zhiY7LMrGgPwkvGhEX0K0sLhICK2AB1yKDNpV+gBmCzFgrEpSvrPFlZzOvncJPDVtGk
	fvT5qqbYJYo4CICO9VJ6UYwHuFwd0k37d/Jue1TaWF5iCTj+IjLTqEyaABuOUTi2sPuq5S
	7oPvKy4pL6F2bnT6+Vzg/xo0u6xKArxicRsCNlmuyVHMjcbRwXGuGihJEzwDCQv/dJF1U5
	FS/jzscxyfZsBdQ6668cTm4brsInIqUeaF9Wq/Exl2ZWLWl4eFtZWFVbCxPcRw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/5] libselinux/man: correct file extension of man pages
Date: Mon, 29 Apr 2024 18:31:17 +0200
Message-ID: <20240429163122.63181-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Set the correct file extension .3 (instead of .c) for the
security_validatetrans(3) and security_validatetrans_raw(3) man pages.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .../man3/{security_validatetrans.c => security_validatetrans.3}   | 0
 ...{security_validatetrans_raw.c => security_validatetrans_raw.3} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename libselinux/man/man3/{security_validatetrans.c => security_validatetrans.3} (100%)
 rename libselinux/man/man3/{security_validatetrans_raw.c => security_validatetrans_raw.3} (100%)

diff --git a/libselinux/man/man3/security_validatetrans.c b/libselinux/man/man3/security_validatetrans.3
similarity index 100%
rename from libselinux/man/man3/security_validatetrans.c
rename to libselinux/man/man3/security_validatetrans.3
diff --git a/libselinux/man/man3/security_validatetrans_raw.c b/libselinux/man/man3/security_validatetrans_raw.3
similarity index 100%
rename from libselinux/man/man3/security_validatetrans_raw.c
rename to libselinux/man/man3/security_validatetrans_raw.3
-- 
2.43.0

