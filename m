Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FAC38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 08:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A209720659
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 08:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGInt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbgEGIns (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 04:43:48 -0400
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 May 2020 01:43:48 PDT
Received: from ithil.bigon.be (ithil.bigon.be [IPv6:2001:bc8:25f1:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAB0C061A10
        for <selinux@vger.kernel.org>; Thu,  7 May 2020 01:43:48 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id CDCFA1FEDF;
        Thu,  7 May 2020 10:35:14 +0200 (CEST)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id I0yXM0mBVeoW; Thu,  7 May 2020 10:35:14 +0200 (CEST)
Received: from [IPv6:2a02:a03f:65bc:5f00:f7be:6179:48b7:2349] (unknown [IPv6:2a02:a03f:65bc:5f00:f7be:6179:48b7:2349])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Thu,  7 May 2020 10:35:14 +0200 (CEST)
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Russell Coker <russell@coker.com.au>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv>
From:   Laurent Bigonville <bigon@debian.org>
Autocrypt: addr=bigon@debian.org; keydata=
 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
 LFU6hIZ9xxNM3jr8h0Ql
Message-ID: <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
Date:   Thu, 7 May 2020 10:35:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3838641.zh4Wi6GlAV@liv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Le 6/05/20 à 18:37, Russell Coker a écrit :
> On Thursday, 7 May 2020 1:50:46 AM AEST Stephen Smalley wrote:
>> on that running instance, but not to specify custom kernel parameters
>> initially or to reboot the system before proceeding with further
>> commands (if anyone knows differently, speak up). We'd have to get to
>> the point where enabling SELinux in Debian is possible without
>> requiring a reboot at all.  And then we'd have to wait for that
>> support to find its way into one of the Ubuntu images supported by
>> travis-ci.  Might be easier to just get travis-ci to support Fedora or
>> CentOS images in the first place. Regardless, allowing the testsuite
>> to be run by users of other distributions is worthwhile IMHO.
> In the past there hasn't been much demand for a smoother installation process.
> If you are setting up a traditional Unix server system the Debian SE Linux
> installation thing doesn't make things much more difficult.  Past complaints
> about it have been more about an imagined difficulty of using SE Linux and have
> ended when I showed and wrote about how to do it (one time I showed
> screenshots of the process in an LCA lightning talk and didn't have problems
> with time).
>
> I don't think that the people who maintain the Debian installation related
> packages would have a great objection to adding SE Linux features, although it
> might take a bit of time for it to migrate from Debian to Ubuntu.
>
> We can make this a priority.
>
If people are using preseed installations (kickstart equivalent), I 
think that enabling SELinux in the installer shouldn't be too difficult 
(installing the needed packages, modifying the files and relabeling with 
fixfiles). It's obviously not user friendly, but the question is what's 
the target here.

