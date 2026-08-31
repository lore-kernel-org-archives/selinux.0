Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EA3769F6
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199279; cv=pass; b=errs3tN1cSYwiWThHIhCJ0tTIlwzLMu65K5V/EAA0z4XWeQo1FBUzEXVly/wfNtxEMOMvS78LpG3VOg5TIprl1FjlNPqQIBEXzFuAPCXb6IeRoFT0O6n9wBHgJhcWBuCFhtadZ0UF7E7n5p/cImm3lZ+lg/XgAK3FFoKYy5UnT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199279; c=relaxed/simple;
	bh=e0cRrASXzY700Rn4voEaX6noZY7opvmpDBj/0WczwqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnkh5k2xaIOyPFvOxxsHyws1HmrOQCpi4H5JUpTn6QK9HSjcxTpGau4jcds/AV+bY1D3xNUcpGn9YqkDLLT5MJVz3H1cWPAVIMRK7nAmkMjtvTTdVXwaHKlTbLc/U9HdMHL9eg6P1s7mgriTf5adykwcftLgPiv1izvVZX9M6pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9oB8jHN; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9oB8jHN"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b132a5009eso1328375eaf.1
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 11:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788199277; cv=none;
        d=google.com; s=arc-20260327;
        b=AJktOBHik363GPb5JxK8WuaKLGRD9rVxknluaHKv/57IdwfZY83iWGH/+46TFt2r27
         y7j6eRplQpYBGWnfWuVa+/NJcKgHDVc2R043XY94aq1RauHA5mE3+r4Ojeobyzj2cCNA
         w/mxVkxx/kKhIMfktNr+c2BcjB4UrFnvfH+qb0470uCP7POh27nKWo+s98qrKvoW87c6
         3sZvqsTDsBiFofj3Z+hOmpo505etnFwaSdkqmvCFWbP/c5/4SIgToacWJ5leOWbQMVjT
         gA9uMWf7fTEErlho1rjwQIl6gba9bKThRZgMinq5ILQMRxkPRP3EEMmG1br5ebAhX5gH
         +0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e0cRrASXzY700Rn4voEaX6noZY7opvmpDBj/0WczwqE=;
        fh=0Fzwzs5SXlcauyZV10jYVdOWMMkLoCrud/LaC3xDChU=;
        b=AurWEhmRGtoFo52N1Tdnl2yETU3t/Eq4cg/srMlw8Sp1r+AignEjrYICDDk841PZHH
         p8A1ZurUM0rAb4EE7PifqwKygUDQEVVdFCcAIqFMq4E1Nc8xBPcWrhbCdgzwA/ipgwbn
         qRUl1vWkkGQLzkNym92jiMTm9SzRIxtgR+5i0FH9JdRhzUwV7ez0JPMRtusxAcLR9q00
         L964mAYJB/5IT0RMcbxPnbhytLmfd12p30Y7PbubXAMzH6qYmx3PvFpPFsppVruqANVn
         gf0cWBP48voKwoXiI02+TOajAOexgev+xDw+pANnFUMWNW+2z1CkwoZk5AEWFiBOOo6v
         CTWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788199277; x=1788804077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e0cRrASXzY700Rn4voEaX6noZY7opvmpDBj/0WczwqE=;
        b=L9oB8jHN39lXVeH/vqDcQ41k60jRr3YeMPnWNrSh0xSx8d635iZT6eFf7hF5svDA8M
         Bdf58KGwxW4NlV4YmDpFFmJe65xIPOdEzt1LyM2UfTHPXKv2NiI0hOCMpZEfe/QIwz3A
         HuvTKjIvpjLyFrXNuQ6aZJNBWxyx78srECV8/zvNC2NDrdeqwnN7Ct9H9x+hcekPtJBx
         1qkOJkK7H+1L8WY2F8yyWNQ0CqbZjO4Rql7kH2L8fCVTaLiDWTCNQPXiaVK+OTNaVAae
         HqEcjAzLRgzhg4YGK1y5CIiDJwmtL1MRaPBgWu7I5XfgPtBkFPkb1wmG5lIbA/ZDjCGa
         kRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199277; x=1788804077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e0cRrASXzY700Rn4voEaX6noZY7opvmpDBj/0WczwqE=;
        b=ADIPIQhnX+OkqfEr+jAP8BamPGAw8ycejqzyXTxolFvRd+6uhbSm/s87v24zu9po7o
         K/KwH1pfolMWUw3tthgq2jwM4KRARZWxVtpbYkXuizZ65uaTb4P74MEdW6yacIlvVrVo
         F/7AsIqEqdDdtVcvW8Nf5K22FPT4/Nau5QFJGEC5wlWWXy6hRGoH1120Bqg5eJQakIcu
         Koj0uTISax4jjfGLQWhQf1IS7H4QH9k3MXiu8OEnitNnXKmad89NTx0cMt2Gkz0vFx7H
         AaaQPwGH9Xfh7LhHuRv6kjYFNHqF6Jf36668Rq8zv+O240bpCcu/UGkrOGcjlO76YxlI
         wXBw==
X-Gm-Message-State: AFuF++nrc67v9Hg6XnJgul6P3AWr2l+rxHdbyIOzc/0D1zxqq5WEiCCW
	CK7tUS+X7NNdigRAb6zfB+e2ArkFPD8a3TDI3aWfdZhrurASZGgOPQaTl6T0UIQSyf/HKl2rpWM
	DiFvWkX2BfoAYGnX6foGWI08HynXAydj5XKi5
X-Gm-Gg: AR+sD10ruW4HmzEaDM2L0oQ1AMDc+B1eENIdyW60Y52WXG6IDLIr1kTOW6eeYuH8oKu
	R6M2l/6oNAsauxpPuz6N4hnlcDar+ns3q5vdhJddsP0sPztvDWqdHhQgRr6HqEu5D3zaovMRkM0
	zz9CRKmGRbx3Zx4YA31FnTV1nyzlyYUI3CvH/SpD++I/hcnoktkouXpOZmdHO+3+piL2v5fH6r0
	NjkvApAblZlf+Y0hDGysGZ4zBudsVbcQ9HY+vWY1EW6w6okJu7V2p3gBUTGR7trXJ4rbFXddkt5
	oPLypPalz5GalSlxBwpPtf0X8t50WjuZCawTEnxwQryW
X-Received: by 2002:a05:6820:99c:b0:6b3:4a99:bd87 with SMTP id
 006d021491bc7-6b372f515bbmr2549049eaf.30.1788199277170; Mon, 31 Aug 2026
 11:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827125511.19408-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260827125511.19408-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 14:01:05 -0400
X-Gm-Features: AcwNN1XZqtQ2FQhdWYt_YkZxSgEVVYt2USfG-OBAHRYYhQ8gwUTH1n-k5qFx2Wg
Message-ID: <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>
Subject: Re: [PATCH v5] libsepol: drop support for policy versions before xperms_ioctl/xen_devicetree
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, paul@paul-moore.com, Johannes Segitz <jsegitz@suse.de>, 
	Cathy Hu <cahu@suse.de>, Russell Coker <russell@coker.com.au>, 
	Laurent Bigonville <bigon@debian.org>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:49=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Drop support for kernel and module policy versions before the
> xperms_ioctl support (SELinux kernel policy version 30, modular policy
> version 18) and xen_devicetree support (Xen policy version 30). Kernel
> policy version 30 was first supported in Linux v4.3, Xen 4.6, and
> libsepol 2.5 (20160223). Modular policy version 18 was first supported
> in libsepol 2.7 (20170804).
>
> RHEL >=3D 8, Debian >=3D 10, Ubuntu >=3D 18.04, and SUSE/SLES >=3D 15 hav=
e
> libsepol >=3D 2.7+.

Would appreciate any feedback from distro package maintainers on
how/if this change would
impact them. Link to the original patch for those who weren't cc'd on it:
https://lore.kernel.org/selinux/20260827125511.19408-2-stephen.smalley.work=
@gmail.com/T/#u

This would break e.g. RHEL 7, Debian 9, Ubuntu 16.04, or SUSE/SLES 12
if they ever updated to a version of libsepol with this change but I
think that's unlikely.
The greater risk is if you have any lingering binary modules compiled
with versions < 18 inherited across multiple upgrades (e.g. RHEL-7 to
RHEL-8), then those modules will break and probably in a not-very-nice
way (libsepol suddenly won't be able to parse them and therefore any
semodule/semanage operations will fail and you might have to delete
them manually from the policy module store).

I'm fine with deferring this change to a future libsepol release after
3.12 (e.g. 3.13 or later) if that would be safer for the distros.
