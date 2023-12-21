Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1015CC
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VyPo2C2r"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e745891a69so3328287b3.2
        for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 17:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703122835; x=1703727635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TD04jn85uaYcWLh+hOc316Ktqs4AMyHwGfySsWA/Y4=;
        b=VyPo2C2rLV21d36DlyuKPhNd60nbQMxYlUdwRnWbK1E+5RTf0uufhNkLEMMpZBLgeh
         dbPJZF0OS+U/rxAdOgwL/7d4D+mHukr8W0yHagB4uNwva+F+rIzbisCAXSlFv1wsqFAP
         4lrpQVEBtUZdFWCrE/eCnikJMu7Oc9MwtW9YKvqcjSO8xSvKNGfJKNbBntHGOhCyWLRy
         12VI7SjNQMhPoEyQgLY6OAI/XJru14ExX8p1mlfWM7IIfT+F2ADJ9JSVCG+UmZT7UTm7
         6tLaoi81MdcwRcLLDFC1ccs4ZqIoPeBGrPluwyTCRQsTJfwmIQcqojyfd2owN58sBhud
         81mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122835; x=1703727635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TD04jn85uaYcWLh+hOc316Ktqs4AMyHwGfySsWA/Y4=;
        b=o1K3fA22Z1KHWvQxN7D/OrFAeep+zjnE5zEQXlIzNFluEG1s/AS0Z1Vs71zB6FGmoY
         MFOIQ/5Yx0Z2NwsH8INxDOaCpb2c4SbeGV86ZNQ6WjtT6uvpl9wFSXhWHm4xWP9orTQ1
         f48BOXEBljwuj86IsShprYRePWrip2LlTtxVN1Cu6vqU6sfDfLOvyxVjz6Im2FY57eHm
         yJO9UjWp+zACOs+IjO+Iq+e62FbjlL/TBbfN+ZM6/Hulvj4KwC7snZwA+OfWvopCyy6w
         qjQ6DIAXJsJX7dznvaswsKAKpkY6EcRsTLW61yvr/VPDy+FI/Bu7WkE6En9bAoEm0+Ty
         l40g==
X-Gm-Message-State: AOJu0YyXVVXkC0d0fMp4gf58InJUkIdDGxs512h2/RBFAKA2gdrxa/jn
	W1UM8R+//a32cSHnaCjR0d50LXtMzFVT1hKThV1v1VYnFlweeOAdDw==
X-Google-Smtp-Source: AGHT+IGj3uBdXb2Q1/pUzgvczrjq86FHoil0pcHP0VUyHCqQe5cFvZmgGN1Vg3lxdybm8RMCWIZu6/vVyridSC4nmF4=
X-Received: by 2002:a25:ae11:0:b0:dbd:aa7b:66a3 with SMTP id
 a17-20020a25ae11000000b00dbdaa7b66a3mr523143ybj.116.1703122835338; Wed, 20
 Dec 2023 17:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024213525.361332-4-paul@paul-moore.com> <20231024213525.361332-7-paul@paul-moore.com>
 <3717b995-5209-4db8-be77-c6303bb1c0db@arm.com>
In-Reply-To: <3717b995-5209-4db8-be77-c6303bb1c0db@arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Dec 2023 20:40:24 -0500
Message-ID: <CAHC9VhSABo8PO0q0EUSw7uh+r8CjPFTwK6DJk8Vs4oDcckPwHg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] lsm: consolidate buffer size handling into lsm_fill_user_ctx()
To: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:31=E2=80=AFPM Aishwarya TCV <aishwarya.tcv@arm.co=
m> wrote:
> On 24/10/2023 22:35, Paul Moore wrote:
> > While we have a lsm_fill_user_ctx() helper function designed to make
> > life easier for LSMs which return lsm_ctx structs to userspace, we
> > didn't include all of the buffer length safety checks and buffer
> > padding adjustments in the helper.  This led to code duplication
> > across the different LSMs and the possibility for mistakes across the
> > different LSM subsystems.  In order to reduce code duplication and
> > decrease the chances of silly mistakes, we're consolidating all of
> > this code into the lsm_fill_user_ctx() helper.
> >
> > The buffer padding is also modified from a fixed 8-byte alignment to
> > an alignment that matches the word length of the machine
> > (BITS_PER_LONG / 8).
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/security.h   |  9 ++++---
> >  security/apparmor/lsm.c    | 15 +++--------
> >  security/security.c        | 55 +++++++++++++++++++++-----------------
> >  security/selinux/hooks.c   | 42 +++++++++++++++--------------
> >  security/smack/smack_lsm.c | 23 +++++-----------
> >  5 files changed, 67 insertions(+), 77 deletions(-)
>
> Hi Paul,
>
> While building the kernel against next-master for arch arm64
> > security/security.c:810:2: warning: =E2=80=98memcpy=E2=80=99 offset 32 =
is out of the bounds [0, 0] [-Warray-bounds]
> warning is observed. On some other architectures like i386 and x86_64,
> an error is observed. > arch/x86/include/asm/string_32.h:150:25: error:
> =E2=80=98__builtin_memcpy=E2=80=99 offset 32 is out of the bounds [0, 0]
> [-Werror=3Darray-bounds]

I believe the code is correct, I'm guessing this is simply a question
of the compiler not seeing whatever syntactic magic is required for
your compilation flags.  While I'm not entirely sure of the "[0, 0]"
"bounds" in the warning/error message, if that were a
offset/limit/length a double zero value would also seem to indicate
this is more of a compiler annotation issue than a code issue.

Looking at the lsm_ctx definition in include/uapi/linux/lsm.h I see
the following:

  struct lsm_ctx {
    __u64 id;       /* offset:  0 */
    __u64 flags;    /* offset:  8 */
    __u64 len;      /* offset: 16 */
    __u64 ctx_len;  /* offset: 24 */
    __u8 ctx[];     /* offset: 32 */
  };

and given that the offending line of code is trying to do a memcpy
into the ctx field, an offset of 32 looks correct to me.

Suggestions on how to annotate the struct, or the code doing the
memcpy() are welcome.

--=20
paul-moore.com
