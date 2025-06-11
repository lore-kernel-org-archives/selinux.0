Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9D157A67
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660314; cv=none; b=ahVW+E4us3kj36frTr/NyTMNQ3+eMafoJy5qd5ztYFUEEReJA4XQccoKX46YWzaLLeonmKf+1jnPKZ3kcHIvkQFo3jjKH/mH2iAW4rPbv7kr7RJNvgMCHbbBt5BFTXYv4PyoNCK6z0Ar/avAXMAUdpaouUc13Ohl8V9XAyoZk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660314; c=relaxed/simple;
	bh=GpsmAPZBVSJJ+9ubBo2hDGtPMH3NzHnys3NejUG7amc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UtHCXgLLR1luZep6RkULtTjW5dunJeGbvtkq2Uw2WDciqI/HDA9G6IsdKMmuJ8LfQqcjBBU1hcot1JJphA2y+DyYcPZQ7OPnITEeWIoQ+eXoPX1xLbPdNgAiYvYneCWYbGcI+l7Xl8CXiWY+zKxGX77qPCv133MQo/Cb/yPPEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WeXA8I0r; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WeXA8I0r"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e81877c1ed6so1137408276.0
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749660312; x=1750265112; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VjFLPJSCK7nqLjUFHebJGCzVS7403d3JF/BF7G+jz7k=;
        b=WeXA8I0rJdCnKfArMTXJ/XnY9sMyl7dyuD3RJJzQEq8P5Ns/7c/erFgeDYHU0zu1Rx
         goNLdT7BoW49m3a4Gz59SWIr80FeL058ysHXZmhg100ohMqjJe9/iCkIlE/DhNap+Cx9
         cYyd1Gxg2TcTiXc4rf5iInBzrsEiYtkeuDGMz919WlUGkvjc66NscX802gw7FY8HmO/k
         FMfet5ck0LzXAVWejyLdeWe0Cd2J0Ypase7AVnWlVL8txCUZ3wLvDtRv2bjIpieBq6v2
         a9umDNJt82X+AhbhtUg2vd1cWHF2MfE5VA0rP2eERl1OLt/7P+uX+8fPIZvxVD28Y9cT
         xACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660312; x=1750265112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjFLPJSCK7nqLjUFHebJGCzVS7403d3JF/BF7G+jz7k=;
        b=KjN1Vp86I5Sj1h4g5IzFdKleryN6jNJRUzZTcfif6bPmD+aiV5fifIobkR6mkUMncN
         LeOPlyHwAxMInDaks3dBRuS9N8SW1oXWF01k4DalQD1rnTj28PY2UyikVB0+JZTW0T7r
         cqH837FjlivxslhglSrR8kQynR7PJoF3Sd8LrlpQS0xcdh6lV7AeAc6oww1IuifIdn9N
         hD9Qm9i8u4UyUaxaXO0AOn1soCG/ULvo9a0Wk4R8qHSq5LVDGTBHZGgucwSrOqEsovlH
         9A8Thm9mDMDlOCNigHcvwYbsRKSvStFdffau0FEtwX7V32BjbGl5JJLdhjiyw3z3kWf4
         wZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXyVJPIqs94XXcLmx3AesU03GMdR9RswznJC86GuhqLg+0SkBs+nraQS5iUP9exyeyxfKZYpy/q@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyrvpMfrEazq21u+l0kEQpKgNr5sQHkbW0Y0ooHVFltGxL7e5
	q9BSpOhJFaxBNBbDxgzFkJz7odDZbyl7OARN5mYnJIZCDzK3vILzA/Z+R7n4Y8nlCSoOCMyEHoi
	dy/k80yisr9PiyxYkI8PkLMnF68TkWKU05JDsb7Lz87UnT7XXVgY=
X-Gm-Gg: ASbGnctnUcm8gkaScQxAqeEqUu+L6D85ofWbesOoAh5abwyqs2SN7+Ov/QOhkjxOMRZ
	UtiL2OqLE4B7zTjxkpGewEzqLwSY5g4q94lXWwvEVOnZUmy5jFdkM34BlPSzPTTEIa1LmEBSgsw
	ZwuNcP3bNqoeTTXOG7PwmMHoU3sfSIPNu/2w/8iLzo/lY=
X-Google-Smtp-Source: AGHT+IFpVzU5xakUGIWEFzt3Vs31IfWYUQtu2lGuLXxdGa+vrXBOhii19UeY+k9qsztms/Ib9g7qayNwgfku7adO1V4=
X-Received: by 2002:a05:6902:1145:b0:e81:cf4a:a1ef with SMTP id
 3f1490d57ef6-e820ba2af86mr154468276.10.1749660311765; Wed, 11 Jun 2025
 09:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 12:45:00 -0400
X-Gm-Features: AX0GCFsd637Kjp2pdqdIqT1H0upvh65nnom8p7jd4vEpZpByetyp6Zkn9cfa1z0
Message-ID: <CAHC9VhS9P-fgWac_sJ_dq6_AQf76RGiqLAmOFnR_4NZ83KQogw@mail.gmail.com>
Subject: ANN: LSM and SELinux trees to rebase to v6.16-rc2 next week
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

In order to pickup an xattr fix, link below, in the LSM and SELinux
trees, I'll be rebasing the lsm/dev and selinux/dev trees next week
once v6.16-rc2 is released.  Currently each tree only has one trivial
patch in their respective dev branches so the rebase is expected to be
trivial.

-- 
paul-moore.com
