Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED7C1A0B15
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470377; cv=none; b=KezUn403WgjWoN+nNNKQPHXY67FiLz5sowXEUZr0hDT4Iq5CxXb9ucX3QYPYyuozY+J/Cs+6bqxL7HBxcR1w1hXWNwyPODNL9sMsB7I4tmJ8Hew4sbEeDuzB+WBeAsRR0Li3LpnmHdohXsI82i1j1YjCL8E51zJ4D7D+vmrArWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470377; c=relaxed/simple;
	bh=vCm+ojbLHcbTZKy1MzDdsAwkSKPYPyr6gdnHUjLu+KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtwUg8YoUOzjacWigH7wtEC8zp/fJijsI3auQ8d7RhpA5o7PSZaA455fmvcqizvp/BHYo1xmJ1SvG/Uc0kgb8AasKqSfROV1IyW0Ulsmh51XFf8pxSA2wmMt/uFjEj9enNkmrow+SE3M/eeNy5Dw327ZI6Zi4I6R3T5GneIFuOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzWuxesS; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzWuxesS"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6102bac3752so9340615137.3
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777470375; x=1778075175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTvLVoNVMxVylnj/rS5PpBab4p1QNEKxG3uaXW47Dvc=;
        b=BzWuxesSxDSDkPdqLclxeKOHh6fpfU3fcUC5AJqYcStHrplD2tqZ67xN1twk0bTngo
         95G7flYUy2AXHfaL+8SbgU9wPt8adHIhc0p0GXL930CuDKsPrH5ANsmF/DO5xxQ0eTVJ
         QNubV0IXQX9TQPYZCrfu/rLHJaZLAJgBYPSr9mPHA+X/SrMkUJe4zzrQ++USK3/9I2os
         aLE6eBV18kTtbt9ZBkZ73XBC4Il4irUmvD5SFAzpkNObfXiytFzH0RTb7cozWMBJzY+R
         7LdE9uy7uicapJeoH8BqRV1NKX7nAJ4J2ps9zrQSjLVTwVkXIxw7XU7znDEi1AxswjIL
         oH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470375; x=1778075175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTvLVoNVMxVylnj/rS5PpBab4p1QNEKxG3uaXW47Dvc=;
        b=CgDs4mLG1i7RMSoVOyK/HLb0VL0pwD9Yzt8PuQ1orw3x+IiGqSDc31u3+Bze37n6ZY
         4t3AOqY03ILPyIyM6DDrzXTq56V1HBna2rPqwaprCByx647QnvViqRp/tvxA/tlRuH9i
         M81jVowkH+yMBMBSX1nW9CvKGR1oVi0OpNQTeS0HRzaHWwt6cYiPMdxdDI4ozn53nk13
         mbIkHPlc6P6TDqQNpAH8CrdDUMUG/grxS+2WgGu2ddBYhNzx5SAaV84kKx8dGLbCgT1/
         WwIuP4tKGBzdzpNubpfZtoWhyPeljJUFBn5EqYGNFXb9fv9A9SYUjYtE3yejWABtt1iR
         TOJw==
X-Gm-Message-State: AOJu0Yz/if0h6tKXkOZ857aWwxjZseYCDBrfXo7/uyjHpMcd/i1cXpo/
	awatpPGnv57sM4RZJS7hPJQ+z0qd7H9ZC71BYkgfqbH71ccXITmOBeTjA3WDVQ==
X-Gm-Gg: AeBDietZ0j3+DEvRaROd7ih2mCOks8/Q71lDzadDXY+h+di0/zSDT3jlF1F2ntOaoNG
	LK17XyjNbbsL3iSYqNm+1g1CVIB/yGNUBHEgCuRDtwTIwjGqqGtbC57CAKe5y1tGQvPxEfOA8/h
	DyNXUOXt2NxwEgUD4QyfV94joApJeShdwyZ5pR0gTi9tgbFXzRXKzISWdGH++7rBmfgXyneEAVk
	uH8uEO0MLQGH6Tp7fr6ZhqIlT5cKdqZMuOYadcDNQVx9eHC/E2jDxzK1G4N7NTw0PtAeaNFJXNG
	KQ42oB4tzGjXkuhTgesRFBdG9FQn1p/w6M13MIid0UHyqfMejlfqro/Ig5P6Zh1yaEN2S87x8FE
	yAdplSHO0rjNwKzboj/29v7KV/ZGRJx3GfROPJp49lJSZcT2i1gugnWyXv6tIXjwiM2Mgn+7T6C
	HZGBemhzso2b3zZtw645yEDacP4+JK5q8IEbUBn62FzCwjO49VtYhgbPmQhPX2gzAYmbA=
X-Received: by 2002:a05:6102:c46:b0:604:f155:9374 with SMTP id ada2fe7eead31-6280a3af2cdmr3942461137.15.1777470375617;
        Wed, 29 Apr 2026 06:46:15 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93cc09abesm175376285a.11.2026.04.29.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:46:15 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: lautrbach@redhat.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Change log level of "Failed to resolve" message
Date: Wed, 29 Apr 2026 09:45:58 -0400
Message-ID: <20260429134558.109817-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bd56ae44 "libsepol: When resolving names check if a block
is abstract" added a log message to report that a name failed to
resolve. This message was given a log level of CIL_ERR, which means
that it is always displayed. This can lead to a large number of log
messages when a policy has many unresolved name look-ups because of
optional blocks referring to policy that is not loaded.

Instead, make the log level CIL_INFO which will cause the message
to be generated only when the user requests higher log level
messages to be displayed.

Reported-by: Petr Lautrbach <lautrbach@redhat.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index b0965f1d..048b3aaa 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4407,7 +4407,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
 
 exit:
 	if (rc != SEPOL_OK) {
-		cil_tree_log(ast_node, CIL_ERR, "Failed to resolve %s", name);
+		cil_tree_log(ast_node, CIL_INFO, "Failed to resolve %s", name);
 		*datum = NULL;
 	}
 
-- 
2.53.0

