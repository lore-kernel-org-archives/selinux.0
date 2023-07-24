Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7361FC00528
	for <selinux@archiver.kernel.org>; Mon, 24 Jul 2023 16:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGXQ3h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGXQ3Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jul 2023 12:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0C122
        for <selinux@vger.kernel.org>; Mon, 24 Jul 2023 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690216120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPc6LfzoRjjMU729bz7XR4bzpQ4gehtU1LQqpTZbFIM=;
        b=D3ZvozONozRktpav431xSgK2J+6EnN0+NY3JhoGAyUm4NFUfwEfbLhDeq/Y1sZASY3eDXt
        br04+R42W2d7sclDXR2RpPMJDU6JZphIzHGDdg7Q4JNSa+drxUkvz1keSp8TM/grQ3+oH3
        sZkFQrzYgUvIENAOVmnjKwmuQtjoDiU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-aUfIyVIWO9yABZhFL3nw9w-1; Mon, 24 Jul 2023 12:28:39 -0400
X-MC-Unique: aUfIyVIWO9yABZhFL3nw9w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40559875dd1so4869961cf.1
        for <selinux@vger.kernel.org>; Mon, 24 Jul 2023 09:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216118; x=1690820918;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPc6LfzoRjjMU729bz7XR4bzpQ4gehtU1LQqpTZbFIM=;
        b=I6VXjc7IQb0uQdkC7loFhyTuE7x0fVhkbtObrv3B4qZeqeh5xL67bZPFPVEe0yldNq
         Ao3RFCuDqEMFQVBxHMg7fo58G18Fe8mdcui8WniFegqrIO6J76zPGsfoRfif4l5yY7Rb
         HjhcwltMqip2dC9HbVqAwPOftd+UOO2omtmarHV60fPHvOQDDHyAWzVN8OCAEplw0PLj
         4WEl/3CO+Yu1IeWicdJB4zGGfLfz3aY1ydexIJm3IoZI2f3UeSgT6ehFNVc0whf2qFqK
         WkZDEL/PozT9ovY3IBGzvMExaKqLCJ8WMikakcRXAdrulkhRIHZiWM/FaGVksf/MNM0C
         3/Gg==
X-Gm-Message-State: ABy/qLaKaTm572Vyj9FR3OlWZnfWttSUCdBgJvEC6mqdt/NE3pI8o2GX
        yVZeCtxsLdAauTW4f/xSq8qlz40bUEJDZ+CDtNFuyUcpyvqq+UJebQByP6Ov4pvGmpiYSgMbfOK
        GX82/IgexLVE5zQXdYA==
X-Received: by 2002:a05:622a:1b9f:b0:400:a9a4:8517 with SMTP id bp31-20020a05622a1b9f00b00400a9a48517mr12402955qtb.4.1690216118770;
        Mon, 24 Jul 2023 09:28:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYe2r1e44ymBAW9LBiJ+Iz0wbFf4q2jQ3Fp4Qsce6fbppjpC0MEicv/dPVwjkV1zWzRFj2Rg==
X-Received: by 2002:a05:622a:1b9f:b0:400:a9a4:8517 with SMTP id bp31-20020a05622a1b9f00b00400a9a48517mr12402937qtb.4.1690216118483;
        Mon, 24 Jul 2023 09:28:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id e6-20020ac84b46000000b004052f71f79bsm3409071qts.74.2023.07.24.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:28:38 -0700 (PDT)
Message-ID: <7b11a20a9ea302d1e719ce7e65b668ce2a3c8c63.camel@redhat.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org
Date:   Mon, 24 Jul 2023 18:28:35 +0200
In-Reply-To: <CAHC9VhTRkWL_R0xdnrYChwmbp3FvXKMjQYpdBn9OvCH23mW=bA@mail.gmail.com>
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
         <679840421f2e7794bb69962b97e0cee1a4e0f0f6.camel@redhat.com>
         <CAHC9VhTRkWL_R0xdnrYChwmbp3FvXKMjQYpdBn9OvCH23mW=bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On Fri, 2023-07-21 at 12:11 -0400, Paul Moore wrote:
> There have been updated patchsets posted, but the original link
> (below) contains my comments:
> https://lore.kernel.org/linux-security-module/20230119231033.1307221-1-kp=
singh@kernel.org/

Thanks for the reference. Interestingly there are both similarities and
differences between my approach and the above. I'll try to study the
above a little bit more and then possibly I'll share what I have, just
for reference.

Cheers,

Paolo

