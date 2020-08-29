Return-Path: <SRS0=Mzal=CH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C876CC433E6
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C97207DA
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 12:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="oaPdARaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgH2MCD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:02:03 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:41962 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgH2MCB (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 29 Aug 2020 08:02:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 74EBBD5313DDF;
        Sat, 29 Aug 2020 14:08:43 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 80Cw3ssNfqQ4; Sat, 29 Aug 2020 14:08:43 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id F05D5D5313DD4;
        Sat, 29 Aug 2020 14:08:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru F05D5D5313DD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1598699323;
        bh=Urq6JweUV4XcfdCL9s6iNhORqAEOGLwAc7RzKdEge4w=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=oaPdARaLxY0XAi5N453ZKSGomvHQbnLUinY8iP5wQRnfC9aH4nv0t6DMOz9ipqz0g
         R3b0K5ZAbHHuZpAkJ4R0qEi3ajfZhXBd0ySjuuZ87ZHsehUOT+1aifGJ4ueITjEVLE
         bLNhiBLxX3VxHwNvlCh65n14WPZCj54XDa8hM3kWyPweylPxPv4+ayoqn12MFimSo4
         PXWx8ZfWIz2mLFqnpA0jmBQ2HADgj91KSNGC7wbIilt3giN6xnOIB5H4ZWp5DHLlWA
         zW82EUqDnMVvw8vv+FrknNooS6tAhAmG95mN6AdgV5I4cCfDW5D/bwTjGdrAcqKZYb
         pt2jwJotb9usw==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BHkMCjqcV_Z4; Sat, 29 Aug 2020 14:08:42 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-71-182.ip.moscow.rt.ru [90.154.71.182])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 804FED530DA28;
        Sat, 29 Aug 2020 14:08:42 +0300 (MSK)
To:     SElinux list <selinux@vger.kernel.org>
Cc:     survolog@yandex.ru, Vladimir Potapov <vladimir.potapov@rosalab.ru>,
        =?UTF-8?B?0JzQuNGF0LDQuNC7INCc0L7RgdC+0LvQvtCy?= 
        <m.mosolov@rosalinux.ru>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: Hiding names of unreadable files
Message-ID: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
Date:   Sat, 29 Aug 2020 14:08:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello everyone,

We have been thinking on such problem: read access to a file may be restricted with SELinux MCS/MLS, especially MLS/MCS.
If a file with restricted access is inside a directory without restricted access, its name is readable.
Name of the file may be used to store some "secret" information.
Some system directories, e.g. /var/tmp, are writable for multiple users, and they may use it to exchange secret information,
bypassing restrictions.

Is there a way to restrict access to names of such files?

What may theoretically be done:

1. Hide such files from directory listing. A bad idea, because most pieces of software (and people)
are not ready to deal with situations when a file does not exist but a file with such name cannot be
created because it already exists.

2. Change name of the file to "????". Even worse.

3. Do not show the name of the file at all. I do not know how it should be done,
something like showing that an "inode" exists.

4. Try to just restrict write access to directories without proper MLS labels:
separate /tmp for arch user, maybe separate /var/tmp for each user, chmod -x (maybe via ACL) for /run etc.

Can and should it be done with SELinux? What about other LSM modules?
Is there a more generic approach to hide names of unreadable files?

