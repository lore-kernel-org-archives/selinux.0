Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08875C433F5
	for <selinux@archiver.kernel.org>; Tue, 14 Dec 2021 01:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhLNBBZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLNBBX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Dec 2021 20:01:23 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24FC061574
        for <selinux@vger.kernel.org>; Mon, 13 Dec 2021 17:01:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z9so3316519edb.5
        for <selinux@vger.kernel.org>; Mon, 13 Dec 2021 17:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZTk8bolDq8/AsAo6cCvCa2jFjj2UMoaT2w91uUpBEc=;
        b=EWSX5TugXgKv4N+dwxotwxMNZxve0zOIj5eLGBp2j6FjRL8kQ1It+38OjMgyIARxoK
         g7dSDKxatJxdqE/lCHG2ooENewN8QST6123SqGZ1vxld834qvfhe1wFY2FVbk5Kx9NUN
         Ol9f8GXizE4VLwWKRjN0f1lyv10+E5xv0whZxwFjoGWp+I1NlzoTGQLy2TqHmS/6qwCx
         JlyYgTZ4ldR9OuoFDPTiT/vPN6sFfSwavhin2ux4wse4Nr1mUBxEnN47WzThOwXqhMOy
         cCDE45WT/W1cOFrHZtgpl5aZ6WBZU8835Q9kN6fyvfldve5Mergf85UvP4MqSG8lLEpc
         Gv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZTk8bolDq8/AsAo6cCvCa2jFjj2UMoaT2w91uUpBEc=;
        b=nZJdMcfgsmJ7gw+z0avZ2dBARDac0vaG2sGrKUO3LJcuskU5R4a0gqoh8VPAKAMRxw
         FuhZfzLI2ZCVnaTJIPd9HbTgYltseQ97cD9NAKDkfuYCmRBGuiAyB0Ue/1h0065AJ1uL
         bzv/9PuWPiIEEDkiNACUecAlOexpugOJ/MgUjhZcS/A/iOH4ZH2MiTqyYlq1a8Dob7cq
         gS9VsFQriy2/3tQNx3/CbePT74f8YOhrFZFxwv7dDlltyHh66WjkpkqVZUlTBdyQ6+th
         KYiNVuCEA5mSKPBMnSQ+g1ZIKjZEVReyux7eZbnmdTZhb78Z/Jprfn0RTcicfgxwj1Oi
         fj6g==
X-Gm-Message-State: AOAM533YoGuUOq/ku7fcjy0ivvb+Qw+ko519WWLvhYOIl4UfwHwu5q4T
        z8DrHEkjHCh3oQDTycASpwVaOUa3xEp7xwU5/adu
X-Google-Smtp-Source: ABdhPJz/9+a7X0xDosHqkYTwqDn0f+nzmvByx+pT05kFTz8X7m+PMRdD4q2SIjtj2HdXD51xOVdT7waXwxbjD5wquN4=
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr2127605ejc.327.1639443681693;
 Mon, 13 Dec 2021 17:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20211213101622.29888-1-richard_c_haines@btinternet.com> <20211213101622.29888-5-richard_c_haines@btinternet.com>
In-Reply-To: <20211213101622.29888-5-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Dec 2021 20:01:10 -0500
Message-ID: <CAHC9VhT5hw1JcgqOGZdTxaVWK5mE0gKKWiPLbJ3aZts+qm387A@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] selinux-notebook: Add epub build
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 13, 2021 at 5:16 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Build an epub document.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  BUILD.md            | 23 +++++++++++++++-----
>  CONTRIBUTING.md     | 10 ++++-----
>  Makefile            | 48 +++++++++++++++++++++++++++++++++++------
>  README.md           |  9 ++++----
>  src/cover.md        | 16 ++++++++++++++
>  src/cover_epub.md   |  2 ++
>  src/metadata.yaml   | 14 ++++++++++++
>  src/styles_epub.css | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  src/styles_html.css |  8 +++++++
>  src/styles_pdf.css  |  8 +++++++
>  src/title.md        | 16 --------------
>  11 files changed, 169 insertions(+), 37 deletions(-)
>  create mode 100644 src/cover.md
>  create mode 100644 src/cover_epub.md
>  create mode 100644 src/styles_epub.css

I had to do some merge fixups due to the logo change, and I added a
few missing oxford commas (*cough*) but like others I had mixed
results rendering the EPUB on my Linux system.  Thankfully the HTML
and PDF formats still looked good.

However, one of the more unfortunate things is that when I tried to
read the EPUB on my Kindle it failed miserably; although oddly enough
the PDF worked fine, the text was just a bit too small to read
comfortably.  I think it would be good to be able to generate a Kindle
compatible EPUB before we merge this.

-- 
paul moore
www.paul-moore.com
