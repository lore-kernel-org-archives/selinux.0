Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3499C38BE1
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 18:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E8F2080D
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 18:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1y/E2Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBXSwU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:52:20 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46046 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBXSwU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 13:52:20 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so323157iln.12
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EhGFq9zt4/ioPQEGrcyIVqXLz7qgGlQB/NoM0nnbwfE=;
        b=A1y/E2MuIzpISOUthIPg+2Ks4GIxsshUYX+f2cAxouT7kxwDMufIuT14MnrnJiat5u
         4OTOEVhk5FczqBB+n/ghC2T5rQ7OoSSC2lgJMZ2RvjavSARPOnSYEJirRyYl4XGJMj/0
         +sEYGKiKDSEtDgZhey4r6KbC8gBbavMuxRVawzwijbA/qsOvwHMoDDNYsAG+8DuTKw1e
         XH+G1r4k69sskYseUVaEmwE9xJI1Koo1nHR7NpVSJtTVOSMkauL5AgPKqcK1AhhCzxNA
         8PsX0dfULpiY61K+y4HS805eu0FnqzLOaSWtusyRW0sxn3FsbUz2hP7uxair2kbncnQz
         BwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhGFq9zt4/ioPQEGrcyIVqXLz7qgGlQB/NoM0nnbwfE=;
        b=KupC8SPhO8Chr/0c+A06T5CBXcC+wd6g0WMhwFU00uMeX4UlXmQ/iGp2XQYcSe4rqx
         16RvizAIsovUqKm6txPqz4pF+aLgaTChv4MGj0XbmMZWq5qGqssrBtK9MYv+//F8a24j
         PWBo4rTJkpotEbHLHzt3ZSTs+jMo7UzmrtjzG+ALSfAoY73EIs9XdPDSpbzapYdaqP5s
         uBO/gcAH0A+WE11nPTiyjg9rHWolZc+PgGA2ofKs4IEa7hRIi4oLeTa31AIMb1rTNqWD
         63/IwNULrsGEfewdsz6zbNPSnh5OIh22QDZ+x6l4GEPTqQAbSZtDLZEPOXS76VjswpNE
         uKGw==
X-Gm-Message-State: APjAAAXkH2Hwfo1jyWNC7gQSpiemNE75NBpulQ9XeIqcOvuQ7W6HNaUT
        zBjkYjSSr+kPy21UPtBjPMJCaNMhlKXOI8t3zh/FhA==
X-Google-Smtp-Source: APXvYqwUPKdq4as0ic04zqRyPwLlJCxbFNNz5FxrVTSc0w2LkpTeRT6wi/9sb5xw9biJ0o3ivUmFZRLF1Ox4Mq1jyIY=
X-Received: by 2002:a92:d2:: with SMTP id 201mr63201771ila.22.1582570339435;
 Mon, 24 Feb 2020 10:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20200221083819.1124890-1-plautrba@redhat.com> <CAFftDdqzTnhO4ii+r9jweBGMtvwrezi-T1_utoCe-V=v+rfPVA@mail.gmail.com>
 <2b98a7da-e186-1013-1286-27d751e75536@tycho.nsa.gov> <CAFftDdo_A5KCwj1szdf-JMV5CbCet58sPe2gJ4v9wKCHOd=1KA@mail.gmail.com>
In-Reply-To: <CAFftDdo_A5KCwj1szdf-JMV5CbCet58sPe2gJ4v9wKCHOd=1KA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 24 Feb 2020 12:52:08 -0600
Message-ID: <CAFftDdqs0OVnMTAbn8_1_G+djMKfseev+05eBW6bPU5ug0mcbA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: deprecate security_compute_user(), update man pages
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 24, 2020 at 12:44 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
>
>
> On Mon, Feb 24, 2020 at 11:00 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 2/24/20 11:49 AM, William Roberts wrote:
>> > On Fri, Feb 21, 2020 at 2:40 AM Petr Lautrbach <plautrba@redhat.com
>> > <mailto:plautrba@redhat.com>> wrote:
>> >
>> >     From: Stephen Smalley <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>
>> >
>> >     commit 1f89c4e7879fcf6da5d8d1b025dcc03371f30fc9 ("libselinux: Eliminate
>> >     use of security_compute_user()") eliminated the use of
>> >     security_compute_user() by get_ordered_context_list().  Deprecate
>> >     all use of security_compute_user() by updating the headers and man
>> >     pages and logging a warning message on any calls to it.  Remove
>> >     the example utility that called the interface. While here, also
>> >     fix the documentation of correct usage of the user argument to these
>> >     interfaces.
>> >
>> >     Fixes: https://github.com/SELinuxProject/selinux/issues/70
>> >     Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov
>> >     <mailto:sds@tycho.nsa.gov>>
>> >     Acked-by: Petr Lautrbach <plautrba@redhat.com
>> >     <mailto:plautrba@redhat.com>>
>> >     ---
>>
>> >     diff --git a/libselinux/include/selinux/selinux.h
>> >     b/libselinux/include/selinux/selinux.h
>> >     index 883d8b85742c..6a512b383325 100644
>> >     --- a/libselinux/include/selinux/selinux.h
>> >     +++ b/libselinux/include/selinux/selinux.h
>> >     @@ -246,8 +246,12 @@ extern int security_compute_member_raw(const
>> >     char * scon,
>> >                                             security_class_t tclass,
>> >                                             char ** newcon);
>> >
>> >     -/* Compute the set of reachable user contexts and set *con to refer to
>> >     -   the NULL-terminated array of contexts.  Caller must free via
>> >     freeconary. */
>> >     +/*
>> >     + * Compute the set of reachable user contexts and set *con to refer to
>> >     + * the NULL-terminated array of contexts.  Caller must free via
>> >     freeconary.
>> >     + * These interfaces are deprecated.  Use get_ordered_context_list() or
>> >     + * one of its variant interfaces instead.
>> >     + */
>> >       extern int security_compute_user(const char * scon,
>> >                                       const char *username,
>> >                                       char *** con);
>> >
>> >
>> > Any reason we're not tagging this with __attribute__ ((deprecated));?
>>
>> Doesn't appear that we've ever used that.  Is it widely supported across
>> compilers and versions or limited to recent gcc?
>>
>
> Its at least since GCC 3.3 and it's been supported in every clang compiler version I am aware of (linked to 3.3).
> https://gcc.gnu.org/onlinedocs/gcc-3.3/gcc/Type-Attributes.html
> https://releases.llvm.org/3.3/tools/clang/docs/LanguageExtensions.html
>

Sorry for the HTML, apparently Google stopped making that my default
when replying...

>
