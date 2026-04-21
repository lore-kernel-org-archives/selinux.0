Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923B3750A4
	for <selinux@vger.kernel.org>; Tue, 21 Apr 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788716; cv=pass; b=O/cqmYTI2uksR/j42gnJ4epZBpNs1CsEi7dc5FlbdH2X4ccGX1qM09Jg+bCN/J38Bm8/jAxb9keCZbeZNTk2IE5wRRGPbse42v3aaRNilMVchulhaswTqHY5hILf2MaqfHnAV//lAouV7PDgFjBQJ9aZ8+mhUZhDjeFNWm/L8uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788716; c=relaxed/simple;
	bh=TFC2igL0wvfRDAfpY2aYszhbdAlr2nKDquJbNVbkGQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAG5ph+QuaBoeHWRVBAYpoKb0VIiM2zxp/2nk9H60CQTJNghkBpG+sGJSxTGJ3UQFQIGCRYR4wYzWLxLrvkCxvLl+uJKRHUeXt5B6fl2+tiRCCWqf81gh3kq+ozu4/AR/u989yHNHUuEG806XzO14pJnpX7PlMVt6gGcm7YBt1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNX6bkWq; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNX6bkWq"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6530287803cso4302394d50.1
        for <selinux@vger.kernel.org>; Tue, 21 Apr 2026 09:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776788713; cv=none;
        d=google.com; s=arc-20240605;
        b=Tk7LwdgAmL90jlODtyNQoE6M4tKnwqnGgFAZktwI5gI9zG40+VSqFo6BwizBW6LCbo
         3Q6sx6laF+6yICrMpHcQEvADAJn+6s6Lgu/qZUQ759gMRn5x2CuHm7yJ77TM+/0ybs59
         w/Uuj1yxh4xXd29eCkdG6HwPyh152MbzTfwZP7Q51an+wdAFqeeSv/XVhCs8BOC+jv3d
         OvqVV30LeVRNbrkodF4t7U8clcBAMZI6R1vJuVI655zUYSHAgDqlR0xSaIw0AuyOBULN
         xPZoImQMiTWP8NjnUMNFF5tALWeIP0ut8PJO4h/ZrpygjLorBW+eMc0pWhloL+xPTvCO
         FnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v0JLr+cIGl6PulupsySyvzYANdYaETgbsKt+d2D0BMM=;
        fh=K0P3yueWX+9wvznQ61j7DXol8naVFvlsq/Ek+LAYujo=;
        b=Ev79UKe4SK0Ow5QozUxXu5LKOdGp2cExVAgwzhLdKPLMe++TBvomcGcV5azIGpp0ze
         TLGDcqQhMK91ELhQ6DrALAh3twSjzMRuyRLa3m2wh+6zgXf0mm+JmbIKkMTkmrPJgPmH
         mMR9f8Cwp+5fbrGR8t3u4/FuUGOTCmtiL8oP1S/vJadD86lHlbntPqLyxeQr6mev2jbs
         QxBBshy+OGMGvkhWwOm5TGUca/vBVJWba7iHvhwqbgO0OP38vwhFLk4j+hkfIj85cjzC
         v+CBQ/gTRHgwesPenUL3eRipsbTm65GsDD1vg1Uvzv/lRO+rUVRltW6+/QJOQjvncjn3
         usJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776788713; x=1777393513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0JLr+cIGl6PulupsySyvzYANdYaETgbsKt+d2D0BMM=;
        b=nNX6bkWq3tV0/LIWRUtfvVUPqTKwwI2v8ud6AXzKzfsF3imniKUBNpOb0O57Ghy3qu
         W3vARz/SMEw5zccQc89cy9e6RNF3wGzwJ+DLCCxblbUibTLzsaBT9sUPTKyKTItx4CrK
         7oHBR+VqT8JdEdk4ZDf1Ruo62y+r77cDpW9NaenZe3sgGlbYwgOpDpMQ/mIT72VIgQhF
         ctqFN91N7c97vv+pjAkLgla3lWNgG6V/vjLP277I4fRTxKt86gyk0FvaPMBK3x4RanGt
         c9E17kKDhLXqDFI4PsjKg580WsUvJkqso/mldsWrFnNESOBMVNioL3Sl/nCRK0lVpw8d
         oufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776788713; x=1777393513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0JLr+cIGl6PulupsySyvzYANdYaETgbsKt+d2D0BMM=;
        b=nnrE8CizzTf0gMuzcukRFiya1/WW0xgoHmbaR5qjqh3Zah4uS55fPE2CXoXAHvB9JF
         BqjPJrCPazRytgGGCTsKcCdwqvjj/0B74GEbPaaPfZdN/UPC5K47A8VUhZ9MoXn7cGwB
         QWi1SedBXI1o99B9OIvuJ0HFCRfFAWHCWQ1BFoPxSba2/hA5cLdsONOlbIWze0Qvxjjg
         bDPb2FFAqE+g+VEcyceNicNyLku3oUc35eKEOBrLYau9dKuAfNrOnXLjEDL5ZzFmxfs6
         WL4CT1fYNF/6g1kRAMffKzLdD7krPqdRUrBGTp9Nuj058QwRbvEw4ce/f1KUyBISC27j
         5Xkw==
X-Gm-Message-State: AOJu0Yw+WnBFJ3vKm6zYRnHzgNPDo4Bek2iAaxqJbyNtpDZ13519Dls6
	EtmR93kBOcdy5QNy9gzXvVXs0WFuB6bJHEBKON6aKrzNjH+dWY5zruQoJHPA4+j54IZBpoM+X+5
	K++2c02rY0L3bC0IWpbqK61CpSotJhtAWMA==
X-Gm-Gg: AeBDieuFrzeYTgPAEmnhgZy7K9PAZ3cLP6RVzoUGZlkbMoGE8pCk4gp4Jo5f+paWscb
	B766usXuluXDjg6eYLBNLt3tJCxnJyk+VBc/hoR1selYBFMN2OPSqjtxm9TxAcWONrqGc9XVd5U
	uEHf9ZEXa/c1siRbj8MujYFqyrjtEeWhCibKWNq76lK6Q1FVY9vd3IZiWM8xz/bmGnyqpcdsfsA
	BuvzU7oj0dNtwEqOtoCFAmhdFS4vFeuaFf3pxb8oBm2RT4HstCVkJm+jCAMNLAupwYbsAqaVyB/
	B/+xkC8Sp07Xu5ZaDw==
X-Received: by 2002:a05:690e:1441:b0:651:bb9f:cf4e with SMTP id
 956f58d0204a3-6531055fa91mr18046890d50.0.1776788712997; Tue, 21 Apr 2026
 09:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410192949.16542-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6y9p0gs17s7090UcbAcA2KtGcj2nKqi-hBtNZ3zgwKDQ@mail.gmail.com> <CAEjxPJ4fPyXO6MWef7kA=gM3HTDhYjvhEbZNRoU=AG__K6havw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4fPyXO6MWef7kA=gM3HTDhYjvhEbZNRoU=AG__K6havw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Apr 2026 12:25:01 -0400
X-Gm-Features: AQROBzAj4YvMcuGUA36aULAepVu0_567FzsOUG46IJHU3R2kp1VKvaRfVdo1tBQ
Message-ID: <CAEjxPJ7ASrJSLOMrryvHGQT7R7rTvfZdfdTPu6z9SmCRUX_wDQ@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: fix avdcache auditing
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 3:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Here is some perf data, using default Fedora kconfig:
> v7.0, unmodified:
>    2.03%  [k] __d_lookup_rcu
>    0.80%  [k] selinux_inode_permission
> Ratio: 39%
>
> v7.0 with v3 patch:
>    1.95%  [k] __d_lookup_rcu
>    0.81%  [k] selinux_inode_permission
> Ratio: 41%
>
> v7.0 with v4 patch:
>    1.89%  [k] __d_lookup_rcu
>    0.92%  [k] selinux_inode_permission
> Ratio: 49%
>
> I only compared the percentage spent in selinux_inode_permission to
> __d_lookup_rcu since the changes were localized to
> selinux_inode_permission. Aside from the fact that v4 is measurably
> worse than v3, I also noticed that even the baseline seems measurably
> worse than the selinux_inode_permission() percentages reported in
> earlier commit messages, although I guess we didn't re-measure when we
> switched from the per-cred cache to the per-task cache (but that was
> necessary regardless).

Actually, re-running the perf commands on the older commits show
similar results for selinux_inode_permission() as I am seeing now, so
something else must have changed in my VM or the kconfig.
