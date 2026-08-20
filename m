Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC97442B2E
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229338; cv=pass; b=DhuNi4IcRtEPZNqziccnWsvmvIx2P7z7KWiCliLmF0dALURIYABYVjkgTG+naYqikP6MFRtm0JRFgLdJ/2Aj5Z1u6rf241l96r7G33fxdGo1g1PKdzqdZ02mVHS8TTyWWvFXOfQ6k1jFN9a6jVZzh74mf3r5j9E7ddo3hMcJuxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229338; c=relaxed/simple;
	bh=CzaVK+SQievluDDuXsCDo8XokIJeXdPaumgXu8sdWGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EstV7Nuo7DiUcFOPoza7Pu+XcxsB9pSYoplZAP6U1Z1n7nRtHfstX2uOnoGg9aZbVINS1za15QtS6P+x1GUr58ftPdiKadOf1cDCJidjWdKhki1yTuc5gCcLUTxWsz3graczMkvwXNF8vbpJk7Hxv29Gee+E6OPU4X9IqvUoxAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTnqqkTI; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTnqqkTI"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b14971e862so430271eaf.0
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 05:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229336; cv=none;
        d=google.com; s=arc-20260327;
        b=Y6HEQU8q5wT1Ory+fFr5xqhNUwNWafYnKwMVUvYR3JT+ALpRoEdlPNgG9fzmEMaYg1
         2Ye5rmm+N0WEC/kQvRzEWvazNTSKDA+Ev9/HtBIUscN9Rc1mlnVvASkmeKvO16SM1bpD
         M43MhZaoGb/EIaY7tthI77TG+qjAGn674eg70WtAQxz1fst6v8/bKI5ydLRw0z2mLTHG
         PHQAUgjQkvr92au9KbF6Q4zqjy4lXXguIqPrcwV7rM7Qu6+Z0az4tOz3GFtSqFCvNJ6z
         2O+8kLDSMgpSv4I/eell9CFDCkDAAHKNvHZiMfMALEAgyf2UM8xuexTCZ4CjIjxo8HLB
         jkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IP3rPD90LGXq8spLotWCGsXxH9/MD4Qwef4e3RRxIRc=;
        fh=WW42/MS8KMBE30aHzgGYYqniQlOuMPH48LLj9zpa/lc=;
        b=IGF3YUklTV8UIwAIw+wX2YbOHM8915s64YOx0MJiL3ezwErUqHR5kspB8Pfo2Vl7nA
         /Qfeu26DgEzE8UB1g9ZokjX9wfzN9n3hEhEnmiNZyW2vUCb7OxTAYm//Z57UoZ9tw9FN
         xQXhAhEDSEr+2U4DpVku8mQbTyPdUwPoyDMcfkASlgXLcDqcIvtp9npMuBoylPod9dAa
         B5WxAKVQMsH4xxFocbd6IZ2V15j+PMaisvphM2zAVaQA3OGEoac7CxCNW7LwbLq1UakM
         uasE0H3Gr49UcA2i8pfznBvWz97HaSnAbpTEKDIbUXCDvDZAMl0ZocMFppKvkFhY/NWn
         CCQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229336; x=1787834136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IP3rPD90LGXq8spLotWCGsXxH9/MD4Qwef4e3RRxIRc=;
        b=OTnqqkTIR3x00Gpm98FEm+rMouiv6o0l9UXYoFe73+GxcqbrD2Br4+WbvIsM6qfc0m
         arxqpnGCxaS/Qg4s/a7BFgHmRZcJ+Ck3yB4/qg4r4CpQbMBWRZ7VERJNaUBNrx/GTHwz
         a57f4n5dkX8PmpW1cYmNQYLcKyt97aZUaxPkhYhww3T6ajhCl1Y+iRVxezGWKgICAhpd
         GjCk28haZA57lTGrkoL8Gu5THtulZAFFMzxS2Ly44MPuBA5I4pzRVnmF0s6MiP7YWRpH
         fNRJtbr7rKxIacIa04WPzMh4su5xXhyChQuMIJ4Wx1Xf3ucwLIFBU88GkSpWqAtph6Zp
         zijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229336; x=1787834136;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IP3rPD90LGXq8spLotWCGsXxH9/MD4Qwef4e3RRxIRc=;
        b=nAnIxWReKnB9oqWXmsLCoooPBQwXu306KFJ3W/qj0/C7ILcFiQQBOYCYoH+tM5VQtW
         Kpal8tg2CR32xTna20ODNEYMQbY6QCM9ehjQPD8FCFHQTmIPb0MAH2OqI+EmUJpCGRBs
         g49cqGFwAeT09641HdpirwDRT1KQzpTQ1idTDh4W1ZVMuyDByTUi9HTkfiSV/5WBq4Mf
         U6UDbnlDPxggbP7lBH9GZ1USOxRgUT2KQf99GbwEipUR5HL9SDjZcXNV/Uhglp5i53sK
         XunUqLt8ydLKITgDixgTrfZTUdEcyhjrihBSSxKDf5xGxKZBVplF/E4Bikp015E1K3dZ
         4zhA==
X-Forwarded-Encrypted: i=1; AHgh+RrwWcxO16FGeB2VB3Z0kqKhaoAdTK4b+AwPUDTqpf7I3KJfwXnJxb6ZHxvD8lXOoRLGcubImV80@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDgGvk0bfRifpZq0zR8g24aSfkMqSPbfm8zOSv8nsG32Wo2RO
	yYRqY4yt65fqLv9d7LW1SWo+8jUBXak9dHFG9/0/3ZApXHLsiD0LkNLmuezD/AhHUVa7KYTL34j
	fd4SLUVSxFlHDpeQ9xqPeEn9tAy0gtXI=
X-Gm-Gg: AR+sD10xUTmQRr275tJkrlb1GsF8bLDaE/RWYQf69huYue5J6C1IVanTFPuIUKBYwbx
	I0Gs+U+nrvBnUHrXsCyB0NuoBKcmg7bNty23ieVN/nY+MTpzP6P91W+0iNMxC+ebL2RiIxhEH52
	Nj/0nUkJM3a7TObc5YMaTbWME65yUfqDav162UedVKFEPFQ+VRYHwDoXQOqF3Eiu76qWCrBO4KY
	W2L7wxDMDrBICW4Ivh1iSDEfYePzioQo/0ISn3DvQQaBLqh2Rl/tS+EOmFPQBt7LVbxAReSgDj2
	sytfaYwKD8gchZgVwT2ySUvNu7+IzAOFk+cg6MZvTomo
X-Received: by 2002:a05:6820:2e81:b0:6b0:31d0:5fc9 with SMTP id
 006d021491bc7-6b148ed461cmr3798272eaf.7.1787229336293; Thu, 20 Aug 2026
 05:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5i7G79aw6d7L_fnvr8zgsxPnmW8bFEJ6NCXWerrSvvYA@mail.gmail.com>
 <CAEjxPJ4cvbu-JRQX+zivNX5i++guHGcwLBbvL-gCrVpSgZ1k3A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4cvbu-JRQX+zivNX5i++guHGcwLBbvL-gCrVpSgZ1k3A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Aug 2026 08:35:24 -0400
X-Gm-Features: AcwNN1Vto-Zp2mmP35TQGXQhiRnBzoxoorO57q-yAItRhovyfZ82doiuSCeOwd0
Message-ID: <CAEjxPJ6-b4KmkgSgO7hXf+8ZGgRtR_JkS1ZQU-ULVk0aex5zCw@mail.gmail.com>
Subject: Re: selinux:selabel_file_text-fuzzer: Null-dereference READ in selabel_file_text-fuzzer
To: Petr Matyas <p.matyas13@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, James Carter <jwcart2@gmail.com>, 
	Jason Zaman <jason@perfinion.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 2:26=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 19, 2026 at 2:18=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > This is oss-fuzz issue 547975134. Crash stacktrace below and
> > reproducer attached.
>
> Here is a more useful stack trace along with the fuzzer input header
> information decoded (\s is a whitespace character of some form):
> find_all
> mode
> fcontext_data_len=3D16 fcontext=3D(|(?0(1)))++c|\s?
> len=3D1 key=3D\s
> *** stack smashing detected ***: terminated
> =3D=3D4287=3D=3D
> =3D=3D4287=3D=3D Process terminating with default action of signal 6
> (SIGABRT): dumping core
> =3D=3D4287=3D=3D    at 0x48E3CCC: __pthread_kill_implementation (pthread_=
kill.c:44)
> =3D=3D4287=3D=3D    by 0x4888E8D: raise (raise.c:26)
> =3D=3D4287=3D=3D    by 0x48707B2: abort (abort.c:77)
> =3D=3D4287=3D=3D    by 0x4871803: __libc_message_impl.cold (libc_fatal.c:=
138)
> =3D=3D4287=3D=3D    by 0x4970F8F: __libc_message_wrapper (stdio.h:203)
> =3D=3D4287=3D=3D    by 0x4970F8F: __fortify_fail (fortify_fail.c:24)
> =3D=3D4287=3D=3D    by 0x4972343: __stack_chk_fail (stack_chk_fail.c:24)
> =3D=3D4287=3D=3D    by 0x42E1BA: jit_machine_stack_exec (pcre2_jit_match_=
inc.h:64)
> =3D=3D4287=3D=3D    by 0x46772F: pcre2_jit_match_8 (pcre2_jit_match_inc.h=
:173)
> =3D=3D4287=3D=3D    by 0x47D034: pcre2_match_8 (pcre2_match.c:7204)
> =3D=3D4287=3D=3D    by 0x40FA51: regex_match (regex.c:295)
> =3D=3D4287=3D=3D    by 0x409D52: lookup_check_node (label_file.c:2013)
> =3D=3D4287=3D=3D    by 0x40A4FA: lookup_all (label_file.c:2278)

To clarify, the \s above is a single space character in both the regex
and the key.
My decoder for the fuzzing input just prints it as \s.

My friendly neighborhood AI suggests that the pattern (|(?0(1)))++c| ?
triggers a stack overflow on a single space because it creates a
catastrophic combination of possessive quantifiers, zero-length
matches, and infinite recursion. Standard interpreted PCRE2 tracks
recursion depth and will gracefully abort with a
PCRE2_ERROR_MATCHLIMIT or PCRE2_ERROR_DEPTHLIMIT. However, the JIT
compiler generates optimized native machine code that relies on a
dedicated, fixed-size memory stack for its execution. Because this
zero-length infinite recursion rapidly cascades without consuming any
input, it instantly exhausts the JIT's memory block, resulting in a
fatal stack overflow (or a PCRE2_ERROR_JIT_STACKLIMIT crash depending
on your environment).

It suggests doing one of the following:
1. Bounded Limits: Ensure libselinux sets strict match limits and
bounds the JIT stack size explicitly using pcre2_jit_stack_create.
-or-
2. Fuzzer Fallbacks: Maintainers sometimes conditionally disable JIT
compilation inside the fuzzer harness itself. This forces PCRE2 to use
its interpreter, which gracefully handles the recursion limit and
returns a PCRE2_ERROR_DEPTHLIMIT rather than crashing the process.
