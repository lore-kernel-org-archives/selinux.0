Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F92DB79C
	for <selinux@vger.kernel.org>; Wed, 15 Apr 2026 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254681; cv=pass; b=cl+Tp9VsDuZ6aTiVo+zJJMZpKGmIjU9bOieLbup87uIpmdDKRuz6xMz04RxanoRB117acK8+TTs6/0j6MNyiwAN4/p2tAW/HxrrB398AuGl5B4dhar9txpy8YsPwN1qXo65PusnC50Imj0dnZ2HBvw9Qu6pUD0B9I+hoLFFtcGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254681; c=relaxed/simple;
	bh=yBCbrPi3GzzeB7Uw6nPeX7Oi0XY7l1qiih5hyKSwWJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJGpGHRSqxMWmG33fmgE/rcfIJ8yK9EAggxpXzVRZFzq2x5SxEgFW1n3MFUJCKNAnD9RjFcrPFDdjElzyEGKDuiMnAhg/Tp2KzadbJzPVMC1KUNrRqYmGcJBnXFlPOPFszZM5XpH2hhNWxMOwGls7Jp93hHEEdKCtYNhnxNth4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTkojCcs; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTkojCcs"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b24fede2acso39738525ad.3
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2026 05:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776254680; cv=none;
        d=google.com; s=arc-20240605;
        b=ChybK4vXixRp8BXJ6uy+BEl42DJqCdImNbNcBJcyFC8P/UcuUHvmnI3TYNpnF409sC
         s4dHDmbPZCewganMK39QW+OwsdyXWgHUc+Pl1gBJA31Qm8c7vKRT/FhAfKd0GKICURns
         hfXd4T92R9nAhDv+UgKCFt+Mywm5/mA7jN7Yz4yEz3Yt3lGA+Ahnvhmegjz8xSq0Gjgv
         BQvAq0n1ofSNpsyRgQNWdZv3HtJMIlEZWR2EGFm6Y0MxXT9HdpXCBMg4lQJqugN7OtGE
         VLVi9gjCUcDePF9fjQhLoCYaEblbZe8mOA/amjUrjrjJ/+Wvl8Qlq6gy4tjUtWMd9rKx
         JMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yBCbrPi3GzzeB7Uw6nPeX7Oi0XY7l1qiih5hyKSwWJk=;
        fh=N7PtZmn02hpPdaeX9AswJv/h9+Qwz/x7Uwoq1oOEY18=;
        b=M1ucV+i/xt/+ce+YePzNKNOpAWuMAal4tH2K0FuHM6quuspaSDMGJJ8x4gZeSInh9D
         HT+0q2Q6IXrxDxG6kAyWI3P7f+O1WGXlXQlR0Mul0THYIE4s1THvYrGD+X4nUpQULQrU
         9Acewoe4ofm2VJCdy+LKeOyej0ag9QeY2gx3KfXLl5PqCo9nHWBa6EmrXg9U9lpWFiXV
         fYmbljY7ptmTrsm3DwSub2vybimOF8T1UDj8QKYivih87ADnT5rI+X6g5mG7S+t7UErv
         nE5S11Wmnm3EwS7xPhRp3PquYP84Xu9lPMTrmvuM32+d1O1HTSdGtlXiAuCQZf3XiEdk
         Ktfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776254680; x=1776859480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBCbrPi3GzzeB7Uw6nPeX7Oi0XY7l1qiih5hyKSwWJk=;
        b=fTkojCcswGs4e9oKsojDa82q98tzgSh8AvgoLjxBHrdEzSHhGj7FDq7BRZFk8AqoFN
         RxdD7r/AEX+weV8mTS1IACx4VsRvMtlWY7XzFI09blIrO8bzJiWc/rTzZdrwZYgY7X1c
         XkOxGcI2rNcps8WSa/C3I+aK3Wm7Wxh6/bhGW9fW/nkK0XgcduIy7aUywPh/IudvOq+s
         aw66YVeS9SYt4RdqqqG9lF6kKJJF0sSO2lpDPQm0bmpPPii1cEX8uEUe4gkvTBrOdPbJ
         MLU4uMgUuQna9SLs0bTU/b3ELWf0YqWxLt86M1HAX7bG7ux6gjG3GJF5gzqVZr7jWl+6
         utpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776254680; x=1776859480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBCbrPi3GzzeB7Uw6nPeX7Oi0XY7l1qiih5hyKSwWJk=;
        b=ckMvVakeivZVdnrAiM8E2H+IoFppcUJXH8+FpuaxLP07XieyHvnJfF9qMzG6wiw3cF
         V+FcGnOVKbzHMPZ0tjBSG6DrbU7j5S6Uvo9oBt5AUzamo21TtlHFehmWXbYwPr+JqXI7
         El9FcmoOSJjn9NQZaKnwRCKMFzKdfvWz5Q8i0ixzLfwFcerL/kxmFHXOzTcK1o4DTlPK
         5+vduJKe4gtwmDDawX3+Jp5Q45uexYaNbTtbS8L7v4LKC7rcZx9FQCmY6iGt8V1Hl96V
         +Us4scw6NU0gq4umUuRXZ/VhKDI9wmCaLmX47TRtM298gz+9wW+QTtpKT+TamBeR1IeY
         cMQQ==
X-Gm-Message-State: AOJu0YydNfQq0NkQEkcczzpplKILfukhA3Uxo2nsoQnLL58W9EyrQzNp
	01u7Jn8q0c6M3rbJBGwCF9eTt15RDU6Bv9nL/JsQItOX+KLUDFSDYu9KSJCFlK3+Zkja6KHIryl
	lYDwa7Gr/bg3u3ovWiKUgfQTS+5viZ6E=
X-Gm-Gg: AeBDieuxCBD8sgTixaJiR+oT5+n/rs1ErnWCQNUGePt8E/ld8DfrCaJFa5BJZIHQe7Z
	ozmyFQjdv9SHr7vd+w11R5FYY4fosmaOo81XSspruPwVq9M70TNRGrfMYOOi7+LSMzG+ZMaYlJG
	IAxIzsP4/ycKcPmwhOHLXeeAohF8zea5mGnOB6s6arOqFM2+ivs8Q10zTs5QdyF/GZ00EIA4L+h
	70eqAwl/YasRCMyaiIP99m3txvmIQarEiXZOqir39M3I9NocZPWV2Gi6Q8Lu5qcTpnomw/aeEPZ
	PFpa7ORGlrJcemiNeQ==
X-Received: by 2002:a17:903:fa7:b0:2b0:6e6a:8504 with SMTP id
 d9443c01a7336-2b2d5a3033amr205140255ad.27.1776254679619; Wed, 15 Apr 2026
 05:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330193100.3603-1-danieldurning.work@gmail.com> <CAEjxPJ6eWtRyLpVQ1WvMC=pfddqjmouH+kb-i=sdaHMmAw+A1g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6eWtRyLpVQ1WvMC=pfddqjmouH+kb-i=sdaHMmAw+A1g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 15 Apr 2026 08:04:27 -0400
X-Gm-Features: AQROBzCpq2TAlBrXdM4ZdRua1Kbnl2O4tQW4abKnErwxCUQ0y1TEDshn30MTVUc
Message-ID: <CAEjxPJ4a6=wcUvr=N4rz+P0Qq129tjTrQ00vKB-mZLLYoO-q7g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: implement namespace_alloc and
 namespace_install hooks
To: danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Mar 30, 2026 at 3:31=E2=80=AFPM <danieldurning.work@gmail.com> wr=
ote:
> >
> > From: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Add implementations of the namespace_alloc and namespace_install
> > hooks for SELinux. Corresponding permissions are defined for each
> > hook (create and setns, respectively), New security classes are
> > defined for each individual namespace type to allow granularity.
> >
> > In namespace_alloc we check the caller's SID against itself. When
> > a namespace is allocated the SID of the caller is saved in the
> > namespace security blob. This SID is checked against the caller
> > in namespace_install. We fall back to SECINITSID_KERNEL if
> > ns_common is pointing to an init namespace, since these are
> > created before policy load and will be lacking a security blob.
> >
> > Requires Christian Brauner's namespace LSM blob patch and
> > Micka=C3=ABl Sala=C3=BCn's LSM namespace audit data patch, which are
> > the first 2 patches in the series linked below.
> >
> > As an additional note, the namespace security blob does not
> > seem to be freed when a mount namespace is marked as anon
> > in the kernel. The free_mnt_ns() function only calls
> > ns_common_free() (which ultimately calls the namespace_free()
> > hook) if a mount namespace is not marked as anon.
> > This is causing a memory leak. This issue would need to be
> > addressed in the original LSM namespace blob patch.
>
> Assuming that this gets fixed by the change suggested by Christian
> Brauner, we can drop this note from the commit message for this one.
>
> >
> > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > Link: https://lore.kernel.org/all/20260312100444.2609563-3-mic@digikod.=
net/
>
> Otherwise,
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

One aspect of these hooks that I hadn't realized until I exercised the
tests is that at least for mount namespaces, they are sometimes
created automatically as part of other operations (e.g. fsmount(2))
and hence these permission checks are triggered by more than just
clone/unshare(CLONE_NEWNS). And since mount(8) has been updated to use
fsmount(2) followed by move_mount(2) internally, these checks are
applied for "ordinary" mounts even within the current mount namespace.
Not sure if that is what we want.
