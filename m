Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0E4C433DF
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 16:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A99A2078D
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 16:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3FbgUmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHNQwm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNQwl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Aug 2020 12:52:41 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD5C061384;
        Fri, 14 Aug 2020 09:52:41 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v21so8055444otj.9;
        Fri, 14 Aug 2020 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=56wQBXZ4Y9r+7Y1AbkehmPLpcOw7Q3KsYOh0M2y8Xio=;
        b=B3FbgUmBSQzCjVwN01d1eKqn5O2qSScVgHaUAbUo8JHcP8sANRiF4MnE85LVFTfij+
         kfU5DwO/lvmBDticXz32C+lPZyCKJFWAqtOeIho4jubcMyD3d+54tQx6bRcfZe0/syb/
         nJ0x7I1GhbHhKZ5cKwkGLE20gjZzTg3QlOwZCHIMZ/iRo5oAouTWJq4mh0z76zjEJmMm
         yBBiMhKa+IR2L3ExLio/4Sr+awwTH2GjZcFxmioydUDm1D8k5uRXce0eUOFMP1h1Kmwa
         Cq80k8nKyfoW1Db4CiSGDY1cKFp9qjveM+wK+q8OgrMgubmVoXkF/TS4DlzMNkZtHiIV
         tIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=56wQBXZ4Y9r+7Y1AbkehmPLpcOw7Q3KsYOh0M2y8Xio=;
        b=M8miqmZOxJYqRbfUpDzFtgMOuxq91w0NmrCjIVhWUevYZ5zF81l2LQlja5LFnPb7rI
         eKZGE8zH57joNa8pqsIOq+hBhREgVv6yGec2AfKAUaJuPsJKFVvKyNWHIiE+9+KQT5gZ
         2PK5fFQzt6/mmchaxJDXKNplmw2nI7emME7tJWcgUBaYWjg2+uHbl5tTP4JLIUMQHj2K
         E1TXXqNY07gOudweXBAOJt2WYFDui0FmYVzREIOzhCNaRHA6Y4E7A5cybwBui0hswYde
         zEYLjHJFXSVaRANpHqSAz4/N/uQELhl8U6a78pG8xs+HRftZu5am181DpYaeekutImRU
         qIig==
X-Gm-Message-State: AOAM531YCem5sRKmDW6XGHPNWWlsP13D8HiADFJP8smZAEf1ZVjt+Wzb
        T4UOEO0LajaNUjYeZjDFjNvcAUmq8qpr2t86jzg=
X-Google-Smtp-Source: ABdhPJz9rxsA7DVxKEwdWtU7rb3uywg36S1LiNDNJwcRMmMj4FExe6Bi1kJ6URn6XNJjcimX8KisS9d3K//G16m4qew=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr2426501otr.89.1597423960353;
 Fri, 14 Aug 2020 09:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200813144914.737306-1-tweek@google.com> <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
 <CA+zpnLcf94HGmE=CGH6nT8ya0oax5orXc5nP1qToUgaca6FeQg@mail.gmail.com>
In-Reply-To: <CA+zpnLcf94HGmE=CGH6nT8ya0oax5orXc5nP1qToUgaca6FeQg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 14 Aug 2020 12:51:05 -0400
Message-ID: <CAEjxPJ50vrauP7dd-ek15vwnMN1kvAyvYSc0fhR4xwCJEQSFxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 14, 2020 at 9:05 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>
> On Thu, Aug 13, 2020 at 5:41 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > An explanation here of how one might go about decoding audited and
> > tclass would be helpful to users (even better would be a script to do i=
t
> > for them).  Again, I know how to do that but not everyone using
> > perf/ftrace will.
>
> What about something along those lines:
>
> The tclass value can be mapped to a class by searching
> security/selinux/flask.h. The audited value is a bit field of the
> permissions described in security/selinux/av_permissions.h for the
> corresponding class.

Sure, I guess that works.  Would be nice if we just included the class
and permission name(s) in the event itself but I guess you viewed that
as too heavyweight?
