Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B31E201D
	for <selinux@vger.kernel.org>; Mon, 21 Oct 2024 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552336; cv=none; b=XdL7ZFBE7FsCC6jJ3UNfLH4jVn7BW5FRcgdJbduIiLBJ0bYxl67Ja3ZOtbPG3eVT0Kd+GpQNaiEtZefzzDgtJwgG+k9yVVRvVvvRqgrVpIbWja7vRPdspILHsfAge3fzHmatTe3Fg1NzN3bkEhy5gwhQH5IVTYo8gRKErnhr17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552336; c=relaxed/simple;
	bh=xHVMoO4waU/DXtGrLBetMPKBcuPkwiSg96773y8cKSg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lTRbGkjk2qRKnENS0ET0CRVpfiyBukyJGbGvz4yTAba8OS78ij1xsUNelxVLZoA0TgpYkzaOcBA/VogM5XfOk4uDG2g/genfGGvnlvNZzmTD9wsT3sV3TF8hzMR/xD6ATIrTlCmUKS2KcUU1LTabjtm0HHBCe9eJFKGtzySnJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x9X0v1i3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x9X0v1i3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35a643200so103421797b3.0
        for <selinux@vger.kernel.org>; Mon, 21 Oct 2024 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729552330; x=1730157130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=umUR3vHeRaPpH2DSarytnsjxJRG2JZV+lU20lccer1s=;
        b=x9X0v1i3JFv/aNWnXBUXDryVKTYkZUstJH0rJ4ybbo24s0Vjem0G4L7i/OHAYmPZkF
         R/y4i/U634HwCWgeJ3rEHrbMDyHgXnC/ecDmGWSfqjeEWS/AS+jfAKIPKb/n/OK3MbzU
         Kaqt94RC7FTHQp5wqqiXJwR39503XltW60tQxN+xLBFqJaoZ+blawr01QtK5j9HE4TpL
         16QIWC6UitCBI96Aa1oorsCgkuXWLcMAIsC38OJrj+5LO+di/us+nDifhQM0OXYn69OU
         KIkAfFhB9Nx/7Eazw+gcDq+JNibPw/WQBTi3zMlssetQayVl1y262PNydDjLI/k74S47
         mVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729552330; x=1730157130;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umUR3vHeRaPpH2DSarytnsjxJRG2JZV+lU20lccer1s=;
        b=F/kApcPW6wCt6suPCa5PbU8lz4Fh+Scnzx0oxK0ylp4ME6Lo21BOnVT9fo4iyn4OWN
         tp1QOCFme5hQyN19EU4byBfy/Oe+oPDFVUb5frQ0Af4ZCadQ6HuJamFIZFulbqL4G7Tq
         Q2EIrdCDhfx6X86pUty7iTRdoF+0Hz7SrZmrQZfa73LJ6cVlveLoye7ZFHDoirnC/EcZ
         EaL3VFrU4DvV+Rh4tLJGyijyjMMM9C7Tbl3PgzMV468nnp1h65SAlk4KwRe6mrqODDk4
         ppRDFiio1TbDJchAXA3c1Rrg0fyvJQNT49yK1MY0rHs40cC+HTcO1wlDFbXYJpDgCWCH
         r7gA==
X-Forwarded-Encrypted: i=1; AJvYcCX9dTxX+Kj/5pm0fGGEb79U2hKjye2LbDP95+y2/j4KrOJoSAiOMY3dmxcq7zNCs3WxX4dP5QQN@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdipvM9SFzfQYM3SKzwX5/vnZqqBSEVePOQ4Yy6IUvluWunfF
	fxIcAEtMIT5Agkk8fuDcCidaMDtS+ufbVh7B/vSb6Gwz1335WxIzYkSbk/Hcj0IKaMKK4YVC3A=
	=
X-Google-Smtp-Source: AGHT+IGNwbJE4DS4y57UJRDt2qgfgZb/KQokrazWwd/XbMmaEzVRWFyU4mEFISXfXhi6ALUkqRhA3rLtvQ==
X-Received: from tweek-syd.c.googlers.com ([fda3:e722:ac3:cc00:b7:3870:c0a8:26])
 (user=tweek job=sendgmr) by 2002:a05:690c:c08:b0:62c:f6fd:5401 with SMTP id
 00721157ae682-6e5bfd57cbemr931137b3.6.1729552330500; Mon, 21 Oct 2024
 16:12:10 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:12:01 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241021231201.2638151-1-tweek@google.com>
Subject: [PATCH] libsepol: Support nlmsg xperms in assertions
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: stephen.smalley.work@gmail.com
Cc: paul@paul-moore.com, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

commit ba7945a250c added support for nlmsg extended permissions in the
policy. The assertion validation was not updated which lead to false
positives when evaluated. The optimization update was also missing. Add
support for the new extended permission for optimization and assertions.

Fixes: ba7945a250c0794837f94ee1fb124426166bbc6e
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libsepol/src/assertion.c | 16 ++++++++++++++--
 libsepol/src/optimize.c  |  5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 3076babe..5e129883 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -110,6 +110,10 @@ static int check_extended_permissions(av_extended_perm=
s_t *neverallow, avtab_ext
 	} else if ((neverallow->specified =3D=3D AVRULE_XPERMS_IOCTLDRIVER)
 			&& (allow->specified =3D=3D AVTAB_XPERMS_IOCTLDRIVER)) {
 		rc =3D extended_permissions_and(neverallow->perms, allow->perms);
+	} else if ((neverallow->specified =3D=3D AVRULE_XPERMS_NLMSG)
+			&& (allow->specified =3D=3D AVTAB_XPERMS_NLMSG)) {
+		if (neverallow->driver =3D=3D allow->driver)
+			rc =3D extended_permissions_and(neverallow->perms, allow->perms);
 	}
=20
 	return rc;
@@ -142,6 +146,12 @@ static void extended_permissions_violated(avtab_extend=
ed_perms_t *result,
 		result->specified =3D AVTAB_XPERMS_IOCTLDRIVER;
 		for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
 			result->perms[i] =3D neverallow->perms[i] & allow->perms[i];
+	} else if ((neverallow->specified =3D=3D AVRULE_XPERMS_NLMSG)
+			&& (allow->specified =3D=3D AVTAB_XPERMS_NLMSG)) {
+		result->specified =3D AVTAB_XPERMS_NLMSG;
+		result->driver =3D allow->driver;
+		for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
+			result->perms[i] =3D neverallow->perms[i] & allow->perms[i];
 	}
 }
=20
@@ -176,7 +186,8 @@ static int report_assertion_extended_permissions(sepol_=
handle_t *handle,
 			     node =3D avtab_search_node_next(node, tmp_key.specified)) {
 				xperms =3D node->datum.xperms;
 				if ((xperms->specified !=3D AVTAB_XPERMS_IOCTLFUNCTION)
-						&& (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER))
+						&& (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER)
+						&& (xperms->specified !=3D AVTAB_XPERMS_NLMSG))
 					continue;
 				found_xperm =3D 1;
 				rc =3D check_extended_permissions(avrule->xperms, xperms);
@@ -376,7 +387,8 @@ static int check_assertion_extended_permissions_avtab(a=
vrule_t *avrule, avtab_t
 				xperms =3D node->datum.xperms;
=20
 				if ((xperms->specified !=3D AVTAB_XPERMS_IOCTLFUNCTION)
-						&& (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER))
+						&& (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER)
+						&& (xperms->specified !=3D AVTAB_XPERMS_NLMSG))
 					continue;
 				rc =3D check_extended_permissions(neverallow_xperms, xperms);
 				if (rc)
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index a38025ec..8a0b70fe 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -189,6 +189,11 @@ static int process_avtab_datum(uint16_t specified,
=20
 			if (x2->specified =3D=3D AVTAB_XPERMS_IOCTLDRIVER)
 				return process_xperms(x1->perms, x2->perms);
+		} else if (x1->specified =3D=3D AVTAB_XPERMS_NLMSG
+				&& x2->specified =3D=3D AVTAB_XPERMS_NLMSG) {
+			if (x1->driver !=3D x2->driver)
+				return 0;
+			return process_xperms(x1->perms, x2->perms);
 		}
 		return 0;
 	}
--=20
2.47.0.105.g07ac214952-goog

