Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B029C3FE377
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535469; cv=pass; b=bUPU//iA5VeH6uVLDAh+NoD/d7doHoRY8lnnduuKzV8jl8Fq3vI7edKkA/n915mVYsDMjZi510V4P8jjb9zmOuzXqKhg3EG3uMv1j0wZG6aipNS5f8f16OwYLeevTjfb2f6P8EGuABPXOn+I4KcuY4sn4XZ2JgQN/5J36Nsbp/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535469; c=relaxed/simple;
	bh=n18IxwlZwDULGhtSCIXDBJoVU4WOlgEIFr6SERxby60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiivm2u2PuPwsBgimXYX+lBqSZ8xrO/21CXuemfxRVp0MtB8gQ9mLMt5iQLX7I9eMWsU1UGVTu2k4XjOibDiI/F3iFqzqwNbzNVHH68GeftsqKzxebt2EMAvv7A7cnojD6E9LkHTVmydc7EWeSiUsKuQa+tymv7GC6d8sZXp2+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axndN/h4; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axndN/h4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf3781ca51so29444585ad.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 07:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535468; cv=none;
        d=google.com; s=arc-20240605;
        b=ZaXVldZsES1GVlI2/F7KaTBTBx03ewwSTkuolnqul6rG80PDVYJuaSxBMCVwv1Mf6C
         kbNLnejOeTSAk0uuj1/Y/Gxzenm2ZBklhFcFN/uJdQNYBLESxfFa7mJ7RFhGojZcNX4+
         EqmteyrC74mP7PQYxTwvtM4Ycch3KD9VQrbL1bcoOpAGPldNjppmQiFrR6AzhX8NBi6G
         rn47wPepgiSka+QB4VP524acyOPhCbVdaFAwdT7Ph7EXlwE9cr0o9j7nHq3ber4Wg9XJ
         xRRLIizRT14DITfIwTgGncTwnKDyC3qiukya5Xx0H0DXVWCS60/dAWOz+LPD/NaL7I6z
         JJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A+8JfOY4FekHsZF5qGoxO/+KR8VXynefr7zHksSFjJg=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=MNwbdQszpMGfQubaqHcSR7HKk3IXR0Tmbf1Oh6/TIdG5sMYek8pURXYnR/OC4RJsEa
         udPulcYDRUs6lRlXHuhmaHP1brwWYs6XO9vxA6tR2RkiURPU/ijQHQpdTluMQG+Hgcx8
         2S6HThEQrrRQG+0vkJ38R31yA8BuAlVY8OJFx60MizfG5CI58Isn2aSf/ylmvpz9sNfO
         ImiFtYsne8Q8S2Aj6AV17ZgWry0qFw3ndDiPK4A0FNiqmyG/VWQqWMRSBS2tjVWYj5ft
         PeNbKG0vzSBdU1r1ld0x5NA8l2HaCsfkI1E/2NfX2p8vvalLahPgEydt8uIImEV5qSDD
         9Q4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535468; x=1782140268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+8JfOY4FekHsZF5qGoxO/+KR8VXynefr7zHksSFjJg=;
        b=axndN/h430p6iUhNmmfKD/NRyAlPjSLBD9aqXxVKISIC6H0CkLrKdWbCZ0BroSHaGI
         jmWYzXUIRGqDlJVsjjkDmRDDkVaWNtpH6B4GLKULifF/xfrWb7vzVqguC4hzirSmbNaO
         syuZtD25IlGDNeE1LFU7p5vMA3r3j5AUNHRakQ7wBHeDcOp6geMTq3imCKWadmKvD+Ky
         cB+vqEENT3LlAX0tA4fbB/+2+AvS2DtjRLrhJDslclUvhfUhJKnTbBURJCRkOvR+tKX7
         Rq1gkzfjBOl45eLTCAmsibQuCyiryaGxCPhVrxAkQJRuvFI5pKDWWeRtMl1vItiqw7QC
         I/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535468; x=1782140268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+8JfOY4FekHsZF5qGoxO/+KR8VXynefr7zHksSFjJg=;
        b=JbfMCi1Fmien8hHARfLcZCgEKTi+BnPIABSejrYvo+Oq7xD3INWer7eogpb2Wr1Oik
         1NTfXe2+vF8tTp5CmrXm+oBQk+COXlS+Xzm6VClDWxV8cGZCEZgz2F5G09ayYjykwIQZ
         q5ZtPPbniofQSya7ch8kblOlYdCAdtIPV/65WGX15nzjHVsnYKiTvbZ3cop3Ol3juQAj
         +e6F1zgdlfnF1csIpCovFct/5e7ODMVBV5g7ljNteDeV6FljTr9rZpKeFBTJZU2tk3D2
         rqPdm2Acwxa8nv01p9+8a471PMUNrhrVwdpG1W+qyPSmgiseCyVd9nwx/s9Ygm5xd4fR
         3AAA==
X-Gm-Message-State: AOJu0YyotNhuo5Ilkm8y1bKp/Dn4DyV9+qDrN6nGpBr8ZU0Q+baZKcPj
	WHuhm0R7JsoOPZyVNME7IeD4zHkTjKURuAvqRz4qoCsAhFbVNtS5HrqF957mMq/cLp+P0F0mYJB
	yqSEKdvjDPHYZY7TnrayWPvxYA9nBuB5XGlLT
X-Gm-Gg: Acq92OHUop7T8mhBfpRu3YYiMIDltQdT7dG1bAm6xpBCqyOiYQkibfANXLw0FzRMiyy
	ENN+DLsEsB4Hw+MR4KZFGpiVg88UZaM7QSl/QvfZpK6druO5oQhgsk60ci5mj69BpSRD+PkpGuR
	RKdHZx5ctgr+LWp3oBLoFJQis5MeZRAxIq23dtuq9GaZKNYxKTPZyQz5br/K3Xy02peXO4wX0q+
	Fr1sLqRmmmVUG+BfGA39HBNHYQ5lIxb/jBJ7Vixk7qDNPTZ+UflmXXf/I3WSiWRtH6wkiTVf41Y
	7rTfLIE6YxB3CN0r/A==
X-Received: by 2002:a17:903:b46:b0:2c1:11b8:3c80 with SMTP id
 d9443c01a7336-2c66428e93bmr119349655ad.30.1781535468113; Mon, 15 Jun 2026
 07:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614155030.97082-1-kalevi@kolttonen.fi> <20260614155030.97082-2-kalevi@kolttonen.fi>
In-Reply-To: <20260614155030.97082-2-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 10:57:36 -0400
X-Gm-Features: AVVi8CfcwjqZ1j1e8VZEzmXnsGGCe6V3oCIprNWD58HfdOo6wMOEeRuiSpa0IUI
Message-ID: <CAEjxPJ6oWaZ2zA=3vybW1JBtK_6Pa2+7NDeb-yobTbck+AtLRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] policycoreutils: use null character in a string
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 11:50=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/setfiles/setfiles.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 9016db5f..656848e3 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -454,7 +454,7 @@ int main(int argc, char **argv)
>
>                 delim =3D (null_terminated !=3D 0) ? '\0' : '\n';
>                 while ((len =3D getdelim(&buf, &buf_len, delim, f)) > 0) =
{
> -                       buf[len - 1] =3D 0;
> +                       buf[len - 1] =3D '\0';
>                         if (!strcmp(buf, "/"))
>                                 r_opts.mass_relabel =3D
>                                         SELINUX_RESTORECON_MASS_RELABEL;
> --
> 2.54.0
>
>
