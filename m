Return-Path: <SRS0=mDct=7F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F047C433DF
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F82820759
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 15:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/gFNyC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEWP7b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 May 2020 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEWP7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 May 2020 11:59:30 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81FC061A0E
        for <selinux@vger.kernel.org>; Sat, 23 May 2020 08:59:30 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id 17so13781642ilj.3
        for <selinux@vger.kernel.org>; Sat, 23 May 2020 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TFcDuq6L3u195E004iaNMYGGbmACZngvfW4LkOd1fsw=;
        b=l/gFNyC0rivkqoNJfwI231johZ0Yj6bbUMBWF1BOAmdRUYS/zzIXIcFPTJj0xyM/MZ
         8K/N1gl8u+8mXbyeecWFSXbWrs0ioaieXQ8W3eagW1WMKATv5Z9rpMYST23ZiAPQZmnj
         2J8ejo7Hr+3vl1OcTg4Hz+4Qfq0ubB+BYySRpyYlkG/aJfGUdCkoy2XNpSRg28jzIJX7
         jgWq5avp8t5n0fYw17uhuQdjhw92mm7LUhMOY3UMe6xfCW+FQRGUOZ7vQGgSp1PNdDfe
         RFW8Wl+NGatD4gj4ySNiaVNTpOYRFqbzS8nWKy1fRkyEmtkqddWf28qXogQ5J490tOS1
         mJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TFcDuq6L3u195E004iaNMYGGbmACZngvfW4LkOd1fsw=;
        b=jTFuFZaUPL61hTrpHad0cMrEcHyIrGpL8kijuqNe4Jp8us8y0xGT4LKomMDKIwT8hn
         BhbHLxIdnhUneNo+yq6cNyXs2fXP1LLcGUF1ckL4m7tUVdIgGMukRzP0deBclbuRH3qY
         UB8zY1mrOcZJiwlW2GZN/MntUNAq9Eti6Ak9Co8mPqLo+/eMILba40fjxkBUBRPcK5Qv
         fw2HNCQjsZe5h1Q/miJf7OIUwLrkuu2ePjT2th+XeypL39tLRvAbGcnijD4Mk4jH7AeK
         YtHZMjcD9TxNxHjETyu6iF2+sB0/DEV0EX0jMWZPUspMC0oISDKoyobMrCWV3/6OxwpH
         O+oA==
X-Gm-Message-State: AOAM533l4F9bReWKWp6FIFFlNOAczZ66WHYY1vrHy5/5E/uPUTysryZ4
        nTkI8fY8R+62REsI61wLV4GWGx43lwQu1a3Sg+UHHMrtRso=
X-Google-Smtp-Source: ABdhPJzR0zesJY6383Mth32Rhe88ulDa74Bt0dO5U/6EfS11rka3FVM+pnNXUEXll2koQ6pWWCBAiEU3SYCGxSsGpiQ=
X-Received: by 2002:a92:984e:: with SMTP id l75mr18391785ili.22.1590249569533;
 Sat, 23 May 2020 08:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org>
In-Reply-To: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sat, 23 May 2020 10:59:18 -0500
Message-ID: <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com>
Subject: Re: CFLAGS overridden by distribution build system
To:     Laurent Bigonville <bigon@debian.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 23, 2020 at 5:57 AM Laurent Bigonville <bigon@debian.org> wrote=
:
>
> Hello,
>
> The current build system of the userspace is setting a lot of CFLAGS,
> but most of these are overridden by the distributions when building.
>
> Today I received a bug report[0] from Christian G=C3=B6ttsche asking me t=
o
> set -fno-semantic-interposition again in libsepol. I see also the same
> flag and also a lot of others set in libselinux and libsemanage build
> system.

Why would it be again? The old DSO design made that option impotent.
Clang does it by default.

>
> For what I understand some of these are just needed for code quality
> (-W) and could be controlled by distributions but others might actually
> need to be always set (-f?).

If you look at the Makefiles overall in all the projects, you'll see harden=
ing
flags, etc. Libsepol has a pretty minimal set compared to say libselinux, b=
ut
they all get overridden by build time CFLAGS if you want.

>
> Shouldn't the flags that always need to be set (which ones?) be moved to
> a "override CFLAGS" directive to avoid these to be unset by distributions=
?

If you we're cleaver with CFLAGS before, you could acually circumvent
the buildtime
DSO stuff. While i'm not opposed to adding it to immutable flag, if
you're setting
CFLAGS, you're on your own. At least with the current design.

I have no issues with adding it to override, but we would have to
overhaul a bunch
of them and make them consistent.

>
> Kind regards,
>
> Laurent Bigonville
>
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D961329
>
