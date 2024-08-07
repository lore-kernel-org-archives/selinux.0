Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5782D83;
	Wed,  7 Aug 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041429; cv=none; b=OXVUIxtEmN5eT8tCVXvYair0WTK2hdnWuabSp7PTmhUUIJGlM8TC3MaxW6IH/5kOc3ty6kxCSHp/VXaiZnz9kgCGCRKhRRyEUdeLisLiMoUC0Fajk92Zvr10V5tRua4koEnBwFj8vhU6LwiHDGSgzEqHZA+tNWS2DY2JV4+FjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041429; c=relaxed/simple;
	bh=OvsePmij4+qC4W0XpuSnvTsV4TtAWofQcxSiTpAA81U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iazg0Qo9WcXwW5gyhQaMWW9lxc4Q8kScsIgae9wyKBzvZzd+uqfLjZKWwICvIM0S00YjQTYMi7j5nWzaE4RjoT7AcyqTH0xw4/lKdDGdhl/Fg1aJ7m51xT7uwNV3qsK1kos9/KZ94lCwzMKH24na2h6ZZlZtOmh25j/RTOXnijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLfFGb3k; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLfFGb3k"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso1473002a91.1;
        Wed, 07 Aug 2024 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723041427; x=1723646227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuLdRBZiE9n4+MHp5PGhajsyIvVYgnsZblL4IXj+RGc=;
        b=YLfFGb3kWldgzaEtH9CIodOR9pCFGlBBYSQg+y/UsHsCt+Ozjwtlrevl7Ae0xAoxxF
         llC8cbWb6IafSI7wInNbjbEubmbQVizN8IKKSuxoRgCD6x3gWrE0nfF+h8iAxNi61ShV
         TQbeSHnvRsApgbsPWIiaM0YcET1W7eJE+Z1KrKjqxh5hpeyXsBaE3QjqfJW5l2i7aOML
         OvqA85Oo3fjP4vsStFICtf1WpU2gvFoECg0LmM22uaTd46kQWCrE3TwRqR6nDN6T+iJM
         8vEW3xV/m2BpgK/zfXjvqc6bXD/2hFbyqtxPMw3t9j2vhQ+/z0+yaoe83haCeJggNCr8
         HpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041427; x=1723646227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuLdRBZiE9n4+MHp5PGhajsyIvVYgnsZblL4IXj+RGc=;
        b=vi7LHHWe2YM6SAwHMzCFFwSt1a3BQU1rT4y9muuzAQcXNYh+oasuAqS9U6BcKwdTgX
         rZyoRLHHj98llg1X8aHqsGUKPUHkdAPv3mJ4EDREp44bYgu7KNMFVCZkiEChXATR+ZME
         Xe6PR/1t002i1Hxwiyj7/KPKXixt+zoUijDlaSZYbYLvqFaIB0081PHA6B770iag3tCe
         6JQrV094l4wE6Usz1v1+XfWBjYUrifvuOKFJIoYdsz791DXMuFcony71EHceb9slMIKK
         nkbRbhtM7f+EsrhWDlev8nYN2ZhBjYy0I915vBn+Tcvah26j1o0OZpPOZRLvfKIQmmhW
         8BWw==
X-Forwarded-Encrypted: i=1; AJvYcCVb+Mvzc4hDFd7P7I1kLGtbw3kgNlJvrOnENMTVlBDwQdfyYUbUyH2pHhIteUAj6mNABCFVNw/iCTFEPYzXoym2xdcj06YDBpfWvu6ytmEBl8dfn91UOfdyEUPVkoRhAQvH1vaqvA==
X-Gm-Message-State: AOJu0YwhJPso5mlxiLXuZ/9eek4AixO2QsqMwlf2ymiqHsAZXzSgaqvY
	BhuHI52HsEl0IoZ3y9jn7r9iBz1LOWfl67X/XhUqRF9cC86DqHj7Fn3f1VxD4oHZyI3Vv5szBZi
	Z85YSMDzJ34e1DRku+RinYJ07I8A=
X-Google-Smtp-Source: AGHT+IFlLvDiv/HFD9TrRoW6wsN4VyG2V9kNVMnuTY2clV+LzI2BSWPAt4ZzooRHLhiaelzqc9i1X9y7/GL61gSRECE=
X-Received: by 2002:a17:90a:5586:b0:2d0:d82:60ae with SMTP id
 98e67ed59e1d1-2d00d827ab8mr12757085a91.37.1723041427326; Wed, 07 Aug 2024
 07:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807090057.1334-1-thunder.leizhen@huaweicloud.com>
In-Reply-To: <20240807090057.1334-1-thunder.leizhen@huaweicloud.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 7 Aug 2024 10:36:56 -0400
Message-ID: <CAEjxPJ5jKHVqCD7dZUK-UYq=op6D_rC6FmnRvQ=sk9uwuQ6sUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux: add the processing of the failure of avc_add_xperms_decision()
To: thunder.leizhen@huaweicloud.com
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>, 
	Nick Kralevich <nnk@google.com>, Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 5:02=E2=80=AFAM <thunder.leizhen@huaweicloud.com> wr=
ote:
>
> From: Zhen Lei <thunder.leizhen@huawei.com>
>
> When avc_add_xperms_decision() fails, the information recorded by the new
> avc node is incomplete. In this case, the new avc node should be released
> instead of replacing the old avc node.
>
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/avc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 7087cd2b802d8d8..b49c44869dc4627 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -907,7 +907,11 @@ static int avc_update_node(u32 event, u32 perms, u8 =
driver, u8 xperm, u32 ssid,
>                 node->ae.avd.auditdeny &=3D ~perms;
>                 break;
>         case AVC_CALLBACK_ADD_XPERMS:
> -               avc_add_xperms_decision(node, xpd);
> +               rc =3D avc_add_xperms_decision(node, xpd);
> +               if (rc) {
> +                       avc_node_kill(node);
> +                       goto out_unlock;
> +               }
>                 break;
>         }
>         avc_node_replace(node, orig);
> --
> 2.34.1
>
