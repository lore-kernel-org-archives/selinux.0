Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B9C433EF
	for <selinux@archiver.kernel.org>; Wed, 22 Dec 2021 15:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhLVPko (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhLVPko (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Dec 2021 10:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640187644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Veglo43zqvGvy6aJUXRTMyUZbkyZg+ycQ7VyzgAjQ7g=;
        b=HuDHoC3eOjCqfcVMgv1SkBFtVznp/BxEckn105FmGmJ0qSJc8H+JQva4dL9qaXm8RO7lYZ
        Mo/b6ykT8yR4qHS0OnUcNLvXt8X0etxenUhei1uGfxBrr/4UEGJZ5D/M6KcbaG0gKw3aTH
        3EchP/2N3jUYquUaf3yupKrC175QxU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-QdYQ3ZIzMBSfFZxxEDECAQ-1; Wed, 22 Dec 2021 10:40:40 -0500
X-MC-Unique: QdYQ3ZIzMBSfFZxxEDECAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91F221018722;
        Wed, 22 Dec 2021 15:40:39 +0000 (UTC)
Received: from localhost (unknown [10.40.192.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23ABA1086483;
        Wed, 22 Dec 2021 15:40:38 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     evverx@gmail.com
Subject: Re: Granting myself access on oss-fuzz issue reports
In-Reply-To: <CAJ2a_DcbGirAaWFZFuk6z4SsbVpZSY8WfeCDJKkVPWpzE3f1WA@mail.gmail.com>
References: <CAJ2a_DcbGirAaWFZFuk6z4SsbVpZSY8WfeCDJKkVPWpzE3f1WA@mail.gmail.com>
Date:   Wed, 22 Dec 2021 16:40:38 +0100
Message-ID: <871r24ejgp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Hi,
>
> while working on the fuzzer for libsepol, regarding parsing binary
> policies[1], and its oss-fuzz integration Evgeny Vereshchagin
> suggested[2] adding my email address to the receiver list[3] of
> oss-fuzz issue reports.
> This would give me access to those issue reports, also to the secilc
> fuzzer ones, and enable myself to provide potential fixes.
> Would this be fine to you or do you prefer only maintainers having access?
>


While I'm not in the list, I think it makes sense to add your address
there, especially if it helps you with the work you do for this project.

Thanks!

Petr

>
> [1]: https://github.com/SELinuxProject/selinux/pull/316
> [2]: https://github.com/SELinuxProject/selinux/pull/316#issuecomment-9390=
14453
> [3]: https://github.com/google/oss-fuzz/blob/master/projects/selinux/proj=
ect.yaml

