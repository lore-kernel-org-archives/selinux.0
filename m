Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E7EEC0
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935274; cv=none; b=gXgtttB+8zSFgIMh6qllh9apwM+HOcLjOgpFTfslP4EsId3FXU4ixpt7mXET4uu3JOQu7rWlVvLilJKs82xhhKV+SS7LVn5lf0jKhm9LFiHUuWBf5DeZnDdsguw02SS4ucoV8ef2nrUtIUKiujObleSQjmhKkIf+D+HRB3bXD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935274; c=relaxed/simple;
	bh=7WJImz9TidKHGvUeTY65mrBSQ5yIq8ad7Mzg2NOvLNw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HzX50ODpQVHyqCLbi6d+bEIFODcRLznco6IZbfggSdGgFtlGGfgWD4IsHS4JBtI0qoAXhmudQivMOuBUwsPMGr0sjuLjJcj6JKC7umTNQI8tzSPNAT2CHE3n9HDWuOpkshH5Lm+zhKKucvDSyU57o5oaTb69hW9P/cQCrmFm6HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fvIH1DdT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fvIH1DdT"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b3289ed834so5043161cf.1
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756935272; x=1757540072; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUOHPggJTbZcWFdIxJ2VoJN81Vz1QNZcrxqigDA6AC8=;
        b=fvIH1DdTom5I1hqG3JLj/JgQ97Kjcw6qMvVnG/PcSLeO8n03TJDn8Kbr90bu3dqod7
         PKaA0B/61u0vWSQSVyTDYWPKg3lbf1UKTxa0ODoI/HmajZetwU5jIt5ASpCLhAQIshtg
         iKcIGS0bKQni3fCKm2aAYw3bGasosbzap4NE9T0TVOddO9sDYuRTi4V1ZDE0zR+Sh+Xy
         9djrI/AuYhdHqJZFTVg2hkaDEKq8wXkbdcSsXy4y4Dq6whZa9BlVwMkYC93stNea6rzv
         ZhsOkoUvLUKAMJm8lSshMRa0e/bwhiyvhrBUKvqKRym2qObNS8nIVq+O+JeTye1CGGD5
         6c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756935272; x=1757540072;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zUOHPggJTbZcWFdIxJ2VoJN81Vz1QNZcrxqigDA6AC8=;
        b=cUa2F/SpMbZpvgl1rrT7/AS0ZTji+L5tLj9XACekPZB7hxAvrp1QTvhbMG3+EUJmoX
         Zkj6CEadrQs33auTsLol6gGTUo0vKF9ZRFCNp3iR5/0ddFCeVBQlifK0StJevv42Zdlt
         jHHis0oDo8S+Nk7ny9yM4LgZzz3KSPqQFDoBwRAKkttRyDOh5fAOqbaoDmmg1fTJUDrX
         GTXKYYfIXl6tYIvxIyx/xnmq3ZhGe4E/8y6moEebZAC+u6AYy23HvADXhX22btQwSBA3
         s9JLGLpIYFHwxFA1Gya+d79RR0qAqO7aOagRyulZYiVv/+6IC9qZVrQ+GCTWns9XwDQs
         vUqg==
X-Forwarded-Encrypted: i=1; AJvYcCXQe/CwHP0sRki4F+8/bquj/lUePSSUvBdYZYzzI++G0TjhAkVPMaSxtLC291iJj3RbEDSjDHsA@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWyM3NF3pN4M9Pshjr8ppXeMXcLD2MiJvqGR//FE+BxmMg7z3
	cKF++kaFTN61F5fZ1gEwktFaQMYb6Kmd9iURo6aqQcVS2Yqx/Gf+Cv1aQr2ccZQ2UA==
X-Gm-Gg: ASbGncttWq9myYhJXCRuTnZpvCpSAAqLEHSTJ/r3ZjCxqyaenrJdqLDcbLiLBS/W8zm
	0M/8KV1sKjU1qGs/LyM/oIERIoqWgdaYsxHI4OuINOxy6AtisjDFh4ro/5gnHvDhNgyBW8CrkFg
	IQ4k2EA3a3O9worcXO58k7CY6o0p71i+bA4V85koiujAaXsZsFCTzz3vJ4tMay/NNa4rrjtFB/P
	MxvktDk5uv0Fo4m+pPi5dlgJCAa3fvjiQk0+iGDh+6S2VzHdUjBur/lF5P88lVteYLktMJuOgBW
	D9h9EbWAn/qD1xX6cDswErb0qfKEpL5aAPIY5CCuzt5y+BN34q2CAacetwXShaRXG2zyuUrSCXN
	yKFFCtefIOJ0+m9JLoL3JC4r1I5CySaGACHh3HQ72CbIwfJMx1tVRLFWagBJt1z6Ek3mN
X-Google-Smtp-Source: AGHT+IEKurkFqRR3+bH6FURY66tQT5pnDG1M4Qzek8x5qHXfMgyZOI0nAVG0j3pwkcq3Z4/1s3SeYA==
X-Received: by 2002:a05:622a:5a08:b0:4ae:6ac1:f497 with SMTP id d75a77b69052e-4b31d86c67bmr233478901cf.32.1756935271665;
        Wed, 03 Sep 2025 14:34:31 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-720ad2cbc78sm35394836d6.23.2025.09.03.14.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:34:30 -0700 (PDT)
Date: Wed, 03 Sep 2025 17:34:30 -0400
Message-ID: <7a43143969582eb131cc42abd699913c@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250903_1645/pstg-lib:20250903_1606/pstg-pwork:20250903_1645
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, willy@infradead.org, vishal.moola@gmail.com, david@redhat.com, mst@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] selinux: fix sel_read_bool() allocation and error  handling
References: <20250902131107.13509-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250902131107.13509-2-stephen.smalley.work@gmail.com>

On Sep  2, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Switch sel_read_bool() from using get_zeroed_page() and free_page()
> to a stack-allocated buffer. This also fixes a memory leak in the
> error path when security_get_bool_value() returns an error.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/selinuxfs.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com
