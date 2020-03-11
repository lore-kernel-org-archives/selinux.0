Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43286C0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E7920691
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACWFGJvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgCKSBv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:01:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35261 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSBv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 14:01:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id k26so3032931otr.2
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JJDvyRfOngG68GV+UmE7eQqJePB3nz1JLNZQ/v84k8=;
        b=ACWFGJvYnA3qy+xQr/gxFq1OZAS4Ck4y6cu825b3RlKidEpxuUKS5YE78oHuJH9DDe
         bgcf9msT7Cm0zcI5ibyYcV/M4yHX/vKNWZAO/TBWg5eXhM5/BG04QNzOEh8hwBhda/rw
         Tl2zWme88ElGwjeyq4lovM/pi5DvClFUuUHMKyHaWpUltCS7TCDarC3AU0ZiWQdvw57j
         A7fsDLwpYxz9BdiR//tPjKgaO79aHISS6ADTcROAD7p2812/hp2AaJnG93QJf78xpgpR
         0rW/qL9QkMnkXzBm99iYGLGGIdh7sItZCvAPn5NNpV6TzujAu0XjJN/TG2gCw50jhO0H
         YkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JJDvyRfOngG68GV+UmE7eQqJePB3nz1JLNZQ/v84k8=;
        b=Q0o2BHkGiSKi0PpxsaNuyT6hKWAZmHiLT0J56jh/N1NZKjBcFpsbtFt2Igv/fSYPyk
         wGjtaf3i3vuXs2mnFG7NmGldabN6qljSFoGCG3JWUJbqkBNV8EwwJvo/aEQpJJ/bIiri
         xDetVu/f9GDh03MFRtfK+kUa9ChjnYsWUA7cP4eVC47hRPfWwfgHEExyGpV1aHTUk4I+
         JqpOINAlqv6XrQxRTIkNznDzenADuaIJoJUjhtT+co4/JG065XDiD6yMiba3e5yDMorB
         F11Tocy8q+rR9EIqwFlBpvAYAZ0SX7FJTK6vHZWxWhRcy/YjHIeT9jX5HdSIyw6ZvwBy
         MBjw==
X-Gm-Message-State: ANhLgQ0qUPd8VpQrFo8LQ+ypewBdmpt8BJmzXCYjeoQifpTh5oYTJbHi
        r7bwzujEI+oOCr7hLPRQMHVm9/fxX1KNXu8uB0O+Fw==
X-Google-Smtp-Source: ADFU+vtSiyVdBqK3HCPx3FZB/hQrCw0s/yBwJgX63C0Bx1piIoAfbZv/26M0J1nLB9ze9PGSUkGasbfsIIYxKWBWyKA=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr3337952otl.162.1583949710485;
 Wed, 11 Mar 2020 11:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200310162456.32240-1-richard_c_haines@btinternet.com>
 <CAEjxPJ4USNdqFY40vPnviLPHSZR22Tpq0y1L+LauJenKXRw6HA@mail.gmail.com> <5b317d8b29fbf7d56238a136254b53b042becf96.camel@btinternet.com>
In-Reply-To: <5b317d8b29fbf7d56238a136254b53b042becf96.camel@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 11 Mar 2020 14:02:41 -0400
Message-ID: <CAEjxPJ54UEMrNU+NBKtJoffB_gyErFbzsLrHj3EbVRMmA+EWmQ@mail.gmail.com>
Subject: Re: [RFC V3 PATCH 0/2] selinux-testsuite: Use native filesystem for tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 11, 2020 at 1:52 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Wed, 2020-03-11 at 10:55 -0400, Stephen Smalley wrote:
> > On Tue, Mar 10, 2020 at 12:25 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > I've revamped the nfs.sh to handle tests that require specific
> > > mount
> > > options, these plus many more are now in tests/nfs_filesystem. This
> > > only
> > > gets run by nfs.sh.
> >
> > I don't really understand why you moved tests that could only be run
> > from nfs.sh out of it into
> > tests/nfs_filesystem?
>
> I only moved them as it seemed more in keeping with the testsuite.
> Would you prefer them in the shell script ? I don't mind either way.

Previously they weren't dependent on the test policy (weren't running
in any test domain
or using any test types) and were only testing NFS labeling behavior.
I think you switched
them over to running in test domains and on test files/directories.
If we stay with the former,
then keeping them in nfs.sh makes more sense.  If we choose the
latter, then moving them as
you have done makes more sense.  Not sure about the tradeoffs here.

One thing to double check is that if you move them and there is a
failure, is that failure reported
properly and propagated up to the shell script in a way that causes
the entire test to fail.  Might be
but I haven't confirmed it.
