Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE83C3437
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697831; cv=pass; b=aRXsOaePRM2c/3K5uvVx4HK1VWPFiI5BWc/6MbTuVmpmI0oWu3vARHiaNh6VEo6iKWzLy6oDPkoM/Ymop/QkSP6YmrwMZAWEXwGciHBx6U1pEonGV6jYLWb3MJGqhMJD8y0efZEmbNauHbUxi+nnl0VVl3vqJC+xU1PncKmE9o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697831; c=relaxed/simple;
	bh=vDmr/C9Nikoa2Laeqcoyj2rY/l2kVUjCqUQVuWkeAjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogmkWRZAP+xxgIAtoHQroz+W24F/bI7rWDavWUGASoXX9k16wrW1kogKM+13svRdtLsCaksTORDQ4AP92layGesgF7WP5amtVphf2CS/LxhB2wnEwj54ERMUs6LqWeJJwf4Dlv3aejMCgwORxSVBFyY5NZd4lTLcuOZ3/UbUYqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccEEKLVm; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccEEKLVm"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8abc87cbd93so581767b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697829; cv=none;
        d=google.com; s=arc-20260327;
        b=hNGUtwFF0Gbwc35F38VCqXpP+Z1lZv3bpQ24gHh6jAFU6b7SUbKIED9HDl0TRG69L5
         jIz5q33Jz8vn4/+yPm1QOVWd7pRbW9i+fJn6OONqCYYPri2CRaScyhq3lJ7RDGHSl7NY
         J3L+C59UrvKGHgWETiFLb3PWkThZPuj0hz+8yKk80xBDs1yYai925kvjbw/b12rgLc/h
         VDo45yc4Iv2KCVSGfooFwsbNtvSv5N9cMk4hsMJobC15RNUtyh46iXrdAQkhRUT9h6p/
         lOz6SfbCmce3bHMAIevM/UWq/B54jk8cTA6I6qgdCX7VNR0OgD0pnTcKlzf0Y7TuPvnR
         D0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDmr/C9Nikoa2Laeqcoyj2rY/l2kVUjCqUQVuWkeAjM=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=Ph7XQg1Amep25p+soSTvqQIuy0HhPYx3yoabgLRG/z22p3pI5f6kwGJIfO1Va5ZKPW
         T9DaAlmkwQ7XBxJo1YQAu7bN5u11spDEPd9LZTKNFevpWy7vCI4mPUNTlUYDd5lmrqNi
         2HQ+ls0buVQ44zuBjCmtQF1WbhmayU9rYUkQLnJ5oGE4IXUQx0+zlahKZOK/e5d6U9L0
         eaA3U5FecuSp7TNP4GANHWie+KfItzpJKPkHInGiG5GWohtA82Z1QzsJfU30v0T4U+4Z
         6c4++vYtmfmHKc1lQyu9Q1MI9OA2OUXC/68s/Sc5WHqlzDb8ZvKPm5KCiUveCRZi8IP2
         kVuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697829; x=1791302629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vDmr/C9Nikoa2Laeqcoyj2rY/l2kVUjCqUQVuWkeAjM=;
        b=ccEEKLVmkWwI6e9Oz0IhifTSfutzVXzM1vBUKbJjnrPKdK/I9Q0r6Uyu36xNyQ2bQh
         51ll9ersP+rSpM7l0r8IExXZCuxAxDekmmLlGU3FZ/ZhROr4u4rYpjRQHxAvDerTPhlc
         R6EHKjqvMNtTn35a5/Hek7HC4dfSin5LcYZDJOvVpHlDd2CNYMCZhmKOJqpUOzgM3MOn
         CYT8jMu/Na74RXCzwplL2e6VaIcz+dEVc/fN9tg62JcNU/1BBHhhuBSMXb7oUHlfokyX
         kMwXJQk+kwv2yhfCh4Lb64e0sN3ZJ1GkRjYP5N7nKJC8b4wSr2kC67rxy9mAUfvH8xGF
         XRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697829; x=1791302629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDmr/C9Nikoa2Laeqcoyj2rY/l2kVUjCqUQVuWkeAjM=;
        b=qlAjQW4PwarfZPkjxxNFCmY+mUUKE0bSJ8gxhJ3NGL7yStPMG1C8ZLjtEavP7QYPS8
         +QTPn72GYhcdD5GEnP74MZzMf8pW9aiyoyh6GiqXP+sVHwi0IyqDehk05CnrbkfdmRqu
         80dsKcVxJ7bw598z9OKcQlOKp59CinS3lSvsfrIHhExeqIBM9C7UCFTBh7/cQ4o5Vc9T
         qPKpqJdyuAMeojCpk4y91d6YIIAIAYwNJbkpum5mk1txREsbraTBjJfEEj61sZqP8Dgt
         3cCPWP+lb4sVgbSor7wEOWwdKOhFc4itxkzm5PCKkyBeEfF34VPp3d8xK/zYB+SQnUnG
         M97Q==
X-Gm-Message-State: AFq9FYI1lDHw8oMdBtX67Q93JZRUH2OMe0yNS6liCYphHuLNEE7qU1MU
	uEI6O9Xg4vxZkEH9LSHVW9DC7vf1BD4YdlEMHggO0jls4g/oNV0bhqSLybpRoCYsB7x54QhOsXE
	adV+H4KFaYiOsr7iRjikQdsD1MeXeBMY=
X-Gm-Gg: AYBFou0+vHmBvZw6ojL1cYzbGo4TGRumuRod82GS0pG+8zu11DPBfW4LpRCtLxxtWKH
	tBUPbytw8LjhcZv6o0SxhY/wGxZW6+ob5qFRlh0hFlH/koXUmlv25rMuCw3bwZZom6O3sbWIP/Z
	7quoihU6aqlwavGlqcgWDmhBrlTk++XYyN8xombaF/9nf4bsPIZddpAh3nH8Sx+O0kaO7NJWrFR
	qBdoERnELA5Dcsh45n1lg+B4EvkPTmVtzn3bB/9ZXGNue5xo246rZCZ+qVhxqPN+Vjx0seXfyMU
	eo/xKLPXTJ6Jq69qpezthMLeI/NZiRACBwkTjE1pN7aYbF6GynGzEsk9lkfQCbJ7ug==
X-Received: by 2002:a05:690c:4:b0:873:5c0f:27c with SMTP id
 00721157ae682-8a64b6215femr90645967b3.38.1790697828639; Tue, 29 Sep 2026
 09:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-26-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-26-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:03:36 -0400
X-Gm-Features: AclHuK-MqrRNJKnCE_lcxCVnctxA-042TYQmf9wQHGVq7tasHAxPju1FSknu6Eo
Message-ID: <CAEjxPJ4c6GOk+wmvJ88yGcxVk2jhNVG4PVnDrMdNRPtY2LOv6A@mail.gmail.com>
Subject: Re: [RFC PATCH 27/32] selinux: fail mount if status or policy cannot
 be marked immutable
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> sel_mark_immutable() silently ignores a failed lookup of the file to
> mark. Since the status and policy files rely on S_IMMUTABLE to prevent
> writable opens and thereby writable shared mappings, fail the mount
> instead of continuing without the protection.
>
> The lookup cannot fail in practice, as the dentries have just been
> created by simple_fill_super() and are pinned in the dcache, so this
> does not change behavior.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

As you note above this isn't necessary because the lookup cannot fail
in practice.
Hence, I don't see the point of making this change. If we truly want
to fail hard/closed,
I would just BUG_ON() a failed lookup and be done with it.
