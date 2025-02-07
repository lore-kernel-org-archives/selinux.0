Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47641A8418
	for <selinux@vger.kernel.org>; Fri,  7 Feb 2025 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964581; cv=none; b=o4pPdmveG16FcRHtBKf8TbxqyFq19/TarMK2CVQRvyvHHqXH21bfmDNEhK3yybr48MbqjvpimCWD+WHqxJJ7k1G+wuoaL8ukFsvoZ40kMig6iKOmO8AnGLS1FjFhq8yE34x0mZqxFvBJ01aYMyz9CW6v+aE2YDlPebL2sPE3sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964581; c=relaxed/simple;
	bh=YY45Gnycd+3o7hKOW8C8JWYriuERUUgTq475FPmCvGI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=OlAlDCdrS6UXnvIau54TwncJ8anbXJ7HjNH2M5XVpYCHtchJNmpdK2mg6yBy8Qdh7Dc0+u5uj/0RpZZmODjyK4q/VhIm5ZAilOLeIlhJf6VBiH7b5x5cpGO+vWs6a00H2gkdDn0Jvxe9ssCfzg9Z7JNASu4lcBnuciAm5aIEdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U3lj2Y/H; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U3lj2Y/H"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd15d03eacso21295886d6.0
        for <selinux@vger.kernel.org>; Fri, 07 Feb 2025 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738964578; x=1739569378; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvI4JoqoZo9YGBOkVNl+HIo1GyCi9K0UiyKNezQvlcg=;
        b=U3lj2Y/Hx5rw231y8IvfEZA+lYWKI2a/kzxlcQ8vJa/yp7+fGbyE40xukdNfaPhLBS
         eyeDnWgB5AA8dq9i/vKzwxnC9ODoz6u7VLzacFdmcaG5qP9mSgTEd/+akTpspOncMGuB
         eGO4GX9HdY7HcVy7hLgPRbXbexsqMMXVGXE3kNBNBI2wkNY6ApWORKUc1VjMhyX9ewfa
         AjWGpToEHycw8wORMj1lwuSUk17dnep90bRZD8M+Nhobnvrzm0sp4yMdyN3TuAYupkbU
         imjbUreNvBUyeHuWItTJeMTj8mBBy+8jETR8lPzeBfbDVpJ9TttR5w/t47qQFv6iVTj3
         A9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738964578; x=1739569378;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IvI4JoqoZo9YGBOkVNl+HIo1GyCi9K0UiyKNezQvlcg=;
        b=tCXH+Xt0DeILxA3U/oWZYMHpApQazIdCj5mpn9mWlncR0lkOoVvoHZJ3lL8Mw+jSM3
         MZ00XbGdbCK2SZkS1E5qdUuZpy369du6JZa/rGOaD0DntkzDXmcHfiiVk2+3UPKyL4SP
         dBggMeVfdVsDdqq2jV0+GS8DV+B+AazyLLsP+aKaONopgzQ3eWL7t2zxoptULVArg7D+
         bNBYGfSr0aNqHO8sMpBdmD2YML3aM21GDqCtAjA3owCQUc8SYBQMTmiNrs35WVXRqgNA
         in7qu5Lnt36QbpUvbU3IlmkuXohxiNWl38ls+2x5Zq7j2b9eK4mSy0EmGQnp/PIYOOgs
         tldw==
X-Forwarded-Encrypted: i=1; AJvYcCVJIqMdc7xHZD2RX/hiNe0FhQEvUKglZBoQLyWsb1zMoHFABwXct5NKXhysTzdlJwQymGqmk1mE@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHLjZFC+FKsAfSqs7RaISdeyN5hst2NITdwYems4U/QidXDVN
	jJLO06XXoKEoV89xBUIVtNfPHAc+8ec6RiraCGbSLzsk4200fA4Rf3gx7DEqhg==
X-Gm-Gg: ASbGncuIy6t6VRSTEEpxoqludy9A0cs7rsaXAHRrrDFRJwHftTiTF31UWOkWuDKbhRf
	AvkHayRZBEskwJo/NPG92/UPATZl4z/mozRy98XMBemsnhOTo6a25MeJrA8Fwp773mYyqXwD1pM
	/ognHLyfpHQ/68FfgICwoJeL/Q2h67Mmzlllt7TFQxehfM+QUoIX2cW6OFILJ6R8N9vEshFogWU
	b0yXicwsscrYxWgX93KFSBfwp1jOXbI683bkoalZSXF9KX06KOWdDIq0JJzhtAq+r7yXZle0ZJt
	t+0SusBvzg==
X-Google-Smtp-Source: AGHT+IFs+6UcZosHd2iDR62Ugi6tG8vmQY7p/Mreyxu8ihzV+H08wfaEH+7KqK5h9qrbMMnVoHlMRw==
X-Received: by 2002:a05:6214:21c9:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6e445a1f182mr86494526d6.16.1738964578659;
        Fri, 07 Feb 2025 13:42:58 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e44b159663sm8220186d6.100.2025.02.07.13.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:42:58 -0800 (PST)
Date: Fri, 07 Feb 2025 16:42:57 -0500
Message-ID: <a4541fab007858c599aed1d1e3e98883@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250207_1530/pstg-lib:20250207_1633/pstg-pwork:20250207_1530
From: Paul Moore <paul@paul-moore.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-kernel@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 2/2] lsm,io_uring: add LSM hooks for io_uring_setup()
References: <20250127155723.67711-2-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250127155723.67711-2-hamzamahfooz@linux.microsoft.com>

On Jan 27, 2025 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> wrote:
> 
> It is desirable to allow LSM to configure accessibility to io_uring
> because it is a coarse yet very simple way to restrict access to it. So,
> add an LSM for io_uring_allowed() to guard access to io_uring.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  include/linux/lsm_hook_defs.h       |  1 +
>  include/linux/security.h            |  5 +++++
>  io_uring/io_uring.c                 |  2 +-
>  security/security.c                 | 12 ++++++++++++
>  security/selinux/hooks.c            | 14 ++++++++++++++
>  security/selinux/include/classmap.h |  2 +-
>  6 files changed, 34 insertions(+), 2 deletions(-)

Thanks Hamza, this looks good to me, but we need to wait until we get an
ACK from Jens on path 1/2; he's pretty responsive so I don't think we'll
have to wait too long.

As far as the return/label issue in patch 1/2, as long as there are no
other issues, and you are okay with the change, I can fix that up when
merging your patches.

--
paul-moore.com
