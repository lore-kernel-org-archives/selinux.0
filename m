From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:11 +0100
Message-Id: <20180214095717.1050-10-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 09/15] python: build: move modules from
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
index a8465e62..5fc1998e 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -4,7 +4,7 @@ PYTHON ?= python
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
 PACKAGEDIR ?= $(PYTHONLIBDIR)
 BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 
diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
index 6d392f5d..c75809ad 100644
--- a/python/sepolgen/src/sepolgen/Makefile
+++ b/python/sepolgen/src/sepolgen/Makefile
@@ -1,6 +1,6 @@
 PREFIX ?= /usr
 PYTHON ?= python
-PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
 PACKAGEDIR ?= /$(PYTHONLIBDIR)/sepolgen
 
 all:
-- 
2.15.1
