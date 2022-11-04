Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C291C4332F
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 10:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKDKmN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 06:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiKDKmC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 06:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18EBDB7
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667558462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QCgN8VdUpvE/N2AerRa3TKOMZiGBS2xB2hEote5/8U=;
        b=iTYf5QOWxk/RNiRkNx7OWO13fueZiS7qMJsanD95uJ2P37oJKry+26yHzvY0z1aUdTQugO
        zSQyjv49f89eXnf+DUuD7p9cvABiK6a9tuse53M+LPy549Vec2qIUl775j7kcx4np3BTkL
        fBP0xsMkFC0wk4tV4eUrfWnlrG2ZI+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-92IwtXkEM6Wi30pidZIDww-1; Fri, 04 Nov 2022 06:41:01 -0400
X-MC-Unique: 92IwtXkEM6Wi30pidZIDww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EF79833AEC
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 10:41:01 +0000 (UTC)
Received: from localhost (ovpn-194-20.brq.redhat.com [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30804403160
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 10:41:01 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH v4] fixfiles: Unmount temporary bind mounts on SIGINT
In-Reply-To: <20221007134600.137812-1-plautrba@redhat.com>
References: <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
 <20221007134600.137812-1-plautrba@redhat.com>
Date:   Fri, 04 Nov 2022 11:41:00 +0100
Message-ID: <874jvfdmtf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> `fixfiles -M relabel` temporary bind mounts filestems before relabeling
> but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
> CTRL-C. It means that if the user run `fixfiles -M relabel` again and
> answered Y to clean out /tmp directory, it would remove all data from
> mounted fs.
>
> This patch changes the location where `fixfiles` mounts fs to /run, uses
> private mount namespace via unshare and adds a handler for exit signals
> which tries to umount fs mounted by `fixfiles`.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>


Is there anyone who objects?

Petr


> ---
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
oglemail.com> (September 16) (inbox)
>
>
>  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index c72ca0eb9d61..af64a5a567a6 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | =
grep '^0 ' | cut -f2- -d ' '
>  [ ${PIPESTATUS[0]} !=3D 0 ] && echo "$1 not found" >/dev/stderr
>  }
>=20=20
> +# unmount tmp bind mount before exit
> +umount_TMP_MOUNT() {
> +	if [ -n "$TMP_MOUNT" ]; then
> +	     umount "${TMP_MOUNT}${m}" || exit 130
> +	     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +	fi
> +	exit 130
> +}
> +
> +fix_labels_on_mountpoint() {
> +	test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" &&=
 exit 1
> +	mkdir -p "${TMP_MOUNT}${m}" || exit 1
> +	mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> +	${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${F=
C} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> +	umount "${TMP_MOUNT}${m}" || exit 1
> +	rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +}
> +export -f fix_labels_on_mountpoint
> +
>  #
>  # restore
>  # if called with -n will only check file context
> @@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
>  	        # we bind mount so we can fix the labels of files that have alr=
eady been
>  	        # mounted over
>  	        for m in `echo $FILESYSTEMSRW`; do
> -	            TMP_MOUNT=3D"$(mktemp -d)"
> -	            test -z ${TMP_MOUNT+x} && echo "Unable to find temporary di=
rectory!" && exit 1
> -
> -	            mkdir -p "${TMP_MOUNT}${m}" || exit 1
> -	            mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
> -	            ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREAD=
S} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
> -	            umount "${TMP_MOUNT}${m}" || exit 1
> -	            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +	          	TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
> +	            export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS FC TM=
P_MOUNT m
> +	            if type unshare &> /dev/null; then
> +	                unshare -m bash -x -c "fix_labels_on_mountpoint" $* || =
exit $?
> +	            else
> +	                trap umount_TMP_MOUNT EXIT
> +	                fix_labels_on_mountpoint $*
> +	                trap EXIT
> +	            fi
>  	        done;
>  	    fi
>  	else
> --=20
> 2.37.3

