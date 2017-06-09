Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v59HRXBC029554
 for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2017 13:27:33 -0400
Message-ID: <1497029518.26846.13.camel@tycho.nsa.gov>
Subject: Re: ANN: SELinux userspace 2.7-rc1 release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Fri, 09 Jun 2017 13:31:58 -0400
In-Reply-To: <1497028696.26846.9.camel@tycho.nsa.gov>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-06-09 at 13:18 -0400, Stephen Smalley wrote:
> A release candidate for the SELinux userspace is now available at:
> https://github.com/SELinuxProject/selinux/wiki/Releases

git shortlog output for this release.

Alan Jenkins (24):
      policycoreutils, python: Fix bad manpage formatting in "SEE ALSO"
      restorecon manpage: link back to fixfiles
      policycoreutils: let output of `fixfiles` be redirected (as normal)
      policycoreutils: fixfiles should handle path arguments more robustly
      policycoreutils: fixfiles: handle unexpected spaces in command
      policycoreutils/setfiles: stdout messages don't need program prefix
      policycoreutils/setfiles: don't scramble stdout and stderr together
      policycoreutils: fixfiles: remove useless use of cat
      Revert "policycoreutils: let output of `fixfiles` be redirected (as normal)"
      policycoreutils: fixfiles: remove (broken) redundant code
      policycoreutils: fixfiles: clarify exclude_dirs()
      policycoreutils: fixfiles: fix logging about R/O filesystems
      policycoreutils: fixfiles: move logit call outside of redirected function
      policycoreutils: fixfiles: deprecate -l option
      policycoreutils: fixfiles: tidy up usage(), manpage synopsis
      policycoreutils: fixfiles: remove two unused variables
      policycoreutils: fixfiles: syntax error
      policycoreutils: fixfiles: usage errors are fatal
      policycoreutils: fixfiles: if restorecon aborts, we should too
      policycoreutils: fixfiles: refactor into the `set -u` dialect
      policycoreutils: fixfiles: un-document `-R -a` option
      policycoreutils: fixfiles: remove bad modes of "relabel" command
      policycoreutils: fixfiles: don't ignore `-F` when run in `-C` mode
      policycoreutils: fixfiles: use a consistent order for options to restorecon

Bernhard M. Wiedemann (1):
      sort input files

Christian Göttsche (2):
      libselinux: add security_get_checkreqprot
      sestatus: show checkreqprot status

Colin Walters (1):
      config: Don't finalize mount state in selinux_set_policy_root()

Dan Walsh (5):
      policycoreutils/sepolicy: Add documentation for MCS separated domains
      sepolicy: Add manpages for typealiased types
      sepolicy: Move svirt man page out of libvirt into its own
      Fix up generation of application policy
      sepolicy: We should be creating _exec interfaces when we create the domtrans interface

Daniel Jurgens (10):
      checkpolicy: Add support for ibpkeycon labels
      libsepol: Add ibpkey ocontext handling
      libsepol: Add Infiniband Pkey handling to CIL
      checkpolicy: Add support for ibendportcon labels
      libsepol: Add ibendport ocontext handling
      libsepol: Add IB end port handling to CIL
      semanage: Update semanage to allow runtime labeling of Infiniband Pkeys
      semanage: Update semanage to allow runtime labeling of ibendports
      semanage: Update man pages for infiniband
      semanage: Fix manpage author for ibpkey and ibendport pages.

Gary Tierney (1):
      libsepol/cil: remove avrules with no affected types

Guido Trentalancia (2):
      libselinux: Fix unitialized variable compiler warnings
      libsemanage: Fix unitialized variable compiler warnings

James Carter (42):
      libsepol/cil: Check for improper category range
      libsepol/cil: Use empty list for category expression evaluated as empty
      libsepol/cil: Use an empty list to represent an unknown permission
      libsepol/cil: Check if identifier is NULL when verifying name
      libsepol/cil: Check that permission is not an empty list
      libsepol/cil: Verify alias in aliasactual statement is really an alias
      libsepol/cil: Verify neither child nor parent in a bounds is an attribute
      Updated libsepol ChangeLog.
      Updated libsepol ChangeLog.
      libsepol/cil: Exit with an error for an unknown map permission
      Updated libsepol ChangeLog.
      libsepol/cil: Add ability to write policy.conf file from CIL AST
      secilc: Add secil2conf which creates a policy.conf from CIL policy
      libsepol: Fix neverallow checking to also check the other types when self is included in a target type set.
      checkpolicy: Create common function for type declares and requires
      checkpolicy: Create common function for role declares and requires
      checkpolicy: Create common function for user declares and requires
      checkpolicy: Cleanup error messages
      checkpolicy: Move common require and declare code into new function
      checkpolicy: Improve check for identifier flavor mismatch
      libsepol: Return +1 when declaration is followed by a require
      checkpolicy: Remove uneeded return check in require_symbol()
      checkpolicy: Make print_error_msg() static
      policycoreutils/semodule: fix -Wwrite-strings warnings
      libsepol/cil: Destroy cil_tree_node stacks when finished resolving AST
      libsepol/cil: Move initialization of bitmap in __cil_permx_to_bitmap()
      checkpolicy: Fix minor memory leak in checkpolicy
      libsepol/cil: Allow hexadecimal numbers in Xen context rules
      libsepol: Update module_to_cil to output hexadecimal for Xen rules
      libsepol/cil: Use hexadecimal numbers when writing Xen rules
      libsepol/cil: Add hexadecimal support for Xen ioportcon statements
      libsepol: Add ability to convert binary policy to CIL
      libsepol: Add ability to convert binary policy to policy.conf file
      checkpolicy: Add options to convert binary policy to CIL or a policy.conf
      libsepol: In module_to_cil create one attribute for each unique set
      libsepol/cil: Add ability to expand some attributes in binary policy
      secilc: Add options to control the expansion of attributes
      libsepol/cil: Remove uneeded null checks of unused parameters
      libsepol: Clean up scope handling
      libsepol: Fix module_to_cil's handling of type aliases
      libsepol/cil: Fix bug in cil_reset_ibpkeycon()
      libsepol: Expand attributes with TYPE_FLAGS_EXPAND_ATTR_TRUE set

Jason Zaman (13):
      libsepol: Add symver with explicit version to build with ld.gold
      mcstrans: Fix Werror=shadow errors
      mcstrans: take LIBDIR from args, dont guess
      Add stub make test targets to new subdirs
      mcstrans: Add utils gitignore
      restorecond: Add gitignore
      policycoreutils: honour LINGUAS variable
      libselinux: get pcre CFLAGS/LDFLAGS from pkg-config
      libselinux: PCRE_LDFLAGS is actually LDLIBS
      Makefiles: drop -L/-I to system paths
      restorecond: get pcre cflags/libs from pkg-config
      Add includes for DESTDIR only in root Makefile
      policycoreutils: make audit and pam support configurable

Jeff Vander Stoep (1):
      Add attribute expansion options

Karl MacMillan (1):
      libsepol compilation fixes for macOS.

Kyle Walker (1):
      seobject: Handle python error returns correctly

Laurent Bigonville (8):
      libselinux: Add clean-pywrap and clean-rubywrap targets
      libselinux: Allow overriding libsepol.a location during build
      policycoreutils: Use "new" sepolicy icon in .desktop file for sepolicy gui
      Revert "libselinux: support new python3 functions"
      Sandbox: Use next() over the sepolicy.info() result
      policycoreutils: Make sepolicy work with python3
      policycoreutils: Force GTK3.0 for sepolicy gui
      policycoreutils: Use GObject introspection binding instead of python-gobject in selinux_server.py

Lokesh Mandvekar (1):
      libselinux: selinux_restorecon.3 man page typo fix

Luis Ressel (1):
      policycoreutils/load_policy: Drop is_selinux_enabled() check

Mike Frysinger (2):
      selinux(8): fix display of man page references
      man: standardize spacing with pointers in prototypes

Miroslav Grepl (2):
      sepolicy: ptrace should be a part of deny_ptrace boolean in TEMPLATETYPE_admin
      Fix typo in executable.py template.

Nick Kralevich (5):
      label_file.h: actually use the results of compat_validate
      enabled.c: Remove stdio_ext.h header
      procattr.c: Use __ANDROID__ instead of ANDROID
      policy_define.c: don't free memory returned from queue_head()
      libselinux: add O_CLOEXEC

Nicolas Iooss (130):
      policycoreutils: restorecond: use pkg-config to find dbus-glib-1 files
      policycoreutils: semodule_package: do not fail with an empty fc file
      libselinux: remove rpm_execcon from SWIG wrappers
      libsemanage: remove ruby_semanage.so with "make clean"
      libselinux, libsemanage: remove *swig_python_exception.i if its creation failed
      libsemanage: semanage_seuser_key_create: copy name
      libselinux,libsemanage: use Ruby to define RUBYINC
      libselinux,libsemanage: link Ruby wrapper with -lruby
      libsemanage: query for python site-packages dir directly
      libselinux,libsemanage: link Python wrapper with Python
      secilc: do not build secilc man page if it is up to date
      libselinux,libsemanage: fall back to gcc in exception.sh
      libselinux, libsemanage: swig: use SWIG_fail when an error occurs
      libsemanage: use a macro prefixed with SEMANAGE to protect dso.h
      libsepol: replace an assert with an error message
      libsepol: test for ebitmap_read() negative return value
      libsepol: make parsing symbol table headers more robust
      sandbox: make test not fail on systems without SELinux
      mcstrans: fix global "make install"
      libselinux: audit2why: remove unused module_state structure
      libselinux, libsemanage: use Python-specific .so extension
      libsepol: do not call a NULL function in additive_scopes_to_cil()
      libsepol: do not crash when a symbol does not exist
      libsepol: do not crash when block->branch_list is NULL
      libsepol: make scope_index_destroy() more robust
      libsepol: fix unknown magic section number error message
      libsepol: do not modify p->p_roles.nprim in role_set_expand
      libsepol: do not check decl->symtab[i].nprim
      libsepol: ebitmap: reject loading bitmaps with incorrect high bit
      libsepol: check decl_id bounds before using it
      libsepol: detect duplicated symbol IDs
      mcstrans/utils: make "make all" use $DESTDIR
      libsepol/tests: use LDFLAGS when linking
      checkpolicy: remove -lfl from LDLIBS
      libsepol,libsemanage: write file name in flex output
      libsemanage/tests: make "make test" fail when a CUnit test fails
      libsemanage/tests: make tests standalone
      libsemanage/tests: test more cases of semanage_split*()
      libsemanage: simplify string utilities functions
      libsemanage: add semanage_str_replace() utility function
      libsemanage: genhomedircon: drop ustr dependency
      libsemanage: remove ustr library from Makefiles, README and pkg-config
      libselinux/utils: do not create an empty /sbin directory
      libsepol/tests: fix -Wsometimes-uninitialized clang warnings
      libsepol/tests: fix some memory leaks
      checkpolicy: free id in define_port_context()
      checkpolicy: fix memory leaks in genfscon statements parsing
      checkpolicy: do not leak queue elements in queue_destroy()
      checkpolicy: free id where it was leaked
      libsemanage: genhomedircon: remove duplicated test condition
      libsemanage: increment the right index variable in for loop
      checkpolicy: fix memory usage in define_bool_tunable()
      libsepol: make capability index an unsigned int
      libselinux: include errno.h instead of sys/errno.h
      checkpolicy: always include ctypes.h
      mcstransd: fix and reorder includes
      libsemanage: genhomedircon: consider SEMANAGE_FCONTEXT_DIR in fcontext_matches()
      semanage, sepolicy: make tests not fail on systems without SELinux
      Re-link programs after libsepol.a is updated
      libsepol: use constant keys in hashtab functions
      libsepol: verify the right variable after calling calloc()
      libsepol: remove useless assignments
      libselinux: always free catalog in db_init()
      libselinux: fix argument order in get_default_context_with_rolelevel() doc
      checkpolicy: always free id in define_type()
      checkpolicy: fix memory leaks in define_filename_trans()
      checkpolicy: add a missing free(id) in define_roleattribute()
      checkpolicy: do not leak memory when a class is not found in an avrule
      libsepol: fix -Wwrite-strings warnings
      libsemanage: make lang_ext parameter const in semanage_direct_write_langext()
      policycoreutils/hll/pp: fix -Wwrite-strings warnings
      mcstrans: fix -Wwrite-strings warnings
      semodule_deps: hide -Wwrite-strings warnings
      libsepol/tests: fix -Wwrite-strings warnings
      libsemanage/tests: fix -Wwrite-strings warnings
      libsepol/cil: fix type confusion in cil_copy_ast
      Introduce Travis-CI tests
      libsepol/cil: use __cil_ordered_lists_destroy() to free unordered_classorder_lists
      libsepol/cil: free the first operand if the second one is invalid
      libsepol/cil: do not leak left-hand side of an invalid constraint
      libsepol/cil: free bitmaps in cil_level_equals()
      libselinux, libsemanage: make PYPREFIX computation more robust
      semodule_package: do not leak memory when using -u or -s
      libsepol/cil: do not dereference args before checking it was not null
      libsemanage: never call memcpy with a NULL value
      libsemanage/tests: include libsepol headers from $DESTDIR
      mcstrans: do not dereference color_str if it is NULL
      libselinux: initialize temp value in SWIG wrapper to prevent freeing garbage
      restorecond: add noreturn attribute to exitApp()
      checkpolicy: add noreturn attribute to usage()
      secilc: add noreturn attribute to usage()
      mcstrans: add noreturn attribute to usage()
      semodule-utils: add noreturn attribute to usage()
      policycoreutils: add noreturn attribute to usage()
      libsepol/cil: make reporting conflicting type transitions work
      libsepol/cil: avoid freeing uninitialized values
      checkpolicy: dereference rangehead after checking it was not NULL
      libsepol/cil: do not dereference a NULL pointer when calloc() fails
      libsepol: do not dereference a NULL pointer when stack_init() fails
      libsepol: make process_boolean() fail on invalid lines
      libsepol: constify sepol_genbools()'s boolpath parameter
      libsepol: fix use-after-free in sepol_user_clone()
      libsemanage: do not close uninitialized file descriptors
      libsemanage: do not dereference a NULL pointer when calloc() fails
      libsemanage: genhomedircon: fix possible double-free
      libselinux: do not dereference a NULL pointer when calloc() fails
      libsemanage: drop checks on semanage_module_info_destroy() value
      libselinux: make process_boolean() fail on invalid lines
      libselinux: ensure that 4 columns are read from /proc/mounts
      libsepol: refuse to load policies with no block
      libsepol: do not wrap integers when checking bound
      libsepol: do not free attr_name twice
      libsepol: do not leak memory when an error occurs
      libsepol: correct spelling errors in module_to_cil.c comments
      libsepol: cil: check cil_fill_list return value
      libselinux: avoid calling strcmp() on a NULL pointer
      libselinux: getsebool: always free names
      policycoreutils: newrole: do not free pw strings twice
      policycoreutils: newrole: always initialize pw fields
      libselinux/utils: add noreturn attribute to selinux_check_access's usage
      libsepol: silence false-positive -Wwrite-strings warning
      libsepol/cil: do not use an uninitialized value in __cil_fqn_qualify_blocks
      libselinux: close the subs file if fstat failed
      libselinux: rework selabel_subs_init() to avoid use-after-free
      libselinux: propagate selabel_subs_init() errors
      libsepol: remove unused attribute on a used argument
      libsepol: propagate calloc() failure
      libsepol: use the number of elements in calloc first argument
      libsepol: make role_list_destroy() do nothing when role_list is NULL
      libsepol: do not use handle when it is marked unused

Nikola Forró (1):
      mcstrans: fix typo in mcstransd.8 man page

Petr Lautrbach (18):
      libselinux: Generate SWIG wrappers for selinux_restorecon()
      libselinux: Rewrite restorecon() python method
      sepolicy: Fix spelling mistakes in commands in generated manpages
      policycoreutils/sepolicy: boolean.png is in help/
      sepolicy: Adapt to new the semodule list output
      sepolicy: Don't return filter(), use [ ] notation instead
      sepolicy: Simplify policy types detection
      sepolicy/generate.py: Fix string formatting
      policycoreutils/sepolicy: Define our own cmp()
      dbus: Use text streams in selinux_server.py
      sepolicy: setools.*Query wants a list in ruletype
      sepolicy: Fix several issues in 'sepolicy manpage -a'
      sepolicy: info() should provide attributes for a TYPE
      sepolicy/gui: Update text strings to use better gettext templates
      libsepol/utils: Fix build without system sepol.h
      Fix recently introduced TabError's
      sepolicy/interface: Use relative python 3 imports
      sepolicy: Fix sorting of port_strings in python 3

Richard Haines (4):
      setfiles: Fix setfiles progress indicator
      libselinux: Add permissive= entry to avc audit log
      libselinux: Add selinux_check_access utility
      libselinux: Remove util/selinux_restorecon.c

Sandeep Patil (1):
      libselinux: replace all malloc + memset by calloc in android label backend.

Stephen Smalley (91):
      Fix release script
      scripts/release: cleanups
      libsemanage: genhomedircon: only set MLS level if MLS is enabled
      Updated libsemanage ChangeLog
      Updated libselinux and libsepol ChangeLogs
      Updated policycoreutils ChangeLog
      Updated libselinux ChangeLog
      Updated libselinux ChangeLog.
      Updated libselinux ChangeLog
      Updated policycoreutils ChangeLog
      Updated libsepol ChangeLog
      Updated libselinux ChangeLog
      libselinux: avc_internal.c: allow building with clang
      Updated libselinux ChangeLog
      libsemanage: fix kernel pathname in semanage_verify_kernel()
      Updated ChangeLogs
      Updated policycoreutils ChangeLog
      Updated libselinux ChangeLog
      Updated libselinux and libsemanage ChangeLogs
      Updated policycoreutils ChangeLog
      Updated policycoreutils ChangeLog
      libsepol: sepol_{bool|iface|user}_key_create: copy name
      Updated libsepol ChangeLog
      libsepol: fix checkpolicy dontaudit compiler bug
      Updated libsepol ChangeLog
      libselinux: fix subdir build and usage of cmdline CFLAGS
      Updated libselinux ChangeLog
      Updated libsemanage ChangeLog
      Updated libsepol ChangeLog
      Updated policycoreutils ChangeLog
      Updated libselinux and libsemanage ChangeLogs
      Updated secilc ChangeLog
      Updated libselinux and libsemanage ChangeLog
      libsepol: cil_lexer: make warnings non-fatal for building
      Updated libsepol ChangeLog
      Updated libsemanage ChangeLog
      Updated libsepol ChangeLog
      Updated libsepol ChangeLog
      Move policycoreutils/gui to gui.
      Move policycoreutils/mcstrans to mcstrans.
      Move policycoreutils/restorecond to restorecond.
      Move policycoreutils/sandbox to sandbox.
      Move policycoreutils/sepolicy dbus service files to dbus.
      Move policycoreutils/{sepolicy,audit2allow,semanage,scripts/chcat*} and sepolgen to python.
      Move policycoreutils/semodule_{deps,expand,link} to semodule-utils.
      Make it easy to omit optional components.
      Build mcstrans.
      mcstrans: Add .gitignore file
      mcstrans: Add a relabel target.
      Move sepolicy desktop and png files to gui.
      Move policycoreutils/sepolgen-ifgen into python/audit2allow.
      mcstrans: fix clang warnings
      Update release script for the new structure.
      Fix release script for packages that need prefixes.
      Add VERSION files for new components
      Move policycoreutils/semodule_package to semodule-utils.
      restorecond: break source dependency on policycoreutils/setfiles
      Fix release script
      Add COPYING files for new subdirs.
      semodule-utils: Drop -lselinux from Makefiles.
      Drop ChangeLog files
      mcstrans: Fix signed/unsigned warnings
      libselinux: normalize enforce values from the kernel
      checkpolicy: treat -self as an error
      libsepol: do not write object_r types to policy file
      libsepol,checkpolicy: convert rangetrans and filenametrans to hashtabs
      libsepol: do not #include <sys/cdefs.h>
      libselinux: avcstat: Clean up redundant condition
      libsepol: sepol_av_to_string: clear static buffer
      libsepol,libselinux,audit2allow: teach audit2why about type bounds failures
      libsepol: Define extended_socket_class policy capability
      libselinux: selinux_restorecon: only log no default label warning if recursive
      libselinux: selinux_restorecon: only log no default label warning for caller-supplied pathname
      policycoreutils/setfiles: set up a logging callback for libselinux
      libselinux: disable filespec hash table stats on non-debug builds
      policycoreutils: remove deprecated -o option from fixfiles verify
      libsepol: Define cgroup_seclabel policy capability
      python/semanage: fix export of fcontext socket entries
      libsepol: do not seg fault on sepol_*_key_free(NULL)
      libsemanage: revert "Skip policy module re-link when only setting booleans."
      libsemanage: Save linked policy, skip re-link when possible
      libselinux: Fix CFLAGS definition
      checkpolicy,libsepol: drop unnecessary usage of s6_addr32
      libsepol,checkpolicy: add binary module support for xperms
      python/semanage: print is a function in python3
      libsepol,libsemanage,libselinux: Fix fallthrough warnings from gcc 7
      libsemanage: Fix snprintf warnings from gcc 7
      libsepol: Fix alloc-size-larger-than warning from gcc 7
      libselinux: fix selabel_lookup*() double slash bug
      libselinux: always unmount selinuxfs for SELINUX=disabled
      Update VERSION files for 2.7-rc1 release.

Steve Lawrence (4):
      libsepol: fix pp module to cil nodecon statement
      libsepol/cil: fix aliasactual resolution errors
      libsepol/cil: better error message with duplicate aliases + support aliases to aliases
      libsepol/cil: fix error check in new cil_resolve_name

Thomas Petazzoni (1):
      libselinux/src/regex.c: support old compilers for the endian check

Tom Cherry (1):
      procattr.c: Use __BIONIC__ instead of __ANDROID__

Ville Skyttä (1):
      Python 3.6 invalid escape sequence deprecation fixes

Vit Mojzis (13):
      policycoreutils/gui: fix system-config-selinux editing features
      policycoreutils/sepolicy/gui: fix current selinux state radiobutton
      python/sepolicy/sepolicy/gui: Fix getting python lib path
      python/semanage/semanage: Unify argument handling
      python: Fix some typos
      python/sepolicy/sepolicy/gui: Reflect sepolicy changes into gui
      python/sepolicy/sepolicy: Cleanup of gui code
      python/sepolicy/sepolicy: optimise sepolicy gui loading
      policycoreutils/setfiles: Mention customizable types in restorecon man page
      policycoreutils/restorecond: Decrease loglevel of termination message
      policycoreutils/hll/pp: Fix pp crash when processing base module
      sepolgen: strip non-printable characters when parsing audit messages
      python/sepolicy: fix obtaining domain name in HTMLManPages

William Roberts (15):
      libsepol/cil: disable symver on Mac builds
      libsepol: build on mac
      libselinux: fix mac build warning when ANDROID_HOST=y
      libselinux: fix required alignment for sha1.c on mac
      libselinux/utils: add noreturn to sefcontext_compile
      libselinux: support ANDROID_HOST=1 on Mac
      libselinux: DISABLE_BOOL move to include headers
      libselinux: add booleans.c to ANDROID_HOST=y recipe
      libselinux: fix compiler flags for linux + clang
      libselinux/utils: fix all the noreturn errors
      Revert "libsepol: fix checkpolicy dontaudit compiler bug"
      libsepol: fix checkpolicy dontaudit compiler bug
      policydb.h: use AVTAB macros to avoid duplications
      expand_avrule_helper: cleanup
      expand_terule_helper: cleanups

cgzones (1):
      fix semanage fcontext help message

dcashman (2):
      libsepol: cil: cil_strpool: Allow multiple strpool users.
      libsepol: cil: remove double-free.

stephensmalley (1):
      Merge pull request #35 from cgzones/semanage_fcontext_description

vmojzis (1):
      libselinux: fix pointer handling in realpath_not_final
