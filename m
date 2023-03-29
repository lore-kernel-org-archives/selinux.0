Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60355C6FD18
	for <selinux@archiver.kernel.org>; Wed, 29 Mar 2023 14:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjC2O2R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Mar 2023 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjC2O17 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Mar 2023 10:27:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F1A5C7
        for <selinux@vger.kernel.org>; Wed, 29 Mar 2023 07:21:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r187so19498712ybr.6
        for <selinux@vger.kernel.org>; Wed, 29 Mar 2023 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680099565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4/N2vrJxKSPGNOo4Sdxe+Hpfi1jERAyjrq6Q8qDfAk=;
        b=E+Xv3lvbzYSO6w0sxubf8tFqaPhuhL0DT/DtwdsUELKN0hN/L0LFwwN91nkb4xMgGE
         QWrSyk2SZJ0638qc+KCN26yHQaipDrBAA9Dc01zPYIV3sY/5juz+8QCRNNiM+sHS3qGp
         t/h+yPhXPjqZhPcpbGWbgMXRsFhl3EkQHCp5AK0WeewpRa81XEzgjRZSDBAmUsIjlzZl
         1NqGnRfyuzMWzQCsBnnFrwsxJTp9kDPZq1TjvjicFGh0ZucARB5wt/SEZzQxLI8pBtGt
         fKkPXeB83uxyRCoMdKUOF3vcF0E2iVY9nPolxBp7M4x5QpjSyTSBbuPh8tUwAE6srx3m
         AO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680099565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4/N2vrJxKSPGNOo4Sdxe+Hpfi1jERAyjrq6Q8qDfAk=;
        b=NkA1KiUhD2bvl0X/YcarJDaw44JQBKmXkewdoHEkyhOJecSpIBOaWju3roAwJmM/et
         suOJGJoBav/cPCUh18t/3/zziudp1wfr1sadEqNgPopTJAhNpqpJIr6r1XvqF9TgbPuK
         txJAoJw2+qS1Wn3WDesknMFDJv73j4tK4d0YKleQjKjSUmYv9SNxmpJLfZmmV1gH4n60
         kyMV2KRl8y/Hha04u4sz5O2TeSYBQ0VgYYZO+iyklv6pF2gX/6BI/lqxWQY+3DGUxE0m
         3K8n3V9OOALE6fo9amndchbDIS9f1gkPzo6T+qt8PvGeyThZS7Y9ukCKvonH4cX/UJuV
         kbGA==
X-Gm-Message-State: AAQBX9daG6z53Qbg2muSlgvGY0cnFCC97jWOXdGGTMXH6Kr+RTA2Ej9s
        T6vXYa+c/RuY9+0UkNsNEHmP21ZWjjhl4hd3zCXr
X-Google-Smtp-Source: AKy350ZXG/6vdtiRwb14rFlkSfYbi/rQ7HyN95sz22NFfzMEzzIVcrSq4Yj28sNoDp2O5+duQn4747E2fbAWADJ+YJg=
X-Received: by 2002:a05:6902:18c2:b0:b78:5662:d5bb with SMTP id
 ck2-20020a05690218c200b00b785662d5bbmr9370969ybb.3.1680099565020; Wed, 29 Mar
 2023 07:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de> <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
 <57a97109-7a67-245b-8072-54aec3b5021d@web.de> <CAHC9VhR=yK72JXW3hJR+gUQtGCNpF0Bzk5RDzPZR0MunC84AUQ@mail.gmail.com>
 <CAHC9VhREfdgiCji=uEeCrc4w1kPGfnWGKnJuUYKXwTApdneSjQ@mail.gmail.com>
 <9e8bb69f-99e8-f204-6435-cc6e52816ebf@web.de> <CAHC9VhQfiNd_4uWBmKCC81UnOJb7Y=UFCDMXuqz3=UPr8QtqNw@mail.gmail.com>
 <382bc6d8-7f75-822a-6c36-088b1d2f427a@web.de>
In-Reply-To: <382bc6d8-7f75-822a-6c36-088b1d2f427a@web.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 10:19:14 -0400
Message-ID: <CAHC9VhRxjJ3WMNc=vwkLKGDjSN8G=P9ykMkYg9dAJs3SaxVYYA@mail.gmail.com>
Subject: Re: selinux: Adjust implementation of security_get_bools()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Eric Paris <eparis@parisplace.org>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Ruiqi Gong <gongruiqi1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>,
        Ruiqi Gong <ruiqi.gong@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 29, 2023 at 1:20=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> >> Would you like to take advice from another information source
> >> better into account?
> >
> > In this case, I prefer what I suggested.
>
> What does hinder you to work with more jump labels for improved exception=
 handling?

I'm the one who has the responsibility to fix bugs in the code when no
one else has the time or the desire, I'm also the one who shepherds
these changes up to Linus and argues for contentious changes which are
not popular outside the Linux Kernel security community.  Having to do
this with patches that I find bothersome hinders me in ways which are
sometimes difficult to explain, but easy to understand if you've ever
been responsible for maintaining a significant code base.

--=20
paul-moore.com
