Return-Path: <SRS0=VGN0=RU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5103CC43381
	for <selinux@archiver.kernel.org>; Sun, 17 Mar 2019 12:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA9021738
	for <selinux@archiver.kernel.org>; Sun, 17 Mar 2019 12:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfCQMJ2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:09:28 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46300 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfCQMJ2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Mar 2019 08:09:28 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E55D0560079
        for <selinux@vger.kernel.org>; Sun, 17 Mar 2019 13:09:24 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id c18so12100100otl.13
        for <selinux@vger.kernel.org>; Sun, 17 Mar 2019 05:09:24 -0700 (PDT)
X-Gm-Message-State: APjAAAUClw8blH9YokaPgGohnN3g3siVKaA4HFFRtCL8w4oAYCMsSwBa
        vw5t0kvi4HNrZemNv0QpPYiDvIhAhADhaDwxFPg=
X-Google-Smtp-Source: APXvYqxZl6ruK2vLMq+xwI8mnD3NOQCTcGQES1mF9zQ8haEH27IvrMu2PdcC3wYFtroFL1uCgi2uSyzT/pM7IyOoF/g=
X-Received: by 2002:a05:6830:11d5:: with SMTP id v21mr3495417otq.165.1552824563882;
 Sun, 17 Mar 2019 05:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <pjda7hw5d6i.fsf@redhat.com>
In-Reply-To: <pjda7hw5d6i.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 17 Mar 2019 13:09:12 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=knPOaffhMtSdEeToA+ePRG=gxj_G=rnXkyV84nUQcZzw@mail.gmail.com>
Message-ID: <CAJfZ7=knPOaffhMtSdEeToA+ePRG=gxj_G=rnXkyV84nUQcZzw@mail.gmail.com>
Subject: Re: ANN: SELinux userspace release 2019-03-15 / 2.9
To:     Petr Lautrbach <plautrba@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 17 13:09:25 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 15, 2019 at 5:12 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> The 2019-03-15 / 2.9 release for the SELinux userspace is now
> available at:
>
> https://github.com/SELinuxProject/selinux/wiki/Releases

Hi,
Thanks for the release!

Nevertheless, the SHA256 checksums on the Releases page were
truncated. When I opened Releases.md in a text editor, it looked like
the lines were truncated to 159 columns. I fixed this issue so that
users can check the hashes of the archives (cf.
https://github.com/SELinuxProject/selinux/wiki/Releases/_compare/8957ff33d88fdc156e1d1ce48777b7f95cc5b7e0...a5ce0f3be923f2ac8e4e32b9711cdae4abad4463).

Cheers,
Nicolas

