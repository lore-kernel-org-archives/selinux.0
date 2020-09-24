Return-Path: <SRS0=GjD/=DB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D87C4363D
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 14:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD00206C3
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuRL9P0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgIXOzh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Sep 2020 10:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbgIXOzh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Sep 2020 10:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600959335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5H8V0nQ+/ravyePPu8sfcvMjfup7vMgmyweA96PuAVI=;
        b=WuRL9P0k/1OSn3rRje//Srm2tjPR1ESU3fPyli6LgLpV13kjBgNJHdAQH8PCTZrcT0pqLp
        XeeKevuMyEA9cagLlp4ozvI+OKTF7cZ4lwmYMrstEZYIpIBN0sWlCvaxhYOelcnUsb5mtq
        Tz01S5DousTescDPQavqdGfDjzujZGQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-am8uoxXDMU-26h1xEVeqiw-1; Thu, 24 Sep 2020 10:55:33 -0400
X-MC-Unique: am8uoxXDMU-26h1xEVeqiw-1
Received: by mail-wr1-f69.google.com with SMTP id l9so1318248wrq.20
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2020 07:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5H8V0nQ+/ravyePPu8sfcvMjfup7vMgmyweA96PuAVI=;
        b=C12D2a/7wEWcUC8JmbLbQgmTYoXVkoO8FO0UX4Y1f/7wL/5ANa8SiMlg2wTEX1iV0F
         5XCadBmIvfcUh404TS0LkX8us5YsaGgcxuFGZGMEe195MCngUpLL4jRpBeBw+W8DrFb+
         deoSMALXrCfmodneSVsiwhk6NJzZniRJQQ1B71AILpjcmvWSTZAinFmi8N+tDmIkYEnW
         i4ZZk8FAV2oasm5AbjZUPuIOy+JT0oXHswlzeL4mvS7CXPIiewAZa5vv+B5TWqndBmRf
         IPf0AKhJlqvxoep31VbuyD0S8tYRW0jfFTW/Ovl6HTnMd5f+RfnsKC2DiQDOq37uKzsy
         s5hQ==
X-Gm-Message-State: AOAM532wOVgQZY0ehrDNjvE0JsbNc9Z9/uHxhoQr9Jnqmm7nbUi3Qcch
        M4rMHoKWXBidVud4ihgJAIRWPbVSZDNG67wnIYsMsoBbgQSk4i2qGQwjz+B5cMxmLgsPxo6cvVv
        B59ksoR3F7wdB1UpxjObm5aDzWaquaBwHyw==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr188549wrt.196.1600959332125;
        Thu, 24 Sep 2020 07:55:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK4N7quN7p1lY7kHHibcoqQVkw0c3utEmgGpKa9lGvrMmEHx7dOhltjjXYqdk3iOkJMUM3qvHo7Aj50JY4QyU=
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr188526wrt.196.1600959331902;
 Thu, 24 Sep 2020 07:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ5BczUFZ82C4bnioSiFLwqv4uvBaGP1afmAf4+amOraAQ@mail.gmail.com>
 <20200924101201.GA609742@workstation.lan>
In-Reply-To: <20200924101201.GA609742@workstation.lan>
From:   Cedric Buissart <cbuissar@redhat.com>
Date:   Thu, 24 Sep 2020 16:55:21 +0200
Message-ID: <CAKG8Do6HbPdTg5yi502Uz66+rFQR9VUC++xJnWQ_5ATJSLcU3Q@mail.gmail.com>
Subject: Re: `fixfiles -C` does not apply to all paths
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        dwalsh@redhat.com, zpytela@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 24, 2020 at 12:12 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Thu, Sep 17, 2020 at 02:53:06PM -0400, Stephen Smalley wrote:
> > On Thu, Sep 17, 2020 at 10:44 AM Cedric Buissart <cbuissar@redhat.com> wrote:
> > >
> > > Hello all,
> > >
> > > I would like to discuss the possible removal of the static path list
> > > in fixfiles' differential update mode (`fixfiles -C`).
> > >
> > > Here is how it works :
> > >
> > > 160 # Compare PREVious File Context to currently installed File Context and
> > > 161 # run restorecon on all files affected by the differences.
> > > 162 #
> > > 163 diff_filecontext() {
> > > 164 EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
> > > 165 for i in /sys /proc /dev /run /mnt /var/tmp /var/lib/BackupPC
> > > /home /tmp /dev; do
> > > 166     [ -e $i ]  && EXCLUDEDIRS="${EXCLUDEDIRS} -e $i";
> > > 167 done
> > > 168 LogExcluded
> > > 169
> > > 170 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> > > 171     TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
> > > 172     test -z "$TEMPFILE" && exit
> > > 173     PREFCTEMPFILE=`mktemp ${PREFC}.XXXXXXXXXX`
> > > 174     sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
> > > 175     sed -r -e 's,:s0, ,g' $FC | sort -u | \
> > > 176     /usr/bin/diff -b ${PREFCTEMPFILE} - | \
> > > 177         grep '^[<>]'|cut -c3-| grep ^/ | \
> > > 178         egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
> > > 179     sed -r -e 's,[[:blank:]].*,,g' \
> > > [...]
> > > 199     ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -i -R -f -; \
> > >
> > >
> > > lines 165-167 and 178 statically prevent some paths to be updated with
> > > the new policy. I suspect this was done for efficiency and historical
> > > reasons.
> > >
> > > I would propose the removal of these path because :
> > >
> > > - restorecon is (by default) automatically ignoring paths that are not
> > > mounted with `seclabel`. There shouldn't be a need to statically treat
> > > paths differently
> > > - Some paths currently in this list (e.g. `/home`) may require
> > > updating. During a policy update, packages (at least RHEL and Fedora)
> > > are using `fixfiles -C` to make the policy more efficient, resulting
> > > in a possibly incomplete policy update.
> > > - The admin may not be aware of the manual steps required to fully
> > > apply the new policy after an update.
> > >
> > >
> > > How about removing these lines ?
> >
> > Looking at the list, I note that several of them have seclabel set in
> > /proc/mounts so they would no longer be excluded after such a change.
> > The biggest concern is probably /home due to making fixfiles very
> > slow.  I think the whole idea of fixfiles -C was to try to minimize
> > time spent on a policy update.  Maybe we need to re-think the whole
> > approach.  Android has taken a different approach to allowing
> > efficient relabeling on Android upgrades.  They save a hash of the
> > matching file_contexts entries as an extended attribute of
> > directories, and only descend into the directory during relabeling if
> > the hash no longer matches.  Upstream, this is only enabled if the -D
> > option is passed to setfiles/restorecon since it requires
> > CAP_SYS_ADMIN to set the additional xattr.  Perhaps fixfiles should be
> > extended with this option and we should be using it instead of -C?

As a side note : since non-system directories do not need immediate
update, how about delegating the policy update of these ones to a
one-off service running in the background ?
> >
>
> I'd like to say that I'm aware about this problem but I don't have answers yet.
>
> It seems to be related to the way how `fixfiles -C` translates regexps to
> glob's, e.g. '/home/[^/]+/\.yubico(/.*)?' would be translated to '/home/*' and
> relabeling whole /home could be long and delicate? action as it would touch users
> data.
>
> As a short term workaround, I'd suggest that policy package maintainers enforce relabeling
> of particular directories inside /home when they know it's really needed.
>
> Petr



-- 
Cedric Buissart,
Product Security

