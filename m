Return-Path: <SRS0=Mzal=CH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF5C433E2
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 23:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02B9207BB
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 23:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="HmToUhCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgH2XZN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Aug 2020 19:25:13 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:40466 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbgH2XZJ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 29 Aug 2020 19:25:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id C5CC8D533FD17;
        Sun, 30 Aug 2020 02:25:05 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id f40hMUTTTH9U; Sun, 30 Aug 2020 02:25:05 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 5DF1AD533FD28;
        Sun, 30 Aug 2020 02:25:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 5DF1AD533FD28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1598743505;
        bh=XKVx2IH2RBIDHi1JUmJH7cGOm/pvrjeWCRyNn6CbWJc=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=HmToUhCkSXTvXoR5YcWdeiNa101NLIYlJwdEuTJnV8ea6EZPfUSBZTVO3v26Loclm
         rQS99OnJ0Z0b/5zGxzfCaDKWh3y7P0caacNa+4un3ELtJ/dCZArVZapWLDGoVI7r8U
         Su6BVqn3b4DwOSi+WgsABQlIzb3sL82c118vhHyTMpnpw268a8+dM7CK7kIvSraVpP
         cN4tCWl49ph9c30X3nCmB3yxOoZl/pPVt83KDOQNOl+tWs0RD4wZw0dm1mmjBrCLoi
         cxhjS6a41qdHdRpEJjvIAW9meyGzgyRGdpE/sBorO7xKbvNNCHeNWewzchpoaWI9CK
         yZfpgfLybGDkg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 12e7bFzykbPy; Sun, 30 Aug 2020 02:25:05 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-71-182.ip.moscow.rt.ru [90.154.71.182])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 19B53D533FD17;
        Sun, 30 Aug 2020 02:25:05 +0300 (MSK)
Subject: Re: Hiding names of unreadable files
To:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     survolog@yandex.ru, Vladimir Potapov <vladimir.potapov@rosalab.ru>,
        =?UTF-8?B?0JzQuNGF0LDQuNC7INCc0L7RgdC+0LvQvtCy?= 
        <m.mosolov@rosalinux.ru>
References: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
 <20a4950f-2d71-3e3f-d2d0-e16bea191a43@gmail.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <f9aab727-8971-4657-a652-59a18eec759b@rosalinux.ru>
Date:   Sun, 30 Aug 2020 02:25:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20a4950f-2d71-3e3f-d2d0-e16bea191a43@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

30.08.2020 00:26, Topi Miettinen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 29.8.2020 14.08, Mikhail Novosyolov wrote:
>>
>> 4. Try to just restrict write access to directories without proper MLS=
 labels:
>> separate /tmp for arch user, maybe separate /var/tmp for each user, ch=
mod -x (maybe via ACL) for /run etc.
>
> PAM module pam_namespace sets up private directories in /tmp etc. and p=
am_tmpdir is probably similar.

Yes. But it causes problems in different places, by far not all software =
is ready to have different files in /tmp from different users.

In general this does work. But for /tmp. What about /var/tmp, /run? In th=
eory a similar polyinstantiation can be done for them, but new problems w=
ill be encountered.

/var/tmp is even more interesting because it is normally not a tmpfs, som=
e software can store permanent data there, e.g. KDE4 stores cache files t=
here. Per-user onion-mounting (overlayfs, aufs) or a simple `mount --bind=
` could be used there.

