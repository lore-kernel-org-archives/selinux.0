Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1862820A3
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523501; cv=none; b=FBs0VXc7Nw1+bMC7QFYz4u9UWe2V8Kg6FNrZN0o8CqPDvpEJ6clbV371ot+/tdyXByIBEueCoUZwxOFMCOFhn1zInkdVwMCZAhec/qdKObrTTXIE65v92p+exj0hrEiDeJTUgQpafGboOWvP3oTUO38/yT4pPJMGbm2tf3kSZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523501; c=relaxed/simple;
	bh=DHEico9mR5etYRvjX5WPNNWvV0Oz+rZAq3lydhPQlzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUrd9cjx6W1xsr+aczr08oZZu3LCh1O+eODjBna8DGIdFLhM/Zw9HrTAPts7gpVB+wPKb+mmNMOZzB2JyM3GziHnZt3cWMxAMlvcNtUzS45BskHadYx+BYu2rGVWJmX+qhu1DvIaEr8tOQybv18LpJbV0nYG0hPooXfd9kRQSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaBs1Lna; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaBs1Lna"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-739525d4e12so1301168b3a.3
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745523499; x=1746128299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHEico9mR5etYRvjX5WPNNWvV0Oz+rZAq3lydhPQlzk=;
        b=TaBs1Lna+0RhE40xF2UbUp3593PNtmZccgSEAXbf0S7kV3UI/hYg+hh29mBZnmvL9Z
         ppB0BpiMAB3w9DP2L3VR4Tu3wiurvV0pKu0LluwBcQpRCew3BX9EA4CHTSm86aqW/dr/
         qLt1vR7ia/ArGVxszWvGVSJg8F3YaQwsZFPe/gamHonjtgeXI4VreG+uz3hywC/gmA6i
         foXQqeJVQShEzdq7dnoXypy2t/2KNyc1KMi+MP41gaf/vuuEySiZ4F5PKEzBlMJDG1ow
         hI90TQTEjwHX93akdDU+iWWAIZGkdF/sGXjwYpxx7L6KDMxrFux31bm0DnbQLisP6xUU
         KjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745523499; x=1746128299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHEico9mR5etYRvjX5WPNNWvV0Oz+rZAq3lydhPQlzk=;
        b=TTDnTqdKz9lYNnktEtQjwW/YvV8xAWhG56newutGQfeDObc8VQXdqvXry4XrgRwI+F
         O334Pz2f0NfIhfw69s1cKxQLHYkqM3vJSGGpUmVtVbb5rx2HcaLSAREG4tG+za/m5nF7
         dpZ6/b127ycqO5sB5kUdvYsOwVz16hEQgvtmoOq7vC84oA1iLYHA7kJy/j42edcRc0L0
         6bve4sobZVUWj0xedzTh8MeGB/RpH+OYs6ZldAAApOrn2IAo9sTttywTGjXgoXe++3ad
         yc58k6dKSqsmEnMZrnfVXB1pmf3bh8KaK5wc/vK3JXMfIExt+eY0Sh4+wI0dcMrlDQ4m
         EkDA==
X-Gm-Message-State: AOJu0Yzq7MrnsSuX7z6GVzCdUBlRGoXbwPw8UJOY78mw+7rEf611kN/F
	xs+E7RYHSMPcxWmNl46BzcmwC+1vOEmTK7/AusajL98ndDUUB9+Obmh3qWz5bxKXo/8RRoOAPoO
	d7ygYTK04OFgHDEX+NTXbF10yVyueVywu
X-Gm-Gg: ASbGncu1uIIOsX02M9EtHhm4PF3BFoJtkCuQ2V4/oMWgeTh/mTOYzljXbCA3axa5U+1
	AHT8/p5qpSHOM2tTghs6/c4WWKHHqVZPJ8fRHahKGvaFN7b1Af/X4yifZJCVcTG83IhoEaLN3qC
	nyDtUPNfpl2VbB91WITrMxSQ==
X-Google-Smtp-Source: AGHT+IHXM0LL7qzA9iWYmFQ8G8lrY+Srza6k/XuXaYijEtw8Oc07M7+YEa020I/JrRVGUjv/mZeuPWnyZeKVdfJqorM=
X-Received: by 2002:a05:6a00:2e0e:b0:736:7270:4d18 with SMTP id
 d2e1a72fcca58-73e24633349mr5083628b3a.14.1745523499303; Thu, 24 Apr 2025
 12:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424185213.17910-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250424185213.17910-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Apr 2025 15:38:08 -0400
X-Gm-Features: ATxdqUEVtq2tDuer_MEP24tyZzS5gM7nzymqX15uQKzJMJ-aeazyxG72yWB97bs
Message-ID: <CAEjxPJ4vHQoiaQVtF7PGg4w+hJa0Rve3ob7ffUnwYoLapMjk1w@mail.gmail.com>
Subject: Re: [PATCH] libsepol,checkpolicy: introduce unconfined as a first
 class concept to SELinux
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 2:52=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Introduce unconfined as a first class concept to SELinux. Previously,
> SELinux had no such concept and unconfined domains were solely defined
> by policy.
>
> Advantages of elevating to a first class concept:
> 1. Explicit allow rules for unconfined domains can be omitted, shrinking =
the policy.
> 2. The kernel can leverage this knowledge to further optimize checking on=
 unconfined processes.
>
> Disadvantages:
> 1. Yet another juicy target for exploit writers, similar to permissive ty=
pes.
> 2. Requires a new policy version/format and bitmap.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

Sorry, should have marked this RFC-only, and only compile-tested thus far.
Kernel patch still in progress.
