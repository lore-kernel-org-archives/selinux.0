Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA50C433DF
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C668D2053B
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591206466;
	bh=N8R8pSuHgSbcthCl3xg6pH5o3sSUgkR8ukFXEmttun4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N+hK3rsVR+4m0sxBGHurLCc8I+hwyZ+0vIMHNw1nSGWWW3RQJSJ5nZCGYPm8BRnRz
	 ZCaz8eURnN3f+wcZ/pwCNGMNyeNM+NpMdiEHfBhyYnR/q64L160fVpPXOoYTMfaL42
	 SSYc4GArzx82sIdq3z2Gtw0o8iLT9pBYMNdpkTts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFCRrq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgFCRrq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 13:47:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BD1C08C5CA
        for <selinux@vger.kernel.org>; Wed,  3 Jun 2020 10:38:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a25so3829676ljp.3
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2020 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmZLnge/JsJbbtstAv9yQbEIQ8yd6Uru632t/pS89cQ=;
        b=NFxCY+bXPLUGZdo7dT3SyTWmToxnyjr4RwN7Skl85wz7MjddHjn2AVfAy7MdqJtKKC
         uXAje7NxrbVdIfpXaqXBBty29zjcQKBbI5aRDK6Ya5s3e7WblNy4BfS4+Mfuz6pzBafg
         rVo3l+YqXE/um6wh4OJHcUO+5+Pm7Fiza4+jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmZLnge/JsJbbtstAv9yQbEIQ8yd6Uru632t/pS89cQ=;
        b=rC0UwEqgqVImYNAhd8evizlS6vfIQ6Yf7w5/6X7eNpT/Plub4Ot6cnM05cuAt7PCQ+
         dzpi9/dUONatsLw0c3OQ4M5B24EKECdZVlNLy/xQtXsOsCYCawWqLm1u/U9VnTEAKkvm
         h/7q0LerxyJfJ53ZYkFx5hZlTmpR61Hej1wiuDQivOAeCt9VSG8rfzV5xDf9wBhYh6HX
         jEWwnh8WYGt66JxuPcJpE8dNTRZO0ztYdiqTOxykr+M2lKXmoPct07QaZpVSHtjRkgMW
         TOYE0bmIefJOV0XRte/VXAbWMRYDaY4R7y3yEGGo8LrxT0OiUgszgr5U2VXqVon9bDT0
         D5TA==
X-Gm-Message-State: AOAM533/9eEseEO+Qf/03vB3z/eI/A7409SNrcurU0IX9cQ0b9yPjIHQ
        A1v/wBU6l7lYLCTYqo752N1bek1sCNE=
X-Google-Smtp-Source: ABdhPJwR1axST8PHU8DoNllU5Qud6jxiMDVELyBI2gWL8mBiF8NUafhQHLiY+rO+4wD9JvAtgvJAfw==
X-Received: by 2002:a2e:9917:: with SMTP id v23mr156831lji.225.1591205884658;
        Wed, 03 Jun 2020 10:38:04 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y3sm351377ljk.39.2020.06.03.10.38.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 10:38:03 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y11so2169004ljm.9
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2020 10:38:03 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr159019ljn.285.1591205882849;
 Wed, 03 Jun 2020 10:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com> <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
In-Reply-To: <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 10:37:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkZROyMpBa8EKPDVK=SvurnrzJXgphQ8Fstx8rrfO6MQ@mail.gmail.com>
Message-ID: <CAHk-=wgkZROyMpBa8EKPDVK=SvurnrzJXgphQ8Fstx8rrfO6MQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 3, 2020 at 10:20 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> We could have inode->i_security be the blob, rather than a pointer to it.
> That will have its own performance issues.

It wouldn't actually really fix anything, because the inode is so big
and sparsely accessed that it doesn't even really help the cache
density issue. Yeah, it gets rid of the pointer access, but that's
pretty much it. The fact that we randomize the order means that we
can't even really try to aim for any cache density.

And it would actually not be possible with the current layered
security model anyway, since those blob sizes are dynamic at runtime.

If we had _only_ SELinux, we could perhaps have hidden the
sid/sclass/task_sid directly in the inode (it would be only slightly
larger than the pointer is, anyway), but even that ship sailed long
long ago due to the whole "no security person can ever agree with
another one on fundamentals".

So don't try to blame the rest of the system design. This is on the
security people. We've been able to handle other layers fairly well
because they generally agree on fundamentals (although it can take
decades before they then end up merging their code - things like the
filesystem people standardizing on iomap and other core concepts). And
as mentioned, when there is agreed-upon security rules (ie "struct
cred") we've been able to spend the effort to architect it so that it
doesn't add unnecessary overheads.

             Linus
