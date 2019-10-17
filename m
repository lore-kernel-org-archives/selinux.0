Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA5ECE58D
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 19:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9602089C
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 19:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbfJQTCm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:02:42 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:60188 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfJQTCm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Oct 2019 15:02:42 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id BA4155646EE
        for <selinux@vger.kernel.org>; Thu, 17 Oct 2019 21:02:38 +0200 (CEST)
Received: by mail-ot1-f54.google.com with SMTP id 89so2807883oth.13
        for <selinux@vger.kernel.org>; Thu, 17 Oct 2019 12:02:38 -0700 (PDT)
X-Gm-Message-State: APjAAAWcx9Ugevcd/d83+/YsB7S6CiQgOIFzJLFmkG0yvkpo+ldBlES/
        p0W5L8aZg7ZXJouQxboD92ECiO6scIOuPAsY6KQ=
X-Google-Smtp-Source: APXvYqw3PkPfl4It1pP5FkwkxGWR/o+zgCIBU9bxeBHZMF4Mtgei5NiJJGDxQw8ztuT/U9SUa6mpgbl4YOCyx07ZsBw=
X-Received: by 2002:a9d:664:: with SMTP id 91mr4208858otn.189.1571338957711;
 Thu, 17 Oct 2019 12:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191013105216.614224-1-nicolas.iooss@m4x.org>
 <20191013105216.614224-2-nicolas.iooss@m4x.org> <pjd7e564aj8.fsf@redhat.com>
In-Reply-To: <pjd7e564aj8.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 18 Oct 2019 08:02:26 +1300
X-Gmail-Original-Message-ID: <CAJfZ7==0i1zz+rZJ0F9G3jF39KD9kMYk4NWxZnVev5vQTvEKdQ@mail.gmail.com>
Message-ID: <CAJfZ7==0i1zz+rZJ0F9G3jF39KD9kMYk4NWxZnVev5vQTvEKdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsemanage: mark all exported function "extern"
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Michael Shigorin <mike@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Oct 17 21:02:39 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 15, 2019 at 10:34 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> > Many functions are already marked "extern" in libsemanage's public
> > headers and this will help using the content of the headers in order to
> > automatically generate some glue code for Python bindings.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Do you plan to provide a test which would guard libselinux.h and
> libsemanage.h so that all new functions are added with extern?

Yes. This series was the "part 1" of the 3 parts described in a
previous thread
(https://lore.kernel.org/selinux/CAJfZ7=kYpc3Y1EHHycGeQSqCoptyNAyEcx4=ZDP=O8NEKJQnyg@mail.gmail.com/)
and "part 3" will consist in providing such a test, for example by
comparing the output of "gcc -aux-info" (which adds "extern" to all
functions) against the new method which will be used to generate some
glue code of Python bindings.

I am currently travelling so I am not able to do as much testing as I
would like. If Michael Shigorin does not send patches for the
remaining parts, I will work on them once I get back home.

>
> Anyway, for both
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, merged.

Nicolas

