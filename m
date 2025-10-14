Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CD30E0E1
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483582; cv=none; b=Sro2kIkFmnk78G4/7lQmHTlGippCvWeZs3a1myN5YvPeYP3WdJRHRSQGuA2xIUy/bVpIjCDVCMFukoVlWSACmWXcZjPoh+MWRmzdeS/n6sT+ph/0fG83pF1IP9mgcDc6Ggz1H7uNVRBVbSDDqyV82glKH20KOAnT8KFLc2Kq0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483582; c=relaxed/simple;
	bh=2OjZR0xIzGES+vVHimuhr1zX3QGgjQKBqN8vzmD73Qs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=nwkjWAoBHG/bZYdeNYAzn/vIwoYt0O4XZzERMhT5A/hLgS8lQqxCRRQXjOKp4qMO7tjCW/6W0coqh3M2sBOdPWB9fu3d8km9XOl9qlyDhQFxRrJ5cEn/6uJGLKAA8YiSaQTT/SgmT1t3jrubGB8xfAAZkvHRe6tlLrvLhmMNnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WMyFQcnO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WMyFQcnO"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7f7835f4478so58988486d6.1
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483579; x=1761088379; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtW7xGM0A0i7bPQL5H3HW6xoKoQmcrde+jRMi+evfuc=;
        b=WMyFQcnOAdB/+dSch4ZN4hT3y02F1Jxkg6407M2HSVC6sCpMjABchEszuEZXFkOjZv
         AcZMRdb3M0pJPorj69ymuxVr+f9TiowBWhxn428bmBRA8pxgRP5uCBWj2tHRmvgt0Yc5
         cls1grSuL3az3zgt/ouDRbQ088bZabq+Nn8wyJliCUpl4KpTpMG/8UnBDYE55dmOUac8
         GulLGa6WPgFfbLG3S66PPcuUwyu5RnSP5pHlg0W5nmQBrABhvVUGqJNYctvzFJTDS0Am
         QIOXzeeZdqujE6G/ixfdRe0VHk/aVeh6YtXTsvHix9+m7LLnBKyHjuY5Amr1KOfgQd5T
         zqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483579; x=1761088379;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mtW7xGM0A0i7bPQL5H3HW6xoKoQmcrde+jRMi+evfuc=;
        b=Y7Hs+abfSehSLdBP4VvgF1iKKIR6d65Scmr6YnmcpIJ3QLWVbKwS12DZKU0DuwBKHP
         4XWzlN9bVPmneFH6rSWt8sl+3/GZhB/Us2NUEsAPGFVphdUXVp/pBZl1QAfNaKzWnhG5
         xIFXpgHphENYT/NmiFuYKH3BfRPGeoglO+5ioyaa4rmKWxh24jm9b+2CC4VhHhbrhApt
         4dbFdPFj1V57OBn8EZfhKgE6SChloTQ8m9rRyvHA272zIeKeYEdO8gHr2BbbjO1QtApB
         GzA7QK3lwHjhB90jdO2l87mWVipRsTm4NSzfA1bAzuQPAFBpi/KKihditwpvDD/RrThY
         9JjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXokjtzpus8j1E71kQk/3zzDnmS5EW6ZKc3Xl8T+mDr5IglhmqVXgfkjBVmD+/Ym+VrFwjLvtaN@vger.kernel.org
X-Gm-Message-State: AOJu0YxbX5YcRgWZ5JMs6fPkMPPhJaPjYfRpJ3j0PlE/T30yluTpfeUJ
	ZJpLenFhcaQ7K1NqIVVCu+1sZqAzaQXY/RT0rKhEgWG1jQMySX2Rse/pP4l7DWFkIWJNhn92oT3
	cxvbU8A==
X-Gm-Gg: ASbGncvQ0mveGmsJuAPAQfIQPCoGcrr7Hyqw23dHk74oLUdyNe8AUBTrGl/wWkbRR81
	bjwAIyd+mhgKBtK+Gi7O3hQEz4ovdTlXMkisfofFma2dK4+esv5nMo1+NtTqHc7mOCHwlYfQB5S
	HBlwHZikKar3jvSRKP+RKyOh6LXGwlsO+jfG9MHHTfQhVN57qNSz42J9K2ZcOwRmRNhk4K3wUpb
	yuP94Hj2Wgt/TzvWYL89YUVaDUcE7IBuLseUnluNhU2cy6F4DeI0878rzFQQzOVSSDkGQGvRgaP
	JtEAJECwXbMalkqI2V1cLXh79AUROXns9GPtlHaXURuu/RB4zyL5EfOi3JrpAcXf+pxbV+OP+xC
	Q+QTYQQwxLF/8lNwWot8UAEiH3ZDyugLpqP+91mWT19dIFrMXMda2pzvaZldGHnXFLCzoNDOQ+Q
	+2j/W1rUb47e5BQLBhMXybUw==
X-Google-Smtp-Source: AGHT+IEptTo2pxg8BQyRH/EAXGF7Ajlrs/OC3K7xB2VEK00ORspclexLASyXzj0clJy3+lke8DpgeA==
X-Received: by 2002:a05:622a:4814:b0:4b5:dc7c:a6ef with SMTP id d75a77b69052e-4e6ead57ffcmr362320031cf.50.1760483578960;
        Tue, 14 Oct 2025 16:12:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e885f1bf3dsm517031cf.24.2025.10.14.16.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:57 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:57 -0400
Message-ID: <3559abfc0d5ceb11f03451aab517c8d2@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 11/15] LSM: Infrastructure management of the mnt_opts  security blob
References: <20250621171851.5869-12-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-12-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the mnt_opts->security blob out of the
> individual security modules and into the security
> infrastructure. Blobs are still allocated within the modules
> as they are only required when mount options are present.
> The modules tell the infrastructure how much space is required,
> and the space is allocated if needed. Modules can no longer
> count on the presence of a blob implying that mount options
> specific to that module are present, so flags are added
> to the module specific blobs to indicate that this module
> has options.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c        | 14 ++++-----
>  security/selinux/hooks.c   | 58 +++++++++++++++++++++++-------------
>  security/smack/smack_lsm.c | 61 ++++++++++++++++++++++++++------------
>  3 files changed, 85 insertions(+), 48 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com
