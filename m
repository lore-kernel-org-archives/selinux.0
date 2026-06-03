Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41C43D4E3
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479502; cv=none; b=Bw4zhLfsog1ef/0TYhmaReGHvGLYFVkqqMyA87vTFle5v/fy7YFqwVY19cp7j6eyf4q0ZN1HNKc6xvfHangISF6j33oGP/CEWIL7+UAx3sZu6WMFmH5pv+4BODTCoKkp0bB8/qZFZ2pxusWtRjfbYSP6R/Y8A1BV9SCwxPmTbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479502; c=relaxed/simple;
	bh=zWl9dXbJkPfV9HTsyWEypfzafCZqC6NHezJFBFWK5go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=mwkhX+PNalfKwsjrgQbB3JPoCxHSMABMp5QvIv5OcIeEIKK0EHpaEY2CdP4771R+IjhCbO7ontDoAZK9+8UU3U58WBxgAMO0ksnf2VTi3VEkxf3Y5J7emRX2MXVU9wZ7FUdX74XIdhcISUCk9lk+v2lsFW8zP7CtqJm2AMqSBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwJd0GWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwJd0GWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780479495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zl8tTgLTK3tXI6/eFEQZIRhAOrK1SgIYX5hIF3A/lVY=;
	b=RwJd0GWmdSqEkninaTufK2GEw/diJk31Jv/zmW65bGoNyurE7z6wxe+9QxMLweXOHmQEf9
	4YfBbI1uLQz22qtZo11S67aAswOd5yc782h1H2vV2UaN7F0M6fH4/0DX1llktslyiJGc1f
	srYUs9FxN+6Y3zMWMezZVyfW0mruuTg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-RvQAmTTTMHWybylqoyTxjw-1; Wed,
 03 Jun 2026 05:38:13 -0400
X-MC-Unique: RvQAmTTTMHWybylqoyTxjw-1
X-Mimecast-MFC-AGG-ID: RvQAmTTTMHWybylqoyTxjw_1780479492
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3226195608E
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 09:38:12 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.201])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BE4630001A1;
	Wed,  3 Jun 2026 09:38:11 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 1/2] Reformat all the code based on .clang-format
Date: Wed,  3 Jun 2026 11:33:28 +0200
Message-ID: <20260603093801.1070705-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Commit 0a6b917da08f ("treewide: add .clang-format configuration file")
added .clang-format configuration file from Linux kernel which allows to
make formatting consistent.

For this patch `make format` to reformat all sources. In future it's
expected that new contribution will be checked using `make check-format`
to keep the consistent formatting.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---

The patch is big and is available at https://github.com/SELinuxProject/selinux/pull/520

https://github.com/SELinuxProject/selinux/commit/184a4b9dc681c21e3f6459d8a02cce8ceb244fa7

 checkpolicy/checkmodule.c                     |   109 +-
 checkpolicy/checkpolicy.c                     |   502 +-
 checkpolicy/fuzz/checkpolicy-fuzzer.c         |    39 +-
 checkpolicy/module_compiler.c                 |   265 +-
 checkpolicy/module_compiler.h                 |    26 +-
 checkpolicy/parse_util.c                      |     5 +-
 checkpolicy/parse_util.h                      |     2 +-
 checkpolicy/policy_define.c                   |  1187 +-
 checkpolicy/policy_define.h                   |     6 +-
 checkpolicy/queue.c                           |    13 +-
 checkpolicy/queue.h                           |     7 +-
 checkpolicy/test/dismod.c                     |   361 +-
 checkpolicy/test/dispol.c                     |   181 +-
 .../fuzz/selabel_file_compiled-fuzzer.c       |    44 +-
 libselinux/fuzz/selabel_file_text-fuzzer.c    |    34 +-
 libselinux/include/selinux/avc.h              |   104 +-
 libselinux/include/selinux/context.h          |    32 +-
 libselinux/include/selinux/get_context_list.h |    46 +-
 libselinux/include/selinux/get_default_type.h |     6 +-
 libselinux/include/selinux/label.h            |    75 +-
 libselinux/include/selinux/restorecon.h       |    50 +-
 libselinux/include/selinux/selinux.h          |   337 +-
 libselinux/src/audit2why.c                    |   217 +-
 libselinux/src/avc.c                          |   228 +-
 libselinux/src/avc_internal.c                 |    63 +-
 libselinux/src/avc_internal.h                 |   100 +-
 libselinux/src/avc_sidtab.c                   |    26 +-
 libselinux/src/avc_sidtab.h                   |    17 +-
 libselinux/src/booleans.c                     |    41 +-
 libselinux/src/callbacks.c                    |    51 +-
 libselinux/src/callbacks.h                    |    34 +-
 libselinux/src/canonicalize_context.c         |    14 +-
 libselinux/src/checkAccess.c                  |    61 +-
 libselinux/src/check_context.c                |     8 +-
 libselinux/src/checkreqprot.c                 |     1 -
 libselinux/src/compute_av.c                   |    54 +-
 libselinux/src/compute_create.c               |    54 +-
 libselinux/src/compute_member.c               |    21 +-
 libselinux/src/compute_relabel.c              |    21 +-
 libselinux/src/compute_user.c                 |    16 +-
 libselinux/src/context.c                      |    72 +-
 libselinux/src/context_internal.h             |     1 -
 libselinux/src/deny_unknown.c                 |     1 -
 libselinux/src/disable.c                      |     1 -
 libselinux/src/enabled.c                      |     2 -
 libselinux/src/fgetfilecon.c                  |    13 +-
 libselinux/src/file_path_suffixes.h           |    66 +-
 libselinux/src/freecon.c                      |     3 +-
 libselinux/src/freeconary.c                   |     3 +-
 libselinux/src/fsetfilecon.c                  |    17 +-
 libselinux/src/get_context_list.c             |    92 +-
 libselinux/src/get_context_list_internal.h    |     1 -
 libselinux/src/get_default_type.c             |     4 +-
 libselinux/src/get_default_type_internal.h    |     1 -
 libselinux/src/get_initial_context.c          |    13 +-
 libselinux/src/getenforce.c                   |     1 -
 libselinux/src/getfilecon.c                   |    10 +-
 libselinux/src/getpeercon.c                   |     9 +-
 libselinux/src/init.c                         |    16 +-
 libselinux/src/is_customizable_type.c         |     6 +-
 libselinux/src/label.c                        |    45 +-
 libselinux/src/label_backends_android.c       |    82 +-
 libselinux/src/label_db.c                     |    97 +-
 libselinux/src/label_file.c                   |   932 +-
 libselinux/src/label_file.h                   |   266 +-
 libselinux/src/label_internal.h               |   106 +-
 libselinux/src/label_media.c                  |    23 +-
 libselinux/src/label_support.c                |    25 +-
 libselinux/src/label_x.c                      |    16 +-
 libselinux/src/lgetfilecon.c                  |     9 +-
 libselinux/src/load_policy.c                  |   100 +-
 libselinux/src/lsetfilecon.c                  |    13 +-
 libselinux/src/mapping.c                      |    81 +-
 libselinux/src/mapping.h                      |    18 +-
 libselinux/src/matchmediacon.c                |     5 +-
 libselinux/src/matchpathcon.c                 |   138 +-
 libselinux/src/policyvers.c                   |     1 -
 libselinux/src/procattr.c                     |   117 +-
 libselinux/src/query_user_context.c           |    39 +-
 libselinux/src/regex.c                        |    62 +-
 libselinux/src/regex.h                        |    33 +-
 libselinux/src/reject_unknown.c               |     1 -
 .../src/selinux_check_securetty_context.c     |     2 +-
 libselinux/src/selinux_config.c               |   147 +-
 libselinux/src/selinux_internal.c             |     1 -
 libselinux/src/selinux_internal.h             |   121 +-
 libselinux/src/selinux_netlink.h              |     8 +-
 libselinux/src/selinux_restorecon.c           |   435 +-
 libselinux/src/sestatus.c                     |    68 +-
 libselinux/src/setenforce.c                   |     1 -
 libselinux/src/setexecfilecon.c               |     9 +-
 libselinux/src/setfilecon.c                   |    13 +-
 libselinux/src/setrans_client.c               |    80 +-
 libselinux/src/setrans_internal.h             |     9 +-
 libselinux/src/seusers.c                      |    89 +-
 libselinux/src/sha1.c                         |   339 +-
 libselinux/src/sha1.h                         |    37 +-
 libselinux/src/stringrep.c                    |    45 +-
 libselinux/src/validatetrans.c                |    17 +-
 libselinux/utils/avcstat.c                    |    33 +-
 libselinux/utils/compute_av.c                 |     9 +-
 libselinux/utils/compute_create.c             |    12 +-
 libselinux/utils/compute_member.c             |     6 +-
 libselinux/utils/compute_relabel.c            |     6 +-
 libselinux/utils/getconlist.c                 |    17 +-
 libselinux/utils/getdefaultcon.c              |    41 +-
 libselinux/utils/getenforce.c                 |     7 +-
 libselinux/utils/getfilecon.c                 |     4 +-
 libselinux/utils/getpidcon.c                  |     3 +-
 libselinux/utils/getpidprevcon.c              |     3 +-
 libselinux/utils/getpolicyload.c              |    12 +-
 libselinux/utils/getsebool.c                  |     8 +-
 libselinux/utils/getseuser.c                  |    14 +-
 libselinux/utils/matchpathcon.c               |    33 +-
 libselinux/utils/policyvers.c                 |     5 +-
 libselinux/utils/sefcontext_compile.c         |   135 +-
 libselinux/utils/selabel_compare.c            |    24 +-
 libselinux/utils/selabel_digest.c             |    51 +-
 .../selabel_get_digests_all_partial_matches.c |    36 +-
 libselinux/utils/selabel_lookup.c             |    24 +-
 libselinux/utils/selabel_lookup_best_match.c  |    30 +-
 libselinux/utils/selabel_partial_match.c      |    17 +-
 libselinux/utils/selinux_check_access.c       |    12 +-
 .../utils/selinux_check_securetty_context.c   |     2 +-
 libselinux/utils/selinuxexeccon.c             |    22 +-
 libselinux/utils/setenforce.c                 |     5 +-
 libselinux/utils/togglesebool.c               |     9 +-
 libselinux/utils/validatetrans.c              |    15 +-
 libsemanage/example/test_fcontext.c           |    32 +-
 libsemanage/include/semanage/boolean_record.h |    43 +-
 .../include/semanage/booleans_active.h        |    30 +-
 libsemanage/include/semanage/booleans_local.h |    34 +-
 .../include/semanage/booleans_policy.h        |    22 +-
 libsemanage/include/semanage/context_record.h |    47 +-
 libsemanage/include/semanage/debug.h          |    22 +-
 .../include/semanage/fcontext_record.h        |    72 +-
 .../include/semanage/fcontexts_local.h        |    35 +-
 .../include/semanage/fcontexts_policy.h       |    30 +-
 libsemanage/include/semanage/handle.h         |    52 +-
 .../include/semanage/ibendport_record.h       |    16 +-
 .../include/semanage/ibendports_local.h       |     8 +-
 .../include/semanage/ibendports_policy.h      |    11 +-
 libsemanage/include/semanage/ibpkey_record.h  |    13 +-
 libsemanage/include/semanage/ibpkeys_local.h  |     8 +-
 libsemanage/include/semanage/ibpkeys_policy.h |    11 +-
 libsemanage/include/semanage/iface_record.h   |    58 +-
 .../include/semanage/interfaces_local.h       |    34 +-
 .../include/semanage/interfaces_policy.h      |    22 +-
 libsemanage/include/semanage/modules.h        |    25 +-
 libsemanage/include/semanage/node_record.h    |    91 +-
 libsemanage/include/semanage/nodes_local.h    |    34 +-
 libsemanage/include/semanage/nodes_policy.h   |    22 +-
 libsemanage/include/semanage/port_record.h    |    54 +-
 libsemanage/include/semanage/ports_local.h    |    34 +-
 libsemanage/include/semanage/ports_policy.h   |    22 +-
 libsemanage/include/semanage/seuser_record.h  |    52 +-
 libsemanage/include/semanage/seusers_local.h  |    34 +-
 libsemanage/include/semanage/seusers_policy.h |    24 +-
 libsemanage/include/semanage/user_record.h    |    75 +-
 libsemanage/include/semanage/users_local.h    |    34 +-
 libsemanage/include/semanage/users_policy.h   |    22 +-
 libsemanage/src/boolean_internal.h            |    20 +-
 libsemanage/src/boolean_record.c              |    62 +-
 libsemanage/src/booleans_active.c             |    35 +-
 libsemanage/src/booleans_activedb.c           |    39 +-
 libsemanage/src/booleans_file.c               |    37 +-
 libsemanage/src/booleans_local.c              |    41 +-
 libsemanage/src/booleans_policy.c             |    28 +-
 libsemanage/src/booleans_policydb.c           |    31 +-
 libsemanage/src/compressed_file.c             |    69 +-
 libsemanage/src/compressed_file.h             |     4 +-
 libsemanage/src/context_record.c              |    61 +-
 libsemanage/src/database.c                    |    75 +-
 libsemanage/src/database.h                    |   124 +-
 libsemanage/src/database_activedb.c           |    34 +-
 libsemanage/src/database_activedb.h           |    19 +-
 libsemanage/src/database_file.c               |    34 +-
 libsemanage/src/database_file.h               |    21 +-
 libsemanage/src/database_join.c               |    44 +-
 libsemanage/src/database_join.h               |    23 +-
 libsemanage/src/database_llist.c              |   114 +-
 libsemanage/src/database_llist.h              |    82 +-
 libsemanage/src/database_policydb.c           |   195 +-
 libsemanage/src/database_policydb.h           |    83 +-
 libsemanage/src/debug.c                       |    45 +-
 libsemanage/src/debug.h                       |    65 +-
 libsemanage/src/direct_api.c                  |   936 +-
 libsemanage/src/direct_api.h                  |     1 -
 libsemanage/src/fcontext_internal.h           |    14 +-
 libsemanage/src/fcontext_record.c             |   117 +-
 libsemanage/src/fcontexts_file.c              |    43 +-
 libsemanage/src/fcontexts_local.c             |    65 +-
 libsemanage/src/fcontexts_policy.c            |    33 +-
 libsemanage/src/genhomedircon.c               |   347 +-
 libsemanage/src/genhomedircon.h               |     5 +-
 libsemanage/src/handle.c                      |    84 +-
 libsemanage/src/handle.h                      |   161 +-
 libsemanage/src/ibendport_internal.h          |     5 +-
 libsemanage/src/ibendport_record.c            |    30 +-
 libsemanage/src/ibendports_file.c             |    30 +-
 libsemanage/src/ibendports_local.c            |    24 +-
 libsemanage/src/ibendports_policy.c           |    10 +-
 libsemanage/src/ibendports_policydb.c         |    12 +-
 libsemanage/src/ibpkey_internal.h             |     5 +-
 libsemanage/src/ibpkey_record.c               |    34 +-
 libsemanage/src/ibpkeys_file.c                |    28 +-
 libsemanage/src/ibpkeys_local.c               |    42 +-
 libsemanage/src/ibpkeys_policy.c              |     3 +-
 libsemanage/src/ibpkeys_policydb.c            |    12 +-
 libsemanage/src/iface_internal.h              |    14 +-
 libsemanage/src/iface_record.c                |    81 +-
 libsemanage/src/interfaces_file.c             |    53 +-
 libsemanage/src/interfaces_local.c            |    39 +-
 libsemanage/src/interfaces_policy.c           |    28 +-
 libsemanage/src/interfaces_policydb.c         |    30 +-
 libsemanage/src/modules.c                     |   328 +-
 libsemanage/src/modules.h                     |    22 +-
 libsemanage/src/node_internal.h               |    18 +-
 libsemanage/src/node_record.c                 |   126 +-
 libsemanage/src/nodes_file.c                  |    46 +-
 libsemanage/src/nodes_local.c                 |    42 +-
 libsemanage/src/nodes_policy.c                |    28 +-
 libsemanage/src/nodes_policydb.c              |    29 +-
 libsemanage/src/parse_utils.c                 |   103 +-
 libsemanage/src/parse_utils.h                 |    53 +-
 libsemanage/src/policy.h                      |    61 +-
 libsemanage/src/policy_components.c           |    82 +-
 libsemanage/src/port_internal.h               |    18 +-
 libsemanage/src/port_record.c                 |    88 +-
 libsemanage/src/ports_file.c                  |    47 +-
 libsemanage/src/ports_local.c                 |    58 +-
 libsemanage/src/ports_policy.c                |    28 +-
 libsemanage/src/ports_policydb.c              |    29 +-
 libsemanage/src/semanage_conf.h               |     8 +-
 libsemanage/src/semanage_store.c              |   682 +-
 libsemanage/src/semanage_store.h              |    62 +-
 libsemanage/src/seuser_internal.h             |    14 +-
 libsemanage/src/seuser_record.c               |    92 +-
 libsemanage/src/seusers_file.c                |    33 +-
 libsemanage/src/seusers_local.c               |   145 +-
 libsemanage/src/seusers_policy.c              |    29 +-
 libsemanage/src/sha256.c                      |   396 +-
 libsemanage/src/sha256.h                      |    56 +-
 libsemanage/src/user_base_record.c            |    99 +-
 libsemanage/src/user_extra_record.c           |    89 +-
 libsemanage/src/user_internal.h               |   163 +-
 libsemanage/src/user_record.c                 |   160 +-
 libsemanage/src/users_base_file.c             |    45 +-
 libsemanage/src/users_base_policydb.c         |    30 +-
 libsemanage/src/users_extra_file.c            |    42 +-
 libsemanage/src/users_join.c                  |    16 +-
 libsemanage/src/users_local.c                 |    52 +-
 libsemanage/src/users_policy.c                |    30 +-
 libsemanage/src/utilities.c                   |    21 +-
 libsemanage/src/utilities.h                   |    23 +-
 libsemanage/tests/libsemanage-tests.c         |    40 +-
 libsemanage/tests/test_bool.c                 |    52 +-
 libsemanage/tests/test_fcontext.c             |    58 +-
 libsemanage/tests/test_handle.c               |    18 +-
 libsemanage/tests/test_ibendport.c            |    86 +-
 libsemanage/tests/test_iface.c                |    27 +-
 libsemanage/tests/test_node.c                 |    44 +-
 libsemanage/tests/test_other.c                |     7 +-
 libsemanage/tests/test_port.c                 |    38 +-
 libsemanage/tests/test_semanage_store.c       |    38 +-
 libsemanage/tests/test_user.c                 |    16 +-
 libsemanage/tests/test_utilities.c            |    43 +-
 libsemanage/tests/utilities.c                 |    62 +-
 libsemanage/tests/utilities.h                 |    40 +-
 libsepol/cil/include/cil/cil.h                |    20 +-
 libsepol/cil/src/cil.c                        |   208 +-
 libsepol/cil/src/cil_binary.c                 |  2139 +-
 libsepol/cil/src/cil_binary.h                 |    66 +-
 libsepol/cil/src/cil_build_ast.c              |  2198 +-
 libsepol/cil/src/cil_build_ast.h              |   332 +-
 libsepol/cil/src/cil_copy_ast.c               |   403 +-
 libsepol/cil/src/cil_copy_ast.h               |   199 +-
 libsepol/cil/src/cil_deny.c                   |   304 +-
 libsepol/cil/src/cil_deny.h                   |    17 +-
 libsepol/cil/src/cil_find.c                   |   157 +-
 libsepol/cil/src/cil_find.h                   |     4 +-
 libsepol/cil/src/cil_flavor.h                 |     3 +-
 libsepol/cil/src/cil_fqn.c                    |    29 +-
 libsepol/cil/src/cil_internal.h               |    71 +-
 libsepol/cil/src/cil_lexer.h                  |     2 +-
 libsepol/cil/src/cil_list.c                   |    17 +-
 libsepol/cil/src/cil_list.h                   |    16 +-
 libsepol/cil/src/cil_log.c                    |    23 +-
 libsepol/cil/src/cil_log.h                    |     6 +-
 libsepol/cil/src/cil_mem.c                    |    10 +-
 libsepol/cil/src/cil_mem.h                    |     1 -
 libsepol/cil/src/cil_parser.c                 |    88 +-
 libsepol/cil/src/cil_parser.h                 |     3 +-
 libsepol/cil/src/cil_policy.c                 |   473 +-
 libsepol/cil/src/cil_post.c                   |   685 +-
 libsepol/cil/src/cil_reset_ast.c              |    18 +-
 libsepol/cil/src/cil_resolve_ast.c            |  1432 +-
 libsepol/cil/src/cil_resolve_ast.h            |    82 +-
 libsepol/cil/src/cil_stack.c                  |     7 +-
 libsepol/cil/src/cil_stack.h                  |    13 +-
 libsepol/cil/src/cil_strpool.c                |    17 +-
 libsepol/cil/src/cil_symtab.c                 |    74 +-
 libsepol/cil/src/cil_symtab.h                 |    25 +-
 libsepol/cil/src/cil_tree.c                   |    79 +-
 libsepol/cil/src/cil_tree.h                   |    34 +-
 libsepol/cil/src/cil_verify.c                 |   639 +-
 libsepol/cil/src/cil_verify.h                 |    47 +-
 libsepol/cil/src/cil_write_ast.c              |   374 +-
 libsepol/cil/src/cil_write_ast.h              |     3 +-
 libsepol/cil/test/unit/AllTests.c             |    66 +-
 libsepol/cil/test/unit/CilTest.c              |   947 +-
 libsepol/cil/test/unit/CilTest.h              |     2 +-
 libsepol/cil/test/unit/CuTest.c               |   206 +-
 libsepol/cil/test/unit/CuTest.h               |   148 +-
 libsepol/cil/test/unit/test_cil.c             |    66 +-
 libsepol/cil/test/unit/test_cil_build_ast.c   | 16702 ++++++++++------
 libsepol/cil/test/unit/test_cil_build_ast.h   |    52 +-
 libsepol/cil/test/unit/test_cil_copy_ast.c    |  2196 +-
 libsepol/cil/test/unit/test_cil_copy_ast.h    |   112 +-
 libsepol/cil/test/unit/test_cil_fqn.c         |    49 +-
 libsepol/cil/test/unit/test_cil_lexer.c       |   117 +-
 libsepol/cil/test/unit/test_cil_list.c        |   138 +-
 libsepol/cil/test/unit/test_cil_parser.c      |     7 +-
 libsepol/cil/test/unit/test_cil_post.c        |   734 +-
 libsepol/cil/test/unit/test_cil_post.h        |     1 -
 libsepol/cil/test/unit/test_cil_resolve_ast.c | 16100 ++++++++++-----
 libsepol/cil/test/unit/test_cil_resolve_ast.h |     1 -
 libsepol/cil/test/unit/test_cil_symtab.c      |    17 +-
 libsepol/cil/test/unit/test_cil_tree.c        |    29 +-
 libsepol/cil/test/unit/test_integration.c     |    29 +-
 libsepol/fuzz/binpolicy-fuzzer.c              |    20 +-
 libsepol/fuzz/secilc-fuzzer.c                 |     7 +-
 libsepol/include/sepol/boolean_record.h       |    41 +-
 libsepol/include/sepol/booleans.h             |    32 +-
 libsepol/include/sepol/context.h              |    18 +-
 libsepol/include/sepol/context_record.h       |    44 +-
 libsepol/include/sepol/debug.h                |    19 +-
 libsepol/include/sepol/errcodes.h             |    14 +-
 libsepol/include/sepol/handle.h               |    10 +-
 libsepol/include/sepol/ibendport_record.h     |     9 +-
 libsepol/include/sepol/ibendports.h           |    11 +-
 libsepol/include/sepol/ibpkey_record.h        |    18 +-
 libsepol/include/sepol/ibpkeys.h              |    14 +-
 libsepol/include/sepol/iface_record.h         |    52 +-
 libsepol/include/sepol/interfaces.h           |    34 +-
 libsepol/include/sepol/module.h               |    68 +-
 libsepol/include/sepol/module_to_cil.h        |     3 +-
 libsepol/include/sepol/node_record.h          |    80 +-
 libsepol/include/sepol/nodes.h                |    33 +-
 libsepol/include/sepol/policydb.h             |    64 +-
 .../include/sepol/policydb/avrule_block.h     |    15 +-
 libsepol/include/sepol/policydb/avtab.h       |    93 +-
 libsepol/include/sepol/policydb/conditional.h |    67 +-
 libsepol/include/sepol/policydb/constraint.h  |    70 +-
 libsepol/include/sepol/policydb/context.h     |    36 +-
 libsepol/include/sepol/policydb/ebitmap.h     |    74 +-
 libsepol/include/sepol/policydb/expand.h      |    44 +-
 libsepol/include/sepol/policydb/flask_types.h |     2 +-
 libsepol/include/sepol/policydb/hashtab.h     |    42 +-
 libsepol/include/sepol/policydb/hierarchy.h   |     7 +-
 libsepol/include/sepol/policydb/link.h        |     6 +-
 libsepol/include/sepol/policydb/mls_types.h   |    64 +-
 libsepol/include/sepol/policydb/module.h      |     2 +-
 libsepol/include/sepol/policydb/policydb.h    |   499 +-
 libsepol/include/sepol/policydb/services.h    |   147 +-
 libsepol/include/sepol/policydb/sidtab.h      |    54 +-
 libsepol/include/sepol/policydb/symtab.h      |     6 +-
 libsepol/include/sepol/policydb/util.h        |     5 +-
 libsepol/include/sepol/port_record.h          |    52 +-
 libsepol/include/sepol/ports.h                |    33 +-
 libsepol/include/sepol/sepol.h                |     2 +-
 libsepol/include/sepol/user_record.h          |    66 +-
 libsepol/include/sepol/users.h                |    32 +-
 libsepol/src/assertion.c                      |   486 +-
 libsepol/src/avrule_block.c                   |    34 +-
 libsepol/src/avtab.c                          |   150 +-
 libsepol/src/boolean_record.c                 |    72 +-
 libsepol/src/booleans.c                       |    68 +-
 libsepol/src/conditional.c                    |   156 +-
 libsepol/src/constraint.c                     |     4 +-
 libsepol/src/context.c                        |   109 +-
 libsepol/src/context.h                        |    34 +-
 libsepol/src/context_record.c                 |   124 +-
 libsepol/src/debug.c                          |    37 +-
 libsepol/src/debug.h                          |    42 +-
 libsepol/src/ebitmap.c                        |    97 +-
 libsepol/src/expand.c                         |  1004 +-
 libsepol/src/flask.h                          |    56 +-
 libsepol/src/handle.c                         |    13 +-
 libsepol/src/handle.h                         |     6 +-
 libsepol/src/hashtab.c                        |    44 +-
 libsepol/src/hierarchy.c                      |   222 +-
 libsepol/src/ibendport_record.c               |    53 +-
 libsepol/src/ibendports.c                     |    42 +-
 libsepol/src/ibpkey_record.c                  |    70 +-
 libsepol/src/ibpkeys.c                        |    47 +-
 libsepol/src/iface_record.c                   |    98 +-
 libsepol/src/interfaces.c                     |    69 +-
 libsepol/src/kernel_to_cil.c                  |   715 +-
 libsepol/src/kernel_to_common.c               |    96 +-
 libsepol/src/kernel_to_common.h               |    77 +-
 libsepol/src/kernel_to_conf.c                 |   687 +-
 libsepol/src/link.c                           |   772 +-
 libsepol/src/mls.c                            |   232 +-
 libsepol/src/mls.h                            |    44 +-
 libsepol/src/module.c                         |   169 +-
 libsepol/src/module_internal.h                |     1 -
 libsepol/src/module_to_cil.c                  |  1060 +-
 libsepol/src/node_record.c                    |   299 +-
 libsepol/src/nodes.c                          |   225 +-
 libsepol/src/optimize.c                       |    44 +-
 libsepol/src/polcaps.c                        |    32 +-
 libsepol/src/policydb.c                       |  1527 +-
 libsepol/src/policydb_convert.c               |    12 +-
 libsepol/src/policydb_internal.h              |     2 +-
 libsepol/src/policydb_public.c                |    59 +-
 libsepol/src/policydb_validate.c              |   561 +-
 libsepol/src/port_record.c                    |   104 +-
 libsepol/src/ports.c                          |    93 +-
 libsepol/src/private.h                        |    32 +-
 libsepol/src/services.c                       |   585 +-
 libsepol/src/sidtab.c                         |    55 +-
 libsepol/src/symtab.c                         |    11 +-
 libsepol/src/user_record.c                    |   131 +-
 libsepol/src/users.c                          |    95 +-
 libsepol/src/util.c                           |    68 +-
 libsepol/src/write.c                          |   447 +-
 libsepol/tests/debug.c                        |     8 +-
 libsepol/tests/debug.h                        |     4 +-
 libsepol/tests/helpers.c                      |    14 +-
 libsepol/tests/helpers.h                      |    26 +-
 libsepol/tests/libsepol-tests.c               |    40 +-
 libsepol/tests/test-common.c                  |   101 +-
 libsepol/tests/test-common.h                  |    17 +-
 libsepol/tests/test-cond.c                    |     8 +-
 libsepol/tests/test-deps.c                    |   119 +-
 libsepol/tests/test-downgrade.c               |    33 +-
 libsepol/tests/test-ebitmap.c                 |    73 +-
 libsepol/tests/test-ebitmap.h                 |     2 +-
 libsepol/tests/test-expander-attr-map.c       |   126 +-
 libsepol/tests/test-expander-users.c          |    15 +-
 libsepol/tests/test-expander.c                |    53 +-
 libsepol/tests/test-linker-cond-map.c         |    17 +-
 libsepol/tests/test-linker-cond-map.h         |     4 +-
 libsepol/tests/test-linker-roles.c            |    78 +-
 libsepol/tests/test-linker-roles.h            |     4 +-
 libsepol/tests/test-linker-types.c            |    73 +-
 libsepol/tests/test-linker-types.h            |     4 +-
 libsepol/tests/test-linker.c                  |    13 +-
 libsepol/tests/test-neverallow.c              |    53 +-
 libsepol/tests/test-neverallow.h              |     2 +-
 libsepol/utils/chkcon.c                       |    10 +-
 libsepol/utils/sepol_check_access.c           |    27 +-
 libsepol/utils/sepol_compute_av.c             |    19 +-
 libsepol/utils/sepol_compute_member.c         |    13 +-
 libsepol/utils/sepol_compute_relabel.c        |    13 +-
 libsepol/utils/sepol_validate_transition.c    |    16 +-
 mcstrans/src/mcscolor.c                       |    74 +-
 mcstrans/src/mcstrans.c                       |   898 +-
 mcstrans/src/mcstransd.c                      |   156 +-
 mcstrans/src/mls_level.c                      |    16 +-
 mcstrans/utils/transcon.c                     |    12 +-
 mcstrans/utils/untranscon.c                   |    12 +-
 policycoreutils/hll/pp/pp.c                   |    28 +-
 policycoreutils/load_policy/load_policy.c     |    35 +-
 policycoreutils/newrole/hashtab.c             |    33 +-
 policycoreutils/newrole/hashtab.h             |    50 +-
 policycoreutils/newrole/newrole.c             |   249 +-
 policycoreutils/run_init/open_init_pty.c      |    62 +-
 policycoreutils/run_init/run_init.c           |   117 +-
 policycoreutils/secon/secon.c                 |   225 +-
 policycoreutils/semodule/semodule.c           |   756 +-
 policycoreutils/sestatus/sestatus.c           |    78 +-
 policycoreutils/setfiles/restore.c            |    56 +-
 policycoreutils/setfiles/restorecon_xattr.c   |    45 +-
 policycoreutils/setfiles/setfiles.c           |    58 +-
 policycoreutils/setsebool/setsebool.c         |    39 +-
 policycoreutils/unsetfiles/unsetfiles.c       |    68 +-
 .../audit2allow/sepolgen-ifgen-attr-helper.c  |    39 +-
 restorecond/restore.c                         |    28 +-
 restorecond/restorecond.c                     |    17 +-
 restorecond/restorecond.h                     |     2 +-
 restorecond/stringslist.c                     |     8 +-
 restorecond/user.c                            |   220 +-
 restorecond/utmpwatcher.c                     |     7 +-
 restorecond/watch.c                           |    70 +-
 sandbox/seunshare.c                           |   382 +-
 secilc/secil2conf.c                           |    78 +-
 secilc/secil2tree.c                           |    85 +-
 secilc/secilc.c                               |   242 +-
 secilc/secilcheck.c                           |    65 +-
 .../semodule_expand/semodule_expand.c         |    65 +-
 semodule-utils/semodule_link/semodule_link.c  |    15 +-
 .../semodule_package/semodule_package.c       |    91 +-
 .../semodule_package/semodule_unpackage.c     |    24 +-
 495 files changed, 49832 insertions(+), 34947 deletions(-)

