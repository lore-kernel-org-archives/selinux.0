Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A83A6407
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068864; cv=pass; b=e+zEAbfUDO3ckJpOAPU2zhGtC/XJGw9uiKJ3K59R1k0MRmJRlnuUquJJ0PWReA4lMPUqOXNoxBLlf2qD8SP9qO6EFhK3GG5axFwMgRzeWibh9wzsxloVHUXQr/+JUP740x8TtWsW54s8HZ8TuyEl2Mz0jIiP7Jc6SVc6MmgzSio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068864; c=relaxed/simple;
	bh=Dxf06kIXMwRZCdLiqRYzetuznN8IpSv4p3Wemc9kj+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0WcjNFwyfNHv2i2QSs57FyoulNsoo1XJpJIMbj5udjJ9ZUjAVtVYFMc/mfUmANd5wPuo9y+fMmJP5LtsS8pxseH6zotq4xXBKJrUEQuLVRZPFZbuYDEiiC1I5Yv4juGs54gQ0YT8A24f84FvCglwaNqrPg8x4rDH5DsjFGAG9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miW7moDC; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miW7moDC"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso41350eaf.2
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 09:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787068862; cv=none;
        d=google.com; s=arc-20260327;
        b=C1I9HHUxhYWb6Rsk7gIJN115R1qu8GmJEuINRYGRecTkRB4+/Rih8/6gOaiQpnybMS
         7W2F/ciHJn7nwEJ2aebDF07Z0H+upziHj8tmlhl9XQKWsqmiiamSG766DuFVhcUi7pjy
         VGjX+A04rZ83LeW3a/uDg3pgJBA1i450yHPYEP7PTk5wROF+shykJtKNkJ7O9YIbHwW/
         rvkSB8EmdBv+j7rmh9QT/Xl5cE8Wnypa9FSxvNiL3Nkd0ClfU78Ph5ZvvxLGlu4tA1Ts
         gUG6cPYekzpmFUOAZAiSAiHx9edk5lNUPBizAxUTKs6uSEJrtTryF/eESiZScnPnyXs+
         0rYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dxf06kIXMwRZCdLiqRYzetuznN8IpSv4p3Wemc9kj+g=;
        fh=KolfM19aEBLsLdlv7CvfZRTH7eSK0t/BZQIdPfHABmU=;
        b=M5IJJRQfI/b4llQqYeK0JygRP1tGFPXNXJGaUYvS6D7851stXoHsl3wCvezVIifOgS
         VSgTZQk0tQE4h+3lgL0jg5z5Btg7eoi3kTB+trfSlrW7udNk519T629yIkHyU2dpA96f
         BIQIdOptDLBjEBlwKEk9yg68kWwwL7ulqyFD5nuTK5ki4astGHwGacFrVgZBC6p4go9S
         4/x19f7jJNt91KTtw9DsoKC/HU/XuScMcrnxTODO+t3zZO41Ym5P0h4AgnA8jiyLEzXk
         4XXlNmYBBycXFlYNJ8B1H8MZNBPsYFlqaRg6eTuu98GlUAJ641maQ2RWIfVMbwlaJ10X
         dQWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787068862; x=1787673662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dxf06kIXMwRZCdLiqRYzetuznN8IpSv4p3Wemc9kj+g=;
        b=miW7moDCu3TFz4xskHIJ4CRnEBE0JJklnCMmU3S5oPuASrwfTkF4HrR+XKK8AHGqah
         rHLca+0qun3mGNzHOy15df8kQI0Dc99fZWXtK6b1i6nEaHQYl/K2v7g/EvzDANrrfdK3
         alHPaeWzNhT9KeAlWZnXYe8o2VyU2qN/MbNuOAku7SKrOtyoUFOBSKBL02LoNyumazpf
         lowunnjBuIqofbmpp7zcAEhe4Fipbkp3AWj/yCM80maizx9nve6J7OMCzSU6sJT6/AJd
         2a+jeD/32CejhkNp4/0NgQ9Gnqp0UeAKSiv5Q59B8v5nCGp/2vyWRdhlqxFfup+dyufg
         NqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068862; x=1787673662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dxf06kIXMwRZCdLiqRYzetuznN8IpSv4p3Wemc9kj+g=;
        b=Lwf3rtMu8TOyfAHxym61OenVrq2lghY65BKWiwy4aUTgoel94YKNoVNRzdbX4S+t8P
         3tSbqvT8FsJ4wILVKGNZaUJS2E7SsT8gxE7OTsQlFXTvxEFYfhGCPpvw3HhKVPPyIH0d
         lhxdnT8yaIAB5md2kbjGXcFM0pFFIXBgYvgGo2ITC++QaX+qkxkcly4JsmGwoGxKDLF+
         +OFAEaYBjYIiandPFqjT1X5ng9WX6pgC8+XQHzhKhHawcbCSH/+E9GMtMJNNcxXVtHWa
         H7lGb1c0wApczXriSOTTzG11ZXZh21sLCqA7iBR3WHmDd2E///odOveSr2/C0P5fSXbF
         53+w==
X-Gm-Message-State: AOJu0Yy8IK+qkCBgwocvvIjhdTBKsjx8g8peB+yi8OvM/2Ulk5AtzKTs
	f0gNJGyT5JK+2kD6RwS0bsLofL8MVxcmBUkrBRNtzL6WvNrveR0k+SSknpsPi/HmpR36pa42BuO
	uH6iGB2ozceiWMZZUzcqPe4E21IrSxdkzBQ==
X-Gm-Gg: AR+sD11uPVaHYPqihOO+QbEpYCYvc6BIkvSQSrcbqX3WePvb4V4whO3FvI1KYXMwPgv
	HdH7K+g1zsyXreS22coU4j7sRbRYhDtE5zB7wUKcbyGMxxGxXb/LeJ829zXtN3gfgy9Un0m9Ke0
	sdF9jHiNWe5fzIP/lgO9kLP68GPvOTtss/l0UWgstbjfUzoYF5whYPdtbAnNeZpDfNIYLDrxqPr
	Af6vOwNyVxZWP5Zzcc/pb/LeVxkjjlrFfPGYGFRkWx7gxgZvORGfIsFG1qXKyK/+xUMG972vjxH
	kYCkC8JEN/rgwqLrTpt9VSzUjJDlx8II7h8MOUtZnOOO
X-Received: by 2002:a05:6820:4c81:b0:6ae:46cd:e901 with SMTP id
 006d021491bc7-6b0d6259683mr29095283eaf.17.1787068861789; Tue, 18 Aug 2026
 09:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG94myvwFz_f2K8SLsfFv1xKDkdm_t6z0s75BLcE5Dn7OV2LBw@mail.gmail.com>
In-Reply-To: <CAG94myvwFz_f2K8SLsfFv1xKDkdm_t6z0s75BLcE5Dn7OV2LBw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 18 Aug 2026 12:00:50 -0400
X-Gm-Features: AcwNN1WBmc7ljGRxQbxgzgipMQA6oPavtMOpghHTj_IzmfK-i94beKVBDKV0EE0
Message-ID: <CAEjxPJ4DjSrYfDG5V2U8SYk+t_hQXLuytuwP04X-jLd0DMd4og@mail.gmail.com>
Subject: Re: [RFC/Discussion] eBPF-based runtime permission auditing tool for
 SELinux policies
To: rushikesh ghatpande <rushikesh.ghatpande@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:18=E2=80=AFPM rushikesh ghatpande
<rushikesh.ghatpande@gmail.com> wrote:
>
> Hi all,
>
> I've been working on a small tool that uses eBPF to observe SELinux
> AVC decisions at runtime and flag unused permissions within existing
> allow rules. The idea is to help identify over-permissive policy that
> audit2allow-style workflows tend to leave behind, since they only ever
> add permissions and rarely surface which granted permissions are
> actually exercised.
>
> Repo:
> https://github.com/rushigerrard8/selinux-policy-auditor
>
> Briefly, how it works:
>
> - Hooks into the LSM layer via eBPF (BCC) to observe AVC checks for a
> given context, without modifying the running policy (no auditallow
> needed)
> - Aggregates observed permission usage over a monitoring window
> against the policy's existing allow rules
> - Reports the unused subset per rule, e.g. an app granted { read write
> append create unlink open } on a file class where only { read open }
> were ever exercised
>
> I built this mainly to solve a problem I kept hitting in my own work
> on distributed systems/networking (permission creep in service
> policies over time), and it's been useful enough that I wanted to
> bring it to this list for feedback, rather than just leave it as a
> personal tool.
>
> A few things I'd appreciate input on:
>
> 1. Whether this overlaps with existing tooling I'm not aware of (I
> know setroubleshoot/audit2why cover related but not identical ground)
> 2. Whether there's interest in something like this living closer to
> the userspace toolchain, or if it's better as a standalone project
> 3. Any gaps in my approach. I'm relying on kernel-level PID filtering
> to keep overhead low, but I haven't stress-tested it against
> high-throughput services yet

Thanks for sharing this. I'm not aware of existing tooling that
overlaps with this.
We have in the past discussed doing this kind of thing via auditallow
rules and Android has used those at times for a very selective form of
this, but that approach doesn't scale well.
If others find it to be useful and it is well-maintained, we could
consider adding it to the SELinuxProject GitHub in the future, either
as its own repo or as an addition to the selinux userspace tree.
Whether or not the latter would be best likely depends on how tightly
coupled it is to other components in the selinux userspace.
