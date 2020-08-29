Return-Path: <SRS0=Mzal=CH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9861C433E6
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 21:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4EA208CA
	for <selinux@archiver.kernel.org>; Sat, 29 Aug 2020 21:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcIkdA7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH2V0v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgH2V0t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 29 Aug 2020 17:26:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6076FC061573
        for <selinux@vger.kernel.org>; Sat, 29 Aug 2020 14:26:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d2so1522046lfj.1
        for <selinux@vger.kernel.org>; Sat, 29 Aug 2020 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ky++0806uMNENBnHVHfNAAXaJFa1Lujx1DepGAbMi64=;
        b=QcIkdA7OHrPKMZa8g1b2SulWdJX+o0SqcSemX+O63hnNG8O0tH6qppioWpVKDQ/Rc9
         pZbb5geONY4+LbE+vooidtwfBwIfXOl0Pa5AZp/whhAJOSOmP5X00AFH0j4IopZ11p6+
         UcIhmfU7ZUBR/4QHwWDWE4aiM1F2+56UPrtGEeUhJ3BV42I4GJyEfdjvAsN4Id//DrcK
         e048ZEFCXHdiIIlw9q+x2CcyJCD35sRRYzzJBziE26UXdCpD1ITzfvPc5UJN4RCMRgtC
         s3aKaZF3bW70KzwkgIrzfBtNAjqLXZZ9JMKvA6h+IsS1SDnsueycAELoseYh9Bq1KjSN
         1NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ky++0806uMNENBnHVHfNAAXaJFa1Lujx1DepGAbMi64=;
        b=oxfhm3intCovLgvBXPIzC6SYlX/+ROQd8bULfI7nEeCEtvcGjArNS3Cf3IRtua/GTB
         GjBFGDyS8XjHSzWLUQlKd84zKxbjZNf6Be6mtvNCE0T7dtfAt4iaiiKa9Qz8KDEQxfpd
         9RC7xU9zCXTVero2Im/q+pvpmaV6yq7js3I+R8gqF3zf0vkUKWRnJoQw0Nxe7WIdOMaU
         Xgi/p6Z4X05iuVkDOIhzUaQhkntHejdJWLwqRTO5/9yGGnA7zWG2ZlOyB1wXb4qqQtw5
         l7rzBeFTXQ4n6g1denRd4ZsxIDk5pJkQ72qaqnPRPYYyyVlDrHurEpjb9KYXSijEmB/y
         JABw==
X-Gm-Message-State: AOAM5336kKROoid+8VymG5GFHCNJullw1++lO8EWSy9DH+I6HtnzZqbI
        3zMKrCfuzw4sS//FD4/RjJU=
X-Google-Smtp-Source: ABdhPJxWqFXpwggPkRHinAVKCcPfY6RslsVDR7+NNFqBcxitkMDXEtQ71rqX2bleP0S4P+xdkVPeQQ==
X-Received: by 2002:a05:6512:2f3:: with SMTP id m19mr1248623lfq.14.1598736407761;
        Sat, 29 Aug 2020 14:26:47 -0700 (PDT)
Received: from [192.168.1.130] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id m142sm867436lfa.47.2020.08.29.14.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 14:26:47 -0700 (PDT)
Subject: Re: Hiding names of unreadable files
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        SElinux list <selinux@vger.kernel.org>
Cc:     survolog@yandex.ru, Vladimir Potapov <vladimir.potapov@rosalab.ru>,
        =?UTF-8?B?0JzQuNGF0LDQuNC7INCc0L7RgdC+0LvQvtCy?= 
        <m.mosolov@rosalinux.ru>
References: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <20a4950f-2d71-3e3f-d2d0-e16bea191a43@gmail.com>
Date:   Sun, 30 Aug 2020 00:26:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 29.8.2020 14.08, Mikhail Novosyolov wrote:
> Hello everyone,
> 
> We have been thinking on such problem: read access to a file may be restricted with SELinux MCS/MLS, especially MLS/MCS.
> If a file with restricted access is inside a directory without restricted access, its name is readable.
> Name of the file may be used to store some "secret" information.
> Some system directories, e.g. /var/tmp, are writable for multiple users, and they may use it to exchange secret information,
> bypassing restrictions.
> 
> Is there a way to restrict access to names of such files?
> 
> What may theoretically be done:
> 
> 1. Hide such files from directory listing. A bad idea, because most pieces of software (and people)
> are not ready to deal with situations when a file does not exist but a file with such name cannot be
> created because it already exists.
> 
> 2. Change name of the file to "????". Even worse.
> 
> 3. Do not show the name of the file at all. I do not know how it should be done,
> something like showing that an "inode" exists.
> 
> 4. Try to just restrict write access to directories without proper MLS labels:
> separate /tmp for arch user, maybe separate /var/tmp for each user, chmod -x (maybe via ACL) for /run etc.
> 
> Can and should it be done with SELinux? What about other LSM modules?
> Is there a more generic approach to hide names of unreadable files?
> 

PAM module pam_namespace sets up private directories in /tmp etc. and 
pam_tmpdir is probably similar.

-Topi
