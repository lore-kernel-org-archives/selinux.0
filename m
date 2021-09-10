Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DAC433EF
	for <selinux@archiver.kernel.org>; Fri, 10 Sep 2021 06:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A926113A
	for <selinux@archiver.kernel.org>; Fri, 10 Sep 2021 06:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhIJGEq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Sep 2021 02:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230417AbhIJGEn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Sep 2021 02:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631253811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKxvWdX44oxtHRq0WHqtV6VX+8CdgY8McjrxBroq5BI=;
        b=e/Ddt2uRFkLWha0V8UrWsj6f/Ym3IfKHo/IRaDD3gFGXz76yPiflQGEr4VJXHiQ1aHOHDt
        dysuLdg/gYz6ZxxA5xJl/UEKc+HzY8hqp5qGulwpP9B2pSidfYIbhM7AVzNIJ4hGWcjMbU
        XdrQn0K3gsWvzZxGKzcLbHAQPhOHUwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-5_u56bF9OYSczfLY_fY8LA-1; Fri, 10 Sep 2021 02:03:29 -0400
X-MC-Unique: 5_u56bF9OYSczfLY_fY8LA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374D41808304;
        Fri, 10 Sep 2021 06:03:28 +0000 (UTC)
Received: from localhost (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C865B60C04;
        Fri, 10 Sep 2021 06:03:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: Another libsepol USE_AFTER_FREE defects detected
In-Reply-To: <CAP+JOzSsZzgAdHX7Tknx9vaQZiecn8fjSGmyU9RxK9rGUpLABw@mail.gmail.com>
References: <877dfpa7pm.fsf@redhat.com>
 <CAP+JOzSsZzgAdHX7Tknx9vaQZiecn8fjSGmyU9RxK9rGUpLABw@mail.gmail.com>
Date:   Fri, 10 Sep 2021 08:03:26 +0200
Message-ID: <874kat9dch.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Thu, Sep 9, 2021 at 3:10 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Hello,
>>
>> our internal scanner reports the following defects:
>>
>> Error: USE_AFTER_FREE (CWE-416): [#def1]
>> libsepol/cil/src/cil_build_ast.c:473: freed_arg: "cil_gen_node" frees "class".
>> libsepol/cil/src/cil_build_ast.c:480: deref_after_free: Dereferencing freed pointer "class".
>> #  478|         if (parse_current->next->next != NULL) {
>> #  479|                 perms = parse_current->next->next->cl_head;
>> #  480|->               rc = cil_gen_perm_nodes(db, perms, ast_node, CIL_PERM, &class->num_perms);
>> #  481|                 if (rc != SEPOL_OK) {
>> #  482|                         goto exit;
>>
>> Error: USE_AFTER_FREE (CWE-416): [#def2]
>> libsepol/cil/src/cil_build_ast.c:942: freed_arg: "cil_gen_node" frees "map".
>> libsepol/cil/src/cil_build_ast.c:947: deref_after_free: Dereferencing freed pointer "map".
>> #  945|         }
>> #  946|
>> #  947|->       rc = cil_gen_perm_nodes(db, parse_current->next->next->cl_head, ast_node, CIL_MAP_PERM, &map->num_perms);
>> #  948|         if (rc != SEPOL_OK) {
>> #  949|                 goto exit;
>>
>> Error: USE_AFTER_FREE (CWE-416): [#def3]
>> libsepol/cil/src/cil_build_ast.c:1042: freed_arg: "cil_gen_node" frees "common".
>> libsepol/cil/src/cil_build_ast.c:1047: deref_after_free: Dereferencing freed pointer "common".
>> # 1045|         }
>> # 1046|
>> # 1047|->       rc = cil_gen_perm_nodes(db, parse_current->next->next->cl_head, ast_node, CIL_PERM, &common->num_perms);
>> # 1048|         if (rc != SEPOL_OK) {
>> # 1049|                 goto exit;
>>
>>
>> They might be related to commit 0d4e568afe5a28edc5fcdcff8e925d4ec1d0d3d0
>> ("libsepol/cil: Create function cil_add_decl_to_symtab() and refactor")
>>
>> Please take a look.
>>
>
> These are false positives. The only time the datum passed to
> cil_gen_node() gets freed is when the declaration is a duplicate and
> duplicate declarations are allowed and the datum is a type, type
> attribute, or an optional.
>
> It would probably be better, however, to pass the SEPOL_EEXIST back to
> the calling function and to free the datum there.
>
> Jim
>

Thanks!

Petr

