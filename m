Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF17C3F2C0
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFF824677
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp9Iz9VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgB0Vb7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:31:59 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:33142 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0Vb7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 16:31:59 -0500
Received: by mail-io1-f48.google.com with SMTP id z8so1167209ioh.0
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pG3DRUaQHUL/RDKvlw4JNMaYYl0+U9kM30S1/i9iqRY=;
        b=Bp9Iz9VTqjjCCitdtadHaCR5ZkwF4XltDAgRNHuYfqCjw0WHiMslrAlTDimuNMWCqW
         +atK73bfPK2nFVLKJDw5DkofO3SgxDEhWr0xhWv7V1belVk8UhVCEpdV68iZixv9Ui5r
         H81xDC9NigKNrqOk6SMiAqdF9kDN/SRUNMA874TeTUCyBXkqbT2SQyIHRrcE1EwQIr9J
         gpxJtC+Z2OWvRdPsPdY2ypFiYAvkWvEZV0IFNMpxOhO0dYiP8bBCUOkrv8mxqiVf0+w1
         7c1bl4I0XP5C/1yUE8MFVUfSLKu0XsiAbJuZ8bfERd93wha9oOiJHJT+3/FoCK04cRER
         WfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pG3DRUaQHUL/RDKvlw4JNMaYYl0+U9kM30S1/i9iqRY=;
        b=db2bbUIc2qIZg31sqqAv7amIyl6wNsRcjm7+q0jCGZzzbgPVmm82J+UES4FaeMUanL
         ctQNQDWLl/hcKxaJqPGSR7BYaAXYEQW1svZ6fv3xPicYKpwpORyg4O0hOwplS4JNCL/N
         YaP3IP6IjPxwL+fDC5ZfkOE7Nr2YySfnrFV/XO9nw8ViVM6lUWvrle5HT67ds2p/XtCy
         HfriDYnAG0zRpmbh6/fWFSzRMUtDSRgIrepmKVrBFRQViq1Os7rbNKvqqOlsElyQoCMl
         ky/22Fv68EAo2cxIXDandL8dPtOuXXHb5Ir6NDR41ztZhIwbGKZNPbkQZcFgspIwMsjs
         ZzEA==
X-Gm-Message-State: APjAAAXrrxV6Az08a9NxzCkxX4IsBoojS6xi5UlWnN+iGxBmXg1amce1
        lSCi4xSsafKntAOYzpexFo/6QsyMhhA9IiIE1PzuXA==
X-Google-Smtp-Source: APXvYqxIItH43fQz+X2HT1Ajy95XoJP1WGM8eceMZ+SB65OtabSq0OKK3VeMVmwThTobVKfAjVdqBtGIOAQ+cMt1YO4=
X-Received: by 2002:a05:6638:198:: with SMTP id a24mr733533jaq.27.1582839119110;
 Thu, 27 Feb 2020 13:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
 <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
 <19b672ed-e4d6-5c14-6839-a9203690b7e1@redhat.com> <CAFftDdri97VAa8jwN+3JcLW90mFXjEBMfPnynix=ZpYW6R51rA@mail.gmail.com>
 <741730b7-fc5d-21a1-8722-fd964153d4dc@redhat.com>
In-Reply-To: <741730b7-fc5d-21a1-8722-fd964153d4dc@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 27 Feb 2020 15:31:47 -0600
Message-ID: <CAFftDdpH2G69O13CfLSyE85NLRvmF81460QUZoVjgzBuYRvuXg@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Ulrich Drepper <drepper@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

<snip>

>
> > This seems like it might be good for specific issues, but I don't see how this
> > infrastructure really prevents or fixes anything besides complicating the code,
> > perhaps enlighten me?
>
> Again, it's a semantic change in addition to a performance regression.
> Didn't you read the part where I suggested just using this one compiler
> option?  How much less work are you willing to invest?
>

No I saw that, and it's it's fine and all and we can add it, but
it limits us to gcc 5.3+.

But we would still need a map file for basic hygiene on what we are exporting.

But this still seems like solving a problem that practically doesn't exist.
