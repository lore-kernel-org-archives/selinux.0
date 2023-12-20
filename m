Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505E495C1
	for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5Jg7ORq"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b71490fbbso73050a91.0
        for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 12:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703105565; x=1703710365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLxBv96okt6dLYH8NBl2EdRyOwW0KHIRFI6HIY0Kokg=;
        b=H5Jg7ORqVdeHsrBmLH2Mu+2eRxxFVfBh9/DlSywWvAKBGmdfSb303Blfek8xg9Xkx7
         68z2jLASpPJMhgHONxAJgH3E2f1kE9iFDz3R0O4q7cQ/TyXe23lrjfWe7mYGR7bgUBuf
         sGQIgPDrzMElEZ9hcxqUIObGPLvE+3LJGpRXz+6DOP2fA2caffW9G0BXkKaajtdWOGWs
         yAheDjk6zAY8/uy78AuevNdbiRemJRJ5oFDCTHUA8VgQY/lkWfpYJQsG97SbHTt5rxzt
         mX8JipfkZYIJZKmB7wXRl1XQD0cAFIIEvXSvWEWTfzGwpZMSRFeXGdSuKzswhj/eQ1SK
         8BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105565; x=1703710365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLxBv96okt6dLYH8NBl2EdRyOwW0KHIRFI6HIY0Kokg=;
        b=BJlPpnlK8NNuZMw/ecLZXoHmGhDYgwb2aVYx5EMCs2W5khUB0scwlhI8OBhNbiM1SN
         Ez39w5mr+69JMLzAe6pRQmXVDi9mJjZ0BrZK1k1sA/d8fAY9G5kHr9/FMAitG0ciTbxP
         0AfdrsyY2tKgGovqX8UY2P1NUTDfRh7Q7pqMubxXBN841q1IC01QiHyoXt0gcjk6mADO
         E0aQk21pWbfWOqTBoX80Q5iVZ/gqOaSy2dSYBqkxAiSTKwpPCM1lpKMAJJxKXt10tctp
         Fiwo2W2cT3omFFreLrGS5xvhYkKPGi6iShRjlLKy2dAYaCZlLrlM4k2Yl1BuXbftvwc2
         a4vQ==
X-Gm-Message-State: AOJu0Yx9Q9F/m2Vptljm0F5y5a4kn+3YhRMBx0Dei/IrsRFj4HxcMBiJ
	dcyzS2fo4Xs9tNPZYsnH7/d96ssVtjKp093hH3fl+DPs
X-Google-Smtp-Source: AGHT+IHHb5U5U/bfT9x6OcLo7649QPIADL8T1LvwGLMg/noHqOFUg0FOwwLLQvrO3MVlKHXRQsy0o5FgdqucLw7avXw=
X-Received: by 2002:a17:90a:201:b0:28b:d86c:a0ca with SMTP id
 c1-20020a17090a020100b0028bd86ca0camr876701pjc.94.1703105565217; Wed, 20 Dec
 2023 12:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220165244.126550-2-paul@paul-moore.com>
In-Reply-To: <20231220165244.126550-2-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 Dec 2023 15:52:34 -0500
Message-ID: <CAEjxPJ7YWTbB=hkNhVzxOXanynV8cRzwwcBi4Y9VpNwvPAdLxA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Ondrej Mosnacek as a SELinux reviewer
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Add Ondrej as a trusted SELinux reviewer.  Ondrej has a long history
> of providing quality SELinux kernel patches and we're lucky to have
> him as an official SELinux reviewer.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Yes, thank you Ondrej!

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 931c52cc8393..295939417dc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19518,6 +19518,7 @@ SELINUX SECURITY MODULE
>  M:     Paul Moore <paul@paul-moore.com>
>  M:     Stephen Smalley <stephen.smalley.work@gmail.com>
>  M:     Eric Paris <eparis@parisplace.org>
> +R:     Ondrej Mosnacek <omosnace@redhat.com>
>  L:     selinux@vger.kernel.org
>  S:     Supported
>  W:     https://github.com/SELinuxProject
> --
> 2.43.0
>
>
