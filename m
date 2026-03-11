Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5904275B18
	for <selinux@vger.kernel.org>; Wed, 11 Mar 2026 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195331; cv=pass; b=BMRDZHz0gJ1s471GcOO/zJ6ilXIcYTt2xQ4KI0CWb0TFUkayScS4WvOQfKy4swJqCnUIwWeiSX9+hg7OGpCP4EmWc74iMVeRoZskLsUj2n+E6ybLjcUzmvxN2rMsL+FNdOgjR57chgVWX8yaxYjsRAPocDfxZz9C2WZ/WgTnUwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195331; c=relaxed/simple;
	bh=SutPZH+yNUzgc9sFqTxrctY8Bd0g++uCdgG9EV/j2b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwWfSi68ePNkGWqa8uH6mM4aSgXPg87V+uk9g4KDIbxP4TJ0WuLQWTxFT9RlMK9nKy30uiF+6a0J34rbP8/r/r0kSmTG9N0TWB1KFI2EYHVLcjVZp6GMGBkyhvc80uFVp3IMO0qE+luw912dMLszLXftH1K24QtCLxMsuvt7i0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XK1bda1P; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XK1bda1P"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-509069a7a7fso313841cf.0
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 19:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773195328; cv=none;
        d=google.com; s=arc-20240605;
        b=GCUJ1H51UKzSYTT0aVAaZJUbi/29sibJIELHiDEJiQwnrPXtf3OtSnTwFFSp519GK0
         8NZKNOmiYPcU5ySqEALSE6mQNG5UVsmbtVuCI1hbcimZSYtSjoWSEIt4/8efAM5Cj8v8
         nBlTQJuupa1SKM4T24RHufMYumGCG8lRyzibPqfhvH9O3Ien8mzk1+Kr5Ad8h21XATgh
         Iq4EVxjWvwLDun1rgEuue3aYe8cu+mfVq2CKvcyUpjG08BF0dMblI0AimlW7yyapSnRU
         6XtyvokXOcNJ0K72Ik0Ff5nidr4QNhmxvwThiU9MxiRrc6nT51ZE9r5+/06Aif4HQSFI
         PsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UN7UAKWIi3jaHEFMhI2+5QzAeYC4yQwkvEWwHqp7e6w=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=QCUkxDTzGOJEcaOdUDVtXz04/OBy+C5D6wrlZf8S/UizpOKzxNwBnhVpyFlq/CVLLK
         0hrygVxjoGgSGbQxum1Da3v+HqPuelJHe4Pl2eCFkPJ4exJ9wSsmtJ0XZ/fWETDZwCPt
         yvUVoUOIYupST7/PQ6M55qz/Rw4LgZX4CNPHG5xcxr5iWeRXgGvGFnbmen0eakuAWMhw
         SCZ0AyEj+TRDLCkhLdK46dfvkECljS5DMVpNmO52x4eI6rppmyKKIM1ybdvJacNKHmCJ
         m3DLghVLhZxOMKi5/uTKgoHhCzw+SUDCIqCWAgpkUGGFTV5dNOvZIVQUxlhHXMf0JAUR
         X/FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773195328; x=1773800128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN7UAKWIi3jaHEFMhI2+5QzAeYC4yQwkvEWwHqp7e6w=;
        b=XK1bda1PsRCLaTzcRu52pQYbcKwQxoHn2M6/u3FCvwdCzCP4MIRxRFBrwCm06mLVS8
         uyMqAP7rQAWhHKE1+uqz+kEbOGplOEdlV4JGg8lw60IcKKOhV44POW1/jp0NNQM7K2QO
         PIHXsuUGTWoTbWJBLL5wvIqJoG7r8UU6GAaVNDnvgWb9pVyqfiPE2cpmz+/l5A6m05Cc
         7c1L0JipZtaks2M9v1/Nmo0+e2eLORSb1JLhxkHqMXLrwwkdLpjLQugFazFnzj3FHhYq
         ZOvHOaFbqTrL9YoJE6QJ5wQ70JxlrX2Vf3jqOQcsyAvhTrIH4nG4+HMNhtP3eSXrNGyz
         /eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773195328; x=1773800128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UN7UAKWIi3jaHEFMhI2+5QzAeYC4yQwkvEWwHqp7e6w=;
        b=aTBLL1Syc6h2sl7s/hhDM2VVXLdB3KaDh28tlogDNJ8xwi5tJIg/kWPXGbhOz71VCV
         Knu1kjBmjMbov452Y1ebHIqzVXcvjaRRQ9T+E1dhkqnJ5DUM8DbIXrZgJSRL5jKwSslY
         qjiZaHdQp382f7ccWMoMi222BJcnRdf/ggu3ap57KC0Ii0xry+5kE+WFy6PhS724SHjK
         s4xIErte7ZQ2irZs4AHq11fWUplZq0ADlrat+BsrSkSRxx5XeOZ3KwC6yGHyGl04Rq6a
         M2TgPmBGuQjoSVcsd4SmMzvVbO4gnuDdhHMFqM9L/6FlHN/XARidx95naxEDQUOOtnh/
         5zYg==
X-Gm-Message-State: AOJu0YyAsv+fSIWz17B3/CpcLUQu3TTKUx0gLILFch/DXC2W64Mmas7d
	BBgouA5UGc4u1Gb/raJTwsHo1WxLfyToLD7sc+s1r3eNbvNnyymNBqlPewFufMY1nTMnRcFubMH
	wtwhAkzthu9VezOLy2hl8yTgybbiW7pTdBaG6zmwe
X-Gm-Gg: ATEYQzxUCzAVEeZC9xSRY9QOLdLUN+rrYSsuSTfSx79/vbF/nYnKAahhW7bP786plJq
	aSAuEVn+dhtEdrSxep6Hdv0P32TwPzkbG9QxnsHJASz0/DcPMsfcsPHTwnat0qUPPKT5jXxXfjM
	WniS9urXxAMfQoNL1Q+tvV85fw/zF3UXTqbu6b8pgdMGS/DxBO0YeigtglC8xDpG49A59u6FHtC
	4PPOQxZhavsT5V4CyuHp5VAO3lw3Dxo3AqlKd/rnSEAMMMp9/8WMa4D7FoX1YgjaDkHhKWyDLpH
	fAsmj50dmlMINpxUiBVrHguInzd0JumehiI=
X-Received: by 2002:a05:622a:188f:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-5093827a1ffmr7214181cf.14.1773195327979; Tue, 10 Mar 2026
 19:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309144132.3039335-1-lautrbach@redhat.com>
In-Reply-To: <20260309144132.3039335-1-lautrbach@redhat.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 11 Mar 2026 13:15:11 +1100
X-Gm-Features: AaiRm52CUyu4hP1eZS6EQp8zCoLXOF9NxwyLBe1CZCpt4pyboe61em0FqkaBrvg
Message-ID: <CA+zpnLdbwgWWXTVPR_+jXB45i+PCJHk1nsL0FgXOGvnsT7CbkQ@mail.gmail.com>
Subject: Re: [PATCH v2] Add support for UTF-8 in file context labels
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:49=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> - libselinux to be able to read UTF-8 spec entries
> - libselinux to compile regexes with UTF strings
> - initialize locales in setfiles, sefcontext_compile, semodule
> - semanage_exec_prog to execute external programs with LC_CTYPE set to
> the current environment
> - disable UTF-8 support build time using DISABLE_UTF=3Dy environment
> variable
>
> Fixes:
>     # cat unicode.cil
>     (filecon "/opt/=C5=BElu=C5=A5ou=C4=8Dk=C3=BD(/.*)?" any (system_u obj=
ect_r user_home_t ((s0) (s0))))
>
>     # semodule -i unicode.cil
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts:  line 2145 error due to: Non-ASCII characters found
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts:  line 2145 error due to: Non-ASCII characters found
>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid=
 argument
>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles returne=
d error code 1.
>     semodule:  Failed!
>
>     # semanage fcontext --add -t user_home_t "/opt/=C5=BElu=C5=A5ou=C4=8D=
k=C3=BD(/.*)?"
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts.local:  line 4 error due to: Non-ASCII characters found
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts.local:  line 4 error due to: Non-ASCII characters found
>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid=
 argument
>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles returne=
d error code 1.
>     OSError: Error
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
> Patch v2 changes:
> - add posibility to disable UTF-8 support during build time via DISABLE_U=
TF=3Dy

Thanks Petr.

Tested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
(using -DNO_UTF on Android)
