Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961434BF935
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950915; cv=pass; b=Dq+yORFOys2veLpPT3YmyxQxE06o3QfVGSlGijZFeroUdL+i6kXQqMobwkiP2kHYOiewnum0+5GYnHwSJ0Zk9862smqxB8mVFTfnMmalb+G+afCse/Px6azVTJ1nHvf/EWQN1WjMwOdQHeVlhH87luXw6RNCahwBt2v2MJZXefI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950915; c=relaxed/simple;
	bh=mUhSevClXvoks8sKBt+JTl1XFx5mrpPgo19J5oyG2fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMSybdtJnBKZQIaAtQi7vzbQmyIxF74VVINYYhpowQBKdkiGlPo0h6mFkClsuX2J2idsqhip37fF8JyciAGuIWyws7HoU/t6cwXOOLJ02NnNDkRDiNkfkpNfp+JlHxegsfy/cJHpzOrtyqc8OuFHTMdPjlMJnZnUghga2a6pTV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha5I8R+s; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha5I8R+s"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4ab201ecso7257084d50.2
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 07:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790950912; cv=none;
        d=google.com; s=arc-20260327;
        b=H2yS4aVUSDUqHL7f6F7Cgjv4q9enp1VL+AfubLJU1xTYjahK6xlFotiQCBOkDonEB0
         OrKoKXWWj3s7f7+T5HvppxpVu5Ef5guoLFWxgvsKLVDamSpeDK6z3HedSXsG7lKQbUeF
         36UAHXLfYZ30XrQ5wcm+WWTEhn/ACCn4qPDgvq3KkwujkHqF9uHsV1AjSTXDddZ1vrDK
         6I6H/WKYxkOb6delTK2Wj2H+s+dgADnakWpLPKNVbDfiKXlOfA5QmQd06u0VKyLZDWHt
         GHe15EVDOUwX0MppjC7QX7PcinIBIjlYNZ2gCTpOSEvwbvNZauG0TulwLVzFy91TZu4L
         Elzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+lWyZFq+ckp6O5YHn45Abh9McV/EidNWl0+bse/8qOY=;
        fh=+/jkIbTpILq22bdT2iyNUDyKgmv7eCl5AoATw4+EBko=;
        b=Lh37x9m9Gsa1bmKJVU7bWIs8KBIBjlhrNZJz8xA96P5bIeIS6uKgyQTOQa+958hFen
         aVSfk7ZpCVq1jnsOzZYmP8CSWUUWsoDGGSou+5JXfoMSCvdu7bUzEFGgPYn2J9PXB8Bl
         1OlIIKgvhij9wWVDpI8Ewlvq9Uv37FxeNVWF0LCp9E6tDLhL3U++w/CQtAtHaFx0IJM9
         bL8mBEmyU93lzbuEE8kFZCuOXTX1qGuDlcLusaRNmpLBvsWHuPk6+DR5tv4Awc1NAeHx
         ximRBjQSbvGz8JYDGRko9ULSzIBb0e6JXuKFdiDx36dmDTvBJcNZ/HdXmeyT2+T2VteA
         M73w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950912; x=1791555712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+lWyZFq+ckp6O5YHn45Abh9McV/EidNWl0+bse/8qOY=;
        b=Ha5I8R+sZGm39xq+GpPSbCzhlhQrAAY3mwdaHHAwq7Yt8d1U9UufGPj4oNkoo/MDyW
         s9gOeMC6GAPJByf3mE6K3fR4DDNeMdBrDMy/rIFsM39HcZP+TcA3A4BMGIAA5HMu9Zyx
         txrDk5nIJlPjQao2rz7HmZxc78/Rl4vBsWQenKtvOMxeBBerQ0g5Favira4VN1ZXVjoW
         +P/7z8lzmKl2Wf2NUFXc53V6QJpDyLMWwi4X4K3WVDnEXL2qXPABX0mGEXc44+Gp7ttt
         EF9fAawKw/zYCazbnwwQNrdZ3/Wcbj6g2hoqcdmzCw0fZ/YYox4OqNgTSf400eduyE1B
         nceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950912; x=1791555712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lWyZFq+ckp6O5YHn45Abh9McV/EidNWl0+bse/8qOY=;
        b=p0ASkpiyZm6s/jM1/NACbLDj/9GkGMr5/4IC01ciBB3LUXYrlKjwPJat93LoBBnHvA
         ETs36Q0JfNkV1CvjqnF73VggNzuZPpQKuJfcOqi2EU470ByPqALmnlvVItQPuU7U/Pu7
         u8NJ3Q+qlic7ztoxvoMa8aMuHbmM/AqhA/oWZMlIFENQDdqv+N84VMjKuAuO0RfLXnIt
         WtHeBrQpyKTsKH14ZR59BXqM/RP8u1HGLl3q+dD7mLhcHWhwUsDe7cVSykrAMVvt4gK/
         qF9et8AgX5cQg4hyTmh7L19P3+S5+cFGmvcinTlk2doi02IB7X/QoPEhxDVnId919TVc
         DivA==
X-Gm-Message-State: AFq9FYIdepsVoLnyD9nI+ttK+nODEHdcD8tO7jMunBD15Bq0rDiAE++c
	NGQU5/cclAEuWTqzc2FSOH9uNxI5tbrEbxmXFcNQ9pctCFS1e4HSi+liSDuDzy0b358K3KLVgcM
	FFOtKCfglZJFcXe2jyBzHUXjiXbVnIb8=
X-Gm-Gg: AYBFou0lwC9OmILAyMlkN7Pk87G2XPmEZNcJTSvtuI2ArZ5rDmqWe+DGqZ7MVZjxACx
	Cq58IXstOXDaSYQ2Y1N6Jvz889hnNWcC+NUbqAX18QHkJFIf9Xtcv2sGRcP0kZ51XuLLuZcoeDZ
	LHwCT0ZtsIN1vG45QTg+KP3+9MQQqyIvvU2Pap7sfZkqDspcss6353wVXH6rSmU5ahGUuA+WLqo
	7oywuc1UilK/W+zDgOp+qeyMUi5aGSwFtgUxVpgbK4jZDD+1SdGwZJ0Y55PvRWV1kdtjPePOImF
	ffFWRY3PHM0mzGle/uQUqnyS/HCyNK9Zg938S2rb
X-Received: by 2002:a05:690e:144c:b0:675:3177:bc87 with SMTP id
 956f58d0204a3-677ac0dd3efmr1001665d50.95.1790950912097; Fri, 02 Oct 2026
 07:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710081533.451115-1-jonderka@redhat.com> <20261001153456.104370-1-bgrech@redhat.com>
 <CAEjxPJ7E_dVUF6XRJ=zS2fBh9QM_aw+k_9fWyxB77nUKQKiNog@mail.gmail.com> <CAEjxPJ4c_k3EyRGoe+wRcsv_==WZE76UujJXp31KjSs847qXkw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4c_k3EyRGoe+wRcsv_==WZE76UujJXp31KjSs847qXkw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 10:21:38 -0400
X-Gm-Features: AclHuK_k2_zK5d24weuM7EKvubKPSq2-Kyn41iSWZ2gdjqpihS6O4O73CO-RnVQ
Message-ID: <CAEjxPJ5XumniFe+WuWiLUcGDYJ6zzaaafdPrvyxkNcVp=g8yqg@mail.gmail.com>
Subject: Re: [PATCH] skip inet_socket/mptcp when MPTCP is not supported
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org, jonderka@redhat.com, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 3:44=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 1, 2026 at 12:49=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Oct 1, 2026 at 11:35=E2=80=AFAM Brian Grech <bgrech@redhat.com>=
 wrote:
> > >
> > > MPTCP is supported since kernel 5.6, but only works with SELinux
> > > since 6.5. tests/Makefile currently adds inet_socket/mptcp whenever
> > > the kernel version is >=3D 6.5. That is not sufficient: some kernels
> > > meet the version requirement but are built without MPTCP.
> > >
> > > Gate inclusion of inet_socket/mptcp on both:
> > >   1. kernel version >=3D 6.5 (existing check)
> > >   2. the net.mptcp.enabled sysctl existing under /proc/sys/net/mptcp
> > >
> > > v2: use the net.mptcp.enabled sysctl instead of grepping
> > > CONFIG_MPTCP out of /lib/modules/$(uname -r)/config.
> > >
> > > Signed-off-by: Jan Onderka <jonderka@redhat.com>
> > >
> > > Co-developed-by: Jan Onderka <jonderka@redhat.com>
> > > Signed-off-by: Brian Grech <bgrech@redhat.com>
> >
> > I'm planning to take most of the patches from this series:
> > https://lore.kernel.org/selinux/20260928155753.2259807-1-cgoettsche@sel=
tendoof.de/
> > some of which may make this and other patches you have redundant (or
> > break on conflicts).
>
> I just merged the subset of that series I acked so you can now re-base
> and see what if any of yours are still relevant/applicable.
>
> > Might want to wait until those are merged to re-spin. Or if you think
> > yours are better, let me know
> > and I'll look closer.

I looked and I think cgzones' patch already addresses this just as
effectively - his check is in the test script so we still descend the
directory and run the script but nothing extra is built since the
inet_socket tests all share the same test programs. So I'm going to
just ignore this one.
