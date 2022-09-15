Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E08FC6FA89
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiIOQ3c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIOQ3b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 12:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C8FFD8
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663259369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cchY8c+gmBverqhJ2sdkjSPl4Hpm7WMcxb2Bo19GOnY=;
        b=dnIE8l6Mm2h8BNHziydFudEgjTOSbQsWlIvrVXktzNGpPRJg4EI7ARZNG8PnBgWthfQxjw
        PuJDX6YzFIiCT6VFvgVU747vp8bJCDDO1HZ+soq86fJnWlWwYchwVu6DDPwFM1rQamMQr8
        Mgg9B4puGySc7PhJs/z/pIts8fHCtHU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-UO7fIMH1MtOiDPowVW3urQ-1; Thu, 15 Sep 2022 12:29:28 -0400
X-MC-Unique: UO7fIMH1MtOiDPowVW3urQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF89C3817A6E
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 16:29:27 +0000 (UTC)
Received: from localhost (unknown [10.40.193.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 818142087440;
        Thu, 15 Sep 2022 16:29:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH] fixfiles: Unmount temporary bind mounts on SIGINT
In-Reply-To: <CAFqZXNvmjHBQ4gTkm3252NE2KcBL4=5da5+dK2pHD0mAxqbAkw@mail.gmail.com>
References: <20220915124418.27156-1-plautrba@redhat.com>
 <CAFqZXNvmjHBQ4gTkm3252NE2KcBL4=5da5+dK2pHD0mAxqbAkw@mail.gmail.com>
Date:   Thu, 15 Sep 2022 18:29:26 +0200
Message-ID: <87leqkd2jd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Thu, Sep 15, 2022 at 2:45 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>> `fixfiles -M relabel` temporary bind mounts filestems before relabeling
>> but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
>> CTRL-C. It means that if the user run `fixfiles -M relabel` again and
>> answered Y to clean out /tmp directory, it would remove all data from
>> mounted fs.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  policycoreutils/scripts/fixfiles | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
>> index c72ca0eb9d61..6811921970f2 100755
>> --- a/policycoreutils/scripts/fixfiles
>> +++ b/policycoreutils/scripts/fixfiles
>> @@ -207,6 +207,15 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
>>  [ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
>>  }
>>
>> +# unmount tmp bind mount before exit
>> +umount_TMP_MOUNT() {
>> +       if [ -n "$TMP_MOUNT" ]; then
>> +            umount "${TMP_MOUNT}${m}" || exit 130
>> +            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>> +       fi
>> +       exit 130
>> +}
>> +
>>  #
>>  # restore
>>  # if called with -n will only check file context
>> @@ -251,6 +260,7 @@ case "$RESTORE_MODE" in
>>             else
>>                 # we bind mount so we can fix the labels of files that have already been
>>                 # mounted over
>> +               trap umount_TMP_MOUNT SIGINT
>>                 for m in `echo $FILESYSTEMSRW`; do
>>                     TMP_MOUNT="$(mktemp -d)"
>>                     test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
>> @@ -261,6 +271,7 @@ case "$RESTORE_MODE" in
>>                     umount "${TMP_MOUNT}${m}" || exit 1
>>                     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>>                 done;
>> +               trap SIGINT
>>             fi
>>         else
>>             echo >&2 "fixfiles: No suitable file systems found"
>> --
>> 2.37.3
>>
>
> And what if the fixfiles process is terminated via SIGTERM or even
> SIGKILL?

Good point.

> Or a power failure occurs at the wrong time?

After power failure and reboot there's no bind mountpoints from fixfiles
left.

> What if some
> other process leaves behind a bind mount / other mount in /tmp?

I don't know. But it's up to users to decide. If they are not sure, they
should answer 'No' to /tmp clean up.


> My suggestion would be to:
> 1) Change the trap from SIGINT to EXIT. That will cover both SIGTERM and SIGINT.

I'll send updated patch with this.

> 2) Additionally modify fullrelabel() to not traverse across mounts
> when doing the removing (+ possibly exit with an error whenever a
> mountpoint is encountered - OR - try to unmount the mounts instead of
> removing their contents).

Given that I don't know what was the original motivation for the cleaing
code and users are asked whether they want to clean up /tmp and they are
warned that they would need to reboot after this operation, I'm not sure
how I would defend the change.

Thanks,

Petr



> -- 
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.

