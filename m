Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209C388E60
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551311; cv=pass; b=dKtaZmtgPbduZX1YcnQHPXaqZSri0LplhK6G0+zFVCS0Yh0hQ7qTYdzkeNzyRqffgFI44zxCgwRx5NPEoR4pBMwXXl4tync2aQXQ0IXMmJqZOKq6kKcNrlzG2zY7w7btEWMcaHUiy6JBMSD5fC3H9hlUkfP7o/GlVFvd4zzlrOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551311; c=relaxed/simple;
	bh=gS5ptihp6LmPw29GE+LP9CjNV8gEDynN2JIrs3jWYBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyZ8xn3fC9mC2csiK0B+QzrldEpy++LC67kEYa5kc6xPnwpicWVQSAuCNzdUDRlzEbYDuNtdMBWamAFHOzejWV4v0Mkv9bxf1ZnHFqU3E53XaqMjFsbRWvxIVBHjAa3zBvpisJbWI1BDibFFHE+ecILqOAlSLYxJj+PMV625J30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGmh8NFS; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGmh8NFS"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-448de0cc236so796265fac.2
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 09:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786551309; cv=none;
        d=google.com; s=arc-20260327;
        b=Gr9Y4XzYFvPWC7iILQf1l5j/4c+WT53nKto7j4hkzeihydGVcGpI5dBORZsza3dYRR
         Pk+kwUlxDO/OYR7EK1sYOkM/LqegP16PqQ3npC+7/zu2ZQu3mVE+jEhtY781LlOSe0OQ
         Z+tzBchUuM0Wq01n+YglXGDce4VGpsjHoQmJQeqInNyU9x2m8cnVXmA26pW0qJq0OPk0
         eyywDq/BBeIjW/P9aEX8HfvptCrsZlTD0106/0CtaPBtw8kqwD/dKjYYjf1ivoGLu5Cy
         bvdNG8UaKpf+LEuzy1Fa1Ic5N00ufBJKXlrCQSUCwZ4VYAnXwvK7j9SP0VgzrvxOP2TG
         LlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gS5ptihp6LmPw29GE+LP9CjNV8gEDynN2JIrs3jWYBc=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=TAk22mZ7dlvo6Cox/PiG++5Sz4lwdrv9RAo990SDFBvaF8Nb+64uyZhl6Uzh+nd1+9
         EioYF9BTF7UmaHyVA8c/91s4foPq98+PerhWDcRfuL5LhHKsPnlrZ1TDAkEivqEAArab
         eRYUILttS+nKjgZTb1f1uhbtM6tq/VxSlqau9c4B1LLNN5+oh1w3hBoTN+cPCd4FLaiv
         7NtolhGJcjkVIZUyBnwYgWZKVRY4UMYLRdpOr2i1KeBZpz5tkCNY/RjTmcdNtqW7ADAc
         M/T6K+8fLfulL4uBbQffr4WGyhlbASrjEx+Eza6dYDXIEoURkcZC/LFXkRLq3BMyLb32
         eprw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786551309; x=1787156109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gS5ptihp6LmPw29GE+LP9CjNV8gEDynN2JIrs3jWYBc=;
        b=dGmh8NFSrkdpj5pgxOM/uLhGIRzrrEGkHvIibxhioDsg5Ra3IaibHSDa+yC9Mkcai6
         m4+DUPAbSwETvAiHNyEPWRFR5HJwVxnm3apQGWEPc/s8f/xRzdZ88k2nw4/WO+gHB/s0
         R4lFFZ4wtTTyivDxo+54Z2e6IhFYoE6PVZQle92xeQ8qH8ce7CdwozKxcwFPFo1aot36
         U9QMim/FcCbWrZIvxuzj6B0ohkZCr8T4QL1UtIJW/shTK7JuB8au0FG0j8kTUYG0pzQI
         ZlmUwvtUv555kGsZTApf9KEMHb/zX7s+YSiqyn8+2ACULoiZDfjXOQoORe6xxrWWVKXk
         +0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551309; x=1787156109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gS5ptihp6LmPw29GE+LP9CjNV8gEDynN2JIrs3jWYBc=;
        b=cziyLFIP1YSnXWnanyrmVoFbi6N766xx8OZzdh/CuadTcIYLWdqDCggdG4/FVuRtQc
         NJKl6xy78seoD5D8vsPOyyC4ioN6I7HJM/hWmjZpWEeF26rc4Zq8n9fwT+xZkdbdVaoe
         expB3cSeRk4NfURFvLF/zcnkTY0gTegiEqZyQF1JtKJfC7S/8JCEjTLaQ47F90eWUVQV
         fSCumJNp5wo1Rkg2Iw5PuwkpjPDnbzExtQFTzpVEccieOtO9jsZ3c48y6eAmhljWvQDn
         pGw5aPwiL8SOrY+BENiYZaYN+u9of+o/x0t/Z+TLq/qY3SDZcQrIQzyuo5ycVDMlGCEY
         +udg==
X-Gm-Message-State: AOJu0Yw5CEs0wok/h4mQekDbKwQ9eVpDdAvkLhGOJb6EkpaaGmg62vJg
	cUSdx1EDeitaSpGfvaNJiQf+UPQbfmBJGTUQ/6W5hlItkBz3+FO5YhkpL7hzzpXZa0EPoYZcd48
	ISvP9G6BZiT2+y4ZhOadky0zt7BDBhtQ=
X-Gm-Gg: AR+sD10ahF7cNMTyOB4DtMPoGy72wXDu1E9xeCVbYwQKpbUFA/YGV9yi6xWAhspaxIG
	ucQUMp+a21HYUjpqYPBURwZmnCV6uvzP67DVwIbnl4xE3aInQoAKJUHfzLtCZ8HyOUB0zGtDoyQ
	TsBcA13viZ5TW8JnVEHMjlpMN+roOK+T90M2I+eVFhCZS0vhftJrPMHNBwqBKxYaLLcmMbHEGue
	+kkabYaA35hHMl4nC0eLEw8VUXPHSvGZzDiLiClC5ES8meLICl2uG3loF5VD8FhG0+746EWB3lh
	WGQK4kD3s9FMlq7AyCcZdx3GKDmFX767Jb78iWT/pb5q
X-Received: by 2002:a05:6870:8a0a:b0:439:a524:a29d with SMTP id
 586e51a60fabf-45e3e931f58mr5463084fac.1.1786551308424; Wed, 12 Aug 2026
 09:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812155831.16467-1-jwcart2@gmail.com>
In-Reply-To: <20260812155831.16467-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 12:14:55 -0400
X-Gm-Features: AUfX_mxe9oFezlZc018f5134WaXOrHykl6Rrid4ClfN_zMhj7ulwOgiEnULokXU
Message-ID: <CAEjxPJ4oMi6HuVhPrnzOqC45j27TaN7uzhncpjb1sYgnqebw+w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Free context on genfscon wildcard error in kernel_to_*
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:58=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> A policy with the policy capability genfs_seclabel_wildcard should
> have all of its genfscon paths end with "*" (which is added for
> backwards compatibility when compiling the policy). When converting
> a kernel policy to CIL or a policy.conf, an error occurs if the
> genfscon path does not end with "*". On this error path the context
> is not freed in either kernel_to_cil or kernel_to_conf.
>
> Free the context when exiting with an error for a genfscon path not
> ending with a "*" when required.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
