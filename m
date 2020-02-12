Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371DDC35242
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 03:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12D02070A
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 03:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wE6p7gn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBLDH2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:07:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43869 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgBLDH2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 22:07:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so641968edb.10
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 19:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFLoJ+Iscn8Qb8Jf6d+3iR2+svxKe9mFdKwvUsh5fhM=;
        b=wE6p7gn51MRK87tVTxdIg0KTgY7b1uGXoMWElvxJiFG4fDFHIox7jf3XfT1A+lguat
         /wlazP6U6/5qjsr5XlZXf13lV4uRoIpHVVI9TpxM/UsCUy4poALez1jSo6rrE9cnfVgl
         TXW4QoMlNLiDCJA8z+e8G/tWx9I9Qvj/ku625Ew0vzecoa8+kmqyhN4o4wYojFfW8iQF
         GiALbzBC+r4wMWzJIGRq5aw2z1gX6VgpQ4Dny4ry1WQuV55aKdrq9EBAnsFr1NSXdu+J
         FsvQBtl1gXiApXxaebax9SZCalClDyZbdp/T2DmExdEzMtDQ3cf9DHSxA4LLviJcOjQr
         n5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFLoJ+Iscn8Qb8Jf6d+3iR2+svxKe9mFdKwvUsh5fhM=;
        b=FUhtmYYZueWWjKQODqmhoyIdGsmkvU3FKV/TA3l3mcP4N3saxyMtj13dMuo6fL/tZw
         bd6zU+S4hveNOgEQ56VI8Hmx4FUlMXwPur9AsGA6BlG/JYOA4GiudmWOhYkYbtRs513/
         OE/vMiVZnD2I0azuq17pHLTfK/eAjhlp5qv7+L7Ui6LTM2DT6FDMo1sDlut/KUjdf+L2
         vfRZGwIhdZXm5g1vYq0EZVz7iwR7T0k9XgIseN4qXq9UFGECMfWbbccFGMBTQZw7O1qS
         tABTvLSJ1e9kYtA8tgZUfg87ZE26s1XSlBA6Qrkf3DXznCmt8E9wAEKVBNAkGhk5hCH5
         QCFA==
X-Gm-Message-State: APjAAAV8qxzNzHDZalEriqBm1zg+pbxoRRq5cmFYIRxbNYHJeObvadQW
        uuqMv1zfjVZa/87PTx+aBMTslZ0yRl1d7Y6Xwqtu
X-Google-Smtp-Source: APXvYqxDmrFQjx8V0VcmOGrFMs/oVT1r+vBxUCOfebdEY0DJ2CPe2Z5xwZqWoVHs9cbihwVvLdyo1+WzRoz2TnBYYbU=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr8786331eja.77.1581476846571;
 Tue, 11 Feb 2020 19:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20200207180148.235161-1-smoreland@google.com>
In-Reply-To: <20200207180148.235161-1-smoreland@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 22:07:15 -0500
Message-ID: <CAHC9VhSiNMEXreCb9=M-Dy=8HOyGRobnBVBMYTHOL1W39dd--w@mail.gmail.com>
Subject: Re: [PATCH v3] security: selinux: allow per-file labeling for bpffs
To:     Steven Moreland <smoreland@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 7, 2020 at 1:02 PM Steven Moreland <smoreland@google.com> wrote:
>
> From: Connor O'Brien <connoro@google.com>
>
> Add support for genfscon per-file labeling of bpffs files. This allows
> for separate permissions for different pinned bpf objects, which may
> be completely unrelated to each other.
>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: Steven Moreland <smoreland@google.com>
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
