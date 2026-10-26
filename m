Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022235;
	b=XH8WsSF/DnZjmElFYbKOoUWPgLbBpdbwArtHWItGUDASLgoeGqMaGP5TsNAnPGyR7QMU
	 vGMtCRXt8fq2F0QjA+W4HHh1ol8D/SJ2w0YmM3GRiYgwzoCMg7po7nsYVr8FvjUUQqtpv
	 xAtLiZggyt34xoMn2Wu82x5blRFAlZgqugOWsuvI0TYBgIP9PVeUi5PjmvCf/0qxevEsd
	 KOwLgm/TqwQxvJ+qd9KfUYcxJaQ9UJCfrmsSLQeb2zkbMGmgEoGIJUxyetB+4zw5Gychr
	 FLp7WvMic9nypbJotTpEMTJl3PACKc9XzGrT+j4gAmwrUejRbrP2RPwzEDxvi5lj3zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=vD97fA3YPS+hZ1Kx/iHUchBabseiTBJ9Q4Nj32VU5RQ=;
	b=nOgDOW91tlfBbPfE7seJgY0RDq4cWeIw3DImBYF03A2ojdQ9f4aNhvkrBuY8tX8Ljt2e
	 s7TRD7Py5Tq9Dn0ZZm0Yi4Yg2+jkv/Jx8LKLeQlRot766yaCP5ECpGS3YfR7fbkd+pZP9
	 RUdcH7qUI9+QzZT8t9VDMO+AoiXv4PANGLxv+A6/IiyJ3HE3qB3v/dFe9ZHexWSshEDPV
	 t3zShz59/pEtAQ09QKV8KoXybtyNgw157Cxbaf+PXBztawsNbunzCtveGXT2+btxmdUdj
	 l/rULGXPXT0OS7Bo+BGNQid1dXP7At7H45hQYKmFwihu+GMWy1Y9Dyw13qs/FPpb4gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Viho9E3V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139A606A31A
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C139A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Viho9E3V
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0f59a5fdeso23260307b3.1
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022234; cv=none;
        d=google.com; s=arc-20260327;
        b=HYosgIYgu7jKXa2eAzbqBoVgPXeNBwe6dvmZw0oEGEuGUDfm45PpTg6p7hCSlEo1u9
         bY2rq2ESRNSq3Cgnnq4rbydtFbGCH2wF3r6dUxV4nvS6DKBok0Up2BGx6s44Awme2LgD
         UJtdDqY6pizUvNC3gv2UoT4DlTTZZ1nE9jdP7F136qQEJLYITfxcWAb44yuLU2q3E5I9
         h0Vw5xWvbKs7/avb56btByrT+NZNmL+7AHw3g7IsCaDp6brxYnWwsQ6uCZJhPa0Dllyt
         Uk028NeoBTpUHYWsUIpDnWxr/JUG4uyqHohjAb2cm5pCak2tOojGrECUwMY12FUku6wl
         GCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vD97fA3YPS+hZ1Kx/iHUchBabseiTBJ9Q4Nj32VU5RQ=;
        fh=oY3YJwlQJe6qc1tfsT1YP2sL1SDhL9BUcCb87gGht54=;
        b=QIouSEe5k76F7dbopVhX1cK5fJK6Vnpv69jVq8l1MFjAWQ5WIpCqZWmFJDbS2xu23h
         9IiNwywZQRLYzng+pi8ldWO4o5Etn9kHe4EibCqm/W5sognNnZVRO1usqMIgOJuIfPWv
         oJ/uKcHWWy5J8Th9qo2qyUfAJgKh+EpHQsMwEAh4BrIJmCrAx+ZEIMeEFY1UylRZ3HIA
         mJHdUou/FjXq5jEMqMJsdqOmSLEFuOJDOll5tNU1+M0nWNGvtvITZI8s+RcMwUHISYMM
         W0vrr7K//FoOmzmOISdIley2ajitKi/JRC2IwuCMGr5i1O3OxPgkRBfvUPH5WutDv0NM
         SNVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022234; x=1793627034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vD97fA3YPS+hZ1Kx/iHUchBabseiTBJ9Q4Nj32VU5RQ=;
        b=Viho9E3VOcVQa+67MyDqcZ2od8+qQ8+qtuSK5QgmOOw1nzFr60KW6ugZlByoP7R200
         P+9AOd+CUpqCrbJbEn+8Vk9ctFt905aujKwv8K67memcLVGpiQJz3qYQwwCdYAOSPDRK
         U748VWHWnHqVIFgfFRayCxAKLJQ1F3sgU02ZkAe4kHY8Jd+inchsvSUk+/kgnJQpiN71
         x2KJPqbdI+e1soatOd2Dt1nAQurDPpEznZQykhDGDqwkPh33ULmnWtlrc4tTlqGB0LvC
         NqS8zHHiSH8MzLxKem35TZuRAh1ngxNYhyofWrZaYE36hpcLqrm9WAJejF6cfWh2v2CD
         Q92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022234; x=1793627034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vD97fA3YPS+hZ1Kx/iHUchBabseiTBJ9Q4Nj32VU5RQ=;
        b=nN9bzA1hLbcqif/nw6Nec6hr9lH7TP25dsHVpWZcR0yHO/vBPDZjxzRCkv0nTuNYRD
         v5c6XlYFKB9QDvPU10a+RPE4GmXBsj6/QSCIRJvuQ9sxAxRxgoLKMD24CYDrVLxQXxjO
         BKe9/L/mW+hoS5xXFP34StWdVX4Lk+Dz4FZc3iPpmoZDH36KQTTz4pEHx4AFnGg044MC
         VX3xFtmpc6ntfMogGyW/df/Vdo9GqVfIKkTZgjgpY3dmHsphZmaSL8N4n6MIqj9q4uyP
         T0DmjK8n1X4RrOWna+aOIx3OpCotDxMvLNyrW4F23Zh4oN9yFvDayFsuBa7y6AXGOfnB
         589A==
X-Gm-Message-State: AFq9FYKOUA8UUm2T89MinXjyA3euoidcThHWp9A3y1wp74PgtgYVyX0i
	F61wI7UiepdNG7spqO+6sR4m4xq8VCjK+teM12DXyDuJwN1lj12JoJRbF1MmhEVHs9rGOx7Uw5+
	QxjH101Vak6C25NxGOj0JOhz2MtON2P1InXOwSSs=
X-Gm-Gg: AYBFou01ozEk/NOncm3PuFnnRM+VaUdvANKGWuHjmjI/BI6m7XATM92+CYJhW9IW3mS
	XXtw7HlEVd/VN1Nh+EEO9/uwoEeKYzq0tOs57gJ3bODpe/4W/2TeujAEnFgQs1IFjWsmuVtuqL1
	VvKHvmphHqbJp1SuAxkcCegcm1Dv+r8HtbAFUiOGdfhtECNPk5dwM9D+3Khy0vDfjBsjkhIETwS
	81Ctmp+6F/Y7F5njtU/W6i5QDGexmhwPlosdA7mhZaQ5PcKyVO5HWv+aW3WzWcLC3ZQXyaj8ub4
	b8aeP7f4MdgwllMGyEMWCxxOaKe425GeV0ltQe8dsrkn8GgGQWh0dUGQQBTjTK2HuVoITOrpPnC
	5FkN87K+8NoGR8Yb+K0XSmJuSf1nijrbOZ0JIsrXbcPNU+P4TyvZHqujcZ/JbxovFH/f5ojbTfO
	WYhP0ttlvtCLLyCvMa1ORP+g==
X-Received: by 2002:a05:690e:4851:b0:679:9b73:bf9e with SMTP id
 956f58d0204a3-67a453f9553mr4072686d50.57.1793022233898; Mon, 26 Oct 2026
 06:43:53 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023185832.62289-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261023185832.62289-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:43:42 -0400
X-Gm-Features: AclHuK9LvltRtx26uLA0li4QtcPloC6mubkus9uqV0ioHkbqiVdCfngh0GU990Q
Message-ID: <CAEjxPJ5HtbKgqJpJFnuasjuCgkU=Ht8+JAyWO7drQ3tNg56d7Q@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: report commit flag-file errors after user updates
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cathy.hu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:58=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> A successful flush of a modified user join sets retval to zero early
> in direct_commit(). The subsequent dontaudit and tunables flag-file
> create, close, and remove error paths jump to cleanup without
> resetting retval. Commit can therefore report success and discard the
> temporary transaction even though the requested changes were never
> installed.
>
> Set retval to -1 on each flag-file failure exit. This also lets the
> existing cleanup path set commit_err and preserve failed transaction
> state consistently with other commit errors.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
