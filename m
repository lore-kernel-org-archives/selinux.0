Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE853C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA7023AAA
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 16:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbhAVQxD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729119AbhAVQiN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 11:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611333361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLqEmMn//MU3/qWSHRhQLmIGI/LN3Yne85jM+Q+dcko=;
        b=BLV1qXnyvLL5lpAnbN1Gh8yEd2jvBrGyO2S1lYzdhYdOEeuGoP5ORyejOrZMdZXfrCceUJ
        VzuToUK7eLwO8dUiHSbui2WqLIRmEyQYGsugk+bcDmLTLdo2cQWZhoSORNoAgceZYWkjQn
        6iJ6tMLT5vy/YV9IwSvateTuPtmnOnk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-HHfbsGuYOWafXAWDotVLxQ-1; Fri, 22 Jan 2021 11:32:26 -0500
X-MC-Unique: HHfbsGuYOWafXAWDotVLxQ-1
Received: by mail-lj1-f197.google.com with SMTP id r20so2184648ljg.21
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 08:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLqEmMn//MU3/qWSHRhQLmIGI/LN3Yne85jM+Q+dcko=;
        b=byBsMZXGOdKV2WFRaw4t+Mrncu5aZ/vRM59h8cQs5ROYq0eB0iw2XOWdn2JW6jvTsR
         PqzGP1/hYzkL8K+JU8oqgzdstnuZ0qqOAeMM0ewcrA5p38CQk4uZ3uZEV3q64kAMmTPx
         OtaT1Qxo/97wRnXBrQ9Ipohyxt8liS1laPiAG/FpvpgtkSPsyH0tUJcXdLs00Wz++Dk3
         KS9ni9pyaji0szSEn/3Hezdyxd9PmjiUYUZFcWeRAyOZnam0zfITA9hXR0FsyP4ItLsE
         PcTu4tIp8O68CcDTAhBTorHD/XDgky1cENKPaj0SOQ9mLFq6Chbq5WzyHUZf6xxj5qui
         YBGA==
X-Gm-Message-State: AOAM530SU9Ui3N+AVf60a0gfzB6WzS47HzhPSR5eHdgJDZ6YSKHRpFGS
        QieCDukbruH8ao90HAlqfRFq5r0m11b7sR12gMfwukJZcbK/QJy5w8fvpHSemCsJNkdpF2iO22V
        tMiPg4k5h7JhhSu49VIbdviJuPJ6aUeXYFA==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr543420ljq.158.1611333144236;
        Fri, 22 Jan 2021 08:32:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCG3FIV07bl4Rv35twGTB0bLE3LVIF2Sj7CuA+MGWXNOwaE1xE2vU2o1F3Si1MCEPTqMLP9wxUBI5ho+9GXPg=
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr543412ljq.158.1611333144027;
 Fri, 22 Jan 2021 08:32:24 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNuE3CbwGDv7mvxh67iX3zeLKTu6AJC_VoeALb_o26+zOg@mail.gmail.com>
 <20210122152552.405237-1-vmojzis@redhat.com>
In-Reply-To: <20210122152552.405237-1-vmojzis@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 Jan 2021 17:32:14 +0100
Message-ID: <CAFqZXNusUEjEqg1a80vPFbgPZLdcseC2ot6co8F4CEjb-a+vjQ@mail.gmail.com>
Subject: Re: [PATCH v2] python/sepolgen: allow any policy statement in if(n)def
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 22, 2021 at 4:29 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> "ifdef/ifndef" statements can be used to conditionally define
> an interface, but this syntax is not recognised by sepolgen-ifgen.
> Fix sepolgen-ifgen to allow any policy statement inside an
> "fidef/ifndef" statement.
>
> Fixes:
>         $ cat <<EOF > i.if
> ifndef(`apache_manage_pid_files',`
>         interface(`apache_manage_pid_files',`
>                 manage_files_pattern($1, httpd_var_run_t, httpd_var_run_t)
>         ')
> ')
>
>         #sepolgen-ifgen --interface=i.if
>         i.if: Syntax error on line 2 interface [type=INTERFACE]
>         i.if: Syntax error on line 4 ' [type=SQUOTE]
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
> Thanks. Fixed. And I replaced "statement" with "statements" to allow
> multiple statements (as was possible with interface_stmts).
> I'm not all that sure about the last line since I didn't manage to find
> it's meaning (but I assume IF-THEN-ELSE).

Yes, the third argument is basically an optional 'else' branch:
https://www.gnu.org/software/m4/manual/m4-1.4.15/html_node/Ifdef.html

>
>  python/sepolgen/src/sepolgen/refparser.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
> index 9f850990..e611637f 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -433,9 +433,9 @@ def p_ifelse(p):
>
>
>  def p_ifdef(p):
> -    '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> -             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> -             | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> +    '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
> +             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
> +             | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
>      '''
>      x = refpolicy.IfDef(p[4])
>      if p[1] == 'ifdef':
> --
> 2.29.2
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

