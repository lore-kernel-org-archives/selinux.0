Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A69C0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB318206BE
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr2jxa6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgCKSOH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:14:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43705 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSOH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 14:14:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id p125so2803750oif.10
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUy4mOZBpAFOY0eZ4KfaukIAjaGTOe91sr3VJSy2fog=;
        b=pr2jxa6mpc8WDvdvju3bt2siu3Z50Yr4FbrLoXY6wIOoPQ13bK3wLn0AzDF3PxqC8y
         UTjAYrRAfDM5+bnoqiiVoD2CwnsoN4VCrr2/CQ56d47WaCzCa9uSfG1+5qF5om0k0cJC
         klaLMmVnvfzkrYIN6Lou/nf9JDynYAhG0Y+JLGlCKBu+zVPGuC5BNKFKM69ZtaT8j479
         a/1Zf6ukpIGjrulFDKrHv1NYuJd3d6v/7zkdV/WjJJxGW7PhcbgxCqGX0z8u3fuxan5v
         vy9zEQoekjY0iUj/fIq6NeeQtjp7cbAP1y9AMuHEjlVu1CdFQqixQc9tORcyLyH492eP
         poww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUy4mOZBpAFOY0eZ4KfaukIAjaGTOe91sr3VJSy2fog=;
        b=qedx+1mwsoaR3GjjeZOmOONF2sUydb/xan2LpXSLWGVdOY00RcnZD5zFS21btFR4qS
         K6Dbrsqr84krGY3VuMjiet9Q7NRwGr6hXZiYH6jACAtnl483qJNT3Z1V/D+cGqaTyqeW
         RuNL364ZbNjzEHg5MqKfN5RBWhjDz861DJayD5hUPej/3/p15exx0RgT6pXDTVZtLdI2
         O1ckfXimBuTbbmgIBRVYXnlz54kkfQUoVqfj/uqHVhdCWIx28A2Bn04PE3PcMO9o41s7
         Qy2dsxrluISjefgt7suaVyHW1lqVqYIlgJbxiJlQWGvboiaQRdd5IWlpe5yGOmd9Xpq7
         Qubg==
X-Gm-Message-State: ANhLgQ1EqRxchwAyWD96Wenm3A/CP33KKAg4bPYupDWsTabOezaoqmI/
        bX5vD6lXPmEBb6UBJUfL/7gLaS5E7wPcEwztDQcUvqpg
X-Google-Smtp-Source: ADFU+vuX0BZAF9y3Lep3w9Qau9oOBUWPPsIIDEfit944LNtPEJOoTKvRK6fLo8LUYi1iVQTwdn4WjLyNZzu3TkEp7Fc=
X-Received: by 2002:a05:6808:34c:: with SMTP id j12mr2764720oie.92.1583950446693;
 Wed, 11 Mar 2020 11:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com> <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
 <pjdd09r6ki8.fsf@redhat.com> <CAFftDdob6kA2XbsaLLKPND7uRFPFJyBwnzcPQPJ+pZsNw+vBzg@mail.gmail.com>
 <CAFftDdo2grFfgkFhSmw_XSeyu3Eo9wKvThqNyAjD73EoJdXJYQ@mail.gmail.com>
In-Reply-To: <CAFftDdo2grFfgkFhSmw_XSeyu3Eo9wKvThqNyAjD73EoJdXJYQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 11 Mar 2020 14:14:59 -0400
Message-ID: <CAEjxPJ7wqdhF5G_2n1EsGjuvHdZhLG6Ww4dEkZ+HJjbffFjDVA@mail.gmail.com>
Subject: Re: [V4] libselinux: drop dso.h
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 5, 2020 at 2:09 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 10:12 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Thu, Mar 5, 2020 at 6:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > >
> > > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> > >
> > > > On Mon, Mar 2, 2020 at 11:41 AM <bill.c.roberts@gmail.com> wrote:
> > > >> [PATCH v4 1/4] dso: drop hidden_proto and hidden_def
> > > >> [PATCH v4 2/4] Makefile: add -fno-semantic-interposition
> > > >> [PATCH v4 3/4] Makefile: add linker script to minimize exports
> > > >> [PATCH v4 4/4] libselinux: drop symbols from map
> > > >
> > > > This looks fine to me but I'd like at least one of the distro
> > > > maintainers to ack it (especially the last one).
> > >
> > > Acked-by: Petr Lautrbach <plautrba@redhat.com>
> > >
> >
> > Thanks staged:
> > https://github.com/SELinuxProject/selinux/pull/205
>
> merged.

I've noticed a change since this was applied; if I build userspace
against the updated libselinux, the dynamic loader will
print a warning if it is run on a system with the older libselinux, ala:
$ /sbin/restorecon -v /etc
/sbin/restorecon: /lib64/libselinux.so.1: no version information
available (required by /sbin/restorecon)
It still works since there was no real change in the ABI but I don't
know if this is a concern for distros.
