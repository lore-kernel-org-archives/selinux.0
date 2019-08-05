Return-Path: <SRS0=PMFh=WB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87567C0650F
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4208B2086D
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nAh0g33U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfHEUrx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:47:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35240 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUrw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Aug 2019 16:47:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so80485246ljh.2
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2019 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lNONgbTZg+kFSese0xVQ1u/9Gcc7S99i5lFLEOyZKkU=;
        b=nAh0g33UvD4qhS4XodRCKi/IXxTCzcw6gIRN+1QDI0FDBq2RbwZfyAu9kNI4MHcDM8
         F1e0hzHBdET5azlND6SM/wGpBLTPLKO48rTNhDRFp8mDDxJrdbaoNi/hGOm7SV977M0i
         g1bsUu5pxoFdmRRG67Ogm6mnSEQNVt8xaSSPZTNB4IYM1rGOAoKb8lhR//wKKhCymBjZ
         +YsyXw9PNxk57/o9LEQ0lf9mTiJUKi9hWzXLBM8t4OeIVwYb1IHoVjMqqX6on4WIgtve
         Sto9Cx9PLmHkO01VSXjY1DZ0KeIDbZB0ndphsWHBR0pI0i1IeLh8PSfhP9WOyYnkAeXx
         Sa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lNONgbTZg+kFSese0xVQ1u/9Gcc7S99i5lFLEOyZKkU=;
        b=dTI3dYs+dTuuF0thnUcsMD6LhH0K0UWJOGopaXNui5CN+O5yQdQDU/g/+++vy4BINI
         74Z9WZlPsEHh9XqYOiswmHd6tj8dKE+CkmgJm81XJ8YWteDCDQ6QUZe/ZuVfGXbGaSY4
         I0TFjCgguhUMX2l/zCuU84F1QSYfspHFAWVHBHaaLKbAvhfroM44qIrM25i9mgXtj9uy
         Ga3KTCvmHe1iobZlz3m/2O4lYXfCOxrdGbApo84rAOieLhA00KbWHZ7Rt9vQxGQ1CzSE
         7+EKxVfOoc4UH7ZrMK7xZTrWx0E426dGtKHcYvt8nuCGIdjfqNcwewIiD5VBRrsb1vL0
         MPJg==
X-Gm-Message-State: APjAAAUNQJxd/lCJt2GkqqB4AiNnlgRhftEvhfVoXumzLHQ+4eFS+HiO
        V9JBEGnd3UbL+/6hhP1KGCkWIss5N98E+LrSpgLw
X-Google-Smtp-Source: APXvYqzUuwmGaTha05eS2DVDzCDv49t2LsIw7UD3VkV1ym4ZwMxnohrJWF4si9Vc+Be1rNOJ6yLWAMdRoAVANOY490w=
X-Received: by 2002:a2e:834e:: with SMTP id l14mr33327076ljh.158.1565038069820;
 Mon, 05 Aug 2019 13:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <156461575415.7833.141394474474181558.stgit@chester>
In-Reply-To: <156461575415.7833.141394474474181558.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 5 Aug 2019 16:47:38 -0400
Message-ID: <CAHC9VhTagSjS=itNZdKvnmR2+-wK5QNTTQDERbrPLcLAcE7ySQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: shuffle around policydb.c to get rid of forward declarations
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 31, 2019 at 7:29 PM Paul Moore <paul@paul-moore.com> wrote:
>
> No code changes, but move a lot of the policydb destructors higher up
> so we can get rid of a forward declaration.
>
> This patch does expose a few old checkpatch.pl errors, but those will
> be dealt with in a separate (set of) patches.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/policydb.c |  376 ++++++++++++++++++++--------------------
>  1 file changed, 187 insertions(+), 189 deletions(-)

Seeing no objections, I've merged this into selinux/next.

-- 
paul moore
www.paul-moore.com
