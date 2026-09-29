Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A98535FD9
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699504; cv=pass; b=IKtTAMdSYPs3KKKs84jf1rVo5CZkVLu7sO83MP/qn7qDxMlbSl//XMAWOj4KE6Qn0xmuJJ+/sGGOMkDqh0ogrrJ98tSok0uYFkU93pVDm0iT9+r4X3xF7DIhLC3Okr0ZbPsqk132AsXr9aC9q69897dC+6NaUrv0RF1EP6bcju4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699504; c=relaxed/simple;
	bh=DT3dgieIvD1ZA1s++psnGtBZtqiLRi3pMAkvk75uU5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqSIbekpvVzoFNHrnKEKxwNOQp641B4dFEnra5VRZYEwH41mM5IQ36KCtk9LYF1lAD8A/8YOQB4vng/AMgT8X0sR48WqKvLd+8oG+SBa3TF9h1ylCEXlU3AilGJjnzyngMv+pDGyroqOFckQvdCZENOm5wW8GSBhXliOO94/UoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD4D6zYq; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD4D6zYq"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8abc87cbd93so997547b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699501; cv=none;
        d=google.com; s=arc-20260327;
        b=g/EJBVddvXgvKnd1zb2/Ektndhk/OOdGqTNZcJOr4dhdISx88ijb7156oCyDJziP0V
         H/vqC8Sgf4IlyGW2kWJ+fi2S9nSwOSQgbmbomestHno0sd4pFyta75PQ8in+14ZmSEi1
         eoSpclMRiRHZcxEwx4oSxEJG+GZPBnfrTNo9izrWmWULtHciXx5cvgZ5kqkrbNqkPzP9
         fPFn7XsP5FIZk8l3UFUilzf0sTuY5Q7YpG9ugT3YdqXB0mW/+XEWw+kVKqyNxA+CYQa/
         zOHrG3oCElIYx74c1TLPHaj4RBtRMN4sgqQ40sQZiH1nQC+MmI7eRV8wFgfErEgm8mcJ
         gweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZzbpKhoPTjSJPEhhpl9bazO4DKqlYAHhYExsE+9/vnE=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=TtQ4v5rs97TfZuyYCuWwbpEOg00XFyHFhlYe1vq6cxj9R7swrSZlgTchDMQ53em4yP
         JgOwvW1tLtzULya3+VryN+2+B1k0B1Moib9v/j3XsvD79CXQwN1+ag8SUY47KJ/4/mbt
         KwZ/L0Z6SWe4MSDJFSnQgRfKwH5QGt41oJdxWDv9cvdMzshLCeWeFzd0UCtX0plZXtty
         rlYN+hV52BtJVcB2Y4srPNTh2dJ/1MQ7jiXsa1vZ4hej2suPoVZlRCobvZCgigKBzPtz
         CLhtXOjjC8ZqGM9hn76EBtp4LpLkduqb7hlP2NW44TmhVFQMS0bPHNW+EghgOIScBvhN
         6cUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699501; x=1791304301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZzbpKhoPTjSJPEhhpl9bazO4DKqlYAHhYExsE+9/vnE=;
        b=gD4D6zYqRMjS8o95IukhXwFJgFbjNno7W4n8RJQda+K5HQoSMmihhmC4QS0/i7/+Xe
         ZGINgf+UisZNHMvaLsKvaRlZjIyYDdwbzCg/mbKsTP67JhUc+hv2f71mMBzvrgqCT9+1
         y4fq5uDsgD0SH/3bGQsEUf2tGe+heCQ/NAHFCczZnQg5cfPxeAkSGzw8dwLpocvPoWDm
         QBGV2kyUTkcN+RUCtm6RSiGr3Iy9FWnSbO9e/fn6tFhEiYpoC8b/g2BywYg0B9z1Gaxt
         6v/cvExhTCpxNBy/YLzLCOe82e5RCvc1tj6OqJ4XbSGTlcWgI4wPxpXAmWkejbLkvti0
         //Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699501; x=1791304301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZzbpKhoPTjSJPEhhpl9bazO4DKqlYAHhYExsE+9/vnE=;
        b=RfNE0Eo05CPytLa8DRUQkRFC6PTaLoTX+j5mD+VzktFP2jTdFaUBchJP9nzjnIDibO
         m+IEmEcpl+WCA2Y3i68230uZIX6ilO06uIMGKpQKy9ezOmztYetR3V0yqzoaug0h1XB/
         U9OiKY4YJHnT6saRN3OBIMFaWhzBiSzst23LfC9euoCnzTWdBTO/JZbjs7PBWd+dlMcD
         hIjuaq1SM2xyPOkquIvFM9gXYTuO9TV+Ya68Oaz88J48g7933QPbKYEMe4+muqa0J35G
         T0nneY6YGdcbzfBuErCWEhWnhsDWYEQRsf0tXXREU+81S+aOeoYORSu/59l23KNr3SWI
         VZ6A==
X-Gm-Message-State: AFq9FYJO1Z7gVrcrtxXjSGPxM1k02TYMtrTWwwnrpil6CbSiOpMYk4zE
	uo1pakCAaLwRvBa4+c5G6gTCtZ3E6Li8kbIu2y8oAwSSgF+qYo3SyA5rgzF+bMkBFGg3WV1vC+j
	NJCicz48BPaEE9QsNKzXBqalC4H3f++Y=
X-Gm-Gg: AYBFou1pUNgR6u4+l4kRDGoIhmkkEFIT0HorgU4dcmBKU2avlSmU64UiYZsrz1yd5f7
	k8sMlnqCFiixwgudpYqOqX2pbqvJTtL6vGxI6F5/3zM4qjamOYpR4hLhZfo6ypZVD568aEl4DFk
	xPZ59GajKP2meL6ZBNMZms15EDB3k2jcFkOHYIFFHqWqEnSXM5KaZKdtRz4yWHoRu5BuC+nLTIE
	Djg+9VDqzFzQsC1YO+sZ3G0p6u/Ke1QhgoHHDnZC/1/EDsguTEKJjTYz7puI5kkJ/6ne+E4rqTF
	5fAYOlu4ChrvnhEC4yQlW7cyt+8AGMrz4SNTo4mURlVZMk/OeuinnLA=
X-Received: by 2002:a05:690c:ec7:b0:873:5c0f:285 with SMTP id
 00721157ae682-8a64bb2af1fmr93478027b3.47.1790699501603; Tue, 29 Sep 2026
 09:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-18-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-18-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:31:29 -0400
X-Gm-Features: AclHuK-liZp4VJ3NNZWdigqzND7iZ15GAWItQbzZTy2yRoHWq8-riiLA7AmZstw
Message-ID: <CAEjxPJ6M+HteCjkmqk7WkjP8yoJ3n6pib-kOBpuG5LOMRv959w@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] tests: test code tweaks
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:06=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Be more cautious on unexpected failures and input:
>
>   binder
>     Avoid returning garbage value from binder_parse() in case of an
>     unexpected (impossible?) empty buffer.
>     Store create_bpf_*() results temporarily in an int to actually
>     perform the error checks (they are currently no-ops on unsigned).
>
>   bpf
>     Initialize variable in case the program gets called without the
>     associated option.
>
>   cap_userns
>     Use appropriate types and casts to avoid implicit conversions.
>
>   execshare
>     Avoid use of void pointer arithmetic.
>
>   fdreceive
>     Do not call non async-safe exit(3) in signal handler.
>     Drop dead assignment.
>
>   filesystem
>     Initialize variables in case the programs get called without the
>     associated options.
>
>   inet_socket/unix_socket
>     Declare usage() as noreturn to help compilers avoid issuing
>     inaccurate warnings.
>
>   inherit
>     Use a large enough buffer for a potential huge PID.
>
>   key_socket
>     Avoid comparison of signed with unsigned integer.
>
>   module_load
>     Correctly check for an open(2) failure.
>
>   nnp_nosuid
>     Check if wait(2) succeeded before checking the child status.
>
>   notify
>     Check if opening file was successful.
>     Use appropriate type for read(2) return value.
>
>   prlimit
>     Set all members of the new limit structure.
>
>   sctp
>     Use appropriate iterator type.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
