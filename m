Return-Path: <SRS0=4esc=C2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401ECC433E2
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECAD206DB
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 14:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cgmkknkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgIQOkl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727599AbgIQOjN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Sep 2020 10:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600353503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=03hHrosk6vW/uDIOphTHf9Ue+4CdUnTzTuBA4swLUCo=;
        b=Cgmkknkk9diFEgBaiaVMcI57J1xa4O4gew8g/WL8bASOmE8TK3NE0R6LuHx1Jo3CKVb0GG
        8b8XlMEWIOyqKt07dkAPQjJbj7Yck4KSn/rM3P+e0V0P56MkLG2DSdcWO4n1bTxT1YHmyn
        ZpqnVKjibwF9GuXcbYwS0kGW/POpqAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-sYqLsDtOM9iku69N4wFGVg-1; Thu, 17 Sep 2020 10:36:17 -0400
X-MC-Unique: sYqLsDtOM9iku69N4wFGVg-1
Received: by mail-wm1-f69.google.com with SMTP id x6so829765wmi.1
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 07:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=03hHrosk6vW/uDIOphTHf9Ue+4CdUnTzTuBA4swLUCo=;
        b=tEuYhfSAGM9XJTXSviO6eCJypfBN/aboRxkHlnVHoiWzCUnRmCcpBol+uUxAaPEp0b
         xeQGJkeSu8JFhOfIzPdG79znXyh6mtNlZ7uCkKxXbK5A8gKRvA7HXu6tJkTJNMwJF2yu
         Zw1i5y14F1J4ACnvWwHtROHufZ8I4Vhm54Se7JKx8Pj8I1TzA8vQFTXtGK3G+8bKceP1
         2Qqz6vp3F28u1vyYKwwOoVMHGIv4E2EpgHN8dmU7B9Jj/Y8gWL2QQCLKvqRz4m/qg+gR
         jLm8mV7rdMJFD+q6p8tux02m55f7xgelD+f9fqy30g5n5mLRXZY94yn47bLv02hKJWDv
         IxKg==
X-Gm-Message-State: AOAM532uWV0exS6VZWvZAQhF4sHOF23IsEFNhZrAdF1T7MB/V8RutQng
        AuHT/XM8dBS0nGrf2mO7BfIc8+PEQ6IcxC5z7Wj3xHHr9LT2HtTMcp8OeCVGExdouExZAC+R9ge
        7lcZZxP3EoeWoHysaDXHelIRu4TYH3+amfQ==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr7703449wrp.13.1600353375764;
        Thu, 17 Sep 2020 07:36:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlXz8JaY7Q2c+lJV1MaoLhHTaRFeuAKN8oCdGAwtZxmlJzdYwlVSVW2EXcZbMvSpQh9InHs6annYhFK98ymrs=
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr7703425wrp.13.1600353375534;
 Thu, 17 Sep 2020 07:36:15 -0700 (PDT)
MIME-Version: 1.0
From:   Cedric Buissart <cbuissar@redhat.com>
Date:   Thu, 17 Sep 2020 16:36:04 +0200
Message-ID: <CAKG8Do7TCwjf9t5ycjjCENqr6a_nHttXPwS+Z6H9wdREew7LzA@mail.gmail.com>
Subject: `fixfiles -C` does not apply to all paths
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

I would like to discuss the possible removal of the static path list
in fixfiles' differential update mode (`fixfiles -C`).

Here is how it works :

160 # Compare PREVious File Context to currently installed File Context and
161 # run restorecon on all files affected by the differences.
162 #
163 diff_filecontext() {
164 EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
165 for i in /sys /proc /dev /run /mnt /var/tmp /var/lib/BackupPC
/home /tmp /dev; do
166     [ -e $i ]  && EXCLUDEDIRS="${EXCLUDEDIRS} -e $i";
167 done
168 LogExcluded
169
170 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
171     TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
172     test -z "$TEMPFILE" && exit
173     PREFCTEMPFILE=`mktemp ${PREFC}.XXXXXXXXXX`
174     sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
175     sed -r -e 's,:s0, ,g' $FC | sort -u | \
176     /usr/bin/diff -b ${PREFCTEMPFILE} - | \
177         grep '^[<>]'|cut -c3-| grep ^/ | \
178         egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
179     sed -r -e 's,[[:blank:]].*,,g' \
[...]
199     ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -i -R -f -; \


lines 165-167 and 178 statically prevent some paths to be updated with
the new policy. I suspect this was done for efficiency and historical
reasons.

I would propose the removal of these path because :

- restorecon is (by default) automatically ignoring paths that are not
mounted with `seclabel`. There shouldn't be a need to statically treat
paths differently
- Some paths currently in this list (e.g. `/home`) may require
updating. During a policy update, packages (at least RHEL and Fedora)
are using `fixfiles -C` to make the policy more efficient, resulting
in a possibly incomplete policy update.
- The admin may not be aware of the manual steps required to fully
apply the new policy after an update.


How about removing these lines ?

Best regards,

Cedric

