Return-Path: <SRS0=dH2y=DG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7E3C4727F
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149D72076A
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F728FBki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbgI2Mio (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbgI2Min (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Sep 2020 08:38:43 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C4C061755
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 05:38:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so4224556ota.10
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g62ZRdxj/aSBie+fSODNpWJSMxyu9J2lxcKHGgrjMDE=;
        b=F728FBkil/lWy6m6fBGgdkeVztFHSE6wsXCriF3wXME99mL2M0LVOEmfUqfX1ptO2H
         G4LAFANWtXSuc0CsVcWj74iDQarpzWbuErTzEm4mO9awthlPfgG0Dhazb7WWxdgVLD4m
         rjm+ZgsAqqeI0VTJbE+idmzxBo+cInq9LBavfZ4UsiqTQuW0hESAsLMCEe6kI2AwQdW2
         qJTY4M9/6RnbM+CtsIuY/ms6XShDWeaibHLYaw8zFDFl6NTEfqPQauQAH9CdAJowpsgG
         Pb+ITGJPCa6y7kDs6KSSEMQJFayZr2q4dya9cSnkRZ4cY6Kvj6ipPi3AuwR8ObmrlPkh
         gXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g62ZRdxj/aSBie+fSODNpWJSMxyu9J2lxcKHGgrjMDE=;
        b=ehDroP4CDuNczwLSDUEeV4ocjmpcVADQksmnBpKh4E1iF72Lha+aLR4Dx5ENk/mXFR
         fi59F0sFKJg5dXy7kqGM234YtP7/xxrWrKhevd045nTpLWvOZDZ/UvH9d+q8c2u6mN4f
         /5F80buMcuDosuDS9WC+oPpYy2iC2QUd1QWrwLqIqbJXDeIBiAld5K2u667nsY8buYeB
         KsuSBxtkifeSECJEJQNMqk7zynBQ9kFsH9sklGGCNdSXQX6ord4Rg7W/W9v3m2vxjd8v
         vb4hsuMBt8L0SBrRa2wWDtESSsiIJ4xq1JkKIymrGcKWZNUXDIMe9vysVPKgoOTDik/9
         9Q1w==
X-Gm-Message-State: AOAM530pRDgh2rn6Q1WK8oN7MdN+fNOXG1d3VdzrIUtO7oJfG0k45pK4
        3fssQD2OzLxozOi2F5fyiZtZlMrKEEyjMEv145M36d7H
X-Google-Smtp-Source: ABdhPJxWPmEkzolb3necQHgOal3YrJSRxEA0fnRCnPWcr10PVMk0Y98Emgo56OsCTqon9KSN3fliGRQ45WnIO816wj0=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr2642751otb.162.1601383122680;
 Tue, 29 Sep 2020 05:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200927094243.43673-1-rentianyue@tj.kylinos.cn>
 <CAHC9VhSKDtp_YoNf=AopcxF19bp=WZsx7hR1rRb6gVPaUTeuRg@mail.gmail.com>
 <CAEjxPJ4Oa59q=LvdZhrjpGL3zQv7-qJthJQaSt=GQnE35MjA5w@mail.gmail.com> <tencent_489983C034412A8A6D8DF21D@qq.com>
In-Reply-To: <tencent_489983C034412A8A6D8DF21D@qq.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 29 Sep 2020 08:38:31 -0400
Message-ID: <CAEjxPJ5deRnC_rJ9M=dHLB=QtskmV+H-Xz_-Y7Qrq+iXcW4fmQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     =?UTF-8?B?5Lu75aSp5oKm?= <rentianyue@tj.kylinos.cn>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        yangzhao <yangzhao@kylinos.cn>,
        SElinux list <selinux@vger.kernel.org>,
        Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 28, 2020 at 11:06 PM =E4=BB=BB=E5=A4=A9=E6=82=A6 <rentianyue@tj=
.kylinos.cn> wrote:
>
> Sorry, the previous emails sent failed for "connect to sec-jeemsg.eemsg.m=
ail.mil[156.112.250.13]: Connection timed out (port 25)".
> The attchment is the previous emails.

1) Use this gmail address for me, not the tycho.nsa.gov one; always
look at the latest MAINTAINERS file in the current kernel for contact
info.
2) Don't send html email to the lists; the list server will drop it
(which is why it never reached the lists).  Make sure you are sending
plaintext emails and use git-send-email to send your patches directly.
