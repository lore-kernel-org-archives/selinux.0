Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C7C4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4C22054F
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 13:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSEf/7Tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfIRNwE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:52:04 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36128 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfIRNwE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 09:52:04 -0400
Received: by mail-wr1-f42.google.com with SMTP id y19so7038159wrd.3
        for <selinux@vger.kernel.org>; Wed, 18 Sep 2019 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0IVkZauId8ilfNOH3Ft7oo547KiWt9vuUCD28/A/ew=;
        b=XSEf/7TvwIAGIxONctwbQExSiF+q5sA8EsrGEb5ThgaDchqPDb4u8yw1nufNnIHI/b
         tfszy1laWDOeYBpRncORhRWYJDLxUVNMcZ0Eqrn12+hNOEpNK0Kj30OQ6ylwy8EmzBbW
         se6PBor1xNd/QPOrDbe9LqQaROO7fSGbvDAvMXKp9Ms0w6xR6gYC/seY/DQVrlrKVSoI
         HtzGj1Xb4Rcod2UW/g0m1HG8ODLKs+d7CunsgpOiRJcWtF6lCueAvBYcGyZbEIkF389T
         Oy///ul8xa9wQGsdPezx6cvSRFOYGL3FEjUk+LzLqEWKqHvnDMBfh2DVqM9YnjkYwCWb
         OUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0IVkZauId8ilfNOH3Ft7oo547KiWt9vuUCD28/A/ew=;
        b=VtwBHZdJAj2Xvaf+WdPIIOY7WFQkdVhfgBAmi9FrTDZG+1bXbc+smzgVyID8GioypN
         Ye2i8+wsGS3agFG97hEW2b3ibDYm0mfr1JkmTmS70Gd95YXVrP0r5tSsRIt9TnoKSBQd
         XpTOXBWHgJcozTiHFoT9q/d7Hj2qSr4dgReVMK/cUPXcVikpRFKKD7L1TbsEdY9Sx42h
         RpKAUFHhwZRKHg5J5NhdHEV5dGrpZaU7ECwSMgpLos4ZuhejVseVmkm8+xOX8MvKizoa
         h6KDHPIRUCqgVmZrLnAIW9kTEl7Fo4wFZ13/GYBiywBaGy78oop2UaQtQbj29jNy0C/8
         zELg==
X-Gm-Message-State: APjAAAX30jE2zgNKdBQ56RuWfr7SmCLKdlt5sUG8+R3WOVaLhwv+wESc
        VA5ETNCfYX77nYXGpkiCQboUvNzjEE3uew80/xU=
X-Google-Smtp-Source: APXvYqykP0lKkqTXmcqN2b0hOKuLUrG9HGQeN7WlHRmciD3Ya2C4Z3SNLv043FvPTTJFiQtk6nOjGUCf2/U+Id5zam4=
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr3085699wre.193.1568814722205;
 Wed, 18 Sep 2019 06:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
 <20190918134642.GA15688@seamus.lan> <20190918134949.GB15688@seamus.lan>
In-Reply-To: <20190918134949.GB15688@seamus.lan>
From:   Ted Toth <txtoth@gmail.com>
Date:   Wed, 18 Sep 2019 08:51:50 -0500
Message-ID: <CAFPpqQH6O7p+d8=79pQ61dqgtNpWggJRtm3vXr3Gx687CvucVA@mail.gmail.com>
Subject: Re: strange tclass in AVCs
To:     Dominick Grift <dac.override@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 18, 2019 at 8:49 AM Dominick Grift <dac.override@gmail.com> wrote:
>
> On Wed, Sep 18, 2019 at 03:46:42PM +0200, Dominick Grift wrote:
> > On Wed, Sep 18, 2019 at 08:35:09AM -0500, Ted Toth wrote:
> > > I'm seeing things like tclass=context#012 in some AVCs what is this telling me?
> >
> > https://selinuxproject.org/page/ObjectClassesPerms#context
>
> Not sure what the #012 suffix is doing there though

That's the crux of my question ;)

>
> >
> > >
> > > Ted
> >
> >
> >
> > --
> > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> > Dominick Grift
>
>
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
