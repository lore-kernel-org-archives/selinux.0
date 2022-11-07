Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF03C4332F
	for <selinux@archiver.kernel.org>; Mon,  7 Nov 2022 11:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiKGLLu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 06:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiKGLLi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 06:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2825CF5
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 03:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667819437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKObO2xkXBLOedp4GFNWRraEd9f36b5PNZhV6f12p+I=;
        b=bO999Nq9ajiXprg4uLHLbjlNyYZJIjfgbXQwS5qNwp0rQHbLH1f6j8qheEY3AehEd/SHXK
        Dxr2nfjawnDLEjNY4x1alFF6gM0u6Udlg6gnHIOt6vu4jSmiu0Z5SrzEMXRFwTXp8ZjixR
        /p1M3LU0QdoBwdALUmH2jbhavMY0h6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-CALlWQbuPaK2KkkqJDqw5A-1; Mon, 07 Nov 2022 06:10:36 -0500
X-MC-Unique: CALlWQbuPaK2KkkqJDqw5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C588585A583
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 11:10:35 +0000 (UTC)
Received: from localhost (ovpn-192-172.brq.redhat.com [10.40.192.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CA162166B29
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 11:10:35 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] fixfiles: Unmount temporary bind mounts on SIGINT
In-Reply-To: <20221107092504.1088612-1-plautrba@redhat.com>
References: <20221107092504.1088612-1-plautrba@redhat.com>
Date:   Mon, 07 Nov 2022 12:10:34 +0100
Message-ID: <87leonc95h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> `fixfiles -M relabel` temporary bind mounts file systems before
> relabeling, but it left the / directory mounted in /tmp/tmp.XXXX when a
> user hit CTRL-C. It means that if the user run `fixfiles -M relabel`
> again and answered Y to clean out /tmp directory, it would remove all
> data from mounted fs.
>
> This patch changes the location where `fixfiles` mounts fs to /run, uses
> private mount namespace via unshare and adds a handler for exit signals
> which tries to umount fs mounted by `fixfiles`.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---

Actually, it's v5:

v2:

- set trap on EXIT instead of SIGINT

v3:

- use /run instead of /tmp for mountpoints

v4:

- use mount namespace as suggested by Christian G=C3=B6ttsche <cgzones@goog=
lemail.com>

v5

- fixed issues reported by Christian G=C3=B6ttsche <cgzones@googlemail.com>


>
>
>  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index c72ca0eb9d61..166af6f360a2 100755
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
> +	            TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
> +	            export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS FC TM=
P_MOUNT m
> +	            if type unshare &> /dev/null; then
> +	                unshare -m bash -c "fix_labels_on_mountpoint $*" || exi=
t $?
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

