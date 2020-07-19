Return-Path: <SRS0=eLZI=A6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7490AC433E0
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 16:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556E7207EA
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 16:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgGSQqo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Jul 2020 12:46:44 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59603 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSQqn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Jul 2020 12:46:43 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jul 2020 12:46:42 EDT
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4D9CB5646A3
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 18:40:47 +0200 (CEST)
Received: by mail-oo1-f48.google.com with SMTP id d125so2746429oob.0
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 09:40:47 -0700 (PDT)
X-Gm-Message-State: AOAM532pAoHFE+RFa0YlvWsemZkACa2O/M+xQ40y0NJszX5nFVbige/s
        EayqcPE3Bsb9v8C3AJ1WzwxLZBXFWlVDSDqiQm0=
X-Google-Smtp-Source: ABdhPJzUwelN9idHDY2EB+GHffi76nv+CeF+uridqdThsfWWJjSXO0xbKUy2ILdVlIwYSkZHkS9yE0axFx2AfXAUfhY=
X-Received: by 2002:a4a:c213:: with SMTP id z19mr16439928oop.46.1595176846290;
 Sun, 19 Jul 2020 09:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200716122213.454087-1-bigon@debian.org>
In-Reply-To: <20200716122213.454087-1-bigon@debian.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 19 Jul 2020 18:40:35 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nZY+DFwVT9X7mJVTBG1=p3ZgR-aX4DNuK02qzVTT_g4Q@mail.gmail.com>
Message-ID: <CAJfZ7=nZY+DFwVT9X7mJVTBG1=p3ZgR-aX4DNuK02qzVTT_g4Q@mail.gmail.com>
Subject: Re: [PATCH] restorecond: Set X-GNOME-HiddenUnderSystemd=true in
 restorecond.desktop file
To:     Laurent Bigonville <bigon@debian.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jul 19 18:40:47 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 16, 2020 at 2:28 PM Laurent Bigonville <bigon@debian.org> wrote:
>
> From: Laurent Bigonville <bigon@bigon.be>
>
> This completely inactivate the .desktop file incase the user session is
> managed by systemd as restorecond also provide a service file
>
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> ---
>  restorecond/restorecond.desktop | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/restorecond/restorecond.desktop b/restorecond/restorecond.desktop
> index af728680..7df85472 100644
> --- a/restorecond/restorecond.desktop
> +++ b/restorecond/restorecond.desktop
> @@ -5,3 +5,4 @@ Comment=Fix file context in owned by the user
>  Type=Application
>  StartupNotify=false
>  X-GNOME-Autostart-enabled=false
> +X-GNOME-HiddenUnderSystemd=true
> --
> 2.28.0.rc0

I was not aware of this option, but it makes sense. Thanks!

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

If nobody complains, I will apply this patch tomorrow.
Nicolas

