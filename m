Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149F3264D9
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144240; cv=pass; b=rDYIMPgj3T6gUqt3cSEK2bE4fFqpqGTgmiM5ZPZCzXf5DVIfAJh8DJoDlx8XdzpAdxKMvVt2O9rDJkqGdCd3k/auKiVyt/wqYx0xcQbIUT3X7dFRD5HLEBYlDnI5iGV3bPS1iJDgWk9TV+FtSUjq/kZ5y9F5WlvqitT4z161Zf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144240; c=relaxed/simple;
	bh=8+M2wY1byH1XcpJravZsAnVeGuKyjf0QyvZrrneh4Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1QBKNCjxDm7vAb6GFstgnIKj4+1oE2fIur8VdYFZ7j6Olzn8JxJqEcRKgQJpa99TH1uAU1K+u7SJYDOe8z0Z4otx0cA5Cl6IpEC0uI/bmlIROMaOKvb+c4gAaX9eAAsz7mfl2okYciBVBJDjQ9gr3ptxPJRp0We5fG5OxJmTDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh/V6NZ0; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh/V6NZ0"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44cb057311bso759041fac.0
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 05:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144238; cv=none;
        d=google.com; s=arc-20260327;
        b=W6RgXoUm8X1HIPuaUQ5Im76EDkRISJrsaG6i/6fngxLvyZv9jLwAhqK7c5wYWUYZix
         cspH7Z69Etw3V6tljSkqIXcZ5oABq1uC/0tIl2wJhF623lM44cxlvBXVp4/+51qdywsR
         x+KtHV7NiC1+lIfwg/tlY6OXbCJwYEc1Oyf/PawObG7SSGfT8pBWbH2Bof6umfOLIZvj
         eDUJpL3s3QfaPbfMJIr1e7bLo8jOZi9+F2jnLE0JVsLUolVT/EiNNCLW/4b0i1kvUgW4
         LkXf80Btto4GqYi3rGnZHh5jJO2iesd3hPS/YJ6OPUPdttBFlykGkhjRyZ3fK7TtN6dc
         nUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9PI4F3pzdKmjB2fMwjBPld/Zr/KdqrDWvKQLOpawxWk=;
        fh=Vdc608U6fmQnkK4Pj/GsEOPoO5XtlZs1Z9K2hPCnM4c=;
        b=fYg0bFa6CQKO2IlelVnV0xeUtmXBVg8jVRF+s8LtpVWyXI7u4PlYmrfyK8CMMChp5X
         Uh62FE8/htIIRhQE0XvpYuf0olKqmHlU7OFCspU1xRWY4/UXVXEQI2OXNRngOvQ0EsDw
         aC8Wf26uFo7nb3BuUX1ZV9lNhVfxfyLjJV4lsVXIp56aXfc6LtuZdOFIF36smou82NOa
         vcSxc7fH5H62VuV8lEbMYeipgbwv8SNox12jFZDElFvOQuzoVCz8gz6wFtI1UYgGwQi3
         4b8TaJnD+A6t2rQT0uVpMr5OXzI2Adq3XrrXqQ9T14ok2KXK7uFAZznK4ko+t7QR2HPu
         H7CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787144238; x=1787749038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9PI4F3pzdKmjB2fMwjBPld/Zr/KdqrDWvKQLOpawxWk=;
        b=Eh/V6NZ0a3SX4uR5gZRQxuXwf+Q4vHqeNs2VRt+OfuLYfzl1A55KCffvAfMhln5acf
         5XhivLKFQ5g2xSHoZOORIEmM0Zv3WhvCCQTuePZpZjLyPvdNA2A7uKiZL+fW67Zdwpt+
         g8R58bHYMWRtrWdCCwKG/QhXfcUvAmhEQjw8DQRKWvozUFx2UbdEtNTKvJ5WkgWh96hB
         BsFLyAD2Ev/yfcBcSGHUj4fBtexX8cQ1k+YDovc4KCreGqhtvcvVCjxqY3bvT5svvPMd
         HexRU5PGx+afmZVs963Nh/kflJnZPwBMrLTvmqfe4g7zYZeHodJMBkQ3d0GfABkPOx6F
         zxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144238; x=1787749038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PI4F3pzdKmjB2fMwjBPld/Zr/KdqrDWvKQLOpawxWk=;
        b=aT+NgNKcuZJF7A2tgQPJe6AqtN3oQAQ5WvRC/ICw9RMif9ySEuVuPoe3vv9NY3Vi3f
         SHugfDwbS2SXX1QtLCQO5VlxR3mW+hrHT1rdEV4HKnpN3WATQrvAcPP47cUVZeFC7V3+
         v8EU7oHIs0TJGzqth+5LUGAeJ/bZXPko4+CE1B8OoZldE5M1VicrpCTKyJStvhGPl0aM
         zb2Cmb6xlEkdA+7XFzP/WxffXM6dkH2jeq6gpqwtcxWtUS4OiTBbWD3h6vcmUCMm3iQY
         5oDZ7eJcOai/OnHWGoX3RcdFjnUFvN06YEDo+SSHCEQzq14Wz+mQMgWwInWnR2Gti3Jv
         oycQ==
X-Gm-Message-State: AOJu0Yw/VED+Vyzrhn6TY6z95pnhRn2dkCLMf2U1gmUjqJ2Ko/dyK+yc
	anR4zyJwFvN5Cm0+DfTzHpbZpWTYqvvhpozXoqmxcpeafbwByON+ZNdjilV75KUjjtLvwvjkDK4
	U3RTVhzFPH6e3IAtY0nCBCYzZ4I1QLK4=
X-Gm-Gg: AR+sD133QS3kCiSv/6ipvb1hLkGuYsXCMpJZYixsr10+WXfIkiN2sSMGaaMTxudCaVv
	RwB690a9sVf/7T1Nwpg10k14UJNJmlK3zCgkTUvnyj/D0KbDJtWcDvL96GgHKmWylgWXMtZpGfI
	17RM6mPgl+3b25uy7r0VOyk3qvS6epKv+vDsvkbkdyapGiQRznw8AjUOgx9ydMBV5Swl08I8Y0u
	kjbKrcRghsXOe9PMLnuGZEYrIA8mFv0yRVd6s7LaSLSCeW2DXmwT27xkh4xlmyuNIUl1M3k14Yk
	dJ46bh6cWbD3ZrfJoqOY0NmePoAFILN2b3BJdhap4VPP
X-Received: by 2002:a05:6870:1408:b0:456:5461:11d9 with SMTP id
 586e51a60fabf-462f6cc1824mr4186480fac.12.1787144238159; Wed, 19 Aug 2026
 05:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818192340.119297-1-boeroboy@gmail.com>
In-Reply-To: <20260818192340.119297-1-boeroboy@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 08:57:06 -0400
X-Gm-Features: AcwNN1Vel73b6DTSSgs1ucbA9s2e2PJjDLPI-rMffoQWlkd4b7UJQvLUDDE6cTg
Message-ID: <CAEjxPJ6oHm8sYTUeCbht3W2VnTbCRYHjq7+j5oL_cOj4UQHndA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] setfiles: control relabeling parallelism from the environment
To: jboero <boeroboy@gmail.com>
Cc: selinux@vger.kernel.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:23=E2=80=AFPM jboero <boeroboy@gmail.com> wrote:
>
> From: Johnny Boero <boeroboy@gmail.com>
>
> Hi,
>
> This is the patch for the RFE at
> https://github.com/SELinuxProject/selinux/issues/489, where a package
> upgrade on an 88 core machine spent hours in restorecon with 87 cores
> idle.  Stephen Smalley and Christian G=C3=B6ttsche both indicated on the
> issue that switching the default thread count to 0 would be acceptable;
> patch 2 does that, and patch 3 adds the environment variable the RFE
> originally asked for.
>
> Patches 2 and 3 are independent and either can be taken without the
> other.
>
> Patch 1 is a small fix noticed while touching the same code: "-T -1" is
> currently accepted by strtoull(3) and wraps around to SIZE_MAX threads
> instead of producing a usage error.
>
> Patch 2 changes the setfiles(8)/restorecon(8) default from 1 thread to 0,
> i.e. one thread per available CPU core.  Only the tools change; the
> selinux_restorecon_parallel(3) default is untouched, so library callers
> are unaffected.
>
> Patch 3 adds RESTORECON_THREADS, with the same meaning as -T, which takes
> precedence.  The motivation is reach: relabeling is driven from package
> scriptlets and init scripts that a user cannot edit.  On the Fedora 44
> system used for testing, 10 installed packages run restorecon from their
> scriptlets and none of them pass -T, so the environment is the only way
> to influence them without patching every spec file in the distribution.
> An invalid value warns and is ignored rather than being fatal, since the
> variable is inherited by every child process.
>
> Measured with a dry run relabel of /usr/share (~588k files) on an 88 core
> system:
>
>   -T 1 / RESTORECON_THREADS=3D1   ~24s, 99% CPU
>   default after this series     ~16s, ~1000% CPU
>
> The speedup here is bounded by the directory walk and the syscall mix of
> a dry run; a real relabel that writes contexts benefits more.
>
> Two things I would like feedback on:
>
> - Whether RESTORECON_THREADS is the right name, given the same binary is
>   also setfiles(8).

I think that is as good a name as any.

> - Whether an invalid value should warn and continue, as it does here, or
>   be fatal.

I think continuing is safer as you noted since this could be inherited
across multiple fork/exec's and
isn't part of the environment that is sanitized by libc. That said,
I'm not sure patch 3 is even
necessary once we take the first two.

>
> Note that this series does not reach libsemanage, which calls
> selinux_restorecon(3) single threaded on the policy store, or rpm's
> selinux plugin, which labels each file inline with lsetfilecon(3) and
> never goes through restorecon at all.  Both looked out of scope here.
>
> Johnny Boero (3):
>   policycoreutils/setfiles: reject invalid -T arguments
>   policycoreutils/setfiles: use all CPU cores by default
>   policycoreutils/setfiles: honor RESTORECON_THREADS
>
>  policycoreutils/setfiles/restorecon.8 | 19 +++++++++--
>  policycoreutils/setfiles/setfiles.8   | 20 +++++++++--
>  policycoreutils/setfiles/setfiles.c   | 48 ++++++++++++++++++++++++---
>  3 files changed, 79 insertions(+), 8 deletions(-)
>
> --
> 2.55.0
>
