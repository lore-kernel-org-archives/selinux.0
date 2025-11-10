Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C32E9EB9
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806105; cv=none; b=InaaZtdbxswaq1hf8+bhTtL6I/tfR8rCJxOMrw71TKfg817L98Cd42yg0WSAdtghLFr8vXTZtvEipZiUCIydGd7lWK2o6tgEgWM4E17rqD2TX5yZWhRzAEOwzS5betxCepvyK57Zcljva+toVhTK4JKom0v0gNPxRNpa+FCK8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806105; c=relaxed/simple;
	bh=lCPgj9Y18gfZp0nK6sMFFxA9gs67Xl+8azZCCYlCW98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEb0EzhRCs0yyGhDtUOrHb88g0TWKYHrR6GYXpYKFZFmfA3PbCAwrU4XLR5XKHe5so6jemMcVyY9i9hjMIvbgtCYFFc+OTaRtTXnrXrjupNRWUnuaJ9BanMiltn/LJiWPz/9AHp6r+AWbm1DNOAXAdu+OmgHiCF7KhNKAJhOa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOR+NO11; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOR+NO11"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-340c1c05feeso2859662a91.1
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 12:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806103; x=1763410903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wlQguBFNLT9kUkQqzflQLmfjmxbToTvQBVEHoioKj8=;
        b=eOR+NO11T7kaRC006IiHfungDAiOv2KWvAuaqbShrRMe1ClkfqpCkK4KHB4ZVJsn0J
         nwMve2X0DFak31lsFpxarjx3DR9Rg9z4v3RFUmH/lW6L/OObE71idLT2Q/HL4cbMhJ0f
         qBFxT/6zxD4Ds5XjL1RLlMPs48XMigfqzCo0Csu6TVYARWXJyWljW+/uk7Pjbc9+8WxN
         yf9ye08CK0ievx9dF84MpszRNtWk8ZYI08FRKAALE1gr3TfYOJRXsTF5uY5ov8AV+hpf
         bbNThZPeXm03NooLgGONjLV0cnGEVU0umhNvex6MXV1nif71Z9dOwjWRWNpWfsZACzJj
         GefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806103; x=1763410903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/wlQguBFNLT9kUkQqzflQLmfjmxbToTvQBVEHoioKj8=;
        b=deiSVT1CL8XJf4iJXG7j3W+pu5RnblYKiXGHUwtVPSFuV89BbWgicXIAJv4AufDSoi
         R2uurTAyiFKrvpOAdqaA95MWypWXBKPDX2WpPSbfNcZYR4GBIDJTIgOPF3tbt+VeLmA0
         pHn+32Q0t5UD+YPJ3vt8oPJTS9flE9i+U0PGSHyD/edz2fOic4ySJlf6k57xasCQAAYS
         cX2Uw1MfnhV2dSgICadO8oRV9tf2RucDdsu02FdPIg57TLKgTKv9J/yVSqg15VYPJzbd
         r1xCpFHXDLnvyEJrT9XTsU1K4MLdnozg4zKJhccN03kyH2+5FUH9P8zVMkHSV947vF30
         1xfA==
X-Gm-Message-State: AOJu0YxhbQRt3o04KrIJyUz5Vv8o05hnaAvz42rbgfqQOY90JybB1XWF
	PWDfjxTm8ths6+e/kTXQeQJFBYJL9LD+RmGBd4emXd68wpH7343Fs7C5IDG4g8LyCB1k4Vz5wfK
	OFwzq4WqC+P+BHHDf6tk9pMN94faTvikSmg==
X-Gm-Gg: ASbGncuZtq9caah3uVkcxWEZAf6V3J0+0TJv38GXGJ3s0+nmt/yvuTWvEIQQn/IXjeZ
	6F+KrTa4DyPM/Az4wAg4SBYRmjFJ3UendDBt6s1eLu4+uf/b0YWaajXmwTH8eA+wjNgTyXW4elz
	ndXZ8WBUc286MkE5hrhz4GOcm8+CTgDSidsYjy3w8JAmMCqNcyoDM0hKysTmqJic4tqfsPfnMYL
	KbgNlQxCc3cRBeRCZW4N7tpxSzkUqlu+PQmzmxou4CVVr+auv1w9MDhLTa46ZmKk4emobA=
X-Google-Smtp-Source: AGHT+IH0myosHS1qVMs3xgcxyMHwHaYj46q+8Pv+sM3zeNQHGVHO4VVBCMXdiWrIcWyk/iJ6KTdmCWGBTK0mCboA3Cg=
X-Received: by 2002:a17:90b:2d10:b0:32e:7270:9499 with SMTP id
 98e67ed59e1d1-3436caa6ba3mr12123278a91.0.1762806102961; Mon, 10 Nov 2025
 12:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110180935.202229-1-vmojzis@redhat.com>
In-Reply-To: <20251110180935.202229-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Nov 2025 15:21:31 -0500
X-Gm-Features: AWmQ_blGRFfXFnIwjBdjlGuqDeadv19HQODKIMnYM0cfKEC1-YDkgnxNpgkEY4k
Message-ID: <CAEjxPJ6oSRpAJV8fPYVnOqtRff_GqXGa7vhSrA9XQqDkx45Z1w@mail.gmail.com>
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:11=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> This is useful in case we want to check that a remediation using
> restorecon was successful (otherwise 0 is always returned, even if no
> files where relabeled).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libselinux/include/selinux/restorecon.h |  9 +++++++++
>  libselinux/src/libselinux.map           |  1 +
>  libselinux/src/selinux_restorecon.c     | 14 ++++++++++++++
>  policycoreutils/setfiles/restore.h      |  1 +
>  policycoreutils/setfiles/restorecon.8   |  3 +++
>  policycoreutils/setfiles/setfiles.c     | 24 ++++++++++++++++++++----
>  6 files changed, 48 insertions(+), 4 deletions(-)
>

> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 681c69db..6e9a159e 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -69,6 +69,9 @@ static struct dir_xattr *dir_xattr_last;
>  /* Number of errors ignored during the file tree walk. */
>  static long unsigned skipped_errors;
>
> +/* Number of successfully relabeled files or files that would be relabel=
ed */
> +static long unsigned relabeled_files;

Looking at skipped_errors handling, there is a skipped_errors field in
struct rest_state, which is initialized to 0 in
selinux_restorecon_common(), incremented on errors only if
state->flags.count_errors is set, and then copied to the static
skipped_errors before returning. Any particular reason not to follow
that model?  Otherwise, you seemingly don't handle the multi-threaded
situation correctly AFAICT.
