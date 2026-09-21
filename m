Received: from mail-yx2-f18.google.com (mail-yx2-f18.google.com [74.125.224.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B033A6F1
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996539; cv=pass; b=YsDuxSQtstN6As2gKuBwSscHbRK6SFD/X+ry2V0dOPpKoaE9+oaTzRJWY4n35ru4aJInFC05gBLR9PZewbDYrW6o0fRMNB5FBoHA4DPyLfLZmc/qhieJ2TEJrzn2O40StjwM+tClJ4vR0D1BqMkbIZ+8JPr6Y1bg+1f8WwI6Nvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996539; c=relaxed/simple;
	bh=5x1Wr8/MNgv6NTxvsm1xx+c8GaoC6cDWFcpk5C1FSLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIlTQm2K92+dcCbVVNZhSrW1IMxMk/ErPo6jKTR4gh8cWfeOxONzew2L/GeXIl/wz0UmRVMYfGJvaG6PZZsns17fEtu2SNQACrTsgFMkuTZj3p5b5+M8szZcLsSV9D95j1kMHr8A4S9K5YniULWFRifAGf8tOWS+iKHeAKhxy0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=glNPYSka; arc=pass smtp.client-ip=74.125.224.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="glNPYSka"
Received: by mail-yx2-f18.google.com with SMTP id 956f58d0204a3-66e4aac92dbso2468356d50.2
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 06:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789996536; cv=none;
        d=google.com; s=arc-20260327;
        b=l1VfVSrP/TOjuPk27YRXMTrAzpKnUJIA1y/FvrQPLkuFhNA6A0Xz6ONodFkcIAG2It
         QZ2c9Y8yqFLJkaskeDFveTYcKOrUWnHQSi0+ye1uAmk9V4XtrTwIyoT0s5NEDyoH5yL/
         cu+hvGhJscdWsCa+Ff4h3kZi4PfHCCR+tS7dDmW8L38nsxIJ+C7mBmGWNWVnKAYgsZ10
         pREq/p80/Bz7Bd05jOGI7c888ZAEbTAUShh1OizBprOoRxRBbVI+FOQ1pK3HKwIB/xAm
         ENQyhZAYUaFM+wZrNSw/HGKq7RICMbJT39q+e+XkRe7AI2aLpyWc4YoZ3+mqC34ZI9u9
         al9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHWx5ithkHsIiiZjaWyCLDQzJ/DVuX4fOFLcjme2kvw=;
        fh=5rUELWyiNc2yZfB2R9FR/cLOc0S+7KYPg6UPbTHNveU=;
        b=MwC5O5gcBUqVShP3cQBu6NJflbZNFoJNx7c09owsRVL7mJmHyOTMtut6tuX1+ZF0/9
         7SCDzYEUkDSRpirlRdUI+ObHXjg6MgDV9QhoDnXCxwXYlu97G9rlAQCHKfoTepoFtvIH
         WVGyeJx0YFp2UAGfOZGbfF7ZUbAz9puyddNBry0mnSJG7q6Sx8pt3vEb8WCU+AgG37Ap
         5A4pb5Sh2R5mQZJQWyPdisKF2czCmgCjtL8JHMQw4Eeqkhztom4ge9Q/OIBqFKXCRh+c
         yZdwNiHLtylIRvYIxcgotCag4LoiCXzSd/2BMijUsC3Lcu7X0ke5rkF9vKws/QWnYBFB
         aPOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789996536; x=1790601336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eHWx5ithkHsIiiZjaWyCLDQzJ/DVuX4fOFLcjme2kvw=;
        b=glNPYSkagKvNBqxi7HlMU1OqpeH8wUChbEpLo2HnTdDpK2bnyJroJ3lB5w+re+roq7
         tqCPi/8Lz2L6XBxIMhH9Cl+61uQUs9g7slEChnSH1gyRf5sMKfCRhx3C0zo6X2ihEwuT
         UW6GBhE6d8lBjbL5xPloieWXdPNiCsW9g7j0GWjVI/d40j4NUd4MRRWndQNoJtS3PO+n
         zJv1y0IFJC6y66M4Wf9vvtuuznzB/UDVFOMyUjrn8PiwDgd6mLWAmL10Amou3PxFuL94
         gQvgIZYXT9QJfOZIA44StN20csK9uB8iILjQ3hMf+rl+7w/asRzTJy8YN+rg6ipUyQtu
         eqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996536; x=1790601336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHWx5ithkHsIiiZjaWyCLDQzJ/DVuX4fOFLcjme2kvw=;
        b=zWQdjNlPYJmzLT1polMXFff5TJ0ayVDLgCmN2c8Dj5/+FAc+xE9FT0hgO1LAxgpGvM
         iyw7uyTnULHbDdYgX5JUV6wtxFS0gRrOfs0WxlBWavHwSp+Z8W/ePtCaxid5HLVd/r8q
         FgfbJF36A1Bl6+WFPFOi0goSE5Z7jLIEtl+Fjpli39I4YEbm6iHIWzqWgs8BfJ2KPRh7
         elyyJ9kdiZadBhE5nRyPs9v/79mwmzMN9731qI7Es1mVwNSvwEUpSsmioPxfupy2cQl0
         NfTubw1z++LqPDNNyLJx8p0V3W7pgfEfCEAGzYAgWPJFXhOdKmtwVnvgTczQYR6NJITt
         iR9g==
X-Gm-Message-State: AFuF++lQ8XVulw7rKSCbOE8i0dXzPbqqpAhVEGarrFX6N+SdV3OQXjkG
	/IWixdhr8S9D792ITA6XOVM6GudinFl/pl5tUduhDfybKe7OwP3d2egN47zcdri4IO2AJxVc1cv
	sbKZI96+Lhl6FVtFYbGkwVf028RZlFr8=
X-Gm-Gg: AYBFou1JaPzkbQ81qRk+DQrDUjoHN4jH9+uw/0Vdg9oK5dxNF7tLcSQQcCY2iCUBLcT
	jpo7vFPpog/7icF8wGx6Plx+YqWqclsEO16YLSDkcR8kFfEswwMbTQM+nLLffPw20F4FUVE6vyr
	rqj3g012NYxznLOjWmKaBPfqOFV08LUWPx/rkiZ2rEW76FuYvp+FS53cNsMEwyqrUFbPPEY6DMm
	337x4PO+kUEb9jePMX41PH9CLytGnpOdI/bowCu3KapWg6a3cNDVjw+S0lcDeMyy2k61/Q2DWNo
	lN8HQv7FFJDVaobG2zIPCjN0gAddbK0IbJSaW77plWOBULrxJspxhq1YYsxcKmNATHLrmw==
X-Received: by 2002:a05:690e:1343:b0:671:1a7f:f74b with SMTP id
 956f58d0204a3-6717fd8eeffmr3207064d50.63.1789996536238; Mon, 21 Sep 2026
 06:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917141317.54719-1-cgoettsche@seltendoof.de>
 <20260917141317.54719-2-cgoettsche@seltendoof.de> <CAEjxPJ7-vEBDoEFbLWfpC0wE5DWUq2UOU=TxvnEaSB3iBOTiHQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7-vEBDoEFbLWfpC0wE5DWUq2UOU=TxvnEaSB3iBOTiHQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 21 Sep 2026 15:15:25 +0200
X-Gm-Features: AcwNN1X9Ypbz5zFgcEMo7y-3cT6G22to8BNNRXniVl2XcZahzz49ZsE612vm6Ns
Message-ID: <CAJ2a_De-iEtNNOU_=m5ujYFqpVNyrS3=f6YF7nbQo+dqhbX2_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: check neveraudit in avc_xperms_audit_required()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sept 2026 at 16:11, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 17, 2026 at 10:13=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > avc_audit_required() returns early for a neveraudit domain, while
> > avc_xperms_audit_required() instead relies on security_compute_av()
> > (and security_compute_av_user()) having already zeroed
> > avd->auditallow and avd->auditdeny for such a domain.  That leaves
> > its "else if (result)" branch as the only way left to audit a
> > neveraudit domain, and makes the two helpers read differently for
> > the same rule.
> >
> > Add the same early return to avc_xperms_audit_required(), so both
> > audit gates state the neveraudit rule directly and the extended
> > permission audit path no longer depends on the auditallow/auditdeny
> > mask having been zeroed elsewhere.
> >
> > No behavior changes today: avc_has_extended_perms() only reaches the
> > "result" branch once the identically computed "denied" is already
> > nonzero, so that branch was already unreachable in practice.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> I didn't see patch 2/2 unless it was one of the other ones.

Yeah sorry, this is a standalone patch; messed up patch generation.
