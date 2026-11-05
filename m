Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910924;
	b=gtspi7q435WPUIO3iA+FMXBS6FYlaV77rKAsjmfzAhZdPKHF6GnmnlPyxG+GBIBWBKw2
	 yr7suxPAhNniiMk5ieR/dC2L0rd8WJ2wILagVLP4O7+XsSDyA58YJcYxDvIddQkhMF3vm
	 YnNqPpVDZy3UoSHVKdK1N+6y3G90xoDZXuEiyK71o+VTzPGJV3eze7XPTsZ0Tx4wLknDy
	 8FgC3cEkaN4rtUiMj7r2FYESYbPK3CsIlRzjbqJkQfWgzDkEfXXMUOa7mFwYN2g+i19zO
	 0pwacPIJqcOybOEJVFLfNGrwSozjbjtouxmVbeqs/Atf2Yyd7WzHHQrG3TZEo+SJgzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910924;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=o/oRutfLOYemiVjOcANzWkHCBWzGBse3nlUuKEm4Peo=;
	b=LVm+zo68eWLTGCNom9llDHJyCa7RoMK2xMffaNxaOueEScHdpKyKmNIwUOapIUJh8WQa
	 mgTOFOFzMfokzQfTBd+ZGXVPPn0oJEka94lDrVHPEbEb0wgS6eKVPLYDdB9su1VNdrQOx
	 yvyhNvQ1LXd6t3cL7EBLu+I74RFlaN7STbqs/AVIbEjapzQYonB8w9d7bKixsyafKgzRQ
	 OSA3XYQIb/GB//PH4a0WsYiHR8VVb+Gsc9vgMhORHKJgMqgre6Xbwy6F9dHhlx6Njztvj
	 K6JjdwUVd+jH2VeAAV5sspcEcP0vkCpGZcJ6au6gvwbb/TYwVAfMIuaxDK1Jyu6Q/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OnB90euW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C403606D812
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 20:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C403606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OnB90euW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793910922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o/oRutfLOYemiVjOcANzWkHCBWzGBse3nlUuKEm4Peo=;
	b=OnB90euWb/oNYcll9SAlZSk/a6/40VWZNeg8jwe1cVZOgk+PkVkiun8UaDhVLwjnVnGr79
	BWW5VE8d0za+euhT8kxXaOVVrD14Q9SBm84rgpJRW5/ZNKvtrmcJ65RwVNZ8RWc0sCdAdE
	u9EhTF9QU+JKNDH1+/cmYROpebum3yw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-Tf5172wmMmGqDEfc2SDa4Q-1; Thu,
 05 Nov 2026 15:35:20 -0500
X-MC-Unique: Tf5172wmMmGqDEfc2SDa4Q-1
X-Mimecast-MFC-AGG-ID: Tf5172wmMmGqDEfc2SDa4Q_1793910920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F215F19560AA
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 20:35:19 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2253530000E3
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 20:35:18 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.12-rc1 release
Date: Thu, 05 Nov 2026 21:35:16 +0100
Message-ID: <pjda4nnow3f.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello!

The 3.12-rc1 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.12-rc1
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know and I'll update the release notes.

RELEASE 3.12-rc1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

User-visible changes since 3.11
-------------------------------

- Introduced a fallback configuration-root search in libselinux: the config
  file, binary policies, contexts/*, seusers, file_contexts and other
  runtime files are now looked up under /etc/selinux first and then under
  /usr/lib/selinux (the fallback list is overridable at build time),
  supporting hermetic-/usr and factory-reset systems where /etc is empty at
  boot.
- Added support for read-only policy module store roots in libsemanage via a
  new semanage.conf ro-store-root option: vendor modules can be shipped
  under /usr/lib/selinux and are searched after the writable store-root when
  reading, while the writable store contains only the local customizations.
  Module listings span every store root and modules owned by a read-only
  store cannot be removed or enabled. semanage.conf itself is now searched
  under both /etc and /usr/lib.
- semodule and other libsemanage users now block on the module store lock by
  default instead of giving up after five seconds, making overlapping
  semodule transactions from rpm scriptlets or configuration management
  reliable (#181).
- Added a semanage.conf option to sort file_contexts.local by specificity so
  that the most specific local file-context customization wins instead of
  the most recently added one (#40).
- Added support for UTF-8 in file-context specifications (can be disabled at
  build time with DISABLE_UTF=3Dy).
- Allowed a '*' whole-component wildcard in file_contexts.subs_dist/.subs
  substitution rules, e.g. to remap systemd-sysext/confext staging trees
  (#491).
- Added a --multiple-decls option to checkpolicy and libsepol to allow a ty=
pe
  or type attribute to be declared more than once, with the declarations
  merged, mirroring the secilc option of the same name.
- Added -r, -i and -V options to sefcontext_compile to omit precompiled
  regular expressions from the output (PCRE2 only) and to report
  regular-expression and compiled format information.
- setfiles now uses all available CPU cores by default, honors the
  RESTORECON_THREADS environment variable, enables
  SELINUX_RESTORECON_REALPATH by default so that files are labeled based on
  their canonical pathname (#540), and provides a new -j option to skip
  files with multiple hard links.
- fixfiles passes -I and -D through to setfiles/restorecon, omits excluded
  mounts from the relabel list, and no longer performs the obsolete /tmp
  cleanup.
- Improved sandbox cleanup and command handling, including quoting the
  command written to .sandboxrc and by sandboxX.sh, and removing temporary
  directories on error paths.
- Dropped support for kernel policy versions older than 30 (Linux v4.3) and
  modular policy versions older than 18 in libsepol; this affects building,
  converting and analyzing policies that use older versions. libselinux no
  longer probes legacy /selinux and /proc nodes for selinuxfs, making Linux
  v3.0 the minimum supported kernel version (#468).
- Bug fixes

Security/hardening changes
--------------------------

- Significantly strengthened validation of binary and source policies in
  libsepol and checkpolicy, including checks on policy versions, symbol and
  scope tables, permissions, MLS components and levels, type aliases, and
  path, port and other labeling fields; invalid or malformed policy data is
  rejected instead of being processed unsafely. checkpolicy now also
  validates the policy database before writing it.
- Added overflow, bounds and allocation checks across libsepol, libsemanage,
  libselinux, checkpolicy and secilc.
- Fixed a regular-expression denial of service (ReDoS) in file-context
  matching and made PCRE2 JIT compilation opt-in.
- Hardened sandbox, newrole, restorecond and mcstrans handling of commands,
  temporary files, signals and configuration data, including constant-time
  comparison of shadow password hashes in newrole, bounded Include nesting
  depth in mcstrans, a hardened mcstrans systemd service file, and use of
  openat2() where available in sandbox/seunshare, restorecond and
  selinux_restorecon(3).
- Improved thread safety in libselinux: the AVC now uses pthread mutexes by
  default when no locking callbacks are set, making selinux_check_access(3)
  and related interfaces thread-safe, with similar serialization of the
  class/permission string mapping and status page handling (#287, #335,
  #336).

Development-relevant changes
----------------------------

- Added fuzzers and bad-data tests for policy, module, CIL, file-context and
  package processing; expanded fuzzing documentation and seed corpora.
- Improved CI and fuzzing workflows, added format checking across branches,
  and removed the CircleCI configuration.
- Added pyproject.toml build configuration for the libselinux and sepolicy
  Python modules.
- Documented the minimum supported kernel and policy versions in README.md
  and updated the security disclosure and maintainer process documentation.


Shortlog of the changes since 3.11 release
------------------------------------------
Akhil Kohli (6):
      checkpolicy: add bad data protection tests
      semodule-utils: add bad-data tests for semodule_package
      semodule-utils: add bad-data tests for sefcontext_compile
      checkpolicy: extend bad-data tests for type, role, and user errors
      checkpolicy: add robustness tests for large policy inputs
      semodule-utils: add bad-data tests for link/expand neverallow

Bill Roberts (1):
      SECURITY.md: remove William Roberts

Carlo Marcelo Arenas Bel=C3=B3n (1):
      libselinux: improve performance with pcre matches

Cathy Hu (1):
      Fix double-free in secilcheck

Christian G=C3=B6ttsche (25):
      libselinux/include: fix man page grammar, wording and consistency nits
      libselinux/utils: fix matchpathcon usage
      libselinux: strip only a trailing newline in type lookups
      libselinux: drop undefined fflush(stdin) calls
      libselinux: guard possibly-NULL role/level in getdefaultcon -v output
      libselinux: check buffer before pointer arithmetic in regex_format_er=
ror
      libselinux: free resources on avc_init_internal failure
      libselinux: assert avc_running in avc_compute_create
      libselinux: add missing newline to label_db invalid-format warning
      libselinux: initialize output context in raw_context_to_color()
      libselinux: bound permission loop in selinux_set_mapping()
      libselinux: simplify type extraction in find_default_type
      libselinux: avoid integer overflow in security_compute_user_raw()
      libselinux: check strdup() allocations in getseuser()
      libselinux: fall back to a default page size if sysconf() fails
      libselinux: simplify canonicalize_context() fallback
      libselinux/audit2why: check allocations in audit2why load_booleans()
      libselinux/audit2why: reject non-string entries in the permission list
      libselinux/audit2why: fix double-free and harden boolean handling
      newrole: fix minor leaks and uninitialized status
      newrole: compare shadow hashes in constant time
      newrole: wait only for the forked shell
      newrole: ensure the standard file descriptors are open on startup
      newrole: fail closed for -l when the terminal context is unknown
      CIL: misc doc updates

Daniel Burgener (1):
      libselinux: Use correct struct name in comments

Eugenij Safonov (2):
      libsemanage: add path substitution helpers
      libsemanage/genhomedircon: apply path substitution rules to home dire=
ctories

Evgeniy Gorbanyov (1):
      libselinux: avcstat: reject out-of-range interval values

Inseob Kim (1):
      libsepol,checkpolicy: add --multiple-decls option

James Carter (41):
      libselinux: Add overflow checks
      libsemanage: Add overflow checks
      libsepol/cil: Add overflow checks for circular reference checks
      libsepol/cil: Add overflow checks and cil_reallocarray
      libsepol: Add overflow checks to strs_* family of functions
      libsepol: Add overflow checks
      libsepol: Prevent OOB access of array when copying scope information
      libsepol: Check for embedded NUL when reading from policy file
      libsepol: Validate string fields used in various labeling rules
      libsepol/cil: Fix double free in cil_deny.c
      libsepol: Validate more access vector permissions
      libsepol: Validate scope index class_perm_map array
      libsepol: Add overflow checks when linking file and netfilter contexts
      libsepol: Use size_t for counting bytes in module.c
      libsepol/cil: Return SEPOL_ERR on failure to set bit
      libsepol: Check for invalid categories when expanding semantic levels
      libsepol: Turn assert into error in type_set_expand()
      libsepol/fuzz: Exercise module to CIL code when fuzzing
      libsepol: Check for zero when mapping identifier values
      libsepol/fuzz: Validate output of expand_module() before proceeding
      secilc: Use size_t for file sizes
      libsepol: Do not convert mls rules to CIL for a non-mls policy
      libsepol: Validate any levels that appear in a policy
      libsepol: Copy a chain of type alias references
      libsepol: Improve the validation of type aliases
      libsepol: Skip aliases when creating the type_attr_map
      libsepol: Free context on genfscon wildcard error in kernel_to_*
      libsepol: Use spaceship comparison operator when comparing ibpkeys
      libsepol: Check that a module does not have any commons when validati=
ng
      libsepol: Use matching integer types in scope_write()
      libsepol: Check all the permissions in sepol_check_access()
      libsepol: Validate expressions do not mix tunables and booleans
      libsepol: Remove assertion and comment from discard_tunables()
      libsepol: Move the PERMISSION_MASK macro to private.h
      libsepol: Remove junk permissions before optimzing the policy
      libsepol: Tighten validation of scope index class_perm_map array
      checkpolicy: Check for mls constraint expression in non-mls policy
      libsepol/tests: Remove non-MLS downgrade test
      libsepol: Check for mls components in non-mls policy during validation
      libsepol: Validate the genfs file type class
      libsepol: Improve validation of scopes

Jason Zaman (3):
      SECURITY.md: Update security contacts
      ci: Drop circleci config
      SECURITY.md: Codify the maintainer process

Joe-Ju-Alpha (1):
      sestatus: avoid self-referential symlink

Johannes Segitz (4):
      selinux_restorecon: Do not exit on directory cycles
      man: Document directory cycle handling of selinux_restorecon
      policycoreutils: Using vendor defined directories for configuration f=
iles
      mcstrans: harden systemd service file

Johnny Boero (3):
      policycoreutils/setfiles: reject invalid -T arguments
      policycoreutils/setfiles: use all CPU cores by default
      policycoreutils/setfiles: honor RESTORECON_THREADS

Md Shafiuzzaman (1):
      checkpolicy: fix double free of fstype in define_genfs_context_helper

Nicolas Iooss (1):
      SECURITY.md: Nicolas Iooss is stepping down

Ondrej Mosn=C3=A1=C4=8Dek (1):
      SECURITY.md: update Ondrej's email address and add GPG fingerprint

Petr Lautrbach (3):
      libselinux: Replace PyString_FromString with PyUnicode_FromString for=
 SWIG 4.5.0 compatibility
      Add support for UTF-8 in file context specifications
      Update VERSIONs to 3.12-rc1 for release.

Petr Matyas (5):
      libsepol: add module package fuzzer
      libselinux: fix infinite loop and missing errno in partial <<none>> l=
ookup
      libselinux: prevent ReDoS in file context regex matching
      scripts/oss-fuzz: build PCRE2 from source with sanitizer instrumentat=
ion
      libselinux: fix SEGV in JIT matching of recursive patterns in partial=
 mode

Pragati Hatkamkar (1):
      policycoreutils: omit excluded mounts from the fixfiles relabel list

Stephen Smalley (196):
      policycoreutils/newrole: fix formatting
      libselinux: selinux_restorecon: use openat2 if defined
      restorecond: use openat2 if defined
      sandbox/seunshare: pin_dir: use openat2 if available
      libselinux: drop legacy probing of /selinux and /proc nodes for selin=
uxfs
      libselinux: avc: use pthread mutexes by default when no lock callback=
s set
      libselinux: stringrep: serialize access to the discover_class_cache
      libselinux: sestatus: serialize selinux status updates
      libselinux: stringrep: snapshot perm names in security_av_string()
      libselinux: update man pages for new thread safety guarantees
      policycoreutils/setfiles: introduce -j for skip_multilink
      libsemanage: user_base_parse: prevent OOB read on truncated config
      libselinux: selinux_set_mapping(): reject class tables with too many =
classes
      libselinux: label_file: check next_entry() when skipping
      libselinux: matchpathcon: make filespec table per thread and bound sp=
ecind
      libselinux: label_file: fstat after open in open_file()
      libselinux: label_db: prevent integer overflows on resizing
      libsemanage: direct_api: clamp write length in ERR_CHLD_STDERR()
      mcstrans: defer SIGTERM cleanup to the main loop
      mcstrans: bound Include nesting depth
      policycoreutils/run_init: handle NULL from crypt() in non-PAM build
      policycoreutils/run_init: fix EINTR/EAGAIN checking in open_init_pty
      policycoreutils/hll/pp: use argv[optind] appropriately
      semodule-utils/semodule_package: report the output filename on write =
errors
      mcstrans: fix inverted alias skip check in compute_trans_from_raw()
      policycoreutils/scripts/fixfiles: drop /tmp cleanup
      policycoreutils/setfiles: fix -f handling
      restorecond: switch terminate to sig_atomic_t for async-signal-safety
      restorecond: copy homedir to avoid overwrite by later getpw*() calls
      restorecond: fix type of utmpwatcher_handle()
      restorecond: fix isspace() call to cast to unsigned
      mcstrans: match base classification and word text case-insensitively
      libselinux: do not call close(fd) when fd < 0
      libselinux: selabel_digest -v: handle unexpected output
      python/sepolicy: generate: drop or merge symbol table overwrites
      policycoreutils/secon: ensure that range_bg is not left NULL
      sandbox/seunshare: free glob on error path
      sandbox/seunshare: make a best-effort to remove tmpdir on error paths
      sandbox/seunshare: cap rm_rf() depth
      sandbox/seunshare: make -W/-P .. check exact
      sandbox/seunshare: document that -C has long been a no-op
      sandbox/seunshare: remove files under tmpdir as user
      sandbox/sandbox: use slicing rather than re.sub in copyfile()
      sandbox/sandbox: shred the correct directory
      sandbox/sandbox: clean up the runuserdir
      sandbox/sandboxX.sh: quote the command line arguments
      sandbox/seunshare.8: Fix typo
      libsemanage: semanage_pipe_data(): multiplex the compiler pipes
      policycoreutils/scripts/fixfiles: drop unused functions
      python/sepolgen: port policygen.py to setools 4 API
      libselinux: fix Python binding for security_load_policy()
      mcstrans: increase context length limit in secolor.conf
      libselinux: add pyproject.toml file
      python/sepolicy: add a pyproject.toml file
      libsemanage: block on store lock by default
      Revert "libselinux: add pyproject.toml file"
      Revert "python/sepolicy: add a pyproject.toml file"
      libsepol: fix formatting
      libsepol: cap max depth for __evaluate_classperms_list()
      checkpolicy/fuzz: ignore invalid policy versions for the Xen target
      libselinux: add pyproject.toml file
      python/sepolicy: add a pyproject.toml file
      policycoreutils/sestatus: fix formatting
      libsepol: fix direct leak in user_extra_to_cil()
      libsepol: Cap max depth and processed nodes for cil_tree_walk()
      .github/workflows/cifuzz.yml: update branch and upload-artifact
      libsepol: log an error if we hit the max depth for __evaluate_classpe=
rms_list()
      libsepol: reject policies with no avtab entries in expand_module()
      .github/workflows/check_format.yml: run on all branches
      README.md: add Check format badge and link
      libsepol: validate type datum value even for aliases
      libsepol: Prevent NULL dereference in hierarchy_add_type_callback
      libsepol,checkpolicy: drop support for kernel policy versions < 24
      checkpolicy-fuzzer: drop invalid assertion
      README.md: document the minimum kernel policy version
      .github/actions/build-userspace: drop duplicated make install, fix co=
mment
      libsepol: drop support for modular policy versions < 10
      README.md: clarify minimum supported kernel and policy versions
      .github/workflows/tf_testsuite.yml: skip testing farm on pull requests
      README.md: Further elaboration on minimum policy versions
      libselinux: selinux_check_access: fail cleanly if avc_open() failed
      mcstrans: escape config text spliced into build_regexps() patterns
      libsemanage: treat module data as bytes in the Python bindings
      libselinux: selinux_restorecon: fix error message on intermediate sym=
links
      policycoreutils/setfiles: enable SELINUX_RESTORECON_REALPATH by defau=
lt
      python/sepolicy: add missing socket template attributes
      checkpolicy: fix operator precedence in flavor check
      libselinux: sefcontext_compile: include limits.h
      libselinux: label_file: make JIT compilation opt-in
      libsepol: do not infer name-based bounds for attributes
      libselinux: setrans_client: free daemon response on error
      python/sepolicy: escape literal paths written to generated .fc files
      libsemanage: semanage_list_sort: handle a NULL *l correctly
      scripts/oss-fuzz.sh: revert building PCRE2
      FUZZING.md,*/fuzz: document selinux fuzzing
      libsepol: add include/sepol/cil symlink for in-tree builds
      libsepol: do not reject control characters in pathnames
      FUZZING.md,{libsepol,checkpolicy,libselinux}/Makefile: fix fuzzer bui=
lds
      .github/workflows/run_tests.yml: use a modern refpolicy release
      libsepol: drop support for policy versions before xperms_ioctl/xen_de=
vicetree
      libsepol,checkpolicy: validate devicetree paths
      libsemanage: optionally sort file_contexts.local by specificity
      libselinux: add a configuration-root search list
      libselinux: search for the binary policy across configuration roots
      libselinux: fall back through configuration roots
      libselinux: search file_contexts files across configuration roots
      libsemanage: accept a list of read-only fallback store roots
      libsemanage: add semanage_module_find_path() and use it for reads
      libsemanage: list modules across every store root
      libsemanage: read the active store through the fallback list
      libsemanage: create the writable store skeleton on first transaction
      libsemanage: create the store root when taking a lock
      libsemanage: refuse to remove or enable a module owned by a RO store
      libsemanage: search /etc and /usr/lib for semanage.conf
      libsemanage: document semanage.conf search path and ro-store-root
      libselinux: allow a '*' wildcard in file_contexts.subs_dist/.subs
      libsepol: validate portcon protocol values
      libsepol: validate genfs_seclabel_wildcard paths
      libsepol: check user MLS levels by scope not policy type
      libsepol,checkpolicy,python/semanage: validate portcon ranges
      libsepol,checkpolicy,secilc: split min/max policydb versions between =
SELinux and Xen
      libsepol: only read/write the neveraudit map for SELinux policies
      libsepol,checkpolicy: update remaining policyvers comparisons to corr=
ectly handle Xen policies
      libselinux: fall through on EACCES when searching configuration roots
      libsemanage: fall through on an unreadable semanage.conf
      libsepol: restore basic validation for path/component names
      libsepol/fuzz: add POLICY_BASE and POLICY_MOD seed corpus entries
      libsepol/fuzz: add Xen, v30 kernel and v18 module seed corpus entries
      libsepol/fuzz: link a trailing module into a base policy
      libsepol: use the correct value in validate_type_datum() for TYPE_ALI=
AS
      libsepol: module_to_cil: warn and drop non-trivial -self neverallows
      libselinux/Makefile: use $(MAKE) instead of a bare make for fuzz clean
      libsepol/fuzz/Makefile: drop -I../cil/include from CFLAGS
      libsepol: reject out-of-range OCON_PORT field at read time
      libsepol,checkpolicy: reject out-of-range pirqcon values
      libsepol/cil: reject control characters in ocontext name fields
      libsepol: validate port range in port_from_record()
      libsepol: drop dead store in ocontext_read_xen()
      libselinux: fix incorrect regexp anchoring
      libsepol: skip unrequired class slots in is_decl_requires_met()
      python/semanage: update semanage-fcontext.8 for fixed regex anchoring
      policycoreutils/scripts/fixfiles: pass -I/-D through to setfiles/rest=
orecon
      libsepol: consolidate IPPROTO_DCCP/SCTP fallbacks into kernel_to_comm=
on.h
      libsemanage: reject out-of-range ports when parsing the store
      checkpolicy: preserve policy type when reading a binary module
      secilc: drop stale integration.cil test, exercise bounds in policy.cil
      libsepol: emit userbounds and fix rolebounds order when writing CIL
      libselinux: export selinux_policy_open()
      mcstrans: search fallback configuration roots for setrans.conf and se=
color.conf
      policycoreutils/run_init: search fallback configuration roots for ini=
trc_context
      restorecond: search fallback configuration roots for the watch lists
      policycoreutils/newrole: search fallback location for newrole_pam.conf
      policycoreutils/scripts/fixfiles: search fallback configuration roots
      python/semanage: document and export the user labeling prefix
      python/semanage: fall back to filename completion for fcontext paths
      libselinux: add Python binding for selinux_policy_open()
      python: read policy configuration files via selinux.policy_open()
      SECURITY.md: update to reflect our current disclosure practice
      sandbox: shell-quote the command written to .sandboxrc
      python/sepolgen: search fallback location for sepolgen.conf
      gui/statusPage.py: also enumerate policy types under /usr/lib/selinux
      userspace: update man pages for /usr/lib fallbacks
      libsepol: compare policy_type, not policyvers, with POLICY_KERN
      libsepol: skip initial SIDs with no assigned context in module_to_cil
      libsepol: clear attribute member set after building type_attr_map
      checkpolicy: validate policydb before writing
      libsemanage: preserve read-only store overrides
      libsemanage: preserve cached records when replacement cloning fails
      libsemanage: release the transaction lock when setup fails
      libsemanage: clear freed keys during component merges
      libsemanage: report commit flag-file errors after user updates
      libsemanage: clear the policy file pointer after reading a cache
      libsemanage: handle module writer close and cleanup errors
      libsemanage: use the available user name when a join fails
      CONTRIBUTING.md: sync with Contributing wiki page
      libsemanage: synchronize user join caches across transactions
      libselinux: wait for relabel completion before writing digests
      libselinux: publish restorecon error counts on every successful call
      libselinux: preserve restorecon failure errno through traversal and c=
leanup
      libselinux: skip read-open for excluded directories in restorecon
      libselinux: skip read-open across restorecon device boundaries
      libselinux: fail file label initialization on auxiliary path OOM
      libselinux: clear consumed source children during context merge
      libselinux: include substitution dependencies in directory digests
      libselinux: select readable file-context configuration inputs
      libselinux: grow the digest specification file list dynamically
      libselinux: preserve the opened policy version when loading
      libselinux: preserve auxiliary file-context duplicate handling
      libselinux: record specification paths for Android backends
      libselinux: let Python own policy_open descriptor cleanup
      libselinux: free regex match data when TLS assignment fails
      libselinux: require a component boundary when remapping policy roots
      libselinux: propagate file-context regex match failures
      libselinux: fail AVC initialization when a default lock allocation fa=
ils
      libselinux: propagate descendant match allocation failures
      libselinux: free shared regex contexts on library unload

Thi=C3=A9baud Weksteen (4):
      libselinux: use designated initializers for label initfuncs
      libselinux: support multiple spec_files
      libselinux: support multiple context files for the file backend
      libsepol/cil: Output culprit rules from binary policy when CIL AST ma=
tch fails

Todd Zullinger (3):
      libselinux: add -r option to sefcontext_compile.8
      libselinux: add -i option to sefcontext_compile.8
      libselinux: add -V option to sefcontext_compile.8

Vaibhav Bhope (1):
      policycoreutils: fixfiles: honor last exclude line without newline

Vit Mojzis (3):
      libselinux: restorecon_xattr: reset dir_xattr_list on every call
      libsepol/cil: fix size truncation in cil_add_file()
      libsemanage/genhomedircon: reject users with a relative home directory

