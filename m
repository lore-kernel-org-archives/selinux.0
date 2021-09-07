Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF58C433F5
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 10:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D80E610C8
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 10:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbhIGKj0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231329AbhIGKjQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Sep 2021 06:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631011087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6MG5CgyFtpBCrPS62b9jN6vktz6s2thEEXkLeqmoV3U=;
        b=JbyDfiAKHwGYI6bWOOciULcGjjksu61Wihxp8+aUAVi44S8jj0HAqftSVwnzwxSgMQAntF
        Mt+K8laMxEKql/kPeeYxm7GLMiumnbQ0xxvA1oHwy8DzuA2u3VD5iGMvAF9DBS3hwyRpqX
        9NAeLhlrScDGUTHszlfsDi7Bmu5osaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-clIo7LwYNESpllOgEDRYmw-1; Tue, 07 Sep 2021 06:38:06 -0400
X-MC-Unique: clIo7LwYNESpllOgEDRYmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5DC1107ACC7
        for <selinux@vger.kernel.org>; Tue,  7 Sep 2021 10:38:05 +0000 (UTC)
Received: from localhost (unknown [10.40.193.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 428907621D
        for <selinux@vger.kernel.org>; Tue,  7 Sep 2021 10:38:05 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: PATH_MAX + 1 in realpath_not_final()
Date:   Tue, 07 Sep 2021 12:38:04 +0200
Message-ID: <87czpkacxf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I was asked whether is there a reason for "Resolved path must be a path
of size PATH_MAX + 1" in the comment assigned to real_path_not_final()
in selinux.h [1]?

    /* Resolve all of the symlinks and relative portions of a pathname, but=
 NOT
     * the final component (same a realpath() unless the final component is=
 a
     * symlink.  Resolved path must be a path of size PATH_MAX + 1 */
    extern int realpath_not_final(const char *name, char *resolved_path);


Looking into libselinux/src/matchpathcon.c:

 423 =E2=94=82   len =3D strlen(p);=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
 424 =E2=94=82   if (len + strlen(last_component) + 2 > PATH_MAX) {
 425 =E2=94=82   =E2=94=82   myprintf("symlink_realpath(%s) failed: Filenam=
e too long \n",
 426 =E2=94=82   =E2=94=82   =E2=94=82 name);=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
 427 =E2=94=82   =E2=94=82   errno =3D ENAMETOOLONG;=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
 428 =E2=94=82   =E2=94=82   rc =3D -1;=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
 429 =E2=94=82   =E2=94=82   goto out;=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
 430 =E2=94=82   }


it seems to be that PATH_MAX should be enough? Am I missing something?


[1] https://github.com/SELinuxProject/selinux/blob/master/libselinux/includ=
e/selinux/selinux.h#L493

Thanks,

Petr

