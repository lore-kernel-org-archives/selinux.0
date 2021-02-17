Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A1C433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD9E64E2F
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhBQRQp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234392AbhBQRQn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Feb 2021 12:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613582117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3fZn9BhSNE3RyFSK5zdfPp9A1UFLJka37FhLPiqJGVo=;
        b=PIXiWfnP68Le8obFRMGwEd+oaR+ZPkhRGg4oTgqboHpIOcvg7D7f1m7BzRiQlB2t+pJVNu
        nMaO4MPzqbBi+b+y1DvVCYwXt5u55ks3RFGXpKlcDIwYa4YGq3Xi9S1s5Y1smZw58+9447
        aWoYzDeX7xhZ1vSjSRQTjml3i4hpQiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-WOUM7hqjOM6SiwzMXEMapA-1; Wed, 17 Feb 2021 12:15:15 -0500
X-MC-Unique: WOUM7hqjOM6SiwzMXEMapA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 994AC107ACF9;
        Wed, 17 Feb 2021 17:15:14 +0000 (UTC)
Received: from localhost (unknown [10.40.194.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DB655D9C2;
        Wed, 17 Feb 2021 17:15:13 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 2/2] policycoreutils/fixfiles.8: add missing file
 systems and merge check and verify
In-Reply-To: <20210203171654.37002-2-cgzones@googlemail.com>
References: <20210203171654.37002-1-cgzones@googlemail.com>
 <20210203171654.37002-2-cgzones@googlemail.com>
Date:   Wed, 17 Feb 2021 18:15:13 +0100
Message-ID: <87wnv6fwf2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Mention the supported file systems ext4, gfs2 and btrfs.
>
> The options check and verify are interchangeable, merge their
> description.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  policycoreutils/scripts/fixfiles.8 | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts=
/fixfiles.8
> index 12342530..c4e894e5 100644
> --- a/policycoreutils/scripts/fixfiles.8
> +++ b/policycoreutils/scripts/fixfiles.8
> @@ -35,8 +35,8 @@ database (extended attributes) on filesystems.
>  .P
>  It can also be run at any time to relabel when adding support for
>  new policy, or  just check whether the file contexts are all
> -as you expect.  By default it will relabel all mounted ext2, ext3, xfs a=
nd=20
> -jfs file systems as long as they do not have a security context mount=20
> +as you expect.  By default it will relabel all mounted ext2, ext3, ext4,=
 gfs2, xfs,
> +jfs and btrfs file systems as long as they do not have a security contex=
t mount
>  option.  You can use the \-R flag to use rpmpackages as an alternative.
>  The file /etc/selinux/fixfiles_exclude_dirs can contain a list of direct=
ories
>  excluded from relabeling.
> @@ -79,7 +79,7 @@ Modify verbosity from progress to verbose. (Run restore=
con with \-v instead of \
>  .SH "ARGUMENTS"
>  One of:
>  .TP=20
> -.B check
> +.B check | verify
>  print any incorrect file context labels, showing old and new context, bu=
t do not change them.
>  .TP=20
>  .B restore
> @@ -88,9 +88,6 @@ change any incorrect file context labels.
>  .B relabel
>  Prompt for removal of contents of /tmp directory and then change any inc=
orrect file context labels to match the install file_contexts file.
>  .TP=20
> -.B verify
> -List out files with incorrect file context labels, but do not change the=
m.
> -.TP=20
>  .B [[dir/file] ... ]=20
>  List of files or directories trees that you wish to check file context o=
n.
>=20=20
> --=20
> 2.30.0

