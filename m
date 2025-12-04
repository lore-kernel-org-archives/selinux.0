Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DF398FAA
	for <selinux@vger.kernel.org>; Thu,  4 Dec 2025 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764891970; cv=none; b=HwBo1VAp7uNjNsfxx138YFIyg4tdmnA+cW6zf3Xj//Fnq1zui5XkRUv278c0vQeE5pjbZRWTHmgC7UIafJvOeprIHcZ9vXHCx87rlKz0gzVp4ObNrIwVSlWJd0H1U5wJ8deml2wk2rWDPeHl2o4Lgq1Xbi+uj9+MCQN5knHGcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764891970; c=relaxed/simple;
	bh=8bXJ68pKnt2pDJWg8mag08R6u19g8q+B1AYX7/7aTaY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lL/lW7ti9h/46psf1MFaZ2bdqO/DVCgdHns6lQWeD+U3wNi16tDKpIeG9b4u9DDCDmVnVcCIw9x5XYM4OlPNT5wjQtOfH1+WZvivpye3X6+2UotlxXnTfZN8H6ZPv+745vL3OLUO048omRIDW6daOhxrzjVS3/vU/S8D4ihgNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ToG1vI4/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ToG1vI4/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29555b384acso15616585ad.1
        for <selinux@vger.kernel.org>; Thu, 04 Dec 2025 15:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764891967; x=1765496767; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FcMvkSjX6f8b8j1hzjcKUPEU1GcyuQTU/MO0Z28PcZ8=;
        b=ToG1vI4/wrLMeDpJTxAaIZ64pq3bedEKyvQKRD6Ud2lXZfZNyN7lCg95ZQ3oit7rS6
         1vU36wrvNpj37XvIXXdeuJqpIKIozrloURpNmS3AwQlVoMEV8wz/Zw5IRo/V6Ri23dB6
         v3pp8lJxicNXTh8IvG7oQQphh842qbC3w0uCZyqN/N2c81fWDvCRMN6L3Fklt2nOjieT
         sZzhYPf73udp66t2hhcPokByLVIp3READeUATMv/glPDGf7jkiE3NJTQBNFeM+Ube/v/
         Ou3EKE/M6MtB3cpVkqmriQS56tbzSg3V1D+uPK8VDs7q2oD7AD1i71JlYQMAJ/nWXN9o
         MNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764891967; x=1765496767;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcMvkSjX6f8b8j1hzjcKUPEU1GcyuQTU/MO0Z28PcZ8=;
        b=GxRhP0UtBNREJLsrphK+sTAHwuDTWM+WJI9gVpCRcXwJRWKu0m74TgUIir6pHhoqa1
         bkeLa45jN7iE6KKCzs5ZXQOt6cdlGCkuDL2GxTkvUU1kgzc3iF34M3o/CSqmL0CxFt58
         JhE/7rDNGoQSeYeahVsPSkNSxo5tuPrxuO36aqz7jzzQ1JpP3FhdE1ga5f5pFqtHk5Yk
         flIpHrB/B5OBI9vbOVkJOXdJd3MA2Y69K0Nfgot9kYniOSiMkAXDxX6eeNopau2gmX9b
         Lobe0FpZm2g1XbUZqG0exhMmn+V2UpTEXzZsnUOs7runoi5ucgwNU9QQ2kT0qQ7Il8FN
         +DXg==
X-Gm-Message-State: AOJu0YxU80XeGmjOhrQSSTPHwiPp+/u24sH/coxOEdpjxJcNBtUL4mux
	jweWelvHjsg4tG2hhGNe9mGlvxzkHkdScPpJOth+zrGiBGAskFFqitww/5gVdxqDxkD4AR0DnxP
	xT9zF0G3tC3RLH5jZFofNseelgqDTzaYSxU6+OJttEMaGXbwZvn9lgQ==
X-Gm-Gg: ASbGncsHjb0EVRSApHEaaA0xJw7d2LS2hf+b8HGbIXxVQ3klArSvrX+6lsUgIZNULlM
	tYGz3GyvMIacp+iUfvu8vZp707mNHvaII0kA18t6mlP4ciU+7QAOiq58kWly9Js5Fcfxy8PLmEE
	93QE5pCR1jiBUcQVNIqQ+5WSElBLZvCo1q/ym/EUG6pGxvrjlr1pW3PupEt+UdGG/z4PKC/LHUl
	xI7FpTJXh872RObzrX/GDQeYgWMiwPGZE939FWiN4T8bhWy4WW0d63s9dqRZhIFIhOf0P4=
X-Google-Smtp-Source: AGHT+IG2zAuKZiUy3L5m+89UNotpV8SiKZOHZc/OJXmp0bBrE/zs5IsJl4JmK0x2dIIs4E+x5mr5D2gz1j1IIM0HSj8=
X-Received: by 2002:a17:90b:44:b0:340:a5b2:c30b with SMTP id
 98e67ed59e1d1-349125d33b9mr7153178a91.9.1764891966575; Thu, 04 Dec 2025
 15:46:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Dec 2025 18:45:54 -0500
X-Gm-Features: AWmQ_blD_39yEYf704f6nOoRUGxrLy7FZsyc20Nh-HiofWtj5noCCRtpbz0k1T4
Message-ID: <CAHC9VhSaM6Hkbe+VHpRXir9OJd1=S=e1BB3zLkSTD+CXwXaqHg@mail.gmail.com>
Subject: overlayfs test failures on kernels post v6.18
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Those of you running tests on kernels during the merge window may have
noticed overlayfs test failures in the selinux-testsuite.  I just took
a quick look and the failure is occurring in test function sub_42() in
tests/overlay/test.  That particular test is expecting a file type of
"test_overlay_transition_files_t" but the actual file type is
"test_overlay_files_rwx_t".

I only had a few minutes to look at it just now, but there were a
*lot* of overlayfs patches sent up to Linus for this merge window,
most of them relating to overlayfs credentials (moving to scoped
guards), so it is possible there are other SELinux/overlayfs failures
as well.  Has anyone else noticed any odd SELinux/overlayfs bugs in
recent kernels?

-- 
paul-moore.com
