From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:30 +0100
Message-Id: <20180124092736.8432-10-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 09/15] python: build: move modules from
 platform-specific to platform-shared
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 python/semanage/Makefile              | 2 +-
 python/sepolgen/src/sepolgen/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 3e48b673..0218222d 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -4,7 +4,7 @@ PYTHON ?= python
 PREFIX ?= /usr
 SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
 MANDIR = $(DESTDIR)$(PREFIX)/share/man
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
 PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)
 BASHCOMPLETIONDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completion/completions
 
diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
index 84548e98..2121a955 100644
--- a/python/sepolgen/src/sepolgen/Makefile
+++ b/python/sepolgen/src/sepolgen/Makefile
@@ -1,6 +1,6 @@
 PREFIX ?= /usr
 PYTHON ?= python
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
 PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
 
 all:
-- 
2.15.1
