Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99063C433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443EE64DA1
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBXRbG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229594AbhBXRbG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 12:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614187779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xh5UJwKO2kWpTqnBpP1DbAiOIirAn7h+Gdr5+eFDoy4=;
        b=XFPdgY8aXbNbZWwpfqtNHy9iCl0xOLMySMI8/bBY8tTm5qvZLnhErzkd7vTuvp8FEK2kYt
        eQBru/+Eg4MDTvWvYPedNvPo3/NOph2zYsx53tFyYPckFkPAn7O2NSiyVfw7xuu2IQ7p9w
        SVxyceDpzqQsqZuruCgzmznGa8nLPzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-_MOr37LhO0epPI9nRg9rJA-1; Wed, 24 Feb 2021 12:29:36 -0500
X-MC-Unique: _MOr37LhO0epPI9nRg9rJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A88A427DF
        for <selinux@vger.kernel.org>; Wed, 24 Feb 2021 17:29:35 +0000 (UTC)
Received: from localhost (unknown [10.40.193.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD3DF6E515
        for <selinux@vger.kernel.org>; Wed, 24 Feb 2021 17:29:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: ANN: SELinux userspace 3.2-rc3 release candidate - the last one
In-Reply-To: <87v9ah1nbh.fsf@redhat.com>
References: <87v9ah1nbh.fsf@redhat.com>
Date:   Wed, 24 Feb 2021 18:29:33 +0100
Message-ID: <87pn0p1iiq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

According to my notes, there's only one patch waiting for review

https://patchwork.kernel.org/patch/12100445/

After few days when it's merged I'd like to push 3.2 release

If you have any comment or objection or missing fix or missing release
notes, please let us know.

Thanks,

Petr


> Hello,
>
> A 3.2-rc3 release candidate for the SELinux userspace is now=20
> available at:
>
> https://github.com/SELinuxProject/selinux/wiki/Releases
>
> Please give it a test and let us know if there are any issues.
>
> If there are specific changes that you think should be called out=20
> in release notes for packagers and users in the final release
> announcement, let us know.=20
>
> Thanks to all the contributors to this release candidate!
>
> User-visible changes since 3.2-rc2
> ----------------------------------
>
> * Improved secilc documentation - fenced code blocks, syntax highlighting=
, custom
>   color theme, ...
>
> * Better error reporting in getconlist
>
> * Improved selinux(8,5) and fixiles(8) man pages
>
> * Bug fixes
>
> Packaging-relevant changes since 3.2-rc2
> ----------------------------------------
>
> * sestatus is installed as /usr/bin/sestatus by default. Original /usr/sb=
in/sestatus is
>   a relative symlink to the /usr/bin/sestatus.
>
>
> Shortlog of changes since the 3.2-rc2 release
> -----------------------------------------------
> Christian G=C3=B6ttsche (3):
>       libselinux/getconlist: report failures
>       policycoreutils/fixfiles.8: add missing file systems and merge chec=
k and verify
>       libsepol/cil: handle SID without assigned context when writing poli=
cy.conf
>
> Dominick Grift (1):
>       secilc: fixes cil_role_statements.md example
>
> James Carter (4):
>       libsepol/cil: Fix integer overflow in the handling of hll line marks
>       libsepol/cil: Destroy disabled optional blocks after pass is comple=
te
>       libsepol: Create function ebitmap_highest_set_bit()
>       libsepol: Validate policydb values when reading binary policy
>
> Nicolas Iooss (7):
>       libsepol: remove unused files
>       libsepol: uniformize prototypes of sepol_mls_contains and sepol_mls=
_check
>       libsepol: include header files in source files when matching declar=
ations
>       libsepol/cil: fix NULL pointer dereference with empty macro argument
>       libsepol/cil: be more robust when encountering <src_info>
>       libsepol/cil: introduce intermediate cast to silence -Wvoid-pointer=
-to-enum-cast
>       libselinux: rename gettid() to something which never conflicts with=
 the libc
>
> Petr Lautrbach (3):
>       libselinux: fix segfault in add_xattr_entry()
>       policycoreutils: Resolve path in restorecon_xattr
>       Update VERSIONs to 3.2-rc3 for release.
>
> Vit Mojzis (2):
>       selinux(8,5): Describe fcontext regular expressions
>       gui: fix "file type" selection in fcontextPage
>
> bauen1 (4):
>       secilc/docs: use fenced code blocks for cil examples
>       secilc/docs: add syntax highlighting for secil
>       secilc/docs: add custom color theme
>       policycoreutils: sestatus belongs to bin not sbin

