Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F61A9FB9
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885479; cv=none; b=EOGesfEe6Vvvu0iXBNOwT/OqMB1eEJ+/fgzq4Ss9sCkd1Vwx5wcwSCXHaB9tXNm8hLWF4dYQq/7vN5VqhCU5OyWoUXn0B00lFvs/niE7+2abQhTADlW3o8mVIs3iiYhUZUqRIgHEpp4a/Y+g+c2P4gLZBzsP0ZtTYJX+dkQHcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885479; c=relaxed/simple;
	bh=W90gwGqWT40ApyYOMCDDXITeb6OYMf4Wvi851kyECII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VL8P5cejAxrtHPhwkRec0g/HUque3jRVoLXKT9VDDlF/es8jrL7x7GiKccvFspRkmRrVVz1g9tha79/QdZxfhgdg4C86uP7h75vPpYmOeYj/LBOMbGfp2qelvxmI0pzE2fJ/APfrpXYW49gzD7ONYSfmXvk5EsEhUaCXs4DXq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flzs8lpI; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flzs8lpI"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-333f8dd3620so17132841fa.0
        for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755885476; x=1756490276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmiQsV7r/tZxgxo0WZ1l1aILYdSAy5vCTaxpPtykcIE=;
        b=flzs8lpI1IViBeY0aJzdNBmuQ8cDDIAqvTB/DvHFfjIQo42L05/n8YJ0Q+tN2gQmGJ
         tJqM3Bjam7SycSgs0W5THFJ/LYUY4xtUn2BUFT5FomxFE1+sVOiFwOtodBqMvZvwuq6H
         6y7jVbbNPaGiCVWnLinr0ztkpWT37hYtdXQNilDegcgacU9vgaPeITJbniBNKgNTDEdJ
         7CAc88WXYtPEPY6GqOppOkU+DssImPmIOLlTxZBn2IXrwADwFSFQj/RA7rfozTWTYMQU
         T47BwoYkiz9zvmieE25DStOl4U9rrjdaVmicjpRh1/aQ/+KmB6Sew07WXog+wykKCoBN
         UexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885476; x=1756490276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmiQsV7r/tZxgxo0WZ1l1aILYdSAy5vCTaxpPtykcIE=;
        b=RV6jqLtKiYEb0jzfJkGkIHIp4//mvvXWHRiBca0elmFo84J+7Izx1ycQ5Lti9ebvK1
         G7fCN3cgRDKWpSEPo+ZeKgyLytDC3pvT620rQs82HfM6163Xe1tUROpn2XLvmffHEPag
         3RzF4KV4i7yth7SD8hesV8Z9J9+ypVD8IFG4XFpjNUNnXlz5MEzfX9iLV8epofkWOjJz
         z0Qny9BLrDqRvVjS614w1bR1mHceAA35gWXSaDifNW1dByUNAVtyZW893Od5jVSexNh1
         SALXpWuRx9tPveWkz3JDp536k80j7AD5vhgVUqv3vFnO9uJhSrk3rpdoiUHU0uD9Zrk8
         sS8A==
X-Gm-Message-State: AOJu0Yx4jgqtZgoUcu9DXoRzoIJk8UULJgnZjwgouKYe4pxtKLJ/EHR9
	QxEI5Lf6MrQXs8cSzwCjXzrUPC7nXvcGsx7gsKVXh66eK1W9vAa39Zho97KtU8Jt9oyxr1o0JAz
	RXXrL2Scq2nFPpQD1jcqocFUPrmvo+1En1Wot/ck=
X-Gm-Gg: ASbGncs4oe24oxImqEH/qCxWoSQz5zjGsusId/JKU1jtYPWU9SxX+SYpD7R2Z8Zy9e1
	s9zOF5xkWY7WyKgUA1GkJwA3v0ZdDpui5oTP72FVw2QI6y3dXbouDD5Cfh+MhN3wSPUlsjSje0e
	JQ3QdEvoWrc1hzRkEFBuV9wlx98DQ05HfQyTqh6+80djUEUELV1vdcuClbnPnpJEDP/wh42wP0l
	PutBEw=
X-Google-Smtp-Source: AGHT+IFvGcRELQeDwAnR2CVCBQhaMGynLnOCTc7DMTXmMCLwWbOiuxuoruHe7E0YVgveELidf0lH3UrgVFVpKzM5FJo=
X-Received: by 2002:a05:651c:3255:10b0:32a:739d:fac with SMTP id
 38308e7fff4ca-33651025c09mr8314321fa.36.1755885475846; Fri, 22 Aug 2025
 10:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821182021.304-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250821182021.304-1-ericsu@linux.microsoft.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Fri, 22 Aug 2025 13:57:44 -0400
X-Gm-Features: Ac12FXyQrbwUUr6LmU4RfdnIsdHzJRC1JQY4o8FvDgwwPic4NzXQv6J5CgIxb2U
Message-ID: <CAKrb_fEx=oKncdp8Ypi5gPuyp=G7KmwUec4sbMO2OOcGEvyNHw@mail.gmail.com>
Subject: Re: [PATCH v3] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:20=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> BPF token support was introduced to allow a privileged process to delegat=
e
> limited BPF functionality=E2=80=94such as map creation and program loadin=
g=E2=80=94to an
> unprivileged process:
>   https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-=
andrii@kernel.org/
>
> This patch adds SELinux support for controlling BPF token access. With
> this change, SELinux policies can now enforce constraints on BPF token
> usage based on both the delegating (privileged) process and the recipient
> (unprivileged) process.
>
> Supported operations currently include:
>   - map_create
>   - prog_load
>
> High-level workflow:
>   1. An unprivileged process creates a VFS context via `fsopen()` and
>      obtains a file descriptor.
>   2. This descriptor is passed to a privileged process, which configures
>      BPF token delegation options and mounts a BPF filesystem.
>   3. SELinux records the `creator_sid` of the privileged process during
>      mount setup.
>   4. The unprivileged process then uses this BPF fs mount to create a
>      token and attach it to subsequent BPF syscalls.
>   5. During verification of `map_create` and `prog_load`, SELinux uses
>      `creator_sid` and the current SID to check policy permissions via:
>        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>                     BPF__MAP_CREATE, NULL);
>
> The implementation introduces two new permissions:
>   - map_create_as
>   - prog_load_as
>
> At token creation time, SELinux verifies that the current process has the
> appropriate `*_as` permission (depending on the `allowed_cmds` value in
> the bpf_token) to act on behalf of the `creator_sid`.
>
> Example SELinux policy:
>   allow test_bpf_t self:bpf {
>       map_create map_read map_write prog_load prog_run
>       map_create_as prog_load_as
>   };
>
> Additionally, a new policy capability bpf_token_perms is added to ensure
> backward compatibility. If disabled, previous behavior ((checks based on
> current process SID)) is preserved.
>
> Changes in v2:
> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>   creator_sid from wrong file descriptor
> - Removed unnecessary checks for null, per review comments from
>   the first patch
>
> Changes in v3:
> - Removed check for 'sid =3D=3D SECSID_NULL' in selinux_bpf_token_create =
and
>   allow it to fall through to the permission checks which will fail as
>   access denied to unlabeled_t
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>

Tested-by: Daniel Durning <danieldurning.work@gmail.com>
Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
