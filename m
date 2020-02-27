Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE7C3F2C1
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA04246A1
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 21:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRgPZzkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgB0VMA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:12:00 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33800 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0VMA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 16:12:00 -0500
Received: by mail-oi1-f170.google.com with SMTP id l136so728882oig.1
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R67XpwOoZo0aS+Gl1xJfaaPq6/Dw/z4nWvFE6legRLE=;
        b=JRgPZzkdt264fy7IyFWC2I5QYm5TbQXMV17lSE2MXiS9bl+63V72ClNqC0lM4cDXIk
         oWF8X8hbgbI3ORZU8zn6tbnb02CWFBo1GB4SeDn4RaaFmXtsnmxHqXo8m5kiTOx/TyBg
         VGUagLKBoslMtvJBfitnJ/TPLG/QT3gpkwDPDphUnemw8Rctn7UEjxTSYyGw5sgnhc20
         K+V4NlQthXMb59+g5DWHHqXtwbQc2moyO6Lx2iluctgT8ZeVHRuLwGkr6yIRjw999omv
         wjM4Xolppp9i8diDZjMtKr8eTo01pXk4XH+WlksH6gIXioF9sv4Gl29G9sF9rKYow8di
         LF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R67XpwOoZo0aS+Gl1xJfaaPq6/Dw/z4nWvFE6legRLE=;
        b=cLsfflHpuz9XlX6Jq0/kWUPsVPZw5KIWoRZTQpUkLfh4GK4SPjR/Z56UDJXSOOzZGu
         d6PDZACHOqjKl4+jsoCwjiDfSjSNVPUw+N9MeFTAX4xBTaxQIB/aoCh9zdJCW3r1+L7J
         Vvtuv1UzrtYze7RhxLB2A+WMHMGNNHPa33lCzAhGKEUCQ0svCYlFwfCYgewZFvILk/vs
         H/ucFg8mBXkRLxrSyNQBVj4h6btd2r32aRXqkMwQhe4T7EDXL22H5E1cgvHyUvU1drQy
         NyKdXyRw37A2q+gdC/AgANcakwCKHtPSTL8Vl53FlJHlVMIHA2Zl7JPYM49ksOpOsUhd
         ewWA==
X-Gm-Message-State: APjAAAXTj4aTW1g8BONz14B6Ozu11aSt+BocGymNASD1yWxoBSud5l6H
        lS4HDt2BfQCexPeqZRH/MtefadeBzBRoGNtJuv8=
X-Google-Smtp-Source: APXvYqwS9RZ5T+UoGmkhTylU0wbw5D3rMpDNGQmqEgYkAjpoT6hwh7gQHAfQXAyzi5Ti/ShADDJb+uJg9sbXBzzR4Fw=
X-Received: by 2002:a05:6808:48c:: with SMTP id z12mr755291oid.92.1582837917991;
 Thu, 27 Feb 2020 13:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
 <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
 <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
 <CAFqZXNtRmp-TiNupX3xgOWiBYun4gK0E3TJcoo4-_b2RF2+Duw@mail.gmail.com>
 <19b672ed-e4d6-5c14-6839-a9203690b7e1@redhat.com> <CAFftDdri97VAa8jwN+3JcLW90mFXjEBMfPnynix=ZpYW6R51rA@mail.gmail.com>
In-Reply-To: <CAFftDdri97VAa8jwN+3JcLW90mFXjEBMfPnynix=ZpYW6R51rA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 27 Feb 2020 16:13:08 -0500
Message-ID: <CAEjxPJ7=WO0CO3Wj=KLMzH56Fg=WMbjjJHN+qAh+e30juKdVgw@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 4:05 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 2:43 PM Ulrich Drepper <drepper@redhat.com> wrote:
> > The use of the hidden infrastructure is not just a means to reduce
> > overhead in the form of PLTs.  It also ensures that internals for the
> > library don't leak out.
>
> Linker script? We just use a map file that has everything local except for what
> we want to export.

That just controls what is exported.  The hidden_proto/hidden_def
stuff is to ensure that when libselinux calls one of its own exported
symbols, that symbol resolves to the actual libselinux implementation
and not something provided by some other DSO earlier in the search
path, which is otherwise possible.
