Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA82E7F2A
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856361; cv=none; b=cG2RmemxtRkdFCtDxfzv3o6cGTJfRiKBe/pRWWT1slmYzDj/rEvW1MX6iRkkxHUgN+JyRk7oak7g0obInI5+XAQnesp49ZD55ofCgYG2ivXZP6RBBAkyN861rSoFSSlOPg8bESR4v4hiFNtLm0ysiz4s2+J2IW8zUaekFVn+Vbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856361; c=relaxed/simple;
	bh=nuBeXqzbbwIPiNbHdLH0b14LMk9SazaF1ipF2VIlvIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=u8pw9ry5wqA7RPGGoKfYYWbuAZ0gwa9kgXk8DtNPqlyNPGjq1WBYM6vyDjR3g4EphBA59ZKj45vHgLR/b731qQBRpb39gn5U5ffP+PRZQQ4ajXVxy05no9fXug6iX8bjH4CYaGjz1aiFi4jo+1xooWOgTQlhD25Gnwx8YT3GxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCI9xFlh; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCI9xFlh"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ab0012e05aso4200356a34.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759856359; x=1760461159; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuBeXqzbbwIPiNbHdLH0b14LMk9SazaF1ipF2VIlvIs=;
        b=CCI9xFlhX1ScVnlSHfe7zJPvb1JOs4f9/CzwrkryF8mB9jgx+F4i1z5umMjevjfRu/
         XBjWEJOH3PyDIdaJtnt3UF6tIwfHpS1C//IKS0o3OOT0+wYzo7IfzfHWc31ntn0o9Skf
         4FM1HuilMCFbHWL1YRulEq0Qu9b8I6Jyef8tl7sEVp/W1F3hufsqt1PrfTmfAz9yXQQl
         OhG+GI9G7ZD7Wh5TuGEkXqgXjZ6/Nz9t1r5kKMDW1haAubSlvJvxwikB7CR/vGXbZpFd
         IQulG97I+IvIzPf0RlNhpUO2ARle82WOahwCFmo9oNA6t+YHWXhTez+08hp5B9Z8+iE9
         fIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759856359; x=1760461159;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nuBeXqzbbwIPiNbHdLH0b14LMk9SazaF1ipF2VIlvIs=;
        b=cOBlo+2RXx9YZ/kfzcJbUydkFG+qZ0S3DUUq6zDGf5WH2E6LC24XwS1GTc/9cEVB0S
         Sl47kyqICTbp3f4TQsk6K2hPom2O6LQRwxLRBa7rILgcr2DZu8fRl2SwWKQVJXvVTe8g
         Nm8jpt7y8Lu2hqbd+Kie0eq912K+s0MEZqdpcInNLA2vhVFAQnzFpfgkVrD22q7j7qIM
         9eRZrCcNu6une8uITYRBdmh7VF0qHAFTouFcBgg0Kb7I144+GQi44EIf4kqzU3Lez/VA
         cPylRvhuOIgW1xvbGJT630yG8XLFGRTIMROeOtRk7K4fuEKvjI63+UgNvegIKXZzvBlo
         HviA==
X-Forwarded-Encrypted: i=1; AJvYcCVIf9JIjHk/IXCHCB4Bcxxsu8s3IS6OjfMaKYmsCQAnZ61W5NGUlKX1g2NAGpWchw9GjLUN5Gyr@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1F31y1tOPzvNvOoUjxXau5yxpWwNIn3A7SnId+iRq8y2A1YQ
	yQUibwndMg3i5pDKJpTJqvp2QOyOw+h3jNCFsqZ6TFxwqyqLFTw4BOHgkVFKag==
X-Gm-Gg: ASbGnctaIeMXl6RWnXGgZhJC6PvPfH/0jdc47XkapSCuABb4YkqqqdsLquQf4U5t8nF
	Ok3mFVoeGiUHvk+6C0CA2fb90RBs2sC3A5xoxgCsa/WMHpw4mv0K7FAZNoXivTtllwcnYN8AVbV
	Slx16qV4Uw9ul4umJspC2Y74is2/wn+MWZEeCDcBxiAzbMRA02A0B+w+BFUHrsw6ggDK9nf+0on
	litOxh2ewx999XxJ8YDfS8swUGQFTHYQs0GZdcVZqn66Yz9GE/ocVdEmXOZWMYv2FBsPSWePali
	IgiyxetPoAj32XnMHi1Svcbgq8nSTEJkuvbKk8mzYVZVfis6Q9pbPlEsc07DZri8bxuMV0FmyXq
	6q81CjEEXmfXRPVFbyz5vV7fXJ55X14xpAPXMsg==
X-Google-Smtp-Source: AGHT+IFPvU8uJww5FZx9gXRPqkqU3or2HPBETDDiTlQool1QmplyGoVvBwyip6wQJ6ESAwKuETrUHg==
X-Received: by 2002:a05:6830:71a4:b0:7b4:1768:ff3b with SMTP id 46e09a7af769-7c0df77a096mr342781a34.22.1759856358609;
        Tue, 07 Oct 2025 09:59:18 -0700 (PDT)
Received: from localhost ([95.173.217.66])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-64e7239428fsm1899552eaf.1.2025.10.07.09.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 09:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 17:59:07 +0100
Message-Id: <DDC90D8L4IHQ.6UEP0Y7BX689@gmail.com>
Cc: <jwcart2@gmail.com>, <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v5] seunshare: fix the frail tmpdir cleanup
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ7536Z8DpOV6nRD-hkmddGLJa0uQ=9yB=tiqXMO7Bu5pQ@mail.gmail.com>

> Also, to be clear, "should be the only ones using the tmpdir above" is
> not a safe assumption against the user spawning a detached process
> that can try to create symlinks in parallel with the recursive
> removal, but that should be mitigated by your rm_rf implementation
> IIUC.

Yes, sorry I forgot to update the commit message.
Rahul
