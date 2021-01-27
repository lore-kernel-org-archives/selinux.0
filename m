Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B06C433DB
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 16:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF4B20757
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 16:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbhA0QUV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343903AbhA0QTt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Jan 2021 11:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611764303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V0Hx7QdEMEPY7Ma5Xw4BQ5XZfaSIVNDVDjsSRdzI9aE=;
        b=EPYEKKK7n0uVMvoz2tLl+ph/3Yu7lb6KTavBHBmFVWfyEny5i64s9wFo7UU6qwcyBLY5TS
        Nv1qHRYesj+I+YPzYJSFrz9ycgcNb/u5eyiIq6G5RKHRgeMQSNAIgxwary0CJqJRZBZZjC
        rBioCZqcJYHrLhsCOawoWrmTUzoWjyc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-sMsoolE2Nn6dJlAec9spVg-1; Wed, 27 Jan 2021 11:18:19 -0500
X-MC-Unique: sMsoolE2Nn6dJlAec9spVg-1
Received: by mail-lj1-f199.google.com with SMTP id n15so57624ljg.3
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 08:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0Hx7QdEMEPY7Ma5Xw4BQ5XZfaSIVNDVDjsSRdzI9aE=;
        b=Q955xYhz8BLUMDH6EvWxuV6Aw0VL4kDUR3PQTjShCZTVOTh89deKY0u44tAWfQOVYM
         GCuqIkfCSxj6LaX2VdAeICjCZKwSvSq3dqYfw/otBLe2szHfMjawOpeKtdElXXq8sNAu
         WeFwD85/iayV4066uzuVvCKyp95v1xfuiXqs8m/5nsQjZciDrcZ7WrpH2SoYWh9pdKGj
         H7IRCjGW6vz1HB02CoJxVXR0AlE2pjR/JEshAnajLcGQZvrTgq/GOBX72ZKTzXVTG67v
         +bwEWORG08dAvIl2iFo6tgeWn3jnkR+ChDY59thxS81iQJLqe9H0U84M8fftCPFs9yNT
         Wi+A==
X-Gm-Message-State: AOAM533+7uVtzl2b2hn6JIM10j4nVCvVOldkOzTYQCHRXIkiV1dCAM7O
        lA9qBNEZSP0dbOYcIL3gauJDoLm8eRKrjMsiMcLFOGo0ZNtAd5n5abAJgLP4BoMBNHGkWlC5Auc
        Bzy9mPYLxI15No3dr9fUrA1BkXk+CWi3dAA==
X-Received: by 2002:a19:7403:: with SMTP id v3mr5510757lfe.67.1611764297792;
        Wed, 27 Jan 2021 08:18:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweFlPaOd6JrOz70L2eCnAxXX0pfzVKfa+b7ucvbp6Cvu+x/W5ZFHaoE1IaUk/1YbccIkRxYFWVcih9WZyhKjM=
X-Received: by 2002:a19:7403:: with SMTP id v3mr5510746lfe.67.1611764297557;
 Wed, 27 Jan 2021 08:18:17 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNuE3CbwGDv7mvxh67iX3zeLKTu6AJC_VoeALb_o26+zOg@mail.gmail.com>
 <20210122152552.405237-1-vmojzis@redhat.com> <CAFqZXNusUEjEqg1a80vPFbgPZLdcseC2ot6co8F4CEjb-a+vjQ@mail.gmail.com>
In-Reply-To: <CAFqZXNusUEjEqg1a80vPFbgPZLdcseC2ot6co8F4CEjb-a+vjQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Jan 2021 17:18:06 +0100
Message-ID: <CAFqZXNtq3BenouP21PHHRv20pUPtNK90WU2hGqZMUwDSxnD2EA@mail.gmail.com>
Subject: Re: [PATCH v2] python/sepolgen: allow any policy statement in if(n)def
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 22, 2021 at 5:32 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Jan 22, 2021 at 4:29 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> > "ifdef/ifndef" statements can be used to conditionally define
> > an interface, but this syntax is not recognised by sepolgen-ifgen.
> > Fix sepolgen-ifgen to allow any policy statement inside an
> > "fidef/ifndef" statement.
> >
> > Fixes:
> >         $ cat <<EOF > i.if
> > ifndef(`apache_manage_pid_files',`
> >         interface(`apache_manage_pid_files',`
> >                 manage_files_pattern($1, httpd_var_run_t, httpd_var_run_t)
> >         ')
> > ')
> >
> >         #sepolgen-ifgen --interface=i.if
> >         i.if: Syntax error on line 2 interface [type=INTERFACE]
> >         i.if: Syntax error on line 4 ' [type=SQUOTE]
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> > Thanks. Fixed. And I replaced "statement" with "statements" to allow
> > multiple statements (as was possible with interface_stmts).
> > I'm not all that sure about the last line since I didn't manage to find
> > it's meaning (but I assume IF-THEN-ELSE).
>
> Yes, the third argument is basically an optional 'else' branch:
> https://www.gnu.org/software/m4/manual/m4-1.4.15/html_node/Ifdef.html
>
> >
> >  python/sepolgen/src/sepolgen/refparser.py | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
> > index 9f850990..e611637f 100644
> > --- a/python/sepolgen/src/sepolgen/refparser.py
> > +++ b/python/sepolgen/src/sepolgen/refparser.py
> > @@ -433,9 +433,9 @@ def p_ifelse(p):
> >
> >
> >  def p_ifdef(p):
> > -    '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> > -             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> > -             | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> > +    '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
> > +             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
> > +             | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
> >      '''
> >      x = refpolicy.IfDef(p[4])
> >      if p[1] == 'ifdef':
> > --
> > 2.29.2
> >
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Merged:
https://github.com/SELinuxProject/selinux/commit/e12f71e82f523513c249dbe5a2e35c1916370992

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

