Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFEC433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Dec 2021 00:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbhLNARe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Dec 2021 19:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhLNARe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Dec 2021 19:17:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FEBC061574
        for <selinux@vger.kernel.org>; Mon, 13 Dec 2021 16:17:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so57149221edd.13
        for <selinux@vger.kernel.org>; Mon, 13 Dec 2021 16:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWtAT034Bu3HTMKSgNv0iU103sF/RXovQxTxX6JX6X0=;
        b=PiOY6Vht70o5o7EQtW667KBZ9aj+6fK0rpqBwYWK9RRDGOYBtxOvu74C0W7HRa/yy2
         Fk75vxgNJ5i9ScJWQfjZXl7PzBSedO3lGwjy94z5KAZsOoMQtixL5oHjLG5oaIt+zidS
         wy8ME9g8Rt/X6mbTlNBGwwUQDDWQ2wu++3rr3iHSOtruE/nej1d7f5zuE+Nl7vXDceHU
         EFjLQQYL9W4hK8xpsSNEkGyOtd1I5T2xMaF7o5yOsb6DxFzfJEmaG5KbQHhoGSpYmKeh
         3sZv0CA0tPeMiQJV3/lpPFBcutQ8TTbnxvqBNqZL94ys/Hs/n1VF5ml65HDxAJwMkNy2
         +IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWtAT034Bu3HTMKSgNv0iU103sF/RXovQxTxX6JX6X0=;
        b=FfMrkfPp8AbXAnj8f4WCCVbsvJQ1FN28LZ74Zwf/EddvAgS/mNZSw6i4qzoUvf/3I7
         uNgOyznfhGGyH5rpZyOUWgL4BoYfcf8AejmLbKBWcVoDdxvKO83BHJ7mzkCcTj3v1i1s
         HPQ5glQ4Y3cKZWvS2SiNWCcPQjG+WAZNAG4FbbW4AAYg91v8C4fq7YQS6ev2Tkzaju0d
         A6IPsGsEmQlnd4OJOa7hB2/wosakzCmXKM68CMjzla7Q2dDKekW8f5UZVrhG2h1DUvwX
         e3TbX0fIMN1po9DvwIb9qB6fiEnis+A/vdXs9uHs+VkvKjaJv76u/vtIatfX0tVPPpou
         lStg==
X-Gm-Message-State: AOAM532U7wD2mR6hMv0WaQslJUMLfh7gZMoh0mSEPG5umQoMn+D53rf0
        FoCdoEvbWwSzjNZW6kWx76BM0K1kVQ8Nm8H2lPeJfiBTIw==
X-Google-Smtp-Source: ABdhPJyM8B9UdKJGua01IokdYRDQsReJL9+4UNx3m5fDxThKhImWrtFexcfRdNc8q0hwriVLwzrF4Hl4928tsRvIWVM=
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr2935021edc.103.1639441052536;
 Mon, 13 Dec 2021 16:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20211213101622.29888-1-richard_c_haines@btinternet.com> <20211213101622.29888-4-richard_c_haines@btinternet.com>
In-Reply-To: <20211213101622.29888-4-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Dec 2021 19:17:21 -0500
Message-ID: <CAHC9VhQX9r29nNBQWK3M3q_9ZC2KegV6miSTpv1uHLrkggOiPQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] src/images: Add new SELinux penguin
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 13, 2021 at 5:16 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add new image from SELinux artwork repository for document covers.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/images/selinux-penguin_400.png | Bin 0 -> 65728 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 src/images/selinux-penguin_400.png

I just merged patch 2/4 and 3/4 but I was pretty heavy-handed with my
tweaks, if anyone has any objections let me know.

- Squashed 2/4 and 3/4 into one patch so that we didn't break things;
I suspect this is what Richard wanted but the mailing list wasn't
cooperating. :)
- Fixed the old SVG links in the Markdown.
- Removed the "SELinux" from the bottom of the image so it is a closer
match to the existing logo.  It was also a bit redundant within the
cover and README.md.

-- 
paul moore
www.paul-moore.com
