Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEA3C04A6A
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 19:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjHAT60 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjHAT6Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Aug 2023 15:58:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35BECC
        for <selinux@vger.kernel.org>; Tue,  1 Aug 2023 12:58:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-563d3e4f73cso3533426a12.3
        for <selinux@vger.kernel.org>; Tue, 01 Aug 2023 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690919904; x=1691524704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ60QsDuNv9KZXlZGxSRT7LD+L7SqKyY+ElK9VKIukA=;
        b=M7jZOhi7PPkt+eTjN623MOBSrw21uusjUC9UJ/mBZHffoCyNOA5IVLROeVbs9Sk5ZA
         8LqJGXC7umVvkzsCV6Wa+o4BQU+xoJksRvW8foBo7DkzxkxjIVq1osw1U57D15Qetruj
         /1rrovg2JlkKs6DXYubN1zLSZnf04ao0BDYeKFCpRbIl5v0tjvwDTJfsE/EGZq258R+B
         trqwzgJ89AHbT8fShCiQZTjgrgwFBqxY6o0Brptk7UNV6/SWdEupMzi5XPbEgP1BBwwA
         30KOLIa6S+7XhEaAfmv2ygZlg9LlX8AAO68Kz58koXrU5JYf4Gvic2KYS26j5wOWfTwB
         8B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690919904; x=1691524704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ60QsDuNv9KZXlZGxSRT7LD+L7SqKyY+ElK9VKIukA=;
        b=eXLbRy7YFyPvsNS7hXLSwaDX3gVYSXV4v982IPamTgvWFa3R52UNxQIgGx477MB3W/
         IDQorJ3ZUWQCSoLmoTVXhCTx91PtDzieaLigTHSu27mL9rSDoSukWkF7scLwaaJN6fLb
         x634mQlfqM22X9y272Vono6R/lCyCHyBgA5YaCW+1RBLN9mepnM4fTk9+BmkG7BKwiVB
         nS4bMuPfpNK3tiSD8XjJPT3OgoXo85oeg8KSeS3H+0eXID3IcrQwF5mwSCJPTUR0WYgj
         86QMx6Z5nrT/mNosZM5mGkFRmfb/lwe7b0Rdga7Z7S6hfI3XdE8lNEs/HLP0EgAwp/QF
         XnMg==
X-Gm-Message-State: ABy/qLaTiAnDR+79z4guLQq5+rqrYipzcL5oDxcdEPku+aNb1IVvRd2x
        DHb5SVphmevokVBFD1XexSEDmYt6gIihHAxpnjAgFQqQ
X-Google-Smtp-Source: APBJJlFUfZV6rqEgYNwieRtOkvsxQdJxXXepCKYNvCWFLYR5zFp95y1q5g6e517EmPGsmvx0ciG4BeeYAOnlKNXE66s=
X-Received: by 2002:a17:90a:cf93:b0:267:f2f4:feb1 with SMTP id
 i19-20020a17090acf9300b00267f2f4feb1mr12229319pju.28.1690919904106; Tue, 01
 Aug 2023 12:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <5d5fdc57-6bf3-ec9a-b71b-b17e259f55d7@gmail.com>
 <CAEjxPJ63oh92-49Oz3BjVxc=Kn6Rcwf1BbdziE_qLTnQ24VbLg@mail.gmail.com>
 <aced6072-1ca3-e01b-4964-67c36a869824@gmail.com> <CAEjxPJ6f7SAO9gbkvriReDyqpAUMT5WT7cp64Me+8SUn8h93AA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6f7SAO9gbkvriReDyqpAUMT5WT7cp64Me+8SUn8h93AA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 1 Aug 2023 15:58:12 -0400
Message-ID: <CAEjxPJ7mu39hGzNx8HN0HAm_h1KpGcrryQW5qHiOYEhf76p-OQ@mail.gmail.com>
Subject: Re: Network ports - multiple types?
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 1, 2023 at 3:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 1, 2023 at 3:38=E2=80=AFPM Ian Pilcher <arequipeno@gmail.com>=
 wrote:
> >
> > On 7/31/23 07:13, Stephen Smalley wrote:
> > > On Sun, Jul 30, 2023 at 5:03=E2=80=AFPM Ian Pilcher <arequipeno@gmail=
.com> wrote:
> > >> # semanage port -a -t fdf_port_t -p udp 1900
> > >> ValueError: Port udp/1900 already defined
> > >>
> > >> # semanage port -m -t fdf_port_t -p udp 1900
> > >>
> > >> # semanage port -l | grep 1900
> > >> fdf_port_t                     udp      1900, 3483
> > >> ssdp_port_t                    tcp      1900
> > >> ssdp_port_t                    udp      1900
> > >>
> > >> And, sure enough, my FDF service is now able to bind to udp/1900.
> > >>
> > >> I was not previously aware of this feature, and my internet searches
> > >> aren't turning up anything about it.  I'd just like to confirm that =
this
> > >> is expected behavior (as it just seems really weird).  Are there any
> > >> caveats to doing this?
> > >
> > > As far as the kernel is concerned, there can only be one type assigne=
d
> > > to a network port, so your new definition is overriding the earlier
> > > one. Is the earlier one in a policy module rather than being created
> > > via semanage? A potential concern with what you are doing is that any
> > > rules written on the earlier type obviously won't be automatically
> > > applied to your new type, so anything relying on that behavior will
> > > break.
> >
> > Yes. The earlier context rule (ssdp_port_t) is in the default Fedora
> > policy.
> >
> > Just to make sure that I'm understanding you correctly, it sounds like
> > modifying the context of a port with 'semanage port -m' effectively
> > changes it to the new type.
> >
> > So is it fair to say that the 'semanage port -l' output in this
> > situation is deceiving?
>
> I would say so, although technically it is an accurate depiction -
> there is a rule in a policy module that defines it one way, and then
> there is a local customization that defines it another, with the
> latter taking precedence as far as the kernel is concerned. Confusing
> at least.

Generally redefining a port type like this isn't recommended because
as I mentioned, it will cause any allow rules in the base policy
written against the other port type to not get applied to this port
and hence may cause breakage. Usually you would just add allow rules
permitting access to the already defined port type, and only create
your own portcons for ports not covered by the base policy.
