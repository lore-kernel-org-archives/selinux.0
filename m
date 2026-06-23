Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3583C37CD27
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222158; cv=none; b=YGQo/th5rIg0SafeVwPxzenRX4h6aVZ4LJQUfTZqq339mMDRik7vCg3IKtxiTRinz4faH62DppyiQ1vEFMmLcaBYmm9hqd66YweWoHHOKCWORAMDPVvqNchXADwm/4zmtjM+ZhkCd6TD/phMi/9PY37MY3l68YCY2Crr/eBHEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222158; c=relaxed/simple;
	bh=H6lX+3h5G+2XUeM2s3dZPlRNl67yWgsziL62SzywYbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITX17l6b/S5syJ7HTn+RYtTlmne2QynAYf+/hwBNlh1oNUeGTHWBokdEnDT6j56Mxs3RGqy0tThZLY+Mek0idCOvTvhGXfe+GBQKgsvxp+Mh/fMdbxbF4EF/1GcQSVKhHbZUHzgM8GWFEIe5j78oKZBL14FVosVasHRm+ZZ7x/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=iFfNCqgt; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="iFfNCqgt"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222153;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbnSRboZoqd+mQl5RsfPV3xD9n3WuTfi8SE56whFmYA=;
	b=iFfNCqgtWGdaLLOO26oV9pxREe+Mmm21SwZ7t5q+YaAMsN6srVhNK3xELb/Jhb9EgF5r1C
	d2vE9JC2avDqt5RgAzknr6wE32KEhv7hA9BvQMuynGqk4iXLLzX8RH/mHWBdp/qcxDtjOL
	ve0N4g+F31/FIYc7DE2bhdeQRhODMbcd6zfn6HixwyjE9+mbi4vCCRJwtM+WpEpDVPL0yD
	xNBDDxjp0tlp46MocwFCOZTuf7sM9uGmC43Ax3wCqhG4OdiRUkZq4q/5m3IrbtSMdkUcJ2
	Qc48VM+RiaIsA08JPFmWrSvGKHih9ybkgRP/H9E3uu9vIRE/UrdaNUvqnbwmNQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 18/24] libselinux/audit2why: reject non-string entries in the permission list
Date: Tue, 23 Jun 2026 15:42:07 +0200
Message-ID: <20260623134215.98273-17-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

analyze() passed the result of _PyUnicode_AsString() straight to
sepol_string_to_av_perm() without checking it.  A non-string element in the
permission list makes _PyUnicode_AsString() return NULL with a TypeError set,
which would then be dereferenced in libsepol.  Bail out and let the exception
propagate.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 268e9097..3c3aa105 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -376,6 +376,9 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 
 		/* make it a string */
 		permstr = _PyUnicode_AsString(strObj);
+		if (!permstr)
+			/* not a string; exception already set */
+			return NULL;
 
 		rc = sepol_string_to_av_perm(tclass, permstr, &perm);
 		if (rc < 0)
-- 
2.53.0

