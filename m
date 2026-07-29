Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2A3B3C01
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356600; cv=pass; b=fktZB6rsmFg2YgT85HD23xveQ1Z4gflkO1ADL58uC2YbFgOidwMhF7tapnYI+CW8mKGQ8oY26SogUElWGqjk0RaF1utVo6uMOZWa6He9v6cHbkq3IXgAfZIJOeLHC0vjJLfho+1p9KfpEeAV/qFO/oka86MLIUr1YuZam1OLsF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356600; c=relaxed/simple;
	bh=olmO7xjGtqImqiVgLEmry2ng6AJcnwUyAbhmIf8GV7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCDYJLEdCfNir+2wqjUF3+UwZwbqP212GZgL85dTNFZ5Lgm01h6UaXofKeHfESp+0nbZMJjAwhD5qp2YErbc/EPZmkCBg/AvfGke6+B8lGwOA+eOtSCn5rjivP/6Q780B+/HP84jxmJR5h5xCuP/I0DZQF0M7obLxaYZNsSqrAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfI8Fvl5; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfI8Fvl5"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6acaee38a75so406333eaf.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785356597; cv=none;
        d=google.com; s=arc-20260327;
        b=odT61jIXwgx5vls1npGUK36u/FMiJR3w08ivUWvpF92pJB3s7wiy6PLU46/PtIf90S
         RZ/itzNWFssV4jvU7P+IPjGnT1bjiHFOWI1xlLiVLnaGqdVdpJKbjkuPmflnDrYRRZog
         iY34RuqZ8Ta63usXmVCnaKCPJAqAF8j0iHoisZ8b97uXLL7wcP5arMkTwmcnzFSXw0eK
         56oZWJObcCVSC83sFPFdwUAgUng00b04dbIslQ8Gfgy9aL4V8Hn217HA+7NgilgRsgsN
         TARHwkCS0DOtqQSbduqpzuHGQXVUPFi2q1ui1Zf8SNaupujXa7xOhh71TwC6ReDWTfhv
         UUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q1J6Zz4I14xc0DPRi9ywjL1ZK4SThDsfDW24QA13jOw=;
        fh=chQ82yjwsBiR9uZWyudR3T+s8hO/5hiH4ix6Fr2pKCg=;
        b=YZCgMR8k79D00z6k9z47FwKPVs7Je7twaNHv8FIUiiUntzcycryH926JQHr+rI/sMw
         PhZxRCjgus7m4Oxka7BTvU4aukzZqCikX67Pul65GPb6sTgRQd1TMDHPupGw79t1pTgm
         FweB8JP8130tcqdCO9V1+KIW0aqlo4KZScdAG08EYAAgUotivH9Wwx48AcmNtl8saiAw
         EZixQuYz96Ki34wquKC59Abd3KeE30BeE3LAoguA8IEnDert05BCNy5yP9e4CaRGD1zs
         RDlZA9S6Hd1urmj1dqri60fmkTkSXTAXY6ZDkzmXWWjlq9660pNjzvR9dqujiGp8wlCS
         gvTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356597; x=1785961397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q1J6Zz4I14xc0DPRi9ywjL1ZK4SThDsfDW24QA13jOw=;
        b=nfI8Fvl5Svk99VMaZ8LIYRhO/L/hdYp4dHpzINipUYjtqW6opsaefYBsSmaYBcBFax
         8tZJOPKfkdS9mAE89PwrgT5t58B4T8w9PxpJFxsx+t8xzrBNUr/b4Qqm+KZb5Em//wIr
         UissMzOU0xMoBx9m3YzutGcqd5gzEkvPvLotxksESn8jS02C33/nb7WQxB/mfp+xQ+d/
         AHWBVkMxRPpK7h2UGhBHgSG2prS/LWiTkIi+w05ttJeSstgfLJ0GeUb0hIRGTJYhjWHu
         jaieQcNIm8rLBFmOPKQezoVOioz/qrpuoJ2KJ+steq/VwnO1MNsZn0X59SzEhR84Q4db
         oijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356597; x=1785961397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1J6Zz4I14xc0DPRi9ywjL1ZK4SThDsfDW24QA13jOw=;
        b=aUvK+1z3fx4TfcJlv0PfFmEB2DrDs0W7zRmGMeK+H3XiCcAfF1XUT1yfjuWubS7mT8
         RbORZ0w8iPahY4KwAJ0/7K9pbZPabfsRjPYE4Y6KwNU9EZWVrwnfyqck5eZG2Z14cgfF
         jcMn738+OdnHgKnPHug7o9xgkTLdRUbiWJVQCFWsoX21RteoD/Wj2bRYgPC27OPYCpxT
         1b3Sc7uLw2v4ImDUJbMEYqMCW+9xkwVJvGtX/vgpOKxNOL/h2nj2D5GXJXh8jBP8Zg+v
         s8zt9ETbNOPdlS9etH86YYSyc9KkPcTRlEDhR+XvdEbyWhmHYrZINTFYRBtXli3/jDUa
         edMg==
X-Gm-Message-State: AOJu0YzmbPLLnivBx0eCWPsnfgHtmmG28YDkRJtQ8jifcDVW8N4WKFcC
	d5yffHAj0Wz8yfTL1ILOGNRbTIj8Nu+E62yLTaNuvoNsDNTBxGp/r7udaBIsloXUNkJG/wGPfpX
	k2ZT4931FpZ4hYTKYewtRfrwIXQbHVTr2tg==
X-Gm-Gg: AR+sD12BeGCyB2Oiz8rE2A+gu4aPEtkDW/juJeBddcFcH+E1rC9IQ2oTVPhI2rSWNeF
	Rcs44Fi8n7+xgxnSqzmpcUSvRx8ob+MU8NvSG5+w1MNAh1gOZ9uRlTV+QLjBJ678aSRK6lIM4yB
	hYduw67gYBKLnzzl5oE4zdxqo8+qzahoN5lSm3X1Y45YpkjlBiw8H/31GvbT3CQAp+tonQl1rkK
	o4BnaIHlCtJoXnYV5rajEDjMOzpLhiGZnT0swjGadgNSkFDyPlTYsC7G9kAQMSg9cuglZ7wfkd/
	XIhsUvtSqoJXHTdlD3+jwjgzugzS4HcMRMbEAkx0CsKB1Q==
X-Received: by 2002:a05:6820:4b8c:b0:6aa:9be1:4844 with SMTP id
 006d021491bc7-6acbb64edc5mr18966eaf.5.1785356597609; Wed, 29 Jul 2026
 13:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729152415.1606580-2-cahu@suse.de> <20260729152415.1606580-4-cahu@suse.de>
 <CAEjxPJ4=M0GjXd3RSYW52J7teeoqiZT4sOcq3WZWzk5_UFe5JA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4=M0GjXd3RSYW52J7teeoqiZT4sOcq3WZWzk5_UFe5JA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 16:23:06 -0400
X-Gm-Features: AUfX_mwAQer3ZI4M3gSC-6E9p0fN5zyOLa67qJo6VS5Wv3ZOQcgUA07uWBhRPN0
Message-ID: <CAEjxPJ5u8iSxHufTWZ6C38UUQSPNgma-9u0gpnP6Emms8Tmw3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] python/sepolicy: add a pyproject.toml file
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:03=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 29, 2026 at 11:26=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> >
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Add a pyproject.toml file for the sepolicy python module.  This
> > required also updating setup.py to avoid defining author outside of
> > pyproject.toml, and I further updated the authors to refer to the list
> > like libselinux since Dan is enjoying retirement.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/505
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Verified via https://github.com/SELinuxProject/selinux/tree/pyprojecttoml
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
