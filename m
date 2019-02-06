Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD10CC169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD9F206C2
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 08:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBFIF4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:05:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfBFIF4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Feb 2019 03:05:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 564922D80A;
        Wed,  6 Feb 2019 08:05:56 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0C415C207;
        Wed,  6 Feb 2019 08:05:55 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] scripts/release: Update links to use release assets instead of wiki links
References: <20190131134812.20440-1-plautrba@redhat.com>
        <CAJfZ7=nW+1DnK1T0-0eDuzP48L26B2yMUA44VWfsnxMVEd_k4Q@mail.gmail.com>
Date:   Wed, 06 Feb 2019 09:05:54 +0100
In-Reply-To: <CAJfZ7=nW+1DnK1T0-0eDuzP48L26B2yMUA44VWfsnxMVEd_k4Q@mail.gmail.com>
        (Nicolas Iooss's message of "Sun, 3 Feb 2019 23:23:48 +0100")
Message-ID: <pjdva1xz6hp.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 06 Feb 2019 08:05:56 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Jan 31, 2019 at 2:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> - new release files are created in release/$RELEASE_TAG
>> - download links refers to new release assets
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> I have created packages for 2.9-rc1 for Arch Linux without any
> trouble, using the information from the GitHub release page and the
> generated wiki page
> (https://github.com/SELinuxProject/selinux/wiki/Releases).
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

>> ---
>>  scripts/release | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/release b/scripts/release
>> index ad10d557..07813749 100755
>> --- a/scripts/release
>> +++ b/scripts/release
>> @@ -7,11 +7,12 @@ if [ \! -d $WIKIDIR ]; then
>>      git clone git@github.com:SELinuxProject/selinux.wiki.git $WIKIDIR
>>  fi
>>
>> -DEST=$WIKIDIR/files/releases/$(date '+%Y%m%d')
>> +RELEASE_TAG=$(date '+%Y%m%d')
>> +DEST=releases/$RELEASE_TAG
>>  DIRS="libsepol libselinux libsemanage checkpolicy secilc policycoreutils mcstrans restorecond semodule-utils"
>>  DIRS_NEED_PREFIX="dbus gui python sandbox"
>>
>> -git tag -a $(date '+%Y%m%d') -m "Release $(date '+%Y%m%d')"
>> +git tag -a $RELEASE_TAG -m "Release $RELEASE_TAG"
>>
>>  rm -rf $DEST
>>  mkdir -p $DEST
>> @@ -44,19 +45,34 @@ echo ""
>>
>>  echo "## Release $(date '+%Y-%m-%d')"
>>
>> +echo ""
>> +
>> +echo "[Release Notes](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/RELEASE-$RELEASE_TAG.txt)"
>> +echo ""
>> +echo "[full log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/log-$RELEASE_TAG.txt)"
>> +echo ""
>> +echo "[short log](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/shortlog-$RELEASE_TAG.txt)"
>> +echo ""
>> +
>>  for i in *.tar.gz; do
>>
>> -       echo -n "[$i](https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/files/releases/$(date '+%Y%m%d')/$i) "
>> +       echo -n "[$i](https://github.com/SELinuxProject/selinux/releases/download/$RELEASE_TAG/$i) "
>>         sha256sum $i | cut -d " " -f 1
>>         echo ""
>>  done
>>
>>  echo "And then run:"
>>  echo "  cd $WIKIDIR"
>> -echo "  git commit  -m \"Release $(date '+%Y%m%d')\" -a -s"
>> +echo "  git commit  -m \"Release $RELEASE_TAG\" -a -s"
>>  echo "  git push"
>>
>>  echo ""
>>  echo "Push the release and its tags to git via:"
>>  echo "  git push"
>>  echo "  git push --tags"
>> +
>> +echo ""
>> +echo "Create a new release from the latest tag on https://github.com/SELinuxProject/selinux/tags"
>> +
>> +echo ""
>> +echo "Add files from releases/$RELEASE_TAG as assets to the new github release"
>> --
>> 2.20.1
>>
