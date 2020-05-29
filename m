Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91137C433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6933920723
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWzdLOpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgE2Nb5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 09:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2Nb4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 09:31:56 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D84C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:31:56 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d26so1901463otc.7
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s4e5vqoO7L7e7OLMsPt2GezuX/wFqqTSwZbMfRG8+oY=;
        b=qWzdLOpb6iyhOu3Vi7C5vhyOnrC3rpzjlAQuNx68GNWCXzxwE4jvhRekl/O1qOIwN9
         /VwKSRCsH+TlbydsP62D4n3NCGlts6jvPzwF5o+NhjEC2wndtlnHS6a//GyRxECEILYE
         qx372yiGCQdMndI4O+HnCYhakMt88u5XA3duBR68mn3MTapobfiolhi7WCe7mGVVLxOy
         67aQPFvJo40HW6M0wOOF+q0iT0kO4F7HrLaat6cbz/DXPdZoDUhNwK+hPk1+ot4fUWqW
         pzGGKFCn3H36bXltgbc/rgPdbRE/De3K7/HO7tMjPfr5+X2OZb6MU/04jQre7FJyJW02
         LI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s4e5vqoO7L7e7OLMsPt2GezuX/wFqqTSwZbMfRG8+oY=;
        b=D5C6NldLBPYemrk9ZN8nWMNtEXLpuA5AKIGoS+ZJ+4nmX/ezQ2A4F62nerSAMGSHjm
         xCLujcVMyzIxcEYUGwIF5XriE/TXnTUx0GklUOp5urAcEdv7PaUdRs+ZqyXGzpSpG9xx
         p0Dah3V22wJbswaNBAqs7VJzCUJGKhtOtPbfSg5sVp9zR31nLQfA/C4qQeyfy4I8nnUd
         mKwP7AfePBojWdppan7cqBqWa7FkOeeg3Om2EzikDs13IQ+hppHxkQqFPLWioeM+JLwh
         NBQDPkfaBFgNoYyFOFSccw+YLavbDQpPj1USi9Cf5DOnQ5RkMeQ36e31d3P8rynbPqhw
         46CA==
X-Gm-Message-State: AOAM531NK7nOODEIEAveO64hmNPgU20GzEe/4PBPj5eNIhw/Dg0Z7a8r
        WX0efKr4hZwAMKkyhHThZ/5dzRVP6g5j6jT2rwjGWRxd
X-Google-Smtp-Source: ABdhPJy1jLV9uU8sHzyzzFqsDVOCngfbLFkbeiFiS1wtPQJ/d7mA/gOM9zUiAdQR/2Zo1M1U0cD5oeeU9060JuyMm0Y=
X-Received: by 2002:a9d:4e83:: with SMTP id v3mr3215109otk.135.1590759115830;
 Fri, 29 May 2020 06:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org> <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com>
In-Reply-To: <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 09:31:44 -0400
Message-ID: <CAEjxPJ6XwXLBKYFaNO-kZz-Vgvbb2B7VKqD3DKQFf_ebBuNiBg@mail.gmail.com>
Subject: Re: CFLAGS overridden by distribution build system
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 23, 2020 at 11:59 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Sat, May 23, 2020 at 5:57 AM Laurent Bigonville <bigon@debian.org> wro=
te:
> >
> > Hello,
> >
> > The current build system of the userspace is setting a lot of CFLAGS,
> > but most of these are overridden by the distributions when building.
> >
> > Today I received a bug report[0] from Christian G=C3=B6ttsche asking me=
 to
> > set -fno-semantic-interposition again in libsepol. I see also the same
> > flag and also a lot of others set in libselinux and libsemanage build
> > system.
>
> Why would it be again? The old DSO design made that option impotent.
> Clang does it by default.
>
> >
> > For what I understand some of these are just needed for code quality
> > (-W) and could be controlled by distributions but others might actually
> > need to be always set (-f?).
>
> If you look at the Makefiles overall in all the projects, you'll see hard=
ening
> flags, etc. Libsepol has a pretty minimal set compared to say libselinux,=
 but
> they all get overridden by build time CFLAGS if you want.
>
> >
> > Shouldn't the flags that always need to be set (which ones?) be moved t=
o
> > a "override CFLAGS" directive to avoid these to be unset by distributio=
ns?
>
> If you we're cleaver with CFLAGS before, you could acually circumvent
> the buildtime
> DSO stuff. While i'm not opposed to adding it to immutable flag, if
> you're setting
> CFLAGS, you're on your own. At least with the current design.
>
> I have no issues with adding it to override, but we would have to
> overhaul a bunch
> of them and make them consistent.

I'm inclined to agree with Laurent here - we should always set this
flag in order to preserve the same behavior prior to the patches that
removed hidden_def/hidden_proto and switched to relying on this
instead.
