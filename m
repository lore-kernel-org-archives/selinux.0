Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCB342CA9
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719304; cv=none; b=jAlliIIq+5PRqZJnP/bbX/9q5rcaLArQI0HunZZEEzZj4/aSggj8PimiZBycEXKFJEt4U1wqoEAp9mQJ/FiIWKKciVzTEOQEa8LoSKOKSEtBOKp1pqLlGAzkHzba5oAZIdCp1mE7+xtAKiKf8wTSYuGU+MtxulEJd/ZqJ5NbfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719304; c=relaxed/simple;
	bh=z/4LWluWyoc1h30W8j/AxdkzznEYaFQpQ/aFhRtPyZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+LbcVZxAMQMjSdjAqm4C02gfWJtRCjT4aEKrTeOrLe9dbld6MZaKYMKlxQ1BrkwhqNruZxZI7eMVlAGmGB4BjzR9DHd47JRLWHRQjRHdWmSSO89wLfg+jofkL/5CIs0xkqq+77nDc3mEr7V6mfAO+l6OjdCAKvVTvsDBlSTyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOO7KBkD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOO7KBkD"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c868b197eso1367883a91.2
        for <selinux@vger.kernel.org>; Tue, 06 Jan 2026 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767719301; x=1768324101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMW+59OOe7kEm8OpSPlC5/HgGwSj1YI2G8LDxG8k7Nw=;
        b=cOO7KBkDbmzKx0OFkZmGFC0mCzPUy/0qH5mMh9d5SzKO8vDpcKDACd3m5ADBtnYvHJ
         0wgY74lnevjmgDBuzjp9Bo0OmVAurFaRWR+dvsSpYihUB7ULeBjSD8UgEt/TcfhaimN5
         aJZHv0fia17VasyzDbHP85+aAuPZ67Vy4hHCWU7DTiLS4gjf7y7C4O0PaL3M/sHfsO0q
         tvVPbDPHDUShD9MlnBojVRsaHEcVgn/e96N18V8nKEOBJJ3ZM2sYs/+Gj2fkFOGTbEvw
         IY5GdozaB0fvmBhLs4LUtOatWG6R7/26vW1O8M9mkYnpop1zvByoAdi6JRr8v3aok0W7
         XftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719301; x=1768324101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMW+59OOe7kEm8OpSPlC5/HgGwSj1YI2G8LDxG8k7Nw=;
        b=fGhHdX97bbZYsJt3r2g5ETLNwemKCXcMglU37XlwlnGi7sRQEZ2beelCovH6ZGSORe
         v2w58SMXBmnv5JOgIWqPjdyDE9NOPduFGONbaq8yppqMPK8+kpXKqlEuJcjpy1OEo78Z
         GzPYrqi2IYmkDRGojzROhQyyGoJ0w+aY5ubqhQApeBIEpYQTjU8bgVoh6nY5odMJHsm3
         CDMOQQyNAyCowMoRlLfNK/b1kKn8ws4574whhtNYsSywn0OieYjeqzMu2jnDhwNjb8Lc
         NRdgPP2eelUnlmFdV7Pz82LNGx/e7p+3ZL0PkcO8Jprufg4tFdEqAsVPoKsEnoPlzC6p
         qZjg==
X-Gm-Message-State: AOJu0YyHaYWkf5BhJKpu5Ne3kfZ56TPlbrHXhX1ap/xl+vdqFNr6/H8l
	COJp64qHfoD8nTvXrSo8rbmLqNwyAgHO3FBp6buuz+lUUjzwgXRyloqns5tOGCnNtJH3umScMAX
	ogiarjbpE2mVr0OE+Kjpv435bZwnyUAMvkQ==
X-Gm-Gg: AY/fxX5t0QDtgSpO4HM6A06BchUStP/drjG4dZiR5ehBdKrhqr7i3mGg2/5U705pBRc
	kJHs6fSClp+bchbObZznRfEBVRh4U1RsvU1RsQn6EdMWCdVt52nfa6XG4D93QkoGcZnJmjQVVSR
	0NIqk7jgvKWdx7R1Q6BUG8/SQ1VsXG9AYM75EQdOkW/DR86FIqxA4m6qIvBQnEMIBZxJD1dvyOS
	rUvHnTtmGli7yUGEZ7ivtWiGCfFefPE3JdqtsMs6ebR4edAqNZxycINVRtdMGuvq8I15qc=
X-Google-Smtp-Source: AGHT+IFlONzrE+orQeC/YaFyDoyo5POOvHoizeRxdhZCPMEea4oE9F7p/RNNKeLnVQY3wfFqybmMJX0ZbpvNMckS3PQ=
X-Received: by 2002:a17:90b:4a02:b0:349:2154:eef4 with SMTP id
 98e67ed59e1d1-34f5f26c601mr2926576a91.5.1767719301393; Tue, 06 Jan 2026
 09:08:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com>
 <CAEjxPJ6yhZSbzMWXq4sQQ7hLydzzmz3i_Bnj9nhskdr0rWf5Hg@mail.gmail.com> <508aca6e-7b32-4b4a-b309-6e6faebf0b8e@linux.microsoft.com>
In-Reply-To: <508aca6e-7b32-4b4a-b309-6e6faebf0b8e@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 6 Jan 2026 12:08:10 -0500
X-Gm-Features: AQt7F2ozGhkDJzGLX1Rlm2mK9vS60f6Yju4knvcFUeRIE3MLJC7fACntN8tLEto
Message-ID: <CAEjxPJ5insPOkSdUuv0ziWFT_8S0bJ5VUtQ0kyrjJMATqw-=Gw@mail.gmail.com>
Subject: Re: RFC systemd-sysext/confext image context mounts
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: SELinux mailing list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:44=E2=80=AFAM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> On 1/6/2026 11:20 AM, Stephen Smalley wrote:
> > On Tue, Jan 6, 2026 at 11:08=E2=80=AFAM Chris PeBenito
> > <chpebeni@linux.microsoft.com> wrote:
> >>
> >> Systemd provides tools for composing directories like /usr and /opt
> >> (system extensions, sysext) or /etc (configuration extensions, confext=
).
> >>    These tools create an overlayfs at the target location, with the ro=
ot
> >> filesystem and extensions.  While they support raw directories, files,
> >> and mutable filesystems, my current concern is with extending immutabl=
e
> >> distributions at runtime using additional immutable images.
> >>
> >> The challenge lies in ensuring proper labeling before deploying an
> >> image, which is problematic for third-party images lacking labels or
> >> using incompatible ones.  I haven't made any patches yet, as I want to
> >> consult this group and the systemd developers first.  My proposal is:
> >> for internally labeled filesystems (ext4, etc.), have the tools valida=
te
> >> the image's root directory label.  If validation fails, apply a contex=
t=3D
> >> mount using the label from the contexts/systemd_contexts file in the
> >> policy.  I'd probably also add options in sysext.conf(.d) and
> >> confext.conf(.d) to override this behavior, such as for specifying an
> >> alternate label for the context mount.
> >>
> >> What are your thoughts?
> >
> > What does validate mean in the above? Check that it matches the
> > mountpoint's match in file_contexts? Or just check that the context is
> > valid under the currently loaded policy?
>
> I meant the latter.

The matching file context for the mountpoint would be a more precise
check of whether the directory tree is labeled compatibly with the
host OS. Regardless, to get the actual on-disk xattr value the process
fetching it will need mac_admin permission and CAP_MAC_ADMIN in its
effective capability set, which we generally don't allow even for
unconfined domains, and use the _raw libselinux interfaces or the
getxattr interface directly. Otherwise it will be automatically
remapped to the unlabeled context if invalid.

> > A potential problem with only checking the root directory label is
> > that those are generally the same across all policies derived from
> > refpolicy, whereas you are more likely to find invalid or inconsistent
> > contexts on leaf nodes.
>
> I was thinking about grossly different policies, but this is a good
> point for slightly incompatible policies.  My main concern for doing
> validation across the whole fs is with how expensive it could get if the
> extension is big.  This could also be an argument for having
> configurable behavior in the sysext/confext.conf, as a tradeoff for only
> checking the root dir label.
