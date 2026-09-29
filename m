Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87124524AE5
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687520; cv=pass; b=hY1GNudUJUWYA5akAV1xIIu+T4lc7gcxrmelRLh93Wk7IfWF2PFYoo/eY7PctTu46RyMI3fIwWx92SFG0pep27rS3R//fswHTnY1igJJiGGqCk7GyZDcgzweLWNk5tTUIZ+JOUnwYgXDuTy+Zf35myGEH3ftQx3ZIGNOpde8CrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687520; c=relaxed/simple;
	bh=YX3q+5ubGxTSDgX0az+AIP8CZ/w0z+osiovLA/V/6po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJDc0NAf/iu2HYvUh1iHGpVNIq/dtyRJu66my+sVoCrAEX+EjC4krWMjkU3i8xH1JeQzl/hXQrE86//rtyIoMBtvpvnP875s3DFndaP6lJGB/yn85cz+xE/eHxjAZZkczkE2pYyJ0/6fEvC2IwhwkLAhrhDfyWetqMQ5R3Dl7Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+Ehc4Pj; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+Ehc4Pj"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a859892080so33255707b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 06:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790687517; cv=none;
        d=google.com; s=arc-20260327;
        b=EMvYETECMBOreiOePaeJy7qKOtw1ypyeY+cipegpYOrCg3LeK2VLBt7snLn/xuP5dv
         9rVzTuzYJvQJcldt2l7cOm5SR7qPZlTqH1wPMOSkgjasXhLbdf/6QH/v18GNqzfpuc70
         /t0DoEHPgU7wxN3Vn2zNDAIZOn10rzPKOWkYZmVq8cdkfEyvI+MetBaJBfy5WH4sGYL2
         m5FoMmCwbYoItlmXGmmLe5MsGZGRG4mEuof02HK3dMbTuYWxvM3MmRXZB4WmwKVgdQJg
         y+9pg3Hy0KxV2L0nDYWUzAWAG20Lcv7NS3lJ7WjEZ5bobMwV/IwNHdIqiR9Noi6DXH6G
         aIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YX3q+5ubGxTSDgX0az+AIP8CZ/w0z+osiovLA/V/6po=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=KwbweHAxfyoYLrzD6+E+PjCJEW+3JhU7Gkm7rjEtrK7fumq8maRlN/RxO0osaZm7cN
         qDLXm4b1GQ1jad/WFTdVG9fIo6sE3OSndGXQUbN4IgS25IzQFD2kTlNyVlyIMf9H6f6B
         45PdeKTcdTVfegAF7hs87dfMvQREWW4mk53Um7xMQ7UHmxitbVc/LvFTqGCb4jVUsHfl
         rxBI2HjmNDmCAUnUSqQoRnSfAYHJns5zG/XKZDfxhQ8L0iKnPXLXkTLp+Cpf3AUd22By
         eQL6wx9hz6m5kbzFF7KYKQIc4nOQThMIzlVOHE5pxOWzLXh4ilHHOOwRjA2QS3PMIdYy
         A5rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790687517; x=1791292317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YX3q+5ubGxTSDgX0az+AIP8CZ/w0z+osiovLA/V/6po=;
        b=G+Ehc4PjtlrovXoh7oE2VgofqSNb8iWQh0rceE7EWWg6DAXSTAOsDpqeDPc5Xm4aUR
         f/9rwmlWgqACuTa/duNN3WJzJ+zjjJdnFFB7nKocPyXB6tciWHpLVeIdf7r2yJ9bwqv7
         1rIfaoAD6kaIlqZUmhvieb84OXYzHNuCysWhneT3yY0FGAcOBIO4DR/bIuE0ff7UEqQj
         EXxpn3XFKOehzbP3fvHayTgdTv4qhlUteqwkwe4m1Wo+4gqRTWvK/KCXKKNuZul5HbxQ
         ejyA/qWb3QOUX4fU7N2JdtG5VsjYgxPnj4m6RrA2WqZB0E9xKk6nxuN0k8fMpauTKpXK
         oXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687517; x=1791292317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YX3q+5ubGxTSDgX0az+AIP8CZ/w0z+osiovLA/V/6po=;
        b=Ozz6dpsqhn4SZC/xccKCRujEErSle3rmmV9tTLEqx7A5rgyI6Jk28xtXcPWZr2UykR
         kkOjPvFje8I9fQZpql5ypvq2IwiPxHDc4Dglnw8EjkOLsk6FXvpq7nyUZdoPiROqlTqL
         It1MM+hVeGGwGplni3zfOO2GKIQ2FwXeZvDZtAaN524HUQgoZFhW+nUsmoQ2D5EZbgiK
         jvPsxQwWBE+1tRBCahSyEqK/siz9o/re3FsUIKc+a8ZH4lPhHhAqW/trNqMbbZUpLGln
         bY6K7FyVZiF6P7CpQQNIv4cLQl0eJaaImWCRvX5qqr6+RpB19ZVJYPnNn3CEYwQ72QX9
         f7Cg==
X-Gm-Message-State: AFq9FYJkhBNES68/yQG9CdlRoDT/ZjzaeYX/wKezSoLKP7MlxfiQTKgP
	heMRFyPvDqckQRkZH15vXWsO0K+K5HYOyny/o/4436+Hn1c/C7Lu1yPZi4OngrwPHnjRy50wz3K
	P3z7Tg99kU0I+Ke9zXecgD7R9YzPGwdM=
X-Gm-Gg: AYBFou0QIpPpir+98ennduM4WB7Uuv2qaApJ4ArpNOCJcpvkkSxTkIM3TviIQhAvu4L
	+aUZetfK55yGkeSU9vRP+4zs58kFHOQxL5woEBW/uROxx+u0tLTRtvo2QF1sb3W/h7LXWuIkKDZ
	Xak+9VQg65xxJgV3d6DclmIzrzGsW3cpFNdYx3cLTVy0TQo753pRYrmeIDSV8fsStQGoKf4q9GN
	RrN/PJ3/GEy4Z9OeW2RtpGqZKDZrmzOYvqM8KF6Um0eGc4qG2sjb5NGK/38B5ZFl7P0AJAeZuqd
	SyqGtJIaQhfLyKcw1VSKlpypih+u6yHiXkwzHpl57mk/KcI+uL1VRxI=
X-Received: by 2002:a05:690c:e3c2:b0:873:5bd1:98b7 with SMTP id
 00721157ae682-8a64e5bf21emr65936157b3.41.1790687517373; Tue, 29 Sep 2026
 06:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de> <20260928165253.2388012-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260928165253.2388012-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 09:11:45 -0400
X-Gm-Features: AclHuK-iCOq6LIhk_vv6Y3-TyIB8vsaf39MWaekMnAP0T53Au5CE8yrFXX8uKWQ
Message-ID: <CAEjxPJ5qoYOAj5qB2h1G0f_G=3A2TU9g-Deg5FdVYR09N2-arw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: validate permissive and neveraudit map
 types at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:38=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The permissive and neveraudit maps are read as ebitmaps and indexed by
> type value, but their set bits are never checked. A bit that is not a
> defined, non-attribute type is silently accepted. Validate every set bit
> of both maps in policydb_index() with policydb_simpletype_isvalid().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
