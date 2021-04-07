Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA547C43460
	for <selinux@archiver.kernel.org>; Wed,  7 Apr 2021 10:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BA2610F7
	for <selinux@archiver.kernel.org>; Wed,  7 Apr 2021 10:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhDGKNU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350558AbhDGKNR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Apr 2021 06:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617790386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTzmw7t7r55/RCuPWWzarkKRc24NzeAsEOXbcDCXzn4=;
        b=HZvRrN0JhDQatfl+ohldreYUwLyzC0OmOsnIp158ENuEol0W9aHIFQDlbS4xxHzZYurx48
        vpLm0JJYXs0YQbt14VwPIorqDmNmeeLY2ZKdF3Wqt6r/RMzP7U9axexbnFeS1ZyHZjcGrl
        PwLR80nONKDxbs94WGO69c/HPanWwVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-wrl7cg6WMoK1rlVaF5ah8w-1; Wed, 07 Apr 2021 06:13:03 -0400
X-MC-Unique: wrl7cg6WMoK1rlVaF5ah8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06F2107ACC7
        for <selinux@vger.kernel.org>; Wed,  7 Apr 2021 10:13:02 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.194.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 612AA7092D
        for <selinux@vger.kernel.org>; Wed,  7 Apr 2021 10:13:02 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/4] selinux: Remove 'make' dependency
Date:   Wed,  7 Apr 2021 12:12:44 +0200
Message-Id: <20210407101245.276527-3-vmojzis@redhat.com>
In-Reply-To: <20210407101245.276527-1-vmojzis@redhat.com>
References: <CAEg-Je-mAOJc53LyMrmcHfgKAvaQm2-jYWKizCAjLW=15_XF3g@mail.gmail.com>
 <20210407101245.276527-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Compile the policy using a script executed by meson.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
Changes:
* Rewrite policy compilation script in python

 libvirt.spec.in           |  12 ----
 meson.build               |  12 ++++
 selinux/compile_policy.py | 128 ++++++++++++++++++++++++++++++++++++++
 selinux/meson.build       |  23 +++++++
 4 files changed, 163 insertions(+), 12 deletions(-)
 create mode 100755 selinux/compile_policy.py
 create mode 100644 selinux/meson.build

diff --git a/libvirt.spec.in b/libvirt.spec.in
index 9cbdb2c513..1b807ec324 100644
--- a/libvirt.spec.in
+++ b/libvirt.spec.in
@@ -1239,14 +1239,6 @@ export SOURCE_DATE_EPOCH=$(stat --printf='%Y' %{_specdir}/%{name}.spec)
            %{?arg_login_shell}
 
 %meson_build
-%if 0%{?with_selinux}
-# SELinux policy (originally from selinux-policy-contrib)
-# this policy module will override the production module
-cd selinux
-
-make -f %{_datadir}/selinux/devel/Makefile %{modulename}.pp
-bzip2 -9 %{modulename}.pp
-%endif
 
 %install
 rm -fr %{buildroot}
@@ -1331,10 +1323,6 @@ mv $RPM_BUILD_ROOT%{_datadir}/systemtap/tapset/libvirt_qemu_probes.stp \
     %endif
 %endif
 
-%if 0%{?with_selinux}
-install -D -m 0644 selinux/%{modulename}.pp.bz2 %{buildroot}%{_datadir}/selinux/packages/%{selinuxtype}/%{modulename}.pp.bz2
-%endif
-
 %check
 # Building on slow archs, like emulated s390x in Fedora copr, requires
 # raising the test timeout
diff --git a/meson.build b/meson.build
index 69a7b4c88e..884d3a490d 100644
--- a/meson.build
+++ b/meson.build
@@ -2182,6 +2182,18 @@ endif
 
 subdir('build-aux')
 
+os_release = run_command('grep', '^ID=', '/etc/os-release').stdout()
+os_version = run_command('grep', '^VERSION_ID=', '/etc/os-release').stdout().split('=')
+if (os_version.length() == 2)
+  os_version = os_version[1]
+else
+  os_version = 0
+endif
+
+if ((os_release.contains('fedora') and os_version.version_compare('>33')) or
+    (os_release.contains('rhel') and os_version.version_compare('>8')))
+  subdir('selinux')
+endif
 
 # install pkgconfig files
 pkgconfig_files = [
diff --git a/selinux/compile_policy.py b/selinux/compile_policy.py
new file mode 100755
index 0000000000..2de26f21c7
--- /dev/null
+++ b/selinux/compile_policy.py
@@ -0,0 +1,128 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2021 Red Hat, Inc.
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library.  If not, see
+# <http://www.gnu.org/licenses/>.
+
+# This script is based on selinux-policy Makefile
+# https://github.com/fedora-selinux/selinux-policy/blob/rawhide/support/Makefile.devel
+
+import subprocess
+import sys
+import os
+import glob
+
+if len(sys.argv) != 6:
+    print("Usage: %s <policy>.te <policy>.if <policy>.fc <output>.pp <tmpdir>"
+          % sys.argv[0], file=sys.stderr)
+    exit(os.EX_USAGE)
+
+module_name = os.path.splitext(os.path.basename(sys.argv[1]))[0]
+
+m4param = ["-D", "enable_mcs", "-D", "distro_redhat", "-D",
+           "hide_broken_symptoms", "-D", "mls_num_sens=16", "-D",
+           "mls_num_cats=1024", "-D", "mcs_num_cats=1024"]
+
+SHAREDIR = "/usr/share/selinux"
+HEADERDIR = os.path.join(SHAREDIR, "devel/include")
+
+m4support = sorted(glob.glob("{}/support/*.spt".format(HEADERDIR)))
+header_layers = glob.glob("{}/*/".format(HEADERDIR))
+header_layers = sorted([x for x in header_layers
+                        if os.path.join(HEADERDIR, "support") not in x])
+
+header_interfaces = []
+for layer in header_layers:
+    header_interfaces.extend(glob.glob("{}/*.if".format(layer)))
+header_interfaces.sort()
+
+# prepare temp folder
+try:
+    os.makedirs(sys.argv[5])
+except Exception:
+    pass
+
+# remove old trash from the temp folder
+for name in ["iferror.m4" "all_interfaces.conf" "{}.*".format(module_name)]:
+    try:
+        os.remove(os.path.join(sys.argv[5], name))
+    except Exception:
+        pass
+
+# tmp/all_interfaces.conf
+# echo "ifdef(\`__if_error',\`m4exit(1)')" > $5/iferror.m4
+with open(os.path.join(sys.argv[5], "iferror.m4"), "w") as file:
+    file.write("ifdef(`__if_error',`m4exit(1)')\n")
+
+# echo "divert(-1)" > $5/all_interfaces.conf
+with open(os.path.join(sys.argv[5], "all_interfaces.conf"), "w") as int_file:
+    int_file.write("divert(-1)\n")
+
+# m4 $M4SUPPORT $HEADER_INTERFACES $2 $5/iferror.m4
+#   | sed -e s/dollarsstar/\$\$\*/g >> $5/all_interfaces.conf
+subprocess.run(r"m4 {} | sed -e s/dollarsstar/\$\$\*/g >> {}".format(
+               " ".join([*m4support, *header_interfaces, sys.argv[2],
+                         os.path.join(sys.argv[5], "iferror.m4")]),
+               os.path.join(sys.argv[5], "all_interfaces.conf")),
+               shell=True, check=True)
+
+# doesn't work properly without "shell=True"
+#    m4_process = Popen(["m4", *m4support, *header_interfaces, sys.argv[2],
+#                        os.path.join(sys.argv[5], "iferror.m4")],
+#                       stdout=PIPE, stderr=PIPE)
+#    sed_process = Popen(["sed", "-e", "s/dollarsstar/\$\$\*/g"],
+#                        stdin=m4_process.stdout, stdout=int_file)
+#    outs, errs = m4_process.communicate()
+
+# echo "divert" >> $5/all_interfaces.conf
+with open(os.path.join(sys.argv[5], "all_interfaces.conf"), "a") as file:
+    file.write("divert\n")
+
+# tmp/%.mod
+# m4 $M4PARAM -s $M4SUPPORT $5/all_interfaces.conf $1 > $5/$MODULE_NAME.tmp
+with open(os.path.join(sys.argv[5], "{}.tmp".format(module_name)),
+          "w") as tmp_file:
+    subprocess.run(["m4", *m4param, "-s", *m4support,
+                    os.path.join(sys.argv[5], "all_interfaces.conf"),
+                    sys.argv[1]], stdout=tmp_file, check=True)
+
+# /usr/bin/checkmodule -M -m $5/$MODULE_NAME.tmp -o $5/$MODULE_NAME.mod
+subprocess.run(["/usr/bin/checkmodule",
+                "-M",
+                "-m",
+                os.path.join(sys.argv[5], "{}.tmp".format(module_name)),
+                "-o",
+                os.path.join(sys.argv[5], "{}.mod".format(module_name))],
+               check=True)
+
+
+# tmp/%.mod.fc
+# m4 $M4PARAM $M4SUPPORT $3 > $5/$MODULE_NAME.mod.fc
+with open(os.path.join(sys.argv[5],
+                       "{}.mod.fc".format(module_name)), "w") as mod_fc_file:
+    subprocess.run(["m4", *m4param, *m4support, sys.argv[3]],
+                   stdout=mod_fc_file, check=True)
+
+# %.pp
+# /usr/bin/semodule_package -o $4 -m $5/$MODULE_NAME.mod
+#   -f $5/$MODULE_NAME.mod.fc
+subprocess.run(["/usr/bin/semodule_package",
+                "-o",
+                sys.argv[4],
+                "-m",
+                os.path.join(sys.argv[5], "{}.mod".format(module_name)),
+                "-f",
+                os.path.join(sys.argv[5], "{}.mod.fc".format(module_name))],
+               check=True)
diff --git a/selinux/meson.build b/selinux/meson.build
new file mode 100644
index 0000000000..2737e60519
--- /dev/null
+++ b/selinux/meson.build
@@ -0,0 +1,23 @@
+selinux_sources = [
+  'virt.te',
+  'virt.if',
+  'virt.fc',
+]
+
+compile_policy_prog = find_program('compile_policy.py')
+
+virt_pp = custom_target('virt.pp',
+  output : 'virt.pp',
+  input : selinux_sources,
+  command : [compile_policy_prog, '@INPUT@', '@OUTPUT@', 'selinux/tmp'],
+  install : false)
+
+bzip2_prog = find_program('bzip2')
+
+bzip = custom_target('virt.pp.bz2',
+  output : 'virt.pp.bz2',
+  input : virt_pp,
+  command : [bzip2_prog, '-c', '-9', '@INPUT@'],
+  capture : true,
+  install : true,
+  install_dir : 'share/selinux/packages/')
-- 
2.30.2

