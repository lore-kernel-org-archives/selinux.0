Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13C391E58
	for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773181454; cv=pass; b=E2J4+6tp67MYxCS43aYY17Rp5mf3wUCVRX7ZJS8Yw9d0hgSQ2vxLrSlLsdSFQTxwTF76aSyIJKdKYZqr42Lol6gh6kSc0JLVnqaufXFsJWhDEsAaKEKy8b8cbGd/v/+HKdCzMsLm+Abcb20BqVrtRA+g759YFik4h1ghZwnWH0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773181454; c=relaxed/simple;
	bh=ce8M4iQB2sfXuv+VW5IdZIix7XjmRWFlfNgAN6eimes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z928wyApUErGZJS0vyB14jYrXD3fgD2gv2skJuapwMGeklL4Ej3NnB6rYwMbh/wDPYyApF3GcH1lxyj8W3HuEv/LEk0M7WGJSMyNTpFRU7Xv4dA7GUdAUyAkb5YjgMuh33wHAUIEehzbN7DPUVMeFnwtES+PXY2+0DoR7wo0BBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4D5djThn; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4D5djThn"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50906a98ffeso233341cf.0
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 15:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773181452; cv=none;
        d=google.com; s=arc-20240605;
        b=LANN3B7ey265HKaH3L/r7pQp4hWcu5r1RPPeB22ATiBylXoGnhBlBZ9gl2sLVDDMD2
         EBGl2xPr54N/W5dZx3qtgHj7r9W5EeTzDoLOssP/YBlaPHlXj+D5B98Qc6Xt+HRAVOq+
         8y5LBvi1TB8u/wJyb+kdSG7FS59/M7TDktT6F5LmY+iE8n6G6D8JOBa+nKip+8sgQ36v
         326Ft8IN8nMwbLHI5euNNnYUZZUvlqSU8Hx2udoxCZJH80RPjc/lwhofydht7AV36mDG
         Qj1oXcmzmKg9ZB4yxEYpIzq/jfs+SPK7L9Y6xOgDT+iixBM9iAiguHZhKCT92RRpo4z6
         RGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3wjkPqFcZwOeTko9ndBTsuLAzvQ/RVQG4Lk48M2Y4tM=;
        fh=eEvyUB7eLKLVncGrRst/NPbBCpcu+8xTByENGfaJ43o=;
        b=fv2NqBglS5IsHgbiKpbdlB5rdAsqu3lxW89tjoK86P1ZRcKlwZ02aaMJJVoboOznfF
         rdNz0uBhoaA4uEgUenuIuo0Ke8+DFv+7f1nvbsqKY7/Cp80iT7v8oU3zEOz1vQq4Yiln
         7I3o8uNpBLQvBZ0E/CZRni9dNBiSXLj8PUNq8B3P3kniW0+pkX2KwpoZI30icuGmL3r6
         R78M8Xz30eA9hUOmbPQFrkpDolDQ1RqaEpSFPE5KnQZMNGDIS1Dr8oidNJa9hCxLdcjn
         /D+R6iVxxIxLxpVkQMpOMnddXimrkQkVXQi23ELeZRODXh557U3GTi5GKFcDPDhVRuE1
         QvMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773181452; x=1773786252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wjkPqFcZwOeTko9ndBTsuLAzvQ/RVQG4Lk48M2Y4tM=;
        b=4D5djThnuTh22uL6rz+c0PMXzUZlq5JorzmL7VHgvq1j4WUHXRLJuFCG5WiN+vzeBh
         +6Bb0Ri7xgVBhaMCVCIlAthjZ8eIrL0nmWuSAr+RyB6FOEL4seL2TW/xA7mhqiTIUbaE
         f5DC4pkOu8RbumHdy5nzEN8JYQ0DIyV2qyGhuwZ6TeCZBhS3ywdKPtO6nbse6IES6E32
         iARJpe8dAArchBV9zYJ76Rhc+cUc7uIw+Foe4fgh0x0Xwd14G9N6YipG8SIZ44xVywGo
         hA0YaJ2K6N9OitExQmZuv4SEEamK06/wy3O/J0DEyspyUDCChEAfnLD4SE2zGfiqyezY
         16vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773181452; x=1773786252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3wjkPqFcZwOeTko9ndBTsuLAzvQ/RVQG4Lk48M2Y4tM=;
        b=V0C1rN1f9qOAaUwvnkqKUdjEHXS6aVxbQGzP8qyTOZToKFB8y+dIosCZmln/CG2zXv
         tclE297t/vmxPQKjmfHIgRMXbLnhotcWBTY7gblmdU84eNTPpWzY4M0oTQofk+L/dNRv
         STZzVOI4uL44TkUqHbrrZjld7pqYVZ3O/d739O1zXAUN5g4swfc4fqVNKAl82Rv0P37y
         tELT3Nax4wErYAkZ2IYqL3aXrC8Wx7rwxhW/mcSL17WDk30U1EXveBv6P+bazzSJTUln
         mum0NXsRmMmxjMwDHgdWveNx80hI1cor3zpj0VpEZzEmkbMu5HQARQagAfql+bbKpH2i
         G78w==
X-Forwarded-Encrypted: i=1; AJvYcCXQcG/Mbzd1sdb/pBD6cSp6wFYLFOm7aCKLqTu1VxZOXBxQix+4uB1+cb5KZuUHWNMoacYyWVqw@vger.kernel.org
X-Gm-Message-State: AOJu0YxsW/aMVq/JlhsFO+ziKEmGJobAMOFr3++d8jjuyIuGByMZ4YBD
	1yOlEyil9NT65nxSAorZ3dd9yF+lf3VABfa86xG8oT1TaIV0F4H5gisNmGcStZQH41npzkgvmz/
	mksK2wF2NZLrXasxAJVv5l1x52tOUCePqx0oeVvXg
X-Gm-Gg: ATEYQzzExmTkCy8zuB08rr6MLsatPuMLyHPlEygHpIq0LjvKxDLvqre0IYuz5NVGnnm
	ssW+SxIGz5L/xusyQHCfKL1uPdZlgu9dsoV8QASK3d988r2pjDpBh/sPENUgyRAXNy/eMkfsGx/
	Ch7wSE84+lflbpilcnI7cMWdWwX6dxm06eqmIKKQa4M/zYOygnCsFQjAxC/9KTpXZfLTZdDgcqk
	O1Xx6eWk7y4MI2F3QQz9QfvePOQ0XT14Si/M7Zhxg8p7WdacmeNgXbiddsqi9eUESNejHDSbKNP
	Hlytw0hl82ihcTlo9U3VTZSx0hfCffkS5CPlxw2u8aZDfg==
X-Received: by 2002:a05:622a:11d5:b0:509:174d:3224 with SMTP id
 d75a77b69052e-50939a12f0amr2336211cf.11.1773181451647; Tue, 10 Mar 2026
 15:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306131941.106248-1-cgoettsche@seltendoof.de> <CAEjxPJ5woS1uBHPE_69rcootf3Z3ZRjnZijAk2PWnNzHNYx_jg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5woS1uBHPE_69rcootf3Z3ZRjnZijAk2PWnNzHNYx_jg@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 11 Mar 2026 09:23:54 +1100
X-Gm-Features: AaiRm51rpFmY6glGBje6IlqMwM7uqpGQH6Ki2WzVl2EcAiUG4oq7xpplwUib6RY
Message-ID: <CA+zpnLeX1XrH9ZsockEG9U4f6F4ZhHvYzsL3GAoPHspcWaKKHA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: correctly find partial matches
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 11:46=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 8:39=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The current lookup for file labels first searches for the deepest node
> > matching the lookup-key.  Then all definitions of that node and its
> > parents are considered.
> > For partial lookups also consider child nodes matching the lookup-key
> > portion that did not match any node-stem.
> >
> > Example:
> > The lookup-key "/sys/de" will result in the deepest node being "sys" (a
> > parent of the root node).  Non-partial lookups don't care about the
> > child nodes "dev" and "devices" but partial lookup does.
> >
> > Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> > Reported-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Where was this reported?

Apologies. I sent an email to Christian on Friday evening directly. We
were observing that bug internally, but I wanted to confirm my
understanding of how nodes are used in the new lookup_check_node
function first.

Here is the content of my email:

Hi Christian,

We've been looking at importing the latest libselinux into Android and
we've noticed a regression, which I believe was introduced in commit
92306daf521 ("libselinux: rework selabel_file(5) database").

Basically, we are running a recursive restorecon on /sys during boot
[2]. We have only a small set of entries in file_contexts [1], mainly:

/sys/devices/pci0000:00/0000:00:[0-9a-fA-F]{2}\.[0-7]/virtio[0-9]+/net(/.*)=
?
     u:object_r:sysfs_net:s0

The issue we have noticed is that entries are not relabelled anymore.
From my understanding, the /sys recursion is stopped early because
selabel_partial_match [3] does not return any matched entry. The tree
has the right nodes, but it starts at the node with the stem "/sys"
and goes to the parent. But it never goes down to the "/sys/devices"
child node and below to check that partial match.

Could you confirm that this is consistent with your understanding of
the new implementation of lookup_check_node?

Thanks,
Thiebaud

[1] file_contexts:
https://cs.android.com/android/platform/superproject/+/android-latest-relea=
se:device/google/cuttlefish/shared/sepolicy/vendor/file_contexts;l=3D65

[2] coldboot, restorecon call:
https://cs.android.com/android/platform/superproject/+/android-latest-relea=
se:system/core/init/coldboot.cpp;l=3D112;drc=3D188decdba910079c26a87a713685=
701644800ff9

[3] libselinux, call to selabel_partial_match:
https://cs.android.com/android/platform/superproject/main/+/main:external/s=
elinux/libselinux/src/android/android_device.c;l=3D558;drc=3De25bf403671b2f=
61fe18c6a4edf8470c9294236e
(this is Android-specific, but there is a similar path in
selinux_restorecon.c).
