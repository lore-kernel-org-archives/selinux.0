Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27347CDB47E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjJLXnW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 19:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjJLXnV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 19:43:21 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA2CA
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 16:43:18 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a50ac5eabso1743819276.1
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697154198; x=1697758998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyXNgmUaPF1bv9pyp6gE2Z2gQrV0/t7IYlhVwPny5tY=;
        b=bzmlk2KZj4Jtu+hM3G+s6mJEtca8aDKDM5tuEVKxpZf2X7LbRC5bHehBOoc+rYLH0d
         aHbWdKG1ozG4SJpqCLWWekCZk/mAZgUtsab1UvcQweRMN4pFYe8qX/scLJ0KsyaHGKFu
         sadZPYf1UeQr8+tQpW1NTkVedIiYwZ8uv0R2BMDI3FlLwmzs80L57GzsK+X9bDJNhizZ
         GiV8I+ADDLVpV/H9JxJQbl3P3HRn0wao8U9l1HBDw3FHtF5RzS37l1fguWzIYBoJTrlF
         byBrhWilcQh/mmf6FXTbRir/LWHUxCNQIAr6KeNc34M+2XXP/Q9sB9kpGMt9xatQVYyr
         BDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154198; x=1697758998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyXNgmUaPF1bv9pyp6gE2Z2gQrV0/t7IYlhVwPny5tY=;
        b=wQjTt27W6Ab7JYyWSD/9lvnSP/uWhW0gyn0oX3u8JwjcCKpeXAxQcw9kCDYmHs4SEv
         0shVUxuWpoqfEeucOP9DibKLKU6OaP0stTfGde12KeUEvV3u68tGv7CDa+vB4pg+cGm9
         HizSNid+96OOdyumZn0691aoC6jkHBEwRVgMv3GR2KcSsRdD1yP5MxtpbOZTcxc9t/Mx
         fId7igOU1g1W2Ehk1izQl32GvURwa/UMHTkHnaIuE5DRbOrJl1encOvzZZP+zVYCsu1B
         0ldeoR2RYVIIgAqg+sJRLfMdRgWyd/VsMGlMBKGcARcLEkC6ZzccQV6+doZCvFXIbo9+
         nnGA==
X-Gm-Message-State: AOJu0YxcAUenvRAB5JQ+b3Uv773rSIhC4W1Dwp821JCSQUoSn6qKk5Jg
        GCQH5l9ser11jjOv09RNfwqhS1vp+GLzT4wn81A0
X-Google-Smtp-Source: AGHT+IFcGjYof8uqwKQYOb5HB7EJH671qYdyyUP/MYsADQEZKIOvJNUJNMPujVOol3jT7OajE1YEovrl2MC9mWZ3EfE=
X-Received: by 2002:a5b:708:0:b0:d9a:d2eb:7dcf with SMTP id
 g8-20020a5b0708000000b00d9ad2eb7dcfmr2908615ybq.41.1697154198040; Thu, 12 Oct
 2023 16:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230927225809.2049655-4-andrii@kernel.org> <53183ab045f8154ef94070039d53bbab.paul@paul-moore.com>
 <CAEf4BzaTZ_EY4JVZ3ozGzed1PeD+HNGgkDw6jGpWYD_K9c8RFw@mail.gmail.com> <CAEf4BzYa9V5FWLqq5wmdTJdtD3yHE-FdvBN7E33bb7+r2eGYBg@mail.gmail.com>
In-Reply-To: <CAEf4BzYa9V5FWLqq5wmdTJdtD3yHE-FdvBN7E33bb7+r2eGYBg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Oct 2023 19:43:07 -0400
Message-ID: <CAHC9VhQuoPUwctgUFNEkXZmutweEpGMVBAx5NmE7PvbE7oeR=g@mail.gmail.com>
Subject: Re: [PATCH v6 3/13] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 12, 2023 at 5:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Oct 11, 2023 at 5:31=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > ok, so I guess I'll have to add all four variants:
> > security_bpf_token_{cmd,map_type,prog_type,attach_type}, right?
> >
>
> Thinking a bit more about this, I think this is unnecessary. All these
> allow checks to control other BPF commands (BPF map creation, BPF
> program load, bpf() syscall command, etc). We have dedicated LSM hooks
> for each such operation, most importantly security_bpf_prog_load() and
> security_bpf_map_create(). I'm extending both of those to be
> token-aware, and struct bpf_token is one of the input arguments, so if
> LSM need to override BPF token allow_* checks, they can do in
> respective more specialized hooks.
>
> Adding so many token hooks, one for each different allow mask (or any
> other sort of "allow something" parameter) seems to be excessive. It
> will both add too many super-detailed LSM hooks and will unnecessarily
> tie BPF token implementation details to LSM hook implementations, IMO.
> I'll send v7 with just security_bpf_token_{create,free}(), please take
> a look and let me know if you are still not convinced.

I'm hoping my last email better explains why we only really need
security_bpf_token_cmd() and security_bpf_token_capable() as opposed
to the full list of security_bpf_token_XXX().  If not, please let me
know and I'll try to do a better job explaining my reasoning :)

One thing I didn't discuss in my last email was why there is value in
having both security_bpf_token_{cmd,capable}() as well as
security_bpf_prog_load(); I'll try to do that below.

As we talked about previously, the reason for having
security_bpf_prog_load() is to provide a token-aware version of
security_bpf().  Currently the LSMs enforce their access controls
around BPF commands using the security_bpf() hook which is
unfortunately well before we have access to the BPF token.  If we want
to be able to take the BPF token into account we need to have a hook
placed after the token is retrieved and validated, hence the
security_bpf_prog_load() hook.  In a kernel that provides BPF tokens,
I would expect that LSMs would use security_bpf() to control access to
BPF operations where a token is not a concern, and new token-aware
security_bpf_OPERATION() hooks when the LSM needs to consider the BPF
token.

With the understanding that security_bpf_prog_load() is essentially a
token-aware version of security_bpf(), I'm hopeful that you can begin
to understand that it  serves a different purpose than
security_bpf_token_{cmd,capable}().  The simple answer is that
security_bpf_token_cmd() applies to more than just BPF_PROG_LOAD, but
the better answer is that it has the ability to impact more than just
the LSM authorization decision.  Hooking the LSM into the
bpf_token_allow_cmd() function allows the LSM to authorize the
individual command overrides independent of the command specific LSM
hook, if one exists.  The security_bpf_token_cmd() hook can allow or
disallow the use of a token for all aspects of a specific BPF
operation including all of the token related logic outside of the LSM,
something the security_bpf_prog_load() hook could never do.

I'm hoping that makes sense :)

--=20
paul-moore.com
