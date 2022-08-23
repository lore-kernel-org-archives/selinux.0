Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD03FC32772
	for <selinux@archiver.kernel.org>; Tue, 23 Aug 2022 18:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiHWSjx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiHWSja (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Aug 2022 14:39:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015981151D6
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 10:02:54 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v125so16787126oie.0
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5ra72b4qNtNT5/Y8jyxLZXNvJFrA5g4ZvUa/siW8nrc=;
        b=Rg9KqkTbhDsx/lxgn3tH/StZ2ZUh0LEpW0faHIyP8g0kYJTa+Ywx9u/V2wYpJ1V3Al
         KEWkjzcT+JDbL2nzQ3d/L4mTsRM89S9fXveF64lTbLHmCHITSXDz9soOhkQOUOfFjA7K
         se4JbQU3WkjCJCmGwwKzO7Ay94mxODHVwPqmnIlL5s/9YoHgi3hHnxHxgJOhSahkUmjd
         xvmte1qK3TXfAP4aVgf45E3/8/1/LChRhBrbBnnbU7XDbpTYNkX5dm74zHttr8K1T1lg
         3qkdBJ5xnX48IJbFyzWlAmMj+7FIyjNWpVfvPSxKUmi2swMd9PxVysP/f7gVNUBUOCRZ
         PzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5ra72b4qNtNT5/Y8jyxLZXNvJFrA5g4ZvUa/siW8nrc=;
        b=GwDSHlHUia5KaWczjyGvQC+uH8TPllJZL2WFrfdv0MgIku1iM11FhZ5h6+22LYlcpn
         HSydbZgX7v+YZIj10n4rn85M6e5tEdSrP8K8hhW6hhEL66J7Uf/0vbDt5m5gsG4jJDj5
         QuGtzgfNdx0LcirOnKvoEnJ15u8Xl2OIBKRe/UoD5x0hja7wLwucmdXZF2gn7evbCLRO
         16ih01kUVNUHRB8x1MqygOBy1cN0cEvrUW10+jXQ+CQbZFTZrRDIs+csTXTjqGmtzM89
         T5Vx7I5kOuGKw71aqM9lTodbKjWgP2YO+E5bxMnsH3rt9HUNd9TeK5xShyNjybXCFs/L
         z6Wg==
X-Gm-Message-State: ACgBeo2sxO0o0w9GWK+OIUQs1YC7mjE+7cbfA2RVHSs9S5HyZhsr+RKW
        a0lA+NgDOXwG9pTJWeXnsIzrRLqYdxxAni+pPcsKoYBsk/K5
X-Google-Smtp-Source: AA6agR7t8bOik6TV8VoD43ntts3M9ydgQUxiv64BSr02QdRPvcxKN04bquZG9GJRFCRRtbxhCt2WNmN+BWaOEhhjlmA=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr1702207oie.41.1661274174127; Tue, 23 Aug
 2022 10:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <166120321387.369593.7400426327771894334.stgit@olly>
 <166120327984.369593.8371751426301540450.stgit@olly> <YwR41qQs07dYVnqD@kroah.com>
 <d2a66100-6660-8f99-a100-0f3c4f80d0ac@kernel.dk>
In-Reply-To: <d2a66100-6660-8f99-a100-0f3c4f80d0ac@kernel.dk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Aug 2022 13:02:43 -0400
Message-ID: <CAHC9VhRiTDqL-EtUcJ9y8nzRPk2BAfGzWK97oe56Ld4KyZsmGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] /dev/null: add IORING_OP_URING_CMD support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 23, 2022 at 9:33 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 8/23/22 12:51 AM, Greg Kroah-Hartman wrote:
> > On Mon, Aug 22, 2022 at 05:21:19PM -0400, Paul Moore wrote:
> >> This patch adds support for the io_uring command pass through, aka
> >> IORING_OP_URING_CMD, to the /dev/null driver.  As with all of the
> >> /dev/null functionality, the implementation is just a simple sink
> >> where commands go to die, but it should be useful for developers who
> >> need a simple IORING_OP_URING_CMD test device that doesn't require
> >> any special hardware.
> >>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  drivers/char/mem.c |    6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> >> index 84ca98ed1dad..32a932a065a6 100644
> >> --- a/drivers/char/mem.c
> >> +++ b/drivers/char/mem.c
> >> @@ -480,6 +480,11 @@ static ssize_t splice_write_null(struct pipe_inode_info *pipe, struct file *out,
> >>      return splice_from_pipe(pipe, out, ppos, len, flags, pipe_to_null);
> >>  }
> >>
> >> +static int uring_cmd_null(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
> >> +{
> >> +    return 0;
> >
> > If a callback just returns 0, that implies it is not needed at all and
> > can be removed and then you are back at the original file before your
> > commit :)
>
> In theory you are correct, but the empty hook is needed so that
> submitting an io_uring cmd to the file type is attempted. If not it's
> just errored upfront.
>
> Paul, is it strictly needed to test the selinux uring cmd policy? If the
> operation would've been attempted but null doesn't support it, you'd get
> -1/EOPNOTSUPP - and supposedly you'd get EACCES/EPERM or something if
> it's filtered?

I haven't built a kernel without this patch to test, but yes, you are
probably correct that it wouldn't be strictly necessary, but
considering the extreme simplicity of this addition, what is the real
harm here?  Wouldn't it be nice to have a rather simple
IORING_OP_URING_CMD target?

Also, just so we are clear, I didn't mark this patch with the
stable/fixes tags because I don't believe this should go into -stable;
while I believe it is a nice addition, it is definitely not critical.

-- 
paul-moore.com
