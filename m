Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81793C433DF
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 18:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58281207E8
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 18:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV1qbvxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgFRS0E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:26:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728979AbgFRS0D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 14:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592504762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2fFQx3L9rZs8hY17nBMtuwwUrsYmZ68rI3haxNajqts=;
        b=CV1qbvxgw9jlEoPVYXf9GcQeSfPswjzXa2sRSqlFYnOCidNQd6vf8QzAnnAMFNDROq/iCw
        rWamUwBxPte3pCgZInQS+LXC0Eplp2VeDGng4sxsbdmbyik7azFFKXlb1cMDQDALxm1mXZ
        5a8Ngc6f7mQ6xGlBHtud+jY9qAhDMlA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-JJbuXv-MMcGKlPKIAt2faA-1; Thu, 18 Jun 2020 14:26:00 -0400
X-MC-Unique: JJbuXv-MMcGKlPKIAt2faA-1
Received: by mail-vs1-f72.google.com with SMTP id k13so987463vso.16
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2020 11:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fFQx3L9rZs8hY17nBMtuwwUrsYmZ68rI3haxNajqts=;
        b=BuvbCDSs0i9Sr2KpU8Di+riJWElXC1Y50V53phdOR9wOQVMdp/pIC+pE+qVeDP9KfO
         JAzCm92MQ97pcCvjC6xV3Qehz323Ek7fnY3xWcdCLT5tLjrzK+kI08ilLtXnVJBhvfYj
         UonAcVOBxwd+9w6XII2RgPibi8VKq0D/9dUxK0JBt2TxPJ8boiDeFZVsm621EVUrCa2Q
         6WocsJF0zry0kSEvuChnK0WNYARq2tuA5EIdip2wLEeGGBAt5GvWAU9CMqcvaCBaZCl+
         6Quzp1BYJXJK6rTm1ve8/TdSN0mqb688J1jUCXbReTC3GpLMIpbYjjGiw92vaSEwxmZ3
         vWfg==
X-Gm-Message-State: AOAM533+OajjgTAtaYBXeEDUpTlAX/jurXKir+6deY4ie3yqPuEckdbs
        J1cXsRQlXTgciWUHN6DszKWN7b3FkObS5ssZlluZyUHN/jSsfW/xY9zUdzixemh7kmUfHsYimkY
        /eqjq1fww5q3aSRRChds4qHKamfbxHPSDGA==
X-Received: by 2002:ab0:408:: with SMTP id 8mr4301544uav.53.1592504759968;
        Thu, 18 Jun 2020 11:25:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzndqkxZ0r2tEpmrIHlL1KTIWcdi2YPnwqjb0izkHIDW/iL35ZqAo+0tphM+YXBdB04N0V6A7oIaP5Wp6ZOfak=
X-Received: by 2002:ab0:408:: with SMTP id 8mr4301534uav.53.1592504759793;
 Thu, 18 Jun 2020 11:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200604191240.263819-1-jlebon@redhat.com> <CAEjxPJ5ih8oJFxMe3K3GGyN0FO3VLnWNEv_YibSWX3a-eDbroA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ih8oJFxMe3K3GGyN0FO3VLnWNEv_YibSWX3a-eDbroA@mail.gmail.com>
From:   Jonathan Lebon <jlebon@redhat.com>
Date:   Thu, 18 Jun 2020 14:25:48 -0400
Message-ID: <CACpbjYp35ifjkMU+dJusnep4ayoQAJd5OkD7J9t=RtA_v4iS8w@mail.gmail.com>
Subject: Re: [PATCH] setfiles: clarify documented path resolution behaviour
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 11:19 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Missing Signed-off-by line.  Otherwise I guess it is an improvement
> although I think it is still somewhat unclear.
> Maybe we should explicitly say that they are canonicalized via
> realpath(3) in the man page.

Thanks, I spelled it out even more in v2.

