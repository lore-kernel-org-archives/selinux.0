Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3874B1E7B
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775763; cv=none; b=oEp2IAMda+PIbizQHyLAj4akCh+krMfXLMn1uYLNKdZdmsDFqdIxluVRmQ0RYvDeY0vtiHf4nu4nDI+7872SCNbNNtV5dzviuegtb/Q8XjFO4bgZDYeh03vIdaDqChDjflc96mGOfN5oLEsr92Gi92+eAeOtp8v97TIlXi+u3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775763; c=relaxed/simple;
	bh=PokIbil+4vzb3IM+d56Xpj4Mvgib+ySxP9q4ulJxR48=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=f0xGbDxtfrpYdCzVgUJI3ohxAYhAnXigee0ywa8nQQsd/o9WIVEqFmvB4NRPphNKOBOIRlXDHuOJzzDnSanNucgcVYsOz//5Z776f2pVMNqyPIzxQlMqqpRh/nt9kyuMBaHFZW7rwnkLYGt6942ivAip1B+u94qNnmYcdPEIhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SATGsQUV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SATGsQUV"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f8c0c8da93so63438526d6.0
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747775760; x=1748380560; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Vcim2IrvThidRodNsg/OfOdq2fd5gLucgy52LkkAJU=;
        b=SATGsQUVNCcWA5EQ2sN31YQi0KcO0OMgg67xcYs16ITaMOe6Op0u1D+gq7ILTSB/DL
         FQdpiltkvmAEgWIanzWiNeydwbuD0aYpWwjtKgHSWO2+a1IMCM/L2d/EDsMDVqiR/t2A
         Dr4vo7CV/Fw3dsrFiU//gjBLuMSUaBhq8lVdNQAtdZY1PTDlbLXocFdQ0S6bxFniWug3
         JssnaOmXDTxnsZ7//pEfNyN7VOKN1Tmeke8pl+mCHHEZ5Qa9IcHIRRtY9bPIi/qbv8Zm
         XyXzgURy4XykbyrKYNDGCVpAz3iq+XNE3u0910/h/s0G2OWeoqOMatHPvm/cFMZvW8ps
         LJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775760; x=1748380560;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Vcim2IrvThidRodNsg/OfOdq2fd5gLucgy52LkkAJU=;
        b=fJSFKf2VRZ2M9Nc8NbvIJ00S90mHEtYS3uK53qHCETyYnk11Ewknt6M1nsd9AXd8It
         qbjRzeqLMtSPDhSMpec0+0ZE5IJvU9QAa3HJI2pGhWKGHCCDkvRsWThGf6/7BrWwQL/w
         /F7McDi43rS7gp5bflTGXQmthkbO0SWORxItDVXUYU3gmPW88NXL2MwSVeiSknnkidR/
         1GaJ8gQbbVSvMY1kROO4gJ/ncxi/+oeUlLLFsgvxl33qt2zxNV5kk3tiTTIcNkoV7nCS
         a+1pgKAcsBqXwo8AFQVHlheZX9jZg2UymZjsletcia5rD8kgkIO7a8mV/8gmOroFhiBO
         Xx7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZG1M9RzZ3lpacZdRIXscoYEWjCH6G4fU9BckmVt180ERhCkuqXJZhuhmySU79v+5ivPsNX19l@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRpqPZvp5cqHTwAuwHO+mx3b2kyL86qnDE8iMVob0qZ0OV3+u
	ARvEBd4M+q6kufCO5eFEjzlshrXH2x9/7n42+tp8WIbf0LTY5s/HYjCND+P5jP0dGQ==
X-Gm-Gg: ASbGncsaKU6WXy0YEYEfw/sGPKsyOt6+1icOGfne3CSEHDOcH6VrIuvmPH8Izurhzm+
	5o2Z2s6CcAi1BKeU76798nEzjHMjU3KaI1zrXUMHJAPIpI74Xv52G6Vv1/8U4rGmsXfTpVEQA+X
	GQLaSwv3/3qDg2VDlAmlDofZEHPAzGTAFoKXWfWM0o6rBZ8jSua5u6YoLAYexrtIJH1gAtE+fTt
	hfEuHM4Rm7AFws0S62ZHGU+gUqYZ7vVRlDZo9VJzY4CPORGX0PreqP0prCpq3CJ/O+tDKDpPD+W
	oJBEc16nSYXTMYd7jR3WwSNp17uANUREnKMWrHWlQN3vpzjHvFnRVprL6VMZIWWfa7sm+qK1nM0
	tU/qx90Ydcj1SDP7n/z0HXLFs049AzkY=
X-Google-Smtp-Source: AGHT+IGXRcWfO4AHv0ErYu9MQe8pxWB5OkTwD4jggVmmRyicMFT0cpUlaxE7iaZV/7atuSeHLh1gYg==
X-Received: by 2002:ad4:5e8f:0:b0:6d8:a8e1:b57b with SMTP id 6a1803df08f44-6f8b0873ba6mr330435226d6.36.1747775760552;
        Tue, 20 May 2025 14:16:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0883b93sm76456226d6.14.2025.05.20.14.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 14:15:59 -0700 (PDT)
Date: Tue, 20 May 2025 17:15:59 -0400
Message-ID: <eb68761b5a2d53702f4d6b80fe2a6457@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250520_1533/pstg-lib:20250520_1521/pstg-pwork:20250520_1533
From: Paul Moore <paul@paul-moore.com>
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, maco@android.com, joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com, surenb@google.com, omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, hridya@google.com
Cc: smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to  binder
References: <20250417002005.2306284-2-dualli@chromium.org>
In-Reply-To: <20250417002005.2306284-2-dualli@chromium.org>

On Apr 16, 2025 Li Li <dualli@chromium.org> wrote:
> 
> Introduce a new permission "setup_report" to the "binder" class.
> This persmission controls the ability to set up the binder generic
> netlink driver to report certain binder transactions.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  include/linux/lsm_hook_defs.h       |  1 +
>  include/linux/security.h            |  6 ++++++
>  security/security.c                 | 13 +++++++++++++
>  security/selinux/hooks.c            |  7 +++++++
>  security/selinux/include/classmap.h |  3 ++-
>  5 files changed, 29 insertions(+), 1 deletion(-)

When possible, it is helpful to include at least one caller in the patch
which adds a new LSM hook as it helps put the hook in context.  With that
in mind, I think it would be best to reorder this patchset so that patch
2/3 comes first and this patch comes second, with this patch including
the change to binder_nl_report_setup_doit() which adds the call to the
new LSM hook.

--
paul-moore.com
