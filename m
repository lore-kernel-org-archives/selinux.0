Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E98C433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Jun 2022 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiFFU4r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jun 2022 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiFFUyQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jun 2022 16:54:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A8CE5E1
        for <selinux@vger.kernel.org>; Mon,  6 Jun 2022 13:43:36 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w16so11399763oie.5
        for <selinux@vger.kernel.org>; Mon, 06 Jun 2022 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7jJEBeTUMr1Mwg2FeytohJBRezv9oQflB/Xy2VJVWo=;
        b=V11yT2TMbN3dRCP7LJi7Q/AZ2SyQNEEBLZSdczf1xrQKgF06KZQIK4axKjpeQVul0u
         kIumak7wCW4DaIoorllg3JB1m4LuDQjAWl3wwnxXJajZuX7lbebjtP/YZgZy+8a/+lFQ
         PwuE2CDfG5PDWsatCn7FsEbq6dRpLSWGH46F8dYVT7I75QRh+rA1sHItkRFsYgeS7ZC9
         5MTc0U5wEGUvVI/H0+PVvHLeEmstM/4KYw2lik3cu0Ab/8GaVSAGyhP45i24P4omdt9P
         xiqyDdvDqxFH97/XfSKTSqulqvjwjAHLmZsgYbvNpS9JZI3dAPxyPOwOOAAbyLDhBSK0
         KZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7jJEBeTUMr1Mwg2FeytohJBRezv9oQflB/Xy2VJVWo=;
        b=UtG0+3jMdCzuvQZakk3uXtnyUEBPO+XTAtLwasU6v1t7vAiESJOvPdiaOfWjsIs6Sp
         Dno+onAkcZfCJwJ3Dj9jirhQ33EjDa14AFyxdYGjzrSu3Hu3S1nH5DIFTtN1Yk9I+o58
         CNAd8Rrt3mdYrnvGEWSG0NZO3HWJyZKY0Jr9zyvUsTYSRDWG3UqVjIza9Xre01x5aw7d
         g8UWD2Gpv1Lctt+Vm0UbbWL4zBApEcj5DqaMWmrt61aCEy/leQWHS56oPjEO6+LzT8LN
         TIm31DCtv+He1LZzKXs3LdDoDx6h8Yuzwn1J0iUh4Vjp+dDVXuSrurPR1Kjac9RVo1kH
         cUqg==
X-Gm-Message-State: AOAM530lMJxaQA7l/G7bVVD2OngkWvmomxWI1GhO6eujtUN4xZZEje7K
        VZrKl1i1gmhlYmeeo8Epgs32dyUPwfTrbcsMOzCaYYRT
X-Google-Smtp-Source: ABdhPJxNdg54tFs0j+j95DaZgSc0ZFAEdsPqIBoVQfB/phOKfpAyZA8q1Vhmjt/aBiecfjuAotJVn/j8Mc/afkB3gFA=
X-Received: by 2002:a05:6808:208c:b0:32b:91e4:32e1 with SMTP id
 s12-20020a056808208c00b0032b91e432e1mr15385584oiw.182.1654548216258; Mon, 06
 Jun 2022 13:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220530122021.3952270-1-vmojzis@redhat.com> <CAP+JOzSq_rQtFfNxw7zLB22P6SM=qxVwYLsqPRZub25XECH7MQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSq_rQtFfNxw7zLB22P6SM=qxVwYLsqPRZub25XECH7MQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 6 Jun 2022 16:43:25 -0400
Message-ID: <CAP+JOzS3PfFJG65SANNgQ-NCE_5je0SDE+3ZHHJUAGrC21BbcQ@mail.gmail.com>
Subject: Re: [PATCH] python: Split "semanage import" into two transactions
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 3, 2022 at 10:40 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, May 30, 2022 at 9:32 AM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > First transaction applies all deletion operations, so that there are no
> > collisions when applying the rest of the changes.
> >
> > Fixes:
> >   # semanage port -a -t http_cache_port_t -r s0 -p tcp 3024
> >   # semanage export | semanage import
> >   ValueError: Port tcp/3024 already defined
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

>
> > ---
> >  python/semanage/semanage | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/semanage/semanage b/python/semanage/semanage
> > index 8f4e44a7..1d828128 100644
> > --- a/python/semanage/semanage
> > +++ b/python/semanage/semanage
> > @@ -852,10 +852,29 @@ def handleImport(args):
> >      trans = seobject.semanageRecords(args)
> >      trans.start()
> >
> > +    deleteCommands = []
> > +    commands = []
> > +    # separate commands for deletion from the rest so they can be
> > +    # applied in a separate transaction
> >      for l in sys.stdin.readlines():
> >          if len(l.strip()) == 0:
> >              continue
> > +        if "-d" in l or "-D" in l:
> > +            deleteCommands.append(l)
> > +        else:
> > +            commands.append(l)
> > +
> > +    if deleteCommands:
> > +        importHelper(deleteCommands)
> > +        trans.finish()
> > +        trans.start()
> > +
> > +    importHelper(commands)
> > +    trans.finish()
> >
> > +
> > +def importHelper(commands):
> > +    for l in commands:
> >          try:
> >              commandParser = createCommandParser()
> >              args = commandParser.parse_args(mkargv(l))
> > @@ -869,8 +888,6 @@ def handleImport(args):
> >          except KeyboardInterrupt:
> >              sys.exit(0)
> >
> > -    trans.finish()
> > -
> >
> >  def setupImportParser(subparsers):
> >      importParser = subparsers.add_parser('import', help=_('Import local customizations'))
> > --
> > 2.35.1
> >
