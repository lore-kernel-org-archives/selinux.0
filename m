Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CF30E84B
	for <selinux@vger.kernel.org>; Thu,  2 Apr 2026 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094195; cv=pass; b=jEdqFs3OfiFcbE4wOxEHL1WzPIl6kfedCDVjBidb2jtnEaQv3c5sJ8MLnELjYAshzwyIZnv8t1O6JXSVaWqF5VJoVo8BXyPFWcJ04EnSqR7fQcCmifXGfDi4RueClwL8t8cJPLIRKZCkHLvBh4vsY4ti/yzrXakKKraA5QEwoaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094195; c=relaxed/simple;
	bh=/Igbx8OXjgL2JcQBv6x/9Q+EbVHRxezsiOOcOV3JhjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSt75zz7gLAUCEAQ2Mg2Hkc1R34wcV3GtgMXnJ/Zvb/Kuir9DMqrL6UNxhbmVf7lKf8lQO5/58Ds8dzKODZf8bdhZXwwWkcCQ5h9SDItrAGL9gYLOflt0kYmlKn8y2cSOKLSuLVm7ISDbgujcXEX08S00ugZawhUHoZltxNbNNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2ngGUrC; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2ngGUrC"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b6c45781aso348071cf.0
        for <selinux@vger.kernel.org>; Wed, 01 Apr 2026 18:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775094193; cv=none;
        d=google.com; s=arc-20240605;
        b=GdK4SjI46OjaN5tifpkC98Qj0zSZfwMV5qP+go+Lxm/EhClyEKp0mJtvQ1xRSjaEo3
         V1PNJvtLKNs2QPLP9mEgL8tGXFOuyxpU9H84PhpxGUQRSG/k8pAffRkuVO7DamebMy0x
         VTuqTDHh9wGHIzNV9j76QNH+HFuPgtY2faLy5nf7XqN+CUQY9g4F3pXiEsWR+5IClUIl
         PrG98UhJV7mPNJV6VT3H+TdbBw81ySxNt6juEqZ1rxavjvQHuMiUkcnrHWmCiIkFfAuG
         aJrgEiVB0axoUglT34m+kFDpiubioaBb+stKjTdzwfOS47ZNtLrwEzbaER9HcxFKGju/
         JBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=onoS09RwA5OTA5gZ0mHuQpAX+KUYRKqLj9Fl9g1CDno=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=KWAuQxg+dmcQVX9fv5PBh9Y0024uNWUtMpfBC8tDD9UNZumfneILQylRcrgbI7HbXm
         bz7HIassZTIrO47a8D/ixbNwpKU0qhAigMHpuV9YKUL7OPuOqw8LPh0s2Ahm6r6wR08g
         OvlTp5YGYxVAHiig+TBMPgTQfP21rBHYSc+U8fSTvm1DsbvBqMKA0p9OD9P6jxlTvbDX
         4hXBtCpu+SkCpW1zNgrT1JZXhAnvz1EFOkm5/6ZBHq61ipwZTTam+Ek19FFCUycti+/t
         oyexNdg925954R1/+z8C9PAhOdUpxgkVZmnRBCN2Lbfx/Whn+PAUTUQVwfHkdL/piuSR
         Gzsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775094193; x=1775698993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onoS09RwA5OTA5gZ0mHuQpAX+KUYRKqLj9Fl9g1CDno=;
        b=j2ngGUrCePg7ebiVR3qLNwMd7414aGy+rieGsAAizP4EE0WQdYqTmFkqdRJ18lYMfz
         U0x+KAB7FzJesLKF5Z3XhE7XaR0WwhRm5r90N3k+t0GEtdyUq3eTMtJVN8rXf9kmG5F4
         T8GYGvKtHb9vGwqO6HpDVgbW8rKsQrn/Pl1jOvrVCP4JYE4Lw0DYcdI4kiNkb15nE4NQ
         WbC1HdCXKXLibJIIs0KHLPOtvSGcr5XnePzOyy6WDO2aj/R9spTGZwilZ+6cA7qSgbWp
         8RK0bVU8Epf/rKdTAxkkhXX4EKIZeWYmQwXr5rgG0b2yXPZHg9N8GsnJujVgUv4u4BUq
         bGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775094193; x=1775698993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onoS09RwA5OTA5gZ0mHuQpAX+KUYRKqLj9Fl9g1CDno=;
        b=ZV2rcFWCdjFlAagYQ2eFKGzIX5EIzi1No09VvKRHftvru82k86l8Ul2AS5yXMK/gB8
         uvX4g4H0vJ7PnDHbEzoetXbk9IbjVI2Ccqp2ejcC65zoWmpOYIMZUydoP49X3q8wtvA8
         GDGDXxmOsvsuJfuh6NHxUosnNDGzpxiMQyjyrQ//d5puX3GV73GM1g1t6zS3ImB0dyYa
         dBypzGX8pgv519xhhMb8xC2ngMYXxUsa3XHmwgTNDl5tWXumkVjCrqZe+/K9AoN45Wbn
         /52C1UqWKIPu73FOEKxdx7XdwH8v7dAm+Lv38Cw6ILVHLrTMwUpgpXjAqtetvSMVc+nI
         6w8Q==
X-Gm-Message-State: AOJu0YxlInYm3H+LSusf2nF4mt0jCGhMqBbCo9ytqR0CPU612rVzWOcq
	dzuwWuF1f6OPqoetJ1dYiNIWXF4F7MkFN3iGd1zqC4AEyyJmgFcm52+62CgxWBDxcJXX49Q844g
	5n6bSZOUUDxwHGVQQHKYzJLkm8ATSaRHIP1n9RmcU
X-Gm-Gg: ATEYQzxGWw9YQMFJJdQ32WXbEjNCAdD3Hw+wohwp1l1gdhL+m/lQB8EzcSLL52uyQ9b
	pLIHYPvByJPtpM7+NtPvsYg0K4Q2DVsEZSPuDF3GrD2yV0t1YBxd9oi36AOjwplxeRtQnAhhGCA
	UNwV3yUA9GctzIEgUaCnxhRimFG2q1OCycF7yzRLkUCneCf5EzMi//CBWGROz+obw1WA2WVFrxa
	20nHD8zuWimVjuHl5Kew9NpbTVfnF2cM7bk2OkdOVtCuMfz/t2ZCtKtfa/yYgxVu8nJLB+y13ET
	kLuDV/cs+z5fJvXi+HNoc5eUBWIGrWeTEKA=
X-Received: by 2002:a05:622a:aa50:20b0:509:21ff:cd49 with SMTP id
 d75a77b69052e-50d504f4b69mr2063611cf.4.1775094192637; Wed, 01 Apr 2026
 18:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320172823.97791-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260320172823.97791-1-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 2 Apr 2026 12:42:55 +1100
X-Gm-Features: AQROBzBLIg6QKtMsafmc_897DoFNLSXqD2rlr_UqITymZoUjX-Mr6h7u8c_h3VI
Message-ID: <CA+zpnLeT-vHKawimcM-7hkoF-DtHdC6c_EDB71OaitF5+kq5fg@mail.gmail.com>
Subject: Re: [DEV-TOOL - DO NOT APPLY] selabel_partial_match_all
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 4:35=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Tool to test the patch "libselinux: correctly find partial matches".
>
> ---
>  libselinux/include/selinux/label.h           |   1 +
>  libselinux/src/label.c                       |   9 ++
>  libselinux/src/label_file.c                  |   6 +
>  libselinux/src/label_internal.h              |   1 +
>  libselinux/src/libselinux.map                |   5 +
>  libselinux/utils/.gitignore                  |   1 +
>  libselinux/utils/Makefile                    |   2 +-
>  libselinux/utils/selabel_partial_match_all.c | 156 +++++++++++++++++++
>  8 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 libselinux/utils/selabel_partial_match_all.c
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/seli=
nux/label.h
> index ce189a3a..cbf4b482 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -105,6 +105,7 @@ extern int selabel_lookup_raw(struct selabel_handle *=
handle, char **con,
>                               const char *key, int type);
>
>  extern bool selabel_partial_match(struct selabel_handle *handle, const c=
har *key);
> +extern struct lookup_result *selabel_partial_match_all(struct selabel_ha=
ndle *handle, const char *key);
>

I think there is value in exposing a similar function beyond this test
tool. What about something like:

extern bool selabel_partial_match_all(struct selabel_handle *handle,
const char *key, char ***cons, size_t num_cons);

which would populate cons and num_cons with the contexts that are
partially matching?
