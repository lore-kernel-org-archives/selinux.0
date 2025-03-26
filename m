Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F42561AD
	for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018041; cv=none; b=h9Eb/fIxpYvKgRfMAKvwOwOacUoaPyoswFa30AY4uxLWq2nbGVw7uXpBstg1rh3HVTGNUpD5tgYWPFJawcnJDc9r19103LIbwF3UL6UJ8c3mxT1Np23hdKdhc+ILAVOPvh8bdnD0i9i80D2Eq5X5IDFYKyGcrKDhOxpSxW2JcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018041; c=relaxed/simple;
	bh=6JmmSbRQ8MpL+89HMfAzj2vUP7QBs0D+i13dt/VsGmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFosiIxoeqfShy+mhshLgAvgC7wozsriv8q0ixs0x0WIs9hgMgEeUFhxpwdM/IVuu+jeELahwN57grYrvJExL0XLpzU+yu82QYxiyEaQpjnl4ModKQp1bGV+Oe9CrIIwESkKu54xMPiIVxnjW4MRnvLuRcROhMOwSeCvvR/rjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HE+O0om6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HE+O0om6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac289147833so38398466b.2
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743018038; x=1743622838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTnx5GpAo0KL0E3TtxHMmgaX5DlYUN52FQs+TSmcpSY=;
        b=HE+O0om6XXscKJ1Eyy6+Te1vAc5UmTqb6RZ+SpNe4FfuAdV0KJZcavirlDa5QvYP2s
         OZRi53gc8rUnj/64UKt5sIjj+m3TxBjOnbx9Y2NxO4JEVGNVHLXcuNiZ0lbaybzlmrig
         F4cGUrqCwiPV2b77Et8B5QRmOMhAt7pdgbf4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743018038; x=1743622838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTnx5GpAo0KL0E3TtxHMmgaX5DlYUN52FQs+TSmcpSY=;
        b=MWyFIXlpDH4scujsA5AWE/dO9dXIbuYFCY9obRmfrOUnK0m4Lwy5LW9qGr5qM428oo
         E5Ug3MJKXj3/upgGGzn3iSg7eagMHu4moZm7LSqLvcj70I/UPHFOYGr6eJBb9YpO567y
         AXtGeWQFS+Dt8KSYtGpILlSKT+FH9vStitRy1rlT/mbVZeFlEuoMBxvcb1bf3n8b2613
         1+rHxkxX2qY+dTWJOjSyAZZWNRe4qm3h2YpTB5BRR++wFC7rvWrOyb4wXF09Cq3ZQsho
         X/FxbrZiO3WWpebcXSQ5ciuvmdHaV2qxRoeh1xP7LfUPSCqP3Zz6jifq/F/AUyJkxK1N
         SmSQ==
X-Gm-Message-State: AOJu0YxqeocWhrXA+6fNJuzkTf3/Lx77f0bGrkKyIuyzcMxJOtQoJW3k
	9KaBEjyG2/jFWlcBwqBJ6ZnX5cNK5LergNXKLejwlsk/MS0Hn9szQ9I7xb8jzv1rfbUHPf8Lyby
	0MlLtcw==
X-Gm-Gg: ASbGnctAVyDDAuprRj/IOQnllOXTJ7QoawLVSjT14Fc2qo0/U1B90tR9xgljTqYyROZ
	DWTEng1RqFR3IhRdBIueUqghJJMMQMrkh8b4GCK9P+0c6or70c3Q5y1etKb4QgkFxd7cZ75jyMm
	c/y/AvYBjT9AkIZCyXzBVQLfuybofthhNf1jHGQuZACGyRJRHwHbnSAJ0XcnkSPLudsF6vnlRco
	EkZwEoa1cbEAUs1ePh/841Ef8qjV7pHpc0cj4L9hJvjXcTQuWITIg9KF2sq+lXlEhQp8HrawWAs
	EQqaCT5QAtq1det3DoEwCY4bqApgQzaKIJb2c0PmJfDdJa6bSeVqwmhNT1DqBqX2pU1WfhxMAF9
	8vVQoNhteKzNZfKQtOic=
X-Google-Smtp-Source: AGHT+IE2IEF2NG2oSsNsSa+ZOSqnGNxf0xh/g3AP92MgFaHrWRl8xCSmM3D8prC7+Fh+F/vQo1M26Q==
X-Received: by 2002:a17:907:1c09:b0:ac2:dcb9:d2d4 with SMTP id a640c23a62f3a-ac6faea171emr53457966b.14.1743018037576;
        Wed, 26 Mar 2025 12:40:37 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e51c8sm1098420066b.66.2025.03.26.12.40.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 12:40:36 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so30219166b.1
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 12:40:36 -0700 (PDT)
X-Received: by 2002:a17:906:d553:b0:abf:641a:5727 with SMTP id
 a640c23a62f3a-ac6fae44e6fmr66686466b.7.1743018036263; Wed, 26 Mar 2025
 12:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com> <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 12:40:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
X-Gm-Features: AQ5f1JoV2NGzR0LooAp6oXwmVVp2SH1Bo3tIPZjlGoykS6sG1BTk0PCL13rM5D8
Message-ID: <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 11:36, Paul Moore <paul@paul-moore.com> wrote:
>
> From my perspective this is largely a continuation of our discussion
> last April, and considering that you ignored my response then, I'm not
> sure typing out a meaningful reply here is a good use of my time.

What you are saying is that I have complained about added overhead
before, and you aren't even willing to explain why new code was added?

> Anyone who is interested can find that thread on lore, unfortunately
> much of my response still applies.

That thread was similar in that yes, it was complaining about extra
overhead of the lsm code. Not just me, btw.

But your respose doesn't make sense. I asked for *why* this was added.
You're saying "I am not going to answer because you've complained
about other overhead before".

I actually went and tried to find the discussion on the mailing lists,
and nowhere *there* did I find an explanation for why this was done
either.

In other words: why were new policy entries added? The commit message
and the list explains what the commit *does*, but doesn't explain
*why* it does it.

I'm cc'ing the other people involved, exactly *because* we've had the
whole discussion before, and because I want to see explanations for
*why* new policy hooks are added to the security layers.

I really think that "policy hooks just because policy hooks" is not
acceptable. And the reason it's not acceptable is exactly the fact
that we have a bad history of various random policies becoming
problematic over time.

There needs to be a *reason* for a policy hook stated. Not "there are
no matching policy hooks".

And I do not see why firmware loading should be a policy issue if the
kernel code that initiated the firmware load (ie the module load that
*was* checked for policy) was already done.

Do I believe this particular case is going to be a performance issue? No.

Do I strongly feel that any additional hooks need *EXPLANATIONS*? Hell yes.

                 Linus
