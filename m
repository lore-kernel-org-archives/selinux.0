Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0527FC54FCC
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 22:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51B7206DD
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 22:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="um4jFtL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDTWZI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgDTWZI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 18:25:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F58C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 15:25:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o127so12971842iof.0
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 15:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T2ih+PlDWeUowkrBFf+mO0zj7Uy7mdCgxSlHDclSAbs=;
        b=um4jFtL9Ir/+ETepzXIls1N8VSfW8UX/eHD8UufqXdOWlDgBpJvdLeQ5mTsZV8IuHF
         KRtM1bnYOP9Z80Td19tJMic7pakeox6CjVEJINMbayf7Moft6IXPKnlawpLrMmIlPL+b
         Pzv5aC9pxMu59qqhlxIkGgQM9dqo1m9jtBPPYXQJRY6z2GOCh5ZIM3OLxQbhQvlsuFyb
         qovIEI6xKt5cnQUHt0cEza2SPfVBRa6a5ODCYxeXuIbBAJNN4H3imYpZDwPP2JiaAKrQ
         aTkCUDKj3diRT9Bt0/LaHaLh/rMzkIscdtCJCOdY/bdOK3wsIEhZ/zQAIuAG5qXGECQ+
         6NRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T2ih+PlDWeUowkrBFf+mO0zj7Uy7mdCgxSlHDclSAbs=;
        b=H8kF3MHA+CFh+D+94qp82v3IwXKoB8bTGoz3wm9naz8JHb4AIbntGfP6Im9jbNXFN9
         THY8E+T5bwyab1/uuvNbVs6yLhI6rLYl1ujlybHKCy5edVFlU0l7VcbT9KWrx+87slR+
         eVmO67pWU4SmTc7fg4iBOiZgq4D3gceNQphDChZ9T+8fKEFKPdOPRjiEy1NhiOjajy3a
         HWhxAcLxp6WFbePdkwMMtCjmi/UO6saGkqX+7QVsx/hI2e9ijuR+Vc6FHyWg1A2JWmHP
         BLhqizRqHr+8jLfogIzhbS/ov8Ji43ft+KS+T9VBycLAu1OmvaecNzeL75/ycGkUpjDK
         dKrg==
X-Gm-Message-State: AGi0PuZ1ffc0eGIh3e2Gyn0gml75J3y/zKqEg+D+nO2XgshQUG0opfzS
        O1KszTxSuH7Wh9/T78ghpvlS144vRah/lXmVBIM=
X-Google-Smtp-Source: APiQypIHsL/ac0wn2wioLA0O/6Rx1iz0EWqAwEsXdoRvLjlYoc4GG4f+M4pITnQ+DPjvnIqhe8hkPVy3D1/6+4f25eY=
X-Received: by 2002:a5d:88ce:: with SMTP id i14mr18060173iol.184.1587421507231;
 Mon, 20 Apr 2020 15:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200419140055.86159-1-nicolas.iooss@m4x.org> <476DC76E7D1DF2438D32BFADF679FC5649ED3B7E@ORSMSX101.amr.corp.intel.com>
 <CAJfZ7==KyK=+AE8+tojCbZRo-UnB-QwEgL8tseLSfq73kL+mQg@mail.gmail.com> <CAJ2a_DcwDeMcF6XTokC=y41uyTgC2-oG0ZpEGYqD2t5QkBMJ1g@mail.gmail.com>
In-Reply-To: <CAJ2a_DcwDeMcF6XTokC=y41uyTgC2-oG0ZpEGYqD2t5QkBMJ1g@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 20 Apr 2020 17:24:56 -0500
Message-ID: <CAFftDdoi=fN5KvMq71bTF0+D3dnPZP8Gd3FV62XAvCtFBOXO6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] python/semanage: check rc after getting it
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 20, 2020 at 1:38 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Am Mo., 20. Apr. 2020 um 20:30 Uhr schrieb Nicolas Iooss
> <nicolas.iooss@m4x.org>:
> >
> > On Mon, Apr 20, 2020 at 4:29 PM Roberts, William C
> > <william.c.roberts@intel.com> wrote:
> > >
> > > We should probably add the checker so it comments on the PRs. It woul=
d have caught it
> > > Before it got in tree.
> >
> > In this case, the bug has been introduced in 2008 ;) Anyway, I have

For some reason, given the timing I thought I missed something in the revie=
w of
the other patches. I guess I should have used git blame vs assuming!

> > never configured lgtm.com to look on PRs, or contributed to a project
> > that did this. For SELinux, I am wondering whether the hundreds of
> > alerts currently reported in
> > https://lgtm.com/projects/g/SELinuxProject/selinux/?mode=3Dlist could
> > affect the usefulness of having it integrated to PRs.
>
> I think lgtm.com only shows new issues on pull requests.
> For example systemd uses it and I never got an unrelated alert.

Exactly, it only gripes if you add. So they will help keep the list
from growing at least.
