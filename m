Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C93090C5
	for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545383; cv=none; b=ojerwxg1JgErQ/6YScVXnGIH0r76rzTDBqu0uQq44isX4vpkZ8waMNrHCRly2Cwba5BudxlhuEIWnAsEZdSzeVnnFIA9iykpJdoJ7KAXSp9kuJTu9UY255KlfTwmF/nJKC13SDCKgaPV899mD+Wv74qekGj+KRepSq8xn6Qx5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545383; c=relaxed/simple;
	bh=72xINJxwfWCjPzDYknkvknCftfqpRGYVTgoJ7cd1Fis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8YtfsIQfbcZXxgqsuVZ2Tsk1DWfoQMfl2fNshkgSpqMQLMciS7fGpQLJ3+66CdVtP9OducyEL8SMY+k9K5K7YOGFnrDbfpun6E45ENSyaVqL5VqrIxkiJV0TGIF96sLLEkx9dzFASTutJj4OUTbuTE76TO5ggIvx+6pnZ5IzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii/sfJTM; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii/sfJTM"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2445826fd9dso51331815ad.3
        for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758545381; x=1759150181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72xINJxwfWCjPzDYknkvknCftfqpRGYVTgoJ7cd1Fis=;
        b=ii/sfJTMMsLJrDJaSVZ6QD1jZ8bw80lisBBdAKUvU3SzLqx5Jq3/GAi4lWWZfiocN3
         uHz1xdz9bj4BO55Hyvw6VrIPtSfH/kQkcQHhl3akriqeo6Zoj2gdeO/tPft/3k2MI1WU
         gvGZKaIXr4XJVBOwZRWnEsArxsdP7d46M7MrPfCKaXH2jy61V9dJRrY2XimNZISIilFi
         IJlqTz0sywvpM+7ABe0+jfCkAxEOf32hQ89o6GzRPuhQM/hxltmY3AVGK8+LjeA69znG
         gO6t6rYiuz0/wYQnTicvrx1tZxXPjHlIuG3kEmPiKfVRyai4bnvB+PXdD3zCaxASqgXN
         iDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758545381; x=1759150181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72xINJxwfWCjPzDYknkvknCftfqpRGYVTgoJ7cd1Fis=;
        b=st8lFllxBL3h7kJUEC5uVoLFjff0l3gWfuoBwZRKilsvjuQgyfSXEC8lT/+dRgNg75
         3LZvOQgkPF8SKAvYyZCX08UiVabjw3+hY0lliYi44qf2fZqDvEsTZF4+G/m6QcquGZln
         wWj74izXKqN8WydzavTRrE82uwv3TpQJMd64gIImvtwM6G4fgt7/RKCBpoOQb8IthJ3n
         2XuUh5JFImrUL/o8BKFv1XrCKiYBkXUva0umEyzBAvR6NZeiDP+KIMJ121fDrHMOu5CM
         vYlvAddMzU6BX9ydy5N4ILYn3HLFI+X7wOQwMK4B0YAGq7oEZU8xCF47epiEaJMfLfze
         Rexw==
X-Forwarded-Encrypted: i=1; AJvYcCXMct6l54RMNC49hSjca/RJFpZ61qdYCl0PWjfBD5g5+omcdowc+y5NJLpU2UoYW89tLGAoYxZx@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtZL80SSnibHxbwVeCF8kWZTGtinX+qS9Jo5/4ViNfkP5U7om
	qPWSJgTLhYGK9pZCEtB85t5dqsJUYD4Gf4tZzndiXhJDRcRB59IDPdql
X-Gm-Gg: ASbGncuw8kxRamjzUkKWnkFLiAskGV1P6XlKn1wNrLgUye2WxGeenMupF5BSEkPAOKu
	ajdfaMjQdoyYzS0WI2iJqIXaI6dST0cDmtDTFq2X+yrZW98OAj4V8iKCHhVDNFMHCznjwoS+V9G
	JiF02xw8ajATXHa13KqyTVqB+y7qlhBNRVNoy8Muebz1POoeQHTC2IPrzTIr4Ja1n3vb74Y4OIi
	HKnshyo/c9w9YP6SeEb5+CnHMGOWAgfMEyhbRn2yeS4H3yJMPsV3g0Wv4cl32fXwvN7DUz2Rh1y
	sMFR9aFBqxmXMPLSNH3GPypOgxlU5pUvtFixPk8UlJ2SHmqh71a5rWLmHpHNQWhf3YaOYtYObZx
	ZnR+fJMfvHSGgm8MNVzii7U6nwRXk1G/+E76ds3vMqyWUL/nuHhc=
X-Google-Smtp-Source: AGHT+IHLkdd31s0BBY9824+rv3LblWPuwQwTjzF2olLliAheKwRkIaLxNxoDa9KmpbrowO9UkMVCsA==
X-Received: by 2002:a17:903:3b83:b0:25f:45d9:6592 with SMTP id d9443c01a7336-269ba558c7amr145199075ad.48.1758545381429;
        Mon, 22 Sep 2025 05:49:41 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053da4sm132593165ad.20.2025.09.22.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:49:41 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
Date: Mon, 22 Sep 2025 20:49:20 +0800
Message-ID: <20250922124920.262151-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEjxPJ41d8WcEh8QYp9E63+tCO2ukE5UWvCJ-hoXgN_Sx=P_-Q@mail.gmail.com>
References: <CAEjxPJ41d8WcEh8QYp9E63+tCO2ukE5UWvCJ-hoXgN_Sx=P_-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Given that the constants are from well known, public sources (which
> you should document in the patch description and possibly as comments
> in the code) and the combining function is trivial, I assume this is
> fine to use, but at the end of the day, it is Paul's call. I would
> recommend #define's for each constant with its source noted as a
> comment.

Thanks for your suggestions. I'll update the patch accordingly and submit
a new version.
