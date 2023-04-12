Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775AFC77B6E
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 04:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDLE45 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 00:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLE44 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 00:56:56 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8647B8
        for <selinux@vger.kernel.org>; Tue, 11 Apr 2023 21:56:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j19so3283283qkk.8
        for <selinux@vger.kernel.org>; Tue, 11 Apr 2023 21:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681275412; x=1683867412;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tSHD7yZKPOCMazemaM4x/64aPdU7j+p7WdjKG0vRG8s=;
        b=Ubh6rO3kCA17HaggLZiqxd9PH+UYkJk9SH9LWNA6fkmnkw+0WkyO6TUQqJchpC/nqa
         dW1EFph2fAzbuCI5ErxbO7LerBO6RU/rZCis8z6nk8R7GdxnTOS2VymaGgZeP6JMzeZK
         iGfKZAi/2SqRZHuVT32reO3o/2KZduRLgsoEDM4UPOOWQWut+VeR4mTjdEFBQFIYOKSx
         blvp1A77WbaydBk28niOcmYWZ7NK4NWwJNWTvY/DT954gHqlsiLncY8hJDqqXc+6FXkO
         7wGrP9jyx5wNwu/XgR4IvpjtOOWol+9CPew+A6YrD6eHgCkZXvaVRopNXKo1ipxVQ3jr
         NWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681275412; x=1683867412;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSHD7yZKPOCMazemaM4x/64aPdU7j+p7WdjKG0vRG8s=;
        b=jCYlfubPpx4WcGcCkKRwmnDJursFxdJwnSjGDcCI/U1mRxhK6K3lpx2a0AgcXe+dBl
         wtU/97PjZuAX2ial5uD+ckF/4Rs1Yb5Oc87coZuFx+hsQKRzPKj924k6ofN/5TiEsres
         cDQb85dkGfO3f7YuKvu/rpNn5gL9RgKcZ080uxen0svy+jvPyp/gVSbaJFzbkyurjs3h
         Q4EGRhvg8HzEXIEGj1yRHfxmdVelsFF4nO6SRSPMYltt1xo+j9KxZqFVfpfltIQA8bLT
         S/m7pbD75z5rW2bq/i75V0/2PLe/PgZPdPzYj5RIwhAqaobrC0RVNAnKAB/ClxscjTYP
         afsw==
X-Gm-Message-State: AAQBX9dze2wt4hueILXAco/V7Jf7x+IbB+G0y8Pl5BqCdt0DzObzX9pn
        J1OOKJYrsaSVy3RiCuHJpqOGAczRi1quiVep/y+u2zR9FW4=
X-Google-Smtp-Source: AKy350ZcE9Q+I56WAkxDFQUg75dTOiqLJ+Dts3e99Hn3Ol1JrxSmltPYyzPta56X01+f5TWi7333XO0hKp//CF6WwHU=
X-Received: by 2002:a05:620a:3184:b0:74a:27b5:52c6 with SMTP id
 bi4-20020a05620a318400b0074a27b552c6mr5664628qkb.4.1681275411796; Tue, 11 Apr
 2023 21:56:51 -0700 (PDT)
MIME-Version: 1.0
From:   Etienne Champetier <champetier.etienne@gmail.com>
Date:   Wed, 12 Apr 2023 00:56:15 -0400
Message-ID: <CAOdf3gqCNHoFT_U8cDTy2v8oB-UKmzJn-hyai8Cn9=Zk7uuTsw@mail.gmail.com>
Subject: portcon tcp 80 change type
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

Is there a way to ship a cil module changing the type of port 80 ?

ie something like
> (portcon tcp 80 (system_u object_r websm_port_t ((s0)(s0))))

When I try to install such module I get an error, I guess because port
80 is already defined
> Problems processing portcon rules
> Failed post db handling
> semodule:  Failed!

Best
Etienne
