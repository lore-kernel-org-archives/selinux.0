Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A75444C678
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535034; cv=pass; b=c7UVA5GUXgE0eyd9KN2jiQPhqsk/xkz48kJ4snHdHh5es4GLy15+ptsZ1x24D/GPjRHKUh5oRx0+BhEnz74J2nsYCsdOYusyg3iy6DQYYSauE5mtnKN9YOk8U3yFV/NF42gSV4LqpRoNVsvqLisSqOnNkXnQ8wVkJV+4wg9ETDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535034; c=relaxed/simple;
	bh=TYue+ZFCO0l1v32mwL5Qk/n95GiDk4qjPg6AiK/M2fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l247o66sdT6ddBirRTvS0m33wf9UpiM3ZgbrDzw2ScrxZxRI/6KEUjtbvC/wAjHU/P9m8g+oAbMVXaB9UIAOO5E0HIcALkog+DGScmTRFJ2UCtB3Dm9lsHUZ6RfX8mzw9SViCyskYVoTewBhxDwSfTNvvv21bMtXLAeLYHcDVaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX3UA6jk; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX3UA6jk"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-446f87b6de1so1347310fac.3
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788535032; cv=none;
        d=google.com; s=arc-20260327;
        b=otoNg8qRV4E1T6XM3tBp+jcFzMiQ6dFI9THJPUF1qjZ8y19lK8rZGbKbtEebd6FfxC
         xVHfSHUN/Uka+QJkXzuc9rc323bObSMzWGjdVqvIlcbfhLWjF+t7q4SIvUW+YwKOasZ+
         5tZomSV4CLhq1zgSR8K4GJ+KYiybXChfKqlzr6QIn61inLhbphMH8bgCS2DT1BQb9MhX
         y1LDPZQc60iiZkLbicAAdrGUlyXLC5TzmC6miqs7mJGN95I0SQwqKriNa7SGEZ09oFFy
         xyvQRt68pspVc0x1i+DR1sliSW7o+s19n+JQgeJoKZIY+OLN8+3dYEcJGaY+H0gOBHPY
         ROCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L02+waRhKxj4OJQy9mnLuXXEbrZSZk+S3lOAppyY+so=;
        fh=i8tZaMkZTypcEH+UcGyP0vRsVnhTalTQAMJmsiOpATk=;
        b=Rr91tCG+yZLKLMQH1rwaf0N/kxNwN9LWCBLBwRUU+H9dYxhJrVuP84FOnTMzKnZdCA
         2NGB0eM8X6S0S+/2dHv6oRwCZQroAfQgNkUeP9biH2Jr+O6Ep1mGQJTXXaEfMDpXXsGc
         gn/tDBoLf5uozWL7NAJA/zpthUxMVcf6yn5Xyr1yV7ErILSweeQtG9TpbBpSnT89al93
         +sKMkv2By/CZjfoIgL8yh5MRojhAsnAMbEiOyOWY9mH22kf99wYyIcQ6nxEL6X4OhUCD
         Bh2DaYTUBNvfZ7RPue6ruKXeffZcLUQAZSJIOLZ05k3qaT9PCDhwoAL29+eBXB2F0B/B
         O5nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535032; x=1789139832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L02+waRhKxj4OJQy9mnLuXXEbrZSZk+S3lOAppyY+so=;
        b=QX3UA6jkweAlti+Ze3J+lX25mueKmpk4VFmb0GYzmbS0dW6GiYiEOEy8TCrrkSb12B
         1UZFdzhNjeueydFXhcLvVJZ/kNNM4CjfDjnGF3r+y/2U2MjEJPR23zjauXl0ZK8tz9Ux
         Jb1l+TMOjSMPIUeFJEIraaImB7n7Pgp/2Mkpdpkl9Abr8H+kWAQwnmgj1MxwAvR3oLnW
         sKTbWc0SEA/SoyYLzVL6azkWfyCGfZaUcBEryCe9JfL8mOpcfJzeXdicHm1a4G7Vd8rl
         D1poDqOOIITiI/kBkdEHa3JlpujGB++qNURkKb6MQwRBryePYLmWl66eoFgQtcqIA2tN
         +8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535032; x=1789139832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L02+waRhKxj4OJQy9mnLuXXEbrZSZk+S3lOAppyY+so=;
        b=KRpTUd7qK0fZoOk2okhVbn9m/exXERZ1SkmpYs6Mz6D8SAoyYXVabF+/3TmzmczDwL
         0Ex8iG2rQC4cDGyGsVVYS5pLo1+gN56XvA8FFz8RwMd74maaEs8xPa5gL7jIcy3LcAJv
         lEgp8jArUHiaYVXcLBqT7GuNa97AVd1PawWMmBzcRV4EZgH5KdUV28vfiXRST8yE4eNH
         eGieHhogqzv25IJWDTPqgkm3L/g0wMwGGYrjjjIRu2w4boDYRONRXtPueOANVpyqCEN8
         UYdO3IPwLaS6MXdhPMCAO2flaaeQY26+YD4F7sbmJ2N6vyOoqOf7IleXWd9ct1e+BOrx
         LqGg==
X-Gm-Message-State: AFuF++mY8/T1QZnS1V+oHaBuiP+yggtgNthbcKgZviiy3I9iLxmYrgpE
	M6HRj//DppYS6CBX8XcaK9IjBtDscoMByXY80YKiiHdURVvCHFOCkWgexftVhBnMzR50KxXerbG
	KUMGFSX1xGevO12SoyVFUH++X6lEozXyBoA==
X-Gm-Gg: AYBFou1Lfv+IyHyygmcExB1Zu7LXGkU6FyqU1aEGlcTFB+8Q3li/jmDkFu2L9MgJo54
	slfNLRQn1U0A0zAms+hjAejabejw7XlUdFyWBvb93DqLT0IWINR4BFagp7/aRucsk+1P5jW2TfA
	OI4lCreitmcyRVFbO6FDrNyna6rOI0HD4QXNaoRhMlK7wqmkkmbMdPpyaxOyYtKhbL53yCzJ8P3
	ODoNSeRueFTi7sttVGnewB6uVQKcVPJChtaGTIBHUP4vKr88TYmq/mNKZsvEeO7u4Cewv7TpFym
	xdhEd/5UCVJjrhKVyVPvmId81UwKpewv80nKNHD7vrk0p54tZatCe5g=
X-Received: by 2002:a05:6870:d1c8:b0:451:b3ae:e444 with SMTP id
 586e51a60fabf-4754f7c26f5mr6619439fac.1.1788535032103; Fri, 04 Sep 2026
 08:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 11:17:01 -0400
X-Gm-Features: AcwNN1VcmpkFzDetwzoUSRF1svcT9gsbSnUm2nFxFz2OHTMTSCkrAvlbQIzpmUs
Message-ID: <CAEjxPJ7Eeb1TMUP+uXFGV0t3yDd8NT9Fm27TaiTu998yGhVPGA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] libsemanage: add ro-store-root and
 configuration-root search list
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com, cahu@suse.de, bigon@debian.org, russell@coker.com.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This series is the second half of addressing:
> https://github.com/SELinuxProject/selinux/issues/33
>
> The first half can be found at
> https://lore.kernel.org/selinux/20260903142600.19723-2-stephen.smalley.wo=
rk@gmail.com/
>
> This series adds a ro-store-root option to semanage.conf for defining
> a search list of one or more read-only store roots that are then
> searched for all read operations when there is no corresponding file
> under the writable store-root. By default there is no change in
> behavior.
>
> This series adds a configuration-root search list to libsemanage so
> that it searches an ordered list of configuration roots for
> semanage.conf.  This list can be overridden at build time via
> -DSEMANAGE_CONF_DIRS=3D. There is no change in behavior as long as
> semanage.conf is found in its default location under /etc/selinux; the
> fallbacks are only used when it is missing.
>
> v4 drops /run/selinux from the default semanage.conf search path and
> example ro-store-root config since it is not required for the
> stateless use case and it introduces the risk that any domain that can
> write to var_run_t can inject files that will be used by
> libsemanage. Distros are free to re-add it using -DSEMANAGE_CONF_DIRS=3D
> but if you do so, be sure to create and label /run/selinux correctly.

This series has been merged.

>
> Stephen Smalley (9):
>   libsemanage: accept a list of read-only fallback store roots
>   libsemanage: add semanage_module_find_path() and use it for reads
>   libsemanage: list modules across every store root
>   libsemanage: read the active store through the fallback list
>   libsemanage: create the writable store skeleton on first transaction
>   libsemanage: create the store root when taking a lock
>   libsemanage: refuse to remove or enable a module owned by a RO store
>   libsemanage: search /etc and /usr/lib for semanage.conf
>   libsemanage: document semanage.conf search path and ro-store-root
>
>  libsemanage/man/man5/semanage.conf.5 |  34 +-
>  libsemanage/src/conf-parse.y         |  57 +++-
>  libsemanage/src/conf-scan.l          |   1 +
>  libsemanage/src/direct_api.c         | 458 +++++++++++++++++----------
>  libsemanage/src/modules.c            |  63 +++-
>  libsemanage/src/modules.h            |  10 +
>  libsemanage/src/semanage_conf.h      |   2 +
>  libsemanage/src/semanage_store.c     | 185 +++++++++--
>  libsemanage/src/semanage_store.h     |   6 +
>  9 files changed, 609 insertions(+), 207 deletions(-)
>
> --
> 2.55.0
>
