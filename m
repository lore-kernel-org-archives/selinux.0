Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0957C4332F
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 11:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiKDLmf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDLme (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 07:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C34125E98
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667562096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4Yg7DDrXpxWFnT8GAGJ32Nyakh8JY80C9NOOivA+dQ=;
        b=aso90Bh3/+AsuFPEvxUQ05HoXmZXCIchSrkyuPlLvC/DpVd8MBV4IqPREzreVHOxGbtSKO
        L9jfu+qLLMz7xArdd3kKMHxgOI72QOZ2KVhhsGqsUKngQi9Qkddkh77CTLjqcGsjyZ0fim
        9v5sy7/Y5JHV+mT/jEQ2TGOb2H++Ctc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-4APPsU_zOEejwXvxu84D9A-1; Fri, 04 Nov 2022 07:41:33 -0400
X-MC-Unique: 4APPsU_zOEejwXvxu84D9A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24E902823814;
        Fri,  4 Nov 2022 11:41:33 +0000 (UTC)
Received: from localhost (ovpn-194-20.brq.redhat.com [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDC5E403161;
        Fri,  4 Nov 2022 11:41:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v4] fixfiles: Unmount temporary bind mounts on SIGINT
In-Reply-To: <CAJ2a_Dfzxn1jHcjJBbktO69fYeLytTDdBSec-oy9fv9rKJ7bbA@mail.gmail.com>
References: <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
 <20221007134600.137812-1-plautrba@redhat.com> <874jvfdmtf.fsf@redhat.com>
 <CAJ2a_Dfzxn1jHcjJBbktO69fYeLytTDdBSec-oy9fv9rKJ7bbA@mail.gmail.com>
Date:   Fri, 04 Nov 2022 12:41:32 +0100
Message-ID: <87y1src5g3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> On Fri, 4 Nov 2022 at 11:42, Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Petr Lautrbach <plautrba@redhat.com> writes:
>>
>> > `fixfiles -M relabel` temporary bind mounts filestems before relabeling
>> > but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
>> > CTRL-C. It means that if the user run `fixfiles -M relabel` again and
>> > answered Y to clean out /tmp directory, it would remove all data from
>> > mounted fs.
>> >
>> > This patch changes the location where `fixfiles` mounts fs to /run, us=
es
>> > private mount namespace via unshare and adds a handler for exit signals
>> > which tries to umount fs mounted by `fixfiles`.
>> >
>> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2125355
>> >
>> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>
>>
>> Is there anyone who objects?
>>
>> Petr
>>
>>
>> > ---
>> > v2:
>> >
>> > - set trap on EXIT instead of SIGINT
>> >
>> > v3:
>> >
>> > - use /run instead of /tmp for mountpoints
>> >
>> > v4:
>> >
>> > - use mount namespace as suggested by Christian G=C3=B6ttsche <cgzones=
@googlemail.com> (September 16) (inbox)
>> >
>> >
>> >  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
>> >  1 file changed, 28 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/script=
s/fixfiles
>> > index c72ca0eb9d61..af64a5a567a6 100755
>> > --- a/policycoreutils/scripts/fixfiles
>> > +++ b/policycoreutils/scripts/fixfiles
>> > @@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1"=
 | grep '^0 ' | cut -f2- -d ' '
>> >  [ ${PIPESTATUS[0]} !=3D 0 ] && echo "$1 not found" >/dev/stderr
>> >  }
>> >
>> > +# unmount tmp bind mount before exit
>> > +umount_TMP_MOUNT() {
>> > +     if [ -n "$TMP_MOUNT" ]; then
>> > +          umount "${TMP_MOUNT}${m}" || exit 130
>> > +          rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>> > +     fi
>> > +     exit 130
>> > +}
>> > +
>> > +fix_labels_on_mountpoint() {
>> > +     test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directo=
ry!" && exit 1
>> > +     mkdir -p "${TMP_MOUNT}${m}" || exit 1
>> > +     mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
>> > +     ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $*=
 -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
>> > +     umount "${TMP_MOUNT}${m}" || exit 1
>> > +     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>> > +}
>> > +export -f fix_labels_on_mountpoint
>> > +
>> >  #
>> >  # restore
>> >  # if called with -n will only check file context
>> > @@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
>> >               # we bind mount so we can fix the labels of files that h=
ave already been
>> >               # mounted over
>> >               for m in `echo $FILESYSTEMSRW`; do
>> > -                 TMP_MOUNT=3D"$(mktemp -d)"
>> > -                 test -z ${TMP_MOUNT+x} && echo "Unable to find tempo=
rary directory!" && exit 1
>> > -
>> > -                 mkdir -p "${TMP_MOUNT}${m}" || exit 1
>> > -                 mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
>> > -                 ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $=
{THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
>> > -                 umount "${TMP_MOUNT}${m}" || exit 1
>> > -                 rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>> > +                     TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXX=
XXXX)"
>
> Whitespace issue:
>
> git apply ~/Downloads/v4-fixfiles-Unmount-temporary-bind-mounts-on-SIGINT=
.patch
> /home/christian/Downloads/v4-fixfiles-Unmount-temporary-bind-mounts-on-SI=
GINT.patch:137:
> space before tab in indent.
>                         TMP_MOUNT=3D"$(mktemp -p /run -d fixfiles.XXXXXXX=
XXX)"
> warning: 1 line adds whitespace errors.
>
>> > +                 export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREAD=
S FC TMP_MOUNT m
>> > +                 if type unshare &> /dev/null; then
>> > +                     unshare -m bash -x -c "fix_labels_on_mountpoint"=
 $* || exit $?
>
> Two issues:
>
> I.
> The `-x` flag make the output unreadable (especially for check/verify).


This is leftover from my debugging. It is not supposed to be there.


> II.
> The option (e.g. `-n` for check/verify) is not passed, should be `-c
> "fix_labels_on_mountpoint $*"`.

I'll fix it.


Thanks!


>> > +                 else
>> > +                     trap umount_TMP_MOUNT EXIT
>> > +                     fix_labels_on_mountpoint $*
>> > +                     trap EXIT
>> > +                 fi
>> >               done;
>> >           fi
>> >       else
>> > --
>> > 2.37.3
>>

