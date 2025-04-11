Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75027BF77
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399215; cv=none; b=I0ZI2QxUwR6uPGqI24tQPNRf5yPqITUCbPsYyA3W21h8CeKLC/pnfsGF779NZM2ISMEaFfmgoartxw8vSxkSrSjlghBoOot9iK29PrpVHZNk9o5bEBikzaNhGL0BN3dPp/VwBBPAWV/hsz1gdN5OYeQ9xtcGlhco5S3sxriMfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399215; c=relaxed/simple;
	bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIHTEHYsym0M9Ba29NcRMdGTglnRvNqFwPPGZfv1HvIR4UoES+IymG/44wpMzgLCV4c0I7RUijTa4mFcVuE4vv8Sb8FeEiBnvh5CZuUmM4ZbNX9YIs4ZhF0XzBzBPFn5o07DxmEdvagZH2ZjPF9vwmySD4faZZjUVirUu92wOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XT+hUKYL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XT+hUKYL"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so316742166b.1
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744399212; x=1745004012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
        b=XT+hUKYLG9ussuY9QStIWsO+NRwf71+8e9MCCCvImPVfbTh7mfqsTd/sp9Naoa8fEi
         dF4s3Olq9Cf3dLUMxOhCTiTq8rwXZ0fKJiR/FFg7qxfpBGOUig84RaBCqKDtsFDfdQt4
         D6q6IOyx3rTSQKPs4MlwmUnTLKcd7hYc7RTSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744399212; x=1745004012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
        b=oLr9v8jE7paul3J1k/pA4bfUUQ8Q9oo2HSwan8BERhzMx7pAAHKC69gbFk2xeVZcEH
         lQjqwsZRLj0m/cYYdNOaQLBNElAUkOqjasS9D4zaqwinPUp+z3Ne+82uym8NYO3q2l4Y
         WsBJBuZnlkmN0DPbAAkFPyFR5h2KbfcvIHSppx45nEJj/PARiOS4tgz7mmYBfsAQpY+f
         qwJOZUqM8cIPWqUMhoYikxBdbVMvoDUE9b/9XWbsVnIe7iybGtufTrsizueXhb0/i2mj
         n9B84pGHsCm0hMbAJz/0SqK/wVvbV+KrTphBMOvaXO9I1xrOByX7PiQgbC8Qs5absalv
         tUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAFfBwsOdNQEVs9Xlu/glX1qvoNVN+YZ3+Q4mKpLEJqVKPi717Vxzwfuq+iFuLRSZjqmx3yaoj@vger.kernel.org
X-Gm-Message-State: AOJu0YzGeSwqhBnfKpUYoFPJnzzShgrTSYBiiBPRJrVVZ8ReXQ7diLHO
	1I2pEHkmPWPwcdz8N4SjFbFnHg894oc1TMqf5SDabAk1x5myS4g1c2AsGzGK4eZV7DRdbougxm+
	SILlht5MsHZlMWGFX0LA+alGkHNDU8fyzwKna
X-Gm-Gg: ASbGnctUityUG5oHNRKxmYqXwryZEk27milEpsi60m41OT4JS0n4aMA5r9j85oSVITz
	8NwHEXgpJmr4kCoFZVnvyXzWfpHssc2GuNxUwH2Qzz2Gb653sIDC8UHzYf6hONdyuOeDmZuHNn2
	Zi6qQWsdTRD2jj57K5f55qVv0=
X-Google-Smtp-Source: AGHT+IErO/wFycetDqHLZ59nJlqxvZeRR7iYXzNYsaGdLraNNvnVeWXTxdCP3oc+y0OVwxcW9yRJa73Xy0cfI5TS2Z0=
X-Received: by 2002:a17:907:3e0e:b0:ac2:55f2:f939 with SMTP id
 a640c23a62f3a-acad3446cc9mr330029166b.6.1744399212186; Fri, 11 Apr 2025
 12:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-53-paul@paul-moore.com>
 <202504091643.3C42B66ECB@keescook>
In-Reply-To: <202504091643.3C42B66ECB@keescook>
From: Micah Morton <mortonm@chromium.org>
Date: Fri, 11 Apr 2025 12:20:00 -0700
X-Gm-Features: ATxdqUGiVvNux-N2_Zf2iA8S0CxC8AJE2HGWavCv50sc5-TRBEPKBa8mI6Moi7Y
Message-ID: <CAJ-EccMhb+Ry0bW8abExkE5V1wJe+CUO_Ty41UHsH-s1ZJdDhg@mail.gmail.com>
Subject: Re: [RFC PATCH 22/29] safesetid: move initcalls to the LSM framework
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:43=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Apr 09, 2025 at 02:50:07PM -0400, Paul Moore wrote:
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Acked-by: Micah Morton <mortonm@chromium.org>

>
> --
> Kees Cook
