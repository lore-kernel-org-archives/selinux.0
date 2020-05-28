Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F2C433E0
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 14:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E99C207D3
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 14:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suhHmiLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391162AbgE1OX5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390932AbgE1OXz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 10:23:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7ACC05BD1E
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 07:23:55 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 69so2499336otv.2
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5u6/PsL6xo9Rk2GNRB5ZRDGm1Ea+RYOHbbxLjExCCXg=;
        b=suhHmiLsNWKbCzyVPmkMafINmcLZzI9bmAWk/ThzaGbLGm8+P9jW3wKa0IZK5qyKpH
         3Vd39cVBunquNxY5AlwDX6egQumsZpwStAca0omf+qHk+xRVv9Imted9i7puZLcV18QI
         VNZqTcPl0umdsOJcpIfhUSdgEsAXIvS/HUT3yXzaMYzbg6LSeBy2YgFzbhRzzASlLY81
         sZENx2tAbI0JnV1GghVMHPjPFV77/0jnnqeWHWwGY20ih+WCQpupHfAJoC6awo+jQEdh
         nU8ymq71B1WDRc3TixX/8F01OdA3LIoK3zDxs5Op2dpdWpRyHqdLmRv+KmW7fPEixUi5
         rvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5u6/PsL6xo9Rk2GNRB5ZRDGm1Ea+RYOHbbxLjExCCXg=;
        b=m5by11bbPFKxDaQyYxCdXcH6x0tFv/bm3dhhoi71qRr2OsvoTAof9pV+rNhyaf6Mr2
         SfNH7pM/bIfQmd/5gmtWt7zJwkZi2DZ/z5F+vFeQtYZg/DMwFFT9G0eCanS5LVAZHJFS
         8eRUnkFpLT1yVB+B8T3SXuSSlyyWoDgYxQ2OueZJthpseBlhbxRuwRlluumlw02n4RDY
         tqIUzeOC6qcGwSu0spvcxCR/yx1ZXeJYT5sdMBEy06zpT1LMUWcp7OjFIYVLxpZ+QmpM
         3kQRTCy++C+5d3r2Qn8u6I7CwczSSBwQzzMSK7WxKAK/8JOFaZPpKz5HvqIyrjVZzhiF
         bu0w==
X-Gm-Message-State: AOAM533YSeyMXFeVCQCVlAmkmOPT8lwrsV2sIYpCzj7abdvjvHzx5Ktm
        J+Hi+u59AFydjg66r3n1JG8WjVqtl8kilJIlMyA=
X-Google-Smtp-Source: ABdhPJwtUqOaNKnTn5kfS1vIZm2fOPz086X+kszIpzwrrMyVoL0BcbrCXBpwicoDbIfsMhQBQXzs+oORGw7SSH3ynIs=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr2507162otd.162.1590675834430;
 Thu, 28 May 2020 07:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
 <20200528125128.26915-1-cgzones@googlemail.com>
In-Reply-To: <20200528125128.26915-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 28 May 2020 10:23:43 -0400
Message-ID: <CAEjxPJ5f2r5R3AhZUxdYhO1U-OWdEd_+Mxfh=Q-THAuGF=Q4nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sepolgen: parse gen_tunable as bool
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 28, 2020 at 8:52 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Currently sepolgen-ifgen parses a gen_tunable statement as interface
> and reports in verbose mode:
>
>     Missing interface definition for gen_tunable
>
> Add grammar for gen_tunable statements in the refparser
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  python/sepolgen/src/sepolgen/refparser.py | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/=
src/sepolgen/refparser.py
> index 2e521a0f..f3e0ae87 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -126,6 +126,7 @@ tokens =3D (
>      'GEN_REQ',
>      'TEMPLATE',
>      'GEN_CONTEXT',
> +    'GEN_TUNABLE',
>      #   m4
>      'IFELSE',
>      'IFDEF',
> @@ -192,6 +193,7 @@ reserved =3D {
>      'gen_require' : 'GEN_REQ',
>      'template' : 'TEMPLATE',
>      'gen_context' : 'GEN_CONTEXT',
> +    'gen_tunable' : 'GEN_TUNABLE',
>      # M4
>      'ifelse' : 'IFELSE',
>      'ifndef' : 'IFNDEF',
> @@ -518,6 +520,7 @@ def p_policy_stmt(p):
>                     | range_transition_def
>                     | role_transition_def
>                     | bool
> +                   | gen_tunable
>                     | define
>                     | initial_sid
>                     | genfscon
> @@ -844,6 +847,17 @@ def p_bool(p):
>          b.state =3D False
>      p[0] =3D b
>
> +def p_gen_tunable(p):
> +    '''gen_tunable : GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA TRU=
E CPAREN
> +                   | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA FAL=
SE CPAREN'''

Looks like you need to also support the case where no quoting is
performed.  Otherwise, I still see syntax errors, e.g.
/usr/share/selinux/refpolicy/include/services/apache.if: Syntax error
on line 35 allow_httpd_$1_script_anon_write [type=3DIDENTIFIER]

35: gen_tunable(allow_httpd_$1_script_anon_write, false)
