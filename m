Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A44DC433E0
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5396B2084C
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 14:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmNXiD1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403858AbgE1O6t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46675 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403770AbgE1O6r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 10:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590677926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJNFvCcPAx3y5kopyXMqioJI0qhdhAGjngY8S5RyBZw=;
        b=FmNXiD1nNlU6cgI4y1QguFdyO735uHZzlynmSrm0sslTvCjEeb0jkA7ta1CatlAyQPsmao
        Kuorizk2ZbZpRs7SWoGLH91IGr+CQrOuhQHQiau0sE3yguaUe8WuwxK2cneHv1C683Fv36
        F0yJ5QgCUECh/dcIk1GzfaWv3n7G7PA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-llSKJXp4Nz-d96K3hkM2nA-1; Thu, 28 May 2020 10:58:43 -0400
X-MC-Unique: llSKJXp4Nz-d96K3hkM2nA-1
Received: by mail-pg1-f198.google.com with SMTP id m15so22318415pgl.15
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 07:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJNFvCcPAx3y5kopyXMqioJI0qhdhAGjngY8S5RyBZw=;
        b=J0G3c0+b/iKBibSfpPpzhhm3Y+Sz59Vwxj/srDHTd62FbD97/3WvdjtRPcvt2pnVRT
         lz1VT2QvxLdplcjJLuV8mbkP0jjgOQ1o/GAMbRRt8qbHTXCp924RFCvaRO0tVv2RtjbI
         BxhW8EwuQwKu2j3qZZjgtF5qUlOdlootBlmraodHX4g1ZoA9jacF8TCV8xMTTJtPrDPY
         XD9mYcSHgWYdPU8FV9enU3jJ0Ja877QO/FWLGm3wbshQ3bmbwyWJtRVVi/VXKm6JBCvp
         RVPqBekDswEODAO0BJSpvXobhD2mB2WCYZfJGi55x84cGfW9BzLvXV7JtidmGFM/Voiq
         nf3A==
X-Gm-Message-State: AOAM532mnbg/dFB4zS8ib1GO2UpdjcZU+Lrhaz4EWELfWTDTfbK8dSWH
        Z39AOi3a2VreroisgNe5d3ecDdCE53nF3BvWtZc9QcqJwhMjUcU53cGLolW6L5gHMA3sJQwHdy5
        Wvv8qlVk5OYLmgbn/urICjLZBXdDVFv+rog==
X-Received: by 2002:a17:90a:f3c4:: with SMTP id ha4mr2542845pjb.18.1590677922829;
        Thu, 28 May 2020 07:58:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiV4bj1axW9nIIn3ZDecwcX2ETIbW0cT5Yn8/Z2AgOP91SIEEIGyrkpcB8ykI5JmuLVG3Pj6q9EGAJ/aFRCWg=
X-Received: by 2002:a17:90a:f3c4:: with SMTP id ha4mr2542832pjb.18.1590677922624;
 Thu, 28 May 2020 07:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200527220653.188794-1-jlebon@redhat.com> <CAEjxPJ50MaQby45iKpxbJXVhKG=mcpRg9t0CjCxfQtNgQyr+Sw@mail.gmail.com>
In-Reply-To: <CAEjxPJ50MaQby45iKpxbJXVhKG=mcpRg9t0CjCxfQtNgQyr+Sw@mail.gmail.com>
From:   Jonathan Lebon <jlebon@redhat.com>
Date:   Thu, 28 May 2020 10:58:31 -0400
Message-ID: <CACpbjYqfOQmmpJuxx9jwN50pChj3hHmsidN1av0WdAg3wJfVBA@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow reading labels before policy is loaded
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 28, 2020 at 9:42 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> You might want to fix the comment style below, but otherwise,
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Fixed in v4!

Thank you and Ondrej for the reviews.

