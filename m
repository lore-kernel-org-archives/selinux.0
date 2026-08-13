Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229548AE28
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635360; cv=pass; b=b+DR1CpBRJlq03+8H02b+k/5QJJXwHgQyMMCCVR4vnWhlQHe63NbzQ1z17cZwWnABxiiluOLlZP5wCNt2p+KA2UTXUk+n4vGYgnzAbtoQrkCbrcctlidldMltLvjr7sPvSrJm7JhhHpbu0Rc8SGQzY2JMprGcEH564iTTfY8Hwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635360; c=relaxed/simple;
	bh=fL5V0ZIiyS+g7yFOczSaxX+yV7u3YCtdohH9mSTTFhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR7GIGfjX8o0iAzhTDa7lZxd5ftWQVnyWbX1F2lVxr1qQauITkuj/a5qwUOYL/npPsFkaanH2vgV5HHG0670Ii5g1p80NUJ/p/lQRWV3dMMqAgpKXDD6JR9c+NbU9xymcfiughnI5cy9pNUrxj/drsvvqBpDTu0nTOCwCtOx1Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfm8xJog; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfm8xJog"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6acc15016f1so28040eaf.3
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 08:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786635352; cv=none;
        d=google.com; s=arc-20260327;
        b=mQ0/JEAjPXhujFdVsWAYA9dXCmJR+PO5VDu/GF6tqmf3kBxyE+OqMygnVqOuQ72dyx
         HB7INBq4iRKszYrSjOySw1IW2vDaPO4tDkK2TE2uzIMOK+tS8RjEdKB3GjxRgHYgsAnT
         yrAiOrWgKL3dleKDUa/r2t94vEYeJsVWCSOdeM3bidzW5zGuRL2rePaNmteKSr3kS0fC
         Da7jEHzgg6Lua4USFp+n722RplAflVmzhVtOVOyZBtzCCKScLSxrnB00Q/Yugq3u7TiR
         op072kclJT5PtwsCU+ULKtBlavDljxwyd/9vn0KE/UDdOcoSnjyAE25gXj8wsLGEbSHb
         slYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fL5V0ZIiyS+g7yFOczSaxX+yV7u3YCtdohH9mSTTFhA=;
        fh=cVZI269ioQuwKzLGwbELyMvF9+q8sQJU42mbMSjvW4U=;
        b=gFCNRmR7y/QECzzQw0D6cMLdmIwbb8EVIaQT1sPlpAOaXfKU3AZvO/xdJufUyi/VBv
         fKX0bW4WumBB3yV/AAmvpZKi/dtAglTbRmVy+7G1sfGbajAGzQVFKb4h0yfMLmCDok9x
         zNsiQZMU8X0kJW79tJ9LX6xjECNB4TU0iWZ5mHneVLK2hboNyVQ68/xFC5SckGPrlXTM
         KmZSO/Wu9oRO9cSGPY3Yr+IycUuR82JBaJGxXo2ul8C1RjqckcBkBbp1a5vwVYVPPmMO
         WvIZ2+B5xLkxe97pxwAWZ2mvmD37Htuz2IiRlao29/U/Hdi3Q/IusQU/Ab/bOo2gqEaF
         J9Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635352; x=1787240152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fL5V0ZIiyS+g7yFOczSaxX+yV7u3YCtdohH9mSTTFhA=;
        b=hfm8xJog60awIJsCz2i6EmgHIFS/cglBdynflbpYgHPu5+iS3gZmiRc7EIvY96FcpZ
         4uqWhoENTqRelsPyl/4Aa1jRJh752rV+iypQk9ZQnWDkNo63lQdHaXykrqyJy2ttmEaK
         fGNNuwbumMYstArAstT1NNEQZYndXg8tnAcmFchzO/CV658WC7O9x60WBBGYJUKNTcr2
         A+bfPaqIgxrry39qPNke7nKn03s/wXauvybmkzWn2WUhm7bkKQaTSlZylIgGQtgIH0ED
         hTGBLFJMm0chEYMk/8VMSTjGjG4+9661rbbOvxj1i2uAp4edAJYAyVuh0QM/jrF3Um35
         jxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635352; x=1787240152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fL5V0ZIiyS+g7yFOczSaxX+yV7u3YCtdohH9mSTTFhA=;
        b=h6d46tigYxHFQnp3i56hVQ2QvVy0FWU0GGuMgOIepaneEKe+9G0czargpbczDI/rF8
         K/4KBz5XkmsC+2EWE/nqFG+m1ziNuiliw/x0nWg9/PuXjPsWeFLrjzvkaV6auE/0DetC
         Hkct4n4Z2reEedloWqBXa2tHHsTA6st6Nm33SO+95FQnr/OPvjNCXh1mBm21/s46aCYE
         1CGJbopyfKhXQ6MQlwA4lapIQbnfjKrTjWAFN01p7mIfni1GPVc5IUdxlUV93F6YprC6
         Fyo7wCEiAs1yV7koGRYhebtyakRarEPCMpuvbyq1RWY6lkZQHLBj/ELih5TMJcrcd0x6
         lx8Q==
X-Gm-Message-State: AOJu0YweaIbyTNWaEIyRfOUfYeFv3H0u2jMUXRU2Gq5/+lLoGkCkfRdX
	nPTCxJ4BoTe5kITJscXYKAp7s5BuiRAfcALTRRCL1mj//BL6t3WyaOe8GoBM4VQwqrL7LBAv2qn
	oFkYN2HWUeBujB7HG7+JC2zHQpoW8Kw2+BA==
X-Gm-Gg: AR+sD10Ze//3OMElElEUgXtbgReCm8mUkMOKvNS9c04nu8SKTdoMQqjf1ll92UF6rTC
	RIvWfq2tQAmK5eVgnWLIs7Bh0KgeRaaTSLJ5AVIRadTLLrrvpGqj5InN/24hMW2lOfBSQrIb7Wd
	28371AS0/Ktm/D3s2gojVHqqw0eOylZ9C/mxM9gZ73ooVWmnDnRFkYPMUR/VA83yBW57Vk4o2Dx
	sOlEwT5kL/5nn49UcKXz9hefkh6DaDTZOIiDuIa6hqQ3ZY5/LCBYlQXn7dUh3X7c7vtd1pvJcbI
	cUel3YzGM/58zE4r2wFtOwVDxRjoaZHIYm/qvGzCGo9n
X-Received: by 2002:a4a:ee10:0:b0:6aa:1633:7af9 with SMTP id
 006d021491bc7-6b0c4779b44mr5788325eaf.35.1786635351797; Thu, 13 Aug 2026
 08:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813073533.3253251-1-pmatyas@redhat.com> <CAEjxPJ4yW94x_DLSe=zdmfKB95aagFmydTKsBnWGfjc6efr4hA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4yW94x_DLSe=zdmfKB95aagFmydTKsBnWGfjc6efr4hA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 13 Aug 2026 11:35:41 -0400
X-Gm-Features: AUfX_my2Q-3Di7eH4zo82G3KqYtDfyMX4HuuR8_Vc7enu08Zgmm9Wtte1dwAW1s
Message-ID: <CAEjxPJ6uL5L=hMc3Gz0B20e=UhDcnWL2WyK-_xbM6Gv5KruDRA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix SEGV in JIT matching of recursive
 patterns in partial mode
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 8:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 13, 2026 at 3:35=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com=
> wrote:
> >
> > The PCRE2 JIT compiler has a bug in its PCRE2_JIT_PARTIAL_SOFT code
> > path: patterns containing recursive subroutine calls (the (?1...)
> > syntax) cause the generated native code to dereference a null pointer
> > at match time. pcre2_jit_compile() returns 0 (success) and the
> > compiled JIT size is non-zero, so the bug is undetectable at compile
> > time and only manifests when pcre2_match() executes the JIT code.
> >
> > The root cause is an interaction between OP_RECURSE backtracking and
> > the hit_start tracking mechanism that the partial-soft JIT uses to
> > remember the earliest position at which a partial match was seen.
> > No fix is currently available in PCRE2.
> >
> > Commit 92af7f1b61db ("libselinux: prevent ReDoS in file context regex
> > matching") introduced pcre2_jit_compile() calls with both
> > PCRE2_JIT_COMPLETE and PCRE2_JIT_PARTIAL_SOFT. ClusterFuzz
> > subsequently reported a SEGV in selabel_file_compiled-fuzzer via a
> > crafted compiled file_contexts input that triggers the bug through
> > the lazy text-compilation fallback path (version/arch mismatch causes
> > the pre-compiled PCRE2 data to be skipped, so the embedded regex
> > string is compiled on demand via regex_prepare_data()).
> >
> > Fix by dropping PCRE2_JIT_PARTIAL_SOFT. Per the PCRE2 documentation,
> > when partial-soft JIT code has not been compiled, pcre2_match()
> > automatically falls back to the interpreter for partial matches.
> > Partial matches remain protected against ReDoS by the 10 000 000-step
> > backtrack limit that was introduced in the same commit. Full matches
> > continue to use PCRE2_JIT_COMPLETE and are unaffected.
> >
> > Reported-by: ClusterFuzz (testcase 5660382656790528)
> > Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex m=
atching")
> > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
>
> Thank you! This also appears to fix another new oss-fuzz report
> (selinux:selabel_file_text-fuzzer: Heap-buffer-overflow in _pcre2_script_=
run_8)
> that just showed up (reproducer attached and output below).
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This is merged now. oss-fuzz should let us know whether it fixed both
of the recent reports.
