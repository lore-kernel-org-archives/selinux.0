Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E1190068
	for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125418; cv=none; b=EY2HwGcEoPDr030qG8+oxHZA9T526kP8Pv6/aNekuHQVKhdJdPPQE7hZ/2Fu7V/JwwIpZSIiLeMYXTUN36D5LUlDFMsd0WhHB10Nr2uMW2nRXttxZ/RplSY4DiFz7pN9/VKMvYwCJ6SYFXJvfszs+1yt0V+l/kQHxt7x4WjJ+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125418; c=relaxed/simple;
	bh=OsP7YfmVJz/ye/aM6syJnsKI/TzCrVmKfcolN9R05ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOJymmVgsUbER9kymJV3iBm2IyWFCCb+lS1afdMcAEIJtlWG5p0PEf4KnmZQcgxYzI5KTtCDTYgoPVfIwVNAebPHhJJeyGiX67bkAp3syH6JSSGxoGnuaMnJ7cAcX+TZaEClNrhmu4o7+KiMjAGb3oHbjGozR32lxWtncJ5uZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Phr11TD3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Phr11TD3"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eff5f99de4so24124827b3.1
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 13:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734125415; x=1734730215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taoEEuTrYij6+ncSg28ADxWB4TOlIxR58EZVlJdDcQA=;
        b=Phr11TD3r5ZDVjRRHb5RQdGpZGluRBgbuStDhbZStwu74ckkftFvdUO3WY9XfraOCn
         QXsDH9IVcIfDTT24Ldm2g7Z5A/JF3o3XZtMOcQfVFjCfwMqur3tYQUXG8zqgXz/3tHfa
         ZGD8GMBLhUkXIE5KQmhQ/BARvjiTq3jFegY77+QCb9JsQ5oKF88zgeyMtgQnvxHCx4Ju
         YW+FsOwLuF6vXU3+xZm59DP0jzRjdt3+RI0LssztqznbQQeCY9/U0ddDT+xG6XbMCNRL
         /Cs6L4rSvz7pYoShDmb/Q003aFbd/hmF8tRGjAPp5Um8+qohR0XrOht/eTZg/nC9+y0a
         ySYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125415; x=1734730215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taoEEuTrYij6+ncSg28ADxWB4TOlIxR58EZVlJdDcQA=;
        b=QqxlovDsiE1e59fs23N6V97lmx/ORIIrkrz08REAyDRj/7WHVBJ6QfxdF7mRydXqIt
         1Hs11PB7DErWEY8RhbuihBaMsIrofn6Jii89cRPOSfp5FLuqXR59tnRq8D77i0+l1ahA
         eEE3DUK+RmpBwGddtnX7E5hM+6WtMvMivwB5wegcJJa6lQrxSseShXPqS+E2+b6c8hCN
         nUVmTAt9HWwmpG7PpNo+Lxn6OFVizIm90CtKLkzs8bbKx8eRaKsY7PgtgllalbOepaNO
         twwGyxXWTyse03Y5shG1STum3SakjJoVv8JQyjpEoLmXXQmK7SzRAj2ovMWKMXf9X59L
         Hwbg==
X-Forwarded-Encrypted: i=1; AJvYcCXcoz9pzw0quws9O9Pr/mmOpoXn/9gQe58YleCdO2q2QCNYxXjLGpR7gUCHijJRwcW1Kqy3wiqy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CO6QxLOMFEcfrUWl7MFjcaiKQdsV+6bPDIQ+8OhnMbH1C4RJ
	MIzPrxf49N1PL3mExTkQJ9vvXGXmFqX0CbUoRSatCI4yBEHdyhRskIOGnmAHXuTvLXxlc6E3Iqe
	tX8JI4IzXkEG2LK0OLWIfqV1D3xv3N0O+XX6R
X-Gm-Gg: ASbGnct7WtxF9tBVrEuj5sVfKH0/850wvRodUgHiocv2qSfPN3jWaxsD/QGjS1WSckx
	h/VY2eNVKFbU83OXx2GTO0vOT0AK6vv1iKJrE
X-Google-Smtp-Source: AGHT+IEJFvwuD1oOC0Ge/s0L2rONQiIC9ra7DlBYSFRKXe4LuqkNBwpqHI9THHCn9mo9jGzPFqOEw16IUqELl0cKkJU=
X-Received: by 2002:a05:690c:39d:b0:6ef:7312:d05c with SMTP id
 00721157ae682-6f279ac65b8mr46998237b3.2.1734125415337; Fri, 13 Dec 2024
 13:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205012100.1444702-1-tweek@google.com>
In-Reply-To: <20241205012100.1444702-1-tweek@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Dec 2024 16:30:04 -0500
Message-ID: <CAHC9VhS=_ZExOUQAiYEwkTEnpT9xNJsj7g7L6HMH2odWX5GxUw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add netlink nlmsg_type audit message
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 8:21=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> Add a new audit message type to capture nlmsg-related information. This
> is similar to LSM_AUDIT_DATA_IOCTL_OP which was added for the other
> SELinux extended permission (ioctl).
>
> Adding a new type is preferred to adding to the existing
> lsm_network_audit structure which contains irrelevant information for
> the netlink sockets (i.e., dport, sport).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
> v2: Change printed field name from nlmsg_type to nlnk-msgtype
>
>  include/linux/lsm_audit.h | 2 ++
>  security/lsm_audit.c      | 3 +++
>  security/selinux/hooks.c  | 4 ++--
>  3 files changed, 7 insertions(+), 2 deletions(-)

...

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 9a8352972086..70444230e56f 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -425,6 +425,9 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
>         case LSM_AUDIT_DATA_ANONINODE:
>                 audit_log_format(ab, " anonclass=3D%s", a->u.anonclass);
>                 break;
> +       case LSM_AUDIT_DATA_NLMSGTYPE:
> +               audit_log_format(ab, " nlnk-msgtype=3D%hu", a->u.nlmsg_ty=
pe);
> +               break;

See my follow-up reply to your v1 patch.  Assuming no objections, I
can change this to "nl-msgtype" when I merge the patch; is that okay
with you?

>         } /* switch (a->type) */
>  }

--=20
paul-moore.com
