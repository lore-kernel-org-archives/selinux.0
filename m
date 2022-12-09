Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF283C4332F
	for <selinux@archiver.kernel.org>; Fri,  9 Dec 2022 19:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLITUd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Dec 2022 14:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLITUc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Dec 2022 14:20:32 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9066E556
        for <selinux@vger.kernel.org>; Fri,  9 Dec 2022 11:20:30 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k185so5409889vsc.2
        for <selinux@vger.kernel.org>; Fri, 09 Dec 2022 11:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SgFsNAWxl/FqC70IKGpPUdsXXXd9XS3CoRkDWL3fq+g=;
        b=CfatCWJD7rFjy2SnS0RkLPG4ZzSDfiy4nqVTY3DNFLBf3YZp1qJf5dG4m2oMGykyiU
         Rbp6zccbDNb/Hp6nT1mhGo00Qj+pEYsV1eN0e4u2uPRrDiodm8N2DgwWx4rk0jSBqSB9
         YnjAysM2hSm+wqovx7Lzczc2wMCtwAoNN97z0JYQThOZRzaIJD42f/HBiX7Te/ZpjfiD
         7lKlf2zeQKL7zZo6kR5jHySes5MNjgASWHXRRdNjc0t7PAyvwtRUAr8IVm04KyFwbYao
         AreiB0zDiQn9OFVSuD506QJfJK2yxu3vI4E5eSQGIW+zUQ3ec+yUJJ315txH6ctVE6Ri
         Y+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgFsNAWxl/FqC70IKGpPUdsXXXd9XS3CoRkDWL3fq+g=;
        b=XZB5m4O23mTqJsJSoejCsJBB7AlOyQb3HCi58+WfQMcpb2tPFhdb635M2821YbTTcL
         XVjIZBJ9FU3Ba91WKEYzXKXzbBKygeZu2Nv5kkx0vo4Az+QZBG7Ff+Xa2lj5XR7E4Z6U
         VQut8GpA9xHRGWTbTSgNC5kj9lQx+bu9MlhTWkDr3V36mrVOZYakW8PXgmScYKWGAN/p
         D0XkeS9rCu8C5Hxm1Ek0D410mdbHdsEu8/90mUJf4h4RAeyQv3W8RY6VLyPSJnwAMSee
         hnG7o1Mhfylz/k0vDC4gPYXHxJuAJYJG/JPYErHol6iMvaIXblY5skm87aWEdm8WoxWC
         7qXg==
X-Gm-Message-State: ANoB5pnIDnb5TZku4BXg/to0+ulhrMSf+75J8+pclzDVP9ucXiLFYTM0
        kYu1fX5z6yrEZzA2DWRojbxktRhV1iOAo0lfXDo=
X-Google-Smtp-Source: AA0mqf5inZu/MATbE+4ZwpjwiVE5krZaP8AeQoy+JtKHF/fj1EXpxRG50EydYGDEBJuVyXitFRLRTxNl1hv0rdJAdNU=
X-Received: by 2002:a67:db04:0:b0:3b1:29d1:3485 with SMTP id
 z4-20020a67db04000000b003b129d13485mr12529397vsj.20.1670613629607; Fri, 09
 Dec 2022 11:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20220801015721.393211-1-chris.lindee+git@gmail.com> <20220801015721.393211-2-chris.lindee+git@gmail.com>
In-Reply-To: <20220801015721.393211-2-chris.lindee+git@gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 9 Dec 2022 20:20:16 +0100
Message-ID: <CAJ2a_DdZTzSxj5uBQwHAnqYUoSM72neqb0BMnn++qKGVbKY2Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sepolgen: Update refparser to handle xperm
To:     chris.lindee@gmail.com
Cc:     selinux@vger.kernel.org,
        Chris Lindee <chris.lindee+github@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 1 Aug 2022 at 03:57, <chris.lindee@gmail.com> wrote:
>
> From: Chris Lindee <chris.lindee+github@gmail.com>
>
> Extend the grammar to support `allowxperm`, et. al. directives, which
> were added in policy version 30 to give more granular control.  This
> commit adds basic support for the syntax, copying heavily from the
> grammar for `allowperm`, et. al.

Looks good to me; two comments inline.


> Signed-off-by: Chris Lindee <chris.lindee+github@gmail.com>
> ---
>  python/sepolgen/src/sepolgen/refparser.py | 80 +++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
> index e611637f..1d801f41 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -67,6 +67,7 @@ tokens = (
>      'FILENAME',
>      'IDENTIFIER',
>      'NUMBER',
> +    'XNUMBER',
>      'PATH',
>      'IPV6_ADDR',
>      # reserved words
> @@ -112,6 +113,10 @@ tokens = (
>      'DONTAUDIT',
>      'AUDITALLOW',
>      'NEVERALLOW',
> +    'ALLOWXPERM',
> +    'DONTAUDITXPERM',
> +    'AUDITALLOWXPERM',
> +    'NEVERALLOWXPERM',
>      'PERMISSIVE',
>      'TYPEBOUNDS',
>      'TYPE_TRANSITION',
> @@ -179,6 +184,10 @@ reserved = {
>      'dontaudit' : 'DONTAUDIT',
>      'auditallow' : 'AUDITALLOW',
>      'neverallow' : 'NEVERALLOW',
> +    'allowxperm' : 'ALLOWXPERM',
> +    'dontauditxperm' : 'DONTAUDITXPERM',
> +    'auditallowxperm' : 'AUDITALLOWXPERM',
> +    'neverallowxperm' : 'NEVERALLOWXPERM',
>      'permissive' : 'PERMISSIVE',
>      'typebounds' : 'TYPEBOUNDS',
>      'type_transition' : 'TYPE_TRANSITION',
> @@ -231,6 +240,12 @@ t_PATH      = r'/[a-zA-Z0-9)_\.\*/\$]*'
>  t_ignore    = " \t"
>
>  # More complex tokens
> +def t_XNUMBER(t):
> +    r'0x[0-9A-Fa-f]+'
> +    # Turn hexadecimal into integer
> +    t.value = int(t.value, 16)
> +    return t
> +
>  def t_IPV6_ADDR(t):
>      r'[a-fA-F0-9]{0,4}:[a-fA-F0-9]{0,4}:([a-fA-F0-9]|:)*'
>      # This is a function simply to force it sooner into
> @@ -505,6 +520,7 @@ def p_policy(p):
>  def p_policy_stmt(p):
>      '''policy_stmt : gen_require
>                     | avrule_def
> +                   | avextrule_def
>                     | typerule_def
>                     | typebound_def
>                     | typeattribute_def
> @@ -810,6 +826,26 @@ def p_avrule_def(p):
>      a.perms = p[6]
>      p[0] = a
>
> +def p_avextrule_def(p):
> +    '''avextrule_def : ALLOWXPERM names names COLON names identifier xperm_set SEMI
> +                     | DONTAUDITXPERM names names COLON names identifier xperm_set SEMI
> +                     | AUDITALLOWXPERM names names COLON names identifier xperm_set SEMI
> +                     | NEVERALLOWXPERM names names COLON names identifier xperm_set SEMI
> +    '''
> +    a = refpolicy.AVExtRule()
> +    if p[1] == 'dontauditxperm':
> +        a.rule_type = refpolicy.AVExtRule.DONTAUDITXPERM
> +    elif p[1] == 'auditallowxperm':
> +        a.rule_type = refpolicy.AVExtRule.AUDITALLOWXPERM
> +    elif p[1] == 'neverallowxperm':
> +        a.rule_type = refpolicy.AVExtRule.NEVERALLOWXPERM
> +    a.src_types = p[2]
> +    a.tgt_types = p[3]
> +    a.obj_classes = p[5]
> +    a.operation = p[6]
> +    a.xperms = p[7]
> +    p[0] = a
> +
>  def p_typerule_def(p):
>      '''typerule_def : TYPE_TRANSITION names names COLON names IDENTIFIER SEMI
>                      | TYPE_TRANSITION names names COLON names IDENTIFIER FILENAME SEMI
> @@ -987,6 +1023,50 @@ def p_optional_semi(p):
>                     | empty'''
>      pass
>
> +def p_xperm_set(p):
> +    '''xperm_set : nested_xperm_set
> +                 | TILDE nested_xperm_set
> +                 | xperm_set_base
> +                 | TILDE xperm_set_base

maybe include IDENTIFER as option to accept

    allowxperm $1 $2:$3 ioctl $4;

> +    '''
> +    p[0] = p[-1]
> +    if len(p) == 3:
> +        p[0].compliment = True
> +
> +def p_nested_xperm_set(p):
> +    '''nested_xperm_set : OBRACE nested_xperm_list CBRACE
> +    '''
> +    p[0] = p[2]
> +
> +def p_nested_xperm_list(p):
> +    '''nested_xperm_list : nested_xperm_element
> +                         | nested_xperm_list nested_xperm_element
> +    '''
> +    p[0] = p[1]
> +    if len(p) == 3:
> +        p[0].extend(p[2])
> +
> +def p_nested_xperm_element(p):
> +    '''nested_xperm_element : xperm_set_base
> +                            | nested_xperm_set
> +    '''
> +    p[0] = p[1]
> +
> +def p_xperm_set_base(p):
> +    '''xperm_set_base : xperm_number
> +                      | xperm_number MINUS xperm_number
> +    '''
> +    p[0] = refpolicy.XpermSet()
> +    if len(p) == 2:
> +        p[0].add(p[1])
> +    else:
> +        p[0].add(p[1], p[3])

Single numbers might also be enclosed in braces, so maybe add an option

    OBRACE xperm_number CBRACE

and parsing it via

    elif p[1] == '{':
        p[0].add(p[2])

> +
> +def p_xperm_number(p):
> +    '''xperm_number : NUMBER
> +                    | XNUMBER
> +    '''
> +    p[0] = int(p[1])
>
>  #
>  # Interface to the parser
> --
> 2.37.1
>
