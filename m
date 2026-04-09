Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A983AC0FE
	for <selinux@vger.kernel.org>; Thu,  9 Apr 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725495; cv=none; b=lawpdOTauoUtZQVaAEbbfOlE8ClEL0gpm3//mvUpXdw4wU4hoJbpGi/td71kd5EWk/Yv4qLNNLo1Mg8oz/P6zZQWDsrcNYAyCgqAnKpvSbaXy1DLPqkYP6Dh36ESHN3xNIzyWOSAacUqPCiQXXLb1wr0fpEEc6/hycg339J7REA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725495; c=relaxed/simple;
	bh=Z26RufYf9AE8PEM1c/upvEWpn5JAegeHrxHe9K3JlbU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C+ZrK/72FTY4DYfKdj2eSboByP2wSadBNPOCfg1r8Z4urmUfhGj/Yvawqkafk3caOPEYtHvwSUsSziRZ8j0SJF0Q+yLvytr5usC6mEtivgtKvodjLJRGb1y63Bt09OaiaAKtw+sWL2BbtHLDUlc8SXVVGL09STnpq7htFEZLacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfXlc/sY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhjsAz32; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfXlc/sY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhjsAz32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775725493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xcV3ccCgKVELUTJYkL6/O7EVqrqYtmT8Nh5mezJfn8s=;
	b=PfXlc/sYdCuvAFgjOnBflor958v8UmAbfBnJqL3ySRyB+XDG1RFEHwQOpMfKrSIGRfhSbt
	Qc6WtDpRUgsGiRxHuW2hpEiKNj/huOaogX6BLs40GlFwTSlJLfefpsShwDAoOjUl2hUMt5
	nmECXytVboqN7eFYmL3/3GVGbEw98UY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-V8etKduPPiymEJJlnOL3XA-1; Thu, 09 Apr 2026 05:04:51 -0400
X-MC-Unique: V8etKduPPiymEJJlnOL3XA-1
X-Mimecast-MFC-AGG-ID: V8etKduPPiymEJJlnOL3XA_1775725490
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488ba2919b9so6011865e9.1
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2026 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775725490; x=1776330290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcV3ccCgKVELUTJYkL6/O7EVqrqYtmT8Nh5mezJfn8s=;
        b=QhjsAz32naDYAoSqv5GXI4V46myR4h6XFQ/zNUDfLwmCTiRAqqVmGznWu61LqH+sHR
         AcsVg8ECzYulFUqBhVZGvOJjkBEpWmZ/wrmsT3vpn6Fe8GMpjwtAG2VKtkA6K32advJv
         Kmh2Bo2ogIimte3otL4jEuQX2916RPsOYZbHhdj8m37yeqttiG1Yd1yupvUQR1BB2co7
         uPO6bzEZuVk1oz2pv5IrjVgjib6bwEPDuPq64J+zp3FSQNOm6tqVphQ2PSg5UwxG1rhf
         U5uxX4+6dtvK/LMc+5anJddZ27LUf+iLOUgVJGjH/QXG5mk3KyvOJa6WAhN9dzREB8Lp
         RGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775725490; x=1776330290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcV3ccCgKVELUTJYkL6/O7EVqrqYtmT8Nh5mezJfn8s=;
        b=r70lIl5tZoPNtwhbxojkllw99f8Pu2YpCFhniw3pH0A1C+Ao0EJWLl9bH7+I0ofTYp
         9c4nb4E6ZBeeaHnpJnz+o3qt672FrEmcKkYUaAEHYFxdZw7D3Rs2pG7dM5pTl3FYtZ/8
         yTJ1E7ubU20ytFvNFlVY4Vk7TiFOs5l6ABBNX7K1eIkGjvRUpNLHWM2CCofgKzUVZhEH
         nvgQBVGEyo+nm+XbFUAKwq3ojkgmqXladh9m6gsez+4hMiUD++crYO2fG+vvsGbidHvB
         FY4FjYFOb9mpoJGYS4pQN+F5gLjggahv8Hd6UDRYOkTlA84qJJPy8Qwlo1Z5+qjfWmXl
         Fl+A==
X-Gm-Message-State: AOJu0Yww9LgVE7BSN0jR3ugicO9SF7ddHv7bAkLjPZd3FRS/jVgwLQcC
	/CB8iArSZnkkVPRq+teovYcKe90LQA51Xz5tIIpi1jcyoucxUXgfHs9/v/016e7kV1Rob3PjWdY
	M6RMDbnT41WHkI9Ac/Cst99tiZ1vck/rABlO7Hw9xu1AXg/yf0JJpHRmDmmCmL27FA5d78wpCMb
	E83G57snEucgRFtClzP1BpaPK9o2hqlvjrApBihFB07CzPxA==
X-Gm-Gg: AeBDiesIGkyfLSS3Vuc5B/vS4XKMGn3FBhLbnNu2/aCsyKQohniqoUZavx9bCfi1sx9
	9JiEVcpGw/Aux28n6b7UNXZymY1MHTOySEkT3kwwne+J7pSinBi/0ovXibw6Jotkm3VNHhSU4uv
	uTfIXRfq2YMfQkdi+/yC3w87/SzsyvsLOt2BChz3nVyEgmGtytw8wHhOKYhK3QePgaR8TJGAtdS
	VRs9ZjzyujZ6xcKuxfGDubrHQ7XvFRg2QyGbqmicRLKrdm95WeEiVwo1iv/ptlLxj2l2qbwHLBp
	31QaSYdsQ6zILJqVXLdm5HdcJ8aiEzmbw+mAFklsuK3nNQWQywj8klf4MMHcdecA8tXs4v16JzI
	2OA0=
X-Received: by 2002:a05:600c:4688:b0:488:b187:d8ed with SMTP id 5b1f17b1804b1-488b187e4admr193835115e9.2.1775725489487;
        Thu, 09 Apr 2026 02:04:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:488:b187:d8ed with SMTP id 5b1f17b1804b1-488b187e4admr193834115e9.2.1775725488617;
        Thu, 09 Apr 2026 02:04:48 -0700 (PDT)
Received: from fedora ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5468sm64409627f8f.13.2026.04.09.02.04.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 02:04:47 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/overlay: add tests for mmap(2) and mprotect(2)
Date: Thu,  9 Apr 2026 11:04:42 +0200
Message-ID: <20260409090442.2846125-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add asserts that verify the expected behavior of mmap(2) and mprotect(2)
on overlayfs files.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_overlayfs.te    |  45 ++++++++++--
 tests/overlay/.gitignore    |   1 +
 tests/overlay/map_access.c  |  55 ++++++++++++++
 tests/overlay/setup-overlay |  10 ++-
 tests/overlay/test          | 138 +++++++++++++++++++++++++++++++++---
 5 files changed, 232 insertions(+), 17 deletions(-)
 create mode 100644 tests/overlay/map_access.c

diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index c09b577..787685c 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -21,6 +21,12 @@ files_type(test_overlay_files_ro_t)
 type test_overlay_files_rwx_t;
 files_type(test_overlay_files_rwx_t)
 
+type test_overlay_files_map_ro_t;
+files_type(test_overlay_files_map_ro_t)
+
+type test_overlay_files_map_rwx_t;
+files_type(test_overlay_files_map_rwx_t)
+
 type test_overlay_mounter_files_t;
 files_type(test_overlay_mounter_files_t)
 
@@ -60,7 +66,11 @@ allow test_overlay_mounter_t test_overlay_files_ro_t:file mounton;
 allow test_overlay_mounter_t test_overlay_files_ro_t:filesystem { mount relabelfrom relabelto };
 allow test_overlay_mounter_t test_overlay_files_rwx_t:{dir file} mounton;
 allow test_overlay_mounter_t test_overlay_files_rwx_t:filesystem { mount relabelfrom relabelto };
-can_exec(test_overlay_mounter_t, test_overlay_files_ro_t)
+allow test_overlay_mounter_t test_overlay_files_map_ro_t:file mounton;
+allow test_overlay_mounter_t test_overlay_files_map_ro_t:filesystem { mount relabelfrom relabelto };
+allow test_overlay_mounter_t test_overlay_files_map_rwx_t:{dir file} mounton;
+allow test_overlay_mounter_t test_overlay_files_map_rwx_t:filesystem { mount relabelfrom relabelto };
+can_exec(test_overlay_mounter_t, test_overlay_files_map_ro_t)
 
 #
 # Mounter should be allowed to search/read r/o directories and files
@@ -70,10 +80,14 @@ read_files_pattern(test_overlay_mounter_t, test_overlay_files_ro_t, test_overlay
 read_chr_files_pattern(test_overlay_mounter_t, test_overlay_files_ro_t, test_overlay_files_ro_t)
 read_blk_files_pattern(test_overlay_mounter_t, test_overlay_files_ro_t, test_overlay_files_ro_t)
 read_lnk_files_pattern(test_overlay_mounter_t, test_overlay_files_ro_t, test_overlay_files_ro_t)
+list_dirs_pattern(test_overlay_mounter_t, test_overlay_files_map_ro_t, test_overlay_files_map_ro_t)
+read_files_pattern(test_overlay_mounter_t, test_overlay_files_map_ro_t, test_overlay_files_map_ro_t)
+allow_map(test_overlay_mounter_t, test_overlay_files_map_ro_t, file)
 allow test_overlay_mounter_t test_overlay_files_ro_t:dir mounton;
 allow test_overlay_mounter_t test_overlay_mounter_files_t:dir mounton;
-allow test_overlay_mounter_t test_overlay_files_rwx_t:filesystem unmount;
+allow test_overlay_mounter_t test_overlay_files_map_rwx_t:filesystem unmount;
 manage_files_pattern(test_overlay_mounter_t, test_overlay_mounter_files_t, test_overlay_mounter_files_t)
+allow_map(test_overlay_mounter_t, test_overlay_mounter_files_t, file)
 # Needed for transition
 manage_dirs_pattern(test_overlay_mounter_t, test_overlay_mounter_files_t, test_overlay_mounter_files_t)
 #
@@ -90,6 +104,10 @@ manage_dirs_pattern(test_overlay_mounter_t, test_overlay_files_rwx_t, test_overl
 manage_lnk_files_pattern(test_overlay_mounter_t, test_overlay_files_rwx_t, test_overlay_files_rwx_t)
 manage_sock_files_pattern(test_overlay_mounter_t, test_overlay_files_rwx_t, test_overlay_files_rwx_t)
 
+manage_files_pattern(test_overlay_mounter_t, test_overlay_files_map_rwx_t, test_overlay_files_map_rwx_t)
+manage_dirs_pattern(test_overlay_mounter_t, test_overlay_files_map_rwx_t, test_overlay_files_map_rwx_t)
+allow_map(test_overlay_mounter_t, test_overlay_files_map_rwx_t, file)
+
 manage_files_pattern(test_overlay_mounter_t, test_overlay_transition_files_t, test_overlay_transition_files_t)
 
 #
@@ -121,7 +139,11 @@ list_dirs_pattern(test_overlay_client_t, test_overlay_files_ro_t, test_overlay_f
 read_lnk_files_pattern(test_overlay_client_t, test_overlay_files_ro_t, test_overlay_files_ro_t)
 read_chr_files_pattern(test_overlay_client_t, test_overlay_files_ro_t, test_overlay_files_ro_t)
 read_sock_files_pattern(test_overlay_client_t, test_overlay_files_ro_t, test_overlay_files_ro_t)
-can_exec(test_overlay_client_t, test_overlay_files_ro_t)
+
+read_files_pattern(test_overlay_client_t, test_overlay_files_map_ro_t, test_overlay_files_map_ro_t)
+allow_map(test_overlay_client_t, test_overlay_files_map_ro_t, file)
+can_exec(test_overlay_client_t, test_overlay_files_map_ro_t)
+allow test_overlay_client_t test_overlay_files_map_ro_t:file entrypoint;
 
 #
 # Client should be allowed to execute/write/search/read r/w/x directories and files
@@ -131,15 +153,22 @@ manage_dirs_pattern(test_overlay_client_t, test_overlay_files_rwx_t, test_overla
 manage_lnk_files_pattern(test_overlay_client_t, test_overlay_files_rwx_t, test_overlay_files_rwx_t)
 rw_chr_files_pattern(test_overlay_client_t, test_overlay_files_rwx_t, test_overlay_files_rwx_t)
 manage_sock_files_pattern(test_overlay_client_t, test_overlay_files_rwx_t, test_overlay_files_rwx_t)
-can_exec(test_overlay_client_t, test_overlay_files_rwx_t)
-allow test_overlay_client_t test_overlay_files_rwx_t:file entrypoint;
+
+manage_files_pattern(test_overlay_client_t, test_overlay_files_map_rwx_t, test_overlay_files_map_rwx_t)
+manage_dirs_pattern(test_overlay_client_t, test_overlay_files_map_rwx_t, test_overlay_files_map_rwx_t)
+manage_lnk_files_pattern(test_overlay_client_t, test_overlay_files_map_rwx_t, test_overlay_files_map_rwx_t)
+rw_chr_files_pattern(test_overlay_client_t, test_overlay_files_map_rwx_t, test_overlay_files_map_rwx_t)
+manage_sock_files_pattern(test_overlay_client_t, test_overlay_files_map_rwx_t, test_overlay_files_map_rwx_t)
+allow_map(test_overlay_client_t, test_overlay_files_map_rwx_t, file)
+can_exec(test_overlay_client_t, test_overlay_files_map_rwx_t)
+allow test_overlay_client_t test_overlay_files_map_rwx_t:file entrypoint;
 
 #
 # Client needs to manage test_overlay_transition_files_t and transition on file named "transition"
 #
 manage_files_pattern(test_overlay_client_t, test_overlay_transition_files_t, test_overlay_transition_files_t)
 manage_dirs_pattern(test_overlay_client_t, test_overlay_transition_files_t, test_overlay_transition_files_t)
-filetrans_pattern(test_overlay_client_t, test_overlay_files_rwx_t, test_overlay_transition_files_t, file, "transition")
+filetrans_pattern(test_overlay_client_t, test_overlay_files_map_rwx_t, test_overlay_transition_files_t, file, "transition")
 
 #
 # Client needs to search test_file_t directory and execute tests
@@ -153,7 +182,9 @@ can_exec(test_overlay_client_t,test_file_t)
 #
 allow test_overlay_client_t test_overlay_files_rwx_t:file { relabelto relabelfrom };
 allow test_overlay_mounter_t test_overlay_files_rwx_t:file { relabelto relabelfrom };
-can_exec(test_overlay_mounter_t, test_overlay_files_rwx_t)
+allow test_overlay_client_t test_overlay_files_map_rwx_t:file { relabelto relabelfrom };
+allow test_overlay_mounter_t test_overlay_files_map_rwx_t:file { relabelto relabelfrom };
+can_exec(test_overlay_mounter_t, test_overlay_files_map_rwx_t)
 
 #
 # Server needs to manage socket files
diff --git a/tests/overlay/.gitignore b/tests/overlay/.gitignore
index 73bc322..dc61362 100644
--- a/tests/overlay/.gitignore
+++ b/tests/overlay/.gitignore
@@ -1 +1,2 @@
 access
+map_access
diff --git a/tests/overlay/map_access.c b/tests/overlay/map_access.c
new file mode 100644
index 0000000..495a262
--- /dev/null
+++ b/tests/overlay/map_access.c
@@ -0,0 +1,55 @@
+#include <unistd.h>
+#include <fcntl.h>
+
+#include <sys/mman.h>
+
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+
+int main(int argc, const char **argv)
+{
+	const char *file;
+	void *ptr;
+	int rdonly, fd, ret;
+
+	if (argc != 3 || (strcmp(argv[2], "R_OK") && strcmp(argv[2], "W_OK"))) {
+		fprintf(stderr, "Usage %s <file> R_OK|W_OK\n", argv[0]);
+		return EINVAL;
+	}
+
+	file = argv[1];
+	rdonly = strcmp(argv[2], "R_OK") == 0;
+
+	fd = open(file, rdonly ? O_RDONLY : O_RDWR);
+	if (fd == -1) {
+		perror("open");
+		return 2;
+	}
+
+	/* try direct mmap */
+	ptr = mmap(NULL, 1, rdonly ? PROT_READ : PROT_READ|PROT_WRITE,
+		   MAP_SHARED, fd, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		return 3;
+	}
+	munmap(ptr, 1);
+
+	/* try mmap with PROT_NONE followed by mprotect with full access */
+	ptr = mmap(NULL, 1, PROT_NONE, MAP_SHARED, fd, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap PROT_NONE");
+		return 4;
+	}
+
+	ret = mprotect(ptr, 1, rdonly ? PROT_READ : PROT_READ|PROT_WRITE);
+	if (ret == -1) {
+		perror("mprotect");
+		return 5;
+	}
+
+	munmap(ptr, 1);
+	close(fd);
+	return 0;
+}
diff --git a/tests/overlay/setup-overlay b/tests/overlay/setup-overlay
index 3f33499..ae817a1 100755
--- a/tests/overlay/setup-overlay
+++ b/tests/overlay/setup-overlay
@@ -12,6 +12,8 @@ setup () {
     mkdir -p $BASEDIR/lower/readdir $BASEDIR/lower/writedir $BASEDIR/lower/noaccessdir $BASEDIR/lower/mounterdir
     echo read > $BASEDIR/lower/readfile
     echo write > $BASEDIR/lower/writefile
+    echo mapread > $BASEDIR/lower/mapreadfile
+    echo mapwrite > $BASEDIR/lower/mapwritefile
     echo noaccess > $BASEDIR/lower/noaccessfile
     echo client_nounlink > $BASEDIR/lower/client_nounlinkfile
     echo mounter > $BASEDIR/lower/mounterfile
@@ -35,7 +37,11 @@ setup () {
     chcon -t test_overlay_mounter_files_t $BASEDIR/lower/mounterfile $BASEDIR/lower/mounterdir $BASEDIR/lower/null_mounter
     # Label writefile on lower with a type that is writable by the client which
     # should allow copy up and write.
-    chcon -t test_overlay_files_rwx_t $BASEDIR/lower/writefile $BASEDIR/lower/writedir $BASEDIR/lower/null_write $BASEDIR/lower/transition $BASEDIR/lower/goodentrypoint
+    chcon -t test_overlay_files_rwx_t $BASEDIR/lower/writefile $BASEDIR/lower/writedir $BASEDIR/lower/null_write $BASEDIR/lower/transition
+    # Label mapreadfile and mapwritefile with the appropriate types that
+    # allow map access
+    chcon -t test_overlay_files_map_ro_t $BASEDIR/lower/mapreadfile $BASEDIR/lower/goodentrypoint
+    chcon -t test_overlay_files_map_rwx_t $BASEDIR/lower/mapwritefile
     # Create a directory per container.
     mkdir -p $BASEDIR/container1
 
@@ -48,7 +54,7 @@ setup () {
     # creation and to prevent permission problems when overlayfs
     # internally creates files on behalf of the current process.
     chcon -R -t test_overlay_mounter_files_t $BASEDIR/container1/work $BASEDIR/container1/merged
-    chcon -R -t test_overlay_files_rwx_t  $BASEDIR/container1/upper
+    chcon -R -t test_overlay_files_map_rwx_t  $BASEDIR/container1/upper
 }
 
 # Mount the overlays.
diff --git a/tests/overlay/test b/tests/overlay/test
index c8367dd..801a703 100755
--- a/tests/overlay/test
+++ b/tests/overlay/test
@@ -19,7 +19,7 @@ BEGIN {
         plan skip_all => "overlayfs upperdir not supported on NFS";
     }
     else {
-        plan tests => 119;
+        plan tests => 135;
     }
 }
 
@@ -44,6 +44,14 @@ sub access {
     return $result >> 8;
 }
 
+sub mmap {
+    my ( $filename, $accesstype ) = @_;
+    $result = system(
+"runcon -t test_overlay_client_t -l s0:c10,c20 $basedir/map_access $filename $accesstype 2>&1"
+    );
+    return $result >> 8;
+}
+
 sub xattr_test_setup {
     print "Setting up xattr test\n";
     system("touch $basedir/container1/merged/writefile >/dev/null");
@@ -104,7 +112,7 @@ sub test_4_0_ctx {
     $output = getfilecon("$basedir/container1/upper/writefile");
 
     # Newly created writefile should have s0 MCS Label since it was copied up
-    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_map_rwx_t:s0:c10,c20" );
 }
 
 sub test_5 {
@@ -130,7 +138,7 @@ sub test_5_1 {
     $output = getfilecon("$basedir/container1/upper/newdir");
 
     # Newly created writedir should have s0:c10,c20 since it was created new
-    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_map_rwx_t:s0:c10,c20" );
 }
 
 sub test_5_2 {
@@ -148,7 +156,7 @@ sub test_5_3 {
     $output = getfilecon("$basedir/container1/upper/newdir/touchlink");
 
     # Newly created writelink should have s0:c10,c20 since it was created new
-    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_map_rwx_t:s0:c10,c20" );
 }
 
 sub test_6 {
@@ -182,7 +190,7 @@ sub test_7_0_ctx {
     $output = getfilecon("$basedir/container1/upper/writedir/bar");
 
     # Newly created bar should have s0:c10,c20 since it was created new
-    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_map_rwx_t:s0:c10,c20" );
 }
 
 sub test_7_1 {
@@ -208,7 +216,7 @@ sub test_7_1_0_ctx {
     $output = getfilecon("$basedir/container1/upper/writedir/writelink");
 
     # Newly created writelink should have s0:c10,c20 since it was created new
-    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_map_rwx_t:s0:c10,c20" );
 }
 
 sub test_7_2 {
@@ -452,7 +460,7 @@ sub test_42_ctx {
     $output = getfilecon("$basedir/container1/upper/transition");
 
     # Newly created writeout should have s0:c10,c20 since it was created new
-    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_map_rwx_t:s0:c10,c20" );
 }
 
 sub test_43 {
@@ -554,6 +562,85 @@ sub test_67 {
     return;
 }
 
+sub test_68_1 {
+    print "Check read map access on noaccessfile, should fail\n";
+    $result = mmap( "$basedir/container1/merged/noaccessfile", "R_OK" );
+    ok( $result eq 2 );
+    return;
+}
+
+sub test_68_2 {
+    print "Check write map access on noaccessfile, should fail\n";
+    $result = mmap( "$basedir/container1/merged/noaccessfile", "W_OK" );
+    ok( $result eq 2 );
+    return;
+}
+
+sub test_68_3 {
+    print "Check read map access on readfile, should fail\n";
+    $result = mmap( "$basedir/container1/merged/readfile", "R_OK" );
+    ok( $result eq 3 );
+    return;
+}
+
+sub test_68_4 {
+    print "Check write map access on writefile, should fail\n";
+    $result = mmap( "$basedir/container1/merged/writefile", "W_OK" );
+    ok( $result eq 3 );
+    return;
+}
+
+# In the context mount case, this will create a new file in upperdir,
+# which will be mappable by mounter.
+sub test_68_4_ctx {
+    print "Check write map access on writefile, should succeed\n";
+    $result = mmap( "$basedir/container1/merged/writefile", "W_OK" );
+    ok( $result eq 0 );
+    return;
+}
+
+sub test_68_5 {
+    print "Check read map access on mapreadfile, should succeed\n";
+    $result = mmap( "$basedir/container1/merged/mapreadfile", "R_OK" );
+    ok( $result eq 0 );
+    return;
+}
+
+sub test_68_6 {
+    print "Check write map access on mapwritefile, should succeed\n";
+    $result = mmap( "$basedir/container1/merged/mapwritefile", "W_OK" );
+    ok( $result eq 0 );
+    return;
+}
+
+sub test_68_7 {
+    print "Check read map access on mounterfile, should fail\n";
+    $result = mmap( "$basedir/container1/merged/mounterfile", "R_OK" );
+    ok( $result eq 2 );
+    return;
+}
+
+sub test_68_7_ctx {
+    print "Check read map access on mounterfile, should succeed\n";
+    $result = mmap( "$basedir/container1/merged/mounterfile", "R_OK" );
+    ok( $result eq 0 );
+    return;
+}
+
+sub test_68_8 {
+    print "Check write map access on mounterfile, should fail\n";
+    $result = mmap( "$basedir/container1/merged/mounterfile", "W_OK" );
+    ok( $result eq 2 );
+    return;
+}
+
+sub test_68_8_ctx {
+    print "Check write map access on mounterfile, should succeed\n";
+    $result = mmap( "$basedir/container1/merged/mounterfile", "W_OK" );
+    ok( $result eq 0 );
+    return;
+}
+
 sub test_70 {
     print "Check unlink access on client_nounlinkfile, should fail.\n";
     $result = system(
@@ -793,6 +880,18 @@ sub nocontext_test {
     test_66();
     test_67();
 
+    print "=====================================================\n";
+    print "map access tests.\n";
+    print "=====================================================\n";
+    test_68_1();
+    test_68_2();
+    test_68_3();
+    test_68_4();
+    test_68_5();
+    test_68_6();
+    test_68_7();
+    test_68_8();
+
     print "=====================================================\n";
     print "unlink tests.\n";
     print "=====================================================\n";
@@ -820,7 +919,7 @@ sub nocontext_test {
 sub context_test {
 
     cleanup();
-    $context = "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20";
+    $context = "$seuser:object_r:test_overlay_files_map_rwx_t:s0:c10,c20";
     print "\n\n=====================================================\n";
     print "Testing mounting overlayfs with context switch\n";
     print "context=$context\n";
@@ -911,6 +1010,29 @@ sub context_test {
     test_66();
     test_67();
 
+    print "=====================================================\n";
+    print "map access tests.\n";
+    print "=====================================================\n";
+    # Reset the overlay to clear any upperdir files created by previous tests.
+    # This is needed for some tests below to accurately test mounter checks.
+    cleanup();
+    if ( system("$basedir/setup-overlay $basedir '$context'") == 0 ) {
+        print "Mounted overlay with context=$context.\n";
+    }
+    else {
+        print "setup-overlay failed. Cleaning up.\n";
+        cleanup();
+        exit;
+    }
+    test_68_1();
+    test_68_2();
+    test_68_3();
+    test_68_4_ctx();
+    test_68_5();
+    test_68_6();
+    test_68_7_ctx();
+    test_68_8_ctx();
+
     print "=====================================================\n";
     print "unlink tests.\n";
     print "=====================================================\n";
-- 
2.53.0

