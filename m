Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789F1A23BD
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305209; cv=none; b=nKX3MAS7y0u8tzBchPEjDJfe3F2AIksN8fAbUIn6DbeQ01qX2o1ny1lJEsQZsvlkz1L58cWsfUV2yS5zURepjfngd9Clbl1Y78u8bilSa8HacUvZPjffc6ZGEJIBtgvB9llpoGfts0AtcrfXjqpurhwIjqmuIccWLcek0FdjmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305209; c=relaxed/simple;
	bh=ExCh1nW1vjHnY03XeHvG1hcHRK5deovSc3rDD8hL9yE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=N3naAofYi/y5Av4lvvUK2LNA6pa/OZButPl1XONozXqFv6VMjpoceHgPuKH57KPzddM4FEvAAV9xO+jK0oR4Bk5t0yYEu49gKS+xlSI1lxhRDlNvdMMA7JJb5IOq3GCLIVVb1xWMN6LpUhP7xvdqp2IkEYXERldxB8/JUAVrg+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CuvlyLqu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CuvlyLqu"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6eeff1fdfso1217883585a.2
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305205; x=1736910005; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+kAHNksMe/kXkxGmFNXBeqM4K/UZtDC/SfkjYB1G8w=;
        b=CuvlyLqueww0RY6/FkteK59+AYeeDiB4DRB8kspaqTzfl1Ekm5ZxSV6TMsH9VzKwVU
         A5H2YiWvihWEY7IQ4Nth0O88aSJAFIiIvGgBAbKB7+mBHoDXH1+UjFEuBostpWRX6HGK
         R4Iv6QBynoWmOv0ooGnNy525c2qNofXd4F+Q23ejP5nbvhF00uMxhyNT83LKYhEPjiDD
         0BMT9U6gLk52kfeQ3oDvha5yJmH1HXJz6Z1Zl7LurDjbw9H/2lorJkRUoYEfciTg5tXR
         MCNFOaH2NzqS1AltXOe4aBklkPVIgW86piC6cVzpQMHMQ13Gi0KsroLsLqcauC04Nluj
         3PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305205; x=1736910005;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1+kAHNksMe/kXkxGmFNXBeqM4K/UZtDC/SfkjYB1G8w=;
        b=O6IPH02RFrh22XtrXpHdhLZDzMc+/enzAGbMLA4igI3RTIn9DWH+YfCvN6o0YzRU4Z
         sKjHO5a+XdPo/70hP6maDc/LwvwRRyT38cDzL2ulqmg6EQ+SMZAwhrdqaTXJaovO8t1M
         iBOSVQVFHZujZppGzK8ylTrhRfgdGzGurIJ+JQ35l3qgZPSn16hW1DS8aW2i9OGBSJ2M
         EQBps6DGq8XUcRFPiGkznjMYcOzTxkLzG8KN+at9wm4J4equC5jU4VLqdqeWSvrkxW6a
         +BAY1Ga7E7E4Oqer7rmjfoQ+sqEyf5+uqxgdY9TGO0NlsIXKiunPTWl6Y16ON1V6yXk0
         r6/g==
X-Forwarded-Encrypted: i=1; AJvYcCVnICbvLfhTcG1+h/ikHvjKNK7PvvYBimZok7lURjjIpRruh9j8EErVhTD+Sddgw7XI6WniVr3T@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlKfbMHcMfAVdjJt9CXtFf/YPuJ14joQXCxBdFSIvwt6xQgDV
	d7+NHSAakyz1/yf5EiE6QOs0SAjaCPsRpwYl+s6Zh/wwWXpbRWqNOYvj3P9EmA==
X-Gm-Gg: ASbGnct8vq4a5PjRULR4vYEC4XoeZFoWa5SF30xYgOIJkhxCtKz+tWIHTW9Htj2CXen
	oKHIsxyM4t1D8liYSekku3D56OlFJZVLZv4unjsXLC6MP8a1cTVU45viaS1jNstbC9bzuc4yvnY
	ocotMpEjKrF+nI/GNFs/s7XVY0lL6fASRr8acl4D6enlZi7E3aG6la129BlAFHJVHdMhuA+pm94
	lo//b08CubAC1aNCof0+nYQ4sow+hZmkOoAE/uTKcVQq8mHheM=
X-Google-Smtp-Source: AGHT+IGfAS0/RTOdLo9YLsVI7/BHEdDVcLTaguEmOzcDE4oMwhb/+83B+6j4YkXqvkM2pCaNyADC+w==
X-Received: by 2002:a05:620a:c50:b0:7b6:ee6d:fc23 with SMTP id af79cd13be357-7bcd97bfc72mr154389685a.49.1736305204786;
        Tue, 07 Jan 2025 19:00:04 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4ee8easm1648074685a.125.2025.01.07.19.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:04 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:03 -0500
Message-ID: <b4c09c8466ebd880ad8e3b370a1fc37e@paul-moore.com>
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
Subject: Re: [PATCH RFC v2 9/22] selinux: make use of str_read()
References: <20241216164055.96267-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-9-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Simplify the call sites, and enable future string validation in a single
> place.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/conditional.c | 10 ++--------
>  security/selinux/ss/policydb.c    | 22 ++++++++--------------
>  security/selinux/ss/policydb.h    |  2 ++
>  3 files changed, 12 insertions(+), 22 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
