Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C778ECAAA1
	for <selinux@archiver.kernel.org>; Fri, 16 Sep 2022 15:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiIPPgz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Sep 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiIPPgu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Sep 2022 11:36:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8502E688
        for <selinux@vger.kernel.org>; Fri, 16 Sep 2022 08:36:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dv25so50202572ejb.12
        for <selinux@vger.kernel.org>; Fri, 16 Sep 2022 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=874znem4TwWAvQja+XVw0dFVyOB+h0Ct8HN0mTMHTco=;
        b=Q3OW1BAam1XoabfpsK4bFUJDki2verAOA48VsxC/zK+V3ecmoe49m12c2mV3Dc6dP4
         M2YPhN6bDYojrmsRpV+vHgryPiLjVB5CA6qdOyEnfHnfoRor74wT70bA/2HDQkAUbaO0
         LMFVZ1wglVJysGI4Zl+VViFEcOUtC5sM3Rp3jHziPbzrBm1IXwZPsjtFU5IwIn0dtbLl
         Ktbq3DBTSyR5WreMP5cxv+cWiho2qgXt5IQTynY4LMlWb8YJrDFq/F/+yI4U+ShyFLQn
         34YBqaRj7Gtpx2Ra4AAynWCJfTGZ0sO82aLRGTlcpnXmjXLAdVL7lQctn61S1ihwytZE
         otLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=874znem4TwWAvQja+XVw0dFVyOB+h0Ct8HN0mTMHTco=;
        b=p6qQzQ/gyiFMZ4AHlylUH0ylSW7bKGaljaIZMOqvsFAldTFESak7AUC0P4V3UBgs2Y
         m3spzt1fLR3ISd9xWcXkq5VRLI0onr3MFjPaMMU20r3r+6O1yEozgTIKuK77bPCIrvy1
         t9RCMiqnZHcH9QZG8gfIGexSHidFXwzkr7uhNkE73j772uPHfDUh0kgB8fr56auKTk8x
         gLrc269wVWjIXtUkLQhLlIKOZzKJKHQ57k+DNeYBn8jphDTBG9fQWNFfSTkdAk6JFnOi
         RT+Zk9WLix0fUbshDcU9Kl4bkv02jmjgiDUz/bo+ASLJKTwtC4cPtXhhjI55uzx0RFNj
         AQcQ==
X-Gm-Message-State: ACrzQf13Msh9q0TtSfswY2YVJQ1qxIdw35kUuA52wfY6SUFurhCi0Za6
        uh6CfNxTa0aF/6pomLQFV3UwWi4gP4fSTU/22ey3e3fv82s=
X-Google-Smtp-Source: AMsMyM4oVE3dOXj3YJeae+kleAXV1THFKOx2pTv0jZmyOs0O0ZRVnB07dEQQLbEcj0ybWipPfoPqo3FV6dCEvHLPTf4=
X-Received: by 2002:a17:907:3f12:b0:77b:8d8:f353 with SMTP id
 hq18-20020a1709073f1200b0077b08d8f353mr3890595ejc.349.1663342607738; Fri, 16
 Sep 2022 08:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220915163751.41804-1-plautrba@redhat.com> <20220916141308.72606-1-plautrba@redhat.com>
In-Reply-To: <20220916141308.72606-1-plautrba@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 16 Sep 2022 17:36:36 +0200
Message-ID: <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
Subject: Re: [PATCH v3] fixfiles: Unmount temporary bind mounts on SIGINT
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 16 Sept 2022 at 16:14, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> `fixfiles -M relabel` temporary bind mounts filestems before relabeling
> but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
> CTRL-C. It means that if the user run `fixfiles -M relabel` again and
> answered Y to clean out /tmp directory, it would remove all data from
> mounted fs.
>
> This patch changes the location where `fixfiles` mounts fs to /run and
> adds a handler for exit signals which tries to umount fs mounted by
> `fixfiles`.

What about additionally using mount namespaces, if available:

@@ -256,10 +256,16 @@
                   test -z ${TMP_MOUNT+x} && echo "Unable to find
temporary directory!" && exit 1

                   mkdir -p "${TMP_MOUNT}${m}" || exit 1
-                   mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
-                   ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG}
${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
-                   umount "${TMP_MOUNT}${m}" || exit 1
-                   rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
+                   if ! unshare --mount /bin/sh -c "mount --bind
\"${m}\" \"${TMP_MOUNT}${m}\" || exit 1 && ${SETFILES} ${VERBOSE}
${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r \"${TMP_MOUNT}\"
\"${TMP_MOUNT}${m}\" || true"; then
+                        echo "Creating new mount namespace failed,
operating in root namespace"
+                       mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
+                       ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS}
${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}"
"${TMP_MOUNT}${m}"
+                       umount "${TMP_MOUNT}${m}" || exit 1
+                    fi
+                    if [ "${m}" != '/' ]; then
+                        rmdir "${TMP_MOUNT}${m}" || echo "Error
cleaning up ${TMP_MOUNT}${m}."
+                    fi
+                   rmdir "${TMP_MOUNT}"     || echo "Error cleaning
up ${TMP_MOUNT}."
               done;
           fi
       else

?

>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
> v2:
>
> - set trap on EXIT instead of SIGINT
>
> v3:
>
> - use /run instead of /tmp for mountpoints
>
>
>  policycoreutils/scripts/fixfiles | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index c72ca0eb9d61..acf5f0996c19 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -207,6 +207,15 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
>  [ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
>  }
>
> +# unmount tmp bind mount before exit
> +umount_TMP_MOUNT() {
> +       if [ -n "$TMP_MOUNT" ]; then
> +            umount "${TMP_MOUNT}${m}" || exit 130
> +            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
> +       fi
> +       exit 130
> +}
> +
>  #
>  # restore
>  # if called with -n will only check file context
> @@ -251,8 +260,9 @@ case "$RESTORE_MODE" in
>             else
>                 # we bind mount so we can fix the labels of files that have already been
>                 # mounted over
> +               trap umount_TMP_MOUNT EXIT
>                 for m in `echo $FILESYSTEMSRW`; do
> -                   TMP_MOUNT="$(mktemp -d)"
> +                   TMP_MOUNT="$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
>                     test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
>
>                     mkdir -p "${TMP_MOUNT}${m}" || exit 1
> @@ -261,6 +271,7 @@ case "$RESTORE_MODE" in
>                     umount "${TMP_MOUNT}${m}" || exit 1
>                     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>                 done;
> +               trap EXIT
>             fi
>         else
>             echo >&2 "fixfiles: No suitable file systems found"
> --
> 2.37.3
>
