Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B93A6EEF
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696016; cv=pass; b=g1NhkM6lkvYse1zCmgF4KQhl8Fkcra889Sc/RO0+YtBB7o15bD6bIzfQDREncaKuJ83ZUuIwVTtoqeVmoemzMa+RcCECf4AcWp3Kmnt/itGH0PNq8fRF2LjPJnKrxsybTGphAJA6nMwpxRxFpRKdiFvgSFLSCqlZOWuOkhuQJpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696016; c=relaxed/simple;
	bh=RnvtRzElHuZ/OT61q2zy9aHGf5xAzq3cy1bMkEHmbqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlSUmzm3hmAMnVy79frvSRz4xdOTs3RJRQzxxNmkuVGpQtg1+kl34++8mqkBoHgHLYrwlc6cE8AJmzPv4X6aXbHLVz4hD0ruWbB5LPYZXBpYGqpIjHipI1T6aavpsWzaJQG0ovsv7mYdZVLiS2A9oGI3PXF4K/p6Maah6sB7t+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imv1p4Ag; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imv1p4Ag"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so51941021fa.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 11:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778696013; cv=none;
        d=google.com; s=arc-20240605;
        b=dWP2jfrBwwDRf4fmh3QyRrOr60o0tzMSPZx0Tlf+pix529eqp5VunOXwUcfcCSLxTB
         P+fmiTB4UNt+W52o34bAFnNWXSkVJWmxsXZmsOsI05RUmVigD0DJlSc16bhOOKuJwzDH
         VCmu1i8Ra+soUOcW5E0xHbla91Wt0Fo7+bgKGppIdHK8MrmqRs9w1d6Xv/3I6YHS5SGa
         XnIL8HkYQU7PHnjmKaXDUVmxmE83822vALIeS4EzanW+7Cqqb9/S4B2dP4CV/TSYLdWr
         ERm7dpcXcyBxJRURM02lp6ViyZsNHgaw/U4A1D69ADnzRx8JUuUnunocZaMHG0EaLrqw
         LjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E72y0SQZiZUSrFM+PCnuqhxyxhSJFu5wKbctBBOWB74=;
        fh=+SOaqlllj/x9oPTKUNrw3U6f73KzX4NDehXGGqjpy64=;
        b=FxsRuAMhdO4UEJJ0LC/mld0IPiPa0cSiHivYkqTzPz9iKbcMM/UZZBnhyaqINFHSKG
         q469OkYZRAd8c8qCc7cZXPzBgBrXiaHUn6Jw3WKaLjV+VSJLeGhTX9ESdMEQYBc06V1W
         zbUZsHt93KbH5hlo7pH3X0BPTnt/DycBnxNa0BykoWcJ1yRbUEgc4nUvG2vvsCDbpHiK
         L9zZ392Ivk8SkzJ1wyT9M+NRzB0311R7KIzB9+PuCTkuq+ssC/cGS+/uuHsuFl7FIhRu
         QlaHgrhYR7De+/h/lzkQ6wll5tRsYEBpB+rfRzk+O94uVq0LygePPo9Zkuisx0vAl8Uh
         n21g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778696013; x=1779300813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E72y0SQZiZUSrFM+PCnuqhxyxhSJFu5wKbctBBOWB74=;
        b=Imv1p4AgnezGiAOKp/xhZgSwTHHC0YLzOwBO9ZN9Pa/DmHLG8oeH1e7KpG4jdqwOZm
         iY/htK/qR2FmY7Bl1Dcm6CDK+RELf2TrtF9iXr2Kdboo3lj5a5W3IN+L0fwtspIX+cn4
         i2CW4V1KApk1iI7I+IMD+B6JBYOs238tJFRKpMgVdFsal/rRHyi75v8DZHXDMGneQnh/
         l0aE+pLPHh/luGqxKn+T68TjO1ok6L64+Ky/dAnATM6DA5pnYZBmpc7LtNSwYJaCothG
         UwDt5JZeJdja6BZb9tY5/AgdG1iBQivSBp298MKNA3+oJTNSEgPrsqTXFISWhX+3n8sk
         OtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696013; x=1779300813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E72y0SQZiZUSrFM+PCnuqhxyxhSJFu5wKbctBBOWB74=;
        b=KJU0SuaC2fHkIzJnHF7svlOKgK7yk2z9U+Yvuw3/eoxCrbrR1cl130VG7I9YGToYlN
         6bN5W65RD3Y5cv7iYuxhhBqCRTHC4m8NMgqFbIQfpd2tATDvdMuPCGtZgp92DvtGIIk1
         4gb5taBd6PFQRycY/M3067XFv6g/811KS5EDp3pMYe6V4cL2jz2tijMk6NXtHM5VsRlT
         Hon70QpTZ7hmbEqH9/z8ASWdPYg10NzoqPb84oQl4IaZ6zp5GQvGadFbnNHqsVB0hGe4
         Cya1BwXNpDNnLqRyhDUojsOEkfKb3CLYiEiih3NaWYvCeVKWlH04WQZGifLFeeP5/1He
         jN2g==
X-Gm-Message-State: AOJu0YwV/3gvRmDmxM9XaR0AjuQivCW7jsge/Ll4W0JTYYvgnCBIPSMY
	up18XU6jwQih8NGWYgsC+hwfopGf5fEQNUrDRCQUwD1AivBS5vy/9/hNfLPW1H2z2+Gd6n+PZ4l
	xhh1EK2KUsVU/IAGSuiC3NCFGu6lWCO4=
X-Gm-Gg: Acq92OG1Mj3hI1Dz/FRrSl8emJZawEHT5PCqyTwqFixS83QTKsUUPvIre9MSWs7sWKE
	SxhZeMxPySGaoShd1udly6oyxuyGeGwssn8AYmn4ZPuW/gQu4lEoTKgD6jTL/4O1mvN41W2gTTw
	bGaozxrUuKYHpmhhliQctmLkxnJYPk0aXxAJPmXigdxO9RomPubOh5MMj5IXjLHrxH/YEo6lfBU
	WaqAvBVL8tGKhlaVivNBhe/+QsaPtLBA04rBUYLLvBpXkkbhgElVaDrHwpVun5L66EMDhqdVfa1
	oM4y1z+9AWGHFIc=
X-Received: by 2002:a2e:b8cd:0:b0:393:d706:7bc with SMTP id
 38308e7fff4ca-3944b253828mr16026251fa.0.1778696013197; Wed, 13 May 2026
 11:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430113302.2841721-2-cahu@suse.de>
In-Reply-To: <20260430113302.2841721-2-cahu@suse.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 14:13:21 -0400
X-Gm-Features: AVHnY4K7IXUQwfmvH4XpUviryBaUp4lknFL0zkWc3GXquRCoi29y2YZdgdq7hRA
Message-ID: <CAP+JOzT7y0dMq5oseWN+86Dq0Mzv0MOK=EUquhLVLnvkDNna-w@mail.gmail.com>
Subject: Re: [PATCH v2] restorecon: Only log error on readonly fs (bsc#1232226)
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com, fvogt@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 7:34=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> Problem:
>
> Before this change, when restorecon encountered a read-only filesystem,
> it would set the error code to 255, not continue traversing, but
> continue with other paths:
> "restorecon: Could not set context for <path>:  Read-only file system"
>
> For callers there is no way to distinguish from that error code if it
> encountered a serious error, or a read-only fs was not relabelled, or
> both. However, not failing when a read-only fs is traversed is
> acceptable in most if not all cases.
>
> This caused issues when e.g. restorecon was used in autorelabel
> mechanisms during boot to relabel the file system. When it encountered
> a read-only BTRFS subvolume, the return code would be set to 255 and
> we had to fail the relabel service, as it might be a more severe issue.
>
> Behaviour change in this commit:
>
> With this change, restorecon logs the encounter of a ro file system, cont=
inues and finishes with return code 0:
> "Read only filesystem, relabel not possible: <path>"
>
> Other mechanims that were considered to fix this issue and why they were
> not used:
>
> - -x skip all subvolumes: break cases of subvolumes which aren't mounted =
explicitly but still need to be relabelled
> - caller generates skippable locations and these get automatically fed
>   into restorecon: error prone and needs to be manually maintained in
> certain scenarios
> - caller ignores non-zero return code: not good idea, it would cover up
>   issues that would be hard to debug in the future
> - skip only ro btrfs subvolumes: I started writing a poc and discovered i=
t is not easily
>   possible without either pulling libbtrfs in as dependency or having
>   a lot of ioctl calls which likely will lead to performance degradation
>   or tracking the btrfs status inside of restorecon, which would be a
>   big code change for a problem that might be also there on other file
>   systems
>
> Discussion and context:
>
> - "Question regarding restorecon and btrfs read-only snapshots" Thread:
> https://lore.kernel.org/selinux/98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse=
.de/
>
> - (open)SUSE bug: https://bugzilla.suse.com/show_bug.cgi?id=3D1232226
>
> Signed-off-by: Cathy Hu <cahu@suse.de>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 8fadf4d2..e8545e27 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -774,10 +774,14 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
>                 if (!flags->nochange) {
>                         if (lsetfilecon(pathname, newcon) < 0) {
>                                 /* Ignore files removed during relabeling=
 if ignore_noent is set */
> -                               if (flags->ignore_noent && errno =3D=3D E=
NOENT)
> +                               if (flags->ignore_noent && errno =3D=3D E=
NOENT) {
>                                         goto out;
> -                               else
> +                               } else if (errno =3D=3D EROFS) {
> +                                       selinux_log(SELINUX_INFO, "Read o=
nly filesystem, relabel not possible: %s\n", pathname);
> +                                       goto out;
> +                               } else {
>                                         goto err;
> +                               }
>                         }
>
>                         updated =3D true;
> --
> 2.53.0
>
>
