Return-Path: <SRS0=RzoT=4R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E025C3F2CD
	for <selinux@archiver.kernel.org>; Sat, 29 Feb 2020 00:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AE72469C
	for <selinux@archiver.kernel.org>; Sat, 29 Feb 2020 00:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LANn715q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB2AWs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:22:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42937 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgB2AWs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 19:22:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id o28so4786803qkj.9
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 16:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=TxHeLiHOK0KHMzChZ7KzElJy8r7bMAkE4Gb8mHE3iLU=;
        b=LANn715qcoHiMXgchXGlEpXXJQDChyZml9GNvJhR2vvdT3Xs//kMNLs5TAKi1OtPpU
         NoI69JvFM7tTiV2TsZnuJic9D9dgRfg+Zaul94SUNuhjhsXltkhnHAIHWAGRsE7igeEh
         QRWzdp0soyNhR9g+ESztLI5SFwjmw22sIKnGoj19vJLSYQIEJi4yMgLRwcBo4i0sr/ub
         SyzdQvF/ngOfFx1Z/icIQ9LLZHrPvtp0PdoL7MaT04SCmgXSa9/rBVLKrzNyPp/Hw2EQ
         +KTkOtD8Q2/xLtHT5IDZ8YQ0gxxc4KzyBKeihTMrs/VlIKNVm6hBj/v415PrR+W5cavk
         Skxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=TxHeLiHOK0KHMzChZ7KzElJy8r7bMAkE4Gb8mHE3iLU=;
        b=kpX0FmV75RIKD3uomx5gIOxUXPgFTn2VfEufyzPn2zdcZgmlrXc8zOzat8NEWCDcli
         8HYDhpVLQDc8Ozffq6mLv8WlXEbana7tWuakcJG2vlUF87vw285Sk0DpEOpk64KXBp6o
         rgg3SNjRWx9FcW11Q3b6FcPXbalicbNkX4rDWlIZfl1V5gtjhUY4jKn43ww5CY6k2iPf
         S6JHHmBJUOajzrUQT9AoD0iJq2NCYFP6nPQbD8N4kMdQvOR3iJ25ZHbEdlA5Sg3+BswD
         BqPtLfdIfZOOdShCo0+H9z9wCUSIw7Pc9V+zW84kIe248m4R/rUiTjikkeo2B7/RDP34
         Ui1g==
X-Gm-Message-State: APjAAAUgZ7P8/CoEAouXNsiqLagdKRiSVFjzUXM3cSMX+V+WqCU294Im
        7BKF39I4AtKaHlT6fEKcBMLw
X-Google-Smtp-Source: APXvYqyuW0Qg0zP/ndS6jFRasM7z9UQFJDVa4uPpcJzHSWrF0u77vaxF8+7S3zRyO+PvN8JsziIJZA==
X-Received: by 2002:a37:9504:: with SMTP id x4mr6613872qkd.453.1582935765856;
        Fri, 28 Feb 2020 16:22:45 -0800 (PST)
Received: from [10.0.0.222] (c-75-67-84-104.hsd1.nh.comcast.net. [75.67.84.104])
        by smtp.gmail.com with ESMTPSA id u13sm5875758qtg.64.2020.02.28.16.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 16:22:44 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>
CC:     SElinux list <selinux@vger.kernel.org>
Date:   Fri, 28 Feb 2020 19:22:42 -0500
Message-ID: <1708e51a400.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAEjxPJ5qssPY+Z1yRgLmff_1+-t5TjkknJnGSuSQFJWARZTZrQ@mail.gmail.com>
References: <20200225094529.178623-1-omosnace@redhat.com>
 <CAEjxPJ7=5yPzv+PCmtTsuN_osgmkxWGab4CN9y7k5LTEoT-dJg@mail.gmail.com>
 <CAEjxPJ5qssPY+Z1yRgLmff_1+-t5TjkknJnGSuSQFJWARZTZrQ@mail.gmail.com>
User-Agent: AquaMail/1.23.0-1556 (build: 102300002)
Subject: Re: [PATCH testsuite v2] tests/sctp: fix setting of the SCTP_EVENTS sockopt
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On February 28, 2020 2:23:27 PM Stephen Smalley <stephen.smalley.work@gmail=
.com> wrote:

> On Fri, Feb 28, 2020 at 8:18 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Tue, Feb 25, 2020 at 4:51 AM Ondrej Mosnacek <omosnace@redhat.com> wr=
ote:
>>>
>>> First, the setting of SCTP_EVENTS socket option in sctp_server.c is
>>> completely wrong -- it assumes little-endian byte order and uses a plai=
n
>>> int instead of the dedicated sctp_event_subscribe struct.
>>>
>>> Second, the usage in sctp_peeloff_server.c is correct, but it may lead
>>> to errors when the SCTP header definitions are newer than what the
>>> kernel supports. In such case the size of struct sctp_event_subscribe
>>> may be higher than the kernel's version and the setsockopt(2) may fail
>>> with -EINVAL due to the 'optlen > sizeof(struct sctp_event_subscribe)'
>>> check in net/sctp/socket.c:sctp_setsockopt_events().
>>>
>>> To fix this, introduce a common function that does what the
>>> sctp_peeloff_server's set_subscr_events() did, but also truncates the
>>> optlen to only those fields that we use.
>>>
>>> Fixes: c38b57ffdac4 ("selinux-testsuite: Add SCTP test support")
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> And applied.  BTW this was my first time using get-lore-mbox.py [1]
> and I really liked the automatic collection of acks into the commit
> message.
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.g=
it/tree/get-lore-mbox.py

FYI, the kernel.org patchwork instance collects the ACKs/Reviews if you dow=
nload the mbox file.  That said, there has been a lot of work going into th=
e lore scripts lately and I expect there to be a lot more development in th=
at area in the future.

--
paul moore
www.paul-moore.com



