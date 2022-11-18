Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77220C433FE
	for <selinux@archiver.kernel.org>; Fri, 18 Nov 2022 10:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiKRKDE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Nov 2022 05:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKRKDD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Nov 2022 05:03:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B554C27E
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668765726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d27Wd07UL1xgazgC6/XC+sjZnlNtWArqOEu0HeUIGO0=;
        b=M+u1zt+MGh55ssV/NAMq0MrgTYI7qu03ohGJqgL+Jo1P2reabT+qapXdhWx6/t7XguzgB1
        c3ArNMaCA/FZ2tGIQJZ01axZCJX7DVawzu+E5mv/hl3mx6s0vshiUY2oOA4rdXvsPEihqA
        CZb9p62EKta264EUPEAKWu4n/wnlZVw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-0D3nuEEwOFm4gb71MPGE7A-1; Fri, 18 Nov 2022 05:02:04 -0500
X-MC-Unique: 0D3nuEEwOFm4gb71MPGE7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26EB6800B23
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 10:02:04 +0000 (UTC)
Received: from localhost (ovpn-194-48.brq.redhat.com [10.40.194.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C82952166B29
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 10:02:03 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] fixfiles: Unmount temporary bind mounts on SIGINT
In-Reply-To: <87leonc95h.fsf@redhat.com>
References: <20221107092504.1088612-1-plautrba@redhat.com>
 <87leonc95h.fsf@redhat.com>
Date:   Fri, 18 Nov 2022 11:02:03 +0100
Message-ID: <87edu01sys.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Petr Lautrbach <plautrba@redhat.com> writes:
>
>> `fixfiles -M relabel` temporary bind mounts file systems before
>> relabeling, but it left the / directory mounted in /tmp/tmp.XXXX when a
>> user hit CTRL-C. It means that if the user run `fixfiles -M relabel`
>> again and answered Y to clean out /tmp directory, it would remove all
>> data from mounted fs.
>>
>> This patch changes the location where `fixfiles` mounts fs to /run, uses
>> private mount namespace via unshare and adds a handler for exit signals
>> which tries to umount fs mounted by `fixfiles`.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>
> Actually, it's v5:
>
> v2:
>
> - set trap on EXIT instead of SIGINT
>
> v3:
>
> - use /run instead of /tmp for mountpoints
>
> v4:
>
> - use mount namespace as suggested by Christian G=C3=B6ttsche <cgzones@go=
oglemail.com>
>
> v5
>
> - fixed issues reported by Christian G=C3=B6ttsche <cgzones@googlemail.co=
m>
>

Any objections?


>>
>>
>>  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/=
fixfiles
>> index c72ca0eb9d61..166af6f360a2 100755
>> --- a/policycoreutils/scripts/fixfiles
>> +++ b/policycoreutils/scripts/fixfiles
>> @@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" |=
 grep '^0 ' | cut -f2- -d ' '
>>  [ ${PIPESTATUS[0]} !=3D 0 ] && echo "$1 not found" >/dev/stderr
>>  }
>>=20=20
>> +# unmount tmp bind mount before exit
>> +umount_TMP_MOUNT() {
>> +	if [ -n "$TMP_MOUNT" ]; then
>> +	     umount "${TMP_MOUNT}${m}" || exit 130
>> +	     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>> +	fi
>> +	exit 130
>> +}
>> +
>> +fix_labels_on_mountpoint() {
>> +	test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" &=
& exit 1
>> +	mkdir -p "${TMP_MOUNT}${m}" || exit 1
>> +	mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
>> +	${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${=
FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
>> +	umount "${TMP_MOUNT}${m}" || exit 1
>> +	rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>> +}
>> +export -f fix_labels_on_mountpoint
>> +
>>  #
>>  # restore
>>  # if called with -n will only check file context
>> @@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
>>  	        # we bind mount so we can fix the labels of files that have al=
ready been
>>  	        # mounted over
>>  	        for m in `echo $FILESYSTEMSRW`; do
>> -	            TMP_MOUNT=3D"$(mktemp -d)"
>> -	            test -z ${TMP_MOUNT+x} && echo "Unable to find temporary d=
irectory!" && exit 1
>> -
>> -	            mkdir -p "${TMP_MOUNT}${m}" || exit 1
>> -	            mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
>> -	            ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREA=
DS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
>> -	            umount "${TMP_MOUNT}${m}" || exit 1
>> -	            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>> +	            TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
>> +	            export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS FC T=
MP_MOUNT m
>> +	            if type unshare &> /dev/null; then
>> +	                unshare -m bash -c "fix_labels_on_mountpoint $*" || ex=
it $?
>> +	            else
>> +	                trap umount_TMP_MOUNT EXIT
>> +	                fix_labels_on_mountpoint $*
>> +	                trap EXIT
>> +	            fi
>>  	        done;
>>  	    fi
>>  	else
>> --=20
>> 2.37.3

