Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7014C10F0E
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F66320651
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 15:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uinxawXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbfDRPS0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:18:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36410 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389471AbfDRPS0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 11:18:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so1899403oia.3
        for <selinux@vger.kernel.org>; Thu, 18 Apr 2019 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PkokV3W5ztXBx7CNe6Bd0nQMrB2nf9QrSzfpE1GP2uw=;
        b=uinxawXjRUmB602c9pSZsw/xbrv0TJcOwTbQqUsJ6rfelIv3jeGsrNHwjtZdDIeW4l
         NYGBLHi0mWHFDkPw4x2NKCeTxbTM/m6gUTUC4awVNRpnBLkfTxdewOCO2KLlwno+TfSm
         hTLqTaU/cQE5MutJlZ6I4MuK6df9hBOFUbolf7fxMjO8NuOkKgwhYXXGgctfAfDPkK6H
         uQSMqz6UtLaNXa0+rNSKwUVhJp0yx2uv2R66Jl/4xTmOFn8wfzxS3HWcVRDa4vzgqsjh
         ZYqfsPkF7HTh98dd/mE09rruTu4BXkw7mQAuT4aCvBBLRDLYnN8blI8iERAfbHlpyGZv
         pYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkokV3W5ztXBx7CNe6Bd0nQMrB2nf9QrSzfpE1GP2uw=;
        b=C8UWcmR8ak8S607bEWL/NhtRYK3D55rWO8JGE2eQGVuKzlvcXPpKUlnqiIbuOPTkFe
         fmxBzpqb02uMtImNSwedl72UJGWC2jBP/V7Fam0eeFN5eaa+lRhZ3JpZp/Z3LrE42f05
         ubdvZKqcBrBvENOp6Rn6x3PmQhb4elWevV+vAJ5p2uwteVvlDK0AT+QReHENEU0KCbmo
         rte3aPWFnV8pSDJvBD4BIZ1q4q1c97SS/28NE8r+tT5EVo0vU/RvSUCrsK0Rce4v/P2k
         qZ0sea/e8GwlWg2pbiab2bT7wcH0O0b8amgJjzwrko7+Je06P1Hy6Km4owBngHwcqw13
         fKUQ==
X-Gm-Message-State: APjAAAUuoOa/w1dzN9mEszJDFRN9kXz5Pj0I9VHgvC+KCu2/vVj6NWQC
        YXfqfz1Eqq6Ykpxt+72AV40+r2ZYloE6nZzRneUf8khg
X-Google-Smtp-Source: APXvYqzQmpwR5jsFDJnPcBS5U1iS2NTKyj1GmaesLfgKfjEMtmQAjhcd5sxJtoxkwQduKIY3kjrfTUuELWkTLoMCfeU=
X-Received: by 2002:aca:6c96:: with SMTP id h144mr2135384oic.167.1555600705071;
 Thu, 18 Apr 2019 08:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190417163731.3434-1-gary.tierney@fastmail.com> <3ef5bbf3-4d1b-26a2-aa18-d32044259064@tycho.nsa.gov>
In-Reply-To: <3ef5bbf3-4d1b-26a2-aa18-d32044259064@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 18 Apr 2019 08:18:13 -0700
Message-ID: <CAFftDdroVYV232N7c997SgP0Owi0J+uFEnzVCdEaJAiKSz86Qw@mail.gmail.com>
Subject: Re: [Non-DoD Source] [PATCH 0/2] checkmodule: allow building modules
 of a specific version
To:     jwcart2 <jwcart2@tycho.nsa.gov>
Cc:     Gary Tierney <gary.tierney@fastmail.com>, selinux@vger.kernel.org,
        Steve Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 18, 2019 at 6:27 AM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>
> On 4/17/19 12:37 PM, Gary Tierney wrote:
> > These changes come from a report by a user on the Freenode IRC channel that
> > they were unable to build policies for a machine that has an older version of
> > libsepol installed.
> >
> > A new `-c` option that mirrors checkpolicy's own has been added to checkmodule,
> > and the output of a simple test is shown below:
> >
> > $ cat > test.te <<EOF
> > module test 1.0;
> >
> > require {
> >      type domain;
> >      type file_type;
> >      class file { read write };
> > }
> >
> > allow domain file_type : file { read write };
> > EOF
> > $ obj/usr/bin/checkmodule -m -M -c 10 -o test.mod test.te
> > $ checkpolicy/test/dismod test.mod
> > Reading policy...
> > ... snip ...
> > Binary policy module file loaded.
> > Module name: test
> > Module version: 1.0
> > Policy version: 10
> >
> > Worthy of note, however, is that these policy version numbers differ from those
> > used by the kernel policy format.
> >
> > Gary Tierney (2):
> >    checkmodule: add support for specifying module policy version
> >    dismod: print policy version of loaded modules
> >
> >   checkpolicy/checkmodule.8 |  5 ++++-
> >   checkpolicy/checkmodule.c | 29 +++++++++++++++++++++++++++--
> >   checkpolicy/test/dismod.c |  4 ++--
> >   3 files changed, 33 insertions(+), 5 deletions(-)
> >
>
> Acked-by: James Carter <jwcart2@tycho.nsa.gov>

James there's a superfluous newline between strtol() and errno.

>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
