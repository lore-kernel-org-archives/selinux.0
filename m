Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfOAH0Qg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A9EB
	for <selinux@vger.kernel.org>; Wed, 13 Dec 2023 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702483772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrbngLgguQQaVnNjv70hhW6WKcGfOxhLueyP6HlAJBo=;
	b=cfOAH0Qgxu2r+X1YaKYoVSBTzIm+Y1gvXBA+IDvhpdvyT7bl+CporBBB3Z+3Bj9bsYZDws
	LlpblESX6Xtno/DMXjsE6s7EIl4Sdw07akHBEQ/Di1vksXUPHQ7vPOGZdPfPFLIo5//HUZ
	XXifqHA0ayDQMKUcF34FcvCvmk0bnCs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-INZB0PA8Numr5jfPBVpBfA-1; Wed, 13 Dec 2023 11:09:30 -0500
X-MC-Unique: INZB0PA8Numr5jfPBVpBfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BE4E86F135
	for <selinux@vger.kernel.org>; Wed, 13 Dec 2023 16:09:29 +0000 (UTC)
Received: from localhost (unknown [10.45.224.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D098E40C6EBA
	for <selinux@vger.kernel.org>; Wed, 13 Dec 2023 16:09:28 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Re: ANN: SELinux userspace 3.6
In-Reply-To: <87bkaurtrk.fsf@redhat.com>
References: <87bkaurtrk.fsf@redhat.com>
Date: Wed, 13 Dec 2023 17:09:27 +0100
Message-ID: <878r5yrsnc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Petr Lautrbach <lautrbach@redhat.com> writes:

Ups.

It 3.6 release, not 3.6-rc2



> Hello!
>
> The 3.6 release for the SELinux userspace is now available at:
>
> https://github.com/SELinuxProject/selinux/wiki/Releases
>
> Thanks to all the contributors, reviewers, testers and reporters!
>
> User-visible changes
> --------------------
>
> * dispol: add option to display users, drop duplicate option to display b=
ooleans,
>   show number of entries before listing them
>
> * libsepol: struct cond_expr_t `bool` renamed to `boolean`
>   The change is indicated by COND_EXPR_T_RENAME_BOOL_BOOLEAN macro
>
> * cil: Allow IP address and mask values to be directly written
>
> * cil: Allow paths in filecon rules to be passed as arguments
>
> * Add not self support for neverallow rules
>
> * dispol: Add the ability to show booleans, classes, roles, types and typ=
e attributes of policies
>
> * Improve man pages
>
> * libselinux: performance optimization for duplicate detection
>
> * dismod: add options: --actions ACTIONS, --help
>
> * dispol: add options: --actions ACTIONS, --help
>
> * checkpolicy: Add the command line argument -N, --disable-neverallow
>
> * Introduce getpolicyload - a helper binary to print the number of policy=
 reloads on the running system
>
> * man pages: Remove the Russian translations
>
> * Add notself and other support to CIL
>
> * Add support for deny rules
>
> * Translations updated from
>   https://translate.fedoraproject.org/projects/selinux/
>
> * Bug fixes
>
> Development-relevant changes
> ----------------------------
>
> * ci: bump Fedora to version 39
>
> * Drop LGTM.com and Travis CI configuration
>
> Shortlog of the changes since 3.5 release
> -----------------------------------------
> Bruno Victal (1):
>       secilc: Use versioned DocBook public identifier.
>
> Cameron Williams (1):
>       Add CPPFLAGS to Makefiles
>
> Cathy Hu (1):
>       sepolicy/manpage.py: make output deterministic
>
> Christian G=C3=B6ttsche (115):
>       libsepol: Add not self support for neverallow rules
>       checkpolicy: add not-self neverallow support
>       libsepol/tests: add tests for not self neverallow rules
>       libsepol/tests: add tests for minus self neverallow rules
>       libsepol: rename struct member
>       checkpolicy: update cond_expr_t struct member name
>       libsepol/tests: rename bool indentifiers
>       checkpolicy: rename bool identifiers
>       libsepol: rename bool identifiers
>       libsemanage/tests: rename bool identifiers
>       libsemanage: fix memory leak in semanage_user_roles
>       checkpolicy/dispol: add output functions
>       libselinux: set CFLAGS for pip installation
>       checkpolicy: drop unused token CLONE
>       checkpolicy: reject condition with bool and tunable in expression
>       checkpolicy: only set declared permission bits for wildcards
>       libsepol: dump non-mls validatetrans rules as such
>       libsepol: validate some object contexts
>       libsepol: validate old style range trans classes
>       libsepol: validate: check low category is not bigger than high
>       libsepol: validate: reject XEN policy with xperm rules
>       libsepol: expand: skip invalid cat
>       libsepol: drop message for uncommon error cases
>       libsepol: drop duplicate newline in sepol_log_err() calls
>       libsepol: replace sepol_log_err() by ERR()
>       libsepol: replace log_err() by ERR()
>       checkpolicy: add option to skip checking neverallow rules
>       checkpolicy/dismod: misc improvements
>       libsepol: free initial sid names
>       libsepol: check for overflow in put_entry()
>       libsepol/fuzz: more strict fuzzing of binary policies
>       setsebool: improve bash-completion script
>       setsebool: drop unnecessary linking against libsepol
>       semodule_expand: update
>       semodule_link: update
>       semodule_package: update
>       semodule_unpackage: update
>       libselinux/utils: introduce getpolicyload
>       libsepol: validate: use fixed sized integers
>       hashtab: update
>       libsepol: expand: use identical type to avoid implicit conversion
>       libsepol: expand: check for memory allocation failure
>       libsepol: ebitmap: avoid branches for iteration
>       libsemanage/tests: use strict prototypes
>       libsepol: update CIL generation for trivial not-self rules
>       libselinux/utils: update selabel_partial_match
>       libselinux: misc label cleanup
>       libselinux: drop obsolete optimization flag
>       libselinux: drop unnecessary warning overrides
>       setfiles: do not issue AUDIT_FS_RELABEL on dry run
>       libselinux: constify selabel_cmp(3) parameters
>       libselinux: simplify zeroing allocation
>       libselinux/utils: use type safe union assignment
>       libselinux: avoid regex serialization truncations
>       libselinux: parameter simplifications
>       libselinux/utils: use correct type for backend argument
>       libselinux: update string_to_mode()
>       libselinux: fix logic for building android backend
>       libselinux: avoid unused function
>       libselinux: check for stream rewind failures
>       libselinux: simplify internal selabel_validate prototype
>       libselinux/utils: drop include of internal header file
>       libselinux: free elements on read_spec_entries() failure
>       libselinux: set errno on label lookup failure
>       libsepol: reject avtab entries with invalid specifier
>       libsepol: avtab: check read counts for saturation
>       checkpolicy: add round-trip tests
>       libselinux/utils: update getdefaultcon
>       libselinux: cast to unsigned char for character handling function
>       libselinux: introduce reallocarray(3)
>       libsepol: validate default type of transition is not an attribute
>       libsepol: validate constraint depth
>       libsepol: more strict validation
>       libsepol: reject unsupported policy capabilities
>       libsepol: use str_read() where appropriate
>       libsepol: adjust type for saturation check
>       libsepol: enhance saturation check
>       libsepol: validate the identifier for initials SID is valid
>       Drop LGTM.com configuration
>       Drop Travis CI configuration
>       scripts: ignore unavailable interpreters
>       ci: bump Fedora to version 39
>       libselinux: update Python binding
>       Update Python installation on Debian
>       scripts: update run-scan-build
>       semodule_link: avoid NULL dereference on OOM
>       libsepol: set number of target names
>       libselinux: fix memory leak in customizable_init()
>       libsepol: avoid leak in OOM branch
>       libsepol: avoid memory corruption on realloc failure
>       libsepol: update policy capabilities array
>       github: bump action dependencies
>       libsepol: validate common classes have at least one permissions
>       libsepol: include length squared in hashtab_hash_eval()
>       libsepol: use DJB2a string hash function
>       libsepol/cil: use DJB2a string hash function
>       libselinux: use DJB2a string hash function
>       newrole: use DJB2a string hash function
>       libsepol: avoid fixed sized format buffer for xperms
>       libsepol: avoid fixed sized format buffer for xperms
>       libsepol: validate conditional type rules have a simple default type
>       libsepol: use correct type to avoid truncations
>       checkpolicy/dismod: avoid duplicate initialization and fix module l=
inking
>       libsepol: reject invalid class datums
>       libsepol/fuzz: handle empty and non kernel policies
>       libsepol: reject linking modules with no avrules
>       libsepol: simplify string formatting
>       checkpolicy/dispol: misc updates
>       libsepol: constify tokenized input
>       libsepol: avoid integer overflow in add_i_to_a()
>       libsepol: extended permission formatting cleanup
>       libsepol: validate empty common classes in scope indices
>       libselinux: update const qualifier of parameters in man pages
>       libselinux: always set errno on context translation failure
>       libselinux: state setexecfilecon(3) sets errno on failure
>
> Dominick Grift (1):
>       secilc/docs: fixes filecon example
>
> Huaxin Lu (4):
>       libselinux: add check for calloc in check_booleans
>       restorecond: add check for strdup in strings_list_add
>       secilc: add check for malloc in secilc
>       libsepol: add check for category value before printing
>
> Huizhao Wang (1):
>       restorecond: compatible with the use of EUID
>
> James Carter (53):
>       Revert "libsepol/cil: add support for prefix/suffix filename transt=
ions to CIL"
>       Revert "checkpolicy,libsepol: add prefix/suffix support to module p=
olicy"
>       Revert "checkpolicy,libsepol: add prefix/suffix support to kernel p=
olicy"
>       Revert "libsepol: implement new module binary format of avrule"
>       Revert "libsepol: implement new kernel binary format for avtab"
>       Revert "checkpolicy,libsepol: move filename transition rules to avr=
ule"
>       Revert "checkpolicy,libsepol: move filename transitions to avtab"
>       Revert "checkpolicy,libsepol: move transition to separate structure=
 in avtab"
>       libsepol/cil: Fix class permission verification in CIL
>       python: Use isinstance() instead of type()
>       checkpolicy: Remove the Russian translations
>       gui: Remove the Russian translations
>       libselinux: Remove the Russian translations
>       libselinux: Remove the Russian translations
>       libsemanage: Remove the Russian translations
>       libsepol: Remove the Russian translations
>       mcstrans: Remove the Russian translations
>       policycoreutils: Remove the Russian translations
>       python: Remove the Russian translations
>       python: Remove the Russian translations
>       restorecond: Remove the Russian translations
>       sandbox: Remove the Russian translations
>       semodule-utils: Remove the Russian translations
>       Do not automatically install Russian translations
>       libsepol: Changes to ebitmap.h to fix compiler warnings
>       libsepol/cil: Do not call ebitmap_init twice for an ebitmap
>       libsepol/cil: Add notself and other support to CIL
>       libsepol: Use ERR() instead of log_err()
>       secilc/docs: Add notself and other keywords to CIL documentation
>       secilc/test: Add notself and other tests
>       libsepol/cil: Parse and add deny rule to AST, but do not process
>       libsepol/cil: Add cil_list_is_empty macro
>       libsepol/cil: Add cil_tree_node_remove function
>       libsepol/cil: Process deny rules
>       libsepol/cil: Add cil_write_post_ast function
>       libsepol: Export the cil_write_post_ast function
>       secilc/secil2tree: Add option to write CIL AST after post processing
>       secilc/test: Add deny rule tests
>       secilc/docs: Add deny rule to CIL documentation
>       checkpolicy: Remove support for role dominance rules
>       libsepol: Fix the version number for the latest exported function
>       libsepol/tests: Update the order of neverallow test results
>       libsepol/cil: Use struct cil_db * instead of void *
>       libsepol/cil: Refactor and improve handling of order rules
>       libsepol/cil: Allow IP address and mask values to be directly writt=
en
>       secilc/docs: Update syntax for IP addresses and nodecon
>       libsepol/cil: Refactor Named Type Transition Filename Creation
>       libsepol/cil: Allow paths in filecon rules to be passed as arguments
>       secilc/docs: Fix and update the documentation for macro parameters
>       libsepol/cil: Add pointers to datums to improve writing out AST
>       libsepol/cil: Give warning for name that has different flavor
>       libsepol/cil: Do not allow classpermissionset to use anonymous clas=
spermission
>       libsepol/cil: Clear AST node after destroying bad filecon rule
>
> Jeffery To (1):
>       python/sepolicy: Fix get_os_version except clause
>
> Juraj Marcin (8):
>       checkpolicy,libsepol: move transition to separate structure in avtab
>       checkpolicy,libsepol: move filename transitions to avtab
>       checkpolicy,libsepol: move filename transition rules to avrule
>       libsepol: implement new kernel binary format for avtab
>       libsepol: implement new module binary format of avrule
>       checkpolicy,libsepol: add prefix/suffix support to kernel policy
>       checkpolicy,libsepol: add prefix/suffix support to module policy
>       libsepol/cil: add support for prefix/suffix filename transtions to =
CIL
>
> Masatake YAMATO (10):
>       dismod: add --help option
>       dismod: delete an unnecessary empty line
>       dismod: handle EOF in user interaction
>       dismod: add --actions option for non-interactive use
>       dispol: add --help option
>       dispol: delete an unnecessary empty line
>       dispol: handle EOF in user interaction
>       dispol: add --actions option for non-interactive use
>       dismod: print the policy version only in interactive mode
>       dismod, dispol: reduce the messages in batch mode
>
> Ondrej Mosnacek (4):
>       libsemanage: include more parameters in the module checksum
>       scripts/ci: install rdma-core-devel for selinux-testsuite
>       libsepol: stop translating deprecated intial SIDs to strings
>       libsepol: add support for the new "init" initial SID
>
> Petr Lautrbach (9):
>       python: improve format strings for proper localization
>       python: Drop hard formating from localized strings
>       semanage: Drop unnecessary import from seobject
>       python: update python.pot
>       Update translations
>       Update VERSIONs to 3.6-rc1 for release.
>       Update VERSIONs to 3.6-rc2 for release.
>       sepolicy: port to dnf4 python API
>       Update VERSIONs to 3.6 for release.
>
> Sergei Trofimovich (1):
>       libsemanage: fix src/genhomedircon.c build on `gcc-14` (`-Werror=3D=
alloc-size`)
>
> Stephen Smalley (2):
>       libselinux,policycoreutils,python,semodule-utils: de-brand SELinux
>       checkpolicy,libselinux,libsepol,policycoreutils,semodule-utils: upd=
ate my email
>
> Topi Miettinen (1):
>       sepolicy: clarify manual page of sepolicy interface
>
> Vit Mojzis (12):
>       python/chcat: Improve man pages
>       python/audit2allow: Add missing options to man page
>       python/semanage: Improve man pages
>       python/audit2allow: Remove unused "debug" option
>       policycoreutils: Add examples to man pages
>       python/sepolicy: Improve man pages
>       sandbox: Add examples to man pages
>       checkpolicy: Add examples to man pages
>       libselinux: Add examples to man pages
>       python/sepolicy: Fix template for confined user policy modules
>       python/sepolicy: Add/remove user even when SELinux is disabled
>       python: Harden more tools against "rogue" modules
>
> wanghuizhao (3):
>       libselinux: migrating hashtab from policycoreutils
>       libselinux: adapting hashtab to libselinux
>       libselinux: performance optimization for duplicate detection

