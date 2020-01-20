Return-Path: <SRS0=4oDv=3J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C26BC2D0DB
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F94E217F4
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 15:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meSKz4ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgATPnv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:43:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35762 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgATPnv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jan 2020 10:43:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so30037340wro.2
        for <selinux@vger.kernel.org>; Mon, 20 Jan 2020 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfLzOPNmZfz2C1QZnz5zZo4D48QknzC03QCIC691Rus=;
        b=meSKz4ta9cTZPzpnLI2r49JdosylGRxbAysn4JcxbOYdoJXyjAv5PmrW35pblt9iau
         fzmUOytaShOIDeTthLxMY0sQWypIwQd9itUnq8kUf52/cpKDyBZFugN7kRHMco2SILno
         yqgTyeggstS8YSp+cN6i4jIe3dbKJIQ4vuGdwz7newmezCmraTeuKPW7kGEGsZ1q/BeM
         grGqAZleCCbalgm9m93XfV+c9dZtxl+qOlStMi0MQ53J3mEY1Mp2qtFJnEroDNS8nbeq
         ofH+o9hrq715QqqdzOsyrGW5hh7M1V6SUO5FZm0oemUh3p4hNfp2/9ceXxO0TQ3L2aV/
         TKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfLzOPNmZfz2C1QZnz5zZo4D48QknzC03QCIC691Rus=;
        b=VNoFjVW5c9IE9ogh7Js3F/brx7LaQtbyKupDDvQ2lE8178XQZfAthcBOu61TTwt5S9
         cUdUqgnilk4p0Mi66gL0BTp0ewELTTUuKYwe2Bdowq0NyAm9p1Lh/K4hlj1DBFH9Dnz/
         Mis+BJL1k+RwWrv+6Mo3P7acHcg4tbo1f53cTNFgKlBbR+0J/YYcvmspfGkNQp0wkubr
         YfGPl9p+24XbY42h8A/8fVVumOhFFD82ntU6S9GS7fRAxLX1GeyruFwHCutn11SlQZ/b
         hGHDLE75ibPECr9heXLVnytOJgnJw5UcJo2keili9bjqPMGQ2hntPGCT0HZVJUM9qhnc
         bKlQ==
X-Gm-Message-State: APjAAAVvOZ03hN/dCb2ApPQIFxkEL2l69jIP0aVnW+/N593YAG8kYE1s
        CHxY4aj3zGQwX8f2QN0nzUNRV4w7G8BiUnUweiI=
X-Google-Smtp-Source: APXvYqz8XRvT83h3w3ryx4CY8Oc/yyvbFE5vQzOexSv1wcHMZjQIQxO4BRN6AQw+L3/38haQycxtthUyHsbux3aOJbQ=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr141272wrp.236.1579535029495;
 Mon, 20 Jan 2020 07:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20200117202407.12344-1-sds@tycho.nsa.gov> <CAHC9VhS+YxOEsfDRjiiwkT9PdAdFLigG-n7cyLHL1ykBQED-Hw@mail.gmail.com>
 <CAB9W1A16ixsXmMkfbD7Z0WrXK+B0xWfNpBbOe+jOb6krOWrogw@mail.gmail.com>
In-Reply-To: <CAB9W1A16ixsXmMkfbD7Z0WrXK+B0xWfNpBbOe+jOb6krOWrogw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Mon, 20 Jan 2020 10:43:39 -0500
Message-ID: <CAB9W1A3G-23EYDOp0YvCXuQNq3N_XH64s53SyqacYCbnqupcQQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix regression introduced by move_mount(2) syscall
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        omosnace@redhat.com, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 20, 2020 at 10:40 AM Stephen Smalley
<stephen.smalley@gmail.com> wrote:
>
> On Mon, Jan 20, 2020 at 7:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > This looks good to me too, thanks Stephen.  Because of the nature of
> > this fix, I'm going to merge this into next now, even though we are at
> > -rc7.  Since we are effectively treating this as another mount
> > operation, and reusing the file:mounton permission, I don't believe
> > there should be any widespread access denials on existing distros ...
> > I assume you've at least tested this on Fedora and everything looked
> > okay?
>
> I did basic boot testing plus selinux-testsuite on Fedora without any issues.
> I'm not sure that Linux userspace (at least shipped in distros)
> besides test/sample programs is using the new system calls yet.
> And since anything that performed mounts previously using mount(2)
> would have required mounton permission,
> I would expect anything converted to use the new system calls would
> likewise have that permission already.
>
> > It also looks like the fs tests Richard is working on includes tests
> > for the move_mount() so I think we are covered as far as the
> > selinux-testsuite is concerned.
>
> Not sure since those tests were just added in the latest version of
> his patches and at this point he would
> be running on kernels that lack this permission check.

Ah, never mind - I see that he mentioned that he applied my move_mount
patch before performing those tests.
That means that there should be a test failure on kernels >= 5.2 (i.e.
that have move_mount(2)) that lack this
patch IIUC.
