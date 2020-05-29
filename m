Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9E7C433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7B8207F5
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWnunMIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgE2NRI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 09:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgE2NRH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 09:17:07 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43989C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:17:07 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z9so2524994oid.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyE2wc91fBAKD6hrWvrK8ldJLfJSVz6Qh5N6zs/9P+E=;
        b=BWnunMIHvwbL2QshcWVMWY7LA+Vt4ScwB2smohLWtAgL66B/FIYRR5rIL/sZQ4HtKL
         0FSaNeW3PMYyQzqMavzpL4/gVLPn4XLz2n3VFNpLgbPF0NlTB+4Lz+43tR972NviXTwm
         ytZ0sRCt21BVkuxRlUfysoItGUIry40EjiaujwqRetcVjsNioeRecTGlDqozN5CI5xER
         S4qUZfIm9JGk0j0h8ghcbYvkQCwJOKiy4vTIzXtxPKOuj38kp3G/xBHZ9ItNb/bx6VmX
         QUdq/NIpIXA+JEvYuCyoWGyAlR9wjWcn/1E1ZlPoGmV2I+PaZAQgWcEnc4+Ujzy/Sbtg
         BapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyE2wc91fBAKD6hrWvrK8ldJLfJSVz6Qh5N6zs/9P+E=;
        b=eJVSRcmUf59kUU8tK6L48ja94qztkQ8wixplmet9jgPxSq3wsch0LlBiTiwd0pzJjN
         tNJ6p0BZViCE54PtLbJ6cerf2+kvmLaVwQ+V7CpYqzfevjme/GsNA+JaJEyTAb9s95ib
         QwrIuocFhRflcWQ13GJOKLAFTMTcAhw9fWShDMeCXNJsSWHt5MCGbFnuNZ5yhCm5ws26
         wtV3m6BVZD8GMzUgEDLb7/y+7HMJwAguZnZdZkqBo34R2/HS1TndO8aoSseGoKqFybdJ
         IvfaSlH7KDYao3yDR6x3gOViJHDx9lasjUmIQ2yLlWviqi//o3uKscVZYB/nTcB5g+bp
         WhgA==
X-Gm-Message-State: AOAM530juzjDM1ogPpP6DxdY6JhjFQrh6OwBhXENlWWZh7ufXoxUxQnH
        jftH49dATg6VSM6GVo6lTTN1CbEpGI5HmdIPAsA=
X-Google-Smtp-Source: ABdhPJwCO74JHugr7aPDQdYWwSmcIv6VFzdxdWxN0eWrbM8NehdW7CFvKBpoXv66J6scBT4ZKWD+MxN70rcO+IQ+J2A=
X-Received: by 2002:aca:c704:: with SMTP id x4mr5430769oif.92.1590758221841;
 Fri, 29 May 2020 06:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <d204aaea-ca46-49c2-f7cd-6f20889cecbf@gmail.com> <CAJfZ7=kn951BnLbJKKLKkzXaeGEnME1P=rBsczFumf3S7=3MjA@mail.gmail.com>
In-Reply-To: <CAJfZ7=kn951BnLbJKKLKkzXaeGEnME1P=rBsczFumf3S7=3MjA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 09:16:50 -0400
Message-ID: <CAEjxPJ5gK_DdNxpjMq8tvvhkq1hxsoE5vTNZAa=hiP-6s=an8Q@mail.gmail.com>
Subject: Re: [PATCH] chcat: don't crash if access to binary policy is prohibited
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     bauen1 <j2468h@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, May 10, 2020 at 1:26 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Sat, May 9, 2020 at 4:06 PM bauen1 <j2468h@googlemail.com> wrote:
> >
> > sobject will crash if access to the binary policy is prohibited by
> > selinux, e.g. refpolicy
> > this also breaks file operations that don't require seobject.
> >
> > Signed-off-by: bauen1 <j2468h@gmail.com>
>
> Hello,
> This patch looks very hackish. In fact, an underlying issue that
> exists with seobject is that "import seobject" raises an exception
> when it is used from an environment that is not allowed to read the
> policy:
>
> >>> import seobject
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
>   File "/usr/lib/python3.8/site-packages/seobject.py", line 33, in <module>
>     import sepolicy
>   File "/usr/lib/python3.8/site-packages/sepolicy/__init__.py", line
> 186, in <module>
>     raise e
>   File "/usr/lib/python3.8/site-packages/sepolicy/__init__.py", line
> 182, in <module>
>     policy_file = get_installed_policy()
>   File "/usr/lib/python3.8/site-packages/sepolicy/__init__.py", line
> 137, in get_installed_policy
>     raise ValueError(_("No SELinux Policy installed"))
> ValueError: No SELinux Policy installed
>
> Is this the issue you encountered when you write "seobject will crash"?
>
> In my humble opinion, trying to hide such an issue by moving "import
> seobject" makes maintaining the project more difficult. I would prefer
> seeing a way to allow using "import seobject" without raising
> exceptions, but working on this is unfortunately quite time-consuming
> (I have not seen a straightforward way to deal with this, and there
> exist several ways to solve this in not-very-direct ways, for example
> with lazy loading of the policy when needed or with replacing some API
> with stub functions if the policy cannot be loaded).
>
> Therefore I will not ack this patch, but I will not block ("Nack") it
> if another maintainer wants to include it.

I'm not opposed to the patch itself (I assume the current code breaks
usage of chcat under MLS policy by regular users who lack access to
the policy file), but your Signed-off-by line ought to be revised to
contain your real name. Otherwise, it doesn't really serve its
purpose.  See  the discussion of Signed-off-by in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html.
