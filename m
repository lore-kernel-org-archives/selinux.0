Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FB47ECDF
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775303; cv=pass; b=pacFBJfvbFiYsNWzwPwk3cDSXeHuI4JmGVui8PhGS09ycG0Ky7KGytVLABTu8p9AMgsvoJ2PDIPRcTZXhhKF7vhQg2HyP2rH2pkaWOwn9sKBphxb/F35rkhkxFA4r51odNNe9eJ8UWV7jYoOiZphWCF8RMC2jLuI34523OF3k6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775303; c=relaxed/simple;
	bh=8ys/Tikx9Fy/J1Y2MRXrSKoBcDLhxr5wAGo15bHXk4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDflplZeR/n0EVUud2vIh980MJcOcfDEyv/dAq6p5+3L5n5/qE8FJAuF9GVhsV7MEe1Wdq4pc0IX/RpgIizs33vVWwFk+junAmzOLHIObVb9ybakQisEXBEkSZS7UD+kRb0r2b7k23J3Va8lwHlJ/1Ht3RwAoUjceQlP9qMQxLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLyH1fnL; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLyH1fnL"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44cd237446cso1728966fac.1
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 13:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787775297; cv=none;
        d=google.com; s=arc-20260327;
        b=REzTO6wL+0sYsdjh9TM4nQ/gTJWQUxZ8d+UejEUijNaVWW5JBT+BH6ZXQCyxBMuc1n
         JYdSyecUP2pyTCbJCZSdHKkpV4jB1Yb/UXg6B6BdPCyD/fSVGYjhg8RBAds0I84bOpU6
         8VMSHbumtPbEfyRiPRH+HYy+GY6KCiuW0Ira1NvuOTm+y+camndsDfkmMBEB8cjRgvHL
         iQ37xcmZU8Fh3Rahh9pfOssIXDL3vuZ1IZyRcaT7r6+Rj6WrLXbmvVoke+secGAl48M9
         kC7wTguFqChh3pcYAPc3P4FgdxSrJXajrp4XIOQe0z6VfRceKfSP5kpPi3dIjnTF91lC
         oIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ys/Tikx9Fy/J1Y2MRXrSKoBcDLhxr5wAGo15bHXk4Q=;
        fh=yGk+IKEZxJGFtqRQpcjNTcsP3uW9vSK1aRMQbU0W2LM=;
        b=DlLHUtPS9XaJdcVREvklNnt/u3WRU/lhkB0xJWQGcGToGxa/7SieTQnoaXHoUioXig
         Mpc0etDBqthrxiDtpe1RgdrkDklVkt5mtf5X9+oWmQKYA/eCbEEpdhn3gIsbaIn2LZiH
         /pEjktjVC/9Rt0ueZH9HXwyiXzcyZXqU6iKz1ibiHcg/kG1/5T49O/cAkxXvMsIhHedB
         x5Z2KYhIDrUILWE9M5/GE2owD/3J5cM6tzrreMdIhBJFJ7gjT7GqZ1jB5ChwBvEpqC5v
         XyMmz2iAPD4PbGKkJQUUnzVPX1k6Tf3OIuz1hZHtzAbGevwzR0XsXnG2yY/qN72WVNv0
         Hr1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787775297; x=1788380097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ys/Tikx9Fy/J1Y2MRXrSKoBcDLhxr5wAGo15bHXk4Q=;
        b=FLyH1fnLTaEqE2j41l3jJXs7nNnT80P7DES0OD63vMvN5xaw+JrLqkia/sRhxE0vZC
         IofAIlA1ItWBlpcQnPhxx3gtuG0pLjcZBwJd5qWRhGy7wfd28xqK57PRW3g/dqP6aCHg
         yW71pSw1jUhZg1iNC65v6DPNxQN3Slo4hH57MEYEJWMdfmLJY497vuu229L7jpU1b9WV
         M3GRlEJGeEsibFDAQiCP7gdQOEShFKmxYxb+oGRfUR/WudqwpleisdKAAuFCmub24OtS
         soq8eeJluzcsvvytgE5Ng7V1mbRmiKONZaJ76Vovqfv7lvXvjjawG8mnKxmlg/Hcqpbe
         ZfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775297; x=1788380097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ys/Tikx9Fy/J1Y2MRXrSKoBcDLhxr5wAGo15bHXk4Q=;
        b=khqbSyge597kc02oYa06KLhDSMb9YbOIr1IbQhpYoIuG0ia/tpr/OSmiuvoBzTHIYc
         T1M22xX1vkSXsGIMDcmz7GjgBaSHbgGiTYnprWBEVnF74RsJIZkAkCxc5H1H1l5+lt3i
         aiJ1wF/n3IRQR0A13YjqLkzsU8hAb6R1ms2LM2ravA/LJXRk1OllG3ApzTX0sJvKU2NY
         dhGfke7GaMH39nBPN8IzC22/nS9k67TNpI/bWAaup51HDbLNFcyCHoKXVwVSXm5Z9zcV
         pv6GTuguSRQgE24HpcjqqXWXjSvqG0WNhJEYbifvtqS90dmA0asWKjCVYk3Sf2iuz9bQ
         c+LA==
X-Gm-Message-State: AFuF++kHtGHUXRr2An9pTBR9o6BTOdhaHtR7Sj6Wrd4MpjWcSo/fircV
	O9Rkv5uHeRiOOaeMl8FV8R/R5ktbzkGrfHHrOjNKJ0PofYjuTMSyYCKVoh85OmAg7kdtPd6qxqp
	1X/2dplUKZtfFi2/tjBziygi2+cUG2gs=
X-Gm-Gg: AR+sD12cj7L4M/N9xr8mhWXakj0uPX/aFVhLfOWjqXdVhXVFf/gqhVhEN6hedkU4cjk
	LhVOFnAQRywzpWgNe/I48m4wV9QVMlsnQWGT/RLx4cVF4m/9jDbHAUxFkGUv5fDAGVe/YpBdQ8d
	MX5uK3Y8Lic21nt3xB6UQ2rMtPw0RdNDcrjfkMrTv5i58/711sBo+mtEVU4b2yWa3mKEJDVxKgo
	RUBTI26w9PfhEuS2FQSY6mBCmymFvxKoUAG4OvoMTa7Pbn6T8H47QqLl7qILbBOwOQ3qMpcqsbc
	DxWGGumHZF5jAkg/7od7WXF6q/Tjgh2B3hIcZVpAIUBY
X-Received: by 2002:a05:6870:5b9e:b0:452:2f:49b0 with SMTP id
 586e51a60fabf-46597c39c75mr10052978fac.4.1787775296672; Wed, 26 Aug 2026
 13:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824191442.77835-2-stephen.smalley.work@gmail.com> <CAP+JOzQnHp8Z5_jwjAe9eRFWKqR=UvfEzewyHKDdZYmduPHkGA@mail.gmail.com>
In-Reply-To: <CAP+JOzQnHp8Z5_jwjAe9eRFWKqR=UvfEzewyHKDdZYmduPHkGA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 26 Aug 2026 16:14:45 -0400
X-Gm-Features: AcwNN1WTl3-Bo4lSkdLyya9J1DrYlnNIYCo5_uwxspdjLAONhUFLPc6KkB2rEiU
Message-ID: <CAEjxPJ5mgQagPPQx8DEOiikEkxZE02yWvusfW=FCCbOdJ3ERJQ@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: label_file: make JIT compilation opt-in
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, p.matyas13@gmail.com, pmatyas@redhat.com, 
	tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:54=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 24, 2026 at 3:15=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Commit 92af7f1b61db6e ("libselinux: prevent ReDoS in file context
> > regex matching") introduced the use of pcre2_jit_compile() after every
> > pattern compilation to leverage JIT for regex matching to help
> > mitigate catastrophic backtracking on crafted file context regexes or
> > lookup keys. This triggers SELinux execmem permission checks on every
> > caller of selabel_open(SELABEL_CTX_FILE, ..). Permission denial is
> > non-fatal in this case but allowing this permission may be undesirable
> > for some callers and will produce audit log noise for others. Further,
> > the JITed matching itself is subject to stack overflow on crafted
> > regexes. Make the JIT compilation opt-in rather than automatic via a
> > new SELABEL_OPT_JIT option for selabel_open() so that we do not impact
> > existing callers while allowing callers to selectively opt in when
> > they want this behavior and run in a context that can be allowed
> > execmem without concern.
> >
> > Link: https://lore.kernel.org/selinux/20260729131413.1390890-1-pmatyas@=
redhat.com/
> > Link: https://lore.kernel.org/selinux/CAEjxPJ5i7G79aw6d7L_fnvr8zgsxPnmW=
8bFEJ6NCXWerrSvvYA@mail.gmail.com/
> > Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex m=
atching")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
