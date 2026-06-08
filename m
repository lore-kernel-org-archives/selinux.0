Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056EF37BE96
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925465; cv=none; b=Ac+edByVN/bZYnYJgYA8Sc6NUD7KytlmDAPfZEz4UngaDA2bVlm/5Z8ZU2mZKuSZZDgDAdaqbhGQADf4bs+aFrVNTs4uf/SNlxmy/VVz/Xr/oYnWlE5ET7pDbzjZ16Ody52HB+zOsZxudo9leMTqU2fnfvtAviAlNLKrTIk4gTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925465; c=relaxed/simple;
	bh=0Q/OLl2No78W4gtF/9sxZ+E1+N8D5Cyzzz4WJ81jZkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sldWQ7t8YyWFW1IhMoT/NMz1Lqtk3KVbdQMwqZoD2j1UrWpMkgBZ6wSNT406/xWJvOlmQ/SSf6LXYsr51GdOLJoAbiWK/bndbAWNTOMKVB9C9CBffMbox9cllX4ExgGDl4xZd0cxtqdKWoBPZu9PcBcO9ZDeljpfMNy5I37uUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMDByHFe; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMDByHFe"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so68403696d6.2
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780925463; x=1781530263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/1UeQYdJmipGRJvIZ86mF/KgypStlMmkaOiGnm1tSA=;
        b=BMDByHFekOHaS/rDx4CpuODteDR4x4umGDlPYB7JvkStAaJKK2DUN798kDql2llFq3
         1IJwrPRbUc1d20A8YKqfSOqR1VRIZx8vO5bZV9ea0l5GUOzib+f0CsJ5oQy7InDeg18v
         QQaQa/VLnUKmkcU9YIbm2d30KFgblI6Gkv7fwM38EairZz4CAT3+F1pi9YU073HWoAfe
         MrpDCfY4ajWOKCK2i9Ihmdn1XoAIu8LvPmOG09XJHhBTmBZpQbQqs2NhGMULVOSiHmox
         jNXfo7Xitrl+c6JvNNAn2GCq0fNzbbouU+8tBVN+64yMQlnegiFVbCkIhsI8u85z2mbJ
         VOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925463; x=1781530263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/1UeQYdJmipGRJvIZ86mF/KgypStlMmkaOiGnm1tSA=;
        b=eV1QIKRcHbULZ+jtDp4oPR2B+oCjTfDIV1e81n+xt0adepWuT6c4OXpT6G5bs1cAkd
         +ztD/r7YXCLcVUg8FXg9C/y8B6b77AwjFZFcfuX7qeK4ZmYxFAOE2Q/hzurNtbVMhSe6
         73Z3QGG9snob7led4uGhd5OQwZt7+xpWL6Td2Mz0yfun9Gv0wBD00oFujv9gvHGpC5aA
         RjdzZtDuiDOo41bUI+jFdBRYu2oh9E/y0mtau7wRIRHK1mZSA6elSn9j5Mkgr+u2l6Dz
         45E55/Td9AEPxNoswW/bVvoN7Bz/YoHEtqT89tXxlsq6ECxQmmg3MkpEbnxYO2U/IBxc
         aEKA==
X-Gm-Message-State: AOJu0YxUIzVlNTcCz6L749SnGr1JK6I4m7T7rct6vOWZsFLEkB/YPJ7w
	Rksi0LcJTuiAwWHMhjF0mZ+3YhvdOb1qrgDjsoCpw0PM2jl92eop3iyt5xt4Rw==
X-Gm-Gg: Acq92OHVKh/vGzK7z2wQNbAuWXhtnwlg4xsu5IdrF+Mds0Ty81Ifho022CQXU0luwRg
	9tthwl6agXepxwQ1JEltJlbuW1sq/AbNjjkdX0XWJ0UMCSyHDubPBmMkneg8pDlo2GYq0kQ0yUM
	El3Q/Xw8atzeR5TkUfD2kiynnhrzexirSlPIHO7jNtRJ12yaJHY1nRaLCe9loF2zIIyiPFXs5UE
	0z8SxHdcBaDzs7GrXQvBVYzaR8ON3/rdZJZEZt+molzFTvx9aI4okN7Qt3Du35izzEleniUCZYe
	zEsJ4TSnsUBrCQWT2rx1AueZdtUydXGF/HwmTydD3fVDJOSRC1dW9U1QaTnkR9qizJJk2NXc62E
	qfq5tlJiEWx6gsKgwpwd9dUFP+huH20+XG693Bmx0VoggaISvEoKRk95HuFhwxtRPQgEPNt7WG0
	OJgWjtjDJ7dhTXbYKFK8QQOXSOJySL/WdRXNxCzJI5dU4XgganNHTJk/AJWnAMP+YgTNcGWW/JJ
	C55DHcJIjQ2OB3iIsFZOnLSkYxJjiSONdCTWw==
X-Received: by 2002:ac8:7f4d:0:b0:517:87df:d8ec with SMTP id d75a77b69052e-51795b727c1mr216173421cf.9.1780925451173;
        Mon, 08 Jun 2026 06:30:51 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775d9efa1sm150980431cf.20.2026.06.08.06.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:30:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Waldemar Brodkorb <wbx@openadk.org>
Subject: [PATCH] libsepol: make reallocarray check more robust
Date: Mon,  8 Jun 2026 09:30:36 -0400
Message-ID: <20260608133036.309348-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waldemar Brodkorb <wbx@openadk.org>

Some cross-compiler toolchains dislike the usage of -o /dev/null and fail
with: ld: final link failed: file truncated

As stdin and stdout is already redirected to /dev/null there is
no need for gcc -o /dev/null.

This fixes an Buildroot autobuild failure for libsepol package:
http://autobuild.buildroot.net/results/72b/72baaab4658254f4c5b3348298af1d5c891cacd6/

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index c222a8fd..cd6ef442 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -31,7 +31,7 @@ endif
 
 # check for reallocarray(3) availability
 H := \#
-ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=implicit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=implicit-function-declaration -x c - >/dev/null 2>&1 && echo yes))
 override CFLAGS += -DHAVE_REALLOCARRAY
 endif
 
-- 
2.54.0

