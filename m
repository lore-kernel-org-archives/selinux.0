Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AC433AD
	for <selinux@vger.kernel.org>; Thu, 13 Feb 2025 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413334; cv=none; b=svBuo0iRSgkvUHnxuPEUh4G1BSc3Mt5p7G0M9hwlL9S8LSeX7vTd0OOtcdx583+XBvjH2C+Y01PM6RSQyu7BHVHslSRCVpslxPMbXGDho8D2tjbdEdYOWXdhBOmLeSOsyuThO6vZqMp9i6lPxfteFruB7rlSOgVrOdB7Hyx5/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413334; c=relaxed/simple;
	bh=HZcCfhRZP/c+JfvcJZJWCvY7xbnSndu8Wkdvl+bNfms=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KKdLyo14EJLPI2Njaa4GuRxm6eWP/T+O3L/KOvdhYJOp+joUXFP91KfLs3QquQ1UUl+NOSAAdZx9yqWt6rhnVBj1jDn63RGExrrdc/Vbcl0jqs06iquYpSqF2wN+cvHj5HbXol0YxYhbc5CTKEhBoLAMdhpPau6xbHagOm5uYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DihZlfBX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DihZlfBX"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa480350a5so899733a91.3
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2025 18:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739413332; x=1740018132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZkPcjYR5ck3R+l7JgL16r7l/ax+sLRaubPhWfQ2fmw=;
        b=DihZlfBX5bvfSbOjFBMUGUADOITLNkMnNzKw5YTNmU2/l1wr/gSLt51bPLsn236vzn
         fuE5Dhm/T6xYw7L6FLDZIPBPyM6xsZJSlcs+9Qw62oFhjEmqt83RkYOV0lW5eT7Q664K
         AUd11iwfUbZ2gUC/H1ViVt9XQPySxiR2UJC3TlfJD5lq2G3s2PUOfQwyCftwJmcfn1A6
         zJIdemE9k8C/UomwZP7OcIGQXWxjIps4hF8N7fRC94ZVkLRyBWlyU78ubSlL7LdxJnmQ
         +clQ+F1KRc6/SIfMqaRcxKydm7DuG8c6UpOU7kCc9piAYml+mLs3YxEuwYnpTGYV7Ir1
         SS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739413332; x=1740018132;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZkPcjYR5ck3R+l7JgL16r7l/ax+sLRaubPhWfQ2fmw=;
        b=smZ2BICHyBmkRFRPs2A2QouRbV6PzsIPnJ6ivWTlCHqv7xcydPi+4ubs1Eu2YquNNV
         m3ttgxClA60Ufhks6e9o4z0IugveZCVaBbYFlrW8w0ZjKd0zAE/ysexasFDgYGrN3Fga
         KIb4mziUHPd2amA+IX9jQNorAHbDWc+JQis6ODCp+Jee0qsAtbNhlMR3XJRMcBbH+E8Y
         z0EuAAkXQSbZcXzWB+aRGkOJHkj/f+LAi0M3l9m5dM73BRLCi+O2lnww/RwZpeZPiGCx
         kN5MSFeuC8e+WDWp3b5AvN+T+qKCfO/cLXeJdGsed2vmkp1S6YlmR2SXug4Jt1AezY59
         jGnA==
X-Gm-Message-State: AOJu0Yzt9QKC5gDvtmhmG807Iew8B5Yzztm1/sVUUiX7z/AUoQ8i2Dg6
	Yyg4mrhucmrfao3gKLLuTBEqaUkOZ1iEBFFSQwdXQnxM813jvvYwOkf1RsXnieYQcNE0tobF2vP
	Sbu1Y5pWF/hQ0NQHX3Td6QhIQnbyRiLPxp/abWzxG5ehCNDPesa5IMl7JocMaoOYenB8jZwsUoX
	Upq6xn4g4B+UbudITvNV9UORsI+Vwz
X-Google-Smtp-Source: AGHT+IHg7+GPBvGxcUWuSQunEtwEg0ggMYbq0syB6+jFwWl21ZWqtAt2HtIRa/wPKLoBzfl5srwsm6cE9A==
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:2fc:11a0:c53f])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51cd:b0:2ee:e18b:c1fa
 with SMTP id 98e67ed59e1d1-2fbf5c57f6amr8287178a91.28.1739413332537; Wed, 12
 Feb 2025 18:22:12 -0800 (PST)
Date: Thu, 13 Feb 2025 13:22:05 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250213022205.972878-1-tweek@google.com>
Subject: [PATCH] libselinux: warn on identical duplicate properties
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Instead of raising an error in case of matching duplicates, only report
the issue as a warning. This matches the downstream (AOSP) behaviour for
Android.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libselinux/src/label_backends_android.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label=
_backends_android.c
index cbe932ae..cf4f5cbf 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -58,10 +58,10 @@ static int nodups_specs(struct saved_data *data, const =
char *path)
 		for (jj =3D ii + 1; jj < data->nspec; jj++) {
 			if (!strcmp(spec_arr[jj].property_key,
 					    curr_spec->property_key)) {
-				rc =3D -1;
-				errno =3D EINVAL;
 				if (strcmp(spec_arr[jj].lr.ctx_raw,
 						    curr_spec->lr.ctx_raw)) {
+					rc =3D -1;
+					errno =3D EINVAL;
 					selinux_log
 						(SELINUX_ERROR,
 						 "%s: Multiple different specifications for %s  (%s and %s).\n",
@@ -70,7 +70,7 @@ static int nodups_specs(struct saved_data *data, const ch=
ar *path)
 						 curr_spec->lr.ctx_raw);
 				} else {
 					selinux_log
-						(SELINUX_ERROR,
+						(SELINUX_WARNING,
 						 "%s: Multiple same specifications for %s.\n",
 						 path, curr_spec->property_key);
 				}
--=20
2.48.1.502.g6dc24dfdaf-goog

