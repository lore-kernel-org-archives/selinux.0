Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57987C76196
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 19:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCaT7d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCaT7c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 15:59:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE1018F
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 12:59:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so26588870pjt.2
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680292769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDzw0X0zew3RIs+fNsY4hh5fPyM9caJ281Ye9MgQy/Q=;
        b=GHpAoHObjx1zRjTJdLHXppd9vdKkv+08SAhqVMMrTgV1KkBZU3gP7pbwQTf9nxK33i
         HPEHUXSKz5KHIpkSXygfVYDgnbkz6UBSezj8Uoa1HfJLctR0JudclRt3giFzLkQxyAe8
         v3ddb8zhtsIYASHzVekQjYtHJfsllqnRkSEWvY7qbtHUFWyjP2E9D0Wtq/SO8woM/gvD
         Pm2fQIhFL6c5WVIkzseH95+Rar+NFK7XfssBdyciSG/8tYhXjZWXfsg8pY5MrSK5/bob
         +nNuydof0iB7ubzcU/APio3nr9/tZoY4+GPNkpuYED6cm28pHyixJTM4F9BAzzSlP28T
         PL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDzw0X0zew3RIs+fNsY4hh5fPyM9caJ281Ye9MgQy/Q=;
        b=MxqUtPmC6Fkn9k589K/hdYO4ECBRf/sgWxa/WEO3l5wn7fOtDsqdmfttnkxQh9xs03
         65rqdoQKthHisi6FbBG8dqPc5XA18BvoeGkaRyISDrvm+jrBZ3zQMKPG3zmWVGCYueZ+
         aWHZeJMzFxWf7uaiGw4w7fhAddFwQGzB/WGMI+85JmQ5ZjGrgpklM0bUJM7TQ7XkG2NW
         M15vCgqb66hCffNsfhbZtrds6icb63nKYPpBR3qBvsiHb/ifcfVfF+mPeFfFmKT+tPIr
         99sAOpYus5b7kRjQz8Kct9GhMulV0flijGW2+O8vaVjmgvrZ88i025kOKN0yGb3OyIwR
         1sJQ==
X-Gm-Message-State: AAQBX9e9/Eyc5t6cVkbjShfdmJyLFORRGodCyUaF9KjeGCJn1L65BStL
        clKAD5w36V0f+ZNzTeXUVcx9tM5zfPAQ0PZoCWiH+BbHYns=
X-Google-Smtp-Source: AKy350avCzTpOdD73IP8JkZgmMnWH4su7aTP790MmtWGXSnZrnnP3o8fXfqIw9INyTQ/t7tEhAS2a4bcBYwg4eNocuU=
X-Received: by 2002:a17:902:b946:b0:19f:29cf:3ed2 with SMTP id
 h6-20020a170902b94600b0019f29cf3ed2mr9473548pls.3.1680292768985; Fri, 31 Mar
 2023 12:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <87ileh5ckg.fsf@redhat.com> <CAEjxPJ675EhOoKXHzXKaVOoSXfqkqKudPzCL=F4aAG0vbd+Cdg@mail.gmail.com>
 <87h6u0bwvp.fsf@defensec.nl>
In-Reply-To: <87h6u0bwvp.fsf@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 31 Mar 2023 15:59:18 -0400
Message-ID: <CAEjxPJ72BTh3MzGje82uN4ayCGFGnJyz7uKobprRhx0R1R0JNA@mail.gmail.com>
Subject: Re: sesearch --neverallow
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 31, 2023 at 2:26=E2=80=AFPM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Fri, Mar 31, 2023 at 8:37=E2=80=AFAM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
> >>
> >> Hi,
> >>
> >> I've got a question what is `sesearch --neverallow` good for and how t=
o
> >> make it work. I wasn't able to get any output from this command.
> >>
> >> Is it supposed to work with current userspace and policies? How?
> >
> > I don't see how it could work. neverallow rules aren't preserved in
> > the kernel policies.
> > It would only make sense if sesearch could be run on source policies or=
 modules.
>
> Which according to `man sesearch` is possible, but only monolithic policy=
.conf.

Even that doesn't seem to be supported by setools 4,
$ sesearch --neverallow policy.conf
Invalid policy: policy.conf. A binary policy must be specified. (use
e.g. policy.33 or sepolicy) Source policies are not supported.

$ rpm -q -f /usr/bin/sesearch
setools-console-4.4.0-9.fc37.x86_64
