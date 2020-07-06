Return-Path: <SRS0=GZQR=AR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F005C433E0
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 13:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC082070C
	for <selinux@archiver.kernel.org>; Mon,  6 Jul 2020 13:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObQqxNW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgGFND6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgGFND6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jul 2020 09:03:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C658C061794
        for <selinux@vger.kernel.org>; Mon,  6 Jul 2020 06:03:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a21so8283460otq.8
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2020 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9M9UcSa8h82zhnFJXgYQSaP8AC5ibN7ePUhkRj/sWbs=;
        b=ObQqxNW63RJrjTqq9eiOP/sFaIMGFf+WXccoFB7qQ+mHJvsN/3q9ZlX/xVSX9RxfQP
         4Y40wWYAAPZ+1D5H82It6JzsQ0ZZMLmKOZRKhPMuCmah+BEGyjtbiYNfW6p3vvw8VbsT
         9wTTcujkI+BRABxYlT/auOPjpys6wQj/3UpHmaFPLRYa8LSVJzaCOAgGDfQKLkeeB05Q
         CUnXW4t3DXUyeq5fdWmEOwpwXzSXkArrbBFYyz8y5qU2GnK+z6O2rDoUIhJRyrmN6QhY
         PJGgcvFYadB8ZzTTJ79ojzvrxbitqNiIbYBmCJB57IRc9JSBV8dhrsuQCzf+Rjd2GDrs
         0byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9M9UcSa8h82zhnFJXgYQSaP8AC5ibN7ePUhkRj/sWbs=;
        b=njZOxXJGFSoMkGmvOZicAzJdHkvokqKeJujlN8yXjvdoEDkXWIvYw79ifVwPCgkcW2
         9CK/G0Qwf8NZ7/GpVQMKtPq9N+0d9f/xrtwOPIeTBHtsQjpyALDgLJ3O9AfZpXPxoCR0
         yJQum3/z32vPwkLl+QI0CmHZBV7U03fNfamMbZOsIld8XQ5Xv/UdwtveIBsPxTODg0ry
         pnNQ6jWtI3YSZZHfKsX8U9H53g1A30b6LjrAbPdX974fvuBO0PoYfyh/6C/SFgtoIvqa
         KrQ2G2gKohl6Gxg0V2GUv5c58xKQxrQ/iJ/3Yfqy5eW1WlizmqhzhU1HT6etchPxe9VL
         2mIw==
X-Gm-Message-State: AOAM532o/1UcqcTnplomg4iVPDE/rw6uAymouwfzhs5MtzJuHV35CqiA
        NfW8H7ZJohxATBhXbqB5PYzugJV19VlAgLbhWpN2YcLUcIg=
X-Google-Smtp-Source: ABdhPJz1WvXjEDQaK5UTOY1u22hBBNObCLR+H8tOKThuSDJN968btM7VRZTZG6wbBCZrP9IalYRoyOjtqmjkFuMt51k=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr33847255oto.135.1594040637662;
 Mon, 06 Jul 2020 06:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <e6cec631-afb5-da5e-c12a-b8496cbeba3c@gmail.com>
In-Reply-To: <e6cec631-afb5-da5e-c12a-b8496cbeba3c@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 6 Jul 2020 09:03:46 -0400
Message-ID: <CAEjxPJ60aq_rv98ZGchinKfYT_aQcp3unKO-pHQxp8fnmw4vBw@mail.gmail.com>
Subject: Re: Daemon's child getting weird denial
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jun 28, 2020 at 10:20 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>
> I'm in the (hopefully) final stages of creating the policy module for a
> daemon that I've written to monitor my home NAS.
>
> The daemon is started by systemd (init_t) and runs as its own type
> (freecusd_t).  In order to read the SMART attributes of the NAS drives,
> the daemon runs a helper application, which has its own type
> (freecusd_smart_t).  So:
>
>    systemd (init_t) --> freecusd (freecusd_t)
>                             --> freecusd_smart_helper (freecusd_smart_t)
>
> This is all working (although I can't help but think that there's likely
> a macro that I could have used to define the helper type that would have
> made things a lot easier).  Every time that the daemon starts, however,
> I'm getting this denial repeated 4 times:
>
> type=AVC msg=audit(1593392372.230:9215): avc:  denied  { sigchld } for
> pid=1 comm="systemd" scontext=system_u:system_r:freecusd_smart_t:s0
> tcontext=system_u:system_r:init_t:s0 tclass=process permissive=0
>
> (Note that the daemon spawns the helper repeatedly while it runs, but I
> only ever see the denial 4 times when the daemon first starts.)
>
> It appears that the helper process is trying to send SIGCHLD, which
> doesn't seem right, as its parent is still running.  (I've already given
> the helper permission to send SIGCHLD to its parent, freecusd_t.)
>
> Has anyone ever seen this behavior or have any idea what could cause it?

Prior to commit 3a2f5a59a695a73e0cde9a61e0feae5fa730e936, SELinux
would check sigchld permission between each eligible target of a
wait*(2) system call and the process that invoked wait*() to filter
what processes could have their status checked. Hence, this is likely
the case that systemd is calling wait*() on the process.
