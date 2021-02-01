Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34D0C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820A064DD6
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhBAOAc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:00:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231422AbhBAOAa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 09:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612187943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0VWoum1lWYQvGy4e4UAOMnhDMvDWAdmuiD9wCmT9hQ0=;
        b=Jw8NiEqxOTW0ZAcTcW6o0x0aB7exl6h6HOvo36x69zuOYoeSLh1h0XN7ZrOwn1uXhBEIAM
        UFeNqMuoKWOq7snztddHtE6wYAHXnLWOqPr/tgI4q33xliChWSqXtVkpgzo9ogdS+caY88
        6sujmDiQbtx3YP38kPiilGNvAzjqp8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-oy1vDy0KPke2unXXihXZCg-1; Mon, 01 Feb 2021 08:59:00 -0500
X-MC-Unique: oy1vDy0KPke2unXXihXZCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CF49800D53;
        Mon,  1 Feb 2021 13:58:59 +0000 (UTC)
Received: from localhost (unknown [10.40.192.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E5D61975E;
        Mon,  1 Feb 2021 13:58:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] scripts/release: Release also tarball with everything
In-Reply-To: <CAJfZ7=mJ7-RCXFO1iDDmaUJx24xmd6-+-ERmi1J7w82Kb3hi7A@mail.gmail.com>
References: <20210129200034.205263-1-plautrba@redhat.com>
 <CAJfZ7=mJ+=tPA8aZzmxhgRqR-incXW8qztibPPQ=RSkc2pS_kQ@mail.gmail.com>
 <87bld5o1te.fsf@redhat.com>
 <CAJfZ7=mJ7-RCXFO1iDDmaUJx24xmd6-+-ERmi1J7w82Kb3hi7A@mail.gmail.com>
Date:   Mon, 01 Feb 2021 14:58:56 +0100
Message-ID: <87sg6fsxcv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Sun, Jan 31, 2021 at 11:09 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>>
>> > On Fri, Jan 29, 2021 at 9:06 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>> >>
>> >> Create and publish with sha256sum also tarball called
>> >> selinux-$VERS.tar.gz with the whole tree. It could be useful for unit
>> >> testing directly from tarball or backporting patches which affects more
>> >> subdirectories. Github already provides similar archive called "Source
>> >> code (tar.gz)" via release assets, but there's no guarantee this file
>> >> would not change.
>> >>
>> >> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> >> ---
>> >>  scripts/release | 23 ++++++++++++++++++++---
>> >>  1 file changed, 20 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/scripts/release b/scripts/release
>> >> index 895a0e1ca1a1..40a9c06f56b9 100755
>> >> --- a/scripts/release
>> >> +++ b/scripts/release
>> >> @@ -35,6 +35,8 @@ for i in $DIRS_NEED_PREFIX; do
>> >>         cd ..
>> >>  done
>> >>
>> >> +git archive -o $DEST/selinux-$VERS.tar.gz --prefix=selinux-$VERS/ $VERS
>> >> +
>> >>  cd $DEST
>> >>
>> >>  git add .
>> >> @@ -54,13 +56,28 @@ echo ""
>> >>  echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
>> >>  echo ""
>> >>
>> >> -for i in *.tar.gz; do
>> >> +for i in $DIRS; do
>> >> +       tarball=$i-$VERS.tar.gz
>> >> +       echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
>> >> +       sha256sum $tarball | cut -d " " -f 1
>> >> +       echo ""
>> >> +done
>> >>
>> >> -       echo -n "[$i](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$i) "
>> >> -       sha256sum $i | cut -d " " -f 1
>> >> +for i in $DIRS_NEED_PREFIX; do
>> >> +       tarball=selinux-$i-$VERS.tar.gz
>> >> +       echo -n "[$tarball](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$tarball) "
>> >> +       sha256sum $tarball | cut -d " " -f 1
>> >>         echo ""
>> >>  done
>> >>
>> >> +echo "### Everything"
>> >> +
>> >> +echo ""
>> >> +
>> >> +echo -n "[selinux-$VERS.tar.gz](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/selinux-$VERS.tar.gz) "
>> >> +sha256sum selinux-$VERS.tar.gz | cut -d " " -f 1
>> >> +echo ""
>> >
>> > Hello, there are at least two issues here:
>> > * The section is named "Everything" but on
>> > https://github.com/SELinuxProject/selinux/wiki/Releases it is named
>> > "All in one". What is the proper name?
>>
>>
>> I used "All in one" in rc1 release but I didn't announce it properly and
>> it didn't feel good to me. So I sent this patch to make this official.
>> And I like "Everything" more than the original "All in one". I can
>> change it on the release page if the change is accepted or drop it
>> completely if it's denied.
>
> I find "Everything" to be quite unclear, because for example the
> archive does not contain the git history... What about "Source
> repository snapshot", which better describes what the archive really
> is? This is a personal opinion and I am also fine with keeping
> "Everything" if you do not like my suggestion.

"Source repository snapshot" works for me.

>> > * $VERS comes from a VERSION file in a subdirectory. It would be more
>> > consistent to either use $RELEASE_TAG (which is the content of the
>> > main VERSION file) or to use a single $VERS variable (and to verify
>> > that the */VERSION files all contain the same content, for example
>> > with "diff VERSION $i/VERSION"). Which option would be preferable?
>>
>> For now I'd use $RELEASE_TAG for selinux-X.Y.tar.gz
>>
>> and maybe something like:
>>
>> -for i in $DIRS; do
>> -       tarball=$i-$VERS.tar.gz
>> +for i in $DIRS; do
>> +       tarball=`ls $i-*.tar.gz`
>
> I do not like using wildcard patterns. In the patch I sent
> (https://lore.kernel.org/selinux/20210130133313.1759011-1-nicolas.iooss@m4x.org/)
> I replaced this part with reading $i/VERSION again:
>
> +for COMPONENT in "${DIRS[@]}"; do
> + DIR="${COMPONENT#selinux-}"
> + VERS="$(cat "$DIR/VERSION")"
> + TAG="$COMPONENT-$VERS"
> + tarball="$TAG.tar.gz"
>
> Nevertheless the script is currently using wildcards and your
> suggestion works, so you can use `ls $i-*.tar.gz` and I will then
> propose a new version of my patch to remove this. Or you can include
> my changes in your patch, if you agree with them. How do you want to
> proceed?

I like your patch and I don't think it's neccessary to apply both. Let's
drop mine proposal. Please merge my changes into yours and update the
patch with "Source repository snapshot"

Thanks!





>
> Thanks,
> Nicolas

