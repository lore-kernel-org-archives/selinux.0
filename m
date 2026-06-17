Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0243D4EE
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705552; cv=pass; b=tbj7lXYPYTkIwbdppwqW3WhiGKneytRAM2qKRPgzOsoWZblBzCKn2Cc5r1n7SwzdT5DwsczJfse1HL4M4HyxnyncRw+uYB2ZKFB+i4zQ62IeBJhq0DfCCAoJ5qnDNRvgI0ICQQ5KNMUPa2XB+gPeXuyPu5dbbdBQP6yFeSqp5c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705552; c=relaxed/simple;
	bh=qZOkYQrbgN19OMPq8cx1ZeZ4Q9D5cghHwIX/oJV425o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO102oWCU+38jU/iZVm3SNsVCI687/C97m1/qsoAu/sVw4gZhFtlCSV1FRNR2/Jt2LvStlCCxNDOvy5ppElLtU/MGbu9dNlFDpS/4IKzPzG3VG7hjg6kj74xElHKqHmFyVmeYF26led9PaPBGnDn6rTIUNjlKAgL6sR56jiF37k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOueTEfK; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOueTEfK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so3629397a91.3
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 07:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781705549; cv=none;
        d=google.com; s=arc-20240605;
        b=N+7ZhrO+klt131t4zed6yHerUtFPVCLKOMltBMF6PdpFCWWVZHaRh5xFZ/NcMJjLc6
         soOvapFQGORT3/JnNd+vArxD6CswMiSRCNtKQT5rmszp3eNTWOTQfF6qkkwMLRP0MhYD
         gEHSH/0fqsCW3JLY5b5PLnw1eBc/1yGm0AeXUqY3H6xk8HG9cZvCnlFolRluieapXORL
         BG0DbcES1Mg3Io7dVUGgOBf9KnsBEE9GFxVO3D41S6VLXoegyxvIFN9fhnxRLJUW8pTy
         7sSvZJdQRtEFSHoFt8rPYcixPsG7ETIonrIgA+jurTH7cPssjTJekMsGBEtCRs+gPwOy
         NrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+Znr61uGzFcsxsz26jA2F8efAegUhnvgDhCI6u5HAk=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=kntsTVwAsttx6WBrpzurzNzAdE/HXPRBFy6K5sK5D2Wh9AV+IxxQrRtzMetEhG4ek+
         7K5Oa0+iHWDQ8uBLGgMevseScWGvNdB0QM6VaGPGi98YT2DXTlk+y2hEQwAiZycRus5m
         38XaJ9nLnPNB8zSDJZNq82lDK3ZNGqnbpFx8OgD5RTwUtTGMSLAyT0rhND7J9Ng6fFCq
         Gh6e3KEX/oYFcfcuMQtS6mV5296aRSv+emx5iyPPtCrqjKyBJUxEwd4htquc1P+0/aHd
         56VOBQNTX3mbPNfAQvFp6/UyxMvMzjAUYnPHkEcQe1UwYZbRCQUjCT/4C0R7rwDmkssP
         nImQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781705549; x=1782310349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+Znr61uGzFcsxsz26jA2F8efAegUhnvgDhCI6u5HAk=;
        b=cOueTEfKD3QG9TPrzlhLZdkXeGjRQiDPNK/wh9MYnu/stbzxYKtfPZbgn5FMkwgnF9
         8EeSZppveVWRLoFbf1TSWpt6kagKgydDlgNviKO9si8fro+drki3RkCJrWnf+KSKMFC0
         q99+JbRh+71ql0SFyobf/+pVWQPOAm+GbeXL20id4dXqA+5PlWkn3aenHqlbXHC7K+ns
         lLiEex0Slw2rc+mA4Z0OYg9QJigpsx7GGyI4Ssn8UM95LIMlpUPM9LBdNRVffhcCPWlz
         RI1vKEPqT8LHxHNR8q4871/MdrB/tvnEaar9TA+8PxgVKzQ1cSA4FKmoqHMnPxCOCq8Z
         RhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705549; x=1782310349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+Znr61uGzFcsxsz26jA2F8efAegUhnvgDhCI6u5HAk=;
        b=U+FuzIk4vVCkj5Asx7w2zGd0GuiTg0cbiwGRtyncwQ17l+SAIb1Qwqe9we3dOvzJ95
         wSa/bVWA8SGYbCRm3X7rZFdd2De/N3wuh0RgbEicWWXeek9pFjPBhmOXH9vWDNGtM7QF
         voIGHlXEgmgMz+QMnEHhNfkhcZBathpb7whV/pqdB9aoZn8Msyw4TDrPWwZU3WBKrDIe
         TKTrGZecz70Y9usMtxQqaIKOEJI4kJMHIAm0JFHlhDK156MqiDQMmpRJfOPw/JrHBUTt
         +1QtFuuBozzch5rVjOnsxZUCWyZDRV3QUZXCbOQ/CNHLejYbdD1w75LfxGhSizr4XnUd
         Wb+w==
X-Gm-Message-State: AOJu0YzkZ5d8KzTDcsiSIIqt1Bha/BMDv9O5+9b90Tx0bK+rp3dTEK6X
	+afrB9AEdKmIxk5g5zQ5wk1ai1H7qAY5YNZy+MRDnVlHRv2zshW8XkDYcOw4m7axkN8ecax/z8V
	jgnujaWNHgIOJgZN5cOSeYBJGh16xK+QUOA==
X-Gm-Gg: AfdE7cn0fuq0NK75rFoqQbhI8CUr9tqRW59x8tDuTtNsd3bUcZTjOBmHMJ9AatMiOx9
	QFT1uSYmA81Vkbkp1bglI2fzn6PHAt4a7C+JTeXrYkK7JxMBpP61WncJ2h8ib+JHMs7opjYxqXk
	viJVBt/uan0t1YxNzmRcM0eyOkDYCYSk1AxxKcscNuWUkhGNhdH0Wqt5giXcP9q3WrKqtCL3Iie
	OEYUJKqGr7CgQ8IdPiIrVHU/x1G1vDnE9cD34NQ5djxhs4dsPKE0m/Q5udbAjlWHTXdIQzoS5di
	gKKknbU=
X-Received: by 2002:a17:90b:3bcd:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-37c91b96697mr3336993a91.0.1781705549283; Wed, 17 Jun 2026
 07:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616194602.58335-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260616194602.58335-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 10:12:18 -0400
X-Gm-Features: AVVi8CcCzj1fXUVtMyUmQN0pPqrin3sAcx98QYJJSeUmFq44E7p46Nb-kYEvSls
Message-ID: <CAEjxPJ568hALDcQ3HsfCJb-EV9LV50YmTjnza2P+2czvPdOHeg@mail.gmail.com>
Subject: Re: [PATCH v4] python/semanage: do not leak an audit fd per logger instance
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 3:46=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> semanageRecords.__init__() constructs a logger() for every instance,
> and semanage import constructs a fresh object for every line of the
> import file. With the audit-backed logger class, each logger() opens
> its own audit netlink socket via audit.audit_open() and never closes
> it, so a large export/import round-trip leaks one fd per line and can
> hit RLIMIT_NOFILE.
>
> Open the audit socket once and store it as a class attribute, the same
> way semanageRecords already caches the semanage handle.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/291
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
> v4: it helps to actually commit the change before sending.
>
>  python/semanage/seobject.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 9ef99be3..5914ef7e 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -106,9 +106,12 @@ try:
>      audit.audit_close(audit.audit_open())
>
>      class logger:
> +        audit_fd =3D None
>
>          def __init__(self):
> -            self.audit_fd =3D audit.audit_open()
> +            if logger.audit_fd is None:
> +                logger.audit_fd =3D audit.audit_open()
> +
>              self.log_list =3D []
>              self.log_change_list =3D []
>
> --
> 2.54.0
>
