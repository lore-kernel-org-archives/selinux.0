Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8B2C433FE
	for <selinux@archiver.kernel.org>; Mon, 28 Feb 2022 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbiB1Skj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbiB1Sjt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Feb 2022 13:39:49 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AA33A199
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 10:28:06 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso19650785ooc.12
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XfYBLivncZVjG0i6RmVzrTcK53sIdERRY+TFOlp5zX4=;
        b=g+IUyTS1IIQqo98VsavY9sj9Q0+6k0eQsnUGVhaoa9foue55uFGC/sbfmMP7esfosh
         jUYefprn58gRXq8BDgUoU7ti471FHuMa20RNgoxYXlneJAVLN3H9+JXqBpCFks4D+mhe
         zL3JZk9HLxtgniijeXwXwVp7JzeRUAhrwiMehh0HQYMr0je74ltBtB3WaOl3QAP8zj5O
         qgbGRgSxx17QgfO1o/X3A9Nt0HB7r1ps+Fx1nYWSMeXmrh+00uf91BoaRBmTk9mDv60s
         IZqnCdGd4E5RPGy5ylNQb1cH8zj7JeLTCDS7dYZ1s4mfc7OD8Nmu57plMuFKTf+BPxJh
         vMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XfYBLivncZVjG0i6RmVzrTcK53sIdERRY+TFOlp5zX4=;
        b=VnohNvLUUvCh9r5grhDQB7JlmMtqUFYossSmw4tELd8l57vtgCsmwzZsOj2nqdhdP9
         /MMqvmukRzl/7MwnPZhDR/X3WGP5VoWzc6hNNYB/CJeNi+vrMPyXJ81PAP86fBchv6Zj
         YnAOUS8Tm4VybHU266XsDHl57neB0Jqv6okIl/xnWIFvaweIuO2GcVReWh+kFlNDNZZu
         9oqCfXz+MjCzP5sUbOH3ida0uYJe+1MqvAy8CwypXsi+SqUtaKkYg6X/+dMkNGM/iydf
         WDdr/t10Tt5PNqvl5Ni6qzBsjHOyPCl+1qe88x4jXCsmdNgCXKNpw836NNks3sShI7H4
         bSrw==
X-Gm-Message-State: AOAM531o2wbsOoq9wd3E66jHTu4UUE9aALQ+4DxJ9rtQdYu6AgyMFQXv
        US35RTZi6sHugc1qumdEFC0CTUyffIGDwM3bz4iCzmQ+n9s=
X-Google-Smtp-Source: ABdhPJymgDSIJF/G5l5XYkSvwOQP3R0k+S0HGKbvfuf0nr7sQ0/iSte0N2qpiwJgvkhyxwoPHwyEnocrE8PcnVZr0Ro=
X-Received: by 2002:a05:6870:569f:b0:d6:e441:553e with SMTP id
 p31-20020a056870569f00b000d6e441553emr1448472oao.16.1646072886000; Mon, 28
 Feb 2022 10:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20220204133507.26977-1-cgzones@googlemail.com>
 <20220222135435.31216-1-cgzones@googlemail.com> <20220222135435.31216-3-cgzones@googlemail.com>
In-Reply-To: <20220222135435.31216-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Feb 2022 13:27:55 -0500
Message-ID: <CAP+JOzRicMLPM+6hs0aC=UGe5Uaw0oMjnRf4CZr=PtrvKg6HZg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] libsepol: export functions for policy analysis
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 22, 2022 at 9:17 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Export functions needed for converting security identifiers from and to
> strings and functions computing security server decisions.  These can
> be used to debug or run tests on binary policies without running on a
> SELinux enabled kernel.
>
> TODO:
> These functions have currently a non consistent return behavior: some
> are returning -1 on failure and set errno most but not all of the time,
> some return a negative errno like value.
> Maybe this should be addressed before exporting them?
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/libsepol.map.in | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 0e05d606..844924fc 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -274,3 +274,18 @@ LIBSEPOL_3.0 {
>         cil_write_resolve_ast;
>         cil_set_qualified_names;
>  } LIBSEPOL_1.1;
> +
> +LIBSEPOL_3.4 {
> +  global:
> +       sepol_av_perm_to_string;
> +       sepol_change_sid;
> +       sepol_compute_av;
> +       sepol_compute_av_reason;
> +       sepol_compute_av_reason_buffer;
> +       sepol_context_to_sid;
> +       sepol_member_sid;
> +       sepol_sid_to_context;
> +       sepol_string_to_av_perm;
> +       sepol_string_to_security_class;
> +       sepol_validate_transition_reason_buffer;
> +} LIBSEPOL_3.0;
> --
> 2.35.1
>

I am a bit conflicted. I like this patch series and see the value in
exporting these functions, but I really don't want to export functions
from include/sepol/policydb/. We have three already that have slipped
through: expand_module_avrules(), sepol_polcap_getnum(), and
sepol_polcap_getname(). Keeping the exported functions in
include/sepol makes it easier to see what is exported.

At least in this case the data structures involved aren't going to
cause problems later as sepol_security_id_t and sepol_access_vector_t
are both unit32_t, sepol_security_class_t is a unit16_t, and even
struct sepol_av_decision consists of sepol_access_vector_t and
uint32_t members. We don't want external programs strongly relying on
the details of the data structures in include/sepol/policydb. It was
kind of a mess when the named transitions were moved from a list to a
hash table.

Since most of these functions are used in either checkpolicy or
audit2why (or both), it is probably fine to export these, but I would
appreciate any thoughts that Chris and others might have.

Jim
