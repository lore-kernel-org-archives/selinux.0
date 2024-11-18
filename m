Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD951AA1E7
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942195; cv=none; b=DHAoqpcPg8vn4bez/MnR2VLPOD7uGQlYXXctA75vu3p+uE9u9g3lb/CDP6lG7c+GVGV+itE2dHTXLLgJNNp95xRGQ6gZgbFhoZ3xCXqqiL1xTfloBaHSqXYgCYhbM8RKPKR7yhmLpmjVUOKxlfqCLBu6yC9yF8oyfjHnxijnF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942195; c=relaxed/simple;
	bh=tPjK0Uajb9gxz2w9IJfwC4umQ1UR5k3OTEUS4CYgcMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kzdXSby3hBac9lWCzAl7C067terMXwsTr8kclxlJjfyOmhrzZBncYNTtH4fRu51TG2w2s0rzU4o/vmtHLx1H8jzEQWXhIvS8C2kfp5L0K7ar8v8rGwxNL5rHo46vjttWOkSDHMNUDHZbdpA8xWagot+5oKPqehG+kWDhXrQBXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Pc2GQ8qr; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Pc2GQ8qr"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZJWWbcCqzyMaQPDvhw2cj9Xr7fhdIfTMd+ck05GoCT4=;
	b=Pc2GQ8qrLgAaxYGcxeuNAw57JFZvhYbNbOa6wuIPlXmgPLjpbrOj1uhgoIJS/W58ZRN4c9
	ml0E0SSox/96fNpNlRM2IUDxDYwRIOM9Nt7WC4BF+qZlY728pb+3CJug8ij3jXqYFU8RvE
	WMEjMlWJtxQ5YjHVuNBPSlmSPc3IR+N+twYXdMKlTXg4eGAdnVzOxNiZXyPnmBozPNRTQH
	QXAhGUsQKj7gBNTIjPcqJqheos0X7e0/GfAmV1tPcfad2zqpEpNWRJeOf7DFr1JyG+WlaC
	3G3av7mbCmWSYkifgXM/EWmHrHlLv9ci+8bnn6wzIvKHF77gZQ54JypmwwgiEQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 00/17] testsuite: misc fixes and virtme-ng support
Date: Mon, 18 Nov 2024 16:02:22 +0100
Message-ID: <20241118150256.135432-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

With the following patches the testsuite runs successfully in a virtme-ng environment.  A minimal virtme-ng default kernel configuration was used combined with the testsuite's included *defconfig*.

Also while working on failed testcases I tweaked some scripts and test code.

Test result:
```
Running as user root with context unconfined_u:unconfined_r:unconfined_t
                                                                               
domain_trans/test ........... ok   
entrypoint/test ............. ok                                                                                                                              
execshare/test .............. ok   
exectrace/test .............. ok                         
execute_no_trans/test ....... ok   
fdreceive/test .............. ok                           
inherit/test ................ ok   
link/test ................... ok                                                                                                                              
mkdir/test .................. ok                                                                                                                              
msg/test .................... ok                                                                                                                              
open/test ................... ok                                                                                                                              
ptrace/test ................. ok                                                                                                                              
readlink/test ............... ok                                                                                                                              
relabel/test ................ ok                          
rename/test ................. ok   
rxdir/test .................. ok
sem/test .................... ok     
setattr/test ................ ok   
setnice/test ................ ok   
shm/test .................... ok     
sigkill/test ................ ok     
stat/test ................... ok   
sysctl/test ................. ok   
task_create/test ............ ok   
task_setnice/test ........... ok   
task_setscheduler/test ...... ok   
task_getscheduler/test ...... ok   
task_getsid/test ............ ok   
task_getpgid/test ........... ok   
task_setpgid/test ........... ok   
file/test ................... ok     
ioctl/test .................. ok   
capable_file/test ........... ok     
capable_net/test ............ ok   
capable_sys/test ............ ok   
dyntrans/test ............... ok   
dyntrace/test ............... ok   
bounds/test ................. ok     
nnp_nosuid/test ............. ok     
mmap/test ................... ok     
unix_socket/test ............ ok     
inet_socket/tcp/test ........ ok     
inet_socket/udp/test ........ ok     
overlay/test ................ skipped: overlayfs upperdir not supported on NFS and OverlayFS
checkreqprot/test ........... ok   
mqueue/test ................. skipped: mqueue filesystem not supported/mounted
mac_admin/test .............. ok   
atsecure/test ............... ok   
infiniband_endport/test ..... skipped: test not configured
infiniband_pkey/test ........ skipped: test not configured
cap_userns/test ............. skipped: CLONE_NEWUSER not supported
extended_socket_class/test .. ok   
sctp/test ................... skipped: SCTP not supported
netlink_socket/test ......... ok   
prlimit/test ................ ok   
binder/test ................. ok   
bpf/test .................... ok     
keys/test ................... ok     
key_socket/test ............. ok   
glblub/test ................. ok   
cgroupfs_label/test ......... ok   
notify/test ................. ok   
module_load/test ............ ok   
tun_tap/test ................ skipped: No TUN/TAP support
perf_event/test ............. ok   
filesystem/xfs/test ......... ok     
filesystem/vfat/test ........ ok     
fs_filesystem/xfs/test ...... ok     
fs_filesystem/vfat/test ..... ok     
watchkey/test ............... ok   
userfaultfd/test ............ skipped: SELinux support for userfaultfd not present
vsock_socket/test ........... skipped: vsock socket family not supported
secretmem/test .............. ok
inet_socket/mptcp/test ...... skipped: protocol mptcp not supported
All tests successful.
Files=74, Tests=673, 75 wallclock secs ( 0.24 usr  0.41 sys +  3.39 cusr 15.81 csys = 19.85 CPU)
Result: PASS
```

The included policy needs to be tweaked (not included in this pull request):
```
diff --git a/policy/test_global.te b/policy/test_global.te
index 0078485..7125036 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -189,3 +189,26 @@ ifdef(`lockdown_defined', `allow $1 self:lockdown confidentiality;')
 define(`allow_userns_create',
 ifdef(`user_namespace_defined', `allow $1 self:user_namespace create;')
 )
+
+
+# virtme
+gen_require(`
+       type kernel_t, unconfined_t, unlabeled_t, virtiofs_t;
+')
+
+# tty since virtme starts with kernel_t after load_policy
+kernel_use_fds(testsuite_domain)
+
+fs_search_tmpfs(testsuite_domain)
+allow testsuite_domain virtiofs_t:dir search_dir_perms;
+allow testsuite_domain virtiofs_t:file { entrypoint execute execute_no_trans map read_file_perms };
+allow testsuite_domain virtiofs_t:lnk_file read_lnk_file_perms;
+
+fs_getattr_tmpfs(test_filesystem_t)
+# fs_manage_tmpfs_dirs
+allow test_overlay_mounter_t tmpfs_t:dir { read write };
+
+allow kernel_t self:capability2 mac_admin;
+allow { kernel_t unconfined_t } virtiofs_t:system module_load;
+
+fs_associate_tmpfs(unlabeled_t)
```

Also to speed up the development cycle I used the following two scripts:

*tools/vng_stage1.sh*
```sh
#!/bin/sh

set -eux

SCRIPTDIR=$(dirname "$0")

cd /

load_policy -i

setenforce 0

restorecon -RF -T0 /dev

# transition out of initial kernel sid
runcon -u unconfined_u -r unconfined_r -t unconfined_t /bin/bash "${SCRIPTDIR}/vng_stage2.sh"
```

*tools/vng_stage2.sh*
```sh
#!/bin/sh

set -eux

SCRIPTDIR=$(dirname "$0")

cd /

setenforce 1

# display some system status information
dmesg | tail -n 40
id
sestatus

cd "${SCRIPTDIR}/../"

make test -j"$(nproc)" || true

/bin/bash -i
```

Christian Göttsche (17):
  Fix typos
  Makefile: use $(MAKE) to pass options
  tools: quote command to prevent word splitting
  tests: port scripts to sh and please shellcheck
  tests: enable strictness for perl scripts
  Makefile: add PHONY targets
  test: overlayfs related tweaks
  tests/notify: work with CONFIG_FANOTIFY disabled
  tests/extended_socket_class: work with CONFIG_CRYPTO_USER_API disabled
  tests/tun_tap: skip if not supported
  tests/inet_socket: skip mptcp if not supported
  tests/filesystem: improve fsnotify check and preload loop module
  defconfig: enable CONFIG_XFRM_USER
  defconfig: enable CONFIG_NETFILTER_NETLINK_LOG
  tests: test code tweaks
  tests: fail on compiler warnings and enable Wextra
  tests: drop headers from Makefile dependencies

 Makefile                             |  10 +-
 defconfig                            |   4 +
 doc/tests/Makefile                   |   2 +-
 doc/tests/socket.sgml                |   2 +-
 policy/Makefile                      |   2 +
 policy/test_capable_file.te          |   2 +-
 policy/test_capable_net.te           |   2 +-
 policy/test_capable_sys.te           |   2 +-
 policy/test_mqueue.te                |   2 +-
 tests/Makefile                       |   2 +-
 tests/binder/Makefile                |   4 +-
 tests/binder/client.c                |   2 +-
 tests/binder/manager.c               |   2 +-
 tests/binder/service_provider.c      |  14 ++-
 tests/bounds/test                    |   4 +-
 tests/bpf/Makefile                   |   2 +-
 tests/bpf/bpf_test.c                 |   2 +-
 tests/cap_userns/userns_child_exec.c |   6 +-
 tests/capable_net/test               |   2 +-
 tests/capable_sys/test               |   4 +-
 tests/execshare/parent.c             |   2 +-
 tests/extended_socket_class/test     |  28 +++--
 tests/fdreceive/Makefile             |   2 +-
 tests/fdreceive/server.c             |   3 +-
 tests/file/test                      |   2 +-
 tests/file/test_nofcntl.c            |   2 +-
 tests/file/test_sigiotask.c          |   2 +-
 tests/filesystem/Filesystem.pm       |   2 +-
 tests/filesystem/fs_relabel.c        |   2 +-
 tests/filesystem/grim_reaper.c       |   2 +-
 tests/filesystem/test                |   3 +
 tests/inet_socket/bind.c             |   1 +
 tests/inet_socket/connect.c          |   1 +
 tests/inet_socket/test               |   5 +-
 tests/inherit/parent.c               |   2 +-
 tests/ioctl/test                     |   4 +-
 tests/ioctl/test_ioctl.c             |   4 +-
 tests/ioctl/test_noioctl.c           |   6 +-
 tests/key_socket/key_sock.c          |   2 +-
 tests/keys/Makefile                  |   2 -
 tests/kvercmp                        |  16 +--
 tests/loop.pl                        |   9 +-
 tests/module_load/init_load.c        |   2 +-
 tests/mqueue/mqmgr.c                 |   2 +-
 tests/mqueue/test                    |   2 +-
 tests/nfsruntests.pl                 |   6 +-
 tests/nnp_nosuid/execnnp.c           |   2 +-
 tests/notify/test                    | 172 ++++++++++++++++-----------
 tests/notify/test_fanotify.c         |  22 +++-
 tests/os_detect                      |  10 +-
 tests/overlay/setup-overlay          |   2 +-
 tests/overlay/test                   |   7 +-
 tests/pol_detect                     |  12 +-
 tests/prlimit/parent.c               |   2 +
 tests/runtests.pl                    |  16 ++-
 tests/sctp/sctp_common.c             |   4 +-
 tests/task_setscheduler/test         |   2 +-
 tests/tun_tap/Makefile               |   2 +-
 tests/tun_tap/test                   |  10 +-
 tests/tun_tap/tun_common.c           |   2 +-
 tests/tun_tap/tun_tap.c              |  10 +-
 tests/unix_socket/client.c           |   1 +
 tests/unix_socket/server.c           |   1 +
 tests/unix_socket/socketpair.c       |   1 +
 tests/userfaultfd/userfaultfd.c      |   2 +-
 tools/check-syntax                   |   2 +-
 66 files changed, 286 insertions(+), 182 deletions(-)

-- 
2.45.2

