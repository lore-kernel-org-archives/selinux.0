Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D015A864
	for <selinux@vger.kernel.org>; Thu, 26 Feb 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064314; cv=pass; b=Ygp5ueqWDpVdyPX8mBZDZSHZLVOQ+aKTeJrRqcNiEGXykJ2oW73Rfve2hWxOYD+ixWhSdo7MfS4VW1fsZSQcTn7hwWlZCpbsHGI64dnxgNzGIulxxEXGSXOarbURKLGUz3EapctNPLvkvECHFWBGldvgd366cAOiDbmH0rhb2/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064314; c=relaxed/simple;
	bh=be7FPiPWe1/11EBo1DumJ14D6YL2yIf6xGwLC8NbK1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gL/O3B6DvxJVUUsrdJvduh4t7yX6HKzVcOH6lgCA3ij/tzhsrHlGgm0sEpDHKZ4Q84nnAnIBs0/90abdfx5H7Obh1XyEZc6rPuZfC4UgX8I5xwrOyFtyY/xM+7lJs6BE31iv8w0jGcVjb4zX5DvF7bIlm4TYbQEC4g/b5Kt/SN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ywoj3TGD; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ywoj3TGD"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3566af9900eso53807a91.2
        for <selinux@vger.kernel.org>; Wed, 25 Feb 2026 16:05:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772064312; cv=none;
        d=google.com; s=arc-20240605;
        b=e9OgUXc+jAcL7bwy0eMBS9Z14Dd2uiD5D58hOTQXne5b7zsYAWLXl7wJQWR/HaEXkT
         09IrJwWSeggu5R2Q64VDKfec3BTW2kpe6BhHGDmf0tVI+kBuq6N7wcIujeUtK3rJTIV8
         PbfobT6GdcWWo0u7JWXV/bplkMZSSP+dcFwiRW6Vza9SuJI2KCK+n7jEIQcdmvFotFKT
         LnqLBG0mqjZ38/OMIlpIL6R3V75G+GKyjm6uz+XYra0/+2Va9ZdJDii3OQq1ea7CoKx5
         IXt4OYqcIO5eEXiGLfkvMSgSnWSO+79yBXlvdpW/70l03n9eJIRAXWdjOAtCE/dThap2
         K56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSqoYbYsLK/wCGwHLYUJNGeDrLmFi7g+s8IszrO9hvs=;
        fh=Gy51sUQ6eW18CC5Jy9f7lz6dlXv/YEHeQ8BzHF/WGzw=;
        b=TQ9Wk48QxyT+M/qG4kwzHZUpTJyGyDPvB/pXHoiiG7akSEOlb/iEC6BrY7j7/AEBet
         EMdyd2vB9zpjW9o3tPUSiIc+9eVKrJCdHF37ARBTCS14ZlGmnyV0zSounPv5h3INGJbK
         OpHD0wi2hwhVBhPH+yS/wIsDqLPsnmPqHTvIHhUpmCfBOu/fRAIwiqhGUxJSkdW6mtZO
         L9JW8plp2W/jn1SGGMDB18dZ5fGiN4KdW5gsJlMt9aEGwzKC+qBiPDw6DQ3FMSGiChTL
         DlSO7H8s3/nZCsNd/AnlRCUrAJzjAxILiKKn162iMWVNNXLwnJ8lTHpMZT8l+OXAn2V8
         V1ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772064312; x=1772669112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSqoYbYsLK/wCGwHLYUJNGeDrLmFi7g+s8IszrO9hvs=;
        b=Ywoj3TGDpqLyuiOjvkC7+ZjN8a9xQZ3e8MIVgsAofq69tc0acw6Cs5/6I92WL2bLeQ
         etGejhj4+g3HiSMhmnQVMSWGp3CRj5ipsrnR1NcNOdwNekVGS22IEjwrPO362Nwyy9YL
         tEt9TYw+mgu1svp8KkxmiEXfm4Zp+Kl/eOqo/b6Vj2/okz1B9URW3XnBnvEHAfj2YKUD
         MiZ5nedzuDGjRTcjVzuDXicXdzsdtIpZD0zLfHb/Kr4CB7+A+FAR+gkO4PTdncyqCZXX
         kOKi61967uk7fsO0B7n1BvS5i0N3G9++cv4Vph/5achC4RteAE/13JBE8usjFvr1xVug
         AEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772064312; x=1772669112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSqoYbYsLK/wCGwHLYUJNGeDrLmFi7g+s8IszrO9hvs=;
        b=sqzPmMjSGEFOlfnihtXIxJicvtrxJKMlsFpMoe3Ek7qKQxIHPCqzUbv+VIhpMErGVG
         spKhbGPqiCuhAgC0MptJ+hzWwJC8TqBPFp3t4lMGIjPo3rgKsW1oW8Er96NI6bM/4y2h
         KOHiyiJSiRL1Eo7ZO9V8X4uy48q2PAuoDweYrRaxLKn2eJTj/9+BzWGlScA32ix9YYUP
         vrewPaB8SGTOUi0CFGu3YkpaGT2OWWwbilDbsDy73K1DDslbXTtLYBJdbbDP2OzK1Nfd
         BlLvUbvquVRuJjMNdxvb/yJce/XqPYSRk7gaz+CvuASP7AfiGHqB8LSHIZhKo1il4RWD
         NUzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPzvRLmEI/8LmV60vEaVev2s/J+1RIquJMcN6spadC2Vz53+/vwOzYp89hRqo1rV0x96VytMdb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7SZGsry454zmMAyJyQQefFKuCHUVa0sK24Lnxs6sVUE52zFG
	7icAgfRltSsh00xjenIdCxXbIfEyYwV4aYaXWJFwDRe8ZBbcq/q6XZluxEnS4FGPDRKCdiuIJ0n
	6CqHQ6XrHkToEBi733qz7etxvAloH9EV/fyjvez+f
X-Gm-Gg: ATEYQzz9tQutLrAaD4KfC/l2BtdPQAVcRwhXjs08pQi7QG1ryYPtMTIJy2ASpt47rWu
	23AZnp3NZ/w8S8XtiKXQqf0a8Y+Phn7QK6kFX0YoG5S+SCtLsIihK6S5ZBiGSvyaWec+dJSBw4K
	tEcOUCa9dERN7rlE28JpdWT9xK8ETnT7hxa6ewZxXJlegGmkxJAOKESxvYI7wFzt3PGQ3uRKS4r
	NytemrYaT2ElWt735qKQsjEKxoWaiTohrBixqkPAYIRWcLq6qxdfU/KpeObgiJSZpK4h+spz7hT
	17zTIps=
X-Received: by 2002:a17:90b:4a05:b0:354:bf10:e6a4 with SMTP id
 98e67ed59e1d1-3593dadfe0emr390882a91.9.1772064312452; Wed, 25 Feb 2026
 16:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Feb 2026 19:05:00 -0500
X-Gm-Features: AaiRm514ql28YykxQ8HO37LZr8RwO7Lk9Xi6HuiY0qbXHJIk_QejzgpYvk-NvTo
Message-ID: <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:56=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Hello all,
>
> As most of you are likely aware, Stephen Smalley has been working on
> adding namespace support to SELinux, and the work has now progressed
> to the point where a serious discussion on the API is warranted ...

I spent a few hours this afternoon re-reading this thread and tweaking
the original proposal to address everything discussed.  The revised
proposal is below, with a bit more detail than before, please take a
look and let us all know what you think ...

* lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) and clone(CLONE_NEWLSM)

We would define a new LSM_ATTR flag, LSM_ATTR_CLONE_NEWLSM, which
could be used with lsm_set_self_attr() to request that an individual
LSM create a new LSM specific namespace on the next
clone(CLONE_NEWLSM) call.  LSMs may choose to perform various sanity
and authorization checks at lsm_set_self_attr() time, but they must
refrain from creating a new LSM namespace until clone() is called.
LSMs may also want to ensure that any state associated with an
lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) request is not carried across
an exec() boundary, however, that decision is left to the individual
LSMs.

We would define a new clone() flag, CLONE_NEWLSM, which would trigger
a call into the LSM framework to invoke LSM specific callbacks to
perform namespace actions specified either by the LSM's policy or an
explicit lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) request.

As with the existing LSM_ATTR support, this is strictly an opt-in
mechanism and individual LSMs are left to handle this request as they
see fit.

The lsm_get_self_attr() syscall could be used to get the
LSM_ATTR_CLONE_NEWLSM value(s) for the current process just like any
other LSM_ATTR flag.

* lsm_set_self_attr(LSM_ATTR_UNSHARE_NEWLSM) and unshare(CLONE_NEWLSM)

This would behave similarly to LSM_ATTR_CLONE_NEWLSM, but the LSM
namespace changes would take place during an unshare() call as opposed
to a clone() call.  This is kept separate from the
LSM_ATTR_CLONE_NEWLSM flag because the behaviors are quite different:
one creates a process with a new LSM namespace set, while the other
changes the LSM namespace set of a running process.

LSMs are free to implement support for either LSM_ATTR flag, both, or
none at all.

* /proc/pid/ns/lsm and setns(CLONE_NEWLSM)

The /proc/pid/ns/lsm file serves as a link/handle to the specific LSM
namespace set in use for the given process.  A process wishing to move
into the same LSM namespace set as another process can use this
link/handle (or a pidfd) and setns(CLONE_NEWLSM) to change its own LSM
namespace set.  It is important to note that using setns() it should
not be possible to change the individual LSMs that are part of the LSM
namespace set, the calling process' LSM namespace is set to the exact
same LSM namespace set as the specified process.

Affected LSMs may choose to enforce access controls on the
setns(CLONE_NEWLSM) operation according to their own policy.

* Policy considerations

The mechanisms above provide for three different scenarios: a new
process creating a new LSM namespace set (the clone case), an existing
process creating a new LSM namespace set (the unshare case), and an
existing process joining an existing LSM namespace set (the setns
case).

In the clone case a new LSM namespace set will be created when the
process itself is created.  It is up to the individual LSMs to
properly initialize their own namespaces and load any required
policies.  Since the new LSM namespaces are created at clone() time
and before exec(), the calling process, or another trusted process
using a new yet-to-be-finalized API, should be able to configure the
newly created LSM namespace before exec().

The unshare case is similar to clone because a new LSM namespace set
is created, but it is a bit more challenging because unshare()
modifies the calling process's LSM namespace set, not a newly created
child process'.  For simpler LSMs this might not pose a problem, but
for more complex LSMs, developing meaningful applications that use
unshare(CLONE_NEWLSM) and properly initialize/setup the new LSM
namespace set may prove challenging. Developing applications that use
clone(CLONE_NEWLSM) will likely be much easier.

In the setns case the process joins a properly configured LSM
namespace set with all necessary LSM policies loaded, there shouldn't
be any additional LSM setup required (although the work to change the
individual LSM namespaces on a running process may prove difficult).

--=20
paul-moore.com
