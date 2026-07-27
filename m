Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D403E5EFD
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187055; cv=none; b=Yl8kX16C2wslw2EqckQwp7xgj5XqaJ2ZyYlOeAepBLrLp++sWJfkk9eZfuMVQ1JleFS6WVtUGpwJ0r1Ptu0SxeRNzrqQEksYjmHHE3xNyMtxn8B5+BJSXSVCNWcQokvG/Wqrzh8PKk3BSaulaIHYiPSDd753gV2wb4RqeGi4Kvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187055; c=relaxed/simple;
	bh=BjFCKW6xM1dcdGXxwBCbkXnJG0K4b+mRruwE4bbzyLM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=h97+XtOlRAsJo23z3VunxCKit7XsBFxwhxU7kUOKLr0EAfjWnXhpR02232PEgRhFuvqkOOou9LzG6x02DbefR7qrneJoQ/VrXr8zQTYzenWbuGeNQlVZbTBYXy8Wml4bibG64+w/w1dLE11AEv4DzVQQZSapAZI4Fis8bEXAGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PlwiI8IS; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PlwiI8IS"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e512a9a6bso171959785a.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785187053; x=1785791853; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hMK1Tnl5b2znZW2CRfc412BmLPfosF2sTUrTddCKPYU=;
        b=PlwiI8ISEpuFnfWQeufcfWs1r4xKXPQo6mDZorW7kLLFIOuId4zuB3+g3vcHxXxqFw
         F9CMGVKRAcyjSBkiqt36lCGVgcoOf24KvPGe/Agl4X0/Pig+h+qzP9BIquYx2aVPs3Ow
         lZFTUIEV74M1Qe8FJKyd+qEopbJU/SzUE5RmDx0pjm9VZ4VTs93OfiVYzC3ipanm0x7x
         Jh7b4CrLf2vz00pj2sA4NNmFY3vH7UxJdWK9+3sFCVyjVo9jljXtdqOh61vwL4SiPcXz
         Nyu27mcUILXieBFdfEgQI60A+5U1C/GH+uNoRFoeq6Kq53bxtAq2pdxoZJiNGIi5j+8L
         Mcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187053; x=1785791853;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMK1Tnl5b2znZW2CRfc412BmLPfosF2sTUrTddCKPYU=;
        b=mg+SNe4cl86jUtyWyjIRIPywGmt7+EaVLVJMhklwrSe7LW+yrsiQRx/IKaYhPOs8ra
         72ElsZeGnlWVvaC177HB80vuSLB/8sV50Hb5SnAE/U0xYveniIRDJMZRML+2of4PD5jG
         yzlOkbvfmpOi90coMeqCLg7kR5EGNTZehHxZBN55BMiW03kXQbbSpz+FPfKEe2kpbYgP
         eUigMxr7jMjrx+MV92fIWsy0o34Az/CA5N9YZf7WL7h+aZfd3+1HiBwhb0ly9FfYWbtm
         oK0fdvnRoVu96tEpvacLpTbG73XcRKo5w8BUBkF20xd010ubQ71XxnnZFPFwdJZ6IPV3
         elcA==
X-Forwarded-Encrypted: i=1; AHgh+RpLyWl7AirSCLufIpBIKwsdLAzoWbJCqeOT6Qm7NnrGxQlOKA25R9qSILzAvy/Xg4OnIL8g64lm@vger.kernel.org
X-Gm-Message-State: AOJu0YzcloRNd+Y3Y6FfNAXumTrpMhhLYwunB7mFQtFuOZ5NaVaYP27y
	MufmFVlpAQKTJ5v1OQeanpPXSKQJp6unkOpMs6f4B+cEbGUYqyxoYSEGW/G5OMzTww==
X-Gm-Gg: AR+sD11B58892JP9uyQimPoORsd5NoSf91iFU/7lIBZwUl2CYZSSSiZ0kmiIWWIn30F
	WxPHkhdhM6sQgvpK7V1wq5z/Wm/e5NQbtt9bqXpSXZepEARoigOd8r1aIa35996nJweW0L2/Jx1
	o4GxotnY3mKe53x+FARCn8NPT2ewQHhySKzWbeIr+C0TQcLB1MEVfYWV1T0u1T5puGmSSU2gvdY
	LftMqcLJXuht4QhR7jaQfbNRALCpbq5YvdQUw/duFgnXEaCtR2yRed9zFHF1HtNJTieCyULUZrP
	dZD9NREYfqnDqEaBqrxkZgVLAIw+DHmOi2rQNr8fm4iGf+Sb5XmAqvydnQ/Att8CvRdIYlPT+51
	pQ4V3/IMk7hqJ1ZDwoEjZAplhZbF8MpCEmTb1la2rzFZLLKr13nfzzUkY6ntcYNHXVbhu13DfPp
	FFkWd7bPbM2dCmQalIX9xCO1tzid+XKAR2cWoCsjAwy193jitxFN67mzW4WQ==
X-Received: by 2002:a05:620a:4713:b0:92e:73fc:154c with SMTP id af79cd13be357-932fe27c486mr104485185a.7.1785187052679;
        Mon, 27 Jul 2026 14:17:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de515602sm697965885a.2.2026.07.27.14.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:17:31 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:17:30 -0400
Message-ID: <ff870cc3a6c0bdd9b0f8176b0e03afba@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260727_1648/pstg-lib:20260727_1105/pstg-pwork:20260727_1648
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] selinux: validate constraint expression attr and op at  load time
References: <20260727144439.6270-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260727144439.6270-1-stephen.smalley.work@gmail.com>

On Jul 27, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> read_cons_helper() validates the expression type and stack depth
> of each constraint node but leaves e->attr and e->op unchecked,
> so a policy with an invalid operator or attribute value is
> accepted at load and only detected when the constraint is evaluated.
> constraint_expr_eval() handles such unrecognized cases with BUG()
> so the first permission check that reaches such a node oopses in
> the context of the checking process or panics with panic_on_oops.
> 
> Reject these expresssions when the policy is loaded, matching what
> the libsepol validator already does.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 35 ++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Merged into selinux/dev, thanks.

--
paul-moore.com
