Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96819994F
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305207; cv=none; b=lMI8iHeFzKq5J30eS40kYUkd5VuXLmYMsPQ0c3sfcofeA0kooMUGTP5lqeZl5dbCHKKAjRBuYUIjRnw9DuCGR7i9OxHx94qUgKY9eWIrQlerrgIwOgKkwOcoevu1aGhCKuppW+Ctf5c8EPIlFvWRKXRMEzBgICxORswMT2VObWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305207; c=relaxed/simple;
	bh=kg/oZJ9Hh7esGFqie1eJQ0q3uOex3G6vTcn9GQYIXuc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=qHZmmGgIHUTAxgRoNrnwidy0aHwQGMf7lLOJZ+U2EfkZHO30eMeIjuRFUAkKiK2dcX9dlaFiBwKiPpiHdSPYvDPs4kcdadvM5mTBneb5fi3RBYZOqqqRqyeaYmDlsOh4kofwfuraGy6krN9bpnXne33YbJpUVzH44fOjNYTrB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AYaJf7Bh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AYaJf7Bh"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46783d44db0so155342361cf.1
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305203; x=1736910003; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arepOiqJBhTy8LJBXLbNVTvzMEQrYQ0+bVCvA32Q0h8=;
        b=AYaJf7Bh8ejZ7fkMcJSUrfQbCxyIh0p9QBafR3AY2KSlPWiD2WHKnrmBDaFlAKNkOY
         I6gYk7EZKcGkfyByE9N0SKDl9gHGRCVJ2LPxNXcuXLJHwZqGVA9LbowDdA6sPizwXncu
         msBuB7uTaVNcRJP7s6vMjaAgnnnaQrq8awmRNTSjJfcR+BvNz1R17Y8eaWDkOm3SA7zN
         VEYLqih2XwWbQfWvLwEfZfUoai/e+XOQPp8TEwGg0Pq83Ja7j92Mq54Z/JgZ34WbyvfF
         zgT15m9mhPTLCylqPdjhp5LB2jQ7P4LNBRqGxpeXKNhduaJEHfgmhOYlJxfr3aT8dNuA
         NUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305203; x=1736910003;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=arepOiqJBhTy8LJBXLbNVTvzMEQrYQ0+bVCvA32Q0h8=;
        b=hG+6VBEXbAXd0W3hNNLivVppEZYlxTv783YZzjk3H3+9wcrpA/MZZR6CmlZ9BEouxo
         n6/1gQL0ws1TqImiyOli8oqRbAeZ+5/c7PqBTXUEOsRrV6BnF27FdIfzZxvJi8UlScyn
         YFV6TbzTEqV1JqCNr7gPR5+E8I9jbcRmHfuoGeWUdMhMuh/35bUdFJV+0LkE5lT0ELjB
         fz4jgGm06dToqcDuyRHbxP8PppoF6/VWO32M6Rq9AKs0DC6v5UBrqh1XPkmHJPEhCQgw
         y1hj0/2gSMrqEgRuXuDuMh407npXt2PJ3d2RVWNzrG/rzjZQMjAMUHOw3HUAlp5sfxmm
         Dy8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/bBeTAOzwgvCMWt4EQrEkjq4OYveDIEqUokgswwUEt8e2QuUA2PdipgonzSokgBXtLiz4oT23@vger.kernel.org
X-Gm-Message-State: AOJu0YyfeqXE2hfb+4QwMgp8X0yMqvN90HlmoDnmHBi3NB6PLGxHLlPd
	CwAhFLEvqQ0D1LzOu9zuWMbkymHN6xUxyjlJa3CtULemzEc4GPwY0Lx9fGylFg==
X-Gm-Gg: ASbGncsEzOMkdU2gaRuKtCffuc/YlwgGCd3xnlneHuj3R+JH7Js6IHa2qKytuD48W+8
	F3JZM7GLcfOkJpoka5Xpt0V7GPgBMBHbvE0LfAngCRLXItTK19IhnozfHiEDpVRJR2jL+0GrdYT
	jR7lTumfJorNIvv8uDTFVUwtmX4HWxzbVC4UJf8R5sfbtr6ZP1lUhWqKFgPbUDcwq56QJ+rZfwV
	GbPq9HwksQAE+Jj+aGPVA94U1hWDK/iUlwHxmAAR/rQ+i9+S2Q=
X-Google-Smtp-Source: AGHT+IG2V4LdZ1+ix3UVm8fGy1Wny0zEJRa4xmmG4X0BNNqJo5+iK5Quw2/BwBAPmfvec7zGf1CJTg==
X-Received: by 2002:a05:622a:1a06:b0:466:a091:aa3f with SMTP id d75a77b69052e-46c7109f0b1mr19801741cf.51.1736305203620;
        Tue, 07 Jan 2025 19:00:03 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46b385c95edsm17454991cf.87.2025.01.07.19.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:03 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:02 -0500
Message-ID: <d7895d5cfc09a64b91721fdc4796fdb3@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250107_1610/pstg-lib:20250107_1603/pstg-pwork:20250107_1610
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH RFC v2 8/22] selinux: avoid unnecessary indirection in  struct level_datum
References: <20241216164055.96267-8-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-8-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Store the owned member of type struct mls_level directly in the parent
> struct instead of an extra heap allocation.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/mls.c      |  6 +++---
>  security/selinux/ss/policydb.c | 19 ++++++-------------
>  security/selinux/ss/policydb.h |  2 +-
>  3 files changed, 10 insertions(+), 17 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
