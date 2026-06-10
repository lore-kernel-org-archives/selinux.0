Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE343921CE
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123509; cv=none; b=hypaXpMxCaLBbmK9pjwbvccj2TdZkRKKmrBu4713KSkpBcg5UQXwtZmRXc6mKbi0EI3lmI6CNeXopkiHgzT+0LTBoqz3M5qgKgDklTJo+VDkZvldNWWrR+6XUD3qdWleV2ZFa0xADBlYlhbRIVuTAmR5V8WgeT6lh+ZDR6/ycZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123509; c=relaxed/simple;
	bh=rRT4mlBskaKgL3xqdb9cvpK3RpH83MWSBaDL6JHgVMs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gLEddhNBTl3wX1OOpXhJJRn/8awF9zfXso9ytbRCLI5WTB/gTbDDLMdiYZQFcR87Sd5WjbK89yloIyb3zkytmxZ9Is0RobEHeHfRfl/thTUUvLJLMetGF/ZhA9EfW1A8AdfJEF3Jtr2OEmqEWJ1FUw5UCl0/skxtpG88UAgC+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kPeguzjB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kPeguzjB"
Received: from CPC-chpeb-8M6PS.redmond.corp.microsoft.com (unknown [40.117.66.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id 410E020B7167
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 13:31:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 410E020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781123481;
	bh=20xsRi/uCpYeqCXGwWvl0I1AdRjXmpwLP/TXrPHZuuw=;
	h=From:To:Subject:Date:From;
	b=kPeguzjBZikmF3i6P+2cNz7BUO+RQ3kKzaphvn77a6j+raEJ0VgXTZXs2hjtPKUkw
	 jcuf9Q374eFAnOXbilhpgIkHfTty06+rKgFPMRMisPzIx+wp3PWTgDDeBQ2uQwvX/B
	 eTF5iydCfJK4AZn+BpH/qdulwwBT4NRaI2eKSi/k=
From: Chris PeBenito <chpebeni@linux.microsoft.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/2] CI: Fix variable use in build-userspace action.
Date: Wed, 10 Jun 2026 20:31:36 +0000
Message-ID: <20260610203137.411393-1-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code was incorrectly using the matrix variable, which isn't available
in other repos. The matrix variable use accideentally worked in this repo
because the action runs in the calling workflow's context, not a separate
context.

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 .github/actions/build-userspace/action.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
index bad6e33d..f5d21b7c 100644
--- a/.github/actions/build-userspace/action.yml
+++ b/.github/actions/build-userspace/action.yml
@@ -71,27 +71,27 @@ runs:
         echo "RUBY=ruby" >> $GITHUB_ENV
         echo "DESTDIR=$DESTDIR" >> $GITHUB_ENV
 
-        CC=${{ matrix.compiler }}
-        if [ "${{ matrix.python-ruby-version.other }}" = "linker-bfd" ] ; then
+        CC=${{ inputs.compiler }}
+        if [ "${{ inputs.other }}" = "linker-bfd" ] ; then
             CC="$CC -fuse-ld=bfd"
-        elif [ "${{ matrix.python-ruby-version.other }}" = "linker-gold" ] ; then
+        elif [ "${{ inputs.other }}" = "linker-gold" ] ; then
             CC="$CC -fuse-ld=gold"
         fi
         # https://bugs.ruby-lang.org/issues/18616
         # https://github.com/llvm/llvm-project/issues/49958
-        if [ "${{ matrix.compiler }}" = "clang" ] && [[ "${{ matrix.python-ruby-version.ruby }}" = 3* ]] ; then
+        if [ "${{ inputs.compiler }}" = "clang" ] && [[ "${{ inputs.ruby-version }}" = 3* ]] ; then
             CC="$CC -fdeclspec"
         fi
         echo "CC=$CC" >> $GITHUB_ENV
 
         EXPLICIT_MAKE_VARS=
-        if [ "${{ matrix.python-ruby-version.other }}" = "test-flags-override" ] ; then
+        if [ "${{ inputs.other }}" = "test-flags-override" ] ; then
             # Test that overriding CFLAGS, LDFLAGS and other variables works fine
             EXPLICIT_MAKE_VARS="CFLAGS=-I$DESTDIR/usr/include LDFLAGS=-L$DESTDIR/usr/lib LDLIBS= CPPFLAGS="
-        elif [ "${{ matrix.python-ruby-version.other }}" = "test-debug" ] ; then
+        elif [ "${{ inputs.other }}" = "test-debug" ] ; then
             # Test hat debug build works fine
             EXPLICIT_MAKE_VARS="DEBUG=1"
-        elif [ "${{ matrix.python-ruby-version.other }}" = "sanitizers" ] ; then
+        elif [ "${{ inputs.other }}" = "sanitizers" ] ; then
             sanitizers='-fsanitize=address,undefined'
             EXPLICIT_MAKE_VARS="CFLAGS='-g -I$DESTDIR/usr/include $sanitizers' LDFLAGS='-L$DESTDIR/usr/lib $sanitizers' LDLIBS= CPPFLAGS= OPT_SUBDIRS="
             echo "ASAN_OPTIONS=strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1" >> $GITHUB_ENV
@@ -110,7 +110,7 @@ runs:
         PYTHON_SYS_PREFIX="$(python -c 'import sys;print(sys.prefix)')"
         echo "PKG_CONFIG_PATH=${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $GITHUB_ENV
 
-        if [[ "${{ matrix.python-ruby-version.python }}" == pypy* ]] ; then
+        if [[ "${{ inputs.python-version }}" == pypy* ]] ; then
             # PyPy does not provide a config file for pkg-config
             # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
             echo "PYINC=-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
-- 
2.54.0

