Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC2AC11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7611F2469B
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 17:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaNLPZpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgB0RMj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:12:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36088 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgB0RMi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 12:12:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id j20so3654866otq.3
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 09:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeNByKSzp02vBAE7CQ7YKpnnlAXHOv08LeYTzEfzjSg=;
        b=aaNLPZpOFVksRE+1W//GL39WYcjJHlVyC/OtKavkwuGKZimaf/y9E3FUi3OdjhyKeo
         Np7YgBJ6/8u1oXFZ8q9XlBI1K9RAO+bP4dE954XQyKJ39ArrMCfo2AdMP971QsXSPAaf
         lBBKb9zVpJzIQQlHXfnXe9OLzF/ETHotYE+yB5Huo/fKWD15w9zmmaf2M2edkFhCy2v4
         O+tc5LsLMI1bi4+qBOP+3wWODR69s/GkRZ4FSP14bBUtPU1Gn4wXB8xdUzC4lSD62wfs
         OSr+p3shW0m7+IO6MAUs+9cIf13U9H6uMoVSahROcq24NiQs2iSt3Bnh2tHZyA/ql7ja
         D/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeNByKSzp02vBAE7CQ7YKpnnlAXHOv08LeYTzEfzjSg=;
        b=ltw6Pn2TDVsSOWhZ9oIcUg3HaF1SCUX1u/N9bp6O73Oq9AXM9fD4d1rWTWuZskR6ui
         V/c2zTIL3fgaHxB4LQCTwfVI4aKRukQeTiQkfXXiJpMDK0IuXdu686MuA3rtLsuI9Wk9
         6U8d6TPwwHr7BoXVV7FdoEcIAgX+imuyFxZT532sTslyOq0gkPjpaS5c+DwsEMNcxcUN
         QC21nYZHWWOkj5ZkiBbvVMjMUv3GWLrm7YfEAauU8oqRS/47PTwxhT8cWXioibQTtDIT
         e3Q4HEuQPVcPt1BkI0uIHj0TeHYx9Ycn56jj7i89IlKv9UkoK1c+c3OQJj9gA57CYleK
         u7Mw==
X-Gm-Message-State: APjAAAUo7yBDFW0ZbjdvSF+f5QNLIy6w86QKUfXCnUZRqXjrsrr3RAk9
        V1U/cb/klYfw12W75kx38mG/pDxMdaEKAnxCs6upAQ==
X-Google-Smtp-Source: APXvYqwzEYqu0cwf/BuGagiwc6d9GxglDi87dkP2jOcPJlqGphYrDVkmoDgpux/Q9P38QuiHiWQAmRtVP49S5/h1fBY=
X-Received: by 2002:a05:6830:140b:: with SMTP id v11mr612807otp.340.1582823558043;
 Thu, 27 Feb 2020 09:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20200221131825.91499-1-richard_c_haines@btinternet.com> <CAB9W1A0Cyg577HvJ8hnhWbvC697QSLmym07hi=Faip1j0gdLRQ@mail.gmail.com>
In-Reply-To: <CAB9W1A0Cyg577HvJ8hnhWbvC697QSLmym07hi=Faip1j0gdLRQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 27 Feb 2020 12:13:46 -0500
Message-ID: <CAEjxPJ6ii71KmnynLTjG5bO5iR7Ova0b9LqaVKgaoA1DjLB9vA@mail.gmail.com>
Subject: Re: [PATCH V2] selinux-testsuite: Allow nfs test script to close cleanly
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 9:06 AM Stephen Smalley
<stephen.smalley@gmail.com> wrote:
>
> On Fri, Feb 21, 2020 at 8:18 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > Whenever a failure, close NFS cleanly.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> I'm not much of a shell programmer but this looks good to me.
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Applied.
