Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818303D3D16
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110995; cv=none; b=NlOlS8pyMQscje6q8O7ldWoKxKRjS9ZMGjZdWnMzG3Yyt5Pei+rg8Idtb0DBFnrDnHqxrl3uqglNNssrGpsD5b9hYfCjz5g5nsVuVAme1ZTOnNaSD1xG289ss6MALxmPD4RrsqDJ0S3HNIU3LY7IpiIIJRMB1+L7tJ09HZAWEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110995; c=relaxed/simple;
	bh=+S9zrCJYs/9f7l3BaRMX+DP8uWQlVtTCBvddDy6WyUM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cumzU/9lEgtyzfNwlcpNO11GZXbvNg4JPj+0lfBSJc5nSo/woPzUbPjUqOb9ZeuhIvF8y0+bjRfm4Ogb4u48aDiP7vayxBM5wwDJ1RLQMxqq9iksjLgpUbShFkp67c7LCWYdIb3E3aJv/2bPz3+mfG5KPBglPRkOmoHCIsmDrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SLusAQJ0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SLusAQJ0"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8eea23d01f7so40410285a.0
        for <selinux@vger.kernel.org>; Wed, 06 May 2026 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778110993; x=1778715793; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG8GfLbGhpN8bHogNWyNBVoLJ9lE2S8KcJnQM7+gDj0=;
        b=SLusAQJ0wY1wgbJsstjR6qbyDo9WpCJGM9c4PKR3CQV5EhiBY8trtwLh+vozThD4Ro
         5tz4fdaLg6wQk4oQfoTmx2SwAXPglg0j02y4KLWBVF6lXLjWuE1lQx9LaccRBapVEhUX
         rd08KhMYBBho+DGiUrOvLw5qoBABilWxMz//gMSaFOgjwW0hC6J4iJadt2rThz8d+XQM
         i4IWJkO89K12F3i5aHOF3tvLKpPmMUOg9vCQjmrEMcVb+JgJhl4tlalgFZer/W0RAZqT
         s+4fpvKW1Po8Xmq3dosr1rsVFrIYJIpTd5WKCGccUtdngQGadqk8wQZcTDnwihLkgurO
         M3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110993; x=1778715793;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG8GfLbGhpN8bHogNWyNBVoLJ9lE2S8KcJnQM7+gDj0=;
        b=GhL25NHp8/ysuNQ8aK/SwgjBKkiVpm45CpV55LKEqflZ5/Y7FtZjlbXZJmZj6SumNt
         QppcdgaACsiJZR0hLQJG0cb/A/qicKsOei+mRhLgMB4xjVsuHaAshR3xzRE/Pt0d/zoR
         wiZzduARsRxrCyvVc6EubHvjYrBrO3cjXn3Wfl+NwQDIbnCTcnUiMI+5NQZttjpMCeA+
         kMj2Slbqj8i4XAHZVIzUpduQrwiH8k2XIIpYVC0VMHVd5PFzlRLnHinKBXtLvJRYMIaG
         7L59++oNK27MbNZa6BiMsKPwQhQCrDEV2Wj0wPDfaNCmyM50Y+AsrntFcWlEemXbdDvO
         ZUCA==
X-Forwarded-Encrypted: i=1; AFNElJ8X7w+q1Vic1ygbNb1Hoyu3a4AaghklP8yA78SxSiikAnREX2JwBaiVj2EKrtOhQq2SRzcHkMrv@vger.kernel.org
X-Gm-Message-State: AOJu0YygcdgLFzfI8Xo0YM4OapG2DsA/WeiDhlGU3TDBxDy/Va4yRGh3
	f+MLcjyEqHtPVLI70vC6XpmzftVqxy+I6dKA75hQuIEWkKhGbPSDnG1srGBxIR5Vjg==
X-Gm-Gg: AeBDiesB3obWO05ebjOJwnGFbcwjron+FbAx+eH58dK3NFkjC2C4d6Gc4GZAdbSHrK3
	4cAwbdLud9MMMAtCq81zyZUfT2SeTXOabIK4IM70laEd8PoOETC7cAELYjVSxcnlS8yaqj9h5OH
	xLjNFj+tMg3w7/o16vUbsb3NkXcl8Xy2DkEPsVQvyiYLpl1B/yKrQZ+55Y8RJYhBNJcOgByAtcF
	dFo0lUSHEvcDiMcWBHNkn0FaeTMeFUSsRfv5EazWuvYaKOiFLlFRasBuf3tlA6VWWoeG8Mn2FEs
	QdI/7AjIwNdDrJylEoAkIebBACOd/Nhyj7gV9g/KJHHf+5LbWzl4+TG1se9VrA92a3IG+l9YS3o
	2eYSMBEqz/RaQZmXWgDi6IgImbHA5/4V1PUclHpCt7lVAEVIe1RiCpVWgq+xTrM9Y3eHWyLzJRM
	tGlPpVPCBeZdJKb5DeExjsaMfFwAkUblejM3OIe1+zJevQbA56MQ1QcMylC0BsppjsupBHw/vqc
	Y60tPU=
X-Received: by 2002:a05:620a:280b:b0:8eb:92a5:5c65 with SMTP id af79cd13be357-904d61eb266mr846637085a.40.1778110993495;
        Wed, 06 May 2026 16:43:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c34a0d4sm1735064685a.25.2026.05.06.16.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:43:12 -0700 (PDT)
Date: Wed, 06 May 2026 19:43:10 -0400
Message-ID: <0dbd3dfdca1c35be4be345909ab0eeab@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260506_1600/pstg-lib:20260506_1556/pstg-pwork:20260506_1600
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/14] selinux: reorder policydb_index()
References: <20250511173055.406906-8-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-8-cgoettsche@seltendoof.de>

On May 11, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Index as soon as possible to enable isvalid() checks to fail on gaps.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
