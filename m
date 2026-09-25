Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408C4189B9
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362825; cv=pass; b=NBpVV1OPB8rvC5lmALbEPaEqHJzxu/8C61jMcPw5MIVkwwzbV+KH+IjcWfqVtcWB8A17RdDR1V92ybBGlLJrDgX4wDZxiVmMmKQ80GZB3bBBauDlbMejhPJad1GRXEGXRjaqGUr/MzbdDoY01mNt3dawVhPGFqyZITREez4BOCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362825; c=relaxed/simple;
	bh=5aE5XwI0Rg2TLFjVgMcB6+3wq1kGsLuLlYIEpg2gBmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu+4rVSHXC5DDN6iH/ThbrZwXAFzRNbJ1Tvl0QOFC15tKVURNQ2mM08VcOOZ/G4IkCd7GltID5JJziYYukhTMplp7G8TEBjE60S5WcD2Shm929tBnW5ClFcMYs1cjhZqK7igak8YtbrllM2N0JiCiPvKXFT4JycWEdXSLA7jKtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFz/Ok+m; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFz/Ok+m"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac8d1eso10954547b3.2
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790362823; cv=none;
        d=google.com; s=arc-20260327;
        b=Kn6k8w5ubnm7vvchi1FIfCzNuMjaaent8bkiAUelZ4q9xDZ5ujYCjYcwwg5KgqrrEo
         HBa9eLU73ZJFTPNUewh1VVWxVx1uVd6eu1jcifsHmqKdRFmSonfuOm0yEc7CRiGRPy0L
         Wd9ve6s3MwxazP0GtpCT9tsNSulwvGTqHdh2oDl+RQDs7jLKMyH5R3X+E79NDHSESt+e
         o3CbFjcNGkC3pfEyruWqGStE9nlrIxHVeSHuAWdp5xB2kgV3yYv1zDkMKNyqNtxe7Ugb
         UQsiTiXtHIJPWAIN6b6TRksXrMA1TZamxQWUCpvu340pE8afaqG4kGdDrUJbw/h/8JS7
         gn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lpaO7boBtQYIzsOxIu0fqP+Yl16Eg+nnOJ+ohFG7n7U=;
        fh=z79tqBQ8pSR2qVWAywrn7MT+CH4xws/HuUMWNeUZti0=;
        b=XycBakC55stJu3LRNYhHike5f2FBx+YvLxSXlM/QV9v2EZ06sWh4rVRjznjEYjT97W
         2zIUL9yQpyTaSiebWW4EK0KS03/qCPG0pHQS6aR4sBXdXQwzOu9+DWWOD2Bsqk61BzBv
         RCIxcNuyz8PNC8SotP3c4L94XmXivX1VH+SbNpn1k5WdqrwFWgOLeMRHsekCCClqbc2u
         ScNThsuSJ5IEJth6tYmB9f8GJGaH+2gBdYFTdOBf3WAJo3LcrmNgSD7z2196aHbo+eHJ
         in4dit/YN5+b1AcXn8hWfUWpd6kh0rY5py/HsZquAYAxhkI+ptkAJfcfB0GP+CPTbPMU
         oRGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362823; x=1790967623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lpaO7boBtQYIzsOxIu0fqP+Yl16Eg+nnOJ+ohFG7n7U=;
        b=PFz/Ok+m+nn/kTjYZyPTlJm74O+ArBhrdZMqaJggOLiJjUVjHFtFYftXvL+Yal1X1s
         bkVQt77FB247jhOES56dfJOhbfPIKztf88kMXLe+naIDc5dyitgTWnuznHDSw6roq3u6
         8nX3Vy+SirdIvxuSWx5vOj+qClbCSSWX5xXVNq41GzcsG0LaG0S86wlyQqJbQS69ajlj
         IaHv94EukyHcRYQ2oIM/ysvKR1M44tqobsD8Hzjr8RY6V3M5HFhuRx3Syb7YvfxyWMLT
         e0gvVSWU4LwZb0af1pf4BnTTVC5t9E7Xvu/J28M6rgL05/8oDko+dUTJEQe8PCidK7RB
         6h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362823; x=1790967623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lpaO7boBtQYIzsOxIu0fqP+Yl16Eg+nnOJ+ohFG7n7U=;
        b=Z6v3YKryVQ3PZdSnBjl7RLr2mGWC0aT+8zxsLAvaa0POuoyKd39q0xKUeYwb+dsdA2
         UHt3XbSpNR2VVKK+JUpUoe35vKhcAdi4g8Ay3An9TlR5hzw+qIY+hWN/kmTKxXbHtfgA
         iOyGhHraKKis9EKGf/B4IfMK67ONeASHx0D4B+1lHL5ZJm/IeJzgqlO4A1qactGemFZw
         x3mRgHvgSabTAHZ9D4oU1+e1DCXwBE35hSYsCzMP5XgEcP/65De1ChqGiOwyzKksZnct
         PCFbwz15a1EJlK+wHHNHN0qUQ40g2W+n8EoxNPjpqbf37+X9PLUKeZjNIpeBCamPNw29
         RUxg==
X-Gm-Message-State: AFuF++mYf9X8M0aj8Okf+DvBiHGwsE9uswC3d8nkZKKK667y/GH8FywJ
	sO4QV6u2I/gz7Vjjp/y6ke1s4OJSbOJ6x5C2w0vUrbqHXdzQmQ3zUDFYG0079890xRutend5Evh
	BmxOwZjb5mlABm47dhVgZ+QCDI4Oyqxf1ipfd
X-Gm-Gg: AYBFou04QSZkQZxifY6/HfFUs4FZFvDroL29VTPJjx7MiaTxGJw0ZLRdFrF2VthXVpg
	sprbfPsF37HPpOmV8t7qHgJgiZwxdNSc2HrmU01AkUsfKfLKAHlItoOYFJ1nfIaIjXUg11bwjGM
	wyoJLZPt7A8B9vNAylfKmyN192SSl8jQl5kvNzwUpxaDpX2mLB2lDiA7LYhcSvIm+9/J9xX49+f
	dex8z9PIXLpmWKbNzoan+gLmGx/gmbkCJh2J3iKiABJMAjelSuN7Zpt49+litbUkIxHEIdy2m2Q
	oQe8BNpd8d/lf0NGkjVc9bFdrxzqEY9Yv+N/vWQ5YWE13SOzLrcZ8e0aZjd7wxA0KA==
X-Received: by 2002:a05:690c:60c1:b0:8a0:5ff3:7ef9 with SMTP id
 00721157ae682-8a64bd5dc58mr37579927b3.50.1790362822679; Fri, 25 Sep 2026
 12:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:00:12 -0400
X-Gm-Features: AclHuK9j3VWOmwQYZDC8RJxq34i65fY10fwSVFgwyHVDe8oHN2QLWuhmbbVpevM
Message-ID: <CAEjxPJ6dS4fsDgoFLDNUOL3a+c9K5CYWMKWtDU+wVfVy4LqZaA@mail.gmail.com>
Subject: Re: [PATCH 05/21] defconfig: update for current kernels
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:18=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Several options have been removed from the kernel or no longer take
> effect, so parts of the testsuite silently end up not being configured:
>
> * Drop options that no longer exist: INET_XFRM_MODE_TRANSPORT,
>   INET6_XFRM_MODE_TRANSPORT, EXT3_FS_SECURITY, XFS_SECURITY, ANDROID,
>   KEYS_COMPAT and NFS_V4_1.
> * SMC now depends on DIBS, and SMC_LO has been replaced by DIBS_LO.
>   Without DIBS the SMC socket tests are not configured at all.
> * CRYPTO_USER_API cannot be selected directly; enable it via
>   CRYPTO_USER_API_HASH for the AF_ALG socket tests.
> * IP_NF_SECURITY and NETFILTER_XT_MATCH_MULTIPORT need
>   NETFILTER_ADVANCED, and the iptables security tables need the legacy
>   xtables options.  Also add NFT_COMPAT for iptables with the nf_tables
>   backend, and the nf_tables options used by nftables-load.
>
> Also add options required by existing tests that were missing: MPTCP,
> vsock loopback, user namespaces and checkpoint/restore, fanotify
> permission events, userfaultfd and the function tracer.
>
> Checked by merging into x86_64_defconfig: apart from the filesystem
> specific *_FS_SECURITY options, all requested options now end up in the
> resulting configuration.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  defconfig | 49 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/defconfig b/defconfig
> index 3dcf710..8199efc 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -11,11 +11,16 @@ CONFIG_SECURITY_SELINUX=3Dy
>  # Not strictly required for basic SELinux operation.
>  CONFIG_SECURITY_NETWORK_XFRM=3Dy
>  CONFIG_NETLABEL=3Dy
> +CONFIG_NETFILTER_ADVANCED=3Dy # required for IP_NF_SECURITY and XT_MATCH=
_MULTIPORT

Move the comments to the line before and here and elsewhere;
otherwise, linux/scripts/kconfig/merge_config.sh complains about the
actual value not matching the requested value just due to the trailing
comment. I also see the following messages from merge_config.sh when I
try to apply this defconfig:
./.tmp.config.aayeHGcT54:7085:warning: symbol value 'm' invalid for
NETFILTER_NETLINK
./.tmp.config.aayeHGcT54:7087:warning: override: reassigning to symbol NF_T=
ABLES
#

> -CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm

With regard to deleting no-longer-used config options from the
defconfig here and elsewhere, the problem is that it could break
generating a config for older kernels that still required them. Not
sure if we care - Ondrej or Paul?
