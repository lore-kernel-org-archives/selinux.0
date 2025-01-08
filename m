Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A6198E6F
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305199; cv=none; b=k9om9xtuKghMYdmKkv+3ThxfRHlCOoCuPHV3BIQniy+WFAguylpKEPn65hzfk7lGyxkYfpP7MTB2InQiwaVQ9RZQ+tucvWjDxYWnLam5Uf2zv9VdbccZnnKIE3+MNAJSDdi+6jXShJrtK6PoIAQxqfVgAvei0lY3EyQj6NeG2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305199; c=relaxed/simple;
	bh=8QBiywYnc12HEznieADRoYmb01M7/kHiGPxLOVKRFMQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Y4PkKSStqpiyeWG4IoeVe03TKLbCxklVsDc86ziDSuclVoPc3QGI5WW+d78DKnT8bo+IRHLwaKkcg+8HIIVo9DAo97caSBejSnLq0FneG4yuXh3bERgWbaU70NADdZIeF83GlOkpmMET98A/Nf7mjW6U8ciWEcUUbwGcWztu7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VwYG/PCe; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VwYG/PCe"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d91653e9d7so142055696d6.1
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 18:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305197; x=1736909997; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asoiHSEPv9nQtNvvZRDauQpkLcgnQc0j14C2mcfDNOM=;
        b=VwYG/PCeoEOq2/jS661KSkN8tUUx23MOoM3QOUaqop/FKnF5lFXRv97WVkkPWNp63g
         puO19MjH4g9ifVZ9JIoRD3dn6zechKm+S6Bf+5LneugeDhHgj233rrULW+MCCAoL4rjQ
         XIV2onytpMGd/D6okPo/3XV6DVvqi6bj8DOzEu9WdTImU+XHoJaX0O9MJNSpT383OVqp
         E452wMUgDg3vz3+ZphaB72am2dIx9k77oc7HfbLfRzsepUk5ctZ4q5REytY0egsq8c8e
         n7ZJy/Lewpctud6iHYKt9/2iHlXpAeBsyAqDzsEBiAWrGHdyH71BKLTgb+upqcJwUAlI
         dlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305197; x=1736909997;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=asoiHSEPv9nQtNvvZRDauQpkLcgnQc0j14C2mcfDNOM=;
        b=MmrPcAAFzXOCnpi67EeYltpi3dzMzB/NZStP5ynm0B1BHe+AVY4ZLOBZokfxov8gWd
         AqZFnstPKC+yJEU28cTnsNkwn1nFP2Bqt8pMuY1b93DbIzao7jrAyreW4bsSt17tgTVS
         5gBSpsNtUvybMV+/A2dtclvi63kZTwxB5ibZ4hObUarbRVGIbjqg0Lb0RzZCp3RfYs5W
         2KdsiEVUhkp/MoLVZGJlC9ZAjTqpzqBzHYiGiGUBb1fbZq6g1VBP5TLwHzjvvT2PfnoK
         oiTmDx1ia71XCNPpHycVv6H6LFq5bighyQU7Z4M/CHWb3RVrULGxlMYVU9FqY2uJEC4w
         EiRA==
X-Forwarded-Encrypted: i=1; AJvYcCXfej+ZL5TbztxgdfuGAkFhL3ECXgX4gRBWjqOaIklJ74CXsTeNJQn+P1jCk5d0w5Hq4pSJsO+2@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJwvsRKLVReGiKl8O7tB+ULQSY3wSbFqZaiXFcgyJgUPQnWE+
	pzwpV2yMuOYjyPfxrtXU3DVSx+zyCzIiYh0jz4kgV3FqhFlyWKH7rHgQBDIKmw==
X-Gm-Gg: ASbGncsvJCfnI6iRO0Oq6fGoRWu1nL5G2mJh/Fv/8g88DF9N5jtomnUXI+AyM+4vGnS
	BGjuSJZWTbUobQVuYpVNL5Qmj2uS7wejUdYETBa/PeAxWm/BEecVCjSCh2t4+nPKqj9CyXnsZrm
	d/COJUgsfA0fy/x92cu05OkNK2Bf0bhDsOa2B+L2LOuoPq+ej8nFT1CsJYVFpJ1xjGmTz2eDk3U
	v8ZLY9SgpZWYWPDsk7vqRWYGV7bSHux/xWn1e2DeytjSR8OZJk=
X-Google-Smtp-Source: AGHT+IGXiPxmJ6OQ+Nw6PJ7nQML8xXaPqLaZmvndDFxkYNvKcPjBpj6CZjbdCHf88W788v2vfnja5Q==
X-Received: by 2002:a05:6214:3a08:b0:6d8:a1fe:72a2 with SMTP id 6a1803df08f44-6df9b2d62a7mr21771066d6.44.1736305196700;
        Tue, 07 Jan 2025 18:59:56 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d574dsm186398476d6.118.2025.01.07.18.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:59:56 -0800 (PST)
Date: Tue, 07 Jan 2025 21:59:55 -0500
Message-ID: <66c03059a9fff1238ed9036ab0593943@paul-moore.com>
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
Subject: Re: [PATCH RFC v2 2/22] selinux: avoid using types indicating user  space interaction
References: <20241216164055.96267-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-2-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Integer types starting with a double underscore, like __u32, are
> intended for usage of variables interacting with user-space.
> 
> Just use the plain variant.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c       | 2 +-
>  security/selinux/ss/policydb.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
