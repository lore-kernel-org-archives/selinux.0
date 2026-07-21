Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401737E5C4
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678393; cv=pass; b=QjgID4Pr3oYDy1iCjZBQtYEdFI9AR45tvjXrUuery4sy1BGXXBSZjuQGR8i25l5gKhEU3uYr9u97lggjn6NIQ0nc/k6bcFtLSlGFFSXL46wr1knnBtCzegI0H+yHP/Y8J3XcU2U2HYQPmSQDwuA1rTbCvfoerqUHfHXCOD0QNZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678393; c=relaxed/simple;
	bh=L0g4ddnMHsPZoKFrZ/b1lCPUW29gUN9aXQ9M3Rwmjmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKOLvUc8G5DU2Rqpxf4aAllL61zumVYo0qpLqFfALnZmSqdEqRteBMmO/uk5ZkFXFZW+ush8aBqfkbUrYRxIfr7RgsWU0W2r3+pxLwvEpWBlM/HLNDodNMp2GCtQA6zZDxO8UKp1aDnR/icsX4OD1aodbsShUF6TodQ5qZJWwgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjTE8jYe; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjTE8jYe"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c10ed63c0so1455231cf.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 16:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784678389; cv=none;
        d=google.com; s=arc-20260327;
        b=E2QGyajPzV1C+XCbos+y1qT+9XEo3MTck8N7/RX7RKDY+fy1Pl9cMypI2laSrpw5w7
         F7Xr+uqKPtku5g7BQFbZh89yhJwGazhnU4yWTpv/0WSrYNXYA4UYCBMGVmH6WeMp587H
         i3AU1itJaoXG9JhJJ3jE8cBk4TuCeO5dlpn5YpxqWsY7A/NLcwjcsOhJLj28WfdQ8SY/
         q3+fR9lUyclI9vSnxzyeR9qI6j4R2oEOxDYw1flkUGs9CZnGuLS+eWQZBJX5BL+i/Qzc
         NDxOi3VVGHL3VSYPMmSkr6piIBJP/AoAeJv8vVOEqQhF8UlPeR5gCwh4Q1tkYOw5g0V7
         h5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lp6Tjz0agQfwOEIwVQAPXPONgJcLDLO2lWxAsV5ojHk=;
        fh=yU0suq9uxVJnW15ds/h86oPn0TGEoRmZIoshvk4GVQ4=;
        b=rvdrrwc0A/86WgHuKh19b3IOB4Mq4fjHTDmCOF7iDzPCYfJMK76jo7kfZHoqjuc8P8
         4vgRgKUT9wVg+o00EUdYjLuZKJsmWDRckUS4HarD1Da7GLpOYOMBRai2di7DQl1c2Sa/
         6lgM0h4iJcf0cduIn0Zwp6kJuOo9epQPHzHHiyV4hizxl/OJHjA1UayLVqhca9XoLHE7
         cfBlOnLc8sYwVonG8qTTGUGS7MOX7b2fGnsFBfP3PbPlQ2ui482jjh14KNGbKO+MjkxH
         96f3cYkRbiNAM9U9wUpQBeS20NWAJjze0Rj7+BITl5WN/Fb1sr6WMpse8O5T2Go7FHeL
         qKVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784678389; x=1785283189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lp6Tjz0agQfwOEIwVQAPXPONgJcLDLO2lWxAsV5ojHk=;
        b=SjTE8jYeDAofZ8aAiBbaKo1crrsIEN+TzFYxzy7vPoUh4Kayr/KIURJ5uadbJTchVm
         B3AdKg/ahKtSCG6OBSgsRUS3TFmJByaRSOxwriQsO1g6AQKy9AW9UIoF0rV6ER+hCJiM
         Z+cMPKcYawsAAb0B2o/WbG7pSUQt2VQ/0CAm0RKkrXQTHwLJ++tYnmwUgzWcY/gSar/W
         IXR4o9egQlkpQdoeWPFIWf2rQsBL9/bH6G0UMIbMCwVNnBBZEBxp4+uHDAs6eEJDXLCG
         5BnccL8hbIzTqqtBPSSFDFn8eqttd5zcwCDAuo7qoV+4I3YZNNtoF/p4n9iqgAkjv81P
         IAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784678389; x=1785283189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lp6Tjz0agQfwOEIwVQAPXPONgJcLDLO2lWxAsV5ojHk=;
        b=rr548abmP4nzeeFhBvvfmaRfR26DOxyAJidIg0Oit7kr72bxajk7S8AtWRXtZjpLRi
         gtMd2uK96JPINHLBRsuQRgaKmeCxTS1B9irrlt+MJ7yrwO7HZy0TWCfdCkxHtzEcstRE
         edr3ymLII/k1K/uiPMdpgBsL64VY/IXR2VpOp2jSL4bWele5VqYaN0KYkn+E1E/bzWqV
         /g5y+72N2V9wdTkoDKoJVR51K2axdEXUVr/LgiyJuQAMEMznF+GIyGg2ILAE/tZHCLzQ
         /KucE20P7XZ4K1povdfHZTrjdQeKE3cKvpgd+PZ/ckI8JT0w2/6GptBB4hLvmTKMC3b/
         VKJg==
X-Gm-Message-State: AOJu0YzxKIZ2eFlpPN+u3ei/4W18xIZxVJC+0Ws/A9heqziwAm6hHrpm
	0/TcAU1TEr46cqsSARk/DMCobMWuTrnu0ppQiZsyzAj36mWA2r5mFJIQNBpMTpfFTDw7NTAsAve
	N9fSjAZKvgyAAP++DEIGmGoOsaJj9UkgBiTwXGdcX
X-Gm-Gg: AR+sD135fqcVSZ+6F6WekTcCcSCIVz4QWlFza0rhxjcJP+fjk+KP09E7KSrs1/QHcgH
	XCeRbGqXLF4ZTzXNg6h+NLZGOrp4SxHiEJIw82sVyFBEUAX1ZGQHxQixVYahKKWRRT4OGol0AJj
	g9bJ4e+FcHDucwe4cx8j9AaEhTalxj/PvVHsxuYUapl7++llAUM3w2KTo1D3J6EnqVlXl15iy/a
	vsFj+4qwOGuEgvyzoilVAYgid179IAd4YEOF3VsOSu0PvaW24ceJUJ2omWa9DICAWNlYwiFePl7
	9iukSE5qx2ycwzty3w==
X-Received: by 2002:a05:622a:653:b0:51c:7a8b:c3ff with SMTP id
 d75a77b69052e-527c47e6238mr4093241cf.24.1784678387909; Tue, 21 Jul 2026
 16:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com> <CAEjxPJ4rpm0v2NPEyw+9+OUcsVgW6Q-ut5D8KXey+_Jbj2AKTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4rpm0v2NPEyw+9+OUcsVgW6Q-ut5D8KXey+_Jbj2AKTw@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 22 Jul 2026 09:59:29 +1000
X-Gm-Features: AUfX_mxh5jAOYuW5z4cdS5i3af5zkSP3A6VhFt4wyO24SEWbsPp-g3z_AxkpjTM
Message-ID: <CA+zpnLcdRZdyRFkUkJNwYwv59zLqYNtT9540tW4XK1MyRiLHwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: support multiple spec_files
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:08=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 20, 2026 at 10:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Update the existing backends to potentially allocate multiple
> > spec_files. This commit simply adds a level of indirection but does not
> > change any current behaviour. It will facilitate the gradual migration
> > of backends to multiple context files.
> >
> > In selabel_fini(), compat_validate() is updated to use the first
> > spec_file only, for legacy validation error reporting. selabel_open() i=
s
> > already performing context validation if requested against individual
> > file paths (see insert_spec).
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---

> > -       rec->spec_file =3D strdup(path);
> > -       if (!rec->spec_file) {
> > +       rec->spec_files =3D calloc(1, sizeof(path));
>
> Here and below, any particular reason you didn't use
> sizeof(*rec->spec_files) instead of sizeof(path)?
> It's not wrong, just not what I usually see.
>

No particular reason. I'll update this in the next patch version.
Thanks for the review Stephen.
