Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F5AC433DB
	for <selinux@archiver.kernel.org>; Sat, 16 Jan 2021 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D71B23118
	for <selinux@archiver.kernel.org>; Sat, 16 Jan 2021 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbhAPMtW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 16 Jan 2021 07:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPMtV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 16 Jan 2021 07:49:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AA6C061757
        for <selinux@vger.kernel.org>; Sat, 16 Jan 2021 04:48:40 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so5235693edd.5
        for <selinux@vger.kernel.org>; Sat, 16 Jan 2021 04:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nhvH/X61UPaWTImifW6SmI44v8XwN9QGMfK7j4xSy3o=;
        b=rVSjYpITqHGpqF/+miVZ+Pi4D6QKHjAmfdlqK3oYZeO/AZl2vlMUHb2FbX74BxA09k
         11BgzMWnLB3hxB3tq9/+OEyxI9WfiG/Fo0Op8hWrcWePEhKeoHvd04GBvdKC9+/VYB0e
         yVqhORG9Dws8wtSwJFXKnOFUUrfgBr691o33ptDz/rDOYLGn9wPPrwbPwWqqtBEKrBY7
         DGw/+CNiV7ECy10rQ7x2BVl2nfq8cjwfINkixIbJ33F7QkNbNQtIfNcLIagFQTTgE6Ah
         TD6c/OXA8AGntRjxM+H1ljfONrdhHDyRaLpk1uw2ZXOeEQ9/qS5SJweC578XxiQoLEeH
         tHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nhvH/X61UPaWTImifW6SmI44v8XwN9QGMfK7j4xSy3o=;
        b=CiqSYInF7r+NlrJifwFo0HIuIoIndHfF978hR5l+jl2vfhpCixqsgzHfHy/KGELowJ
         9HGacmhn86H8azuV/+p77Q0kHHxZVbqR5MMoyf2z/JEnKDKFZRyjH1+d/YIwxFZRSy1a
         rIH9rQiWvW/bWvEJaobvkWR8DedasTgQFNYPkBpxcfjB5u3Tv4bJNtzWWKPLovBbjA+w
         1NR59vsrMrCYmDkiQWldBWrAgBddKrhqP4u61AoVNoWE00ZgIW1Z6pS4at1cA9cdTsK1
         h80CHqJB4jgik7uxe6I2ZfPNpJFqJh/vV6T0tbYlQzbDTq43I9wQYp1ZQRQkgvvGW4+2
         /LQg==
X-Gm-Message-State: AOAM532/0bFafr7fBFpTYc0UbTgqL9vD9UPjfaRcOiz2seK0VDHEnf2q
        mxu0vPx2C9P0d3hoP6i5OGzhV7t0MLQLWjddFF41ZyB+ywbDSg==
X-Google-Smtp-Source: ABdhPJwfj/QdJwwGMZUIkiIDd6AwWJqhf3PYCDXrkp9dPPWHQ7N6uqB/BxFeaESyCDBzB5ipp2gc5n2bTSEU9ZxmoyE=
X-Received: by 2002:a05:6402:11d3:: with SMTP id j19mr13120801edw.314.1610801319060;
 Sat, 16 Jan 2021 04:48:39 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Sat, 16 Jan 2021 16:48:27 +0400
Message-ID: <CAJ+F1CKqVX6L7HGqiRGqxxTgyhrLAGbCSMvcv4NrBR_3C-Q93w@mail.gmail.com>
Subject: VSOCK & getpeercon()
To:     selinux@vger.kernel.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

getpeercon() isn't implemented for VSOCK. Note, I am not very familiar
with SELinux, but I was porting some applications that uses AF_UNIX to
AF_VSOCK and reached that point.

I found some previous discussions about VSOCK & LSM from 2013, but the
reasons it was abandoned don't seem so clear or valid to me:
https://lore.kernel.org/selinux/1803195.0cVPJuGAEx@sifl/

To me, SELinux could always associate a VSOCK with a process context,
at the very least, and thus enforce some communication policies. No?

thanks

--=20
Marc-Andr=C3=A9 Lureau
