Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F9DC00319
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 19:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EB32083E
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 19:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfBUTAy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:00:54 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49020 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUTAx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 14:00:53 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7978B561245
        for <selinux@vger.kernel.org>; Thu, 21 Feb 2019 20:00:49 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id 98so45948017oty.1
        for <selinux@vger.kernel.org>; Thu, 21 Feb 2019 11:00:49 -0800 (PST)
X-Gm-Message-State: AHQUAubO1/lqNEjBpH9xCB0FHYJoRRlsHpwnLsDsHxxtabe06+R2hjSQ
        Nm0LvbNTRabxPmLWkur6LYqEbnShawdDP7FJqYU=
X-Google-Smtp-Source: AHgI3IaOKl1jrO69r2VuXniBAWFiz7BD9W0IYPNbaxqbfGR6obWdfv88fnHbGABHUOTuDN24+O+9JoBXU7Xjv9W5cL0=
X-Received: by 2002:a05:6830:193:: with SMTP id q19mr27101ota.278.1550775648464;
 Thu, 21 Feb 2019 11:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20190220160446.23150-1-plautrba@redhat.com> <CAB9W1A3GWkg+hKZVeyH31Trfiz3eiaNAXf3FEH1z=roDoBiqqw@mail.gmail.com>
In-Reply-To: <CAB9W1A3GWkg+hKZVeyH31Trfiz3eiaNAXf3FEH1z=roDoBiqqw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 21 Feb 2019 20:00:36 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mFhPWSOmpaiBHVpYOeKhCUH=qVro=X=1d=yLsQOi_wfQ@mail.gmail.com>
Message-ID: <CAJfZ7=mFhPWSOmpaiBHVpYOeKhCUH=qVro=X=1d=yLsQOi_wfQ@mail.gmail.com>
Subject: Re: [RFC] Switch to Python 3 by default
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb 21 20:00:50 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 20, 2019 at 10:18 PM Stephen Smalley
<stephen.smalley@gmail.com> wrote:
>
> On Wed, Feb 20, 2019 at 11:05 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> >
> > Default instalation seems to be inconsistent a little when PYTHON
> > variable is not used during build. Python 2 versions of selinux and
> > semanage modules are built and installed, but /usr/sbin/semanage and
> > other tools are already changed to use /usr/bin/python3.
> >
> > I'd like to propose to change to Python 3 by default and leave it on a
> > maintainer to use PYTHON=/usr/bin/python2 when they doesn't have Python
> > 3 available. They would also need to change shebangs of some tools, but
> > this is the same situation as used to be when default was Python 2 and
> > maintainers needed to change shebangs to /usr/bin/python3.
> >
> > Do you have any objections?
>
> Sounds good to me.

I agree.

Cheers,
Nicolas

