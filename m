Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC2C433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 13:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiDFNE1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiDFNDp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 09:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EC514DBFFB
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649237472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cTn/X9Itj5mbXY8lzRe4R1XbyPDiJvHPpZSph7Uw4Jw=;
        b=LwNQRN8ioe1YywvoiQXxA4MjCQpnLswfIexM37Deaygu+1GBEcAlKsnVaXtTKIUeBGv30s
        MpJKBb6iiYKC0Hp/i8pwrjBrZjPeRaCUuDl6QNzlFz+rdkAe0scB2zOoA59a/sqMGTCq/c
        dInhovu/XD/DBddxX9d0BXBCULPwOWU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-lqb0voBwPm6LemCqEcQnxw-1; Wed, 06 Apr 2022 05:24:05 -0400
X-MC-Unique: lqb0voBwPm6LemCqEcQnxw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5419B3811A2E
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 09:24:05 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05A11401E9C;
        Wed,  6 Apr 2022 09:24:04 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Joseph Marrero Corchado <jmarrero@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v3] libsemanage: Fall back to semanage_copy_dir when
 rename() fails
In-Reply-To: <CAFqZXNstUu0s4P2iXPmdvdu-86_tajuV+RQKzMK_+xYBk-y+bw@mail.gmail.com>
References: <20220324095251.1561597-1-plautrba@redhat.com>
 <20220324120034.1570408-1-plautrba@redhat.com>
 <CAFqZXNstUu0s4P2iXPmdvdu-86_tajuV+RQKzMK_+xYBk-y+bw@mail.gmail.com>
Date:   Wed, 06 Apr 2022 11:24:04 +0200
Message-ID: <87pmlupnt7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Thu, Mar 24, 2022 at 1:01 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>> In some circumstances, like semanage-store being on overlayfs, rename()
>> could fail with EXDEV - Invalid cross-device link. This is due to the
>> fact that overlays doesn't support rename() if source and target are not
>> on the same layer, e.g. in containers built from several layers. Even
>> though it's not atomic operation, it's better to try to copy files from
>> src to dst on our own in this case. Next rebuild will probably not fail
>> as the new directories will be on the same layer.
>>
>> Fixes: https://github.com/SELinuxProject/selinux/issues/343
>>
>> Reproducer:
>>
>>     $ cd selinux1
>>
>>     $ cat Dockerfile
>>     FROM fedora:35
>>     RUN dnf install -y selinux-policy selinux-policy-targeted
>>
>>     $ podman build -t localhost/selinux . --no-cache
>>
>>     $ cd ../selinux2
>>
>>     $ cat Dockerfile
>>     FROM localhost/selinux
>>     RUN semodule -B
>>
>>     $ podman build -t localhost/selinux2 . --no-cache
>>     STEP 2/2: RUN semodule -B
>>     libsemanage.semanage_commit_sandbox: Error while renaming /var/lib/selinux/targeted/active to /var/lib/selinux/targeted/previous. (Invalid cross-device link).
>>     semodule:  Failed!
>>     Error: error building at STEP "RUN semodule -B": error while running runtime: exit status 1
>>
>> With the fix:
>>
>>     $ podman build -t localhost/selinux2 . --no-cache
>>     STEP 2/2: RUN semodule -B
>>     libsemanage.semanage_rename: Warning: rename(/var/lib/selinux/targeted/active, /var/lib/selinux/targeted/previous) failed: Invalid cross-device link, fall back to non-atomic semanage_copy_dir_flags()
>>
>>     COMMIT localhost/selinux2
>>     --> d2cfcebc1a1
>>     Successfully tagged localhost/selinux2:latest
>>     d2cfcebc1a1b34f1c2cd661ac18292b0612c3e5fa71d6fa1441be244da91b1af
>>
>> Reported-by: Joseph Marrero Corchado <jmarrero@redhat.com>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>
>> v2
>> - improve the commit message
>> - use WARN() instead of fprintf(stderr,
>>
>> v3
>> - WARN without \n at the end
>> - split long line
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Note that I didn't give the logic a thorough review, so I'd prefer
> someone else to give it a final look and merge it.

Merged.



> -- 
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.

