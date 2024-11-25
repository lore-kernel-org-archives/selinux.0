Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9B1B415F
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555608; cv=none; b=btXoTJcbJ2JExTypNzZ+TuFSgeFWX43QjePZM3zzNShdYVXuT4Dn8DPwdihYN/fJ8GPKGBv86FrJ5aBGQEeHAT4caCaRWADBREdIfFsO99Xn3L/X1sC06FB6e/w5rlFRVh8XocwIF1gAK9NK2FLq5ytqxem4oHzoqNAbyJ4dzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555608; c=relaxed/simple;
	bh=t73WbR3ab3rF0Q9RppmNDg+jLwz+yZEqwvg6KqtHwl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMi88eYT+RHNWNPFQy4tdoxrdsxT1BhhAAsPAkNhE7oPCylD1gxPdNsAqMadhQcDxGz7zKXkH/AWz51iDgrbxfT4O3EmLSFnij3hMjr5XDeowsDlfssq46fdCXRjYpjFETDosaAUFNwGKZ29f/pRHmATI6BYdKPDzyvTK604ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lyYpqJ+K; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lyYpqJ+K"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eeb2680092so45662507b3.1
        for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1732555606; x=1733160406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzxgNxqaDGuk1IV5pj/Zv7sx7PZeGmYwY8RUgm1VgKg=;
        b=lyYpqJ+KBsugKE9bMwElz91tdmNhZRPsoWajB0fwnFB9mP7DllvGwsJyIhpALNe+Tc
         KjuJU0755Fw+NXRoErJi4CHa5mUixR+d+xxQ+gNsgVkJfHoF/9nfmvLDsq7AeYxiR8Lk
         S13djs5Vqhj1u5JEgNl8bump1mf86HBasNEQxnZsPuD81LV/JPs+5dgmuogvxSVT18/d
         04JNjTB/iVLzUPUJjlStnaF+Z+bpFuYhagmfZ9FYvryzGghWub/6nhGr+EWRa5aD7Vho
         lcfKK9Y/zgkHB3sUxtpnQP6pUOc4O+Rih8bHSc6yt+/bbSXzB2nuSg3zld+5bWbjACw+
         RDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555606; x=1733160406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzxgNxqaDGuk1IV5pj/Zv7sx7PZeGmYwY8RUgm1VgKg=;
        b=IGAFp+c7ecxR11R66ecorrjQjnZ4MGSfJof+nb7Pkg6SeOkhuFGTylO8GyBF8qaSoL
         /EsVUIe6NBpEmKZxifnjynLC1kH82Gtr2mswnu03U8V74eTNbzagTRnmulAJ53mTnsY2
         hWMVbMhmaC0dbeMWQTmDPn3ZIDCsHsyjTPqEcqienN6iTe5ORyUP7y8wBnGLBjoByT1m
         nFkb3CSkeP3HldGwjtDd/d/MYFDpCje2Bsb/UHJx6K9DPGuwfmRrr3ZaSCKLnpu02zwd
         28S712dm+jCRS//tOfkpx7OoPbV2mawH6nmnAYqzPPCiJl4Sd7JtjyvkfACQNv8n9LRp
         I+yg==
X-Gm-Message-State: AOJu0YyzK1D1UPqseo15tl9SzA9QpkWQ/K2LTViPg0++3C0ZhaAjvmAT
	TSMcD265q36pMv9rUNcemF1+rr01pbJqsnRIYWpt++Sb5YxfKBdCZ1ljL0B4v1d11ohEqCJ9Dyt
	CBHNJyk+VJf6Eom9gNCbj1iDThvw0fiftx94=
X-Gm-Gg: ASbGnctMzgsmDQAOtPZ/bJY9twb1USaxBE7OxDgUSBCkUXUlZdJ6SLGdzHQv0X7muSB
	REglCdsQhMDc5tACKVYAuEBpDW2v9DjM+
X-Google-Smtp-Source: AGHT+IF+UQsuO8ZW51g4f2XEayPf9CN5c7ZfkWRzb6SNlBf2q/jkygZddutiIwn8SHVQ/Sro8/QU3C+Gtsnr6SEobVY=
X-Received: by 2002:a05:6902:124e:b0:e38:b767:4cd4 with SMTP id
 3f1490d57ef6-e38f8b22755mr11288332276.26.1732555606004; Mon, 25 Nov 2024
 09:26:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
 <20241115133619.114393-23-cgoettsche@seltendoof.de> <342b4afd-3a1a-41bd-8e2d-63eebb1fbcd2@linux.microsoft.com>
In-Reply-To: <342b4afd-3a1a-41bd-8e2d-63eebb1fbcd2@linux.microsoft.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 25 Nov 2024 18:26:35 +0100
Message-ID: <CAJ2a_DfU5yPQk11MLMuTLB43Z-xrQ8w_M6T1zgshydbcNY=KvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] selinux: harden against malformed policies
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Nov 2024 at 16:35, Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 11/15/2024 8:35 AM, Christian G=C3=B6ttsche wrote:
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > With the SELinux namespace feature on the horizon it becomes important
> > to identify and reject malformed policies at load time.  Otherwise
> > memory corruptions can compromise the kernel or NULL-pointer dereferenc=
es
> > and BUG() encounters can bring systems down.  Currently this is not a
> > security relevant issue since loading a policy requires root privileges
> > and permission of the current loaded SELinux policy, making it one of t=
he
> > most privileged operation.
> >
> > The first 9 patches are cleanup commits with overseeable diffs.
> >
> > Patch 10 unifies the underlying type used for security class identifier=
s.
> >
> > Patch 11 to 21 add various checks at policy load time to reject malform=
ed
> > policies.
> >
> > Patch 22 needs some discussion:
> > It limits the valid set of characters and the length for strings define=
d
> > by policies.  Currently there are no restrictions, so control character=
s
> > are accepted, e.g. Esc as part of a type name, and their length can be
> > arbitrary.  Human formatted security contexts however must not be
> > arbitrarily long, one example is they must fit in a page size for
> > selinuxfs interaction and network associations.
> > Thus the patch introduces the following restrictions:
> >    * Disallow control characters
> >    * Limit characters of identifiers to alphanumeric, underscore, dash,
> >      and dot
> >    * Limit identifiers in length to 128, expect types to 1024 and
> >      categories to 32, characters (excluding NUL-terminator)
>
> I believe that those first two restrictions match what CIL will do today
> (https://github.com/SELinuxProject/selinux/blob/9b4eff9222b24d4b5f2784db2=
81f4f53019263b0/libsepol/cil/src/cil_verify.c#L96),
> but the length restriction in CIL is 2048.
>
> https://github.com/SELinuxProject/selinux/blob/9b4eff9222b24d4b5f2784db28=
1f4f53019263b0/libsepol/cil/src/cil_internal.h#L49

My intent is to make it hard to reach the page size limit with a full
context of `user:role:type:mls`.
Also the current SECMARK limit for the security context length is
*only* 256 characters, see
https://elixir.bootlin.com/linux/v6.12/source/include/uapi/linux/netfilter/=
nf_tables.h#L1379
and https://elixir.bootlin.com/linux/v6.12/source/include/uapi/linux/netfil=
ter/xt_SECMARK.h#L15

> I would think that we'd want to end up in a situation where the kernel
> is either equally restrictive or less restrictive than CIL.

Yes, i agree.

>
> -Daniel
>
>
>
