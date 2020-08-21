Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBE8C433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595102063A
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeDmOiCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHUPfo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgHUPfj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 11:35:39 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C36C061755;
        Fri, 21 Aug 2020 08:35:38 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id z10so426725ooi.10;
        Fri, 21 Aug 2020 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SvUQuk+rHgKISg+6rb+6W/mr4lYNsMnpLOa6G9AwJ1k=;
        b=VeDmOiCow0mnT8FwybNdZNdmwHM2Nu0d+jxGDzRFEBreEuwDNzBsHYMi3OGjADf/WL
         YjvK83iGfIihAMZU577sHMRfCZIHvObAEnmuAhL9UlEJDAPMFaWfko9cXASi+SrK+D1I
         THcCYYk007Lily9BKDaRpdZcPj1YhDyCEXZo0OJmgtA2FSeEt/G+5IPEDmK7mv/SyLvx
         SvqmzjPRMgslq1aPelOa36DYtxKO1Eq9coXEbMtEGZn2wj3Wxj4WIpNRsJPWlkSldgvE
         g+I0QKt8GmyTcCrjTaBUkVcrJRjPT9PiNsNL5gp1DdiQk5BApdo9V25Ik4FjNfhkB8UK
         tgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SvUQuk+rHgKISg+6rb+6W/mr4lYNsMnpLOa6G9AwJ1k=;
        b=MrrUxhn1+djYQUidM+JG7fJcFL5zNKWQ4hJd0xlLUTT8E16ACAytJkPm0HmzpZn98f
         /TpPlImRC4sctBeBJiZNY0dhnBslaDrejW1aSs+PQeLA5gDs7OvJdlpHByRNCJrgsEnX
         JY0uA73Hyw20Dfgw8YH99xWbNmWv+fSXphO3O5b0iRvemyNAy9vFjRwgAP4rEcxtjMa+
         7DcKnIhOoPtZu1JMo9qctnSdnPtCjG9DZ5DpmzCAMY8B5n1jRqnN6P44/Dq4xiRG+oIK
         HvBPuC3mE80si4Se0PGPwR7bCg2510E7f2Vyvtn/SRZuXN8yPtwUcSTzKxX4E5ztmNoA
         dF3w==
X-Gm-Message-State: AOAM531MhJCmrj0KitQp+hf+8g4dKm3VQXlZ7fvWPkjtrAOtT7k3uBso
        WVDpG24O9sBagAbSxlVktT80b//1WgQUb2P+OzU=
X-Google-Smtp-Source: ABdhPJyov7PitoQCwzWl7xrkZh9OAU4RlTH38R5BCXsvGrRreeAMvQAD9kuLnTlUJ8EEEvouO3cz6v1UEghxWwmN76g=
X-Received: by 2002:a4a:9f93:: with SMTP id z19mr2563687ool.58.1598024135515;
 Fri, 21 Aug 2020 08:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200821140836.3707282-1-tweek@google.com> <20200821140836.3707282-3-tweek@google.com>
In-Reply-To: <20200821140836.3707282-3-tweek@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Aug 2020 11:35:24 -0400
Message-ID: <CAEjxPJ7TP7mvKFDBfP51n8hNzdGFuME8YJ-yT1_VngDufajQKw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selinux: add basic filtering for audit trace events
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Fri, Aug 21, 2020 at 10:09 AM Thi=C3=A9baud Weksteen <tweek@google.com> =
wrote:
>
> From: Peter Enderborg <peter.enderborg@sony.com>
>
> This patch adds further attributes to the event. These attributes are
> helpful to understand the context of the message and can be used
> to filter the events.
>
> There are three common items. Source context, target context and tclass.
> There are also items from the outcome of operation performed.
>
> An event is similar to:
>            <...>-1309  [002] ....  6346.691689: selinux_audited:
>        requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
>        result=3D-13
>        scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
>        tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile
>
> With systems where many denials are occurring, it is useful to apply a
> filter. The filtering is a set of logic that is inserted with
> the filter file. Example:
>  echo "tclass=3D=3D\"file\" " > events/avc/selinux_audited/filter
>
> This adds that we only get tclass=3Dfile.
>
> The trace can also have extra properties. Adding the user stack
> can be done with
>    echo 1 > options/userstacktrace
>
> Now the output will be
>          runcon-1365  [003] ....  6960.955530: selinux_audited:
>      requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
>      result=3D-13
>      scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
>      tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile
>           runcon-1365  [003] ....  6960.955560: <user stack trace>
>  =3D>  <00007f325b4ce45b>
>  =3D>  <00005607093efa57>
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> Reviewed-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
