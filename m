Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7654C43334
	for <selinux@archiver.kernel.org>; Fri,  3 Jun 2022 14:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbiFCOlF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbiFCOlD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Jun 2022 10:41:03 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB8A4C79D
        for <selinux@vger.kernel.org>; Fri,  3 Jun 2022 07:41:02 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w16so757536oie.5
        for <selinux@vger.kernel.org>; Fri, 03 Jun 2022 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJ5aXOsl6ld6hTN09/GFX0IeTs6SJty1pJ8qT/1641c=;
        b=CDCottNnUclYsy8q58WS94lLKVitjnjtMg0Dx+Cn4XqbETXoRz0BNO2LNeoSSuRNoQ
         3KC1FDXA1eew6qma/aVj2LxABxqw+SvN92mm3VokV53j7qU3A2i3X7UnY73huE/QoC/G
         Nzc2+84ZHGbHExtWg/Kmem41fmsyLRGo1pe+MccBdhCpUWTIs1jEzC7uchUjs+oLy/kE
         uay3xgYAloUzS84gZrPC9qepiJSWhimltBG5J4qTLEJB5aH2WJftyT07WkL5EyHRJN+j
         PWBMfFW26aSU5oMM9r72LSziKKwXu1GnbU+1NmmI0AOhLIPI8yWKfqvj2QJrnYX6SaG8
         gNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJ5aXOsl6ld6hTN09/GFX0IeTs6SJty1pJ8qT/1641c=;
        b=aJGqeWxSnCM60xp8+vFoTVGhKW0MhBjbzsYWaSEeiBG+yAxi5Vg+e8RvysRHhBZKgI
         9wRJE8vLUbDwcoFhoX3X7O+kXWU9okK4pcBfGvgOJ/D9IHOLPbTEnpqd0zN/Tg10eWde
         /LGMD2O2ojgCltSG+a1YWhKu3L14nUwnqwhEkjPUR9LvxMW+Tw4spLOzQ6foHWA8rCVu
         AcSmMeXYKU83qrwdnC0YinUtDLf+1aHrx7p3J1dpgNnTyKfM1j0OrERlSAwCCqbjmvyH
         BVfRFo6kMWNuL1IMhH58HVq75iABCSwmA1YtlCSwQdHRo+PfUH2FWcJ12pOpkptXn4KD
         KIMA==
X-Gm-Message-State: AOAM531Z1CUgpDJHdV5DjKb8+KltNDjh8S7ZMtLW/j6efwZaMx87Cq7x
        8Oemy5ObPVdGPwf7mZYB+PHOJ2cfrPPEUN3Rq5PHpSmO3Wg=
X-Google-Smtp-Source: ABdhPJyiJc5FInn5RjjnZwhKpEJ1stmu+d8N6j+NuhMtnfJoHwyI4LMNjmBf9/fw9j7b/D7xWYpw3U1F+M310w2MdcA=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr21623812oiv.156.1654267261985; Fri, 03
 Jun 2022 07:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220530122021.3952270-1-vmojzis@redhat.com>
In-Reply-To: <20220530122021.3952270-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 3 Jun 2022 10:40:51 -0400
Message-ID: <CAP+JOzSq_rQtFfNxw7zLB22P6SM=qxVwYLsqPRZub25XECH7MQ@mail.gmail.com>
Subject: Re: [PATCH] python: Split "semanage import" into two transactions
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 30, 2022 at 9:32 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> First transaction applies all deletion operations, so that there are no
> collisions when applying the rest of the changes.
>
> Fixes:
>   # semanage port -a -t http_cache_port_t -r s0 -p tcp 3024
>   # semanage export | semanage import
>   ValueError: Port tcp/3024 already defined
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  python/semanage/semanage | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 8f4e44a7..1d828128 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -852,10 +852,29 @@ def handleImport(args):
>      trans = seobject.semanageRecords(args)
>      trans.start()
>
> +    deleteCommands = []
> +    commands = []
> +    # separate commands for deletion from the rest so they can be
> +    # applied in a separate transaction
>      for l in sys.stdin.readlines():
>          if len(l.strip()) == 0:
>              continue
> +        if "-d" in l or "-D" in l:
> +            deleteCommands.append(l)
> +        else:
> +            commands.append(l)
> +
> +    if deleteCommands:
> +        importHelper(deleteCommands)
> +        trans.finish()
> +        trans.start()
> +
> +    importHelper(commands)
> +    trans.finish()
>
> +
> +def importHelper(commands):
> +    for l in commands:
>          try:
>              commandParser = createCommandParser()
>              args = commandParser.parse_args(mkargv(l))
> @@ -869,8 +888,6 @@ def handleImport(args):
>          except KeyboardInterrupt:
>              sys.exit(0)
>
> -    trans.finish()
> -
>
>  def setupImportParser(subparsers):
>      importParser = subparsers.add_parser('import', help=_('Import local customizations'))
> --
> 2.35.1
>
