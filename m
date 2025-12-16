Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4433A6E6
	for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878960; cv=none; b=mbfT1aWdFNzv2K05toEP7xxJXBP7ljoW7bAJwToclSUWPT6gkQYEUmNgWiZkDunrSpfUXQAPVJ2eQGrWLAfwo/xPubGIvrufeRUUT3srNsHoAIiF0RIh6JWKdZoXybvf9sfEfyx8ahQAEDPW82NA7BCYcu+tq40ItixnOQfZmrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878960; c=relaxed/simple;
	bh=v6qSPbazIbEay7EXZFe9DGCkiumHopuzf+llzVeMCzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HLbVi6IeL2Eb9AFQr3Hm/aLmscP5HHs4xwrvO9MbA8iFdT6/+p82nMC2/4DBBQOJoqyc2Yz23L9nT1UiKFzed7/COc0ul+nt4tkbH9IgwFbl5E0fVMJeR1J4LFg60Hl1gBgFLZqeagynzuJDbaEjD90koJOTJHl7xHgGYTLNROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dLc9yK9m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dLc9yK9m"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso33290255e9.2
        for <selinux@vger.kernel.org>; Tue, 16 Dec 2025 01:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765878955; x=1766483755; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6qSPbazIbEay7EXZFe9DGCkiumHopuzf+llzVeMCzA=;
        b=dLc9yK9mQHt/plAosleuRsuPIQJQKLBw71xTvsI0hklvzVOh0B55xZP66xkalolGQh
         8ihDWmxT68hAq7vSYiIftMw2ZhMoUgXu6QbOCz18N+M/n6Kj+wu+yCVCwxypa4oVJdi3
         WLUWp26UOEB1QX81bnXypdND7vlUVU11mi91zXHBLlGCbYyFLg04t6mQbM9Wk6joB7c/
         /428t46GpcCSUL46BmQtKiLYAT4jDnQhSp3Yg9j9tucHbjND5obu9HwqBsCA5YhnyvgR
         EgH+ZzvMF14KyqcqP7ZfjNhFDDzhRDKkfhpS4qMSEqsq6fB7fed6bBA6+1ih8XoFCOU4
         EDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765878955; x=1766483755;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6qSPbazIbEay7EXZFe9DGCkiumHopuzf+llzVeMCzA=;
        b=dwjd8gnhuf5lZNdVT0Wj2qnnU2j2Z47rjaYZem0CLeiQ7O2AgkjxDdSqaiu2VX3I2m
         kz8uPUgiiPYf+jCIYOXbvy32cTHVfQAuRjyVWw5m59+/8D8PJcQ24FuvXlFHUdE3cXay
         Lk+QjOa0Jdc/jgR25q6da8n/+Reo9kBkDXUzexxk/B1Z7/mQkkSwxWBxnfKBfqJ5bOV4
         W0dLm9lxLJHk0HNQF1+tdP2WnNwFPpXgkvbnDg6xWCkXeGcs+MH9tEFSH65qcWs89ALZ
         jFvuaGtXUyRsj91amdmnureMiMAraHgvvVtxKdTdXTPs/1MZ27LgTwv4dRGn6euLqn9W
         6fSQ==
X-Gm-Message-State: AOJu0YyXw8SHFqntCz7jQOYC1tU12Nb/ZiwhL0HJycia9ljjHZppk/yl
	7ZP4oM9ZRHGWGkXH1Yj4SAM8zor8oTH1W0EgS6G0bhrGzFGhODzEDypQAIzwZf0c8zAJIgHxEQn
	hVxfveAI=
X-Gm-Gg: AY/fxX7w5vqZjlrP8PR+WK7aqgOBcUlSQXb+p8WUyO/ZDMGX3ELDMLApCUVz0/egtPf
	pbr4FBOwd6CQbH/Q40q6+MN7sGuRgkFr4HrkuEc9GeIcHkoFgrnWjJPe8apip1W6I3ij/1uDhM+
	YbtFx1slcOFTx/D8c9QXaHGPX1yIHxVSxC8Fdap9eQSpPnXVbJ0IU3rLmamsjwV7q9qzxbpOfT0
	l3rexClWmC/E/Sr/DH94bfOa4fPWZzacKq/kvuYGP7iAML1WmYfURQNUdm5SCpkgA281RMIRraR
	5VNrb530rvXHTVZ/yxneIiSeQ2iuv4O1yooH4++DO5lU10f9PUOnFmmkVOQSPC1u2VswfKEL6zW
	4aLXrd8LEwmWbkQ2FUHcPZ1L/mREhcryDDNUSwz4BeInXZ/HXC7gUXC/+u54+aVXPDqW3Vb/2Jh
	99EKT0TLorMzX+iPDptBs=
X-Google-Smtp-Source: AGHT+IHVG/5tLgeX9lKKllhXy4OLKTMjwaMgOmEL5Z/47SH1UmyNaMk7+S+ymlyPRDD4ez9W+Qs8ww==
X-Received: by 2002:a05:600c:1d2a:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-47a8f7039c3mr146487405e9.0.1765878955168;
        Tue, 16 Dec 2025 01:55:55 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430fb078e56sm13668810f8f.21.2025.12.16.01.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 01:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 10:55:54 +0100
Message-Id: <DEZJUGBX3UJT.3NRHNSS55B7I2@suse.com>
Cc: <selinux@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [LTP] [PATCH] ima_selinux: Fix requirements
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251208141321.696537-1-pvorel@suse.cz>
In-Reply-To: <20251208141321.696537-1-pvorel@suse.cz>

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--=20
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

