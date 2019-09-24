Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7A0C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 10:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048CD214AF
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 10:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw9YdA3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbfIXKvf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:51:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47178 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387644AbfIXKvf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Sep 2019 06:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569322293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tp7SgAQa8q6Ghz+WZXTg5B8RGVTXWqssMgDJWk74AoA=;
        b=Sw9YdA3sVSYvSWbMhxpxdBGbaf6AUWdK/x/PLe1Ru1hF0Akkhes9teBEMSL2cUziwqweZi
        2b4n5MPKOYaxmjJHVszILy2i4kFrrvE2jEE7SDvqRe6IY/gBKYt82Pzh1b8//F0a2FzQqK
        C+RAceYa6Cw542re4p5gqbq6J23FQt0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-ug8zgiSyOlyVbxFAan_9FA-1; Tue, 24 Sep 2019 06:51:31 -0400
Received: by mail-ot1-f71.google.com with SMTP id z24so925209otq.6
        for <selinux@vger.kernel.org>; Tue, 24 Sep 2019 03:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/hjI0ww3TOGmvkgnZtJU3xN9ds5nr77R/kT8eYxOYk=;
        b=ka0RUynuUoFAFBmP6f6Fv8mElhMgiZjIomUIsbN+3pEvQksXOSbA6fECyCHJJAmKHY
         5O34gsgfcm0tzhK7o+NFPctlavg7aNrxm59EemXpKMFYVLWc76PRR6Ka+lTdHFEmrLm3
         H4jhDfe00XQi9OXaFYtk98MNGWwq3ZyWLwfviKbWYuG08LJjSCkyHXwM8Z7BWAMLtNms
         PxBKjkM3PDO8YzSI258pvrWZCOeb0hj2yzFmpvR7rIwaWmWWQ59+h+w6YAeuoR5NsmEP
         GF6SeBsKYTLSnE+JhV9SMLuzsCZxScnO/6Rqaic94YEp6+q/edLo8EXHCkDcFdwXhU2w
         qT3A==
X-Gm-Message-State: APjAAAXUn5oHYkwGeKEPd2J0vbDZpXwzhC11MB+Y4OKw8WLeGUQpgwmz
        p4Qc6SZT0g2NLHeoD1nK8m5n/9Jfb40ylMZEhEP+KLZsF7jhsNAZx6hwY8XcRGWwvo3USr0hVRI
        jOredG9yf+F/r0jslH8Ctb8tNJ6CFE/f1eQ==
X-Received: by 2002:a9d:625a:: with SMTP id i26mr1143457otk.43.1569322290182;
        Tue, 24 Sep 2019 03:51:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxglG6teMGD+GiJbzfyVS6YFkoJbtcnvdddP0EqvxWUSpPMYKDcVPgGD1N/ol6yU7Z+zqEYnfbtQT/EGGhoMeE=
X-Received: by 2002:a9d:625a:: with SMTP id i26mr1143443otk.43.1569322289900;
 Tue, 24 Sep 2019 03:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190923095837.25752-1-omosnace@redhat.com> <b74cd6c5-0f63-80d8-99c0-967dc638279c@tycho.nsa.gov>
In-Reply-To: <b74cd6c5-0f63-80d8-99c0-967dc638279c@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 24 Sep 2019 12:51:18 +0200
Message-ID: <CAFqZXNtagT7TDgV4D88juWK7qVTEgkcjm6UL6zKsPm8gd7yyWg@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: do not rebuild policy package if
 already built
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: ug8zgiSyOlyVbxFAan_9FA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 23, 2019 at 4:11 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/23/19 5:58 AM, Ondrej Mosnacek wrote:
> > Right now, test_policy.pp is rebuilt on every make invocation. Tweak th=
e
> > Makefile so that it is only build when it hasn't been built, it has bee=
n
> > cleaned, or the source files changed.
>
> It also needs to be rebuilt if anything under
> /usr/share/selinux/devel/include has changed e.g. upon an update of
> selinux-policy-devel.

I am now testing a version that always executes the `$(MAKE) -C
test_policy -f $(POLDEV)/Makefile test_policy.pp` step, relying on the
system Makefile to rebuild the pp as needed (there already are proper
dependencies on the include files). However, the package manager on
Fedora preserves the timestamps of the installed files (from package
build time), which means that make doesn't always detect that the
files are newer than the already built policy package.

So it looks like we don't have any other choice than to always rebuild
if we really need to auto-react to changing system files.

>
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   policy/Makefile | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/policy/Makefile b/policy/Makefile
> > index a5942b3..cc0f140 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -86,7 +86,7 @@ ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xR=
HEL6))
> >   TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.=
te, $(TARGETS))
> >   endif
> >
> > -all: build
> > +all: test_policy/test_policy.pp
> >
> >   expand_check:
> >       # Test for "expand-check =3D 0" in /etc/selinux/semanage.conf
> > @@ -94,7 +94,7 @@ expand_check:
> >               (echo "ERROR: set 'expand-check =3D 0' in /etc/selinux/se=
manage.conf"; \
> >                /bin/false)
> >
> > -build: $(TARGETS)
> > +test_policy/test_policy.pp: $(TARGETS) test_policy.if
> >       # General policy build
> >       @if [ -d $(POLDEV) ]; then \
> >               mkdir -p test_policy; \
> >
>


--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

