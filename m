Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C4C46470
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 17:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684AF26D78
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 17:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XKN/x+IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfEaRyV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 13:54:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42702 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfEaRyV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 13:54:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id y15so7221678ljd.9
        for <selinux@vger.kernel.org>; Fri, 31 May 2019 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nT30FLV8V8r7rS3YVbwNsm7LRzdGW2CXF/e9e4gpF4g=;
        b=XKN/x+ISQstRG2eEdz03yF04g9UNBHAyy0hQuqmA9W0PUQgmL1Nm7TR0wkzfmM8Bed
         LYHTFiCxXWzMrXNgbg2NfhYse8keHtJ1bhkCpBvCnUvLM6Lw61r8NboS/WRn8HXz6cZd
         eiud2xLE+0TRpofj32zwHdvCbCG3BCL+9rnmhaLQGaLlF6UabnBzqBJcCF+zJ0vkRY2C
         YqRwWy3vhuDk4xMRX7c2LUQxQNUF4algh7HM911rd6dbVM/UV3qlelkppVn/x6BGDrdp
         zkVPIkYtmN75xGNN/qNWOz8CrpQzzzQB8mTFo96/CP3Tu/VpXYcr8W6+XCElbHrKB9Uz
         +9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nT30FLV8V8r7rS3YVbwNsm7LRzdGW2CXF/e9e4gpF4g=;
        b=PkvR+RYD/wFBs0qU/J8fNtG5uN9FGBnajPPe4fiKN3JG+2ip6oshn/yOAZKfsS6QG0
         bHHgWeQcrZWCR7xQ/yMneLzvWjv5dmCugNDUEG2s3k4rlhmBLBc6hl4xfFVHjzjWH+9k
         /Vn/c6aWNXe6ZzYWawHb2KNSI/WDgDInVkBzIw0hJiKW9GFZrSxwLBLEAATS4qUHQQkU
         dc+F1XOoCnBE20SRfnb7GIbPzv2USjP5BTSozDDJxQcHn66ZY6Dm3TawZ9/WY0NPVjG8
         38hI2OJIFvNTFSJPF3RN11ZKaYm5fbZkCou2woA0LfFhHEWuxrGEFVYpvmkEGLfUJzBD
         yqrA==
X-Gm-Message-State: APjAAAXxh7wI4TuWfJjAHr0zZAcJeMqDcTDnJCMtvNMDlADliV96wBOv
        VF9MaNn33Kr7vuDJ09Qdb0wY+PR9Yuozatn37G2t
X-Google-Smtp-Source: APXvYqxvsb1rZJEbTuqzQmxZaDpRDYaGbPlhsEDlO+gRf4X7iYLoaMS2Lr1v5i2V4UbErVqUIA+MO2H2I145YXXf7dw=
X-Received: by 2002:a2e:3e14:: with SMTP id l20mr6760972lja.40.1559325258834;
 Fri, 31 May 2019 10:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190529160337.4672-1-plautrba@redhat.com> <CAHC9VhS8+h5TW1fAsss0uq=XspPun+SWzxRquusP6gLe7FMG7Q@mail.gmail.com>
 <CAHC9VhQcuQ8+eoxXXqtEL4+PyxrWdpVvgMG9FDKnmr_XfaBsiA@mail.gmail.com> <pjdo93iv7q2.fsf@redhat.com>
In-Reply-To: <pjdo93iv7q2.fsf@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 May 2019 13:54:07 -0400
Message-ID: <CAHC9VhQcrzJ7bQZccJw9v7cYUewMGMRdDVm8bkBwc4KFYsDKng@mail.gmail.com>
Subject: Re: [PATCH] Add CONTRIBUTING
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 31, 2019 at 1:45 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Wed, May 29, 2019 at 12:05 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Wed, May 29, 2019 at 12:03 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >> >
> >> > Based on https://github.com/SELinuxProject/selinux/wiki/Contributing
> >> >
> >> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >> > ---
> >> >  CONTRIBUTING | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 60 insertions(+)
> >> >  create mode 100644 CONTRIBUTING
> >>
> >> I would suggest updating the wiki to point to this file if/when it is
> >> merged upstream.
> >
> > Sorry, one more thing: you might consider adding the ".md" suffix so
> > that GitHub and others will treat it as Markdown.  I know that GitHub
> > also treats the CONTRIBUTING.md file in a special way and presents it
> > to users in various parts of the web UI, for example it show up in the
> > sidebar when creating new issues.
>
> Using Contributing.md in code would mean that it could be directly
> copied to wiki.

Another benefit, although I would encourage you to simply put a
pointer on the wiki to the repo file; duplicating the text is almost a
guarantee that one of those copies is going to go out of sync with the
other.

> When you say include DCO directly in Contributing, do you mean something
> like
> https://github.com/bachradsusi/SELinuxProject-selinux/wiki/Contributing
> ?

Yep.  In case you are wondering, here is what I did for libseccomp:

* https://github.com/seccomp/libseccomp/blob/master/CONTRIBUTING.md

-- 
paul moore
www.paul-moore.com
