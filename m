Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE054EE872
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454205; cv=pass; b=ru/44iCQ1qKXBqh2aXeQgCydtbLVSeHjW2z4xJ1P4EoMnljGurrVwLbo9/Ewh+ggieyiqZhmgI/einemWJXHE3Ru9gO0PJvsXxcMmMsn8w2Ue8QjEwbPCfsDZrnvd7mW5KlMSM2yAKM97aA/N2Hu/a3KkTRfHq/qg/kbPzvlsVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454205; c=relaxed/simple;
	bh=fIzJ2UzV1e1OhGgyxGwDuKbdIbdlV23EY1glTplhvE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fX+50fpjyGdX2HBe0xVwvgsSdVGwg03VL0mN01xbuT4jWBH8rWOqFqKpWuPyuBVV+OAOK+ZI77xcGjyVwIqUkNkcIQLUOT1oD7ISBPSow38HuWn5grBdhUQXdD3iMr6Zm7ZcbTYHP6gVVmuJVlhUjMgZcRP0gBqQXsVqPwcr1W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d5xJJ/s+; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d5xJJ/s+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-85c9a79590aso2991846b3a.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 09:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788454203; cv=none;
        d=google.com; s=arc-20260327;
        b=qdEcp3wlVGVnQIkx9niI1O7fyMJZUGQD5pggrRu40cUYiWCphPbk6RjqIyLh5USM8s
         +jnvhO8R7+7sJtBvmZWTKC8VTUc8cDcG7yVL5WJ2EJAu6pgyqYiX3195Bf/8RI0yHidg
         ZQXgy8t7Cb7kN8HzviBjZ5gixndfH0cDoF+eGhmo9Itco222YGWc/hAR/2lhUa1UvGpR
         Q9+fHOpphQcSaNfDrrIXfjFqhz7rGShpvvSCRYlU8vKqIl56RPGXcTeL2bQQSLW1W7wn
         dPYIlbdz953vcjP3y6hUz4+X1aUVDQLKwEAul8kLgWXBqjTpUwtTT0EJ6IduY7YlMPvl
         hGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2HQUVihfuH1EnVw3l99N8g3U4J8AO1suXuMcFxz4nu8=;
        fh=q8fXXiEMmgMb+/T7Vaho4u9XGfdjI05CRC9PoO2L1pw=;
        b=mZwymkAECx9c0dy812PBAF30N6tERmfOvSP/fHE/AL7+cjSM+qLPRTXTf1Ivq3GhEU
         VCK89v+ibF6cV8IAuQsBUz6kB+H4XygSn5oixGrZjfqBfao/74jXqZbKGeXSMIVcOvpc
         DGJpUc3dpsFxHVgppwIuT5kXOiDBB6OFHP0gbiobmWWhLr2y6WFwiI4xqNViofripe2k
         5PIUZI6CjJZBFKu9IDQ4qKxv7/pXRjPnDnt3yjjbMgOehGeaR8hMHbnIkfiVA3lwlNG4
         Z5FOcAsjGCmyFpZFu7DIT9BUQHEaAFDMcw+8FiHN829+aEU/MeKBL4XhrZm6SY4q5yjB
         k0qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788454203; x=1789059003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2HQUVihfuH1EnVw3l99N8g3U4J8AO1suXuMcFxz4nu8=;
        b=d5xJJ/s+bZ8G7cWlXDwnUBOPPL8SWcKkAjBqVEKf0k4KhYK9bAhQNuAshxxnm3oSNG
         sSZ4BQmTBFCPFBAeebo/pK8zvQFpLzMgiimZ4O9PknbACOpudWvxED6ArnkbLWKw8FCh
         +IBn3NHozxUwW8bvALGbsYnVz1LRE9zhT2AlS4w7wxnhBYzsac9vsY+tSgEsjkK4BN7v
         MXWO3o4iMN4FJRYFXQqzayhQtzEFTv0XDbT/1HorIgjNqEk6eafAYALYShPQhbYda1wn
         9T5654dscRfI8x4p3yFivJORk2SiIhsZpI7yhJq97hcCgl1rk25k4IAw3xdR7g9Vfd2w
         XMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788454203; x=1789059003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HQUVihfuH1EnVw3l99N8g3U4J8AO1suXuMcFxz4nu8=;
        b=hKtxwiWvuqgbFP4Hm/cnHk/DPvEG/oUuJuu4Qy7+xog6uf9omN6NW9m+/jxczBrgVJ
         RPWpuHliLXn+U0awYuwH823q6789BdNPkvtgx2kR2lFn6L0cwpEMg2j3FL2Kl+RP/Wyr
         Twa/fPjPdomGYZc0GtfYHICjR8YHcNSom1yWdI7fQVu03/ghwA9bpu+UFBPm2OlGZ8qr
         yFBquTSSGB5JHUSkaEG0Drte52OkHEaCsJBC6qF0tqGDH4D7vinNH0kpZOkep8p3HLX0
         d0bP/L/GjvFgWqJRiHzAcblT9Ooyl3M0/RmQoWTE2R/lJ5TWExLJd5tor4iHSbvkBoxo
         RqVw==
X-Gm-Message-State: AFuF++mFNFAdqmjoWVMewCnnpRsa/EC9I0vrmer5H5PIFqDW+30XXWHT
	boOVrN8KixsAlpjlxsr0RggNv3WhJfOcO1jJlubO+NzvcL7dUl54hnlCnWLh3yRbMHKznZWtxA5
	tRAqR2bT43bwLh+qAY0Z8MTCmjTcw28UvrRzuvX32UgYjU6ArPllalQ==
X-Gm-Gg: AYBFou2jpz1ZftyacOOqOmVliLHAo0TRr3bK4EF0F4op0pPoXTidEe58EukGqdAgBJv
	5MmSPvoF2NKkt0Kuddoo7cMv6XOAu4cz0dxRuIgyZ2CwoWBTXzt/ze/j9UOgtLtf3H84Qi7I0PA
	QDfB2FZ+b7XeXezg3rivsPAXEqdCQ2Gm/Ofqycr/WThhINX6jowYF3PnwZ3IC+3HTrVj6Y8JjAb
	ijjyY+6Y/gYYnS5aOKNJGc/nhSItWAA6LefWjr19bZfwqiBTSgIgqidYUTp6hRpFxaxWvkqKihx
	VNA9FgmE4BajRVnwbz6k1H5ZdfWlh6D428OJ5kYSoNlD
X-Received: by 2002:a05:6a00:4c96:b0:857:7337:5db8 with SMTP id
 d2e1a72fcca58-8616ae4e171mr356491b3a.22.1788454202717; Thu, 03 Sep 2026
 09:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903155615.516010-1-omosnacek@gmail.com>
In-Reply-To: <20260903155615.516010-1-omosnacek@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 3 Sep 2026 12:49:48 -0400
X-Gm-Features: AcwNN1Vi1fFN8XgqNIFOZOP1XJFQC7hXS3V-fOBEGIFKC-xj0anHhARHzxX5Hmo
Message-ID: <CAHC9VhQSoWBfWrf97Ch3ZZJXkOvhbwNOGmq8rMxLFzq+a-CkQg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_MAINTAINERS=2C_mailmap=3A_update_email_addre?=
	=?UTF-8?Q?ss_for_Ondrej_Mosn=C3=A1=C4=8Dek?=
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 11:56=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> I'm going to use my personal email for kernel contributions from now on.
> Update MAINTAINERS and .mailmap to reflect this.
>
> Also switch to use proper spelling with diacritics, since I normally use
> the full Unicode name with my personal email address. I'm leaving
> in-code occurences unchanged though, as that would be just unnecessary
> churn.
>
> Link: https://lore.kernel.org/lkml/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK=
8KuseMQS-9tNA@mail.gmail.com/
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>
> Hoping for this to get picked up via the SELinux tree, since the main
> change is in the SELinux MAINTAINERS entry.
>
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Of course, I'll take this via the SELinux tree.  Since I'm going to be
sending up a pull request to Linus soon with a v7.3-rcX fix, do you
have any objection to me sending this up with that fix, or would you
prefer this to wait for the next merge window?

> diff --git a/.mailmap b/.mailmap
> index 6803f3bd2865..0e672a60afdc 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -699,6 +699,7 @@ Oliver Hartkopp <socketcan@hartkopp.net> <oliver.hart=
kopp@volkswagen.de>
>  Oliver Hartkopp <socketcan@hartkopp.net> <oliver@hartkopp.net>
>  Oliver Upton <oupton@kernel.org> <oupton@google.com>
>  Oliver Upton <oupton@kernel.org> <oliver.upton@linux.dev>
> +Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com> <omosnace@redhat.com>
>  Ond=C5=99ej Jirman <megi@xff.cz> <megous@megous.com>
>  Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
>  Pali Roh=C3=A1r <pali@kernel.org> <pali.rohar@gmail.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc320b373656..875d0baed8b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24772,7 +24772,7 @@ K:      \bsecurity_[a-z_0-9]\+\b
>  SELINUX SECURITY MODULE
>  M:     Paul Moore <paul@paul-moore.com>
>  M:     Stephen Smalley <stephen.smalley.work@gmail.com>
> -R:     Ondrej Mosnacek <omosnace@redhat.com>
> +R:     Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
>  L:     selinux@vger.kernel.org
>  S:     Supported
>  W:     https://github.com/SELinuxProject
> --
> 2.54.0

--=20
paul-moore.com
