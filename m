From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 00/15] RFC Source Policy Support
Date: Tue, 26 Jan 2010 17:08:06 -0500
Message-Id: <1264543701-20638-1-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Our motivations for this patchset is to enable source modules to be
stored in the libsemanage store. These changes will allow users and
administrators to:

   1. Insert human readable and editable source modules into the module
      store.

   2. Retrieve existing modules in order to view or make changes.

   3. Stop storing and versioning policy source outside of the semanage
      store for minor local modifications (though it is possible the
      store could be used for general policy development, it is
      anticipated that for larger policy development activities an
      external source store and version control scheme will be used).

Additionally, switching to source modules will bring several other
long-term benefits:

   1. Reduction in the number of binary formats used in the SELinux
      toolchain, easing maintenance and development.

   2. Development path to tools that enable larger policy modifications
      on end systems (e.g., cloning application policies, removing rules
      from distribution provided policy, etc.).

   3. Development path to multiple high-level policy languages.
   
   4. Better Dependency Handling - e.g., updating an interface in one
      module will cause the new interface to be used in other modules
      without re-compiling those modules externally.

   5. The removal of a special base module, allowing more flexibility in
      policy construction and easier overriding, disabling, or removing
      of portions of the core policy.

[Design Considerations]

In creating this design there were several key questions around
backwards compatibility and user experience. Below are several of the
most important and potentially controversial design decisions.

No Support for Binary Modules - Many designs were made that included
support for binary modules including, in several cases, base modules. We
found that the compromises that each of these designs forced were
unacceptable and, perhaps more importantly, there was no way to provide
a user experience that would meet general expectations.  Further, it was
felt that most users either had the source for all of their modules or
in the rare cases when source was not available, the modules would be
trivial and the source could be reasonably extracted using a decompiler.
The most challenging problems were:

   1. Interface files - Because binary modules do not contain the
      interfaces created by their modules it would be necessary to
      locate the corresponding interface files for each binary module to
      allow source modules to be compiled. This is particularly true in
      the case of support for base modules. While it might have been
      possible to hack around this using the interface files in the
      selinux-policy-devel package, there were many problems with this
      approach.

   2. Dependencies - Binary modules would not be able to be updated
      based upon changes to the interfaces in other modules.

   3. Intermediate language - supporting binary modules would make it
      much more challenging to support compilation to the forthcoming
      intermediate language without creating a complex conversion tool.
      It was decided that enabling support for binary modules that would
      eventually be discontinued was not worth the complexity.

Single Source Files - The initial designs for source modules included
the possibility of supporting reference policy modules directly by
combining the three files for each module (.te, .if, and .fc) into a
tarball. This created a very unfriendly user experience and created many
corner cases (which tarball layouts were acceptable, how should the
infrastructure handle 'extra' files in a tarball, etc.).  These
complications led us to instead use a very simple sectioned text format
for reference policy modules and, in the future, to remove the need for
sections through language and compiler features.

Module Ordering - The current reference policy compilation
infrastructure devotes substantial attention to dealing with ordering
problems. Some of these problems are fundamental (such as the ordering
of portcon statements) while others are an artifact of the current
compiler and M4 (such as the need to separate out interface statements
in .if files). Rather than devote substantial effort to creating
mechanisms for specifying or dealing with ordering, it was felt that the
long term solution to this problem is in the improvements that will come
from the proposed common intermediate language [1]. Therefore, in the
short term, several modules will be ordered specially based upon name
and certain policy statements will only be supported in those specially
ordered modules (e.g., a module for specifying defines such as
DISTRO_REDHAT). These hacks can be removed at a later date.

Base Module Removal - The decision to support a special base binary
module was made to make bootstrapping a module store easier by including
a module that was required to have a minimal but complete system policy
and to deal with ordering by only allowing order dependent statements to
appear in the base (such as object class or portcon). Over time it has
become clear that the base module limitations outweigh any of the
intended benefits. This is especially true as support for overriding
policy modules is included. Therefore, the source semanage store will no
longer support or require a special base module.  Further, there will be
no restrictions on the use of policy statements in modules. While this
will allow some unintentional mistakes (e.g., including a broad portcon
in a module that gets processed first) it will also allow additional
freedom (e.g., the use of narrow portcon statements in modules).

[User Experience Overview]

The overall user experience will shift from using external tools to
compile a policy package (.pp) to working directly with source modules.

Source modules will be a single text file containing all of the policy
for that module. For the current reference policy that will require
combining the current interface, type enforcement, and file context
files into a single text file. The user will then use that text file
similarly to how the current binary modules are used. Insertion would be
performed using semodule (the 'ref' extension is for the single file
reference policy format):

# semodule -i apache.ref

Note that the language for the module will be inferred from the
extension to avoid the general tools, such as semodule, needing an
awareness of the format of all source policies. The name would be taken
from the input filename.

Removing a module would be the same as it is currently:

# semodule -r apache

Listing would be generally the same, though there would be the addition
of a language field to the full output:

# semodule -lfull
400 _access_vectors      2.20091117          ref    
400 _constraints         2.20091117          ref    
<snip>
400 _mls                 2.20091117 disabled ref    
<snip>
400 corenetwork          1.13.1              corenet
<snip>
400 zebra                1.10.0     disabled ref    
400 zosremote            1.1.0      disabled ref    

The first large change to user experience is the introduction of a
command to retrieve a module:

# semodule -g apache
# ls
apache.ref

# semodule -g apache -o myapache.ref
# ls
myapache.ref

Similarly, there is the addition of an edit command that is similar to
sudoedit. This is purely a convenience; it will retrieve the module to a
temporary location and install it after updates are made.

# semodule --edit apache

Finally, semodule now supports adding a user message when making
changes:

# semodule --edit apache -m "Allow apache to execute cowsay."

[Compilation]

In the interests of supporting multiple high-level languages (such as
domain specific languages) we provide a two part compilation process.

The first compilation is from a high-level language (HLL) module to a
common intermediate language (CIL) module. This compilation occurs when
a module is installed. The compilation is handled by a HLL specific
compiler conforming the HLL compiler specification.

The second compilation is from CIL modules to binary base module. This
compilation occurs during the commit process. The compilation is handled
by the CIL compiler.

In this implementation the CIL refers to a special formulation of the
refpol language called refpol_ilc and NOT the proposed CIL[1].

[HLL]

We provide an overview of high-level language treatment here. This
patchset introduces two high-level languages refpol and corenet. Please
see their respective patches for details on their languages.

[HLL Compiler Specification]

Each high-level language (HLL) has a compiler that converts from the HLL
to the CIL. The HLL compiler will be a command-line tool that takes the
HLL source as input on stdin and outputs the compiled CIL on stdout.
Errors from compilation will be output on stderr and a non-zero exit
status set. Additionally, the version of the module will be output on
file descriptor 3.

For example an invocation by hand of the refpol HLL compiler:

# refpolc < apache.ref > apache.cil 3<> apache.version

The compiler name, path, HLL extension, and any flags to the compiler
are specified in the language configuration file.

[HLL Configuration File]

Each language has a configuration file stored at:

/etc/selinux/language.d/<language>.conf

Where each <language>.conf contains:

NAME=<human readable name>
COMPILER=<full path to compiler>
EXTENSION=<file extension without dot>
FLAGS=<compiler flags>

For example:

NAME="Reference Policy"
COMPILER="/usr/bin/refpolc"
EXTENSION="ref"
FLAGS=""

Language extensions are required to be unique (at least from all other
languages and preferably globally unique).

[CIL]

Here we discuss the CIL treatment in general. This patchset uses a
special formulation of the refpol language combined with the traditional
Reference Policy build infrastructure as the common intermediary
language (referred to as refpol_ilc). For details on the refpol_ilc
please see its patch.

[CIL Compiler]

The common intermediate language (CIL) compiler converts from the
intermediate language to a binary base module. It is a command line tool
that takes the enabled and disabled modules as parameters. Errors from
compilation will be output on stderr and an non-zero exit status set.
The binary base module will be output on stdout. Disabled modules will
be specified with the -d option.

For example an invocation by hand of the refpol_ilc CIL compiler:

# refpol_ilc `find /var/lib/selinux/targeted/active/modules/400/ -iname cil` > base.pp

[ChangeLog Support]

Every successful commit will produce a log entry. The log entry will
contain the command run, who ran it, their context, when it occurred,
and any user specified message.

The log will be stored at:

/var/lib/selinux/<policy type>/ChangeLog

Each line of the log has the following format:

VERSION="<repo version>" COMMAND="<command + options>" USERNAME="<user name>" CONTEXT="<context>" TIME="<time stamp>" MSG="<message>"

All quoted strings have special characters escaped (quotes and anything
not printable [^:print:]|\").

The origins of the information in the fields is as follows:

   [Field]    [Origin]

   VER        Discovered from the 'SCM', for the time being this will be the
              commit number.

   CMD        Discovered from /proc/self/cmdline if available. May be set by
              the library user.

   USERNAME   Discovered from getpwuid(getuid())->pw_name.

   CONTEXT    Discovered from getprevcon.

   TIME       Discovered from ctime(time(&t)).

   MSG        Set by the library user.

[Setup]

The following steps setup a system with source policy support:

   1. Compile & install patched SELinux userland.

      Note: Remember to install the new python wrappers (install-pywrap)
            if you intend to use semanage.
   
   2. (On Fedora) Remove /lib/libsemanage.so.1. The default installation
      location for libsemanage does not overwrite the one shipped with
      Fedora.
   
   3. Get Reference Policy:

      # git clone http://oss.tresys.com/git/refpolicy.git
   
   4. Make the refpol_ilc build directory:

      # mkdir -p /usr/share/selinux/refpol_ilc/
   
   5. Create and install the refpol_ilc build environment:

      # refpolicy2refpol -b refpolicy /usr/share/selinux/refpol_ilc/build

   6. Convert Reference Policy modules to refpol modules:

      # refpolicy2refpol refpolicy refpol

   7. Copy an existing installed policy such as targeted to a 'test'
      store:

      # cp -R /etc/selinux/targeted /etc/selinux/test

   8. Create necessary directories for a 'test' store in
      /var/lib/selinux:

      # mkdir -p /var/lib/selinux/test/active/modules

   9. Install the source modules to the test store:
   
      # semodule -s test `find refpol -iname \*.ref -or -iname \*.corenet | xargs -I{} echo -i {}`

      Note: The current semanage policy does not allow executing
	    generated files, so you need to change the policy or put
	    semanage in permissive.

[1] CIL RFC: http://marc.info/?l=selinux&m=124759244409438&w=2

Caleb Case (15):
  [src-policy] refpol language and tools
  [src-policy] corenet language and tools
  [src-policy] Reference Policy to refpol conversion tool
  [src-policy] refpol intermediate language compiler (refpol_ilc)
  [src-policy] language.d and language.conf parser
  [src-policy] libsemanage: compile hll module
  [src-policy] libsemanage: compile common intermediary language
  [src-policy] libsemanage: remove binary interfaces
  [src-policy] semodule: remove base module support
  [src-policy] libsemanage: get source module
  [src-policy] semodule: get module source
  [src-policy] semodule: edit module
  [src-policy] libsemanage: ChangeLog support
  [src-policy] semodule: user message support
  [src-policy] semanage: source permissive module

 Makefile                                       |    2 +-
 corenet/COPYING                                |  504 ++++++++++
 corenet/Makefile                               |   27 +
 corenet/corenet.conf                           |    4 +
 corenet/corenet.py                             |   17 +
 corenet/corenet/corenet.py                     |  175 ++++
 corenet/corenet/corenetc.py                    |  129 +++
 corenet/corenetc.py                            |   17 +
 corenet/setup.py                               |   13 +
 libsemanage/include/semanage/modules.h         |   14 +-
 libsemanage/include/semanage/private/handle.h  |   31 +-
 libsemanage/include/semanage/private/modules.h |   28 +-
 libsemanage/src/Makefile                       |   16 +-
 libsemanage/src/direct_api.c                   | 1165 ++++++++++++++----------
 libsemanage/src/handle.c                       |   95 ++-
 libsemanage/src/handle.h                       |   10 +-
 libsemanage/src/lang-parse.y                   |  271 ++++++
 libsemanage/src/lang-scan.l                    |   84 ++
 libsemanage/src/libsemanage.map                |    6 +
 libsemanage/src/modules.c                      |   41 +-
 libsemanage/src/modules.h                      |    3 +-
 libsemanage/src/policy.h                       |   15 +-
 libsemanage/src/semanage_lang_conf.h           |   39 +
 libsemanage/src/semanage_store.c               |  884 ++++++++++++------
 libsemanage/src/semanage_store.h               |   55 +-
 policycoreutils/semanage/seobject.py           |   15 +-
 policycoreutils/semodule/semodule.8            |   27 +-
 policycoreutils/semodule/semodule.c            |  540 +++++++++++-
 refpol/COPYING                                 |  504 ++++++++++
 refpol/Makefile                                |   28 +
 refpol/refpol.conf                             |    4 +
 refpol/refpol.py                               |   17 +
 refpol/refpol/refpol.py                        |  176 ++++
 refpol/refpol/refpolc.py                       |   77 ++
 refpol/refpol/refpolicy2refpol.py              |  185 ++++
 refpol/refpolc.py                              |   17 +
 refpol/refpolicy2refpol.py                     |   17 +
 refpol/setup.py                                |   13 +
 refpol_ilc/COPYING                             |  504 ++++++++++
 refpol_ilc/Makefile                            |   24 +
 refpol_ilc/refpol_ilc.py                       |   17 +
 refpol_ilc/refpol_ilc/refpol_ilc.py            |  193 ++++
 refpol_ilc/setup.py                            |   13 +
 43 files changed, 5200 insertions(+), 816 deletions(-)
 create mode 100644 corenet/COPYING
 create mode 100644 corenet/Makefile
 create mode 100644 corenet/corenet.conf
 create mode 100755 corenet/corenet.py
 create mode 100644 corenet/corenet/__init__.py
 create mode 100644 corenet/corenet/corenet.py
 create mode 100644 corenet/corenet/corenetc.py
 create mode 100755 corenet/corenetc.py
 create mode 100755 corenet/setup.py
 create mode 100644 libsemanage/src/lang-parse.y
 create mode 100644 libsemanage/src/lang-scan.l
 create mode 100644 libsemanage/src/semanage_lang_conf.h
 create mode 100644 refpol/COPYING
 create mode 100644 refpol/Makefile
 create mode 100644 refpol/refpol.conf
 create mode 100755 refpol/refpol.py
 create mode 100644 refpol/refpol/__init__.py
 create mode 100644 refpol/refpol/refpol.py
 create mode 100644 refpol/refpol/refpolc.py
 create mode 100644 refpol/refpol/refpolicy2refpol.py
 create mode 100755 refpol/refpolc.py
 create mode 100755 refpol/refpolicy2refpol.py
 create mode 100755 refpol/setup.py
 create mode 100644 refpol_ilc/COPYING
 create mode 100644 refpol_ilc/Makefile
 create mode 100755 refpol_ilc/refpol_ilc.py
 create mode 100644 refpol_ilc/refpol_ilc/__init__.py
 create mode 100644 refpol_ilc/refpol_ilc/refpol_ilc.py
 create mode 100755 refpol_ilc/setup.py


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
