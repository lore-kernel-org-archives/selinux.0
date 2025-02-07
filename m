Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76C175D5D
	for <selinux@vger.kernel.org>; Fri,  7 Feb 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951663; cv=none; b=W5VTJPaWzlHQ5s2pXPzWOZzCNI+d1AIfIkadx8rOcBaSV8AGDs4mvD7rRww3fKAbQgwGJlO0BpGtvobJg49Q629zaNuddWKPcNgGt48Ogt8hPPm6YzPzuomiNDXcGF3XNJT2l1Or9UvdLRij32UggNa3DbtyBBy1tiU/N9DUXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951663; c=relaxed/simple;
	bh=f0HSQziLQ9mxAalYb1/C8shgRhWQcLY3lNUzUiw9e0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gx++yVnfFX/gANtzWTIQXaJNQ/7nVD76Kn9Cy7XEh7kLAIYvYLVAKoIDTxHOMyWuXWK2ffCD+FghPdmqu5oz4RxvphXOagluV4faWud3PZGhYxCH11sVw44SYaAbVVUjilSdqcQ8Kzoj1iTy4R6EBtyreg4/+ZoxtEEwJbk08qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB8N+QCF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB8N+QCF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so3408543a91.2
        for <selinux@vger.kernel.org>; Fri, 07 Feb 2025 10:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738951661; x=1739556461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RcpMQ5YwUzbDvaVUO24oOJ/0As6XZY1+iCAF4v5fmk=;
        b=lB8N+QCFHPR4BsrUTs6xxrFzXw+ZfdTZ3vIyHBOItqrB4elUS9h1LyTBiPEVxKXYzw
         P9b1qo6cIhSiEGVa99OlhKOPaHvxi6t9NNYI7ZA0kY47OR7hgAeAO447GJm1WTC8z2Bp
         4TveciGkS0xqa2sZkA7LHqmayIBs53mcOoQvMUhbNmijZOXUk1IwrLBwUuAAckysaF9s
         1Wyczn8VKybPhQ64znram+J5OjnOoE5RPUzG5cS/9QCEdDgIAwrWVCSEXLjVqcaHv0Aw
         oo1x0IcRqsa4rk3arjCV3LUgmNGmsXA0uNTbvPXBdtpKX7B5kpxSCaMRlYDPvmBRUFLN
         wO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951661; x=1739556461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RcpMQ5YwUzbDvaVUO24oOJ/0As6XZY1+iCAF4v5fmk=;
        b=XxTE+TW+PuBJX0rtupFGFox7pR6QZadQ2dvo2Z572U6ku93DkiyBKKqgxgPslK8YFV
         SJ/0pnRfXrLR6z9kds/n6QdroJotSGeENqy2tgvs6BHygRikkiV7RWArqrP2wpR4jlKG
         s5AZUCqcwVZe7GnBM7vxKq0t0yTPIgxbTqGKiq/GGy3MxYsGzI39oYRA0sTQJOQGgbZW
         rRWHOVbLnqbnX3DtpIy2lX0UBO9iwadXIjiUgq2TrdTDdaVHUpWDgc/ScRaQQjymydS9
         gtmDeF2h1HtQUOEqGcePisKQGpjBU2v8CcFIJn5RgG0BWIpjagnauGyeaa/u5yNwlwDZ
         j2ig==
X-Gm-Message-State: AOJu0Ywijr5umoHlenPauU+HoETw7EIiuDvg9UgwMRakcUde82LwmCm0
	ToUDiZ+rBSRIkI/loJSXN213yt0QQsdUyIjL0Sr7UAgS/yOCVj2JGD2pU4GxSPK+0mVW1Uh0BzY
	a+f0S/OpOloDEZXwbRr5TzABBT+8fP7xq
X-Gm-Gg: ASbGncvyKwV9gy9iYyX/uEj5QzBFBE7VPKJQniz80cvZBdWq991qGO1oDzEIPxSL8JY
	mfMmeaDit7wv5kpXJXE4oGboR0FAu2w9qwzA/GKWCuw2n59jFnaeeGvRdu5D2jbeo2/rjVQN1
X-Google-Smtp-Source: AGHT+IGAY57ryAVbaFF/WYp37rKh4tTR1FGBDnr4EMmywz7oEXBdaio7JM+ls5NsIQOiXWzTqQw57gfdlJdNJ3nzKOg=
X-Received: by 2002:a17:90b:164e:b0:2fa:b8e:3d26 with SMTP id
 98e67ed59e1d1-2fa243f2c2fmr5903786a91.30.1738951660585; Fri, 07 Feb 2025
 10:07:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Feb 2025 13:07:29 -0500
X-Gm-Features: AWEUYZnKvbnxm1TJheN1ezdPfZ9BIKp-1aSZWkKw-FEt0yxJCKzEiC4nOrOdpXM
Message-ID: <CAEjxPJ7n-qTTYN1+6XXNiL82ZYiHBujO4ijpKvhiJOoW1xgZkg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/44] SELinux namespace support
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This is an RFC-only for the SELinux namespace support, just to
> encourage early review and identification of any show-stoppers
> with respect to the design and implementation to date.
> Patches 0001 through 0009 are just re-based versions of the original
> SELinux namespace series that predated COVID. The remaining patches
> are all new relative to mid-2024 when work on the namespace
> support restarted.
>
> If you actually want to try running it, I'd recommend instead using
> my branch which has an additional cherry-picked fix from upstream
> needed to avoid crashing the kernel. This can be cloned via
>     git clone -b working-selinuxns \
>         https://github.com/stephensmalley/selinux-kernel
>
> Configure the kernel as usual but add CONFIG_SECURITY_SELINUX_NS=3Dy
> to enable the support. More detailed instructions on building, booting,
> and testing the SELinux namespace support available upon request. I
> have been running the SELinux testsuite and booting Fedora,
> Rocky 9, and Rocky 8 containers with SELinux enforcing within
> the container on a Fedora SELinux-enforcing host OS, a Fedora
> SELinux-disabled (no policy) host, and an Ubuntu SELinux-disabled
> (no policy) host.
>
> Known remaining issues include:
> - Per-namespace checking of all relevant policy capabilities (currently
>   done for the open_perms capability),
> - Proper handling of peer/packet labels when they cross SELinux namespace=
s,
> - Optimizing the implementation for the single SELinux namespace case,
> - Review, and if desired, change the kernel interface for unsharing the
>   SELinux namespace (currently via /sys/fs/selinux/unshare with a
>   libselinux wrapper),
> - Namespace-aware context mount options for sVirt-like setups,
> - Namespace support for certain residual networking hooks that lack it
> - Anything else noted in the patches themselves.
>
> It is an open question as to whether some or all of the changes could
> be merged before all of the above issues are resolved, given that
> the support is only exposed to userspace if CONFIG_SECURITY_SELINUX_NS=3D=
y
> and even then only to privileged userspace. I think at a minimum we
> would likely need to optimize the implementation for the single SELinux
> namespace case so that it does not introduce any significant overhead
> prior to merging, or extend CONFIG_SECURITY_SELINUX_NS to actually
> compile away the extra storage and runtime overheads introduced by
> the infrastructure. Open to suggestions.

For those following along, I have created a repo with a README.md
capturing instructions for how to build and use this support along
with open issues for the known remaining work items here,
https://github.com/stephensmalley/selinuxns

Also, I addressed a couple of comments I received, squashed a few
commits together where it didn't make sense to keep them separate, and
re-based on latest selinux/dev.
