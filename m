Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F598763FD
	for <selinux@vger.kernel.org>; Thu,  4 Apr 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263119; cv=none; b=QA/sYoivzVt7DChDlESqp2OzVJvBhuzqJCXClaEiWbgf/hYSq8a8sW7BOV/SB6JFDv4BhL1AENQD5cobRraVMPdAP1F77L511cKJ6Q4PULAW6iJ+STCBLVr/DcRh9CPNVkPZNndOLNHOlmdWDsBGCuOnfyh07ENboVJOJ9N+A5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263119; c=relaxed/simple;
	bh=Kt+a7KP4YuLI232695cT2koS4lSJOEpJmBLk++N1oEA=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=uW0jo1dijpF5Lwi9GpzuYd0fKvbyURlWmtaShgfo1m+cUZsQeWr6HDpEGd8sYlv0nGUNb9oz9kP/3SbJIYLrxfJk4h8EYMcATJA4mZ4pc0QrLWAJUrokNR6HTJ0H1VDa3bKH9jlfkR2RcmA0KZYuT21ZhOKz/TKQI56tYCvW5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PKFdlnqu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PKFdlnqu"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430a25ed4e7so8226661cf.0
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2024 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712263116; x=1712867916; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IJ/NA77srV9WcwNy1jrRxiIjXCG+fGyfe1SHGcwnkW8=;
        b=PKFdlnquu02Z3zQEWAGSlMorrPcWzgyAdIDJglf9Q7U6ToM+/XUn/aa0sMv0xd/INI
         LW8x5OesgCWv3PMxrg/SxkTbAgmBLR8MyNotDUbUhtaRAIYFVrF3VrbpdiHQMF1OYQR0
         OJsBmXgJA6ynwONYzsUGabDQzGsrt8x1VKvG8GpLYvNEDEnkUxNH+i93ogtB0jZ22lf/
         dsqI2+g2rOcplY6D5ZvKVtoG4Ocv/HEP08a9g46NesFiz3VsQRX4VP6T8IQVlejT80oP
         dph4zoIQdKdhA0cFocZJuaAN89G2jcFK5YKYJyKok+O5Ns4cTXUA5WMByZwO6ctWGBAh
         LlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263116; x=1712867916;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJ/NA77srV9WcwNy1jrRxiIjXCG+fGyfe1SHGcwnkW8=;
        b=thkdPOj8UK6XjTxEkhMFW5AsnPmxN1iJQ1Thy5zAh/5BpFHolaBeMxJbk8eKa9dj3t
         xPsRbiR8kc66OcxUrNjSQ0UK/tKbpk1DwYvyCa74nURg9oWKTCd7k5u2wG+zPRW7jCKD
         FSOwMviUTfk2oGJyqjY3lRnJ0Xd5vHWGtl5BoFwhVatbDquckfQhfGGNRBdmOdyHZuB3
         UlJZPrSUkBGdQi7cLLTwCoG6PTCMQ8q/Jp5xmjknbiSjfbR4bXhiEADj5GzJc6DcHHSn
         78S1kzcofvvI6JRyJ2Vw9VokrhqiwQgpmUmtASNErsUkNkuFDSGMvH8pb6OyssskOD3U
         DB8g==
X-Gm-Message-State: AOJu0YyyoBWxm6NnfTkg+syFpxadISlo+VoIw5aLKt6whHs46LQDxYm5
	PcBLFez7zyeQyiboyFQaHhUcNGMXORWvND9nBjYG+OdWCe/2rIHwaN40a6NtSg==
X-Google-Smtp-Source: AGHT+IHOnJ4PYaM+Fflxdefz8VXngJscu4bg29joNsIBMd0PqrzbSN2zn/5e2SVJFndcZetWCPV4uw==
X-Received: by 2002:a05:6214:487:b0:699:12d7:bc91 with SMTP id pt7-20020a056214048700b0069912d7bc91mr4318243qvb.29.1712263116441;
        Thu, 04 Apr 2024 13:38:36 -0700 (PDT)
Received: from localhost ([136.226.84.189])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cfb42000000b006993cbb1ab4sm42650qvq.117.2024.04.04.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:38:35 -0700 (PDT)
Date: Thu, 04 Apr 2024 16:38:35 -0400
Message-ID: <1bf08f31513935dc011115e0ab912818@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] selinux: clarify return code in  filename_trans_read_helper_compat()
References: <20240404151619.868283-1-omosnace@redhat.com>
In-Reply-To: <20240404151619.868283-1-omosnace@redhat.com>

On Apr  4, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> For the "conflicting/duplicate rules" branch in
> filename_trans_read_helper_compat() the Smatch static checker reports:
> 
>     security/selinux/ss/policydb.c:1953 filename_trans_read_helper_compat()
>     warn: missing error code 'rc'
> 
> While the value of rc will already always be zero here, it is not
> obvious that it's the case and that it's the intended return value
> (Smatch expects rc to be assigned within 5 lines from the goto).
> Therefore, add an explicit assignment just before the goto to make the
> intent more clear and the code less error-prone.
> 
> Fixes: c3a276111ea2 ("selinux: optimize storage of filename transitions")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/selinux/722b90c4-1f4b-42ff-a6c2-108ea262bd10@moroto.mountain/
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 1 +
>  1 file changed, 1 insertion(+)

As this really only impacts static analysis I don't think this rises to
the level of warranting a stable tag so I'm going to merge this via the
selinux/dev branch.  Thanks everyone!

--
paul-moore.com
