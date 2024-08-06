Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA657CBA
	for <selinux@vger.kernel.org>; Tue,  6 Aug 2024 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913813; cv=none; b=kL82PmuuzZd7edM9fVOcZDoeU8j8nahE3O26bBWv1/0c+z7let0d1jYPj1iZQYTIVwuzOQ4kYgVgPTredcoHZebJuZGC7PyX/v84wDB9s4uzsEMGkMfBs3cqunCiqgGZaWSkYCMnL5QPi6QuKSa2EcO3wCoUMBH65HWE7CQg1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913813; c=relaxed/simple;
	bh=M8lCPbpz8MJ7MmX8w6ySSM335BKWQPUYdlyNM4pcNL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/yfMsE+UMnAWCrdJtGTrxHIGok8gijREnxQhmivWym+ZihF1VbeDaI6nY35R0wd2WP6NLbPx7Svh9uNC4+N+Y3MpEJik/XQy1gadI1gIPqev4vyrTY/OPoEW7iQpS72aM27eGZQlQoQSTitX7vpTdGRpyxdWzLdPs79pJ0Rtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AqIjGFxt; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AqIjGFxt"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so1273951fa.2
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2024 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722913809; x=1723518609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=AqIjGFxtM0nFjNXxOr7KDYCUIJeYxKS32lAgjemtmmhh9bvx3RgcyRhtpne9s7jhkw
         8JaHUpJqtcDLArsgJamUrkgkrJQk/mdyXVPUbfOYS9kY5bzsrpUHWNPaW1nz9o9qGaEK
         HB5VZVGmFKgZ0VFV6k1d4LmCh5BFz3eqoS5cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913809; x=1723518609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=wEAxTCI0c2h5I3XBv4p3W4LqyqQQYfqq1jHt4eECdi1e3xBReUGXZQ+fVtgBCPwbzz
         Bsc8dgXKY+DUGEYAYzGMK4Joafcpo+O7M5gIE/E+Zd27zOsRuujzOPMfCmdMXy0Utfko
         UKG59RrHOyf4ZNKx4+kH/kMGTvzv3sHtIs82kG/2HvU67Bc75m6PfEIOYzehqYINfUkY
         O2kHS427t3CJpL2flHIZqLrX+oCNNmwBpUJEwraAp+SqXowFEdyrZCvqKijqy4g20D8M
         cMfoPWfL4OCfRCjBMa/Z554w1tTF+4sQLwHvLLjSaAP1LlSYqZOnwpoebsR/mzVev+lY
         6psA==
X-Forwarded-Encrypted: i=1; AJvYcCW+FLI3ho/cOhyTdBkdeAgOVbAWDaxJtdJdY7tePl6eezASVbxR4fjDxJEfyP6Di6A6XYQGoY9Xwb4uXKk3Cbo5qcs8qIRRCg==
X-Gm-Message-State: AOJu0YyLPO0xxmDk6G01w9IqqkrWZc5JC6yjfT0CrrQhNPDw0Okr18A7
	Rxn27rp963MyEiw8NpB7bwfULd2x3aK60n67oRqbgFL1NtIAfjPT9t7rp7b6CXwfKsvGU1r6p9k
	K/9Yk5g==
X-Google-Smtp-Source: AGHT+IGj4IqAYKpwA9TLPUnWbYrbIAKlCrQfAXVcptm/2Hyx6XapCER8saL4gWK1YMWldbUBELQMEA==
X-Received: by 2002:a05:6512:33ce:b0:52e:9d2c:1c56 with SMTP id 2adb3069b0e04-530bb3b73bemr8937541e87.35.1722913809280;
        Mon, 05 Aug 2024 20:10:09 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7fe2fsm510994266b.178.2024.08.05.20.10.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso5245366b.2
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwYFPFpvXlL7amk7V7nKvg84KH1V+fWbzQkGGUpY5Z5siN4MnX31nN+ocfiR0KWT+cFbWbkIvJVG3G2d+MsGX+N/Gee+MNzg==
X-Received: by 2002:a17:907:da9:b0:a6f:4fc8:266b with SMTP id
 a640c23a62f3a-a7dc4db9f44mr1005005366b.3.1722913808064; Mon, 05 Aug 2024
 20:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
 <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
In-Reply-To: <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 20:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> One concern about removing the BUILD_BUG_ON() is that if we extend
> TASK_COMM_LEN to a larger size, such as 24, the caller with a
> hardcoded 16-byte buffer may overflow.

No, not at all. Because get_task_comm() - and the replacements - would
never use TASK_COMM_LEN.

They'd use the size of the *destination*. That's what the code already does:

  #define get_task_comm(buf, tsk) ({                      \
  ...
        __get_task_comm(buf, sizeof(buf), tsk);         \

note how it uses "sizeof(buf)".

Now, it might be a good idea to also verify that 'buf' is an actual
array, and that this code doesn't do some silly "sizeof(ptr)" thing.

We do have a helper for that, so we could do something like

   #define get_task_comm(buf, tsk) \
        strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)

as a helper macro for this all.

(Although I'm not convinced we generally want the "_pad()" version,
but whatever).

                    Linus
