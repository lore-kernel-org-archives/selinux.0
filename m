Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15176C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97652077D
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I28dlZB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2ND4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2ND4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 09:03:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF7C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:03:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b3so2427512oib.13
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLtqpXVrcrLD1bQ7q+0dJoSj35vKULbgc9Kadgxsq88=;
        b=I28dlZB1Bx4EF8OiX8asFZoueMNTtf+dHjKuG7xIrf+KTkclPwt4hMMEn9eNUcu90y
         Ac+p74JouNIUljPACs7Zwz/na6ucOxKHu0Bs5ReLKJlp5NNKofTq4bS0RNiTMaSUsKiI
         nh2YOClzX4fw0J0PXqQhMvzchuZwPcddn0bLC+/H+GrZGbBPAxKD/EsQCcgHLt0lMIkZ
         cUDdT5Y6BqC+1HwjC8TdjxcTPqEodMeSfIgoKCF7tWjyN6W7qVhV6lgZSmaSYeMsv0Eh
         9bPuruW9zHHT8uGAeuz30cJH5UBPxSdTrAy4/ozLEWZBWo9tA9luDJv9AMGT+0I4OyYU
         RH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLtqpXVrcrLD1bQ7q+0dJoSj35vKULbgc9Kadgxsq88=;
        b=ogRHn4jUvIaUuH2R5PMRLhmkqO1fxSQS3pVGjhRU5tEaWes0xUGIL3g6q6SFOnNn7u
         HHirkKOVAwkzOsztDo4sZDbKEw6K/NeiBL4hAwfcILWJ/j6JUAgpzOf+LPVAPSu3B0yB
         1ElTdVZHwHEnTK9s/T39ixVpEmBIXDFBSQ4l8W/pWwWeG832H0WIW8TQ0Te7vFaKWTCV
         WfTeqza5p46T9JlMvtwfGJk54O1YoRDHzyUCYrPfN9behEwGxcbNI0nKwqYuSbiXD/qq
         7e3a5M4yrWi5le0pHlqXNzxXHBZ7NciDl2wHaMyAJgqLVt6Qs0niqVOvdohomovzLNeU
         wFVQ==
X-Gm-Message-State: AOAM532ASKjQSU68t3iqQ2EFUloPI+f7+L9Et/wDh8qRn4j0HdA83Upt
        YnjR/NKkX00QQbpLjPVaU0yUHJkL73CxcI+Q/ac=
X-Google-Smtp-Source: ABdhPJzfEPv7FRHI8oetVKPfHVTqSTJnNHD4s3e8G8NvHGF3vmaQvzTs1x7UwrbP0/7p8iTfx7WWVhwwQ51bi2fl48w=
X-Received: by 2002:aca:c704:: with SMTP id x4mr5368350oif.92.1590757435507;
 Fri, 29 May 2020 06:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200515114111.11428-1-toiwoton@gmail.com> <20200515133540.GD255621@workstation>
In-Reply-To: <20200515133540.GD255621@workstation>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 09:03:44 -0400
Message-ID: <CAEjxPJ6EQmzHqXWO02GzCwf-uLG1zePkkhgboAknqwxdxR04hQ@mail.gmail.com>
Subject: Re: [PATCH v3] secilc/docs: fix use of TMPDIR
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Topi Miettinen <toiwoton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 9:36 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 02:41:11PM +0300, Topi Miettinen wrote:
> > Environment variable TMPDIR may be already set for the user building
> > and this could be equal to $XDG_RUNTIME_DIR or /tmp which are existing
> > directories. Then when running 'make clean', there are unintended side
> > effects:
> >
> > rm -rf /run/user/1000
> > rm: cannot remove '/run/user/1000/dconf/user': Permission denied
> > rm: cannot remove '/run/user/1000/systemd': Permission denied
> > rm: cannot remove '/run/user/1000/gnupg': Permission denied
> > rm: cannot remove '/run/user/1000/dbus-1': Is a directory
> > rm: cannot remove '/run/user/1000/inaccessible': Permission denied
> > make[1]: *** [Makefile:68: clean] Error 1
> >
> > Fix by always setting the variable.
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> > Suggested-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Should I merge this or do you have it?
