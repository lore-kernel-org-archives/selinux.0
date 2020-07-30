Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B45C433DF
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F142070B
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjUF00W2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG3Ous (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Our (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 10:50:47 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B99C061574;
        Thu, 30 Jul 2020 07:50:47 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id w1so5274300ooj.2;
        Thu, 30 Jul 2020 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n8J2m5u07Q5LrlrNsTTftXBpKUr3fzjgIgd7DPs1RVg=;
        b=KjUF00W2Azha/60W2r09lRyLbwMfgG9BaNz1SjLC9bKLxWwsz4WKr0t+eF7Zkmkxnp
         5mBoZMKc9CrOv1+5f7PvzDr5xyrZT2HaAqa6O2NDgIaM+acUVtqk96lLGxV/to4GeC+W
         XFjnKIwF5+jWylUhMr9ZiujAjjgzd1ZZxC7etVYI3i8NpBJlqWplgSRaL8cMHiBUHljg
         ghWfjY+/DmOGpG9nEIYCGtpuuuRop3dZa1Hlci9WXCHEVuBcmgULZhernwq9uj08aukZ
         5hWcQtwyumbMJQiKPdrFdQguZLgtpjiqDTChD/X20/G6mmq+QbuhJhuRkUsTckB2WZj8
         HI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n8J2m5u07Q5LrlrNsTTftXBpKUr3fzjgIgd7DPs1RVg=;
        b=Q3LiriRLpBwxWvk8FT0DNi2OMmvfzfTI0ZEDQR5H8L5OTaJzrOlFUlXw/PsmcIhAZ2
         pOvMbc85w494MqHwjGq8Wfhm3IjZ2J5LPZrNytz7VmCVrFjlfD/EmA7h2SgF8vdfhiaJ
         j/4vKcLHUALm7Exm/v0dPJvXkgJyhimHZB1aNy3m6LcgyHoe2MdU0lleGMcM56oYpPTE
         m1+MWyKEIrdKwoklHCbPLDtXbl9Owh53WvhbE87alTth0ZiubDoXYdrgwmF3Nr5soMpG
         YOykJacxjGjKM7xykrs0yExHsx1zw7jQhUaetD4LOZNeOKoFPhyzJpJQU+al5gfUucYK
         UT7w==
X-Gm-Message-State: AOAM5335GPMh8dc14mF7/cQCBXyl0/7fUTyuXgQ0CvSMfe8XquVhRUpU
        gGP9KLh1R/HZWeQCBDCuZckNCUmlo6HF9UA0Fgs=
X-Google-Smtp-Source: ABdhPJyrG7DpH7VL/mYWZxhvX1/djwJUpW/IGkzfK0asWtDmdE5ONEj9ZS+ZSGgK6005ABF/9NUY76s0IaJsOU2/2R0=
X-Received: by 2002:a4a:3b0f:: with SMTP id s15mr2647317oos.71.1596120647022;
 Thu, 30 Jul 2020 07:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <20200724095232.5f9d3f17@oasis.local.home>
 <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
In-Reply-To: <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 30 Jul 2020 10:50:36 -0400
Message-ID: <CAEjxPJ5tu=R20snbetzv+CCZMd-yD+obbkbf6MYVqQx3oZLkqA@mail.gmail.com>
Subject: Re: [PATCH] RFC: selinux avc trace
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 30, 2020 at 10:29 AM peter enderborg
<peter.enderborg@sony.com> wrote:
>
> I did manage to rebase it but this is about my approach.
>
> Compared to Thi=C3=A9baud Weksteen patch this adds:
>
> 1 Filtering. Types goes to trace so we can put up a filter for contexts o=
r type etc.
>
> 2 It tries also to cover non denies.  And upon that you should be able to=
 do coverage tools.
> I think many systems have a lot more rules that what is needed, but there=
 is good way
> to find out what.  A other way us to make a stat page for the rules, but =
this way connect to
> userspace and can be used for test cases.
>
> This code need a lot more work, but it shows how the filter should work (=
extra info is not right)
> and there are  memory leaks, extra debug info and nonsense variable etc.

Perhaps the two of you could work together to come up with a common
tracepoint that addresses both needs.
On the one hand, we don't need/want to duplicate the avc message
itself; we just need enough to be able to correlate them.
With respect to non-denials, SELinux auditallow statements can be used
to generate avc: granted messages that can be used to support coverage
tools although you can easily flood the logs that way.  One other
limitation of the other patch is that it doesn't support generating
trace information for denials silenced by dontaudit rules, which might
be challenging to debug especially on Android where you can't just run
semodule -DB to strip all dontaudits.
