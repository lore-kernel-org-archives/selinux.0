Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9E359A6C
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092297; cv=pass; b=qJYZuDws8RVij6cYTYXlA6K1Z+HMe+JCOhKhmemy8gs6ErfaQ8uiMJvZGkuURr9j7+Ym7boatG54VPZPm0wwQ3h99o/PAl6i9+X7ZubbKNva88SQZs3hP3xDEiEqCznLFbECwjPp/ZnICLdUp1JpXiGqKhhMOvu/RWHfzWIJbYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092297; c=relaxed/simple;
	bh=K+DQeIHhDYeEgAWeAYkQESZiAh03A8T09tWWEkqBzKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvKPjMBNw+Jw1hS63RNGHGTnuTUOlKKXlswSeWZ8MZxVbkqeHqb5axhGnhk7V0OxT3D9afDhYfGw41Xud63Y7eSi06UoD0j68VGiervLQwGJD2ApCjgznivWu+pNFYbC0JXpsS3BL/U1qJK5jJ5C/tF2iZG/Lvead/1bJ6jxbzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAIo3PMX; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAIo3PMX"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6587cee8b57so7786100d50.2
        for <selinux@vger.kernel.org>; Wed, 06 May 2026 11:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778092295; cv=none;
        d=google.com; s=arc-20240605;
        b=jjOHP8j2Bag8eJlb8YLFHXxAOVp9glJELCuOQxMZkQsqmeKvTzKOy6bAA2XaKI1Yop
         3OU/2HjAi7cA9Epo6IK4VA+sYuuPD8yTOy1L2BZE0ZBBNYcW7o9osuAiTVrNdZt3k9Dj
         0c05eC1KVlPTh5eZOAnGZC3Csd5tnPzcDZDXBn9a4CLUTBV9vBK4tC0i84rOCVJRTUwD
         vZqJEUjc4mRBIJSKryytofRYMGUjzB5cBhOWYTpIBRzlvXt3ZoqIrvR0tu35rStVCJ2M
         CWWuKTdPDP/cjGW+LskyE9sCBBl/r3RTMrYqmArGArkauWa05QCcP/aPmwmODII16P81
         iwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9akTSwlreNemjDDl/tav+BImCnfp28vxpIgpi93G6Ek=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=ZnUr3Ov6zmhRhJe0XpGYC/ACqeNf+k0dVPa2HEDGCItEiMkic8WyuAmhaWwaVrgsBO
         +Imq+ILlg+UiiizRHNVDzwOR8x72KucQW+fUW71+ZnHFkQasnqiArzgq7s8soUC0lwd4
         yficjssTO75jAEf8qlz3WwNoZA/LMC1f3RhKZg/G7D8zIFvtBeY+vRgeIBGxGXO3026E
         L6lZATa9wDqsPCxDpkN9QUEu8UyAYRmw11Nc646+oWWTDGeHjCQ3soIgmFwFWmX/Z8mn
         qtaj0iexJoWR/C7IMvX8JSwK5d05fnzNjv4EKf1a7BHL9wVh7IwfiMHCZG1ofWsgq18B
         DHRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778092295; x=1778697095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9akTSwlreNemjDDl/tav+BImCnfp28vxpIgpi93G6Ek=;
        b=GAIo3PMXfYwj6sLJ/rOabPZQcJSDQ4O+MZ/iFNclypNGkvv4PdtqmjnCp93gORwZBU
         6FOyfWwevSdXCuw6uBZ4JGzsAkM7Hs9R+4lPsQvNNVcAg/pzPclXQsmyG54U3kGwq+4o
         5YYzx55jUHVZ9x1dSdQThuxuV4S3RzSccW85tKrszzgzFOBbLfModfSzfJITNydQnfw0
         OJAXnaPa9naTq1/QSpdYATIVWqIuqzYk+7OCqKu04R3eZWc5Vl+rdhPYOHMfGK1f8gmM
         7FgZw0xuunfF/fPWM4u35vNNJjUjpa1D6cc6Np6+LsoWy/gxBDLG1T2ZuO1HmlAyaQgn
         qDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778092295; x=1778697095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9akTSwlreNemjDDl/tav+BImCnfp28vxpIgpi93G6Ek=;
        b=NPE/WAGGNnB9ttBEJ1/llqWjjrO3jUzIMt9EKc/7ChkKp72nJ2aFNrk3n+4NxVtFDV
         zXTkffO5ADPJpf34XNS94HLv6VOowz+7NKDncbENqtFbcfwZJVDQhh20QMA5pwvf9RQt
         x1kMa2Euh3HwLDRFDncXYspMcojVZ/Y9oHEepCg/738k7nRHVTXXRcJuNHTKhHCPrYAW
         KgsXGEIvsXMJvY5v4hDBPSRMLPznTXoyBIppDEr2WwBD47GR57Xb1lZ4mX3Act9nKWwo
         2GY5bJl+Joi1gmfGGRjwwOlJqO7THzZEIFyQPTu/bMJIg6vzQJ/gnEpRVrWLvy24xuef
         kZsQ==
X-Gm-Message-State: AOJu0Yyq4w7yOjlZoebpqy0KuhPZTHt7SL2Nmwpv1ZLLDf5Q+uxRHq6Z
	EpagF5+V0UbHoYZ421QUgJyvv5377AkkHgEDE5Lz0KbeObEk6LqvoPnNWt12M6832Mly1ef20Hx
	PVN4kPJuCZVS+NoY/dMZE7SZiyzkO2szDaQ==
X-Gm-Gg: AeBDieunzMB2o0qtebdjqV4HXQqNr91/y1zZ5NrFaSwFllydBjmnVk8wN6WAJA6Qwh8
	AB8H0ZH43s9+Qq+0Fm2c9R/7PoPxMTJbIiZ3r2UIMePQIOok0fdBelFW8ASdfdjjvv1MPRpwewQ
	pJRqogMNq55avBrJ454gxMFbaGzaeDIZ2h3gwsIj8p9QwrWop6FhiHtp0i7hLLkta3wXhWXWVsN
	VPvvfZV3RlO+Sg0sihHYutSJ1YJMes5FzxbgS/8mw2tLxAWb4jLDlNLeDQU89Id/NNXf1II/ejy
	CaF+E4xFuII1qEZDoA==
X-Received: by 2002:a05:690e:14cf:b0:65c:febd:c0db with SMTP id
 956f58d0204a3-65cfebdc973mr1904540d50.60.1778092295323; Wed, 06 May 2026
 11:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aftvCdG7qZ5TeQhI@14-5A-FC-31-E8-67>
In-Reply-To: <aftvCdG7qZ5TeQhI@14-5A-FC-31-E8-67>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 6 May 2026 14:31:23 -0400
X-Gm-Features: AVHnY4IZ8uoqHEjqcuCjOUptM_Pca0wQUBEQI8S-Egig0RPws4MWk-lj8daPMk8
Message-ID: <CAEjxPJ5PVu=ypZ1coyq5B9kNNFkyE2s2HM2m+fmBSBv=ObxwHg@mail.gmail.com>
Subject: Re: libsemanage: why is expand_check integer?
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 12:42=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Hello!
>
> libsemanage/src/conf-parse.y: why is 'expand_check' conf
> option type 'int' even though it is really a boolean?
>
> expand_check:   EXPAND_CHECK '=3D' ARG  {
>                         char *endptr;
>                         long value;
>                         errno =3D 0;
>                         value =3D strtol($3, &endptr, 10);
>                         if (*endptr !=3D '\0' || errno !=3D 0 || (value !=
=3D 0 && value !=3D 1))
>                                 yyerror("expand-check can only be '1' or =
'0'");
>                         else
>                                 current_conf->expand_check =3D value;
>                         free($3);
>                 }
>         ;
>
> Many other boolean conf options are handled like this:
>
> disable_genhomedircon: DISABLE_GENHOMEDIRCON '=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
>                 current_conf->disable_genhomedircon =3D 0;
>         } else if (strcasecmp($3, "true") =3D=3D 0) {
>                 current_conf->disable_genhomedircon =3D 1;
>         } else {
>                 yyerror("disable-genhomedircon can only be 'true' or 'fal=
se'");
>         }
>         free($3);
>  }
>
> Is it worth converting 'expand_check' to be like this too or
> is it wrong to break the existing configurations that use '0'
> or '1' as values?

We should definitely preserve backward-compatibility for all existing
userspace configuration files and APIs/ABIs.
Some of us predate stdbool ;)
