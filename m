Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77422183CAD
	for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588301; cv=none; b=n+I5+BYhwk0Sqpi3++I/JADFiGtOABBo8zI6lJsP3H/ON2y36Oe19xdeeesuaPDXOZJ4EVDTXP1LwAV4VOtook5H5KNrCFkcBGzFryOH675D9Igmwbczhn/W1UPBnEWW0eTZhS4rSWeKJR4uj6Mrq1QojUnPHZdfCRktmxuFu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588301; c=relaxed/simple;
	bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLNwgaR6zyAHOYr2gkieInoOn7RHpiNXM+bbHk6tWzVoLc2HusXyt/KfE1GW/eOFsxp6Ncy1VeNI2jcEZ5cc4bdwJW9vNDP4sGRUcymUjSObqCVeDZbbhczY9ObmRYEU5B7V4kaTx0mGIkk8lbltpy1Lo/Ht2MdtiFz/CU1Bo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+j9ex3p; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+j9ex3p"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-493e8ef36b4so2231765137.2
        for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723588298; x=1724193098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
        b=D+j9ex3pJWeRWjq0NBYRAHJ12rIjeopGts0r0GTgjexMWWliauckLTij+u2/DtqaWn
         IPQXwFUz1MUSigu0oPStUaFqzldIUc6ZItrjzNZ/XMk8CJsMoIBgaw6AdgZAnuJ74Mif
         HxjrmmUY7YEzRN4Age1V1a/oYDZTMq+Ml6HWBArv3qWfb6CB9PbAegBWfG+qzwhxG1RQ
         8SxkWeeBd79wsXNDRQvBmgxkybLm6z0e9rqqFzohuML5RHyHVhs4s4sDyHpNo2DNY+wi
         +Uz/c6UKDHSB47b66QDOI2Pe1KXWo0XtrMjFe0TmfKB0ldc351LTEsWBPcRG8r1WJ/Bt
         079Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723588298; x=1724193098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
        b=J69PB8CoT4g2qTnYkGByYAvcxrfSG87sa/hmH0GRuMvMyt3wUJmbJNVR+UULIpJlGi
         K+9krT6toJMy2IVbJ5Rky5oKV00YIO72l898qeiItsQnYldOd2spYEjaMPn/jQQQ3XiO
         nDrTfvsdmeFca1UiUsg77OgckkbflViTNjEZXkrS00Qb5FRu8oJtXtfH3pcloY8Ngzq0
         bvnmITevowT0NLurHmNwFmCBNgoBWgyEhqug3qDXEd6elRmG8q6v8WTXKnaDpXTo1/28
         fq8vfr+gsXXFYQ+MpOC0VDDYHpVRruZhm1Hbn1b3uLynMsA7XZ6TfMmH+H5Jbb8BBVpJ
         Rmpw==
X-Forwarded-Encrypted: i=1; AJvYcCXDjKwcCyhAJH8mE6n2ndGK2yaO8XpCll6ntsLjkZ4t9kS7j4bJfhfJNi6H4JQ6N0enrmgrrddPcmajQyLMGDItfCbLQTabzw==
X-Gm-Message-State: AOJu0YyIS2wvCOs7ct78tVEAkhmCKzE+pt1cFZchPt117oLOJEHHW9S3
	JKFuk1ISe5vKU73w45+NBJlkdFMMtapgPppXveww6CzsP6FuRhoTCOmc/8/HWcSgsjCSLGqfo+c
	CsalqUmdwc6dEVqE0QvVKfMiO4PGghb7cnCjq
X-Google-Smtp-Source: AGHT+IH/QraxU2fjWjOPkx0WDZKuaY29L3Zen/pzf+3bC1KTX13QSkaN1GEjq4vqJeNmusG+MLJVL3jxUBZoAMXwy+8=
X-Received: by 2002:a05:6102:c04:b0:493:b4b5:4850 with SMTP id
 ada2fe7eead31-497599e9a02mr915097137.31.1723588298200; Tue, 13 Aug 2024
 15:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812022933.69850-1-laoar.shao@gmail.com> <20240812022933.69850-8-laoar.shao@gmail.com>
 <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
In-Reply-To: <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 13 Aug 2024 15:31:26 -0700
Message-ID: <CAFhGd8oBmBVooQha7EB+_wenO8TfOjqJsZAzgHLuDUSYmwxy=w@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] tracing: Replace strncpy() with strscpy()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:19=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Mon, Aug 12, 2024 at 10:29:31AM GMT, Yafang Shao wrote:
> > Using strscpy() to read the task comm ensures that the name is
> > always NUL-terminated, regardless of the source string. This approach a=
lso
> > facilitates future extensions to the task comm.
>
> Thanks for sending patches replacing str{n}cpy's!
>
> I believe there's at least two more instances of strncpy in trace.c as
> well as in trace_events_hist.c (for a grand total of 6 instances in the
> files you've touched in this specific patch).
>
> It'd be great if you could replace those instances in this patch as well =
:>)
>
> This would help greatly with [1].
>

I just saw that Jinjie Ruan sent replacements for these strncpy's too
and tracked down and replaced an instance of strscpy() that was
present in trace.c but was moved to trace_sched_switch.c during a
refactor.

They even used the new 2-argument strscpy which is pretty neat.

See their patch here:
https://lore.kernel.org/all/20240731075058.617588-1-ruanjinjie@huawei.com/

> Link: https://github.com/KSPP/linux/issues/90 [1]
> Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu99=
v7+b6AyHMmaDFA@mail.gmail.com/ [2]
>
> Thanks
> Justin
