Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE226C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 19:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBFE61059
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 19:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243355AbhIITIr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237617AbhIITIr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Sep 2021 15:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631214456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=8aKy9KlfgbB/iFLYLRQ6GKDKw9yXt5NHM+jFXrJTWp8=;
        b=P9USyDI2WYRpZi+M9FUYrKbCKC6Ta7GOC/UegFtpQu470g0LrqweuMWWU3pYq4lRU2hw16
        3G69k724O/CxlUiM7HCg61UfPn8zatHAK2IRzXuj2DazyfS+N4+wpj0kd94ekwWC4m4pNk
        edZ4pT8UYlFq15eBFiDW207PfMtomKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-7wOvU-3oNKCKV2BZOkAnKQ-1; Thu, 09 Sep 2021 15:07:35 -0400
X-MC-Unique: 7wOvU-3oNKCKV2BZOkAnKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87ED802935
        for <selinux@vger.kernel.org>; Thu,  9 Sep 2021 19:07:34 +0000 (UTC)
Received: from localhost (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40E5B19D9B
        for <selinux@vger.kernel.org>; Thu,  9 Sep 2021 19:07:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Another libsepol USE_AFTER_FREE defects detected
Date:   Thu, 09 Sep 2021 21:07:33 +0200
Message-ID: <877dfpa7pm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

our internal scanner reports the following defects:

Error: USE_AFTER_FREE (CWE-416): [#def1]
libsepol/cil/src/cil_build_ast.c:473: freed_arg: "cil_gen_node" frees "class".
libsepol/cil/src/cil_build_ast.c:480: deref_after_free: Dereferencing freed pointer "class".
#  478|   	if (parse_current->next->next != NULL) {
#  479|   		perms = parse_current->next->next->cl_head;
#  480|-> 		rc = cil_gen_perm_nodes(db, perms, ast_node, CIL_PERM, &class->num_perms);
#  481|   		if (rc != SEPOL_OK) {
#  482|   			goto exit;

Error: USE_AFTER_FREE (CWE-416): [#def2]
libsepol/cil/src/cil_build_ast.c:942: freed_arg: "cil_gen_node" frees "map".
libsepol/cil/src/cil_build_ast.c:947: deref_after_free: Dereferencing freed pointer "map".
#  945|   	}
#  946|   
#  947|-> 	rc = cil_gen_perm_nodes(db, parse_current->next->next->cl_head, ast_node, CIL_MAP_PERM, &map->num_perms);
#  948|   	if (rc != SEPOL_OK) {
#  949|   		goto exit;

Error: USE_AFTER_FREE (CWE-416): [#def3]
libsepol/cil/src/cil_build_ast.c:1042: freed_arg: "cil_gen_node" frees "common".
libsepol/cil/src/cil_build_ast.c:1047: deref_after_free: Dereferencing freed pointer "common".
# 1045|   	}
# 1046|   
# 1047|-> 	rc = cil_gen_perm_nodes(db, parse_current->next->next->cl_head, ast_node, CIL_PERM, &common->num_perms);
# 1048|   	if (rc != SEPOL_OK) {
# 1049|   		goto exit;


They might be related to commit 0d4e568afe5a28edc5fcdcff8e925d4ec1d0d3d0
("libsepol/cil: Create function cil_add_decl_to_symtab() and refactor")

Please take a look.

Thanks,

Petr

