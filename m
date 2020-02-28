Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8889C3F2CD
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 19:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7F62469F
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 19:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpKY4KGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1TX2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:23:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46788 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1TX2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 14:23:28 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so3892491oid.13
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 11:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XeyiPyxzdPzKOSYZSvG3g0ODiuKgutt5YPp+pWVvn90=;
        b=dpKY4KGNEhj81qEhWc55ARkqsLPuXy0MlaLI1ArqQCZ9C8Q/tSWLb7CxXjwAyv4u44
         Bxu3A6gZq3m2LpOJy7l/rdEvGj0K4eZQsFVlUDPLJ+JvALt1VHq0zEvGeywLq7IBVlY+
         gAZUaqDFsBNhxR69TzEFpgMnHoKUhPQ/noPPL3SF6LkVXxxhHzHdt2BFJ2DqrLB05MQy
         bZvt+TtCRBIQv141B9lLSwHPBy7FHLpSyKkBYd5kOQJvjHf2v7Gx6C773RIPckgHIKNG
         nO7cMvvsR6dU074/kMhjSuwbCiiB0cpCYjisUoPxmbJwO/pe8GZiFSMEvkmMX9ic5MWN
         WMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XeyiPyxzdPzKOSYZSvG3g0ODiuKgutt5YPp+pWVvn90=;
        b=VyCwZ6VTabo49Xnz7mn5X4FlfLPBqyG8p29L6AqbW3ILIH1oShkE4gEZvnPzH1Rs3e
         EobwhfxRRuYDFZeWp/+Uw8gEVnK4AxGKUz/qCRhanWfx2BiXf2/Bp8nM8bvk0eT0/yw7
         XBCE5ED4dHJg57j2zkqm8iKZtkM5knZ4TsqkKtSHJF5ar2qZazCPS2ZNnNl5/XBVYkbg
         JQljnHkGOVVXNZagZht4i3gEyk6H9sJUElSe4agqfPDuUabhj+uaXtcWUVeXYf7e6yMO
         RZh8xBCrR+tjH+O5r5fTUcm5oyJcRS9alNf9vNHOTThaNIVMauAzNJZHHI8m26McCMjk
         /Gbw==
X-Gm-Message-State: APjAAAXXMk2gzCgXhMkM+YzjjR+FZ5jpW7WICSrvmCrkprQFHUS70Tov
        Dbu1y25n9LURa6VWah71qbceyuuQX5NFilhKZbA=
X-Google-Smtp-Source: APXvYqwSvyvHTwNO4DGPRqZbEj8qbAEbhKq3r9OD+mim6MsUT3Ex/yBiikTJo9vjmJBo7mbucPark/Kjaak8U/H6R0I=
X-Received: by 2002:a05:6808:48c:: with SMTP id z12mr4142984oid.92.1582917807244;
 Fri, 28 Feb 2020 11:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20200225094529.178623-1-omosnace@redhat.com> <CAEjxPJ7=5yPzv+PCmtTsuN_osgmkxWGab4CN9y7k5LTEoT-dJg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7=5yPzv+PCmtTsuN_osgmkxWGab4CN9y7k5LTEoT-dJg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 28 Feb 2020 14:24:46 -0500
Message-ID: <CAEjxPJ5qssPY+Z1yRgLmff_1+-t5TjkknJnGSuSQFJWARZTZrQ@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/sctp: fix setting of the SCTP_EVENTS sockopt
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 8:18 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Feb 25, 2020 at 4:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > First, the setting of SCTP_EVENTS socket option in sctp_server.c is
> > completely wrong -- it assumes little-endian byte order and uses a plain
> > int instead of the dedicated sctp_event_subscribe struct.
> >
> > Second, the usage in sctp_peeloff_server.c is correct, but it may lead
> > to errors when the SCTP header definitions are newer than what the
> > kernel supports. In such case the size of struct sctp_event_subscribe
> > may be higher than the kernel's version and the setsockopt(2) may fail
> > with -EINVAL due to the 'optlen > sizeof(struct sctp_event_subscribe)'
> > check in net/sctp/socket.c:sctp_setsockopt_events().
> >
> > To fix this, introduce a common function that does what the
> > sctp_peeloff_server's set_subscr_events() did, but also truncates the
> > optlen to only those fields that we use.
> >
> > Fixes: c38b57ffdac4 ("selinux-testsuite: Add SCTP test support")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

And applied.  BTW this was my first time using get-lore-mbox.py [1]
and I really liked the automatic collection of acks into the commit
message.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-lore-mbox.py
