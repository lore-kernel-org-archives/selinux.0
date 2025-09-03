Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2F2DF12F
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930057; cv=none; b=PQFMrbiqHefy26+oHAofsTUIbdHbyy+HQFxn0Wd5a4D+8jWnHf2zuZdcpj5bv0/rNSb8uMewbI4Lv5oBbaJFeeWqtdbUqts+ihmApXA+FOXWkkVhww3BGbU0qSBfCzGGExJXAsoUQ22c+mvKC6KBE4B3Yw+lVElEOIJIaENW4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930057; c=relaxed/simple;
	bh=yngmQ/ltButix+LVvtj/TMZq5fYiyFfS8swlHEL00yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POdbR9bc8JpFMOKaLyv2nBGWEu6Ymnp/g7HtoFPfpfyqF8XJD9CzEA/uwRRB4Jfk9vl8om7nJSmSa7HRD5QlmdM6kQomnIgct5yPhR2YqhOZhJlAKJ9BuQnVgVMSo8KbF9CITQI2MvwWnrg/ruAzaj9WtPeeQEvvLUfxiSD8nGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F9NvoDhl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F9NvoDhl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cbd9d9f09so3488195ad.2
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756930055; x=1757534855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7BsOvy2TQZjlRoG4f8RUy2TF7CbbV+kzDpz7/CPYH0=;
        b=F9NvoDhlAY1dl1glMsWEDjRfa0U//fMpkgS88uoGFcco6dl8m1oNuNB26SUGgwlUG/
         m+WojV14evsY8vDoqkVXyHzYsHdA1gmf8CmDMhTTcQ34rMyeSUbT3pRLhWeBL0ZkViGC
         dQUw0/g4qTjdMxbfHE4wzX4eCJOrsV9vM3c+5aTDFVjf0x8ChrPxYq/Wja2b6zKEhh4u
         2yrnDKbPtNa5xm4OQposUE8dY1hkucCl/KaYPtTGwziGajWiZg4eJOKNUiPjc3EXrzYB
         i1KpKWlFKX695pTqVRtpvgrRDY4yDuCjkMueHcb92zM8woATwBVsL22IFsOti1cukUVa
         ecWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756930055; x=1757534855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7BsOvy2TQZjlRoG4f8RUy2TF7CbbV+kzDpz7/CPYH0=;
        b=NVCdQrVR0MUNAWZItxF55GxJTIM4nnxr3BUtI4Br0Pqo9enPysbfC7jTwZIwoioHPl
         j/hDH5owZT1X7Q5Hwyfz7QcgqYX7vaXLKJs0vDs7nRWpJVu3kEQ9EwBVY19VszmtBI48
         gLNCLHHzwKVptM4MCSITsk8ifPtUrjiLSRmOyr60vwtt3k5R+xdZlznNufw7wOtrMQ1T
         yGdcL+RysFWRoCaB03hT+KoXAMv/Xo6fMlPV7WUUpWUQeja5eKG5u4i/RkDFYUTo7VJH
         atR4ErT5qPQs3Nz9A0nZ39saI9jVsz4kWtLWoMTByKvxqCZTxcZsjR4O057JOEfupWwR
         lmEw==
X-Forwarded-Encrypted: i=1; AJvYcCV8mWs3b0vxKDqdBWWrcprI3SJUU+zA/++mXN4z7AOCtP8Y1MuoX1PrLBeUnaX5VZAqsqNW5l8G@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8oPSnFidIlI3KDWiIQjYPcDCPJUmNny3OpxWZL8JKoTmLxYa
	4wI7YXsxrq79ZkGIreGzCuXwIcGSYJJ+j+mKZOZL4Em3rEja/Z5+zw8+Et7V4nisnG83Nyd6wDr
	pyNbtDA5LUvjWI7XE4emRmF3DiTjKXPhlKFhDGJoS
X-Gm-Gg: ASbGncvrdaMMDkPtyxXXZ9TiTq3jt6rpO8lQxrKBhY9mV8IpTsULqFdo3tqVy1URCd0
	uU6qbeHlWMU7EA+wArmIK4aWOlbOY8ekWwhLudbD4cpKUGhtqps57XG5h0D/geWknSOK/g0tdPj
	bLX2CoKPTcIJHF2EX6g2SC5OBDSP0qsezKeh6fT429HVRC7LNNbz/MFY1SzLGqgdDn7uPw0oeA/
	y5BcPBs//bKwlGKnw==
X-Google-Smtp-Source: AGHT+IE/jxp5MGXQjY9oGumbm8NaKpkAlmwUE6015x88FR0z5hTMAkqxHgNJHhqTh4+JXLWysrNaHK0JYJQoNh58kjI=
X-Received: by 2002:a17:903:41cc:b0:224:23be:c569 with SMTP id
 d9443c01a7336-249448f4103mr192848795ad.22.1756930055424; Wed, 03 Sep 2025
 13:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-40-paul@paul-moore.com>
 <e3a54d30-85c4-482f-be91-6d10e0ff6e0e@canonical.com>
In-Reply-To: <e3a54d30-85c4-482f-be91-6d10e0ff6e0e@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:07:22 -0400
X-Gm-Features: Ac12FXzD41H6XFdIb0vdFaRxcoKu4oQccezb2K9_6QR2TZu6fu1vwmKFxGVeaVs
Message-ID: <CAHC9VhRUNPbHnjoOuv+Yby0WPSztSFJJ2GT3NHu32eJxEjiWmg@mail.gmail.com>
Subject: Re: [PATCH v3 04/34] lsm: introduce looping macros for the
 initialization code
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:37=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 8/14/25 15:50, Paul Moore wrote:
> > There are three common for loop patterns in the LSM initialization code
> > to loop through the ordered LSM list and the registered "early" LSMs.
> > This patch implements these loop patterns as macros to help simplify th=
e
> > code and reduce the change for errors.
>                        ^
>                        chance

Good catch, thanks.

> otherwise looks good, and you can add my
>
> Reviewed-by: John Johansen <john.johansen@canonical.com>

--
paul-moore.com
