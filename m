Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B31CDA2D
	for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682075; cv=none; b=dm8VTzhvtNT7rfs4ZHTVY0T7fI2vR6YpuqmKzwgBqWpV1V84k0jp4PSgEivc4t8T8A1+sBCBQX8t7hQJtq+OHp/dUI44uziLCnBQN0iYpZnOdjXeXcy3r1K/VgRM2ge1BFSLcbcNPjyNVUS9EYgcOAX1coJkrpWII7+R29+9OFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682075; c=relaxed/simple;
	bh=T/EyYVYYGd+GoKisfYhrPazHCEASjhtX/JUIQXjgbmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfuQd2zr6YTGVuFr+JJbm2fze1HLRjjiZ0O7033SHDPHCKF4RySmuBiYSzDOv3VNVN4M/KWxIrDH/rV+T9BczEwaaTtjng0nbzLudGnAQXIRe6NFHWh5yUkLd4GLrP7OaGKdrjbyOVxMfeKq9KTz6HbiNfMSFRyjk+d+ouNZZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+aY2VkT; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+aY2VkT"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e380f16217cso1947192276.1
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 06:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731682073; x=1732286873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC4dhW4f/hQyKHHqlBrdHPviXzhzjc8n6+Mh96iCHxY=;
        b=e+aY2VkTuBtKn5tiXk4H4PBMOCWmTD7AuFI2hqM+m/JTqH7P2/POKukvjifJIQ+E3H
         k+OvlowyWu2dx2ANkmp0TNzUKvx0lCionBLKnM+013DCU9Qm4a1402sdd2qQI8gDeykI
         tdXKiuAlzoqpFZ5dFg+A9t8nDqbhOoE5hxdLlQoA7Jf8RhP+f1PXnCFIx3uODR//RGnJ
         i5SmpFKP7J6n9sdQJolw9NF9XgGBuCPsxmJALU7IH0pPeKEhxeFesYMrAGbTIT7VH77y
         mnX/nYobgPZlydEGecoz9KMrcjANeiYChO3K+ludO/IbYLXf/S1BRK4/CpaLPsGRSluL
         Q7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682073; x=1732286873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC4dhW4f/hQyKHHqlBrdHPviXzhzjc8n6+Mh96iCHxY=;
        b=cwjwr2yGHPXJ+JqSyk6yo3f2jcCBv6Z+XmA2tVxAAgpOmhS7rbaHpamtvV5nyKK8Wv
         WlvZBXY+ClTbcNK3ZmVJ9X0OTcVYQEqnrU4eV8wpXTHfW6PCoXeQyNhee11GXjowyTk1
         XdhZGO0GvvxEOM9CxbMCQYteDw/WXqew74cSsWohFVHMYjIfx0H9XIzsDBs7y/cOaknb
         7EnaZ7gmhUm4OC2/pWVc9nmZ9bW/INGPYAwJEIdX22y2NFJU5PXLfv/KvdW7pvdabMir
         tIguvQWcSnxlzu80fLLXExOldzt+T/EhrgMA21aL0gY0bxlqoYmBSQXeBle9wcYHutqO
         giEg==
X-Gm-Message-State: AOJu0Yxn9jHpfzfdpk+S8FKeG9cffKPEOdAjvoA24PIxMTZheHmIRkGW
	CISvJ58+ElPcOMelBrFkAIc06CllGlGhkwafcvNCRXcIgaWxk/63AOOtTUtYeeK5T6wAbACD3MS
	Fv4NYU8QLWu/g/qu4aMqZyUM7GtjWSIwf
X-Google-Smtp-Source: AGHT+IFmiM+AmbtiwbiBk90Nud5/lxhSCDR/2J8G2Maxbt7k1e7x/wvpdJIvyBdscnc0Vw75SkUSf9v1sIiLbrl78jw=
X-Received: by 2002:a05:6902:330c:b0:e29:3bb6:d63e with SMTP id
 3f1490d57ef6-e38265e3374mr2592404276.51.1731682072731; Fri, 15 Nov 2024
 06:47:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113130206.1417824-1-lautrbach@redhat.com>
In-Reply-To: <20241113130206.1417824-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 15 Nov 2024 09:47:41 -0500
Message-ID: <CAP+JOzT_qOFo7b0xroSnK35YjAF9=tuQj74+w_eiTf_3nOyjqw@mail.gmail.com>
Subject: Re: [PATCH] fixfiles: use `grep -F` when search in mounts
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Christopher Tubbs <ctubbsii@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:15=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> systemd escapes luks uid so that mount points contain '\' and grep
> should not consider this as regexp
> Fixes:
>     $ cat /proc/self/mounts | sort | uniq | awk '{print $2}'
>     /run/credentials/systemd-cryptsetup@luks\134x2d6d1f41e6\134x2d5538\13=
4x2d41a0\134x2db383\134x2cd41c2ddcacaa.service
>
>     $ sudo fixfiles -B onboot
>     grep: Invalid back reference
>     grep: Invalid back reference
>     System will relabel on next boot
>
> Suggested-by: Christopher Tubbs <ctubbsii@fedoraproject.org>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/scripts/fixfiles | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index cb50fef3ca65..b7cd765c15e4 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -45,9 +45,9 @@ FS=3D"`cat /proc/self/mounts | sort | uniq | awk '{prin=
t $2}'`"
>  for i in $FS; do
>         if [ `useseclabel` -ge 0 ]
>         then
> -               grep " $i " /proc/self/mounts | awk '{print $4}' | grep -=
E --silent '(^|,)seclabel(,|$)' && echo $i
> +               grep -F " $i " /proc/self/mounts | awk '{print $4}' | gre=
p -E --silent '(^|,)seclabel(,|$)' && echo $i
>         else
> -               grep " $i " /proc/self/mounts | grep -v "context=3D" | gr=
ep -E --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
> +               grep -F " $i " /proc/self/mounts | grep -v "context=3D" |=
 grep -E --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo=
 $i
>         fi
>  done
>  }
> @@ -55,14 +55,14 @@ done
>  get_rw_labeled_mounts() {
>  FS=3D`get_all_labeled_mounts | sort | uniq`
>  for i in $FS; do
> -       grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --sile=
nt '(^|,)rw(,|$)' && echo $i
> +       grep -F " $i " /proc/self/mounts | awk '{print $4}' | grep -E --s=
ilent '(^|,)rw(,|$)' && echo $i
>  done
>  }
>
>  get_ro_labeled_mounts() {
>  FS=3D`get_all_labeled_mounts | sort | uniq`
>  for i in $FS; do
> -       grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --sile=
nt '(^|,)ro(,|$)' && echo $i
> +       grep -F " $i " /proc/self/mounts | awk '{print $4}' | grep -E --s=
ilent '(^|,)ro(,|$)' && echo $i
>  done
>  }
>
> --
> 2.47.0
>
>
