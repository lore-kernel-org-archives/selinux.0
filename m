Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347C301716
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483578; cv=none; b=qpLLnRx+REqrZzK0w3tmJgve4sagI7SVWPNY2YEiiaWraAC9gLHtWF8il4I5LJCjhAb35N37uE35eyuEZ4xP4E2v2/1GEZ3KdVTmMOEf1LeNvauFBdtTRdYkiDIt7pGXn4AkCn38Yp/aKx2i0lZgLFxORm7aP90vJ+0x2w9A82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483578; c=relaxed/simple;
	bh=yBSQDIAerL1pP8jBEJSFDm/XqydoQBHKsJlKkV81ReI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=s5kBd7RUu/Sjb7Pz8pRP+QN2x0dJHR+DVetjhVjR3rRUt7TReKDaLYNnyFGBpe0qrDZq/yEwhvqLa6QvFa4m4y6658kVsiA7HWZseiIoXkuZ67TAuSPxwWg7K2yNoLMzXCK1s8wqbepEiqYe4rvhn5VX+UaeXCC+VA2gBIhd4ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N1jMtUhr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N1jMtUhr"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8608f72582eso412238685a.2
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483575; x=1761088375; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3staXW51kCGZsXIYMV8mfgMCQKvW22Nmb5sYckB4owE=;
        b=N1jMtUhrEsoqSqmuUt4dNAp2G91diUd+lxSNjM5PHpqvyt+msQmcGnTt8sMI+PzIB5
         zzCchOTWn2kMn2zqx6sDRH0X9lZEGpQ5gcZta/w8esbx27at03sPyIxE1Dv3vK1URwqf
         3mf9g2dDt3uMI3u3nAQs3WOaKlQgwUVDyR3ZQrzLeSEX9g/ngZI+7sIBub3GNgrYSVDn
         nlHPI0/575JpkkQt7M7qb4IQr+lW/ULVNlN2xjN7wdZ/2WXU48A+FE4NT+qviSkLxz4t
         ubNO21xBE4pteCCm3wm/5/ufpCajLYNUwkKl9lbzFY27+Q15CGDzJvSLvBGO24TuCgSF
         hmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483575; x=1761088375;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3staXW51kCGZsXIYMV8mfgMCQKvW22Nmb5sYckB4owE=;
        b=o7X73idruxV7FQxiH68SHoYzg3Bd3TwTi/x43nBfHPtoydEW7Vg77ceu39Su4SnCSE
         Jsg72zKIm7JSZVg3u7MD574uqSNrinRS6HVxzonzGvqyO5lj/NlZZ9YEU0uJnCW/C46r
         Jl8FWCQRNeBQ4kxBzkMUINcThYtybm6N+D5bH15WqNDk2NkO02JiNtPooKvgkT783ND3
         BXGbQMQ06/fmS2srR4ireFSXfNxP9TSKCtb+7Es9DBX6r3FhVghhWif+nCq5YhQQYFb7
         Y1ANYEiJHyq/cFjqP21LC+V6U7hGilT0oF7LDKwuWe5Ys12CrnVeRijlCj9whfNMJHTY
         0H5w==
X-Forwarded-Encrypted: i=1; AJvYcCUgjgeBxbpb4x+VdG+VSuTfNs54PD4ydr5xfeHnzSOmL0V1wei8/BsBKX8RS1/S+kgSJER8NBsD@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhSq0NdVbM3x9qX8djyuAi7n1wzxiOZjcQySqUEFhG1UmcHUE
	DIlC9D5y2TckPiGEfE3pJXtx90vHn+BQ8F2zNQL0GpL741VeFtQC8EmDvLKC1J1ETw==
X-Gm-Gg: ASbGnctXhKQ7ZnoQt9l+lKABkYSp5Gftm36JGZgoVrc//ZpLpaOzJ8XnDK+1ohE27Qu
	hxY8KYAx4vdH6eA6wfeTw9T7Xfw4Q3v2P56teoorzBxl+LRPvOXDczuBQ8/IPe5NKzgRruOZFyY
	mKV0aNFOxXrfsfOJOIJJjyLnk6SJWQuHtQEnIZ+d/dXk4ZWcbH6KdLqIP58gJOkWEnZiGdHRHkR
	YWTN3ebnn1zoA4jV2QazRHh54f+v5JPg2zuHTPzvr6xUNL7T1SFKz7VlGMx3ToSAQJeGno5cD/O
	DUFGhZ/bnxfnNqjnP19szE6e+QUOb8g0LzBx4o+drtFV6W471XSFYoec7Qeu8V9l6sfQ2iO+vHJ
	0RjIHoG7V7TZmRiiuznjPJDTC9Rydd75HlraFBRei/kAxGa10mOulLa/sokRBZRsQIIkUfzKi3m
	+5c6RAaj5iDSwRsIH5Ubsyng==
X-Google-Smtp-Source: AGHT+IHQuFhiVAIzWYGxERI883rLNluCPfSroNYywP2IoanX/gCv8E91aVZJ/MsGoz8MOXeF3+6hyA==
X-Received: by 2002:a05:622a:1989:b0:4ca:9c53:f1e8 with SMTP id d75a77b69052e-4e6ead793c4mr365706661cf.73.1760483574819;
        Tue, 14 Oct 2025 16:12:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e881d2c71csm7370921cf.43.2025.10.14.16.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:53 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:53 -0400
Message-ID: <b73ddac399f78e46ba753f6bea4fcbb5@paul-moore.com>
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
Subject: Re: [PATCH RFC 9/15] LSM: Add mount opts blob size tracking
References: <20250621171851.5869-10-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-10-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add mount option data to the blob size accounting in anticipation
> of using a shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 1 +
>  security/lsm_init.c        | 2 ++
>  security/selinux/hooks.c   | 1 +
>  security/smack/smack_lsm.c | 1 +
>  4 files changed, 5 insertions(+)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com
