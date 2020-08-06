Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C31C433E3
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 16:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EAD23119
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 16:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tBXJs6Mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgHFQzo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbgHFQzI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 12:55:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D8C0A889B
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 07:48:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so9077287wmd.4
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iVPk9cGrF9SajGaztCpQ3qzffyx+hSo3oq+N+VKk/s8=;
        b=tBXJs6MhPgY2+EcN89n6dvIoqTKYSKZvopZ0KFA4mdzRFW9gaF+bx5+UgnXWhRUsAQ
         Vs8CG82VJaXJdbRIvk/GcoZcYM6aJA/+w3tE+Zd6PlrrCtU0J44oFRxHA7+Ca30utHTz
         C5woKWl/7bJ4TdZEK0xKQL/cFe9RLGmAWZhngFX7xqeRdeSPDpSP+M4Q+sKQli2xX2kI
         CQtxJUKk3gApY3PYxU7+kDJL/Wb7ujbcvlrrLwHdio1szkraYLjLRalKVaxXmYCia4rZ
         4g1Vph4RDxDXa8pAzI5MABsdCANiD9ju1dUkgsSyHqvEV1HnWsQwT+WxquApojkiLa+2
         T8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iVPk9cGrF9SajGaztCpQ3qzffyx+hSo3oq+N+VKk/s8=;
        b=C/8U+dWR+XrP7GrVlRuJi1kVnc0f3ZNZgmxIkCVs/za86ljqZd5G1+ZhJS+zG/mzVF
         vMr4NV1KQwMvwWvnw7j8c5lwc7RqCmlYGoZLAno/BCbklAkELZ+pnpKTJz63URPNGMvE
         tqFX4Ur1bcmynr70Ng58TEmL4KhfSJ+D6IOtqgfc99VXturvNh0/gwTE655pJJ6yp5nx
         BcH9yj8jqgr0jQLcbT/7yuTWgYntT7U7DdhKDt+Apto7wnarGhGmQGBjbXeEsDxKJaWU
         M6vxNCscwjgdk7pxcRCaYuz0H1RwE8aECc0IRgV3juDBYxFO8ZapvZsTbv7R3aVdEtCj
         c2IQ==
X-Gm-Message-State: AOAM532IcTAO3Svvooz5/Glys4811/cJr745Hw+HZrXp5ze1aYCjB9+c
        VE7hm7xvWEZc+2MZQbXLieSHKoCR
X-Google-Smtp-Source: ABdhPJzMq5x2AyXOCMb4MUdOb7aobnSBeqbXa9ySLzz3Ws7sVHxFU91dtPnYf9zOvQ48FDNtreiB7g==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr8201690wmj.5.1596725319263;
        Thu, 06 Aug 2020 07:48:39 -0700 (PDT)
Received: from ?IPv6:2a02:810d:4bc0:8098:8252:51b6:80cd:c2fd? ([2a02:810d:4bc0:8098:8252:51b6:80cd:c2fd])
        by smtp.gmail.com with ESMTPSA id w1sm6884111wmc.18.2020.08.06.07.48.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 07:48:37 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [RFC PATCH v2] fixfiles: correctly restore context of mountpoints
To:     selinux@vger.kernel.org
References: <CAEjxPJ67MVocx8MO51VcpHRmwZzxANa8Q+-iZFgxPrdwXk5i3g@mail.gmail.com>
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
 MzTZEAm15uwFxq66
Message-ID: <85917790-f0a6-0d57-face-58a6536b1793@gmail.com>
Date:   Thu, 6 Aug 2020 16:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ67MVocx8MO51VcpHRmwZzxANa8Q+-iZFgxPrdwXk5i3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

By bind mounting every filesystem we want to relabel we can access all
files without anything hidden due to active mounts.

This comes at the cost of user experience, because setfiles only
displays the percentage if no path is given or the path is /

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---

 policycoreutils/scripts/fixfiles   | 29 +++++++++++++++++++++++++----
 policycoreutils/scripts/fixfiles.8 |  8 ++++++--
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 5d777034..30dadb4f 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -112,6 +112,7 @@ FORCEFLAG=""
 RPMFILES=""
 PREFC=""
 RESTORE_MODE=""
+BIND_MOUNT_FILESYSTEMS=""
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
 FILESYSTEMSRW=`get_rw_labeled_mounts`
@@ -243,7 +244,23 @@ case "$RESTORE_MODE" in
 	if [ -n "${FILESYSTEMSRW}" ]; then
 	    LogReadOnly
 	    echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
-	    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${FC} ${FILESYSTEMSRW}
+
+	    if [ -z "$BIND_MOUNT_FILESYSTEMS" ]; then
+	        ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${FC} ${FILESYSTEMSRW}
+	    else
+	        # we bind mount so we can fix the labels of files that have already been
+	        # mounted over
+	        for m in `echo $FILESYSTEMSRW`; do
+	            TMP_MOUNT="$(mktemp -d)"
+	            test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
+
+	            mkdir -p "${TMP_MOUNT}${m}" || exit 1
+	            mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
+	            ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
+	            umount "${TMP_MOUNT}${m}" || exit 1
+	            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
+	        done;
+	    fi
 	else
 	    echo >&2 "fixfiles: No suitable file systems found"
 	fi
@@ -313,6 +330,7 @@ case "$1" in
 	> /.autorelabel || exit $?
 	[ -z "$FORCEFLAG" ] || echo -n "$FORCEFLAG " >> /.autorelabel
 	[ -z "$BOOTTIME" ] || echo -N $BOOTTIME >> /.autorelabel
+	[ -z "$BIND_MOUNT_FILESYSTEMS" ] || echo "-M" >> /.autorelabel
 	# Force full relabel if SELinux is not enabled
 	selinuxenabled || echo -F > /.autorelabel
 	echo "System will relabel on next boot"
@@ -324,7 +342,7 @@ esac
 }
 usage() {
 	echo $"""
-Usage: $0 [-v] [-F] [-f] relabel
+Usage: $0 [-v] [-F] [-M] [-f] relabel
 or
 Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | verify }
 or
@@ -334,7 +352,7 @@ Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] { check | restore | verify }
 or
 Usage: $0 [-v] [-F] -C PREVIOUS_FILECONTEXT { check | restore | verify }
 or
-Usage: $0 [-F] [-B] onboot
+Usage: $0 [-F] [-M] [-B] onboot
 """
 }

@@ -353,7 +371,7 @@ set_restore_mode() {
 }

 # See how we were called.
-while getopts "N:BC:FfR:l:v" i; do
+while getopts "N:BC:FfR:l:vM" i; do
     case "$i" in
 	B)
 		BOOTTIME=`/bin/who -b | awk '{print $3}'`
@@ -379,6 +397,9 @@ while getopts "N:BC:FfR:l:v" i; do
 		echo "Redirecting output to $OPTARG"
 		exec >>"$OPTARG" 2>&1
 		;;
+	M)
+		BIND_MOUNT_FILESYSTEMS="-M"
+		;;
 	F)
 		FORCEFLAG="-F"
 		;;
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 9f447f03..12342530 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -6,7 +6,7 @@ fixfiles \- fix file SELinux security contexts.
 .na

 .B fixfiles
-.I [\-v] [\-F] [\-f] relabel
+.I [\-v] [\-F] [-M] [\-f] relabel

 .B fixfiles
 .I [\-v] [\-F] { check | restore | verify } dir/file ...
@@ -21,7 +21,7 @@ fixfiles \- fix file SELinux security contexts.
 .I [\-v] [\-F] \-C PREVIOUS_FILECONTEXT  { check | restore | verify }

 .B fixfiles
-.I [-F] [-B] onboot
+.I [-F] [-M] [-B] onboot

 .ad

@@ -68,6 +68,10 @@ Run a diff on  the PREVIOUS_FILECONTEXT file to the currently installed one, and
 Only act on files created after the specified date.  Date must be specified in
 "YYYY\-MM\-DD HH:MM" format.  Date field will be passed to find \-\-newermt command.

+.TP
+.B \-M
+Bind mount filesystems before relabeling them, this allows fixing the context of files or directories that have been mounted over.
+
 .TP
 .B -v
 Modify verbosity from progress to verbose. (Run restorecon with \-v instead of \-p)
--
2.28.0

