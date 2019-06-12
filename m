Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBBBC31E48
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5620866
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KkwQ3OCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406732AbfFLPBr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:01:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32847 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbfFLPBr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 11:01:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so12403766lfe.0
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HHCDrti6hZOHHFd1mpKnLx73brcB9mCERSd3hAVv5pE=;
        b=KkwQ3OChlT1SGhZHjb9KzgGArXdQ0Dq/std7lS1DpML+cI6hpP/WBT4ne8hr2hmYkw
         PqYf+g1JoepAjFhtN4AONq2Y9oe/QcsF5s7ZEMjrhzjPzEuTX8Wzpfb5AdborLNmQsHE
         8p3d6NsfYZIW5C3BrbDXWCiymcil4LNea/80AlG9Uvfu0Q0MjoLG2viuI3z4cBnH5yef
         b4TUUqzUa2BIu7E0XcaUUOitQIlHSTF3sSaurPeWkDEnDZ9yzW7We8sXG1uQADJmkSD9
         6IF5aJ+vpR50hNyD/iQwdoUXgukc7tCtqIlGYiRFZuCtzWj5TuItQF//y37eSc/spbTY
         CR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HHCDrti6hZOHHFd1mpKnLx73brcB9mCERSd3hAVv5pE=;
        b=SO35SFOHUVARbxQXAzdknoIuSMykz6G4n4r6CgSHKl8wsSMhOb5/iXBKxmDEGntA63
         6B/B2OqU56k2o9XW7gE4YbQ2snv+etHQlo8aIKrHDYQ6ATuctWoWjQ9oIoyquXuoku10
         5bWK11woeq1HZQTDqM5dwKbcFKVoIVUXub2pavmAFxO/Ls9Nzwe97QrKUFZLB2dBsS8p
         VkmWgvhW/8EWVJO/U857v3GJuOqZp5oRwMiBwBimgiazp2o24+w9QVw8XMCY8nMSByJr
         FgnT9smSdZ8TwiPWP968cIGmIaG/MmHZlAOTeZNLfJyGxx1l7zp/f3lu12Pj8U3ias1/
         qvlg==
X-Gm-Message-State: APjAAAWjEgueJnrU9ugpTJGFdLXLA+dgAMPhg4xQ5Jiq+T40kdyh5fv6
        N6f2TkTKP6yAU9+DFJcC/LJwld/YpAn41B7XQsFB
X-Google-Smtp-Source: APXvYqzUa4qPIMP44F+BRabfYCSqJIepdYV6MTPHD6iv/GuQEMcoUX0OYLpUf6gPQK1dgHDLAI0smjWtlweRABY8wvI=
X-Received: by 2002:a19:230e:: with SMTP id j14mr2053068lfj.13.1560351704859;
 Wed, 12 Jun 2019 08:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190611080719.28625-1-omosnace@redhat.com> <CAHC9VhSXZp6QierOGRBXmyUf=pT3Y4mf=78AmQAquuQ8-WBSGw@mail.gmail.com>
 <CAFqZXNsD06JYYNmpOYyGrxLHCfvVyUSJMZ3mRTWG5-b2Ws7zQw@mail.gmail.com>
In-Reply-To: <CAFqZXNsD06JYYNmpOYyGrxLHCfvVyUSJMZ3mRTWG5-b2Ws7zQw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jun 2019 11:01:33 -0400
Message-ID: <CAHC9VhSs4pEDL+fSFCqd4xNLqXgEQ42Qh0p2uhePnbx9ZuxwgQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: log raw contexts as untrusted strings
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 12, 2019 at 3:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> On Wed, Jun 12, 2019 at 12:56 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jun 11, 2019 at 4:07 AM Ondrej Mosnacek <omosnace@redhat.com> w=
rote:
> > > These strings may come from untrusted sources (e.g. file xattrs) so t=
hey
> > > need to be properly escaped.
> > >
> > > Reproducer:
> > >     # setenforce 0
> > >     # touch /tmp/test
> > >     # setfattr -n security.selinux -v 'ku=C5=99ec=C3=AD =C5=99=C3=ADz=
ek' /tmp/test
> > >     # runcon system_u:system_r:sshd_t:s0 cat /tmp/test
> > >     (look at the generated AVCs)
> > >
> > > Actual result:
> > >     type=3DAVC [...] trawcon=3Dku=C5=99ec=C3=AD =C5=99=C3=ADzek
> > >
> > > Expected result:
> > >     type=3DAVC [...] trawcon=3D6B75C5996563C3AD20C599C3AD7A656B
> > >
> > > Fixes: fede148324c3 ("selinux: log invalid contexts in AVCs")
> > > Cc: stable@vger.kernel.org # v5.1+
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/avc.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > Thanks, the patch looks fine to me, but it is borderline -stable
> > material in my opinion.  I'll add it to the stable-5.2 branch, but in
> > the future I would prefer if you left the stable marking off patches
> > and sent a reply discussing *why* this should go to stable so we can
> > discuss it.  I realize Greg likes to pull a lot of stuff into stable,
> > but I try to be a bit more conservative about what gets marked.  Even
> > the simplest fix can still break things :)
>
> OK, I was a bit unsure whether to mark it as stable or not and
> eventually inclined to do so... I'll try be more careful about it in
> the future.

If it makes you feel better, it's not that big of a deal, I just felt
it was worth mentioning since we've been doing a bit of a "best
practices for submitting SELinux kernel patches" on the mailing list
lately and I felt this was worth mentioning.  The basic idea is that I
think marking something for stable shouldn't be taken lightly and it
is worth a discussion, even if it is short.

--=20
paul moore
www.paul-moore.com
