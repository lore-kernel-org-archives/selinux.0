Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C8CC35E15
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DD820675
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG+0IXS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgBYUty (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:49:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35076 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgBYUty (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:49:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so865812otd.2
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIjC+1FDEn7GricRNxhJFmHBylUPfLH+/YJVbbQYx8g=;
        b=hG+0IXS89ipjuCBBgkg2r6i8T9KA0wt3dkRkxbdR/npcvGy4pzdnhHiFItzHBPEvwn
         gRbLoGpm/6SjZJdqpyXw8cBncoWb4JUYJER+mZDEgKvNECiWVEP6NE0kYuGLdMn4Gt9Y
         anPXwaXxcolnZqikJfipY45wEoJKiHb9n+vOKrImODuw/xO6S8hj4GVlwESETS3iKeDR
         bETLjV+9DZRm5OynEN5Ll+z0J8nt5/obskLQGPKv0IcV7ypRrMB7UypHpu+LpmxsjMxy
         AhfsewnJpiCs9kBGIW9p38twVtlKnbk2UnAYIJsXwbjDE8O4nE0+rw4NFq3CPkURcVms
         tDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIjC+1FDEn7GricRNxhJFmHBylUPfLH+/YJVbbQYx8g=;
        b=pIzgikV7iN5qcMisqv3557hhgsuetbh+WPYofhM2h758Duf/uIZok6Pbw9cakh+lbS
         y5VexqGNNVxrPw7d1qFFiJZvb6X+krfSeedXCqN8LQr7FPj+zha/Z4VFLvxhCLLlli1h
         bG5sZ68zogVhs++cz+xdYptrGh8cWqMhqrzsuLwdqHkGNZ7XtCGFkhjEMEGV3F99wpSe
         toelDEwkLjGxUzoDVOCppwIkSeav5+J2MXv5BDJJJtMIWnTVgoLEw2kmd/Tr9FuWnUsc
         6bMDMgNvXHdVRpqmo7PlyHk+AHXvzVIOUG1Zy1WmgMvtFq7teVXSL22vT6A92tZ1Lywx
         r6zA==
X-Gm-Message-State: APjAAAVfRSB19Om62U9YblqdGvEigzccAjnsNEcmSYb9/AWcK2cyj/Zn
        DuI95cvME4MyJG4H+DoD/g3COkGChR2RIqsJ+3E=
X-Google-Smtp-Source: APXvYqxd24ApwvIdoWR+EgwWWaDEcF+WbUTzGkHiJLFkN7JbYXoP6moRBOB7RDvAjWG2d3A3PJbiVsHAVCD/sto0+m8=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr371224otl.162.1582663792464;
 Tue, 25 Feb 2020 12:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Feb 2020 15:51:25 -0500
Message-ID: <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     bill.c.roberts@gmail.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, plautrba@redhat.com,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 3:03 PM <bill.c.roberts@gmail.com> wrote:
> The annoying part is internal users of the routines. We could always make
> a v2 version of the function for internal callers, and leave the old
> interfaces intact to work around the warnings, or just pragma them out.
> This series pragma's them out.
>
> diagnostic push has been supported since GCC v4.6. Earlier versions will
> warn on this, and the sideffect is that the diagnostic ignored pragma
> will be valid for the rest of the file. Clang has similair support thats
> been around *at least* since clang 6.0.

My inclination (and others are free to disagree) would be to rename
the deprecated functions for internal users (and mark them hidden),
and add stubs for the old interfaces that call the hidden functions to
avoid the need for this pragma.  Also, FWIW, there is a push to remove
the hidden_def/hidden_proto stuff for LTO, see
https://github.com/SELinuxProject/selinux/issues/204, although I don't
yet know how that will turn out for libselinux.
