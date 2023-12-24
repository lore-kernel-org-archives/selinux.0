Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687DEAC0
	for <selinux@vger.kernel.org>; Sun, 24 Dec 2023 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YOtIarov"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-204500454fcso858916fac.3
        for <selinux@vger.kernel.org>; Sun, 24 Dec 2023 12:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703451208; x=1704056008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eJ5kELvKhedX9EnpknPh9Uzs8+yLEfkilDmWrRStKw=;
        b=YOtIarov/J6s9xsM6LiDPNK781OXlfgxMeMGXf2gy+ubMCSSqe8JmweU4DRCxIID72
         iAFaKfGmgTyPnB0SHaKIyp5BbHF36gC6fyv37TjbgrxKWhQmC3vWwNiyD7DNfShd7oDw
         PfIqwSMqF8iSyMQW/pFlidLHJYmNyzwjOS1MetE/oU1sk+O6v7xhmX8Qb/HowVAumivC
         hB/whMgie+6f03Rp3wtvN/x6l8/SY3sRhna2Tlo6QkJbEPmX2dubuc5HnmRLOTtSntqm
         FbF4L4A4UsZpMQ1S68abZOLVPDrLo3Bj1Q+VPyLRoCUk8LZ/tjVAtEtLVsQhKUrrr/fW
         N3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703451208; x=1704056008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eJ5kELvKhedX9EnpknPh9Uzs8+yLEfkilDmWrRStKw=;
        b=nkJIg+qQ/67C7pF6AjOuNKnE0h/aRNFBIgURHPGqXm25uPwCNfIo5VTiAJGiYrZuDO
         CHrbjs40OeO52CLJMZizQm8KyJfjuGSyO2FmhAkNiKgYCWGPdRFY9bfysiCuwUXGAAN4
         v1hWsm7U56VYhA7aIgm+/hcAvPszbcY+k5Un0G9yJcrQ2Gha2kxSpUcQaFk+wgIAU124
         Q0mW/2q/JlFOITTo5Lh6Xi0+tcMZiUDgpA6WYJxgg31S5AMBCxgNJnyiDVuBqLmqsrHy
         jhEauqa1WPCrwDbVNo8Mk3jNwU0MB1+Qj4kDzk8ZA+4IcfNY5ORLVdnJS2q8NhmNEkZW
         M5nw==
X-Gm-Message-State: AOJu0YzV/BDLgbzAzO4g/4eFhWk3gNODB1kBYn/I9y+NUNEmslyu5yau
	Huu5LkLM6IazVcGvPCLN+tqesM1EhqJ1IRl6dXajZMRlRqMp
X-Google-Smtp-Source: AGHT+IHJn2RMPINVg7kRyhtjoEo7CrInLSg++LDl2IOK5pQWVQokOc8gh9qoWmJejDIY2LhqBpVSFISgcHzHDX7bp84=
X-Received: by 2002:a05:6358:7e56:b0:174:c61a:4dd4 with SMTP id
 p22-20020a0563587e5600b00174c61a4dd4mr3742363rwm.41.1703451208018; Sun, 24
 Dec 2023 12:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
In-Reply-To: <20231219090909.2827497-1-alpic@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 15:53:16 -0500
Message-ID: <CAHC9VhRDPv4-gNNiFMNtP_vL8UM66RQX0vxB0WkNw3Rn_Lcfmg@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Alfred Piccioni <alpic@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:09=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
>
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>
> This patch introduces a new hook, security_file_ioctl_compat, that is
> called from the compat ioctl syscall. All current LSMs have been changed
> to support this hook.
>
> Reviewing the three places where we are currently using
> security_file_ioctl, it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/ioctl.c                    |  3 +--
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  security/selinux/hooks.c      | 28 ++++++++++++++++++++++++++++
>  security/smack/smack_lsm.c    |  1 +
>  security/tomoyo/tomoyo.c      |  1 +
>  7 files changed, 57 insertions(+), 2 deletions(-)

I made some minor style tweaks around line length and alignment, but
otherwise this looked good to me.  Thanks all!

While I agree this is definitely stable kernel material, given where
we are at in the current kernel cycle, and with the end-of-year
holidays in full swing, I'm going to merge this into lsm/dev and send
it up to Linus during the next merge window.  The stable tag will
remain intact, so it will end up trickling down into the stable
kernels, it will just take an extra week or so (which I think will be
good from a testing perspective).

--=20
paul-moore.com
