Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3170C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 21:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792F020863
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 21:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pf1iKreE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792F020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeK2Izw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:55:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33727 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeK2Izw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 03:55:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so20573685lfc.0
        for <selinux@vger.kernel.org>; Wed, 28 Nov 2018 13:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UbjfQW9J9BBwf59qii6+dDVIsy8pzC8Vzhlevq+m+o=;
        b=pf1iKreEhOtTcOR7CtXvtC0XBEiXy9otF4h8WYBxanI8MGpOKvDtB86cz6C3uJoZ3A
         /Id8YuEjrNidD3YmRBvscRWDIUmZpnMnuDt8c+AhgdeuA4IA+J++TkmqrVvIaU7wPSe9
         nqw9myUE07PJMz5L6+WD4VpWT2Pnp8amCqaB4lRRp7n+nzBtD/CfqMWYUgElGPAujML+
         49vMy9YTnlh6PJT4BM1MzRoGB3mxGx6BQY2+Uz/Dx17zbI9HhdK9DtNzfMXt6aFLEM4/
         fTUZ8F7fXMGoRs6n3YB6fm4gMKHlgj+SmQ1wrAXRVL+9M1DChfKhpIZA9IuSIOvtbh8t
         RUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UbjfQW9J9BBwf59qii6+dDVIsy8pzC8Vzhlevq+m+o=;
        b=kFi/9kkRZTKxfDyqU+g7WG47voeU5lu1Hh97/GcXGVo3bkbBbF7lcJa/qv7zkVmkoj
         giKFeLnlS6Mq5dv7YI16TizloElgCXEpyqQ1Tk1MUtFL8q9h48l2gbfLq5xnMC8N+i77
         BG626RK0h/sb8wQa9T134pD7W9dJueiNCAjt5/hXS70yGNYXVCg+AcJCwOnTkIMbTHKr
         7XSUG1I0eZkHlZWFXwXmPhtBF5iXgjV7zwXDx9NE7sP/LSmmS05oO9wkqWS9Bd2WZxWC
         3rD+41xhYxP2pGYEkm1HRt8dN36Yh2ZPnVrfDw2iJeU8Updt26JLqIxyI2KH0RuWjCix
         snSA==
X-Gm-Message-State: AGRZ1gJK5V8T+2pBV3sGMzGjNHv4b6RIPbwmn18sPFYC3PnZNEoM5tTU
        0EBdEN6n5Pxo1sKaL2EjE6SbGf5GxSMHtrLQHRsl
X-Google-Smtp-Source: AJdET5djzW1NAOHCvwT0PMz2L4+UQUpJxPRT9oMcKZUtMaEOprcKLU1isAfml/cT01TEqb2fItGLT4vPQ15G70ZNk8o=
X-Received: by 2002:a19:40cc:: with SMTP id n195mr22735114lfa.40.1543441966492;
 Wed, 28 Nov 2018 13:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20181127115246.00967523@canb.auug.org.au> <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au>
In-Reply-To: <20181127225013.133adc7d@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Nov 2018 16:52:35 -0500
Message-ID: <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     sfr@canb.auug.org.au, omosnace@redhat.com
Cc:     viro@zeniv.linux.org.uk, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 27, 2018 at 6:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Ondrej,
>
> On Tue, 27 Nov 2018 09:53:32 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Hm... seems that there was some massive overhaul in the VFS code right
> > at the wrong moment... There are new hooks for mounting now and the
>
> The mount changes have been in linux-next since before the last
> release ...
>
> > code that our commit changes is now here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/tree/security/selinux/hooks.c?h=for-next#n3131
> >
> > It seems that the logic is still the same, just now our patch (or the
> > VFS one) needs to be updated to change the above line as such
> > (untested pseudo-patch):
> >
> > - if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
> > + if (fc->purpose == (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBMOUNT))
>
> OK, so from tomorrow I will use that merge resolution.  Someone needs
> to remember to tell Linus about this when the latter of the vfs and
> selinux trees reach him.

I will, or at least I'll do my best to remember; since we only have a
few more week until the merge window I like my odds.  FWIW, I
typically do a test merge on top of Linus' tree before sending the
SELinux PR just to verify that everything is relatively clean and
there are no surprises.

Ondrej, please work with David Howells to ensure that submounts are
handled correctly in his mount rework.

-- 
paul moore
www.paul-moore.com
