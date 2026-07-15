Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A630648C
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132455; cv=none; b=tfyrn+Drzr8vwTINN2TCMSU8UwGLpHIGz4q+xiw3dQBN9pFSecbqAY0hmYPi8nOnnXUnPc46uS5l7xFHUtdrQIA0HXQw536hY3ArtnWQ/PeM35EyxcFfIbkMK41JbV0GWHyniVsiWrxUWEhFAnct6F8mLGqjfyJj6zrPPGx0tMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132455; c=relaxed/simple;
	bh=rGVxbRRl1kfH0Mh8J8pVSMJIRLn0OGtkYfuWV3yCLhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHR5cFR5jASFlB6HbU473Ugt0IfjSGUp+UMJlhinzuMLLD9jRZIff90QfCsGhtZwKX2i3KRoHTtFdWnXIuYGCQ3GdfzbPuPcR/1EsrLGXUnIwzrv3/GucVMUG/LZJM2c/hSY3zVbRosB0X4wvY/n7TEKew0RpsZvLLV1DROT68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTJXvGiV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTJXvGiV"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e53581361so403837385a.1
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132453; x=1784737253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F49G/OoMVdOSeWdg7dcaH5I2fSamTXNZ4Hb6qx0w9PU=;
        b=fTJXvGiVkbBfzrhEHIjmt9tBKKFo37OB6Vi7iOnbOKp5ptSAx3PCjGawBm8rpTaAsS
         hhMbsFtQYUhB20uenEtxl9gDETrEG05ufJO/f3Fz4G9qKPW/2+9U7wnJ56tpQJC3V1Rc
         JrUyUgTfIzfqmPaTjSM0afacZbVJhqze4GBO3CWeKCrVy68obrezBNt3OQlf87k5wCnI
         wl7k2ePbh5HkkLksUPyezfU63xAdE+Fb3fGqUPYhTZ6434ktQeCZ+X74xfoQ5CfRoytA
         +EYgJHEo4k2ZqdFU+BVzd6RLVEBFzG93xOgJ9lnGuKjxqW7uUpngIm59oIa8LhG3xyI6
         Yzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132453; x=1784737253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F49G/OoMVdOSeWdg7dcaH5I2fSamTXNZ4Hb6qx0w9PU=;
        b=Z3aKK5ceWe78i00uldxJGgkXPIJ/ww6WUs6t+p9IYV2s9dJSiYYCz/0YmklrC3INvx
         KwnM+FB92eF+P7msQ3kKjcMlyiFQlNQHx0gMGzs4qkUSf3NQL9exUdUzJGZiiYUM/bqn
         Aed9o8WAcBc810F2HuJQxVRHoBKfb610tCJ+M/r2P/ZdKVJ7oEGL13eRGoIHBlvsC6zB
         hAC/Yq4HtZvZO5NXb63khSgl3bTMlqS3iHEqiz1l610AluV1RYVKKKflbF5e2dZFKIzK
         lii9qhGk4typTeIAcYWgD9BdJz8zz+AiTnK6NIjrOaCer45gm2NkYuibzS0pwsdghm0t
         Rz1g==
X-Gm-Message-State: AOJu0Yz9v/XIm+UBegNfIrvx+/HlgMZwnAhyUbVNiB2ZEiLoLF4AmrIg
	C7v7O11YboW6o2k2xfCXLbGBHj6Q3x+1K2eZf76aZ7PT7ZQT705ynmxfG6x7sw==
X-Gm-Gg: AfdE7ckNEkmHr3L0vHik24CnFberD942oStUw1DYeovAdDMEgJZrz60xJeYOYS1a3y9
	BeDQOgQXUzE/mkuLYx9BjaI3Ob/gTHWvHDDAn9crZsDjsfERSTPLKK7YQUEu9A018XTCc1SEwOy
	Wa+lQc60fpHtp4g3WOm4sMjL+JpFSufi3F2Y1cEnSp4K2Kebmid/CAOuCxEhr+rSjGbe2F1xlel
	ekSYedjE6g2LrY7wpks54W/kpjamHbEDH8YBoUf+riaKU/xjdmPi0yFbQIR8ija+83V03KRULQe
	0a0jM0MNBSNylHzKGC1M1hrUBOHe+ESpZzvdk4wx267HvAdBIxOVSYhvQYmT4wPpJiQzt9rOW3P
	qlniU90OemvcqrvNtkDP2pSNN+Dh6fAbUZZlaNiAnG82weh1ATv6zAAKRwCe0/OQYqrXItaInZq
	RZUMUnyygDBkcpFHHEa/Z5RqHLFNmh3LXBcWoDZzCcgXyUq+0ZYRX8Skj4kldhqOLGc41+kd41F
	8GySCTbidG91iwH
X-Received: by 2002:a05:620a:469e:b0:92b:6805:eae5 with SMTP id af79cd13be357-9309629f321mr348093185a.66.1784132452819;
        Wed, 15 Jul 2026 09:20:52 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 05/10] sandbox/seunshare: document that -C has long been a no-op
Date: Wed, 15 Jul 2026 12:20:31 -0400
Message-ID: <20260715162037.42329-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
References: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally seunshare cleared both effective and boundings set by
default, with -C as an option to only clear the effective
set. However, commit 1f0b5bd920c8 ("policycoreutils: seunshare: Only
drop caps not the Bounding Set from seunshare") switched the default
to only clear the effective set, making -C a no-op. Document it as
such in the man page and a comment in the code to avoid confusion.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.8 | 5 ++++-
 sandbox/seunshare.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sandbox/seunshare.8 b/sandbox/seunshare.8
index 5339a3b1..bad7e1dc 100644
--- a/sandbox/seunshare.8
+++ b/sandbox/seunshare.8
@@ -22,7 +22,10 @@ Use alternate temporary directory to mount on /tmp. tmpdir must be owned by the
 Use alternate temporary directory to mount on XDG_RUNTIME_DIR (/run/user/$UID). runuserdir must be owned by the user
 .TP
 \fB\-C --capabilities\fR
-Allow apps executed within the namespace to use capabilities. Default is no capabilities
+Retained for compatibility; has no effect. seunshare always drops all
+capabilities and sets the no-root seecurebits so setuid-root programs
+run without capabilities, but leaves the bounding set intact so
+programs with file capabilities continue to work.
 .TP
 \fB\-k --kill\fR
 Kill all processes with matching MCS level
diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 37a24c57..7c6154e1 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -864,6 +864,12 @@ int main(int argc, char **argv)
 			verbose++;
 			break;
 		case 'C':
+			/*
+			 * This is a no-op ever since
+			 * commit 1f0b5bd920c8 switched
+			 * the default to support
+			 * use of file-cap binaries.
+			 */
 			cap_set = CAPNG_SELECT_CAPS;
 			break;
 		case 'P':
-- 
2.55.0

