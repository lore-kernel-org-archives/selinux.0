Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7016EC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 17:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F50F2073E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 17:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quhYJLX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCZRC4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:02:56 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37326 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgCZRCz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 13:02:55 -0400
Received: by mail-il1-f195.google.com with SMTP id a6so6052719ilr.4
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06YEmB8TjY4oQzWXzMteaZ1EZUaxnaadaj7gcB5Cb6c=;
        b=quhYJLX3IPqhloUqw2SnEgn+LMS1vgzku62hYxNMxGNi1LUTwVo2j70KxMNwQ0YHfq
         rwz+PKwtNsdiZfCPGBZ1qBuHqIHj1kyf6EiQclUHDA4dy73sI1qadR88Leq7IYfqq1zD
         furtcqV63Vu4DZDj1bQye/OLgJq+XHOP+FZkyfMJFJLeJvIR0HxsadXgzpv5eMDUCe32
         pMTyYcSxIOzRoLDscrkMkd23xMlxrsUnlMr5TviFB1UHMB9I7G4fqtbpGewDqJdK6xcz
         TCbeIg9btzkdZywZPN6CVnb5C8VUxE5F3QUnu9J7gAmpUHZKsFATOar6zDfQpbkLYm5P
         cjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06YEmB8TjY4oQzWXzMteaZ1EZUaxnaadaj7gcB5Cb6c=;
        b=WA3xOhygC94nRDmoe7vf7OcyLvXbncZGahi1Kwhp1d5SDBqSil1ied4ZQleXtfGSW0
         EZlpsKB/Eihkb2jzXRiXRbqn9E55tOftpYVRkeTUq7/Ky6XaGVFfrJhwX/dcrYKHVEct
         Tl5cCIgcA4C5eKdg9xnOrUtI3r2E4rc1ZjEarMngKDdIwY96WwIVLGnbwbFgDXnlpVEL
         uNf2tOM0KyQ/GqUpp71ZIkwtEtQj6YXOTgR2gLvbpUp4E6LE+tig35z7ajwc/YrFyqJo
         GzdohyDDMVxQZWqUhTxtsiGbnRQcsBCU0Lt09wtxSMNfjkb6G7CYiYoX1QezebewtlsL
         McrA==
X-Gm-Message-State: ANhLgQ2D4AxdqnaZ2fhrnfY5FgSvbEFPDPr38jDvN+DRnGg0m+EqfOHW
        zwggigegw5PsBLacvnmbUHho8wnqVgtXDZ2qnJnCQK3LzvM=
X-Google-Smtp-Source: ADFU+vtwVoCrt9OmF4UzfTTVmkMvPwxZX9X3+RjhX659tC1umTV3B6lDBxroAWGy5t7qrJ0OdcZ0hpEId5/M85TeeTM=
X-Received: by 2002:a92:d3d0:: with SMTP id c16mr9831231ilh.22.1585242174176;
 Thu, 26 Mar 2020 10:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdr=2ji0=dG2Jc2A=rTcu215ETkeEkBxnp3UMeXzp=VRkA@mail.gmail.com>
 <CAEjxPJ4iQmgz0Po7o1REc5Fb63ci=6WtF8=e6zwD46=1o9x9SQ@mail.gmail.com>
 <CAFftDdrqHVgzNx75g2UfQwwzrp+uEnOmht+Lvp3A1svt3BJn1Q@mail.gmail.com>
 <CAEjxPJ6UMs+XgBm5ry98c41zKymKxO4QfSW+eyOaUe5xgQ6eaw@mail.gmail.com> <CAEjxPJ7YLp6_cAJ1bVUDy0638FpAy99wvBfEpKJxRkSUsTD-jw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7YLp6_cAJ1bVUDy0638FpAy99wvBfEpKJxRkSUsTD-jw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 26 Mar 2020 12:02:43 -0500
Message-ID: <CAFftDdqAR10wBgg6uV2HKQPdL05=uVnn1yodW_qPFouu1Oy6yA@mail.gmail.com>
Subject: Re: PR 193 sitting for uClibC fix
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 11:57 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 26, 2020 at 12:52 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Mar 26, 2020 at 12:46 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Thu, Mar 26, 2020 at 11:44 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 26, 2020 at 12:22 PM William Roberts
> > > > <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > This PR:
> > > > > https://github.com/SELinuxProject/selinux/pull/193
> > > > >
> > > > > Has been sitting forever. I looked through the mailing list and didn't
> > > > > see any patches hit the list,
> > > > > we should either close it, or merge it.
> > > > >
> > > > > Thoughts? If we need it to hit the list, can I grab it and sign-off on
> > > > > it and post it?
> > > >
> > > > You can't sign-off on someone else's patch without them first signing off on it
> > > > or otherwise certifying to you that it falls under clauses (a), (b),
> > > > or (c) of the DCO.
> > >
> > > For some reason I just assumed it had a signed-off line, it doesn't though.
> > >
> > > > You could create your own patch to achieve the same end, especially
> > > > since this one is trivial and seems
> > > > to be modeled after an existing commit,
> > > > ab0e27003ef245f20512d1808b1dfee662ab8f41, so it
> > > > seems like it is relatively safe.
> > >
> > > I thought about creating it, but it's like how do I create such a trivial patch
> > > and not get hit with I copied it.
> >
> > IANAL, but IIUC when something can only be done one way, it isn't copyrightable.
> > Other possible ways to differentiate:
> > - libselinux/src/Makefile provides a FTS_LDLIBS ?= definition, which
> > was missing from their patch.
> > Not sure that matters.
> > - Instead of adding it LDLIBS for everything, could just add it where
> > needed, similar to PCRE_LDLIBS.
>
> Or you could just ping them on the github issue and ask if they will
> at least certify
> to the DCO as a github comment (or better, push a revised commit with sign-off)
> and then you can take it from there.

Already pinged once, I can try again and see. Give them to next week and if no
response submit something like this:

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 361506384d08..32da04068b3c 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -10,6 +10,8 @@ else
 COMPILER ?= clang
 endif

+FTS_LDLIBS ?=
+
 ifeq ($(COMPILER), gcc)
 EXTRA_CFLAGS = -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand
-Wcoverage-mismatch \
        -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
@@ -45,7 +47,7 @@ endif

 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 override LDFLAGS += -L../src
-override LDLIBS += -lselinux
+override LDLIBS += -lselinux $(FTS_LDLIBS)
 PCRE_LDLIBS ?= -lpcre

 ifeq ($(ANDROID_HOST),y)
