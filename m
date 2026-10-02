Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7E4C2261
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950565; cv=pass; b=WyPovpf9E2wb9c7uQ+eXNwaPHdAV2zjyx9fj0RNau5gCoTu/ud670pFQ+/yEKfOxNXJRdCEyPu4QQhzW7jgT/p+dStxubt56QKvSAxDcaJ4OV/lULB0NHMel8jR+uk9hRxc2XErgVp7Nl/5gU27m8zSKvt8CFFordu78HsAMr7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950565; c=relaxed/simple;
	bh=95nq9O/rnmImQZCEHr22EZYsWPSiMq+KLc6P6IqGBvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXxVWtIrB87McMC064oQWFzA2AIsksDqQzj3zT0c3H4sxZ+mWwe8epcjSEYaA9JQ4wbT0D8FecVu/088Ze0yyiSiyXZcFtyJPL2EYHeRdLPXeOacSvFcAxjXskjs9vSppJhjoAcjPVYzJ7jqc1LWDXvlMKZKjlYivLn++dpiTjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmuZajuD; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmuZajuD"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-66e4aa8d881so8204509d50.1
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 07:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790950561; cv=none;
        d=google.com; s=arc-20260327;
        b=QlQWVR6MFV7k/n1Tsru6Sqa6+bKXZbsyNcGoJYF32eGDLK6kzqp/Ap8/mpRKEDMFxP
         285pyyDFB6QGt+oktWvY6H8vfmJC7vuQT/YeWVTbxUsBJY/nY6IccNngHElbqL9Aq01M
         hz7Q+akaiQDY3Nbs1tT0JdZzVVlU/8ai1wB02MpwEGkUmNQiovNSpN1ejgngnfI+NyUG
         kPLch/NNeMX7nWRVysulMY4Zf6fY1ZNoymgnHk5LLH6ZHqImID84c2Sitmya+02oqn5e
         C1355V3DC6bwzX5b6ryyVKD8BN55G+nG38FKKsp90TIBvPCOLhnKZKxxaQaLCsELZGyE
         ZjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=95nq9O/rnmImQZCEHr22EZYsWPSiMq+KLc6P6IqGBvw=;
        fh=E95boLTiTkq8XsjKw8GK1wyz25DmW0RgNCvDUxEAbME=;
        b=QIepE32mSqgT/b/DFfrZIKcisxpma5MHUnkxN4zQNdDfOOIUaFehWBI5NqrwumRZ9L
         Mipz0HZABW/dpwqqI8URl+r/zEYMGl2ojumYx8Ur3HOxRCsedBKqyRopfc2qrvGY8m+W
         4coeiSIomljobedY/QpwGPmkMcx5Kpr6m5miVvnagFj/lk1zQAflIoq2IwVcggAZT3sV
         ypR5zR8cImLYxC8UP1fNGk2yFqmV45Utup9lwnd8Mvdxk+53v93sov46/uQAP8UzR6rJ
         gi/ifeU/lm6gFTcN+bVfPPjbeMYbvH3m8OCnmIYN+VVQGK5JXSuxAxcMD+KwEHpe2775
         sCBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950561; x=1791555361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=95nq9O/rnmImQZCEHr22EZYsWPSiMq+KLc6P6IqGBvw=;
        b=qmuZajuDrLsN4BnFSvl4IF3Q3tzmPADespUo1ORmxFRtrlCYMPu0JCj7Q7QwNOMBMe
         gy+uq0GZTlFkEp/UVfZ+fcLiPz33ovge15BRIqfORGRFUqXhuawIhxBJAoEB/HKq/jr0
         dXaOnBAcsuWbHUNgFULOsEX8GU19FTZd8TbuALk72N4XKENOvyju6HZ5hrCtih95Xo5M
         GnzIB7kYYV/pVf/pr1os+MAptTXw9oGs3FxQgBn9ql9iLeQhXWZlSVavuJPDb8GLC6R/
         dTB25jARsklszaRiOjBXUhIc0Nyq7gReX0CjOYbgcOV+WYtqLqQTDqh9JgaeMs4gVo8h
         xXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950561; x=1791555361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=95nq9O/rnmImQZCEHr22EZYsWPSiMq+KLc6P6IqGBvw=;
        b=Ou8BOhUHcrIm+JFyu61YoZ4ST3QBgUMtnWRieC2xGVqU8f2e8CVGdIqwxqjGINCFvJ
         mSDayZqTRYfOH94TmqMbelN/l618z5zfVd9+mkFFs0PJ5mhnbFH34CDfxmAg9sjV8seD
         NmO2GnM6ik6uyDcTK/7O7BfjGFF2AmLRKyqRQsO/VwY2L0nVCOeTSi1jNpxJkSOWhJca
         nMcT+3JyeWUI40mn/iiu08uI+46GPa9JkEtyiW7Qu/LOo+JYk6s6p+/yuktL5FbXbN4h
         7okitfkt1s8IFVVD6dnpA5UR7y6hfAWKXo5RXOjj7tTuOUzog4TRoKve3nksJNh6QXvS
         fZWQ==
X-Gm-Message-State: AFq9FYKVEMZ1BZVhHjLVIInEcJ1If2PlnxxLado6QZyPcRR6PSvvcOta
	Yc/IRDoPpsHaubti5BZ0e/DbJXh/xZ3RpIvgOwx06LCyJSIWElS7C3weowop1YbShGRLDFhXzrJ
	wa/04rSC1XPYkdVydHahjVul1VQLYigDZMw==
X-Gm-Gg: AYBFou3FOUbk7a2XmwK0o6d8SXW/YpUgWe/5MqT31O8DixIOkqteqz6HL4q/Xv79mDL
	or2wW9rQyiBzJcvy2RRMwJQJG53UhJtMYDsy+jHHakGB4GPnSs21HRj3zBkJmBbg7b3piDv5Vl4
	NEoabh5aGxshh5QzKGiVjVLYO85+8osMsyB3UP1pVKtVtfqOLQ18jSZ5Cy0oXCB0oaSMDYnGIA+
	wzcUT1Rf/zrsRuzjFUL1xSUbi3wIKqoJj2nz02gZwtyoWjmgtjYAzLMyNeOGfXPe6CwjEE3Rnri
	cFs8hTGj+RubyMLqoboA+LiFqnoWbIlnKy63c8XEIbyXNL6N1OiKBV8=
X-Received: by 2002:a05:690e:4852:10b0:675:5e40:3eed with SMTP id
 956f58d0204a3-677abf9f112mr940221d50.23.1790950560747; Fri, 02 Oct 2026
 07:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001153212.102261-1-bgrech@redhat.com> <20261001153212.102261-3-bgrech@redhat.com>
In-Reply-To: <20261001153212.102261-3-bgrech@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 10:15:50 -0400
X-Gm-Features: AclHuK8a8pt0YmBmswbXUQ6toONueABwDNWfBh1lYfBfKL9TbA7XPnIliTDB7eA
Message-ID: <CAEjxPJ4mjdBgTupSCGqrpwe=6=OURSSvewC+iAhPAQF0c19Fuw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/filesystem: probe ext4 quota support before
 enabling it
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:05=E2=80=AFPM Brian Grech <bgrech@redhat.com> wro=
te:
>
> Add ext4_native_quota_supported() and legacy_quota_supported() to
> Filesystem.pm: instead of inferring quota support from kernel version,
> actually create a small loopback ext4 filesystem and try to mount it
> (with the native quota feature, and separately via the legacy
> quotacheck(8)/quotaon(8) mechanism) to see if the kernel can really
> handle it. Use native quota only when supported; fall back to the
> legacy path only when that works either; and skip quota testing
> entirely (without breaking basic ext4 mount/unmount tests) when neither
> mechanism is usable.
>
> The probe uses an isolated tempdir under /tmp rather than the ext4
> test's own $basedir: per-filesystem test directories (tests/filesystem/
> ext4, .../jfs, etc.) are symlinks back to tests/filesystem itself, so
> writing probe files into $basedir would share state with every other
> filesystem test, and incomplete cleanup (a stuck loop device or mount)
> could corrupt whichever filesystem test runs next in SUBDIRS order.
>
> Assisted-by: Claude Code:claude-sonnet-5
> Signed-off-by: Brian Grech <bgrech@redhat.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
