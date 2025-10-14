Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756A2C1590
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431499; cv=none; b=JK5QAVnD1aajj4LCZtkl6zSycrZKSCQ6JVS08w7mlzWR0VRaMtuR2RuxMkJ754ZPlcivEyEcSMrJU8QBZ+yolYT/DR8Hp/UXMuGgnmXBWTNYwV2+pj+wVh9WSREnG+5rMhf4z1vxKHuzyYZN47wfVwFrN6ifXHxUFSYU0zti+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431499; c=relaxed/simple;
	bh=QCc667ZR356w9M9sRjuYNALD7n1ghS2qqr7eO4lXmgA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=KPv7lw58Z8p7D2IlHhIuPH+4YA3wn/9/Q46JgbYK7YoItMbbgq4EkNbsLP11a0mbc0ixDoUgVSV8XXwbZH2FZYp65RqK3/AQCUvS6q0Ur61vEtWZ6rPjKLpzTjTprAvgYGBMLteBpr/gak1yPXo5JfvDkAby0WGbrOhV1igIm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRqYRDdR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRqYRDdR"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so3662584f8f.3
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760431496; x=1761036296; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCc667ZR356w9M9sRjuYNALD7n1ghS2qqr7eO4lXmgA=;
        b=hRqYRDdRhsTKKsTu0/kamAJEbYntGBGkgHvfZoY0K4CMdcCzrsQEBxnCnyKnkyXJul
         bGlSebIwsj94+KpGixlEVqDaUW8aj1LNE9gcDnE0nF5cb7g4WqWHKj39E9bFLx9JgvwX
         Yv5fPd9lwVHJknQqyYzHcR+6hTSnq51DWSKfK0AXBqdWavKnjiioxvILiTk+wQLDz1sK
         LglCDSMcbu+HvQIU+KOanY3Rq/2XjjE3nOtkmL9NPPNmI66rjci7yDxzY+RbrXNbevFg
         EANeGb+K/0d7zCnw5Sa0UMHNFgp7NNrtmKDOSvl9e2bmieafue20s1AWAxbOQjOQklFP
         CWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431496; x=1761036296;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QCc667ZR356w9M9sRjuYNALD7n1ghS2qqr7eO4lXmgA=;
        b=YQdzSVvZfqTMvojMiq8afLVvt5UjD/5FPYzmSr0ptO5zOoWLjZe2ikN5nQewtsyxjI
         3rOoecFWsCGUwBRgVhK+yiSe3KoDDxdeO3eIm3tDhpE3D8+VqPzjHkVhOwZOAUCVEtwD
         VtCCVCg11vMLIj8iUX0xWrYnB0QiUNiRlMYM6njdLS7CgsR9aP9Zy1Hay848sn01t753
         61AzF16yE86CiaJ/w0BgIWljUg9F/Ex6KPXvBI87qlm6np6cHE+BhdXU84VVxlgK9l6S
         qguej7ZhjwL3B5IhHiDL4otqZVt7l7/bduXwXw5mPeZeRgiX+ZRJh4BCMlJvmtUDl4z3
         7VxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNgVWhNvDaWn2T4gTZrhrLCQU3Zn0ksodCuP2Y4bM0qNs6fccf22Evwb5uI8cl4lvCE9STyjtR@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGCfpJsEJ2Vfa+lBQENAxbzV+HKHGpgauJ5iLxd1uSsZFX80R
	UN8NSPxEktQEScX/n1VbjZoLS28OCyM1Hi8vpt5MBn+R2BN/JH0Nfutm
X-Gm-Gg: ASbGncvSmOCwnvguaZMDeYpjPA0YVOMSSJkur1e37RsxN79ghgvAuY5dJpoJmhn21qJ
	+rdmDmELyIso55S9s/9RIwihpMJIrWG21wjj+VlM7eJFJpXmFz1/v7xJppapu9GWLYGim8K+SLS
	bEe7Gnb8Z+/jejxVL8VDNKQL7+DKORVx6tjkn48SWct8G55gtDdgozdmX0NcxhSlmFJyKPl2T4X
	C0mUZ2QHTxS0DL4BKCnJ4I/DDFKinhlPjJTOXfcVPlF/P5X90weqQK2iXcNKhzcymJ7wFvcv5yA
	tGgGAPobaBhf3FbjakfnpQxQ+ckXf28dyotOKF8Wuyvirc/M4HXZlXd7gsx2gbB8G+utuCKrTkz
	PNaxks1VGOp9FIKrCAW+dEM32ZvwLzBPyJKk=
X-Google-Smtp-Source: AGHT+IFfa8OAtafuuUGs2egVJBUb1byqVIgBWU+yOOKTl2fIrZpKoG8/MJ8EE2gS4Xc4dZ2jyMCXRw==
X-Received: by 2002:a05:6000:40da:b0:3f8:8aa7:465d with SMTP id ffacd0b85a97d-4266e7d4580mr13959139f8f.30.1760431495672;
        Tue, 14 Oct 2025 01:44:55 -0700 (PDT)
Received: from localhost ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ba41sm228702445e9.4.2025.10.14.01.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Oct 2025 09:44:54 +0100
Message-Id: <DDHWVS1R3X60.17PAF8BR4DEWA@gmail.com>
Cc: <lautrbach@redhat.com>, <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v2] default_contexts: introduce PAM stacks
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ5
 P23pREOYr7nz0OyFQb04Pz1fNaNB0_9Qn52aLQqrAQ@mail.gmail.com>

> I'd like to see an actual implementation of how this will be used
> before we add it to libselinux.
> Also looking for input from the distro package maintainers.

Sure, no problem. I'll have a patch for pam_selinux(8) ready soon as
well. This patch goes back to the systemd-run0 discussion we had. I
just realised that if we're adding this to default_contexts, then we
also want to probably add the same functionality to contexts/users, so
I'll send another (RFC?) patch to document that too.

Would you like me to ping your github account (@stephensmalley) on the
PR I send to pam?

Regards,
Rahul
