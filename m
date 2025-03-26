Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682325F7AD
	for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023189; cv=none; b=iCA/KJEQpJufOL+/obM/F6BXczNFA/btx1KYsd2MpbK4uMIWXRqUzv4BnSs6BnfMUJzqMD6G96yd+BbM2r2xfrgISGVyH3baeWQHedB5HcGbSlB+maE54VKaJlFJABsr87de2ImhnbnNtU93H4ZUMvkLmGW1rDzcygR5kDgfS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023189; c=relaxed/simple;
	bh=rBOd0N7sw7lqSgPKAUfjO0c8aSqpEDqRGYRlPQCZwgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQBc52Oj82lUv6qgI2Gfqer+8K02w4ojdnUqxZu9i/1aBLzsLhVEWKq3LZbZFBTsJ/xZw/XdZG0jjG63OdZUwb7VQ4Rb1F37b/NLHEGzMGFPjst/N00v6lgtDBBc4Y/BIjdihHSl/DnwyoF64/hNmhbatWNRPgTQydlQR17YlXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S7B7usao; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S7B7usao"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so419273a12.3
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743023185; x=1743627985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzdIojrDdHs/8zIWGqiZCIGtqwEg8y5P2tmcwYv1zsk=;
        b=S7B7usao0A81kfX4snBkhwoBFIy7ggcLD35/0Ansmf/cddBLgIdmZjw55X+3uZaEOa
         bqqDJY92D8DBoDiLuPbcRT6KnJGG/sJwMbjdXudryla2eNlUfhp2/lJzezRSLASd4eCE
         Y7pAkItDXlpYnaiCawglmWhn7BBtc7+QmoZEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023185; x=1743627985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzdIojrDdHs/8zIWGqiZCIGtqwEg8y5P2tmcwYv1zsk=;
        b=XThdsFKFOqnvEKIHdk69WjQzce6zp6fAeDgWIXJtRJi1J+oxitqhmvBu48Ux9qg25x
         8SwGd6NJUIvYf/aI8CNlE0ldn+y2OEOjXFhCOYSip603v3qWj2bZl8tkRkeKYKuK5UBg
         PqmERDr3tCpxT8ikYMdlna+cAqdTRM6ZQiP+uYR4kuZfwLSnYmHKl9h3FLzRUQVij2z0
         tKPnfvRxc6VIZhOGJ+vnB2OVxtH3WOvngkAmJvnJYKHIRwXR8VxMWHrCjZ3aJV00Kdgb
         MwtQ++i7byOEnnEwAhb5TZGTr9GVFrqgxWAP36+eS+OTW8TyFYVSiW9PkcXEmJoNzSZP
         uDgw==
X-Forwarded-Encrypted: i=1; AJvYcCV05HrIL9Lu/+ELCnoA2A6txFcKj3Elj46oQqx6anMl+niz6wd2rlSffQaIq5udwArBgtWcMLdp@vger.kernel.org
X-Gm-Message-State: AOJu0YxMscG0OmqH//j+6bpNVaCVsanG8618SKp4Sb/dK2iIkT6X4JxB
	j+ENjdU6HURVJmLV/KQmVBqAvRPexi11KI7YgASxWXLJfrBdhd1tFwbRmhBczMwQLbR4ZMxFLJH
	lgWg=
X-Gm-Gg: ASbGncuOFMGjzxU2TUHWKbuYukplr7L0tPft4C8JwkDPi73zVzffKhS3NKRX7b6kt7q
	zPncaivjKgEtsoRg/u7siuS/zXywuAXYlxRLth7rJ+Rt5iHGgs1NwN4hDDgZk6RAN+c18dkqwIw
	W7k3KYB0QoDF2akJ+2QKQ5MkGtjBefxDFPhIyVVBpkLNpwIlr6MSBwEbyxk3/fj94kJDuGVan+X
	wcHFx+s8bJj3p9P4yfBvZYWbck5ctE8Ap9JrfnQ5FwVofKWnX6zsnfdk5gpTSkTXMOEo2dhfzIV
	jK4DPH41dWI+eHeTzZNY/c+wNQu1n219Ok1t1rpTMmuuMpHTkkISfRAyehsyxT7IP7YVI4XXfEi
	E2NOt/uTorAGnLXGGwCQ=
X-Google-Smtp-Source: AGHT+IFN4zQxRqHgkPlt+Zd+dXVeQUvQ4il6xRDWtCz1MyBA9YWOhw1L4tsKx+LWHcTdCwXPAfo3qg==
X-Received: by 2002:a05:6402:51cc:b0:5e6:ddab:736c with SMTP id 4fb4d7f45d1cf-5ed8e49b5d0mr1000479a12.17.1743023185076;
        Wed, 26 Mar 2025 14:06:25 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c7141sm9820286a12.63.2025.03.26.14.06.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 14:06:24 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso40217666b.1
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 14:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTUnbpMlTO29laCCswAQk1EFGZ7xP/f0IbGDN5IgO+SnVOMXD6aemPZKDbtRLmmRsGDvEhHS3G@vger.kernel.org
X-Received: by 2002:a17:907:1c27:b0:ac2:cf0b:b809 with SMTP id
 a640c23a62f3a-ac6faefb3c6mr77839666b.31.1743023183362; Wed, 26 Mar 2025
 14:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com> <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
In-Reply-To: <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 14:06:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpOP7o7v4OvVtYDIcepm7xWCMUr4sx6jgUkuQxGuRmvGQLwQrHUGSdEb-s
Message-ID: <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>
Cc: "Cameron K. Williams" <ckwilliams.work@gmail.com>, "Kipp N. Davis" <kippndavis.work@gmx.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 13:48, Paul Moore <paul@paul-moore.com> wrote:
>
> Looking at the pre-patched code one can see that SELinux only enforced
> access controls on kernel module loading

I *know*.

I've looked at that commit. It's why I'm asking.

>      Moving forward to the recent pull
> request, the LSM hooks do have the ability to gate these additional
> file types, and for a LSM such as SELinux that aims to provide
> comprehensive access controls, adding support for enforcing controls
> on these additional file types is a logical thing to do and consistent
> with our other work.

Again - you're explaining what it *does*.  I see what it does. That
was never the issue. That was the only part that the commit message
talked about.

What I'm asking for is *WHY*.

I realize that to you, the security side is what you do, and you feel
that this is all some internal thing to selinux and may feel that I'm
butting in where I shouldn't.

But to others, these things cause extra overhead, so it's *not* just
internal to selinux. It affects others in bad ways.

I want the _reasons_ for new policy hooks to be *explained*.

>  The fact that these changes didn't happen at the
> same time as the enabling support for the other file types is likely
> due to an ongoing challenge we face where we sometimes fail to keep
> current with all facets of kernel development.

You are still just talking about what the code does.

I repeat: my questions is *WHY*.

*WHY* is that policy needed at all?

As you correctly point out, it has NOT EXISTED for a long long time
already, and the code has been the old way since 4.x timeframe.

So my question literally boils down to "WHY SHOULD IT EXIST NOW"?

We've done quite well without it.

And I do not not see the point of allowing a driver module load (which
*is* a policy, and has been for a long time), and then disallowing
loading the firmware that the driver needs.

That's insane. So explain to me why you added what looks like
completely insane policy hooks.

See what I'm complaining about? I'm literally looking at that code,
and I understand what it does, but it adds policy for something where
I do not believe policy makes any sense what-so-ever.

The whole "any policy, anywhere, any time, for any reason" model is not valid.

We don't ask for permission for core kernel functionality. We don't
ask permission to do things the kernel needs to do.

And new policy rules need to be explained.

             Linus
