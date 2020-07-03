Return-Path: <SRS0=unIV=AO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E7C433DF
	for <selinux@archiver.kernel.org>; Fri,  3 Jul 2020 13:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C2A2084C
	for <selinux@archiver.kernel.org>; Fri,  3 Jul 2020 13:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="On+rYWUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCNtO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCNtN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Jul 2020 09:49:13 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88DC08C5C1
        for <selinux@vger.kernel.org>; Fri,  3 Jul 2020 06:49:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so27586078edm.4
        for <selinux@vger.kernel.org>; Fri, 03 Jul 2020 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzNntGK3i6IXaj2mCIg0cVuNvS1gTOvJG7BWIlnDj0A=;
        b=On+rYWUswjmZH0fovuVYaulQjuZPSej8E6E0rVatp7KjhM3iuNds44TlAkXMfrFVoQ
         qucKzRX/rdbTZW7AmrJGwnB1bFLsLLQpTf90cNg+YCCTQylrvByC1vXODDknxiOI8wss
         ZqopNFL+Lj9dypkM3n4+tFX0gyNZ5EQU1XzBXRgxQY1/YoBaiZK+wEjiFNFq8R0hOHe1
         PyE/Yu1OXaqia2WJEJiAUH4z3u9Ldc2uFdzuaEilQz9qybQoSOgWQ5F0NwSem5hvL00l
         1w+hhRUmYF1mpq3fvord/7u7Woth6S08+lQK/8yiOVQdVEBlP9yRcFM81/UpVkk34uCT
         9/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzNntGK3i6IXaj2mCIg0cVuNvS1gTOvJG7BWIlnDj0A=;
        b=kTdeI1F7Cvgr62wIHvbzYeBkYqCijpJgUByPjgKwAIWakm5g31pfsaVrarCffvVVau
         XlYDZrzhTP6fTm6kYSQjC0yONvNvwCNEYKCbJ568WYE2S1NzrgR2I5dMjW7fQT7zoZGy
         9pO0IVTGeLtAjrYsvemRXZw5/D5C2bHB6ng3QKrucHgpKG0e9KDnhUPV/Nly/C1040oa
         +Fjh+hf+dsgspJCy8IvSR7peQFGv2eC1ONN5TrVrmqQs6E6Q8OoMY7Sw/EVl7eiKWXdY
         NjZtkJuBCIjS2UQ0/FXUJRBpSG6HwMvNr3ldxg+r3HaLuqpmhL/apF/WYowGxgmIDeal
         MWQQ==
X-Gm-Message-State: AOAM531HknzL5qCCPwx+OdUTEYiufWiCyBq/GUJve+zmtfE5fN5cJAAJ
        o3bpv0PISQo5VVxMP/o6PwqWYXzKqSFkMCsZ02QiQp8=
X-Google-Smtp-Source: ABdhPJyI+3tPHd4FiGRpW7BOykEtPVErpAH8urAaGsypbHsGRtQxdyWlgohnlBwHBpTzEUF8gNeT5v0RmSCPV09ihXI=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr38837570edw.196.1593784152085;
 Fri, 03 Jul 2020 06:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <35be1a17-1b72-fca7-55b2-b3f32b4e13aa@gmail.com>
In-Reply-To: <35be1a17-1b72-fca7-55b2-b3f32b4e13aa@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Jul 2020 09:49:01 -0400
Message-ID: <CAHC9VhSjso7KxFjUYPDZWKzo8ukLjSSg4WZ2nkCyOSA8hdBGNA@mail.gmail.com>
Subject: Re: Strange AVC denials without effect
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 3, 2020 at 6:28 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Hello,
>
> I renamed SELinux packet types and also without using type attributes
> (like packet_type etc), so that refpolicy TE rules for packets should
> not apply. Then I added new rules for the new types one by one as they
> were needed. But there are lots of audit entries which would seem to
> indicate that kernel_t is prevented from sending packets:
>
> type=AVC msg=audit(1593770235.180:3222): avc:  denied  { send } for
> pid=408 comm="irq/30-iwlwifi" saddr=10.0.0.3 daddr=1.1.1.1 netif=wlan0
> scontext=system_u:system_r:kernel_t:s0
> tcontext=system_u:object_r:my_dns_client_packet_t:s0 tclass=packet
> permissive=0
>
> In reality, the packets are sent. But kernel_t is not permissive and
> there should not be any rules which would allow the action, so shouldn't
> this prevent packet transmission?

Hmm, that is interesting.  Are you 100% certain that the packets which
are the source of this AVC denial are the ones being sent over the
wire(less)?  Based on the permission, this is coming from the SELinux
postroute hooks which simply return a DROP to the netfilter code, so
if the packet is really getting sent it might be a case where the
kernel is ignoring the netfilter hooks ... and that seems fairly
unlikely to me.

What kernel are you using?

-- 
paul moore
www.paul-moore.com
