Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877C3C433FE
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 09:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhKWJaD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235291AbhKWJaD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 04:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637659614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0l2YRJ9zIAojaIm8rOVGgz2Ef9k9mfZXz0pzPSoQZ6M=;
        b=COae8d6dkyLLf7ALUJDtpAiqHtvkStqt1n36PId38L/tOLUxgY1ToWF/LADf0VtRM+phHN
        vsopNB1ooo9kGrzwJqqUmR8MRvVLWqmKYIAFJ/lfeXVmIFeNcGaGzaahbCu+dzuwcW+8hL
        gg9sMe3R6pOQLPcLjVGqEcBkXiOF6Z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-jbjETzvUPlu4XfWIuS52qg-1; Tue, 23 Nov 2021 04:26:53 -0500
X-MC-Unique: jbjETzvUPlu4XfWIuS52qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B1968799ED
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 09:26:52 +0000 (UTC)
Received: from localhost (unknown [10.40.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1435D3AEF;
        Tue, 23 Nov 2021 09:26:51 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH userspace v4 0/8] Parallel setfiles/restorecon
In-Reply-To: <CAFqZXNusb5FUnXYKFrjc1Rxh-M-2man4TCLUZR56mPtrkrdDhA@mail.gmail.com>
References: <20211026115239.267449-1-omosnace@redhat.com>
 <CAFqZXNusb5FUnXYKFrjc1Rxh-M-2man4TCLUZR56mPtrkrdDhA@mail.gmail.com>
Date:   Tue, 23 Nov 2021 10:26:50 +0100
Message-ID: <87pmqrkysl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Tue, Oct 26, 2021 at 1:52 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> This series adds basic support for parallel relabeling to the libselinux
>> API and the setfiles/restorecon CLI tools. It turns out that doing the
>> relabeling in parallel can significantly reduce the time even with a
>> relatively simple approach.
>>
>> The first patch fixes a data race around match tracking in label_file.
>> Second patch is a small cleanup found along the way. Patches 3-6 are
>> small incremental changes that various functions more thread-safe.
>> Patch 7 then completes the parallel relabeling implementation at
>> libselinux level and adds a new function to the API that allows to make
>> use of it. Finally, patch 8 adds parallel relabeling support to the
>> setfiles/restorecon tools.
>>
>> The relevant man pages are also updated to reflect the new
>> functionality.
>>
>> The patch descriptions contain more details, namely the last patch has
>> also some benchmark numbers.
>>
>> Changes v3->v4:
>> - add a patch to fix a pre-existing data race in is_context_customizable()
>>
>> Changes v2->v3:
>> - add a patch to fix a pre-existing data race in label_file
>> - wait for threads to complete using pthread_join(3) to prevent thread leaks
>>
>> Changes v1->v2:
>> - make selinux_log() synchronized instead of introducing selinux_log_sync()
>> - fix -Wcomma warning
>> - update the swig files as well
>> - bump new symbol version to LIBSELINUX_3.3 (this may need further update
>>   depending on when this gets merged)
>>
>> Ondrej Mosnacek (8):
>>   label_file: fix a data race
>>   selinux_restorecon: simplify fl_head allocation by using calloc()
>>   selinux_restorecon: protect file_spec list with a mutex
>>   libselinux: make selinux_log() thread-safe
>>   libselinux: make is_context_customizable() thread-safe
>>   selinux_restorecon: add a global mutex to synchronize progress output
>>   selinux_restorecon: introduce selinux_restorecon_parallel(3)
>>   setfiles/restorecon: support parallel relabeling
>
> A friendly reminder that these patches could use a review/ack :)


Acked-by: Petr Lautrbach <plautrba@redhat.com>

# chcon -R -t admin_home_t /usr
# time restorecon -r -F /usr

real    1m13.629s
user    1m11.581s
sys     0m1.885s

# chcon -R -t admin_home_t /usr
# time restorecon -r -F -T 0 /usr

real    0m7.425s
user    1m18.712s
sys     0m3.692s


> -- 
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.

