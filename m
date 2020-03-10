Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905ADC10DCE
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41010215A4
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 20:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3cP0RI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCJUQI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:16:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46199 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbgCJUQH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 16:16:07 -0400
Received: by mail-io1-f66.google.com with SMTP id v3so8095508iom.13
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2020 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvSL6Fd5tf92z6LEBZH9nibwVKiMGsOZIt+NjwmsDBg=;
        b=B3cP0RI3NvGjZlUwKcGO/gBEO173UnFfZJ0L6ochUeVc13QCjvtlTQhqFCnhlMp56a
         mJ//gPz/mxmyOzKNaNgTQ/MAqVpsin7LMZ0+czMTCLrqmZSf3aAEKU30PCd7Wfj+tyHt
         PDy3EpKV0vkBvAF3ZJ2k7HONPO9fX7wApMAMRijclX9xyX1JPYwFToRqig0b5vx5K2Y9
         xq9qh5u9BCYRAWxT/C8ZI4m396LuKKrPt+AnLZa24mUn4lFQ1dnKITpt5PeLwguzwAQg
         90gyMaIgyasvZvfihDN4UOJIYwmOY5XHb4Wzmg/6PGHlwQPiNw2a1EHiS7ax3vCDs52V
         6NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvSL6Fd5tf92z6LEBZH9nibwVKiMGsOZIt+NjwmsDBg=;
        b=T9RQHfmM8bmPlFBt+TlvJo0FX0HZ8QIwLU7bbDt/+UbRYlKOiERlyOzASVmt0m7RgP
         ar3dAsNtLPmFvncIqBLGQMAmJvwDPN5dT3zTzRB27qm1uHKwZ9gaeh4J4xARW8ojt9gc
         4qer7L61IM284J9LGl+1BGGvtnBznF7ZN0LASyKdT03HhilE3i9nJCVclSj6pGNAt6aR
         wJWGHnTPoyLGrnJ54RwpOh9lAuOO52Y3U32q4jUfRwZdWzGnE1I+D1XCt2fz7pF8hd6i
         arZF01NorL7RB8+7mGH/qbcDhIuVGczTnEnOds9gUCiAScYsA8jbn3joKEYLVb3Zsow/
         pBLQ==
X-Gm-Message-State: ANhLgQ0TNds9Vv61B++/ciZ0TuJtA3goLzfBceZzsWR/nlfCmHvIqCII
        QPTza8jtN98ChxZdlM9bJ07+gV2enblQUyYY/C8=
X-Google-Smtp-Source: ADFU+vs5tUUV586WYHVXrNyj6emXAPGOtJeTslrtChTCiXU7BDjg3eLg1R3DchJolzFpCvZoZgUgohUxEgMHx3iDQWY=
X-Received: by 2002:a5d:9708:: with SMTP id h8mr19267076iol.141.1583871364131;
 Tue, 10 Mar 2020 13:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200309152539.8581-2-william.c.roberts@intel.com> <CAEjxPJ6fUuZbe_Pz7xzfzEGc_ABPjsarTX4GmevEVpf4CS_D0w@mail.gmail.com>
In-Reply-To: <CAEjxPJ6fUuZbe_Pz7xzfzEGc_ABPjsarTX4GmevEVpf4CS_D0w@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 10 Mar 2020 15:15:54 -0500
Message-ID: <CAFftDdp4x1a+kntiJoQbsROMLrGBh91zNab5TSV=FNLUcVyYPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/dso: drop hidden_proto and hidden_def
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 10, 2020 at 3:09 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Mar 9, 2020 at 11:25 AM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > libsepol already has a linker script controlling it's exports, so this
> > patch has a net 0 affect, with the exception that internal callers of
> > external routines, which there could be 0 of, could potentially call a
> > non-libsepol routine depending on library load order.
> >
> > Additionally, verify that nothing changed in external symbols as well:
> >
> > This was checked by generating an old export map (from master):
> > nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
> >
> > Then creating a new one for this library after this patch is applied:
> > nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
> >
> > And diffing them:
> > diff old.map new.map
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> I get the following differences when I do the same:
>
> $ diff oldmap newmap
> 62a63
> > sepol_context_to_sid
> 93a95
> > sepol_ibendport_sid
> 117a120
> > sepol_ibpkey_sid
> 163a167
> > sepol_msg_default_handler
> 194a199
> > sepol_node_sid
> 240a246
> > sepol_port_sid
>
> Looks like these were marked hidden previously but get pulled into the
> map through wildcards if that isn't retained.
> Maybe we should drop wildcards from the version script.

Interesting, i'm glad you double checked that. I wonder why my diff came out
clean, perhaps I fat fingered something or didn't have a clean environment.

Yeah pulling out those wild cards is probably smart anyway, even if the diff
did come back clean.
