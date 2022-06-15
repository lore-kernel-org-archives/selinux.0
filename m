Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A17C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 22:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354635AbiFOW6o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354709AbiFOW6n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 18:58:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332BF1FA50
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 15:58:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h5so17247490wrb.0
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7d59e8cLd9zR8JBI8Qug1RRbOtLsaHXxn7NGGAbfac=;
        b=8FEQ/rKC2z2qweHx7AbNnl2OYRuMQjwUirgjoVVMGbDTTjJdWJhGsVCJJYtp5+5eK4
         XtelcaIv34qF0q9Qht2XX40NUplwFjmE4HSeV9obfyTk/EG2SiYkSsY+o+KaMg8vZ7wI
         cPdHFWwmLlrRt8JVt5BVzHT83TUcwfR8gYt6STFWC5FVCK9OdeLtCOuNFlD/ydgiWPN7
         FIxA+8CsKA9MkkwAHKLeHqcf5aIkmWD4sVM32RDt5XFgw5cWWNNKxVW1VI6j2/6kMn15
         onIlZFHJAhSSPm1pKn7i+uPJ2VlO5crOq9hJmTNO54fY0IBK2HjT49IkScVZEC5lbWF+
         nFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7d59e8cLd9zR8JBI8Qug1RRbOtLsaHXxn7NGGAbfac=;
        b=r8gO5PwEGqE6jlDN56Q4dgJEzE22Pc3KsFxWhF7uU1Zl0NjcUFp5n1908Y9dKhUpQ/
         FeBWQvJVAa+b+MOVLVWdP6HKSBNjQCNxEfKYeLkX/+WPZcJISk/p1HBzms+5+cpz8DgU
         2u/cXLgL7HhH8KC6LW8KUJnise8155i97pJ7mg43YsO8jlG0CI/sysOLXZcTxDl9Vdpg
         XmGsOA+p5Tp+9n7jDjTklDQCdDe+QHyAE8kGTCez/sZ2jOX2QM3+7lGZIvQL4PFb/jB1
         r4ZI1rhxJBVxVXsjhbBSHGyTfQOWHZFtEZdsoJ4Wh54VoOCOpy0EAyHrGELRi3fkF0fK
         H6QQ==
X-Gm-Message-State: AJIora/7yUUHeZLgIw7Mra6suxeTVZ9R8ewlCMj+MV5E5f/yVSaH0GDO
        3fTNe8L01zU+ru6LeVR0suKTk8RAkj/hzvqpuOjD
X-Google-Smtp-Source: AGRyM1tR/8FwEvyL+Y8ZCasyw/O1y6VLQFDMk+WfCNi0tijbHrlOJ8pcBy3IJBRxFdOtz1bgY0/pm6gf+ypXk07cW+Q=
X-Received: by 2002:a05:6000:230:b0:210:31ca:28b8 with SMTP id
 l16-20020a056000023000b0021031ca28b8mr1923497wrz.538.1655333914698; Wed, 15
 Jun 2022 15:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220614132333.143042-1-xiujianfeng@huawei.com>
 <CAHC9VhQdfPBn4kbY0xRPaCvNBJJGdQQe_90A4Hhdsj6gVr6pAQ@mail.gmail.com> <CAFqZXNswaUiHNZA65GCsgB7GNLm6tc2OFXsQrTWxBTfWviQ8+g@mail.gmail.com>
In-Reply-To: <CAFqZXNswaUiHNZA65GCsgB7GNLm6tc2OFXsQrTWxBTfWviQ8+g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Jun 2022 18:58:23 -0400
Message-ID: <CAHC9VhTjaVN1anR34s5foehSMzz1s-xXY8JZ1k44MzSqCi2_EQ@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_policy
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Austin Kim <austin.kim@lge.com>, michalorzel.eng@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 15, 2022 at 6:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Jun 15, 2022 at 4:03 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jun 14, 2022 at 9:25 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> > >
> > > In this function, it directly returns the result of __security_read_policy
> > > without freeing the allocated memory in *data, cause memory leak issue,
> > > so free the memory if __security_read_policy failed.
> > >
> > > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > > ---
> > >  security/selinux/ss/services.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > This is another case where there is not actually a memory leak as the
> > only caller of security_read_policy() is sel_open_policy() which will
> > free the buffer it passes to security_read_policy() on error.
> >
> > If you want you could add a comment to security_read_policy()
> > indicating that the caller is responsible for freeing the memory.
>
> Can we please not have two almost identical functions with different
> cleanup conventions? Please let's either make both functions guarantee
> cleanup on error or neither of them (adapting the caller(s) and
> comments accordingly).

Priorities Ondrej, priorities.

Every patch posted to the list has a time and effort cost associated
with it, and between reviewing other more important patches and
working on a proper SCTP/SELinux fix, I simply don't have the cycles
to spend doing the back-and-forth on a patch like this to fix a memory
leak that doesn't exist.  It definitely isn't because I don't think
the code could be improved, it is just that there are only so many
hours in a day and I need to prioritize actual bugs and important new
features that people want merged.

... oh, and I need to reply to the complaints too, that's always the
highlight of my day.

-- 
paul-moore.com
