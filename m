Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A2397AF5
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681970; cv=pass; b=LM6ugMARw2OkIFHv1AsemwJTGh1BMJz9RT4yC5sKOEY/ZjM4Bk1LbTT/csZfHpJ8YgJPEwnwtVfOHFiceoG1bDlLQf2b+BcvTkFmCwakgC6hoE0qWpsAJrzYhA/fQT48HOrbpwMA3/m/d2UcbAKahfMDd1rVFvTVKPZmysoQqic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681970; c=relaxed/simple;
	bh=CDMrdb3lEULcl4w7Ixq9lG9sQ+j/U8n+AXGGL3yd1+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvPRlSI8vm/8FXFMT2kbr6MYI3RzHu4lAIGkU2EOcQx6XEe8lnnLLSOAb2dUw4xhXxd7D8tKgP9N7MkFphd9z3jZU20LhXBeXzAsJ2hvPD142/URm+v6z9LJ388sYdfTtPb9FAerVqBCmnsvpgAydfBvu1XMh8WBhpNpMITUYJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYJ+QWZz; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYJ+QWZz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0bd02d97eso26065175ad.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681965; cv=none;
        d=google.com; s=arc-20240605;
        b=TnMNi6bG+TEVNL5TE5xTuCZR1Y2jPWOxl7HGtQNHeZC2YoebhdsJVCwgVkQZZQTnB8
         /LAeN3mS+qemWXm43u//v4w1CdSq8qxFpZVAsjvdswreZSb7HGAbS6AedroAY3WMk/2G
         u1oMQmP/jOgyMrVhsxloC+l7/3wbM26CgbmGl0b1zktmIWUqS+9tIJZsTu87c9O3tuC+
         lYkxZ3mM5Y3c17t5GY3flSQLsMbn0/CVKoKPzXij590XqrP6BPKOIVKdj6OVdoEFpJXq
         g4xzks30KVxMpqEpOxO1e9vvJEVDKFb1mSpJyZEkY1e3sh5nAlQkcXNF+s1yc+zaXk69
         +5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MlL3Q1WOo9a10gqtc5Igq84BsWqZMdKaYMPnSGNK2HA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=YPea/ijIc22Xuj3Phtxpteb0z0ZwMw8AFRzfrD5+U0m9KONAVMf3r8Q++tztR0x3+W
         zVikYB++AcqIp61DP6KiVR3IHwIC+waolbSugBRQtRXCUrEvOK7jKTmivokzrnCWnJkL
         HGg+Ovhcth8+GeHvDTz+hcO04a88RU869xrLZEH6o0najyxW4DCP/UpAnyHGk54b9mH0
         trAHtCkPJf8J1St5qPg1ohfbVRo3mX6JweHlTW7NPVPDU25rHIsjckOoT4Q715/KQd5/
         p+3MEae5/cxOJU6ub27ePc8Yz0tcL/rt5vVD89B1++nExy07VpyenzV7Q3V00wg0siQZ
         +RBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681965; x=1781286765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlL3Q1WOo9a10gqtc5Igq84BsWqZMdKaYMPnSGNK2HA=;
        b=HYJ+QWZzV79CwA//zq16RHGDcAHmp35711OFxnIWFMX1/VvLJMb/MdCa2lFbBPEQCe
         7CSiSq1NYtD87hKmE9Fi+9k6i4fZKGASfNPw7Oe+QU/HmXs3rsDvkVtV+fc8oQoPfAdl
         bjvAfIZQC4zU/foeQcCSBtjLgoCKr/NbUec7PXB4A9DlQu0gyVAJ1dHyOdYZ3KmTL/Pc
         DButotZgWfuOqxZ7WqsK1TZbEIGLF4A/rVWlZUGVKKQi8p73FCJ7TPAdpRvH9R1+vEqF
         LDyoQaKLB30vbQQB+AWYnUZVxNPtI3gtgsaQb7Rq9ORGKxjB5bSbHzNF5B6GQwTyG6sS
         Oyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681965; x=1781286765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MlL3Q1WOo9a10gqtc5Igq84BsWqZMdKaYMPnSGNK2HA=;
        b=XI1ezF7UWzTeZ7GSIZSZMy1LVn4NIYA+wQ8tPu3zIbN+fK9ZSvyrggZS2fJsYk0ixZ
         O92GejvtXXGNGYgthERBnkMMjpcSrdjMDP5+uuZfqYTmwxZBu0nE+DvCTC9KKdLBo+50
         ektJAS6LT8H7pr3XiAfu+rqTu3td32rG9yHipaqxGE7Uv3PAqf70amobeHzGZerGpP4e
         XGdMRGFtV8IAf/zNp0Y8MRSVXwmUM21PjjQIj/TrySV0PbzqGFVd6ekTQhKm0YCKaN7r
         qPUtj2Fcgn3JM53aEHpf+hZHkAk7Ju0Q8PtnC0iAV4ihz9TARLnd2gWv5kj6INqs50gt
         lMVA==
X-Gm-Message-State: AOJu0YwRfZTs9WYO9rh8roUACdl7TQHVGd+QMPuGmzyxlxeBgJFNOwal
	+y/XnQpfXNMS//5QgoN3P78N+5noMKBt2AM/AEfD+wo5EI69kTWnFIs9I+O+t927p3S5AuNoLz3
	rYJjDpkd3deJa8RIJYRRMNcMt5EocV+4=
X-Gm-Gg: Acq92OEMgJvFapaPvtG4Acn293ihFW2S+Zv6tLX2uze4HxDTLG5ydE2+GW6AF1XF7i4
	MRVs2mBEi78cxKTd5ekCWLxWLeUgXMpX1dXmQtc+0DwvN4n2hz0t6Zte4MHLyJ7Z4btmzMT5zle
	rsTrLudf0Kd3D/+VVly9Oug9p2P47gjoFdelF+4av/q9A5cXpp5v1148Lm/A/LJvXEQcbEKii57
	qWxppqSqNFmksUXgRWAt/f28s71w+W8WT+oZtRsnE6K8bvTPMjrrmDh6c+QwQ1NDo7KFLBuow6c
	pZihXSDGHjdRicVvvw==
X-Received: by 2002:a17:903:faf:b0:2c0:db23:4c4 with SMTP id
 d9443c01a7336-2c1e82191bamr48677305ad.16.1780681964816; Fri, 05 Jun 2026
 10:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:52:33 -0400
X-Gm-Features: AVHnY4IrftvoRsWyn8SCpu3KXCOFfqOOSwlaJSxVm6GN-4G07qR7O9DYjb5vO0w
Message-ID: <CAEjxPJ642Aq17urQ-4ZmTEGWqUDd_G8=Nf+LdnEW6Fe9AzOfyQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] policycoreutils: drop unused macros
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/run_init/run_init.c | 1 -
>  policycoreutils/setfiles/setfiles.c | 2 --
>  2 files changed, 3 deletions(-)
>
> diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_in=
it/run_init.c
> index 2cf5bb7b..f304c4f3 100644
> --- a/policycoreutils/run_init/run_init.c
> +++ b/policycoreutils/run_init/run_init.c
> @@ -235,7 +235,6 @@ static int authenticate_via_shadow_passwd(const struc=
t passwd *p_passwd_line)
>   */
>  static int authenticate_user(void)
>  {
> -#define INITLEN 255
>         struct passwd *p_passwd_line; /* struct derived from passwd file =
line */
>         uid_t uid;
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 1ab59ee2..9016db5f 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -21,8 +21,6 @@ static int null_terminated;
>  static int request_digest;
>  static struct restore_opts r_opts;
>
> -#define STAT_BLOCK_SIZE 1
> -
>  #define SETFILES "setfiles"
>  #define RESTORECON "restorecon"
>  static int iamrestorecon;
> --
> 2.53.0
>
>
