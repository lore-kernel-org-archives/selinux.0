Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD920C3F68F
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9353320836
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uP2bZkb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfLJTn1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:43:27 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:39561
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbfLJTn0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 14:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576007004; bh=CJiSiRby+c7T9jH8PAichJnKJI9nmiEBR0oy0YDAKxw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uP2bZkb6PzDy2Cf/bXxn+fbwTfpGx4Ys32uUG71PSB79x9U5o4vvUp82cwFLBd9Jrv99KnPlDRZL9SEpCP8L3lTpIJyUwfZzRfT0s1q8xrFnA4rumN4w5u8eO2dAfLLlAF3vGMfs5fCxabyZIWscvwrzL0kaHLf1TAEjdNqUunnHpKO9F1ZI0dKcNQoqHk4wVxz+j/oZIzxtOQpjWhsZO7oLKI1T4FB6yK9ITskzZX/WKBbIPdO+KgLF363BQH7PdVp3pyIASCC63chyA9XBu1rpiZz/kUdcXecBYdQMQNgw4/eFhTslS0CqxzK3IOF7UEQ8hGdYyzThqKQZ9uNCDQ==
X-YMail-OSG: 3fj3_SAVM1khKWTuTfDVfXFsMnbxuQqx.f3_TJZxnCrRkE9UEjbpF3zP9ow_1a6
 eJ2DxokUSbI2ELBKJ1bQJIcjFGRIiEfCQaHnASfsTs2A6w3rRbkFosaJvQ5uiUDd1c7NfxQ4Thps
 sAN_VaJ054UoHx8EsZUtMOYvx6f6cHSZM0WWoqOEVROEDzPqpGCcLBg3_Xk5yQ4LrV_3oef_83B1
 NYXWz7wQKM3eA9eyyVINNJaRP.b0njSpyfXREyh0wmpuONXIxCVnXkjZSUona9AOKM1e.20lR11P
 5eR.m5ASn.uWnZh.22A.yFdkz.KC56122cFK1W_kygrrTP5HBSOvhFsrsJyDJE5Nhibpfp45sUvP
 LFhGubtGtANrmTzsbuX9wmXmJSfG7MCXvzFy1IlxZsqqE1BQEey6t.kkvVhy5dzc.TR9eg6BluP1
 oYRBpUVZtofHkng6uShGNp4qC6xKOoN4oHlKTVibQxOPKV9MNKm3dg3eDBTYMxUmCE9kKpAs4Llo
 4gqOHznQsFdxi1CwyrHHfIkS2giK7tAluH1UzXYEPHwtVPHGj4JeTY2jGiIguTmyn1Xprt4Jgd.E
 Wwu.sDsNiPjc5tp1pwerzvWB_2Z1lDaIJRCKhK_75hVOjCu12TO8JR4v7Hc6D8FoJShEjS3gQrDk
 cmJ4fZEqbKRMYwOnEUhy0JnyvEtWdZFWNmznWps99xEdf.vIsfVMuOsrv2ntVfzR_jqRsn8WPlLd
 ZBOK2rPwwhATW..9Jmh3SgeoCo9Uvd5Q9VxFgYieYDIQk30KCgU0qEBJFMBMV2sraakNxzCUxcI3
 GIcvFdkDdCVfI2VhR9oRXsCXTeLa4F8KHJvXhUVvPZn6uwRBbv.h72xVIDxMXr3cnlebFmokSljP
 .pT9KOGPN9ECdXAxBn0L_nauu30LHFWVRTm99sPvxoKGuJ8LYxUL0rQmCi.id4tia.shtnBRLW8o
 3AdnRpEgySFoFSKaXbZJUzDzRWcErBbXIgKHYFm.N8Gd38XvVdJhUiP_ihZugq5hh6MHKMsvgK_J
 ojg0P_fBgBTApyAROtcrgUi2d6iA_gzuERDvFYoanrTUT4fPta3C2YxkPHhXFksZ1PLsQdhA9VoN
 BgevXPxyn9kdGQFERzD1YtR8YKsO.EApXuXWWfipXLrceq9PAAeq3iCWLGdniH4Vlijrp5uPQSb3
 bLMzfh9rPu6Qm0Q7dX3KO0Zk84ivJl98Ywx.WFQdlQhx5y4Shtxh5ryNzZi7JIjvHItrM9FOaXE2
 AIi8Ol69BeIlzrqKGbuif37MM34sQPgromebieYTPmYejlWb..0eoXQavoov2LgmhsNitlQIXE32
 IJ87.AqbwUPNB4gP8LTnmnjUCe7Gg.2g7nfjSQAiwHtpXDsX.dpyLpmRXAnSVV5nmfGb50y2B5bf
 sgyGCxYLKNJoyEOvk9lGvmlCyNLc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Dec 2019 19:43:24 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0270ddcf35c24dc4028ec343b2a82e13;
          Tue, 10 Dec 2019 19:43:22 +0000 (UTC)
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less
 broken
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191209075756.123157-1-omosnace@redhat.com>
 <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
 <CAFqZXNvMHEvv0tP7ybFEsH1-CvE5GGC9fEP=yXqEnQmjxgdDjA@mail.gmail.com>
 <CAHC9VhRe=xdz9eD9q8mO8=3QDVfsRpn7OUyXDj7o4C-cYfFHMQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e1d9b641-8de6-9a0a-e6a2-d58c178a184b@schaufler-ca.com>
Date:   Tue, 10 Dec 2019 11:43:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRe=xdz9eD9q8mO8=3QDVfsRpn7OUyXDj7o4C-cYfFHMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/2019 11:29 AM, Paul Moore wrote:
> On Tue, Dec 10, 2019 at 6:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> On Mon, Dec 9, 2019 at 2:21 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
>>>> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
>>>> infrastructure to use per-hook lists, which meant that removing the
>>>> hooks for a given module was no longer atomic. Even though the commit
>>>> clearly documents that modules implementing runtime revmoval of hooks
>>>> (only SELinux attempts this madness) need to take special precautions to
>>>> avoid race conditions, SELinux has never addressed this.
>>>>
>>>> By inserting an artificial delay between the loop iterations of
>>>> security_delete_hooks() (I used 100 ms), booting to a state where
>>>> SELinux is enabled, but policy is not yet loaded, and running these
>>>> commands:
>>>>
>>>>      while true; do ping -c 1 <some IP>; done &
>>>>      echo -n 1 >/sys/fs/selinux/disable
>>>>      kill %1
>>>>      wait
>>>>
>>>> ...I was able to trigger NULL pointer dereferences in various places. I
>>>> also have a report of someone getting panics on a stock RHEL-8 kernel
>>>> after setting SELINUX=disabled in /etc/selinux/config and rebooting
>>>> (without adding "selinux=0" to kernel command-line).
>>>>
>>>> Reordering the SELinux hooks such that those that allocate structures
>>>> are removed last seems to prevent these panics. It is very much possible
>>>> that this doesn't make the runtime disable completely race-free, but at
>>>> least it makes the operation much less fragile.
>>>>
>>>> An alternative (and safer) solution would be to add NULL checks to each
>>>> hook, but doing this just to support the runtime disable hack doesn't
>>>> seem to be worth the effort...
>>> Personally, I would prefer to just get rid of runtime disable
>>> altogether; it also precludes making the hooks read-only after
>>> initialization.  IMHO, selinux=0 is the proper way to disable SELinux if
>>> necessary.  I believe there is an open bugzilla on Fedora related to
>>> this issue, since runtime disable was originally introduced for Fedora.
>> I, too, would like to see it gone, but removing it immediately would
>> likely cause issues for existing users (see [1]) ...
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1430944#c2
> For the record, and for those who didn't click on the RHBZ link above,
> I'm a big fan of getting rid of SELinux's runtime disable but concede
> that it must be done in such a way to as not horribly break userspace.

Is there some reason that changing the "disable SELinux" option
has to remove the hooks? Why can't it set selinux_enabled to 0
and be done with it?

