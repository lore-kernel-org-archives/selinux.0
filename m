Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633D41E6C5
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902712; cv=pass; b=YBdC/KwJ3gH4Nro1hoiqjIh9Z4piBBQ19B0RocBtTa/Kt56aUL/dzApoxEH2fvr6mXx6ppa4q3jr/J3nHfsC6uJ+UmScCLrs5odtnLnS1gG1yMdTShltPTKyLSowrn8gWaShgwYinu3FDe7iFHtgZXpy8FWQHCs4fi0MPoZZp1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902712; c=relaxed/simple;
	bh=h+qXSDm4T4NLRB7Q5QH4cFzpXt0lh2rhpb0jPwJdW74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMJeHmWTfJPTTz9TFj9kanfAnJBXiJIMecmiV2DK66GUcXE3z96pNk2RzYxDlR47G4BgeRc4LogvSGIM8b+dirPIUv8ndsJbtkOx1haTSioIalfMOD3h25iY+Jsky6rl9WWCyauQx0lR0q++B4kRs+Jreo0umD/f6by/WBVpcco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ1dxLka; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ1dxLka"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6aac8a94a2bso241910eaf.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784902710; cv=none;
        d=google.com; s=arc-20260327;
        b=XTt+N1CGqF86sgvK5lHo+cloVjTNRxiqbDaBiLRBchygmdqaeF30SxmEJWBZJeEaIt
         37npmrKvsGjAuWOVMfPpYHBlfWmehzIV//snhNhclPlrTeuPQOmdKcf3clZz/a+KV9XF
         EHqavnNjcO/y9XS3Wohg/NFIgX3YRA/uvW0SifWZ329WvJVcyev14tJ2tQakLIcirWji
         ri5tNQnOIIR4EMyyG36kZe4iHZ3hw3JWTdEXUMd2DueQLDNjMCUlUcvqIG1XY2+ewcNQ
         zrEE4F0ASuFRw10CR8akDiesfzaO5b6Icc4edLK7rYK/caNa8l1gNvXOo6wlzSATp4JK
         Z/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngHB6Y1XjLhyR8wt8jc90vlwFdx/kOT1Mh9ZmO75HRo=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=nT0OFGJHxzl+QdWHj/Z852WI2Flft/j9K0zszKMS/Nh5GH0b1D6LlvbmYd0jIGsH8q
         vyp6VwFD7ogFAO+saZOUnuv0BWRBIbt3jThigcZfyzgHifiXPypQLOK1TerWSzWBADjT
         QY87wnjO8SyKjyfkzd791tAeDLzSW7zQI9V3smflH4ZHVCFwzMNKXZbNxWiu6bGxhTtR
         VoYTGbk9B+QSWfpeOS3Gtg5UJLh0upYK3oJV+5puswpZURDofQlr7HkFwI15m1tEDlMD
         blYe4YHJx1UOMngoCPQM6C1YgGEb9QXEvSYv2nGDsjSrepYpKTItgqOEddP/Kh5z5I34
         sMHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784902710; x=1785507510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ngHB6Y1XjLhyR8wt8jc90vlwFdx/kOT1Mh9ZmO75HRo=;
        b=VZ1dxLkaRQbMM0js0KVivr4U5JPnCcnzSDnqfqJ5NK0c1uwnVv12KE3yAPPSNqeSq2
         p//Y3EKCUCtHnkSa9ncDUTzzHx6yTi/ebZctwjYrAc7/6jri20omSpFcW3d6lQCT47Wo
         yFygcVHYme2G5YFeW2zgVtq/YNEvMyeVRwamf6KZuASbCR9b+bprWXBZ6+7nxxJ9RHaI
         wxNkxquDd3ul7uySof1WZ+tGneBgMV52yGNEO3OaobsWHMz4do6IKrDy9ZRBaaCFuGVE
         J9auv1DUAqUUDELaHmLg/5HlIMlW8q9eLfoKFarLv+fKfsINc1i14MBofjLH1j4cFnkm
         OB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784902710; x=1785507510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngHB6Y1XjLhyR8wt8jc90vlwFdx/kOT1Mh9ZmO75HRo=;
        b=Ljsa+MwFUCjqZANMYDXnRRWtrhTfqnmOTPAcVpTW8nG/98+Z5EcWHaFy3JBCBroaCM
         z4ICVx27v0hxR3u90abLhuEDD8EXzSsXyyBW3Yh3kaIc2FcyAYJ/oWkIBElYsbwwsY7G
         zkWvnTbTo5S3hIe8piq7erqTGqRg6MfS1dsKU+9oLJEAzOvQ/ETMmOMOLDL1dCgv3fk9
         fty0eeQcrcYasChYKxPddTWApCKi2nIde/6rrwF6vXXPYkJynxyWw29f1Fp6903aFReg
         6lxcxpKnOzO4J0hJVtCSBAptFFKZUpt7Bt0HRHFD5yRI3nlHYVNFm9TbnEw9+EroXSbk
         +bCg==
X-Gm-Message-State: AOJu0YyZeNki/rYudI37HBQJArjv2oe9lONFhzIOy2rHkS/qdHcnzn+4
	K/vpKJv/x4FrSD0t4tRy5T7SUvUIo2qTb0W0pWnR5zbH7XKj0jHsY1sLPUEDiEfX4/MOQWLpODn
	xKmwFJQycdjUikmQN8pFAW7zIz60FUfPxtA==
X-Gm-Gg: AR+sD138pHlpAMsQtJWTDwCTO5t1rSyGct75j8ZoYJcA/x9tI4vpgTz5PEuICU5tzgh
	ylJws6y4gyUHqIgafxZYT5a+uXTRr86TVz90NTtr+iW/EH6fpHRk5lFFTirdsCnbdhSS3xa5XoI
	jJPrkn2isG/QjeoB+7Lg9nRSTY01OB7bwDqYjcThI18zMBz+gsnD2qL1TOsncAyvHEdB7k3H9na
	wce2qYAw+jCzPIDyscyPOEJlGHRHmDsGiINaK1gN+tly74Q1VVmQ/rhisvRKA==
X-Received: by 2002:a05:6820:997:b0:6a1:7953:38ed with SMTP id
 006d021491bc7-6aad4218487mr3890688eaf.67.1784902709711; Fri, 24 Jul 2026
 07:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720183745.47045-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260720183745.47045-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:18:18 -0400
X-Gm-Features: AUfX_mzJ1isMdsmtFGVRuIsVG0Sr5Q9OJnbyhV4iXFW2ovBy6SUrbfZjrY7QGeM
Message-ID: <CAEjxPJ4AfZS9dVUmC2nCm9A0=wAeErZ+UGaJOR2HzPghL8BXyA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/scripts/fixfiles: drop unused functions
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> After "policycoreutils/scripts/fixfiles: drop /tmp cleanup", these
> functions are no long used, so we can remove them.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  policycoreutils/scripts/fixfiles | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index b5f193e1..493c86f9 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -66,23 +66,6 @@ for i in $FS; do
>  done
>  }
>
> -#
> -# Get the default label returned from the kernel for a file with a label=
 the
> -# kernel does not understand
> -#
> -get_undefined_type() {
> -       SELINUXMNT=3D`grep selinuxfs /proc/self/mountinfo | head -1 | awk=
 '{ print $5 }'`
> -       cat ${SELINUXMNT}/initial_contexts/unlabeled | secon -t
> -}
> -
> -#
> -# Get the default label for a file without a label
> -#
> -get_unlabeled_type() {
> -       SELINUXMNT=3D`grep selinuxfs /proc/self/mountinfo | head -1 | awk=
 '{ print $5 }'`
> -       cat $SELINUXMNT/initial_contexts/file | secon -t
> -}
> -
>  exclude_dirs_from_relabelling() {
>      exclude_from_relabelling=3D
>      if [ -e /etc/selinux/fixfiles_exclude_dirs ]
> --
> 2.55.0
>
