Return-Path: <SRS0=4esc=C2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C9DC2D0E3
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013732087D
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8eQN1qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIQSx3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIQSx3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Sep 2020 14:53:29 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A1AC06174A
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 11:53:18 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g96so2874063otb.12
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNXvgXV54YjFVuMd9RdOW56E/MqP1r69EZ75rcbuw48=;
        b=t8eQN1qqmQxzqaf9JrAjYwN0Po+E0xdfp1Zp+9JtMPaIHNnEJk4HTsmxFPws96fQp5
         uzdIWRpN/fkRzkTLyLDhOoUApB5aWeXYgXy3qqJeN9I1Hdaqh1KmbsyJ6KhH2UCoV99B
         kdjwp0LNiVt1UwD4Vqx8kKZt6icakCoPTjp19z9UJv25MjF3oHynJE0UvDQldnpGRTIs
         uPLIrRWKa3f0rDTrfbmO3s14Pw2yIUvU0/sFIcxZS1Nauce8vBaVnognhPXXAlYUE83z
         4d5CPsIEYmf9V7ST1ywd051+48wSpu2H7hwK7VK9F7Id3wYR8514yaS97Keer+e0C9KN
         SMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNXvgXV54YjFVuMd9RdOW56E/MqP1r69EZ75rcbuw48=;
        b=DE15rtVt4UqfgiZR40I1PrAjEfq9rOBop4BolCXH/4Aw5BKDgD0TDwfID1xumyUZt/
         SWh2qMnA+HP4CUcylpT43YfHP6mYwDLU9u9CoNzrSX+//vc4R9yRFRmRBGve6xxaGStf
         iTZBDvY08SjY2w6bKCKNOVGglrNTnKv/M+ZCpCpMCozNrGwvuQdxKMhbejNMXaxIiEke
         x2bcKM7QkkEe+v3Teb4KalzxQ/TpLs9WzlCNn2iSrS3JeHixH1F92wpPDzKElI6mD3RY
         K0HGscnXzwrzkMnZgRbF4/0JBqMrySOx23tYNGIxkqdqOdC8eHW8i1PfFj0U3hTvc9WE
         E+xQ==
X-Gm-Message-State: AOAM5325Qg8BVeI9oQDFsF9IVSBL0Kb/APfronPP/1MTwi4DPC68SVtJ
        wyeVcpH63FbfLL0acVS1R+vXF1N4qsY9SbPoo+x6rjAr
X-Google-Smtp-Source: ABdhPJwv6apI2M/Paw3ySAfe/9ZpsglP0mt4le684aHDlDGayv/BmDNlOTAKd74BIB08Z9n9/FQIcxLQ/k8at5sX7KY=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr19556815otn.89.1600368797352;
 Thu, 17 Sep 2020 11:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAKG8Do7TCwjf9t5ycjjCENqr6a_nHttXPwS+Z6H9wdREew7LzA@mail.gmail.com>
In-Reply-To: <CAKG8Do7TCwjf9t5ycjjCENqr6a_nHttXPwS+Z6H9wdREew7LzA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 17 Sep 2020 14:53:06 -0400
Message-ID: <CAEjxPJ5BczUFZ82C4bnioSiFLwqv4uvBaGP1afmAf4+amOraAQ@mail.gmail.com>
Subject: Re: `fixfiles -C` does not apply to all paths
To:     Cedric Buissart <cbuissar@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>, dwalsh@redhat.com
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 17, 2020 at 10:44 AM Cedric Buissart <cbuissar@redhat.com> wrote:
>
> Hello all,
>
> I would like to discuss the possible removal of the static path list
> in fixfiles' differential update mode (`fixfiles -C`).
>
> Here is how it works :
>
> 160 # Compare PREVious File Context to currently installed File Context and
> 161 # run restorecon on all files affected by the differences.
> 162 #
> 163 diff_filecontext() {
> 164 EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
> 165 for i in /sys /proc /dev /run /mnt /var/tmp /var/lib/BackupPC
> /home /tmp /dev; do
> 166     [ -e $i ]  && EXCLUDEDIRS="${EXCLUDEDIRS} -e $i";
> 167 done
> 168 LogExcluded
> 169
> 170 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> 171     TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
> 172     test -z "$TEMPFILE" && exit
> 173     PREFCTEMPFILE=`mktemp ${PREFC}.XXXXXXXXXX`
> 174     sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
> 175     sed -r -e 's,:s0, ,g' $FC | sort -u | \
> 176     /usr/bin/diff -b ${PREFCTEMPFILE} - | \
> 177         grep '^[<>]'|cut -c3-| grep ^/ | \
> 178         egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
> 179     sed -r -e 's,[[:blank:]].*,,g' \
> [...]
> 199     ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -i -R -f -; \
>
>
> lines 165-167 and 178 statically prevent some paths to be updated with
> the new policy. I suspect this was done for efficiency and historical
> reasons.
>
> I would propose the removal of these path because :
>
> - restorecon is (by default) automatically ignoring paths that are not
> mounted with `seclabel`. There shouldn't be a need to statically treat
> paths differently
> - Some paths currently in this list (e.g. `/home`) may require
> updating. During a policy update, packages (at least RHEL and Fedora)
> are using `fixfiles -C` to make the policy more efficient, resulting
> in a possibly incomplete policy update.
> - The admin may not be aware of the manual steps required to fully
> apply the new policy after an update.
>
>
> How about removing these lines ?

Looking at the list, I note that several of them have seclabel set in
/proc/mounts so they would no longer be excluded after such a change.
The biggest concern is probably /home due to making fixfiles very
slow.  I think the whole idea of fixfiles -C was to try to minimize
time spent on a policy update.  Maybe we need to re-think the whole
approach.  Android has taken a different approach to allowing
efficient relabeling on Android upgrades.  They save a hash of the
matching file_contexts entries as an extended attribute of
directories, and only descend into the directory during relabeling if
the hash no longer matches.  Upstream, this is only enabled if the -D
option is passed to setfiles/restorecon since it requires
CAP_SYS_ADMIN to set the additional xattr.  Perhaps fixfiles should be
extended with this option and we should be using it instead of -C?
