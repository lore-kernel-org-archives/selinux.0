Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2B1D88A4
	for <selinux@vger.kernel.org>; Sun, 28 Sep 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759099185; cv=none; b=jjlqL+CrER0bVgG0N8meuluiE9OazbY1ZjoAfwDzFDAoDMUNqt2xp3Le4rAIK3BlSzQVZXGf3w0kTY5l5btVPSWkoQU1YSrUUZZst8O7zbwAbYdnmd+5UFtXBOfBUKVWrGg3zMg6caBNWen/07naJq2dKUjNly5LVOfCpq8SwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759099185; c=relaxed/simple;
	bh=kXKmO6n5Din44cSJWxXcVoXM38FV5peSIJpsioARrn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+8AKzyhpAJ30DBIv9KVMPV32aFWuI8a4tau71yruMEymW/WMXTP/2+aW35oZR1BtFW0PxoJvXxqzyDtVA2AHEoNhStq0l+NJTW6Gvi8Lk00z7vKIi+giuA1JeF80xZALCNoU6REM2q9+MY6/rDjcxXljLQH8sFRrS/Sb+vGEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTf5LcMp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTf5LcMp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso19889225e9.2
        for <selinux@vger.kernel.org>; Sun, 28 Sep 2025 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759099181; x=1759703981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyX3cgsvu12nopI4WOacUTAghnyDuAb6q5ph5LnAAO8=;
        b=KTf5LcMpG2nPAQ3Uj0W11AUkiaVTHDfH2yu9B3CNcMijeLWpr3DFJbz/O3gukexhWy
         i8kaF1XH2ju/ZZTh26cSk6g1hMSZamGB7P50QkzAQ7WDS10XZDTe6uxedC40/UhsJn+X
         l3EkufaVaViXGOVbzJeWj13TGUD9y+qhnwXJpJf0XH4LywMZCsIzqTTe+8Pk0O5sFks5
         4ypus7uBfezb+KjMxWxV225LeVIegqJxh8JAz1Iv6DmFP4kftEfjuSID1rqsRf4qmYCx
         qul4GUuHe1UkFNzNwJOi6gonGQQzaBjwS7YlzaYFZj6HQXxJkE8ifBbW+URKkv0sraGx
         HNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759099181; x=1759703981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyX3cgsvu12nopI4WOacUTAghnyDuAb6q5ph5LnAAO8=;
        b=K0J04hzw6ddBIj/sdFw+ghqX5bZxWcDIdc+9uSlOjmIwEhmhJn+mhz3RqGLl/xm35a
         2hq6qwMGE18ZAebggZnGmABDow2Qrs0+Xw2sEQrAQrNnT+JkD6F1ETGTXP7w8+u/8J33
         sWzJw6vpKaR9akyBbdoVE2mkHpcGr6LyNszweTxH27aiDOKIKPfpZI3qaYIBJoADZrj8
         wCitaLOi19opncT03CydoQveC3SJJ/5DW7scprOglsqMd5HgPxgWRO8u4P3RgWjF3UrO
         cyNlkAi/t6mLWfM5O2fjPUuzEor0j/NEf8lEV4ozelIinWJjTHtmfsR/CK2+bKNbEtRP
         L0+A==
X-Gm-Message-State: AOJu0YzHenBT/4YdS24DDl+4DkZEk21AraEehvKGIg9A7EOfxpaZcCpD
	9ox21t6NLpHqphzV4jq1AkHrXvboZq5mjBXjM7Xs45VgYuvKGwy0HYGHd5OShQ==
X-Gm-Gg: ASbGnct7lcJhuw0zmG8d/nFyd85oABlycAE5FtYQJ9TnNRduSCgRweLa+vILDwr8kC7
	oPT9K8GKmmP9RrezAp9dH6uM329OKGU02WTbLenlGYcTyEZOMnK9O92bWzHIaxPJrfUyJuLFsG1
	rSJTwxLGyVgMbe8xAiadWX32lTdFR3f3qiO8ISi+lxsxlDoC/NZMmCC01gGPUI4Xfm0hhurj0Tm
	2BIYc2SkD8AuqRrP4pRg6GctxJ2JCBzJNxbQsZiqoHKVE+hmyBOCZA/Wvx1E17c9aZMVhnSN5Hj
	dPkE4DJQAjhDjlUeoqHWh9mtARDsTQjvMs02kwY2S2Dkg/a+DMS9GX+/uyMDM2vGwGg9e24XuCM
	xWOv/wSs=
X-Google-Smtp-Source: AGHT+IHz4u54LtpZroGcJ8ledGfhL+xMVeOhqKdjkC6vyBUHYY5PMRdOq3saLuo6wiuVYdvT7MAJXQ==
X-Received: by 2002:a05:600c:5286:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-46e4a13eaa8mr37602315e9.19.1759099180511;
        Sun, 28 Sep 2025 15:39:40 -0700 (PDT)
Received: from sierra ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1b665sm15629486f8f.27.2025.09.28.15.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:39:39 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [RFC PATCH] treewide: add .clang-format configuration file
Date: Sun, 28 Sep 2025 23:39:23 +0100
Message-ID: <20250928223923.1268452-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently only an RFC.

Add the .clang-format configuration file, taken from the Linux kernel
repository. We don't have any official style guidelines in tree at
present, which makes it a bit unclear how to format C code for new
contributors. As well as this, different parts of the codebase seem to
been formatted with different styles on occasion, so using an automatic
formatter should resolve this.

.clang-format is also read by various editors and tooling for writing C
code. It may also be worth adding an editorconfig file in the future as
well?

It may well also be worth adding a `format` target to the Makefiles, is
that something that would be useful?

A few other things to consider to do in the future:
1. Reformat all existing code. I understand this is a big change, hence
   the RFC, but we may as well get all code formatted if we go down
   this route; afterall, it's not like this will cause any breaking
   changes.
2. Possibly add a CI target to check that all code is formatted as per
   the new clang-format configuration? The options `--dry-run` as well
   as `-Werror` can be passed to clang-format for this.

Comments/feedback appreciated, thanks.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 .clang-format   | 804 ++++++++++++++++++++++++++++++++++++++++++++++++
 CONTRIBUTING.md |   2 +
 2 files changed, 806 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 00000000..48405c54
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,804 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# clang-format configuration file. Intended for clang-format >= 11.
+#
+# For more information, see:
+#
+#   Documentation/dev-tools/clang-format.rst
+#   https://clang.llvm.org/docs/ClangFormat.html
+#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
+#
+---
+AccessModifierOffset: -4
+AlignAfterOpenBracket: Align
+AlignConsecutiveAssignments: false
+AlignConsecutiveDeclarations: false
+AlignEscapedNewlines: Left
+AlignOperands: true
+AlignTrailingComments: false
+AllowAllParametersOfDeclarationOnNextLine: false
+AllowShortBlocksOnASingleLine: false
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: false
+AllowShortLoopsOnASingleLine: false
+AlwaysBreakAfterDefinitionReturnType: None
+AlwaysBreakAfterReturnType: None
+AlwaysBreakBeforeMultilineStrings: false
+AlwaysBreakTemplateDeclarations: false
+BinPackArguments: true
+BinPackParameters: true
+BraceWrapping:
+  AfterClass: false
+  AfterControlStatement: false
+  AfterEnum: false
+  AfterFunction: true
+  AfterNamespace: true
+  AfterObjCDeclaration: false
+  AfterStruct: false
+  AfterUnion: false
+  AfterExternBlock: false
+  BeforeCatch: false
+  BeforeElse: false
+  IndentBraces: false
+  SplitEmptyFunction: true
+  SplitEmptyRecord: true
+  SplitEmptyNamespace: true
+BreakBeforeBinaryOperators: None
+BreakBeforeBraces: Custom
+BreakBeforeInheritanceComma: false
+BreakBeforeTernaryOperators: false
+BreakConstructorInitializersBeforeComma: false
+BreakConstructorInitializers: BeforeComma
+BreakAfterJavaFieldAnnotations: false
+BreakStringLiterals: false
+ColumnLimit: 80
+CommentPragmas: '^ IWYU pragma:'
+CompactNamespaces: false
+ConstructorInitializerAllOnOneLineOrOnePerLine: false
+ConstructorInitializerIndentWidth: 8
+ContinuationIndentWidth: 8
+Cpp11BracedListStyle: false
+DerivePointerAlignment: false
+DisableFormat: false
+ExperimentalAutoDetectBinPacking: false
+FixNamespaceComments: false
+
+# Taken from:
+#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ tools/ \
+#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," \
+#   | LC_ALL=C sort -u
+ForEachMacros:
+  - '__ata_qc_for_each'
+  - '__bio_for_each_bvec'
+  - '__bio_for_each_segment'
+  - '__evlist__for_each_entry'
+  - '__evlist__for_each_entry_continue'
+  - '__evlist__for_each_entry_from'
+  - '__evlist__for_each_entry_reverse'
+  - '__evlist__for_each_entry_safe'
+  - '__for_each_mem_range'
+  - '__for_each_mem_range_rev'
+  - '__for_each_thread'
+  - '__hlist_for_each_rcu'
+  - '__map__for_each_symbol_by_name'
+  - '__pci_bus_for_each_res0'
+  - '__pci_bus_for_each_res1'
+  - '__pci_dev_for_each_res0'
+  - '__pci_dev_for_each_res1'
+  - '__perf_evlist__for_each_entry'
+  - '__perf_evlist__for_each_entry_reverse'
+  - '__perf_evlist__for_each_entry_safe'
+  - '__rq_for_each_bio'
+  - '__shost_for_each_device'
+  - '__sym_for_each'
+  - '_for_each_counter'
+  - 'apei_estatus_for_each_section'
+  - 'ata_for_each_dev'
+  - 'ata_for_each_link'
+  - 'ata_qc_for_each'
+  - 'ata_qc_for_each_raw'
+  - 'ata_qc_for_each_with_internal'
+  - 'ax25_for_each'
+  - 'ax25_uid_for_each'
+  - 'bio_for_each_bvec'
+  - 'bio_for_each_bvec_all'
+  - 'bio_for_each_folio_all'
+  - 'bio_for_each_integrity_vec'
+  - 'bio_for_each_segment'
+  - 'bio_for_each_segment_all'
+  - 'bio_list_for_each'
+  - 'bip_for_each_vec'
+  - 'bond_for_each_slave'
+  - 'bond_for_each_slave_rcu'
+  - 'bpf_for_each'
+  - 'bpf_for_each_reg_in_vstate'
+  - 'bpf_for_each_reg_in_vstate_mask'
+  - 'bpf_for_each_spilled_reg'
+  - 'bpf_object__for_each_map'
+  - 'bpf_object__for_each_program'
+  - 'btree_for_each_safe128'
+  - 'btree_for_each_safe32'
+  - 'btree_for_each_safe64'
+  - 'btree_for_each_safel'
+  - 'card_for_each_dev'
+  - 'cgroup_taskset_for_each'
+  - 'cgroup_taskset_for_each_leader'
+  - 'cpu_aggr_map__for_each_idx'
+  - 'cpufreq_for_each_efficient_entry_idx'
+  - 'cpufreq_for_each_entry'
+  - 'cpufreq_for_each_entry_idx'
+  - 'cpufreq_for_each_valid_entry'
+  - 'cpufreq_for_each_valid_entry_idx'
+  - 'css_for_each_child'
+  - 'css_for_each_descendant_post'
+  - 'css_for_each_descendant_pre'
+  - 'damon_for_each_region'
+  - 'damon_for_each_region_from'
+  - 'damon_for_each_region_safe'
+  - 'damon_for_each_scheme'
+  - 'damon_for_each_scheme_safe'
+  - 'damon_for_each_target'
+  - 'damon_for_each_target_safe'
+  - 'damos_for_each_filter'
+  - 'damos_for_each_filter_safe'
+  - 'damos_for_each_ops_filter'
+  - 'damos_for_each_ops_filter_safe'
+  - 'damos_for_each_quota_goal'
+  - 'damos_for_each_quota_goal_safe'
+  - 'data__for_each_file'
+  - 'data__for_each_file_new'
+  - 'data__for_each_file_start'
+  - 'def_for_each_cpu'
+  - 'device_for_each_child_node'
+  - 'device_for_each_child_node_scoped'
+  - 'dma_fence_array_for_each'
+  - 'dma_fence_chain_for_each'
+  - 'dma_fence_unwrap_for_each'
+  - 'dma_resv_for_each_fence'
+  - 'dma_resv_for_each_fence_unlocked'
+  - 'do_for_each_ftrace_op'
+  - 'drm_atomic_crtc_for_each_plane'
+  - 'drm_atomic_crtc_state_for_each_plane'
+  - 'drm_atomic_crtc_state_for_each_plane_state'
+  - 'drm_atomic_for_each_plane_damage'
+  - 'drm_client_for_each_connector_iter'
+  - 'drm_client_for_each_modeset'
+  - 'drm_connector_for_each_possible_encoder'
+  - 'drm_exec_for_each_locked_object'
+  - 'drm_exec_for_each_locked_object_reverse'
+  - 'drm_for_each_bridge_in_chain'
+  - 'drm_for_each_connector_iter'
+  - 'drm_for_each_crtc'
+  - 'drm_for_each_crtc_reverse'
+  - 'drm_for_each_encoder'
+  - 'drm_for_each_encoder_mask'
+  - 'drm_for_each_fb'
+  - 'drm_for_each_legacy_plane'
+  - 'drm_for_each_plane'
+  - 'drm_for_each_plane_mask'
+  - 'drm_for_each_privobj'
+  - 'drm_gem_for_each_gpuvm_bo'
+  - 'drm_gem_for_each_gpuvm_bo_safe'
+  - 'drm_gpusvm_for_each_range'
+  - 'drm_gpuva_for_each_op'
+  - 'drm_gpuva_for_each_op_from_reverse'
+  - 'drm_gpuva_for_each_op_reverse'
+  - 'drm_gpuva_for_each_op_safe'
+  - 'drm_gpuvm_bo_for_each_va'
+  - 'drm_gpuvm_bo_for_each_va_safe'
+  - 'drm_gpuvm_for_each_va'
+  - 'drm_gpuvm_for_each_va_range'
+  - 'drm_gpuvm_for_each_va_range_safe'
+  - 'drm_gpuvm_for_each_va_safe'
+  - 'drm_mm_for_each_hole'
+  - 'drm_mm_for_each_node'
+  - 'drm_mm_for_each_node_in_range'
+  - 'drm_mm_for_each_node_safe'
+  - 'dsa_switch_for_each_available_port'
+  - 'dsa_switch_for_each_cpu_port'
+  - 'dsa_switch_for_each_cpu_port_continue_reverse'
+  - 'dsa_switch_for_each_port'
+  - 'dsa_switch_for_each_port_continue_reverse'
+  - 'dsa_switch_for_each_port_safe'
+  - 'dsa_switch_for_each_user_port'
+  - 'dsa_switch_for_each_user_port_continue_reverse'
+  - 'dsa_tree_for_each_cpu_port'
+  - 'dsa_tree_for_each_user_port'
+  - 'dsa_tree_for_each_user_port_continue_reverse'
+  - 'dso__for_each_symbol'
+  - 'elf_hash_for_each_possible'
+  - 'elf_symtab__for_each_symbol'
+  - 'evlist__for_each_cpu'
+  - 'evlist__for_each_entry'
+  - 'evlist__for_each_entry_continue'
+  - 'evlist__for_each_entry_from'
+  - 'evlist__for_each_entry_reverse'
+  - 'evlist__for_each_entry_safe'
+  - 'flow_action_for_each'
+  - 'for_each_acpi_consumer_dev'
+  - 'for_each_acpi_dev_match'
+  - 'for_each_active_dev_scope'
+  - 'for_each_active_drhd_unit'
+  - 'for_each_active_iommu'
+  - 'for_each_active_irq'
+  - 'for_each_active_route'
+  - 'for_each_aggr_pgid'
+  - 'for_each_alloc_capable_rdt_resource'
+  - 'for_each_and_bit'
+  - 'for_each_andnot_bit'
+  - 'for_each_available_child_of_node'
+  - 'for_each_available_child_of_node_scoped'
+  - 'for_each_bench'
+  - 'for_each_bio'
+  - 'for_each_board_func_rsrc'
+  - 'for_each_btf_ext_rec'
+  - 'for_each_btf_ext_sec'
+  - 'for_each_bvec'
+  - 'for_each_capable_rdt_resource'
+  - 'for_each_card_auxs'
+  - 'for_each_card_auxs_safe'
+  - 'for_each_card_components'
+  - 'for_each_card_dapms'
+  - 'for_each_card_pre_auxs'
+  - 'for_each_card_prelinks'
+  - 'for_each_card_rtds'
+  - 'for_each_card_rtds_safe'
+  - 'for_each_card_widgets'
+  - 'for_each_card_widgets_safe'
+  - 'for_each_cgroup_storage_type'
+  - 'for_each_child_of_node'
+  - 'for_each_child_of_node_scoped'
+  - 'for_each_child_of_node_with_prefix'
+  - 'for_each_clear_bit'
+  - 'for_each_clear_bit_from'
+  - 'for_each_clear_bitrange'
+  - 'for_each_clear_bitrange_from'
+  - 'for_each_cmd'
+  - 'for_each_cmsghdr'
+  - 'for_each_collection'
+  - 'for_each_comp_order'
+  - 'for_each_compatible_node'
+  - 'for_each_component_dais'
+  - 'for_each_component_dais_safe'
+  - 'for_each_conduit'
+  - 'for_each_console'
+  - 'for_each_console_srcu'
+  - 'for_each_cpu'
+  - 'for_each_cpu_and'
+  - 'for_each_cpu_andnot'
+  - 'for_each_cpu_from'
+  - 'for_each_cpu_or'
+  - 'for_each_cpu_wrap'
+  - 'for_each_dapm_widgets'
+  - 'for_each_dedup_cand'
+  - 'for_each_dev_addr'
+  - 'for_each_dev_scope'
+  - 'for_each_dma_cap_mask'
+  - 'for_each_dpcm_be'
+  - 'for_each_dpcm_be_rollback'
+  - 'for_each_dpcm_be_safe'
+  - 'for_each_dpcm_fe'
+  - 'for_each_drhd_unit'
+  - 'for_each_dss_dev'
+  - 'for_each_efi_memory_desc'
+  - 'for_each_efi_memory_desc_in_map'
+  - 'for_each_element'
+  - 'for_each_element_extid'
+  - 'for_each_element_id'
+  - 'for_each_enabled_cpu'
+  - 'for_each_endpoint_of_node'
+  - 'for_each_event'
+  - 'for_each_event_tps'
+  - 'for_each_evictable_lru'
+  - 'for_each_fib6_node_rt_rcu'
+  - 'for_each_fib6_walker_rt'
+  - 'for_each_file_lock'
+  - 'for_each_free_mem_pfn_range_in_zone_from'
+  - 'for_each_free_mem_range'
+  - 'for_each_free_mem_range_reverse'
+  - 'for_each_func_rsrc'
+  - 'for_each_gpiochip_node'
+  - 'for_each_group_evsel'
+  - 'for_each_group_evsel_head'
+  - 'for_each_group_member'
+  - 'for_each_group_member_head'
+  - 'for_each_hstate'
+  - 'for_each_hwgpio'
+  - 'for_each_hwgpio_in_range'
+  - 'for_each_if'
+  - 'for_each_inject_fn'
+  - 'for_each_insn'
+  - 'for_each_insn_op_loc'
+  - 'for_each_insn_prefix'
+  - 'for_each_intid'
+  - 'for_each_iommu'
+  - 'for_each_ip_tunnel_rcu'
+  - 'for_each_irq_desc'
+  - 'for_each_irq_nr'
+  - 'for_each_lang'
+  - 'for_each_link_ch_maps'
+  - 'for_each_link_codecs'
+  - 'for_each_link_cpus'
+  - 'for_each_link_platforms'
+  - 'for_each_lru'
+  - 'for_each_matching_node'
+  - 'for_each_matching_node_and_match'
+  - 'for_each_media_entity_data_link'
+  - 'for_each_mem_pfn_range'
+  - 'for_each_mem_range'
+  - 'for_each_mem_range_rev'
+  - 'for_each_mem_region'
+  - 'for_each_member'
+  - 'for_each_memory'
+  - 'for_each_migratetype_order'
+  - 'for_each_missing_reg'
+  - 'for_each_mle_subelement'
+  - 'for_each_mod_mem_type'
+  - 'for_each_mon_capable_rdt_resource'
+  - 'for_each_mp_bvec'
+  - 'for_each_net'
+  - 'for_each_net_continue_reverse'
+  - 'for_each_net_rcu'
+  - 'for_each_netdev'
+  - 'for_each_netdev_continue'
+  - 'for_each_netdev_continue_rcu'
+  - 'for_each_netdev_continue_reverse'
+  - 'for_each_netdev_dump'
+  - 'for_each_netdev_feature'
+  - 'for_each_netdev_in_bond_rcu'
+  - 'for_each_netdev_rcu'
+  - 'for_each_netdev_reverse'
+  - 'for_each_netdev_safe'
+  - 'for_each_new_connector_in_state'
+  - 'for_each_new_crtc_in_state'
+  - 'for_each_new_mst_mgr_in_state'
+  - 'for_each_new_plane_in_state'
+  - 'for_each_new_plane_in_state_reverse'
+  - 'for_each_new_private_obj_in_state'
+  - 'for_each_new_reg'
+  - 'for_each_nhlt_endpoint'
+  - 'for_each_nhlt_endpoint_fmtcfg'
+  - 'for_each_nhlt_fmtcfg'
+  - 'for_each_node'
+  - 'for_each_node_by_name'
+  - 'for_each_node_by_type'
+  - 'for_each_node_mask'
+  - 'for_each_node_numadist'
+  - 'for_each_node_state'
+  - 'for_each_node_with_cpus'
+  - 'for_each_node_with_property'
+  - 'for_each_nonreserved_multicast_dest_pgid'
+  - 'for_each_numa_hop_mask'
+  - 'for_each_of_allnodes'
+  - 'for_each_of_allnodes_from'
+  - 'for_each_of_cpu_node'
+  - 'for_each_of_graph_port'
+  - 'for_each_of_graph_port_endpoint'
+  - 'for_each_of_pci_range'
+  - 'for_each_old_connector_in_state'
+  - 'for_each_old_crtc_in_state'
+  - 'for_each_old_mst_mgr_in_state'
+  - 'for_each_old_plane_in_state'
+  - 'for_each_old_private_obj_in_state'
+  - 'for_each_oldnew_connector_in_state'
+  - 'for_each_oldnew_crtc_in_state'
+  - 'for_each_oldnew_mst_mgr_in_state'
+  - 'for_each_oldnew_plane_in_state'
+  - 'for_each_oldnew_plane_in_state_reverse'
+  - 'for_each_oldnew_private_obj_in_state'
+  - 'for_each_online_cpu'
+  - 'for_each_online_cpu_wrap'
+  - 'for_each_online_node'
+  - 'for_each_online_pgdat'
+  - 'for_each_or_bit'
+  - 'for_each_page_ext'
+  - 'for_each_path'
+  - 'for_each_pci_bridge'
+  - 'for_each_pci_dev'
+  - 'for_each_pcm_streams'
+  - 'for_each_physmem_range'
+  - 'for_each_populated_zone'
+  - 'for_each_possible_cpu'
+  - 'for_each_possible_cpu_wrap'
+  - 'for_each_present_blessed_reg'
+  - 'for_each_present_cpu'
+  - 'for_each_present_section_nr'
+  - 'for_each_prime_number'
+  - 'for_each_prime_number_from'
+  - 'for_each_probe_cache_entry'
+  - 'for_each_process'
+  - 'for_each_process_thread'
+  - 'for_each_prop_codec_conf'
+  - 'for_each_prop_dai_codec'
+  - 'for_each_prop_dai_cpu'
+  - 'for_each_prop_dlc_codecs'
+  - 'for_each_prop_dlc_cpus'
+  - 'for_each_prop_dlc_platforms'
+  - 'for_each_property_of_node'
+  - 'for_each_rdt_resource'
+  - 'for_each_reg'
+  - 'for_each_reg_filtered'
+  - 'for_each_reloc'
+  - 'for_each_reloc_from'
+  - 'for_each_requested_gpio'
+  - 'for_each_requested_gpio_in_range'
+  - 'for_each_reserved_child_of_node'
+  - 'for_each_reserved_mem_range'
+  - 'for_each_reserved_mem_region'
+  - 'for_each_rtd_ch_maps'
+  - 'for_each_rtd_codec_dais'
+  - 'for_each_rtd_components'
+  - 'for_each_rtd_cpu_dais'
+  - 'for_each_rtd_dais'
+  - 'for_each_rtd_dais_reverse'
+  - 'for_each_sband_iftype_data'
+  - 'for_each_script'
+  - 'for_each_sec'
+  - 'for_each_set_bit'
+  - 'for_each_set_bit_from'
+  - 'for_each_set_bit_wrap'
+  - 'for_each_set_bitrange'
+  - 'for_each_set_bitrange_from'
+  - 'for_each_set_clump8'
+  - 'for_each_sg'
+  - 'for_each_sg_dma_page'
+  - 'for_each_sg_page'
+  - 'for_each_sgtable_dma_page'
+  - 'for_each_sgtable_dma_sg'
+  - 'for_each_sgtable_page'
+  - 'for_each_sgtable_sg'
+  - 'for_each_sibling_event'
+  - 'for_each_sta_active_link'
+  - 'for_each_subelement'
+  - 'for_each_subelement_extid'
+  - 'for_each_subelement_id'
+  - 'for_each_sublist'
+  - 'for_each_subsystem'
+  - 'for_each_suite'
+  - 'for_each_supported_activate_fn'
+  - 'for_each_supported_inject_fn'
+  - 'for_each_sym'
+  - 'for_each_thread'
+  - 'for_each_token'
+  - 'for_each_unicast_dest_pgid'
+  - 'for_each_valid_link'
+  - 'for_each_vif_active_link'
+  - 'for_each_vma'
+  - 'for_each_vma_range'
+  - 'for_each_vsi'
+  - 'for_each_wakeup_source'
+  - 'for_each_zone'
+  - 'for_each_zone_zonelist'
+  - 'for_each_zone_zonelist_nodemask'
+  - 'func_for_each_insn'
+  - 'fwnode_for_each_available_child_node'
+  - 'fwnode_for_each_child_node'
+  - 'fwnode_for_each_parent_node'
+  - 'fwnode_graph_for_each_endpoint'
+  - 'gadget_for_each_ep'
+  - 'genradix_for_each'
+  - 'genradix_for_each_from'
+  - 'genradix_for_each_reverse'
+  - 'hash_for_each'
+  - 'hash_for_each_possible'
+  - 'hash_for_each_possible_rcu'
+  - 'hash_for_each_possible_rcu_notrace'
+  - 'hash_for_each_possible_safe'
+  - 'hash_for_each_rcu'
+  - 'hash_for_each_safe'
+  - 'hashmap__for_each_entry'
+  - 'hashmap__for_each_entry_safe'
+  - 'hashmap__for_each_key_entry'
+  - 'hashmap__for_each_key_entry_safe'
+  - 'hctx_for_each_ctx'
+  - 'hists__for_each_format'
+  - 'hists__for_each_sort_list'
+  - 'hlist_bl_for_each_entry'
+  - 'hlist_bl_for_each_entry_rcu'
+  - 'hlist_bl_for_each_entry_safe'
+  - 'hlist_for_each'
+  - 'hlist_for_each_entry'
+  - 'hlist_for_each_entry_continue'
+  - 'hlist_for_each_entry_continue_rcu'
+  - 'hlist_for_each_entry_continue_rcu_bh'
+  - 'hlist_for_each_entry_from'
+  - 'hlist_for_each_entry_from_rcu'
+  - 'hlist_for_each_entry_rcu'
+  - 'hlist_for_each_entry_rcu_bh'
+  - 'hlist_for_each_entry_rcu_notrace'
+  - 'hlist_for_each_entry_safe'
+  - 'hlist_for_each_entry_srcu'
+  - 'hlist_for_each_safe'
+  - 'hlist_nulls_for_each_entry'
+  - 'hlist_nulls_for_each_entry_from'
+  - 'hlist_nulls_for_each_entry_rcu'
+  - 'hlist_nulls_for_each_entry_safe'
+  - 'i3c_bus_for_each_i2cdev'
+  - 'i3c_bus_for_each_i3cdev'
+  - 'idr_for_each_entry'
+  - 'idr_for_each_entry_continue'
+  - 'idr_for_each_entry_continue_ul'
+  - 'idr_for_each_entry_ul'
+  - 'iio_for_each_active_channel'
+  - 'in_dev_for_each_ifa_rcu'
+  - 'in_dev_for_each_ifa_rtnl'
+  - 'in_dev_for_each_ifa_rtnl_net'
+  - 'inet_bind_bucket_for_each'
+  - 'interval_tree_for_each_span'
+  - 'intlist__for_each_entry'
+  - 'intlist__for_each_entry_safe'
+  - 'kcore_copy__for_each_phdr'
+  - 'key_for_each'
+  - 'key_for_each_safe'
+  - 'klp_for_each_func'
+  - 'klp_for_each_func_safe'
+  - 'klp_for_each_func_static'
+  - 'klp_for_each_object'
+  - 'klp_for_each_object_safe'
+  - 'klp_for_each_object_static'
+  - 'kunit_suite_for_each_test_case'
+  - 'kvm_for_each_memslot'
+  - 'kvm_for_each_memslot_in_gfn_range'
+  - 'kvm_for_each_vcpu'
+  - 'libbpf_nla_for_each_attr'
+  - 'list_for_each'
+  - 'list_for_each_codec'
+  - 'list_for_each_codec_safe'
+  - 'list_for_each_continue'
+  - 'list_for_each_entry'
+  - 'list_for_each_entry_continue'
+  - 'list_for_each_entry_continue_rcu'
+  - 'list_for_each_entry_continue_reverse'
+  - 'list_for_each_entry_from'
+  - 'list_for_each_entry_from_rcu'
+  - 'list_for_each_entry_from_reverse'
+  - 'list_for_each_entry_lockless'
+  - 'list_for_each_entry_rcu'
+  - 'list_for_each_entry_reverse'
+  - 'list_for_each_entry_safe'
+  - 'list_for_each_entry_safe_continue'
+  - 'list_for_each_entry_safe_from'
+  - 'list_for_each_entry_safe_reverse'
+  - 'list_for_each_entry_srcu'
+  - 'list_for_each_from'
+  - 'list_for_each_prev'
+  - 'list_for_each_prev_safe'
+  - 'list_for_each_rcu'
+  - 'list_for_each_safe'
+  - 'llist_for_each'
+  - 'llist_for_each_entry'
+  - 'llist_for_each_entry_safe'
+  - 'llist_for_each_safe'
+  - 'lwq_for_each_safe'
+  - 'map__for_each_symbol'
+  - 'map__for_each_symbol_by_name'
+  - 'mas_for_each'
+  - 'mas_for_each_rev'
+  - 'mci_for_each_dimm'
+  - 'media_device_for_each_entity'
+  - 'media_device_for_each_intf'
+  - 'media_device_for_each_link'
+  - 'media_device_for_each_pad'
+  - 'media_entity_for_each_pad'
+  - 'media_pipeline_for_each_entity'
+  - 'media_pipeline_for_each_pad'
+  - 'mlx5_lag_for_each_peer_mdev'
+  - 'mptcp_for_each_subflow'
+  - 'msi_domain_for_each_desc'
+  - 'msi_for_each_desc'
+  - 'mt_for_each'
+  - 'nanddev_io_for_each_block'
+  - 'nanddev_io_for_each_page'
+  - 'neigh_for_each_in_bucket'
+  - 'neigh_for_each_in_bucket_rcu'
+  - 'neigh_for_each_in_bucket_safe'
+  - 'netdev_for_each_lower_dev'
+  - 'netdev_for_each_lower_private'
+  - 'netdev_for_each_lower_private_rcu'
+  - 'netdev_for_each_mc_addr'
+  - 'netdev_for_each_synced_mc_addr'
+  - 'netdev_for_each_synced_uc_addr'
+  - 'netdev_for_each_uc_addr'
+  - 'netdev_for_each_upper_dev_rcu'
+  - 'netdev_hw_addr_list_for_each'
+  - 'nft_rule_for_each_expr'
+  - 'nla_for_each_attr'
+  - 'nla_for_each_attr_type'
+  - 'nla_for_each_nested'
+  - 'nla_for_each_nested_type'
+  - 'nlmsg_for_each_attr'
+  - 'nlmsg_for_each_msg'
+  - 'nr_neigh_for_each'
+  - 'nr_neigh_for_each_safe'
+  - 'nr_node_for_each'
+  - 'nr_node_for_each_safe'
+  - 'of_for_each_phandle'
+  - 'of_property_for_each_string'
+  - 'of_property_for_each_u32'
+  - 'pci_bus_for_each_resource'
+  - 'pci_dev_for_each_resource'
+  - 'pcl_for_each_chunk'
+  - 'pcl_for_each_segment'
+  - 'pcm_for_each_format'
+  - 'perf_config_items__for_each_entry'
+  - 'perf_config_sections__for_each_entry'
+  - 'perf_config_set__for_each_entry'
+  - 'perf_cpu_map__for_each_cpu'
+  - 'perf_cpu_map__for_each_cpu_skip_any'
+  - 'perf_cpu_map__for_each_idx'
+  - 'perf_evlist__for_each_entry'
+  - 'perf_evlist__for_each_entry_reverse'
+  - 'perf_evlist__for_each_entry_safe'
+  - 'perf_evlist__for_each_evsel'
+  - 'perf_evlist__for_each_mmap'
+  - 'perf_evsel_for_each_per_thread_period_safe'
+  - 'perf_hpp_list__for_each_format'
+  - 'perf_hpp_list__for_each_format_safe'
+  - 'perf_hpp_list__for_each_sort_list'
+  - 'perf_hpp_list__for_each_sort_list_safe'
+  - 'plist_for_each'
+  - 'plist_for_each_continue'
+  - 'plist_for_each_entry'
+  - 'plist_for_each_entry_continue'
+  - 'plist_for_each_entry_safe'
+  - 'plist_for_each_safe'
+  - 'pnp_for_each_card'
+  - 'pnp_for_each_dev'
+  - 'protocol_for_each_card'
+  - 'protocol_for_each_dev'
+  - 'queue_for_each_hw_ctx'
+  - 'radix_tree_for_each_slot'
+  - 'radix_tree_for_each_tagged'
+  - 'rb_for_each'
+  - 'rbtree_postorder_for_each_entry_safe'
+  - 'rdma_for_each_block'
+  - 'rdma_for_each_port'
+  - 'rdma_umem_for_each_dma_block'
+  - 'resource_list_for_each_entry'
+  - 'resource_list_for_each_entry_safe'
+  - 'rhl_for_each_entry_rcu'
+  - 'rhl_for_each_rcu'
+  - 'rht_for_each'
+  - 'rht_for_each_entry'
+  - 'rht_for_each_entry_from'
+  - 'rht_for_each_entry_rcu'
+  - 'rht_for_each_entry_rcu_from'
+  - 'rht_for_each_entry_safe'
+  - 'rht_for_each_from'
+  - 'rht_for_each_rcu'
+  - 'rht_for_each_rcu_from'
+  - 'rq_for_each_bvec'
+  - 'rq_for_each_segment'
+  - 'rq_list_for_each'
+  - 'rq_list_for_each_safe'
+  - 'sample_read_group__for_each'
+  - 'scsi_for_each_prot_sg'
+  - 'scsi_for_each_sg'
+  - 'sctp_for_each_hentry'
+  - 'sctp_skb_for_each'
+  - 'sec_for_each_insn'
+  - 'sec_for_each_insn_continue'
+  - 'sec_for_each_insn_from'
+  - 'sec_for_each_sym'
+  - 'shdma_for_each_chan'
+  - 'shost_for_each_device'
+  - 'sk_for_each'
+  - 'sk_for_each_bound'
+  - 'sk_for_each_bound_safe'
+  - 'sk_for_each_entry_offset_rcu'
+  - 'sk_for_each_from'
+  - 'sk_for_each_rcu'
+  - 'sk_for_each_safe'
+  - 'sk_nulls_for_each'
+  - 'sk_nulls_for_each_from'
+  - 'sk_nulls_for_each_rcu'
+  - 'snd_array_for_each'
+  - 'snd_pcm_group_for_each_entry'
+  - 'snd_soc_dapm_widget_for_each_path'
+  - 'snd_soc_dapm_widget_for_each_path_safe'
+  - 'snd_soc_dapm_widget_for_each_sink_path'
+  - 'snd_soc_dapm_widget_for_each_source_path'
+  - 'sparsebit_for_each_set_range'
+  - 'strlist__for_each_entry'
+  - 'strlist__for_each_entry_safe'
+  - 'sym_for_each_insn'
+  - 'sym_for_each_insn_continue_reverse'
+  - 'symbols__for_each_entry'
+  - 'tb_property_for_each'
+  - 'tcf_act_for_each_action'
+  - 'tcf_exts_for_each_action'
+  - 'test_suite__for_each_test_case'
+  - 'tool_pmu__for_each_event'
+  - 'ttm_bo_lru_for_each_reserved_guarded'
+  - 'ttm_resource_manager_for_each_res'
+  - 'udp_lrpa_for_each_entry_rcu'
+  - 'udp_portaddr_for_each_entry'
+  - 'udp_portaddr_for_each_entry_rcu'
+  - 'usb_hub_for_each_child'
+  - 'v4l2_device_for_each_subdev'
+  - 'v4l2_m2m_for_each_dst_buf'
+  - 'v4l2_m2m_for_each_dst_buf_safe'
+  - 'v4l2_m2m_for_each_src_buf'
+  - 'v4l2_m2m_for_each_src_buf_safe'
+  - 'virtio_device_for_each_vq'
+  - 'vkms_config_for_each_connector'
+  - 'vkms_config_for_each_crtc'
+  - 'vkms_config_for_each_encoder'
+  - 'vkms_config_for_each_plane'
+  - 'vkms_config_connector_for_each_possible_encoder'
+  - 'vkms_config_encoder_for_each_possible_crtc'
+  - 'vkms_config_plane_for_each_possible_crtc'
+  - 'while_for_each_ftrace_op'
+  - 'workloads__for_each'
+  - 'xa_for_each'
+  - 'xa_for_each_marked'
+  - 'xa_for_each_range'
+  - 'xa_for_each_start'
+  - 'xas_for_each'
+  - 'xas_for_each_conflict'
+  - 'xas_for_each_marked'
+  - 'xbc_array_for_each_value'
+  - 'xbc_for_each_key_value'
+  - 'xbc_node_for_each_array_value'
+  - 'xbc_node_for_each_child'
+  - 'xbc_node_for_each_key_value'
+  - 'xbc_node_for_each_subkey'
+  - 'ynl_attr_for_each'
+  - 'ynl_attr_for_each_nested'
+  - 'ynl_attr_for_each_payload'
+  - 'zorro_for_each_dev'
+
+IncludeBlocks: Preserve
+IncludeCategories:
+  - Regex: '.*'
+    Priority: 1
+IncludeIsMainRegex: '(Test)?$'
+IndentCaseLabels: false
+IndentGotoLabels: false
+IndentPPDirectives: None
+IndentWidth: 8
+IndentWrappedFunctionNames: false
+JavaScriptQuotes: Leave
+JavaScriptWrapImports: true
+KeepEmptyLinesAtTheStartOfBlocks: false
+MacroBlockBegin: ''
+MacroBlockEnd: ''
+MaxEmptyLinesToKeep: 1
+NamespaceIndentation: None
+ObjCBinPackProtocolList: Auto
+ObjCBlockIndentWidth: 8
+ObjCSpaceAfterProperty: true
+ObjCSpaceBeforeProtocolList: true
+
+# Taken from git's rules
+PenaltyBreakAssignment: 10
+PenaltyBreakBeforeFirstCallParameter: 30
+PenaltyBreakComment: 10
+PenaltyBreakFirstLessLess: 0
+PenaltyBreakString: 10
+PenaltyExcessCharacter: 100
+PenaltyReturnTypeOnItsOwnLine: 60
+
+PointerAlignment: Right
+ReflowComments: false
+SortIncludes: false
+SortUsingDeclarations: false
+SpaceAfterCStyleCast: false
+SpaceAfterTemplateKeyword: true
+SpaceBeforeAssignmentOperators: true
+SpaceBeforeCtorInitializerColon: true
+SpaceBeforeInheritanceColon: true
+SpaceBeforeParens: ControlStatementsExceptForEachMacros
+SpaceBeforeRangeBasedForLoopColon: true
+SpaceInEmptyParentheses: false
+SpacesBeforeTrailingComments: 1
+SpacesInAngles: false
+SpacesInContainerLiterals: false
+SpacesInCStyleCastParentheses: false
+SpacesInParentheses: false
+SpacesInSquareBrackets: false
+Standard: Cpp03
+TabWidth: 8
+UseTab: Always
+...
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index c501cf84..7ec8cb0f 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -53,6 +53,8 @@ When preparing patches, please follow these guidelines:
 -   Separate large patches into logical patches
 -   Patch descriptions must end with your "Signed-off-by" line. This means your
     code meets the Developer's certificate of origin, see below.
+-   C code should be formatted using clang-format, using the .clang-format
+    configuration file at the root of this repository.
 
 When adding new, large features or tools it is best to discuss the
 design on the mailing list prior to submitting the patch.
-- 
2.50.1

