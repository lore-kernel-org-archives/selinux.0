Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC2C433DF
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 14:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2AB2074B
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 14:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=collaborative.li header.i=@collaborative.li header.b="nZXyc/VF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgFIOFO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:05:14 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:61824 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbgFIOFM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 9 Jun 2020 10:05:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 708796F4;
        Tue,  9 Jun 2020 16:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        collaborative.li; h=content-transfer-encoding:content-language
        :content-type:content-type:in-reply-to:mime-version:date:date
        :message-id:from:from:references:subject:subject:received
        :received:received; s=dkim20160331; t=1591711509; x=1593525910;
         bh=aMrWcOoj3tVO37LInRpf6nQJUicnTJaRAU64pSsW/JA=; b=nZXyc/VFia9U
        X7vwe9HHn+Gn2xIlefHWrqe4PEbVOrZUp7t+cFHz0AJu5jQ8NUk72C6nm34EteIn
        o0tNYZQyMIPukNgx0eNhNdJgsTxUeq2YamePjkUdpfgOmRHD7FFJIyinzFRL5Goo
        4JeSEQQJrlzcwyECV78DYGXvwact86lq6QsR6C7+2YBAydaq/fLlbqY/RLcJ7esF
        gLYevQGPeWoBVRM2SqQfvcuP+cI0DgmL3NxQfJqYuKpR04K3qk/PEoAVJr6MFtyh
        WCnj4tB1kBeoYGoya2NgDJZ4Be27/4UV+noz0j7IxLO4s02aQp0iczwAlgBogpQK
        eM3w3iqqZfFrC3auUs/rOefuFJ5g6xZyNXxAf3MAPB0SE4Y6PC7H9OdiXZ7pdbfE
        hCIdEHxf5UBJXhAe4joL+V5FtnSyepCVJ092O8jofdjmGGFJZHnqKWxGdnMUpXTv
        JxmLe6d/ZCU13TVQU8FPFVBz2/kYr8q5ev/o6d7bGnD/re32rxU1yGmuDGEWqWJV
        2pW/I6/7nn8daxLmfgEOL7kO5lkY7VKSyRZfiPu7abL8UEG8T0wa4IwHdCeILwmb
        PLJRgvLLbzFbkXKupUOCxXr9KHdLRSdmiOpz4/DcQKrP5c4++IyCiobOm49/XVUQ
        H0gdGfgYoiG9CcH0w62XuFOkI1z017A=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tyrZcGTH2SUK; Tue,  9 Jun 2020 16:05:09 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id DB59245E;
        Tue,  9 Jun 2020 16:05:08 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 8176D25BD;
        Tue,  9 Jun 2020 16:05:08 +0200 (CEST)
Subject: Re: No window opening when running sandbox -S
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <7b738730-bbc3-eb04-b8b8-63706cebce24@collaborative.li>
 <CAEjxPJ4Rw-B00FWjpTL3dWLwJ8daqy6NH_7su-EtAXYky8caQA@mail.gmail.com>
From:   Cristian Ariza <cariza@collaborative.li>
Message-ID: <e99ea6cf-8970-057a-4dad-1d9c5d973ba1@collaborative.li>
Date:   Tue, 9 Jun 2020 15:05:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4Rw-B00FWjpTL3dWLwJ8daqy6NH_7su-EtAXYky8caQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 09/06/2020 14:02, Stephen Smalley wrote:
> You are using sandbox as packaged by Fedora in
> policycoreutils-sandbox?  If so, please file a bug against their
> package.

Just tested the version on the selinux repo and works. Will report to 
Fedora. Thanks.

> To be honest, I don't use sandbox myself and I am not sure it is being
> very well maintained these days.  It was originally created by Red
> Hat.
> It seems like it has been OBE by other efforts to sandbox apps on
> Linux e.g. flatpak or snaps although I don't know that any of those
> are leveraging SELinux.  I'd be tempted to remove it upstream unless
> it is getting proper care and feeding.

I have been fiddling with a few alternatives for sandboxing apps but I 
haven't really found anything that comes close. Probably the best I've 
seen is firejail and its defaults are not too good (too permissive IMO). 
It's a shame if it's not being maintained.

