Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6636195A
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768581; cv=pass; b=AWGHD4YWPBaB+mEmwAd7DhhikRkEiipb0FgYEhZNXKYyXquad0h7Wyw3qErRuiPN7MH0vbGDEun3gjX+zKNzxhIAgoAboas1QzFpRNmIZMBnhblbobe2anrCxZP5b1hWV5tX1Vj4i5nnmh6vevcqQaL8e5mBLtyBWQWaVwbsXy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768581; c=relaxed/simple;
	bh=qyl9vXLvBcM3XscoRgUXk8im0cMspVFyY8rIUOTVnh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=js9+/VqC8AHJ5sXAk24ZRIRYQhIHxR/MtztbkvlJdjnFzABP2VMu2D/HTv1Ah9MY1AM6AL/g7KoPbBO3nYhXKUfGlHeT+TJ6zLcbBWPviG1wj7CjgJ/2EYEQzi+n4G4xQ07O0u29RMtDCk1abJSpqmkr9nxGcmzCDpvk6MwaT2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGi26SHu; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGi26SHu"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb34c17b96so1414706a34.2
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 11:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787768568; cv=none;
        d=google.com; s=arc-20260327;
        b=gUPVn5SaAfjMKUrr6Q+3bIQ2i+PWLENxCKokGQ7WVo6OHtBblAUMN8VvZFsuTcD/aK
         BIRA/LV/IGTZw2uoeRz+jOBpj/WfAkCJB/fMa5KEZPR5QKa5aZz9+t3WNFMjd3T64O04
         2BpcdH42kPVtELQ+RHwoDyidG1dlWpDbvet4zY2OaJgoMS3Bucfp3GILaJ9rUKgyg5ej
         CuGnLMhFfyWhJeumddaV/WkbNAwh+6Z9dMUQNkheHGvdC4lfkTy0K8aCc54ee0b3yQd6
         JG3aNOJfH/MMt6xNBZyecoB6L7HyQLYA9ax7t1+PSVBUHXUVI3pEv5rx9caXq97BwKK5
         Kh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qyl9vXLvBcM3XscoRgUXk8im0cMspVFyY8rIUOTVnh4=;
        fh=8VGxBlUMc4oFu2whFFvkqj35KMT0awfo+JzjggYQvWw=;
        b=kaHccYbUHkK+Q6YTT5hoWBg0mmMPzczcipWx5bYYAA+cIqzUXS+b1sNeU+ZRJdwHdQ
         4PcxpjR5+pKaEfnuRQJi1NCMnr0ew5h4KJxk/1TumexrilPbgoIUmqEQNeeIhQf4CrrP
         fmMS8YVgXNSfAcYEYHrIEeSnzgsjuwm2z7ZNUkV3ucQL6xtOvaS0LGF46pCawmCTlhze
         CB/BU5Y+CVf0YcNwMiOCH1ZIULP23Utq4qK/RFaBs0/9v1VQXfDLiGPAZZGcpaQb1tFV
         JCBxe2xFGliK6QzysikMdK8KloemYHK+y0MaKovCxCWC26SuhjwXzC2EuyC/8otvha7t
         rKjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787768568; x=1788373368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qyl9vXLvBcM3XscoRgUXk8im0cMspVFyY8rIUOTVnh4=;
        b=LGi26SHuawX8BGBp2OHLFHuobNl59wm97StdWZfd6zNFCjf4s641ZD4kyhEGqa5NiL
         ltuNZobJWm5RueoTbzfRb77wUhaN79liO+eGKq/Q6i/zNgQfLG+g9XPGLr2pqEUSybb7
         +P5QJkjtae0oK1/S+NwA9Y4jQ+VO6Umri6X/0L8VzhYyFlmhLkvyuzhAhz0RQzCCzLsC
         0+ME9o7zKC8z7y0M9kRu4V3+I8En39Hv4rVFjmYMf9Gl4zfIfkS6XMTrVKcMDLdx/f0x
         T/Myzxl0ckruUh2xdoL/A7O+FMJVVYOX0c6VFxfzgrijkwhYuq6d1acRmw3QzU+GmLt/
         iSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787768568; x=1788373368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qyl9vXLvBcM3XscoRgUXk8im0cMspVFyY8rIUOTVnh4=;
        b=poBHB9D+QzxplhHxukTeDVAosHKX9iNJOJ7DJNzyF8Ykur0zT6lyMl1m1EB45PJ3Qy
         tCnFEZyPsexDvjeXh6Ns3XkdJmpnKPHV33brCm0gNWFX4ZVwfcJ1IBwhgCm/y5iG1EU6
         G5SUA/Dqo8dfm5Q5a5o3y7ghBSW+uFDAq9OjP7Vp+ORr0eKejuRLNhWbj8xyFYO0nGwT
         UJWWKsW/SgN3CvmSdASSm8mQjLp0vaTFjWtD4cyaDz4/A48s2vpexofzw7KyQGvVIPJy
         PH1HZzTK3AU0+JvcT6jx4/TGy7jG2WGRQv+1pWFmPPH3bQe4yqQQeewXo3ExSmhWyaNk
         eAcA==
X-Gm-Message-State: AFuF++l6IpLW82sHTZXkncgdG0mLOddYRVIeQCAdMyduFutdZWusDw4M
	J781RBWa+N/gMZIRkSd/3p78LgA4FEJyne+ymiYB6jxmLH6lVDHxscSEYncNjTJ/mtBeneylQuj
	993DMOens0tA2lCO1IxBWfjx6krPEvqOsFw==
X-Gm-Gg: AR+sD12Ln1YVLdIRfDZLOBVVqYOBjt6rJAAll067VrXQXALgry5tTfz+GoE16AoFKwf
	B2nZqUbPqHVhOnKdh2kn2bf/O7l1lul6GV++W1drvZrcPbLr55xh1cz/RVoVijMNGG7k+u83Ubo
	y4ZKypF5WU/JuAtKyIcvHOALu7qCxTT2L5Z8q9V3/vs64oSo160wuuaEHv11JVEUunIm8nCarrk
	IsyEIyk30GobqCYLGcmFHfZc40TIoYse6PrKNI7zdPdT2Yf9Ja4q5MexyLAaj9+2/kA2BGjGW+G
	3iFvPWgIXJqvRHNZV260QKk6sb2ksZ9m/rxj05lbaVev
X-Received: by 2002:a4a:e719:0:b0:6ae:9b39:68ce with SMTP id
 006d021491bc7-6b1a04cbf55mr6599220eaf.24.1787768567674; Wed, 26 Aug 2026
 11:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826180113.6262-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260826180113.6262-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 26 Aug 2026 14:22:36 -0400
X-Gm-Features: AcwNN1WhQJQYWejebKUMepHo5R4xOvE3EzZqwPkkSnL23EtcG3BfDZauhtZ0ZK8
Message-ID: <CAEjxPJ67kfo8sWPhCiHH1aNoiAAtdg3HccMiRZx06zEjEL4jig@mail.gmail.com>
Subject: Re: [PATCH] FUZZ.md,{checkpolicy,libselinux}/fuzz: document selinux fuzzing
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, nicolas.iooss@m4x.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:04=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Document the use of OSS-Fuzz and CIFuzz by the selinux userspace
> project and provide some instructions and helpers for debugging
> fuzzing failures.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This is based on my experience thus far in handling OSS-Fuzz/CIFuzz;
> for those who may be more familiar with them, feel free to correct
> or suggest additions! The decode*.c programs are just copied from
> the fuzzers themselves and then tweaked to display additional info;
> I also found them useful for reproducing bugs in a manner more
> amenable to using gdb/valgrind than the oss-fuzz.sh-produced build.

I'm sure we can just fold the decode*.c contents into the existing
fuzzer .c files with appropriate
conditional guards around the main() function or similar. Also should
likely make them actually
split and write out the individual files rather than just the header
info so you can have the .conf
file for the checkpolicy-fuzzer and the file_contexts file or
file_contexts.bin file for the selabel
fuzzers.
