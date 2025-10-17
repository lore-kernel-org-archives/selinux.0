Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897221B9F5
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705502; cv=none; b=pcxb+2U0pVMnwdJkiNkk1tap4rJmIBiVM0zClGa4ERY3Wm1i0q677Br4T9H26+SW3rHClqLspuY7BHV0/+LE84B1oq3ISRSHwfjBzDO4MGN4sqeqAgtfuhkrIq5lSY8Fum2qwX86uiV2roqvg1MbazEnFbTfjSyOd+DmtSH3+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705502; c=relaxed/simple;
	bh=nw1q6XjEZthV/4GvzKWTqqzmQB95A1Kmppm3x50pB7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjkeqVJsp2XIMiPdXu7XmdyYz9Q9az26EMttYH4QA/Y5xGNyacd7BXNHiLZsn+olCBBz2vngdDhq6UWC5UAjFRJTPximdVKd7NxD00RQCwLlY2m50Srux6DTbeBWIgyIQCt1Cq5aQDH+NsAp6fR+6NVvVxTciRHscQb0Sd4kvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNCyndIS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNCyndIS"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so1797740a91.0
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760705500; x=1761310300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9PAP0oNqfBmZk7Xls+7KWnm1BnehRB3NEfpkXUoujE=;
        b=kNCyndIS9Fh1QvEukDd7p3fEaKMCynVMl0VXRMoftXtolHTHewiV4fs8ilsqGlMWmB
         N90nStznQE35cbU1aluTzmKIIiOq7pHVc7rNssBm0GBii3eeP+f7EOWRdOXrRBBRAzwg
         hA+9VDZ5Hx+33RVyqZtbvo1SdZjmegC2/L05lQtoXUSIAJXf/cZeMMCoMw1WEYZBiFnL
         wbLQ9RwO0gijikDi4Y0eGa+5BIDu2txpwiAPbKEvSuJS7KK2frf2KcQ+FDpzFR2dBp3f
         tGfliFVwUo2HslHnerwOpWeXlazAob59l2+lMO5k02tahx43ya0RL8EQxDMHj62A5+n2
         xccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760705500; x=1761310300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9PAP0oNqfBmZk7Xls+7KWnm1BnehRB3NEfpkXUoujE=;
        b=fmJ37O2/u04ZUhU7i1ipHrDMVbQuHYpwYiqNviEf0UT+eZQ0E1Fh4gs+IV5dQL9Se6
         Yhg6lWeE0ToU+oyXGeRcujmr5edERyXraRIrgXBohrWRCTfqLE5G+uCv9s0jlFEwSexg
         xfBY39Jvx9g9uvDSp5F45GGUek3LIfn//dio3/iGFCpNKJ/Akgiv7eEAT4jp5r7g5W16
         mq0wE4vkrv7idcy1k7fJBqUf4vC5PNRSTnIvQ1IVnTP4qa8K3Z/oFstUn2jjLptC6NT6
         mPwFRMjAb/23RWqiZmQmUFAM51y6sOo08/tDIP3Iux3gUtctAOldKbNehjPxrWj6xseB
         fxIA==
X-Forwarded-Encrypted: i=1; AJvYcCXGKva72X84vP8AbCsjdNOTU5JxIBX3PzK++XlZ1bwsjk8cOP6LjEjfAlpC20eSUrADeOa10G0P@vger.kernel.org
X-Gm-Message-State: AOJu0YyGgUyAKSp10qih+sya7MSCvdikpRbOVWIMM8CS4Zjvh7BbU/MU
	LOwab58flQo2cRAMLIXXhiLIn7cMo7IJNgXP7xJ161V+Z/HYCPKp8FuD5XQIV49706K3+ruS6nv
	t9xfPzREb+WTlnDotK4zMp391OS18BHc=
X-Gm-Gg: ASbGncv/ojwir6Gp+9Xsa8k5tJ0Km6+QJ+IoMComCV+FWbpPj0D4PHozvT7OkF+/2hN
	lo2Z90B6Tj6NpENkJAVhpiUUJ9Yx+cF9zbBH4a6WiNmg0aqKLpMHg0n8AxQ5mLnT4QjmL2krUtN
	jOMxFcS4OyUn1OmSula2pAEWwN9A/z8iRObi1ajMKFj9+HWgaDYpX7308BsbJgYyDeS873ErJ5+
	kOSJoh0Qg3RAYh9pG/dX1ID4E9svdUkDfZZA6zAKWZlAsOeOERg8pGaD6YAwN/wGCN1bT4=
X-Google-Smtp-Source: AGHT+IHNjZILAHnGhhjWsGWJRZD29L3kVQW6hnoXUZARaXDfpfSBLy9aESnW20RrrluP0/qBqdypRNaIWtHDRNyyx/s=
X-Received: by 2002:a17:90b:3d87:b0:339:d227:82fb with SMTP id
 98e67ed59e1d1-33bcf8fa579mr4478997a91.26.1760705499734; Fri, 17 Oct 2025
 05:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldln43to.fsf@redhat.com> <20251007104656.479127-1-nvraxn@gmail.com>
 <CAEjxPJ5cMQb2DE37BnzrDQYars8eRfe4VSfN_4mwRQAhj2nW8w@mail.gmail.com> <DDK3662P8K9T.RXDV7DIQFPV1@gmail.com>
In-Reply-To: <DDK3662P8K9T.RXDV7DIQFPV1@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 17 Oct 2025 08:51:28 -0400
X-Gm-Features: AS18NWAJ0v0YYvC6z8je3jtkdYBbvw6z3n81Syt9Svh4_k3XHrVzcSf0RMZ1d5Q
Message-ID: <CAEjxPJ7y=scNU61+TLMXNMzrvxMbkUdB5a+drAM7gqg2z02POw@mail.gmail.com>
Subject: Re: [PATCH v3] treewide: add .clang-format configuration file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:05=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> On Tue Oct 7, 2025 at 2:21 PM BST, Stephen Smalley wrote:
> > On Tue, Oct 7, 2025 at 6:47=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> =
wrote:
> >>
> >> Currently only an RFC.
> >>
> >> Add the .clang-format configuration file, taken from the Linux kernel
> >> repository. We don't have any official style guidelines in tree at
> >> present, which makes it a bit unclear how to format C code for new
> >> contributors. As well as this, different parts of the codebase seem to
> >> been formatted with different styles on occasion, so using an automati=
c
> >> formatter should resolve this.
> >>
> >> As well as this, replace all the existing indent targets with format
> >> targets. Commands used to find and replace those targets:
> >>
> >> git grep -l -E '(\.\./)*scripts/Lindent' | xargs sed -i -E 's@(\.\./)*=
scripts/Lindent@clang-format -i@g'
> >> git grep -l 'indent' -- '*Makefile' | xargs sed -i 's/indent/format/g'
> >>
> >> Also add some empty format targets to Makefiles that previously were
> >> missing an indent target so that `make format` does not error.
> >>
> >> A few other things to consider to do in the future:
> >> 1. Reformat all existing code. I understand this is a big change, henc=
e
> >>    the RFC, but we may as well get all code formatted if we go down
> >>    this route; afterall, it's not like this will cause any breaking
> >>    changes.
> >> 2. Possibly add a CI target to check that all code is formatted as per
> >>    the new clang-format configuration? The options `--dry-run` as well
> >>    as `-Werror` can be passed to clang-format for this.
> >
> > Yes please.
>
> Should this be added in another patch? My concern is that CI will fail
> should this be merged without formatting all code.

Yes, we can wait on it.

> >> diff --git a/mcstrans/Makefile b/mcstrans/Makefile
> >> index b20279ab..28d8c7bc 100644
> >> --- a/mcstrans/Makefile
> >> +++ b/mcstrans/Makefile
> >> @@ -21,4 +21,6 @@ clean:
> >>
> >>  relabel:
> >>
> >> +format:
> >> +
> >
> > We should add targets for mcstrans/utils/*.c and mcstrans/src/*.[hc]
>
> I wrote a simple check-format target in the Makefile:
>
> # We shouldn't have any unformatted files in the repo without an explicit=
 exception.
> # Given that this is used with the `check-format` target, which does not =
modify any
> # source files, merely checking if they're formatted properly, it's fine =
to rely on
> # find to get all C source and header files.
> CHECK_FORMAT_SOURCE_FILES :=3D $(shell find $(SUBDIRS) -type f \( -name '=
*.c' -o -name '*.h' \))
>
> check-format:
>         clang-format --dry-run -Werror $(CHECK_FORMAT_SOURCE_FILES)
>
> However, after running `make format` and `make check-format`, I noticed
> a whole load of failures caused by a load of other missing targets. I'm
> thinking that it may just be better off using that same find command to
> get all c sources and headers, and have a single, global format target.
> Afterall, in pushed code after we've formatted it all, I don't see any
> reason that some code should be left unformatted (especially as we have
> things such as the clang-format off comments for specific sub-sections
> of code), and while working locally if someone wishes to format only a
> specific globbed set of files, something like this should work fine:
> clang-format -i src/*.c
>
> Thoughts? Suggestions?

Only caveat is that the selinux userspace tree is released as separate
archives for each packaged component so downstream users might not
have the top-level Makefile.
But I'm fine either way.
