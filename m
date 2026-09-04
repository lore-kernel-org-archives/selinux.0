Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502674F30E3
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535007; cv=pass; b=mOJdAqOrfzQXP+qyuT5MetdKHf6Z0Y4xCDUjUvC+nHhDbElUGaVv0n9TrOKLpOpRcTRMBeLdntqLYjZBwuzFjECNJ7E3Yz376wClTOLlu19crDz462+F8wwDIlvrORgvRX8mInA1YlzZNXw5MhceeyDu44RCUzos+fI7gHqPDZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535007; c=relaxed/simple;
	bh=BAAOSW2Gbeh3TubkI1tO900bFBpi5DIBTNmdea8nqQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnyqMHORRWW6I3cGwHON9/uA8hzx/zF5sZeuPaMpvCydHRICzU4cDRfxY3W+mulRiiOF1dXSxRmBWPsQ5h+0H/jiVnzkPj3wkOI4GcUzZg2NCPRFzcif+1I4QCw7KtqiXxYnIgLEMTHllPS7iEIRBivWdvgDq4svRhZHL/iQxcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkLmqiIL; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkLmqiIL"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-46556b9e02cso870899fac.1
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788535003; cv=none;
        d=google.com; s=arc-20260327;
        b=l9Mp9JW9Pi0skvVNSvZANdi66Sbm6f582W3leMR5SQ84ZsbUa+pfr3/ldlZtGbSUye
         OYuvXbwWLzj6lyVOy4u6bvz62rJK3PdS+/s+ag+ikRnrrpZ3VpZzKwoSdbvehtw5SkWI
         q9wP3KuX9uhAcNDcy+uJEh5ENKZf8t0+bJwIEfqA7z+DReh0xU15ZM55gVGazWAqanJB
         brd9O5BJ9egqTSIwmt5z/nbCKNzBDZ6V8H/l9hbjZVFIhchJ9y8LaXoOqq/v6fqGx53Q
         LWQaj4+u0/KfbV/s/8qL3Gw9cq6ncyzKWM/ExSRmBJDgn6U6tCYxAx3zD009lLAO/fxu
         MwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DVQsTmpc+g1kpLzmwvxDl/9kllelpZ5pZlj+dYP2600=;
        fh=i8tZaMkZTypcEH+UcGyP0vRsVnhTalTQAMJmsiOpATk=;
        b=qIyquCrnqln62Swb9J2jUdQIo/vcX0A/X0RinW0KhMEOpwjixHtBTwoq8ce1vUo4lh
         ntG2+kUxmNFlgrU5Wfw25G2Mm4STvBW+9SkrV40XhYdAzr4uqzIMuBDvEygfnYPqdtAD
         eTBzF8g/2RKdXj5zlDynG+NlifNCtI4s8Xs83lgYnUQG+kYL9ieAcviBNbuUyIZvtsdM
         0bR1imTk7n6FPYQh2YJyBwNYIF/03En4sxjtTsqd6c29xq7f55ygQP6PhGscE+qXFIrN
         LFKk+YoFCJgoLTC6lj95qgqG1PbgNKjuh46Gg6J5F0tfNNIM8725B7LbX8He0slN1fKH
         WNTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535003; x=1789139803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DVQsTmpc+g1kpLzmwvxDl/9kllelpZ5pZlj+dYP2600=;
        b=gkLmqiILjS5fSEXdrmP8txgICa71I1Zz/AltFuAJJ4KfSpPBD932BR7rmdwYl7ysy4
         pBGi3vpk+Jhh0Sl3jmYuLyFA7ga/eLOi69VgIqfdT69eDW8ViXp1ZelQk+ubE+edLAB8
         MuhLxO5oQ6GjKN0sL886l/nV6TMSAK47DVOBTP2RD1TwZFZ11izDXph422Mi+tsIQtHf
         gPaTk0G7qjLEdIOly9RE4Y7OvxUP+6lCpuYpTNjviffP19tbpIf19pwaJrcyUPA4ddJ1
         ve5F8KD4A5Gx73KTi334+9xMMjQauBlf0vkMjqxn6WMRFx47rBGRJTz2xgsu+d6yeh7s
         Z8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535003; x=1789139803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVQsTmpc+g1kpLzmwvxDl/9kllelpZ5pZlj+dYP2600=;
        b=IAvS97/OFPEMv+86I6NOKk9vKe3VRIXlGLz9v/WDyyQGR8g+sy8HYrWDL2eU4gpvhR
         FqGv98u1kuenqQw+5guIBHX1JfVtlJbkZFHPGEQr4tAZfZZa/UuBzGV17vwIdWejugST
         Sagc4WTMh0vEoba/a9Y8GhnvNNRq98o2deUyQhuHTWEgLXxL34kQKnetv5MCrHcdwK0h
         eyJwUX4UuX6BwGcIOD5B1Q5232N5ON5mxo6YEudmQtnCIv/fRmo5W97yj8JkoiYqP7Xs
         0DIJR+PX8lSynta0KhL3JVcG4iFzyIsyfp3HriBHuX1SEujTzZJFyMgcx3UTEJjy0yYi
         sJHg==
X-Gm-Message-State: AFuF++m2RhVNMr42aWWrQCZRXWsdj9vUT1G10OPEQaNKaoSmae4V/+pv
	4pVt3Mko37v5ZqYQSSorRdK/xHzagRboTpkU23BuS5Q/EU6y/i4eA0QnNOOqORXA4uJoPJ3uMdS
	22UQuKdV6ldsKrW0iIDD5I9WXhoG2CUavEg==
X-Gm-Gg: AYBFou15MQaRupB325lRx8I8R6EJj9UiwT1VMgNUrAt7O5zBxq16CyYGOoKfPDUMr9q
	y1AcyX1iGVTkzLi3NrfW3THrKLVm6EoVy22tB6yDF8enQeBE/xmBHVqgtfl2MZv7PSfEo6mCJRP
	qtAfxvw/Tv/AYSUkDFys4sOvHAL5HH4sOha7XJdU1IoLdBRXi+bh0ohdKVqib7rKGZYz4kcvAQz
	ynxdWQ1X/kFYYgYI5FcAQ2+jNVsu8Lf+52DX9QHoAKnBLZ8wVTQiO5kn267QwQJR70ekFTR4HkR
	pUpov3BOKKIaX/tFu/s6vCIfelrmaR5wmR2OUpSnUTMd
X-Received: by 2002:a05:6871:c8c9:b0:451:ca58:626e with SMTP id
 586e51a60fabf-4708380ae2emr6480657fac.8.1788535003321; Fri, 04 Sep 2026
 08:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 11:16:32 -0400
X-Gm-Features: AcwNN1WIiSAIHen913_--55FW_gJHi6-No8hjCIajs-68fO5wimAoAVJxPOTJow
Message-ID: <CAEjxPJ7jO+CZ_A856Z6yFkr4Nr6OgxreaGfr1vnbHrVL_aYbDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] libselinux: add a configuration-root search list
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com, cahu@suse.de, bigon@debian.org, russell@coker.com.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:29=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This series is the first half of addressing
> https://github.com/SELinuxProject/selinux/issues/33
>
> It adds a configuration-root search list to libselinux so that it
> searches an ordered list of configuration roots for each configuration
> file. The list can be overridden at build time via
> -DSELINUXFALLBACKDIRS=3D.  There is no change in behavior as long as the
> files are found in their default locations under /etc/selinux; the
> fallbacks are only used when those files are missing, e.g. upon a
> factory reset.
>
> The second half of this series will address libsemanage but is not
> necessary to merge this half.
>
> v4 drops the /run/selinux directory from the default
> configuration-root search list since it is not required to support
> the stateless use case and it introduces a potential risk of
> any domain that can write to var_run_t being able to inject files
> that will be used by libselinux. Distros are still free to
> add it back using -DSELINUXFALLBACKDIRS=3D but if you do so, be
> sure to create and label /run/selinux appropriately.

This series has been merged.

>
> Stephen Smalley (4):
>   libselinux: add a configuration-root search list
>   libselinux: search for the binary policy across configuration roots
>   libselinux: fall back through configuration roots
>   libselinux: search file_contexts files across configuration roots
>
>  libselinux/src/booleans.c                     |   2 +-
>  libselinux/src/get_context_list.c             |   6 +-
>  libselinux/src/get_default_type.c             |   5 +-
>  libselinux/src/init.c                         |  12 +-
>  libselinux/src/is_customizable_type.c         |   2 +-
>  libselinux/src/label_db.c                     |   2 +-
>  libselinux/src/label_file.c                   |  49 ++++-
>  libselinux/src/label_media.c                  |   2 +-
>  libselinux/src/label_x.c                      |   2 +-
>  libselinux/src/load_policy.c                  |  24 ++-
>  libselinux/src/matchmediacon.c                |   2 +-
>  .../src/selinux_check_securetty_context.c     |   2 +-
>  libselinux/src/selinux_config.c               | 179 ++++++++++++++++--
>  libselinux/src/selinux_internal.h             |  40 ++++
>  libselinux/src/seusers.c                      |   4 +-
>  15 files changed, 283 insertions(+), 50 deletions(-)
>
> --
> 2.55.0
>
