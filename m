Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D404C433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56598205ED
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXH3VRTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgEMPxw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 11:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgEMPxw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 11:53:52 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF7AC061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 08:53:52 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w11so18555121iov.8
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJ1ljmYjS2gPZ0dIOVlnGicYB/OfDXHtcE08OiBpqHE=;
        b=LXH3VRTxOeS6E7kG9Fm72kq9dSaDubgTqtrPOsx4RXlGzFrD37m3KDvdlBYdvHmSIn
         Tdm5YGaAgyrbShaXNeB8U7qD0IDqDub28eDGJXTlDEIMpnCWqPiS0t4yvH0cMMCfgA3r
         84l2sodnq0Gl2NzIpoSLezfmu/PiAODp57u8cxH3g2fTF/vdQI9txFdd0FVnj0eEQIDe
         xQmNnXJyTtbTyBfxtRFesf9y/AEj7ZF9mph4/Qw+IHQcQC8pJIjYgCnHR4J4HjT1aRIZ
         3ix1L0prD9C5A5wr2BLPtFFLHi6OG65kCGkW6vt6XKPVwT971/sH/mr8wQuRSDhgEpgP
         furA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJ1ljmYjS2gPZ0dIOVlnGicYB/OfDXHtcE08OiBpqHE=;
        b=IEjmEBLfxH9u3/hQb/lq387HPgSHFPJrkNls4WITxDH7lKTrH9JZV/iJPzLq87Mc1q
         A/Nyia9VbjdMbj5w3/su7b+izaYXzzl/1Q2lYg7fjVHhX9FtPYHmL6S4sQ2jtEvLHKx8
         iDQi8h4s4BaJwF9h57/1DRI2ifAXHim2Ram7lLkeNE1kIl63mR8EH5nrqYoOv7NaPsvF
         +HvXw5mObXBhQ4uSyQ56GRQixX0gdHf9tX95Aq6uPO/a2/SJWH+JhPEq9fk/x/uPW3sk
         irRcdgwetTlVNoNk33YU4fqdhWGa2URWYv/+ksmDL3BZjQcppQgcxYrtTaRxkwQYz6Iz
         HEcQ==
X-Gm-Message-State: AGi0Pubd8+nFP1pzZ4Vds15wqYyE0XJ5WKj0IiHAwGBWM/Ahej/rE+dv
        j7Fgxtkm2ynQFrj4KiAXWs9wGkVVLcytJvK4TVSzGvOeBnc=
X-Google-Smtp-Source: APiQypLgow0IOx2CXAV+YSlmagQITrBxe0giZRcdNk8q/uektcckSggmYQm65GY+2VwBCQO9BOXczPj0QFoidPNEyeM=
X-Received: by 2002:a02:210c:: with SMTP id e12mr213306jaa.130.1589385231441;
 Wed, 13 May 2020 08:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200511120332.26029-1-plautrba@redhat.com> <20200513151055.GA184174@workstation>
In-Reply-To: <20200513151055.GA184174@workstation>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 13 May 2020 10:53:40 -0500
Message-ID: <CAFftDdr_Y5cm8mzGyBFwROxTfT+6RePRqe04+hKmhWfkByuwUg@mail.gmail.com>
Subject: Re: [PATCH] run-flake8: Filter out ./.git/ directory
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 10:11 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Mon, May 11, 2020 at 02:03:32PM +0200, Petr Lautrbach wrote:
> > When a branch has '.py' suffix git creates a file with the same suffix and this
> > file is found by the `find . -name '*.py'` command. Such files from './git' need
> > to be filtered out.
> >
> > Fixes:
> >
> >     $ PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8
> >     Analyzing 189 Python scripts
> >     ./.git/logs/refs/heads/semanage-test.py:1:42: E999 SyntaxError: invalid syntax
> >     ./.git/refs/heads/semanage-test.py:1:4: E999 SyntaxError: invalid syntax
> >     The command "PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8" exited with 1.
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Applied.

I updated the state to accepted in Patchwork

>
> > ---
> >  scripts/run-flake8 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/run-flake8 b/scripts/run-flake8
> > index 24b1202fde99..67cccfe99e5f 100755
> > --- a/scripts/run-flake8
> > +++ b/scripts/run-flake8
> > @@ -7,7 +7,7 @@ if [ $# -eq 0 ] ; then
> >
> >      # Run on both files ending with .py and Python files without extension
> >      # shellcheck disable=SC2046
> > -    set -- $( (find . -name '*.py' ; grep --exclude-dir=.git -l -e '^#!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | sort -u )
> > +    set -- $( (find . -name '*.py' ; grep -l -e '^#!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | grep -v '^\./\.git/' | sort -u )
> >      echo "Analyzing $# Python scripts"
> >  fi
> >
>
> --
> ()  ascii ribbon campaign - against html e-mail
> /\  www.asciiribbon.org   - against proprietary attachments
