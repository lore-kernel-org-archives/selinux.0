Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D156C4321E
	for <selinux@archiver.kernel.org>; Tue, 29 Nov 2022 13:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiK2NRz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiK2NRc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Nov 2022 08:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06489627FC
        for <selinux@vger.kernel.org>; Tue, 29 Nov 2022 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669727777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8n5pn8uNfp51DWASeSr0A2oEBhBK826MwPnG3BYrt/o=;
        b=TxP8Z3KsBkxaIS+j24zYzg7aC2WcP5T88yaLJtoVQNfUFxqpOqDw9MZzLdpvvQ1rDw+6vH
        ZaA9C/Ve3Lww9/zhAdZ1e7BYd4gnLvI4lT5qTAZifff0t2Zf/nzl7nbZ5aEQUFnMGI9hPT
        UEwODiXJS4nnNfNpe31oCo0Zz1gEGlI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-9N6x05EwOUGRwYfOJAOWyw-1; Tue, 29 Nov 2022 08:16:08 -0500
X-MC-Unique: 9N6x05EwOUGRwYfOJAOWyw-1
Received: by mail-ej1-f71.google.com with SMTP id sb2-20020a1709076d8200b007bdea97e799so3876942ejc.22
        for <selinux@vger.kernel.org>; Tue, 29 Nov 2022 05:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8n5pn8uNfp51DWASeSr0A2oEBhBK826MwPnG3BYrt/o=;
        b=LRJlY0cr7qN5JF/EKLiAtuhLGY3/Mh8cHaAUCxJcO2hVBzvUXpesPHQMrGgWz2St10
         fwFTZnCjLctHuquff5uSmcZjUt7HPp9oURYPU0CR8luGZKG/Kx1exyV+RICv4hdX/M1Q
         FnshRf25t2VH1TzSgRYo63l7nvdKXPixGTEqyje4PPgJBU9+VlsNFNJpM/jflD4c6dpF
         eScDsXulwi+BUuOXBWEfiyyMiB0Naqev6xDG8XzrQQdeIhDHUPKWXNKyItfbvUljo14m
         DDqYQkj63+1EqeNuuJWTwGSsYr5FFBQklGvTKAnwDOBTBGYqNt73a/AM1NDbq63gwhZ8
         4Mcg==
X-Gm-Message-State: ANoB5pmeZdQKigb2BUySqd/3x2vIqouzADywbrWzgMUX/FXMo3qm1gxz
        WTljBzJ42WwKYlQx/JQpFI5U9LAjFTS6Y8JC4ugBXomFOXtLN0Lw5wx3TZPTzVQZ26AvDcOB1+Q
        gC/n3wYrOVPlxnZyA4Ls/1GKth4utuNzpgRJfdUdiWJViugl3Hl6LinpbsWpSLIQefRY4
X-Received: by 2002:a05:6402:5003:b0:462:a25f:f0f2 with SMTP id p3-20020a056402500300b00462a25ff0f2mr51600868eda.156.1669727766849;
        Tue, 29 Nov 2022 05:16:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4btGrx5A0e/QEWqkeSwXJhZ02knAOFfVbEfJ0AzX/6CHhBaYXqkOSMGmxh1FKhR7rggXZ5gQ==
X-Received: by 2002:a05:6402:5003:b0:462:a25f:f0f2 with SMTP id p3-20020a056402500300b00462a25ff0f2mr51600846eda.156.1669727766474;
        Tue, 29 Nov 2022 05:16:06 -0800 (PST)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id ky17-20020a170907779100b007c09644afd9sm75232ejc.108.2022.11.29.05.16.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:16:06 -0800 (PST)
Message-ID: <30fc3ef7-1b62-0a18-fa13-140f888ca0a5@redhat.com>
Date:   Tue, 29 Nov 2022 14:16:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     selinux@vger.kernel.org
From:   Vit Mojzis <vmojzis@redhat.com>
Subject: semanage export does not distinguish between --modify and --add
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,
semanage export always uses -a (--add) even in cases where -m (--modify) 
is needed (when modifying record specified in policy).
Reproducible for "semange login" and "semanage fcontext" (and maybe others).

Steps to Reproduce:
# semanage login -m -s unconfined_u -r s0-s0:c0.c1023 __default__
# semanage export -f /tmp/exp
# semanage login -D
# semanage import -f /tmp/exp
ValueError: Login mapping for __default__ is already defined
# semanage login -lC
<empty>
# cat /tmp/exp
...
login -a -s unconfined_u -r 's0-s0:c0.c1023' __default__
^^^ should be "login -m" instead

Alternative reproducer:

# semanage fcontext -m -t boot_t "/xen(/.*)?"
# semanage export -f /tmp/exp
# semanage fcontext -D
# semanage import -f /tmp/exp
ValueError: File context for /xen(/.*)? already defined
# semanage fcontext -lC
<empty>
# cat /tmp/exp
...
fcontext -a -f a -t boot_t -r 's0' '/xen(/.*)?'
^^^ should be "fcontext -m" instead

Expected results:
The login/fcontext mapping is removed and re-add by semanage import 
(semanage login -D, semanage login -m -s unconfined_u -r s0-s0:c0.c1023 
__default__).

Is there a straightforward way of figuring out if the login mapping was 
introduced by "semanage -m" while exporting customizations?

Alternatively I was thinking about modifying "semanage login --add" to 
modify existing mapping if it exists, instead of exiting with an error. 
But that is a change in behavior and may hide user mistakes.

