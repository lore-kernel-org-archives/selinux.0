Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA03ECBF5
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969909; cv=pass; b=Zk0y4LAC6vM1jnFdanTh7D+zvvQ8HZQ06t/dfSEj7rOhBBV6hwDtY4N/jxW75UZ0O2VlMFBBasCnRiqvBDTPTqkntkdtpYfB3M408dMrW1c+IibNhfZEhKH5d0nOFPvVdh4tdNa9ieOxzThBRaEC6jgZlWp9ggDNv+GsSVHCKWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969909; c=relaxed/simple;
	bh=xsBUuNHyJi9yrhsvrYQPnMsYSonpH+BAcPOtIOEzYI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naSdbHFV3RSJgh/VJq6Pl9bMilTH11Hwn8XD4ZwJ5qZeYI3Wr48ZwNjp7J8hk7jRSW4VnYyKkeZmGHQX2u+H+nnHK+w/5ckQLAnbCU7R74QckTV6XU+2spbTqCPEA7febD2R6dfwsqRdkBk7sZe9u0+i1X6vHcrFF3EknrN0s+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBby5iq2; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBby5iq2"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67568357b63so360147d50.1
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 12:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790969900; cv=none;
        d=google.com; s=arc-20260327;
        b=II0cHIOZHz1Js5lPfYvU3HTjvcAKBoQziQwJzkgnOxAdN85pBQzpUkNky1hGfjGDzX
         l+o6uadFfR+B5Pz64fx3AsdG9jH6ITiDzYslq5baoSOKwoyan3eOhx4lKQcoeEZZn+OY
         25oiH3WUvtP0CcNlLH0xREGrJLvhNeIqqTltqCaJ2dR50pIpD85CdYBcqxm550V16AI+
         t1nLLc/ADS4x6wyWJlcIX7h0Wwgm+Z9htOjHyFl/i8xzKKpw4ujOydtk13H4i0ivXg4A
         WXV+Ecghj8UhWclvQm9ZXyO4krEtcye3qGkQ7a53CP/n9L+tuTblKcPd4Z5FDcZ09/Ep
         1Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xsBUuNHyJi9yrhsvrYQPnMsYSonpH+BAcPOtIOEzYI8=;
        fh=E95boLTiTkq8XsjKw8GK1wyz25DmW0RgNCvDUxEAbME=;
        b=XYb3S0UOJa4I7UCNlwKAnLxsrzUzwx/vWn2uSaWleG7L+FYBhjGnWTSGZKQOgDFTCp
         YRaBk6fAi/Y95l7l71Qk4cML4Zy0IZzFCjbI7jiynQF39usQZmfZ4bEVDVhaaw6IvcUf
         dh5tFm2nkPD7Yl0rp5Qq7saAT7X6roRpg1w7BXJso5YMamhuXs7uX9tLNr/MhxB0oZSm
         u3bcOxbiQHcBGIpiKyg6GVCMBjHXCIKzDubMeSCuttJylm7Yz+4LnJZZKQ36rysmekks
         NY910K++su13z/wk7oIPaXCY2BqIF1/VSgWQ+QR59WEM52Txc9vouDSuIxYp2bSp5ZKH
         bMSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969900; x=1791574700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xsBUuNHyJi9yrhsvrYQPnMsYSonpH+BAcPOtIOEzYI8=;
        b=XBby5iq2xxYKRVsT7WaktE5wxh/IAkSTlJcdV48fCrE8LlAS913xjY5pwc7rJsSiZy
         TzuCE94GEI4p4B/mM4xQGq8+iBFaKB0NEm/Wt1kxITjnoCh4UWq92Y/EdWiKrvPk+4n6
         vpKDvwCfvF5LhBpl0ex6X8m4EgLn3z8KUlM4UrDhAJM6zoSILsJRzOblyWVcro7U6m6T
         +Cff8NGI8xeCgr+u7Mt1u1Z56epjGixWk+01zQL94MlsInijhC7hpwYPx8suhJ77arcl
         ogP5dnpTJgOxgCM19oa+rqlQ8Kh7+dKrrTnPT4kyfz1cxXc4mWPR3zl6LXDDrrT6f3nz
         JTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969900; x=1791574700;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xsBUuNHyJi9yrhsvrYQPnMsYSonpH+BAcPOtIOEzYI8=;
        b=tyvrUAdIIbluGmVeMWIMUKThlStlB3rbRMnUCB/ZrC3IzKTOfmCjluViwWKcarxIOk
         mm2ZM7ioAU3pNrozNyZ27AJiBW+ylDUetuCZ1ArijldK/NQ0Ume8sR8lE6Km8gGcbov3
         Sgwxx2PzJQq/Yomo/U1StxFIex2S5MRkyLGUD31TfBW8ddedhWuatiAULAO6xrl6fDhJ
         3YyYQiq/vBeGr5/7n3nM/lpO8CaLBNLGJHOqt66NTunq9EHzlZ7KJGGhKe+tZ8wzEuxt
         bHqiwjsJEcUk7taM/12xcW9kGTuEikI9bgddklmKC4NE6BC3DDvt2zOIdg3dFd2mh1+S
         Xtiw==
X-Gm-Message-State: AFq9FYLwbev62fIWz0Cp6TR0uc7dXCNHsiFoWx/t73fe1/wVOb3WT1h/
	H3XAKqdBsi02wM4kppHVgkk1PkJKZwbYadiOojtlAtVHdeyAStdueOJTi8KQzoMvjbduMXocKvx
	i3eZyfPGwxE1oX1M4JtpbaOV6akjTZiAcqS3t
X-Gm-Gg: AYBFou1kCB9lE2Arcl3sK/d5TjhvBv598lMta4HR4Qyh7osv6+iXCZSdzjDOpkeQgRe
	HTgBenxzNGUFUdmy7wQZg+Qq2wPiBBOgQA0yOZoHMrxDJPeXKnjFNr1nnpa2QC0NUEz7PqBMacg
	f0Hg/8ebY1RPskJL6tvOJFQe1UQ25l5vv7tdb1ND+nnbAkiynEMGcDP+jdN5DI1qtiolKm9U5Wj
	BcJcPh/dOyz9tCNGCUfKhbXe1bGKtpsHpgUVStOhKnKzL+0CbCmJuelEySkoQQEiz7HvJypX8Nl
	+RZ71saQrJYPtcjuMzBghPx/yY5JwbEdANXgHZa5Ut5ICuAgKutHtpQ=
X-Received: by 2002:a05:690e:484e:b0:674:17ca:25dd with SMTP id
 956f58d0204a3-677ac0e12cdmr1143209d50.78.1790969899686; Fri, 02 Oct 2026
 12:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001153212.102261-1-bgrech@redhat.com> <20261001153212.102261-3-bgrech@redhat.com>
 <CAEjxPJ4mjdBgTupSCGqrpwe=6=OURSSvewC+iAhPAQF0c19Fuw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4mjdBgTupSCGqrpwe=6=OURSSvewC+iAhPAQF0c19Fuw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 15:38:08 -0400
X-Gm-Features: AclHuK94s6jwRlX6aei8FUPdaRnDakzR4vMxJH7zR8KRrpgxJJyyv5f_HRHmUc4
Message-ID: <CAEjxPJ6V+6abL3ZTEU=xBS2GamNWpbnrGyMmMQRy4x-arK22CA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/filesystem: probe ext4 quota support before
 enabling it
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 10:15=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 1, 2026 at 12:05=E2=80=AFPM Brian Grech <bgrech@redhat.com> w=
rote:
> >
> > Add ext4_native_quota_supported() and legacy_quota_supported() to
> > Filesystem.pm: instead of inferring quota support from kernel version,
> > actually create a small loopback ext4 filesystem and try to mount it
> > (with the native quota feature, and separately via the legacy
> > quotacheck(8)/quotaon(8) mechanism) to see if the kernel can really
> > handle it. Use native quota only when supported; fall back to the
> > legacy path only when that works either; and skip quota testing
> > entirely (without breaking basic ext4 mount/unmount tests) when neither
> > mechanism is usable.
> >
> > The probe uses an isolated tempdir under /tmp rather than the ext4
> > test's own $basedir: per-filesystem test directories (tests/filesystem/
> > ext4, .../jfs, etc.) are symlinks back to tests/filesystem itself, so
> > writing probe files into $basedir would share state with every other
> > filesystem test, and incomplete cleanup (a stuck loop device or mount)
> > could corrupt whichever filesystem test runs next in SUBDIRS order.
> >
> > Assisted-by: Claude Code:claude-sonnet-5
> > Signed-off-by: Brian Grech <bgrech@redhat.com>
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch (not the entire series) has been merged.
