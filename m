Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B691C433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 18:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiCCSR7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiCCSR5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 13:17:57 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845121A3633
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 10:17:11 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso6700094ooc.7
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 10:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XJux7M+MGZwDv2CyBeAyd+fIkUWEKiJjGys8CKVxQZE=;
        b=gS5YakIrNUEdKPFZ0vWJimoGfJk1wQluG6ll89KJUcA2nL20zwdbCPnUcjVQgPpNMe
         Us/kmj5XKtl1EKOb4i1G1h7LzClKDeLHzFp6mc2OnqBWrLs4gT+3Utlbw9jiDGlpjcSg
         w3QiC2Mi58D1Tx7R495TW0+LH7vTZ9l9wan+BWyw2d2i7oHD01LwcoOw4hBI6xVjJYB1
         gczEiFvU6mcjPbtqt6DYVjp1NQ3HfIiQ4VES4qGt0CYgCMCE9lJmI1sFzDn+YBV8qRdH
         t5Og8xd/MRjGzOZ22oaV8V1q/vVJzoj3pnhD/Iq6tv/U6+5ogIK4LaAzlEXs7oSQVJvV
         yqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XJux7M+MGZwDv2CyBeAyd+fIkUWEKiJjGys8CKVxQZE=;
        b=WImoz1a16U/jgz+qCUDS7DLR8I9/vQYN1fKUqxTtK+av0c2+hF6y2g8EOb37KLR7f6
         TPX384jxx2P/tDR/mFK+DwxgLq+rXsIqmK+F5N9iZuyMsPtL107GSr7r+XxB+oqWEdIT
         +PaaIJ5W8/9aX35ImT0ZgLjlYlPqh0A/0leuiTPluD1AnYzoZATHd0MjQqSsOkRuuKc/
         QqN/qAJzXtp3OO95hitAJ9CmmFYRH6RL5B1zhPlhsMhMqIuvyPwXdHXC4A10fU0Z6895
         rrinB0PXfoG+IHOx/HQglkCHGYaGkAbkNctgw9292uleLoX11bns8+EwcaKLuRQbolUo
         v2mA==
X-Gm-Message-State: AOAM530i/qHErqAA4mQvQbgt+4sBHhbaOKAFnN1A3mbfBo3vGJjUaefo
        u84UPgRMw6jq1eeLmpn6tuc0uuQ0ojQXoLScIpuU+ntP
X-Google-Smtp-Source: ABdhPJytayFxLb/sYVkBFh40IJ+sEnNn0uRHOySj7k5azHDqoF1+KBEjvv8sS47JBROLmGQoCZc4Aka6G3ZTYmYcw5Q=
X-Received: by 2002:a05:6870:7a3:b0:d7:5fbf:37b7 with SMTP id
 en35-20020a05687007a300b000d75fbf37b7mr4965179oab.16.1646331430860; Thu, 03
 Mar 2022 10:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20220214165812.9359-1-cgzones@googlemail.com> <20220214170855.10603-1-cgzones@googlemail.com>
 <CAP+JOzQ=WsaQJnQv4AKNCEzPBevvhRKXDHrgUO14XVxm4nCjCQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQ=WsaQJnQv4AKNCEzPBevvhRKXDHrgUO14XVxm4nCjCQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Mar 2022 13:16:59 -0500
Message-ID: <CAP+JOzSfKVoPbL4GkzDfCA7-yR74SW-C5M1shCbaKs7AZ=Afqw@mail.gmail.com>
Subject: Re: [PATCH] python/sepolgen: accept square brackets in FILENAME token
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 28, 2022 at 3:09 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Feb 14, 2022 at 4:19 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > When parsing Reference Policy style files accept square brackets in fil=
e
> > names.  The FILENAME token is used in the TYPE_TRANSITION grammar rule
> > for the optional name based argument.  This name can contain square
> > brackets, e.g. for anonymous inodes like "[io_uring]".
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > added missing signed-off
> > ---
> >  python/sepolgen/src/sepolgen/refparser.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolge=
n/src/sepolgen/refparser.py
> > index e611637f..1bb90564 100644
> > --- a/python/sepolgen/src/sepolgen/refparser.py
> > +++ b/python/sepolgen/src/sepolgen/refparser.py
> > @@ -261,7 +261,7 @@ def t_IDENTIFIER(t):
> >      return t
> >
> >  def t_FILENAME(t):
> > -    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :]+\"'
> > +    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :\[\]]+\"'
> >      # Handle any keywords
> >      t.type =3D reserved.get(t.value,'FILENAME')
> >      return t
> > --
> > 2.34.1
> >
