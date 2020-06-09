Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87730C433DF
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 16:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1494820774
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 16:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=collaborative.li header.i=@collaborative.li header.b="K0bX578m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgFIQFy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:05:54 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:65318 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgFIQFw (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 9 Jun 2020 12:05:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 3BCE47D0;
        Tue,  9 Jun 2020 18:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        collaborative.li; h=content-transfer-encoding:content-language
        :content-type:content-type:in-reply-to:mime-version:date:date
        :message-id:from:from:references:subject:subject:received
        :received:received; s=dkim20160331; t=1591718749; x=1593533150;
         bh=ESjIGnNZHqKPyOGmgC6B4sje9uR9aKGitb5hoOKtpqA=; b=K0bX578mq7fY
        3ui7Z2rEJa5Lb/Ai9TW+a+Z8rcGZllThAGLy+xExavWrrUMqvfRTYSRpErj/fQGW
        T4rkt1ge38T+Us8rD+cdnLQ0O0xRp7LAUzo/xoqY25HcZBHQt0WK7huFrgZXBKf1
        2QBhZC8pp0luJ40Blzb8dvgRjOKRUzbWpVc4xVfyds5CURN0PqshEbCMK8blpP9e
        WMIlxYm3cL0In8OU+n+TYYXQWLZW+epMhyDuVDWyMevZfZ8JX8v64tkBRuzQ9Cu7
        cTYuetdcinSQ/lkuqUoBbj78JTLBK7DovOCYZi1qFC2J8j+kEIWo2B/+tyfWQ1eL
        rE/+H8MX7D6dz9H/bq5S0Kd+wwO+dw3p/OIt22HM2awx7Gya2nFa+4RxrwWdYV+g
        BudRTHZpNda+6JmGEFRVTKaHtN7nAv9XRrXWv+oDUq+igWptu1MhW4LxwUioGH+G
        kvFy/XT6t0Fv5bk2Be9AmTWyb44rmqNA4Xe8wi40yJRfKfHD8fQKshHMOLLTmejL
        icVf4nZxEL0qlLdeJRX0egA86esZPiRmgdMDJ363XYt0juH2tKOtcNkYqlkMgng0
        P3b27tcQ2dQkxpt4eeHwoE+87RBZWdCYgbiX47pw9XgDPH+Yfe1ARbb6l28li6j7
        fq4596PT7deZy78SguQM2IYHZ1psT1U=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uKk2aCJLrNpL; Tue,  9 Jun 2020 18:05:49 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 79499358;
        Tue,  9 Jun 2020 18:05:42 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 68B52AEF;
        Tue,  9 Jun 2020 18:05:41 +0200 (CEST)
Subject: Re: No window opening when running sandbox -S
To:     Topi Miettinen <toiwoton@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <7b738730-bbc3-eb04-b8b8-63706cebce24@collaborative.li>
 <CAEjxPJ4Rw-B00FWjpTL3dWLwJ8daqy6NH_7su-EtAXYky8caQA@mail.gmail.com>
 <e99ea6cf-8970-057a-4dad-1d9c5d973ba1@collaborative.li>
 <61832df5-4aba-dacd-644b-b8e8eead0fe9@gmail.com>
From:   Cristian Ariza <cariza@collaborative.li>
Message-ID: <3e5daa46-b775-4cdf-05a6-3339852d62cc@collaborative.li>
Date:   Tue, 9 Jun 2020 17:05:39 +0100
MIME-Version: 1.0
In-Reply-To: <61832df5-4aba-dacd-644b-b8e8eead0fe9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 09/06/2020 16:04, Topi Miettinen wrote:
> Please report Firejail issues on Github so they may get attention. 
> Current (unreleased) Firejail also supports SELinux labeling, so 
> existing SELinux rules apply even if the file system is heavily 
> manipulated.

Is the opinion around the SELinux community that Firejail is good enough 
(in the field of single-command GUI isolation)? A bit hesitant about its 
security because of [1]. I know there is a few alternatives [2][3][4] 
but I don't think I have the knowledge to actually judge which one 
provides better isolation.

[1] https://www.whonix.org/wiki/Dev/Firejail#Security
[1] https://github.com/google/nsjail
[2] https://github.com/containers/bubblewrap
[3] https://www.freedesktop.org/software/systemd/man/systemd-nspawn.html
