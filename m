Return-Path: <SRS0=Mzal=CH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E234C433E2
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 23:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52266207BB
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 23:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="MtdZyoRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgH2XaM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Aug 2020 19:30:12 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:40774 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgH2XaM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 29 Aug 2020 19:30:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 852F9D49E9127;
        Sun, 30 Aug 2020 02:30:10 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Oz5TsGGFpQO1; Sun, 30 Aug 2020 02:30:10 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id E8427D47C2D2D;
        Sun, 30 Aug 2020 02:30:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru E8427D47C2D2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1598743810;
        bh=dcjYw09s4YEzJi7Is2v1cOFPsGFErZYwCuvaPsAIMtU=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=MtdZyoRC5X6+5pixfz+lfsriWzPOpNH5DR1v9kneWUbdbvqjzxG1LLoU6aEFHc+uQ
         8yDQS8njbvnnFUCO7qy4jJ6SYLDU8PcnUE8F5DhjVLwn0xlqcndEODXuIxIA+/bcdG
         admOm0dwvBe+ZfK7yCB+gi1jDsK2xUAVdBrYZW1FtAfI7nepYCt09fkziE0MoaRmBI
         5+83wChjYNt3E422tS+tsU2/U07a47WP6ddNsC5uXHTp4H5v6ezz0EJVBgtSkpPYl/
         JLz1NMMihkXB7z8PfgqqDzXYfaxC51aKM0ZvgTi063h73orQrxIwDpI6l9koaIGy0j
         CcVtnRlQSH3Sg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S4pSDUa-Tc7Z; Sun, 30 Aug 2020 02:30:09 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-71-182.ip.moscow.rt.ru [90.154.71.182])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 970A5D4112532;
        Sun, 30 Aug 2020 02:30:09 +0300 (MSK)
Subject: Re: Hiding names of unreadable files
To:     Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     survolog@yandex.ru, Vladimir Potapov <vladimir.potapov@rosalab.ru>,
        =?UTF-8?B?0JzQuNGF0LDQuNC7INCc0L7RgdC+0LvQvtCy?= 
        <m.mosolov@rosalinux.ru>
References: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
 <f2db2efd-1852-bcb9-c734-68d29b9f1880@schaufler-ca.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <e8efae23-ac19-ce3d-4988-b3e304e4807b@rosalinux.ru>
Date:   Sun, 30 Aug 2020 02:30:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f2db2efd-1852-bcb9-c734-68d29b9f1880@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

29.08.2020 19:42, Casey Schaufler =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On 8/29/2020 4:08 AM, Mikhail Novosyolov wrote:
>> Hello everyone,
>>
>> We have been thinking on such problem: read access to a file may be re=
stricted with SELinux MCS/MLS, especially MLS/MCS.
>> If a file with restricted access is inside a directory without restric=
ted access, its name is readable.
>> Name of the file may be used to store some "secret" information.
>> Some system directories, e.g. /var/tmp, are writable for multiple user=
s, and they may use it to exchange secret information,
>> bypassing restrictions.
>>
>> Is there a way to restrict access to names of such files?
> TL;DR - No
>
> This is probably the oldest active question in the history
> of UNIX/Linux security. In the late 1980's it arose many times
> in the process of system security evaluations. Because the
> name of a file is data in the directory, and not an attribute
> of the file in UNIX/Linux filesystems, access to it is controlled
> by access to the directory.
>
> There was initially much crying and gnashing of teeth about this
> in the evaluation community. Especially with regard to /tmp.
> SELinux (and Smack, and B&L systems from the old days) have
> explicit policies controlling how files can be created in
> directories such that you can read the directory but not the
> file attributes. While this can't prevent creating a file named
> launch-the-missiles-at-noon, it provides accountability.
Very interesting, thanks.But are there technical restrictions to implemen=
t hiding names of files?
Let's assume that we will be OK with performance penalty of directory lis=
ting because of checking access rights to each file inside the directory.
Were there any attempts to implement this?
