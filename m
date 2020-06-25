Return-Path: <SRS0=GDzX=AG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C00CC433DF
	for <selinux@archiver.kernel.org>; Thu, 25 Jun 2020 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341C220789
	for <selinux@archiver.kernel.org>; Thu, 25 Jun 2020 17:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfURGTFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404740AbgFYRam (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404698AbgFYRal (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Jun 2020 13:30:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D53BC08C5C1
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2020 10:30:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d4so6032038otk.2
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2020 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvzhe11VKECITwUQ1Xlnc30c+o3QDKAmXI3wMhF+/zM=;
        b=AfURGTFnK6D7oQQIuAdLOKOP7Iw+be4Ld0IkbdkrfbkESmjCkCXm0ZTQt+2qAcPmK9
         GDt/Ak33OcWyZCNiwSUrUKwJk4IyXf/XMH+SeCJol7g13z+IFhrYG/bm48t6D/PvCSM8
         ia8bVR1Sz5EOcAf/tBhkWytpPMJrVsxFoAaDAtIwE+K0ahd0pcuZH3eFSmr2blqcjr1f
         5ZjZNBckRUwSdw/wudCzvxNDb8kYEUsWVHzuqpqkPrWKJ2idxksh6RxvaduF4wcX6SVi
         r6yPHG3HMLJ4Xj7IIypVKuGlZMrqtYplK5Uj28V2tCcRCPDvSVZi3Rh1zmwBnUpLLMVc
         qZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvzhe11VKECITwUQ1Xlnc30c+o3QDKAmXI3wMhF+/zM=;
        b=pXEqQCfd9A9mmSXRfrAi+xEj9HlKx5gaHScNZ051P+LeQGciFPo0Yl3EuTSBHeoZTa
         /GYN92TJphJkQ3+xb3cLU42EACvSYVCmV+FA5cx7Hnb6iiueriU0FYHSt555KkoCM9cd
         6xqM7zvaoOPdlMCTzlS6YnfW6t4nKhLIUFciinXtuGnx8QeoCoq0uqaJa2McsqJsamR8
         +HCLiqvvm5DuA3L30p/rBMFfirVwg1sYlwSvGUeYoXIMxRjmG1mlTA1yoaAbFElFZ7mA
         JcIMJsz/EfeBzO9+B9ZlYBovpqujNDlVJRgP3XZkVNK5BnsHYJ3nlccekFCFE4fXhJSN
         HbfA==
X-Gm-Message-State: AOAM530ToqQquddhOVSPHxpxV8qldSiX82wyT+Wiv7LYs2YM7Ws6JiDf
        rB/y9XS+S1T2Bb3qi8ylkVC218gpl5F+925Og+U=
X-Google-Smtp-Source: ABdhPJygO7aFdL4mUp8YfxWc1wMQGXVU+NkeCuWiDyC16R3zdkYviNCw4M8ty9ag+VdzuY8O6DbtaUcVpP1voBhhuZg=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr13972173oth.135.1593106240666;
 Thu, 25 Jun 2020 10:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200605081952.16278-1-toiwoton@gmail.com> <CAEjxPJ50YNJViUUA=7jaLwzPDMJUE0xzegAes4YF=TwpAo88YQ@mail.gmail.com>
 <CAEjxPJ6eevd1JOQN_8yC1SyQWoqPwkBvGJDu=ju+Dpku666KhQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6eevd1JOQN_8yC1SyQWoqPwkBvGJDu=ju+Dpku666KhQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 25 Jun 2020 13:30:29 -0400
Message-ID: <CAEjxPJ4Sk-DYg=cByfkcUOs+YvyQPSj8nh=3-DWJOQyfbMO+XQ@mail.gmail.com>
Subject: Re: [PATCH v2] semanage: handle getprotobyname() failure case
To:     Topi Miettinen <toiwoton@gmail.com>, linux-audit@redhat.com
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 22, 2020 at 8:22 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 8, 2020 at 12:18 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jun 5, 2020 at 4:24 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> > >
> > > At least on Debian, /etc/protocols, which is used by
> > > socket.getprotobyname() to resolve protocols to names, does not
> > > contain an entry for "ipv4". In that case, set the protocol number
> > > used by audit logs for "ipv4" to a fixed value. To ensure audit log
> > > compatibility, let's use the same numeric value as Fedora: 4, which is
> > > actually understood by kernel as IP over IP.
> > >
> > > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> >
> > This looks fine to me but adding linux-audit mailing list to see if
> > they have any concerns.  It appears to make no change to the audit
> > messages on Fedora.
>
> Seeing no objections from linux-audit,
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
