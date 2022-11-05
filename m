Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A23C433FE
	for <selinux@archiver.kernel.org>; Sat,  5 Nov 2022 09:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKEJa1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Nov 2022 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEJa0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Nov 2022 05:30:26 -0400
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Nov 2022 02:30:23 PDT
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484141B4
        for <selinux@vger.kernel.org>; Sat,  5 Nov 2022 02:30:22 -0700 (PDT)
Received: from webmail.defensec.nl (debian.lan [IPv6:2a10:3781:2099::123])
        by markus.defensec.nl (Postfix) with ESMTPSA id B7F29FC0ACA;
        Sat,  5 Nov 2022 10:24:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1667640269;
        bh=2LBNbfkea3sFRMrIuIHKlAcuFvi+78gujCZj4TM3ins=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aHZVRlFh87kvnZak6Jk/qLLGJnB7D8jN6I1b5E5lBan5ZY//NXs5NDytkDyVFhQc9
         7F5gra/oOjh71uo6dM120qv/7NJSqHSQ4XrLpnu4U11SGU8ZZ3UOKb6FgP+/jxZ1G2
         wiSh75W5WZPFOCR6TL1QTDG6MGlzNOjD/mrClBZg=
MIME-Version: 1.0
Date:   Sat, 05 Nov 2022 10:24:29 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v4] fixfiles: Unmount temporary bind mounts on SIGINT
In-Reply-To: <87y1src5g3.fsf@redhat.com>
References: <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
 <20221007134600.137812-1-plautrba@redhat.com> <874jvfdmtf.fsf@redhat.com>
 <CAJ2a_Dfzxn1jHcjJBbktO69fYeLytTDdBSec-oy9fv9rKJ7bbA@mail.gmail.com>
 <87y1src5g3.fsf@redhat.com>
Message-ID: <6f56b088839634a24310b37aeabe781a@defensec.nl>
X-Sender: dominick.grift@defensec.nl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022-11-04 12:41, Petr Lautrbach wrote:
> Christian Göttsche <cgzones@googlemail.com> writes:
> 
>> On Fri, 4 Nov 2022 at 11:42, Petr Lautrbach <plautrba@redhat.com> 
>> wrote:
>>> 
>>> Petr Lautrbach <plautrba@redhat.com> writes:
>>> 
>>> > `fixfiles -M relabel` temporary bind mounts filestems before relabeling
>>> > but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
>>> > CTRL-C. It means that if the user run `fixfiles -M relabel` again and
>>> > answered Y to clean out /tmp directory, it would remove all data from
>>> > mounted fs.
>>> >
>>> > This patch changes the location where `fixfiles` mounts fs to /run, uses
>>> > private mount namespace via unshare and adds a handler for exit signals
>>> > which tries to umount fs mounted by `fixfiles`.
>>> >
>>> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355
>>> >
>>> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>> 
>>> 
>>> Is there anyone who objects?

Unrelated but thought i'd mention it here:

Since at least Fedora uses btrfs by default on Workstation it might be 
worth it to look into adding support for btrfs (subvolumes) to fixfiles.

>>> 
>>> Petr
>>> 
>>> 
>>> > ---
>>> > v2:
>>> >
>>> > - set trap on EXIT instead of SIGINT
>>> >
>>> > v3:
>>> >
>>> > - use /run instead of /tmp for mountpoints
>>> >
>>> > v4:
>>> >
>>> > - use mount namespace as suggested by Christian Göttsche <cgzones@googlemail.com> (September 16) (inbox)
>>> >
>>> >
>>> >  policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
>>> >  1 file changed, 28 insertions(+), 8 deletions(-)
>>> >
>>> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
>>> > index c72ca0eb9d61..af64a5a567a6 100755
>>> > --- a/policycoreutils/scripts/fixfiles
>>> > +++ b/policycoreutils/scripts/fixfiles
>>> > @@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
>>> >  [ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
>>> >  }
>>> >
>>> > +# unmount tmp bind mount before exit
>>> > +umount_TMP_MOUNT() {
>>> > +     if [ -n "$TMP_MOUNT" ]; then
>>> > +          umount "${TMP_MOUNT}${m}" || exit 130
>>> > +          rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>>> > +     fi
>>> > +     exit 130
>>> > +}
>>> > +
>>> > +fix_labels_on_mountpoint() {
>>> > +     test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
>>> > +     mkdir -p "${TMP_MOUNT}${m}" || exit 1
>>> > +     mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
>>> > +     ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
>>> > +     umount "${TMP_MOUNT}${m}" || exit 1
>>> > +     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>>> > +}
>>> > +export -f fix_labels_on_mountpoint
>>> > +
>>> >  #
>>> >  # restore
>>> >  # if called with -n will only check file context
>>> > @@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
>>> >               # we bind mount so we can fix the labels of files that have already been
>>> >               # mounted over
>>> >               for m in `echo $FILESYSTEMSRW`; do
>>> > -                 TMP_MOUNT="$(mktemp -d)"
>>> > -                 test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
>>> > -
>>> > -                 mkdir -p "${TMP_MOUNT}${m}" || exit 1
>>> > -                 mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
>>> > -                 ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
>>> > -                 umount "${TMP_MOUNT}${m}" || exit 1
>>> > -                 rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
>>> > +                     TMP_MOUNT="$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
>> 
>> Whitespace issue:
>> 
>> git apply 
>> ~/Downloads/v4-fixfiles-Unmount-temporary-bind-mounts-on-SIGINT.patch
>> /home/christian/Downloads/v4-fixfiles-Unmount-temporary-bind-mounts-on-SIGINT.patch:137:
>> space before tab in indent.
>>                         TMP_MOUNT="$(mktemp -p /run -d 
>> fixfiles.XXXXXXXXXX)"
>> warning: 1 line adds whitespace errors.
>> 
>>> > +                 export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS FC TMP_MOUNT m
>>> > +                 if type unshare &> /dev/null; then
>>> > +                     unshare -m bash -x -c "fix_labels_on_mountpoint" $* || exit $?
>> 
>> Two issues:
>> 
>> I.
>> The `-x` flag make the output unreadable (especially for 
>> check/verify).
> 
> 
> This is leftover from my debugging. It is not supposed to be there.
> 
> 
>> II.
>> The option (e.g. `-n` for check/verify) is not passed, should be `-c
>> "fix_labels_on_mountpoint $*"`.
> 
> I'll fix it.
> 
> 
> Thanks!
> 
> 
>>> > +                 else
>>> > +                     trap umount_TMP_MOUNT EXIT
>>> > +                     fix_labels_on_mountpoint $*
>>> > +                     trap EXIT
>>> > +                 fi
>>> >               done;
>>> >           fi
>>> >       else
>>> > --
>>> > 2.37.3
>>> 

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
