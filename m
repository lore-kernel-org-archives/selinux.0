Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C01C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1B9208C0
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 20:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfISUvv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:51:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:50067 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfISUvv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 16:51:51 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7B4AC561249
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 22:51:48 +0200 (CEST)
Received: by mail-oi1-f173.google.com with SMTP id i16so3972105oie.4
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 13:51:48 -0700 (PDT)
X-Gm-Message-State: APjAAAV6Esbi63Poxsj7Xy8yNAr9tq9LLyL/sLcCP6//z2l2SGwc8cVU
        fQQa0+P25iQBfgCZMhJb0qncHagetaMSV2lyfuU=
X-Google-Smtp-Source: APXvYqzvL3kbkKC62u1C+RV+H9Wn3MqxPp8vRmxHobyN23rhDV7VEjrJ6kvreMTO8jdYyDxxik9bIFu1o2D9MeHXoi4=
X-Received: by 2002:aca:4d08:: with SMTP id a8mr4115895oib.39.1568926307404;
 Thu, 19 Sep 2019 13:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190918210450.8692-1-nicolas.iooss@m4x.org> <1800df5d-121c-e275-f3bc-ec71d2b0d3e7@tycho.nsa.gov>
In-Reply-To: <1800df5d-121c-e275-f3bc-ec71d2b0d3e7@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 19 Sep 2019 22:51:35 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==HxzHGkS2e+cJ+qsJaetVgBCv+xQWS0CYdE8yHWEhNwA@mail.gmail.com>
Message-ID: <CAJfZ7==HxzHGkS2e+cJ+qsJaetVgBCv+xQWS0CYdE8yHWEhNwA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux: ensure strlen() is not called on NULL
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Sep 19 22:51:48 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 19, 2019 at 6:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 9/18/19 5:04 PM, Nicolas Iooss wrote:
> > When compile_regex() calls regex_prepare_data() and this function fails
> > in the following condition:
> >
> >      *regex = regex_data_create();
> >      if (!(*regex))
> >          return -1;
> >
> > ... error_data has been zero-ed and compile_regex() calls:
> >
> >      regex_format_error(&error_data,
> >          regex_error_format_buffer,
> >          sizeof(regex_error_format_buffer));
> >
> > This leads to a call to strlen(error_data->error_buffer), where
> > error_data->error_buffer is NULL.
> >
> > Avoid this by checking that error_data->error_buffer is not NULL before
> > calling strlen().
>
> It seems like regex_format_error() should just return immediately if
> !error_data->error_code (#ifdef USE_PCRE2) or !error_data->error_buffer
> (#ifndef USE_PCRE2), since there is no back-end error message to get and
> report in that situation.

I agree. I will modify the patch.

By the way, while reading function regex_format_error() more
precisely, something seems strange in:

pos += rc;
if (pos >= buf_size)
    goto truncated;
if (error_data->error_offset > 0) {
    /* ... */
}
pos += rc;

As rc is not reset to zero, its value is added twice to pos. Is this a
bug, or am I misunderstanding something?

Thanks,
Nicolas

