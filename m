Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AE194C86
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701031; cv=none; b=DkMfnFjzUpCknLwh4/6XRYcGmxKaTlsPX1XPUud0MRSgj0SXatvI7AaqMVLfn7H1aWOGsSjkNoIJEJkVZM2DR7Bua6E+CJMZUWnqamrdbN/jkoEoiQL5DsEeiucEITJNiz58qTc9yfN4IXhVquQtJio1YyBQyeNal8wkyy1a5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701031; c=relaxed/simple;
	bh=hgjTHs5JmMMytybnRwTG3YlR471KLlQmy8BzkVTkoSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GMq/OAeVnDNl6BBLqkOjeIeZZUfta5TUHo5nXgX5wobD7jCSLjmlpsmH+itjoqKuitAN0jCkoUJk3I43Pm1WE6kKewHaxFK36g7zt9SyFww02bmwbpT35IrN/wY9c2ba/IDvX31rGBSczQh5DP81cRQ0uqTqyG9a87bltb4W6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ul57GFIa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ul57GFIa"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376dd56f60so3486642b3a.3
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744701028; x=1745305828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6o6VlG667ZEyC86nQszf0kC1MPduBRYvbeDLPV7sl8=;
        b=Ul57GFIaYyExv/b+DfPi/o8CI68A/gfO+S56edIZaVFmMHkg4WPkljG//oTJgtTD8G
         ORuh+dLSph6/o71QPoYQHfoGB9bZ/Hh0EQ4m7nG1QD1wEoK1QK95J2jVGlW1y+gHZ2vY
         JrO2v1uZ2Tv229es6LxWr9haDZ+3AopzlyUS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701028; x=1745305828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6o6VlG667ZEyC86nQszf0kC1MPduBRYvbeDLPV7sl8=;
        b=HHRotL3P4PTfGz7SiURaK7P5j617iFlcjca8oZIO5YxPalFjiDXCuHVRFyD6nAWAZ6
         nUHN2powdfgP37SAA2l16cxmRWgj2t+aV3Q0DYCWsFpZRMm1JnYrN//hoF/ttQGWm3SJ
         MN1NogtcDw4u6TtpJeNZcnRCbv+v9ip3qcqllzzijMjY0qJqYX1Q1zM/yEv2Go4E2hgo
         pu5XVz42L5WiDyE9X6gmk9PurYc3qqpJFFF8IRRrUFw9BI7co2eZ1e2JAS6KIMDJUsR1
         qANeWrx7W5OpdnSFDpNohExJJvD491+Tm6bK35XU0lAnwMIyQUjN2MtgegpdPbNQM8sQ
         Muyw==
X-Forwarded-Encrypted: i=1; AJvYcCWzvW9Ibm62kmGq0a+Nb0irPo8jTTegkggQxHypO0ji03RCaZQ2xY6jzgqvLtuxIPMpONevrIDY@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsVBdOko6lwO3pKGweaMpBMIBHpEEcPTWJjSsq2XTVD3HavYm
	mHjt9NzWLMqxkicy92/nAsW0qlQD4RRlNayadW32rcbeBk251rp4g1rachSgWA==
X-Gm-Gg: ASbGncuVfV/Ju1oDYs4cIb1Mg5UqKa+r3EFZF9wkn2+OvT9AgZDqA2vLotyxtpkMvMf
	ao97a5BulEDGSKEaIeMA707jhHwiCx5GotHuIggp59cxx4JLIZs8SPx9NJ6wxFRRAK84Xfi3UJn
	hX5sNaMun66kCkggmNCli+gp87P4PRgg3VnNqyV53ynKtfGNMuOCjzP821QS025bSv1Hl7FWazd
	0AMA0M9wRLDkK6v0t5xVc2e5QqhsWWpF9uVHQBLEGqLsl879bXGF7hZkd21pvvqJkmGI26piiu8
	iutnRr+IikZM9t8ogfdKfvew2oW7F3UEwyLAnKkf3W2lhtzuTsBlG4FdgfjZsygr6Wte8ss8Dxs
	5mjZfC8RtJbbn4AusTWj62Xb/wNmufPsu
X-Google-Smtp-Source: AGHT+IHtUHEUPGRVyXkbMi4UYc6Avpdq9djDvh+9l3Xj/U/x/5LMdUNaz958WfPpUVydJ+mBGs02Dg==
X-Received: by 2002:a05:6a21:168c:b0:1f5:619a:8f75 with SMTP id adf61e73a8af0-20179781db3mr27147152637.2.1744701028108;
        Tue, 15 Apr 2025 00:10:28 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a250sm8659543a12.62.2025.04.15.00.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:10:27 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v17 0/3] binder: report txn errors via generic netlink
Date: Tue, 15 Apr 2025 00:10:14 -0700
Message-ID: <20250415071017.3261009-1-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

It's a known issue that neither the frozen processes nor the system
administration process of the OS can correctly deal with failed binder
transactions. The reason is that there's no reliable way for the user
space administration process to fetch the binder errors from the kernel
binder driver.

Android is such an OS suffering from this issue. Since cgroup freezer
was used to freeze user applications to save battery, innocent frozen
apps have to be killed when they receive sync binder transactions or
when their async binder buffer is running out.

This patch introduces the Linux generic netlink messages into the binder
driver so that the Linux/Android system administration process can
listen to important events and take corresponding actions, like stopping
a broken app from attacking the OS by sending huge amount of spamming
binder transactiions.

The 1st version uses a global generic netlink for all binder contexts,
raising potential security concerns. There were a few other feedbacks
like request to kernel docs and test code. The thread can be found at
https://lore.kernel.org/lkml/20240812211844.4107494-1-dualli@chromium.org/

The 2nd version fixes those issues and has been tested on the latest
version of AOSP. See https://r.android.com/3305462 for how userspace is
going to use this feature and the test code. It can be found at
https://lore.kernel.org/lkml/20241011064427.1565287-1-dualli@chromium.org/

The 3rd version replaces the handcrafted netlink source code with the
netlink protocal specs in YAML. It also fixes the documentation issues.
https://lore.kernel.org/lkml/20241021182821.1259487-1-dualli@chromium.org/

The 4th version just containsi trivial fixes, making the subject of the
patch aligned with the subject of the cover letter.
https://lore.kernel.org/lkml/20241021191233.1334897-1-dualli@chromium.org/

The 5th version incorporates the suggested fixes to the kernel doc and
the init function. It also removes the unsupported uapi-header in YAML
that contains "/" for subdirectory.
https://lore.kernel.org/lkml/20241025075102.1785960-1-dualli@chromium.org/

The 6th version has some trivial kernel doc fixes, without modifying
any other source code.
https://lore.kernel.org/lkml/20241028101952.775731-1-dualli@chromium.org/

The 7th version breaks the binary struct netlink message into individual
attributes to better support automatic error checking. Thanks Jakub for
improving ynl-gen.
https://lore.kernel.org/all/20241031092504.840708-1-dualli@chromium.org/

The 8th version solves the multi-genl-family issue by demuxing the
messages based on a new context attribute. It also improves the YAML
spec to be consistent with netlink tradition. A Huge 'Thank You' to
Jakub who taught me a lot about the netlink protocol!
https://lore.kernel.org/all/20241113193239.2113577-1-dualli@chromium.org/

The 9th version only contains a few trivial fixes, removing a redundant
pr_err and unnecessary payload check. The ynl-gen patch to allow uapi
header in sub-dirs has been merged so it's no longer included in this
patch set.
https://lore.kernel.org/all/20241209192247.3371436-1-dualli@chromium.org/

The 10th version renames binder genl to binder netlink, improves the
readability of the kernel doc and uses more descriptive variable names.
The function binder_add_device() is moved out to a new commit per request.
It also fixes a warning about newline used in NL_SET_ERR_MSG.
Thanks Carlos for his valuable suggestions!
https://lore.kernel.org/all/20241212224114.888373-1-dualli@chromium.org/

The 11th version simplifies the yaml filename to avoid redundant words in
variable names. This also makes binder netlink yaml more aligned with
other existing netlink specs. Another trivial change is to use reverse
xmas tree for function variables.
https://lore.kernel.org/all/20241218203740.4081865-1-dualli@chromium.org/

The 12th version makes Documentation/admin-guide/binder_netlink.rst aligned
with the binder netlink yaml change introduced in the 11th revision. It
doesn't change any source code.
https://lore.kernel.org/all/20241218212935.4162907-1-dualli@chromium.org/

The 13th version removes the unnecessary dependency to binder file ops.
Now the netlink configuration is reset using sock_priv_destroy. It also
requires CAP_NET_ADMIN to send commands to the driver. One of the
patches ("binderfs: add new binder devices to binder_devices") has been
merged to linux-next. To avoid conflict, switch to linux-next master
branch and remove the merged one. Adding sock_priv into netlink spec
results in CFI failure, which is fixed by the new trampoline patches.
https://lore.kernel.org/all/20250115102950.563615-1-dualli@chromium.org/

The 14th version fix the code style issue by wrapping the sock priv
in a separate struct, as suggested by Jakub. The other 2 patches are
no longer included in this patchset as the equvilent fix has already
been merged to upstream linux master branch, as well as net & net-next.
This version has already been rebased to TOT of linux-next.
https://lore.kernel.org/all/20250118080939.2835687-1-dualli@chromium.org/

The 15th version switches from unicast to multicast per feedback and
feature requriements from binder users. With this change, multiple user
space processes can listen to the binder reports from the kernel driver
at the same time. To receive the multicast messages, those user space
processs should query the mcast group id and join the mcast group. In
the previous unicast solution, a portid is saved in the kernel driver to
prevent unauthorized process to send commands to the kernel driver. In
this multicast solution, this is replaced by a new "setup_report"
permission in the "binder" class. Meanwhile, the sock_priv_destroy
callback and CAP_NET_ADMIN restriction are no longer required in favor
of the multicast solution and the new "setup_report" permission.
https://lore.kernel.org/all/20250226192047.734627-1-dualli@chromium.org/

The 16th version fixes the build error when CONFIG_SECURITY is disabled.
There's no other changes. Thank you, kernel test robot <lkp@intel.com>!
https://lore.kernel.org/all/20250303200212.3294679-1-dualli@chromium.org/

The 17th version corrects the issue in binder_find_proc() that multiple
binder_proc instances might match the same pid. It also simplifies the
parameters of binder_netlink_report(). This patchset also includes a
patch to SELinuxProject/refpolicy for the new permission and another
patch to SELinuxProject/selinux-testsuite to test this new permission.

v1: add a global binder genl socket for all contexts
v2: change to per-context binder genl for security reason
    replace the new ioctl with a netlink command
    add corresponding doc Documentation/admin-guide/binder_genl.rst
    add user space test code in AOSP
v3: use YNL spec (./tools/net/ynl/ynl-regen.sh)
    fix documentation index
v4: change the subject of the patch and remove unsed #if 0
v5: improve the kernel doc and the init function
    remove unsupported uapi-header in YAML
v6: fix some trivial kernel doc issues
v7: break the binary struct binder_report into individual attributes
v8: use multiplex netlink message in a unified netlink family
    improve the YAML spec to be consistent with netlink tradition
v9: remove unnecessary check to netlink flags and message payloads
v10: improve the readability of kernel doc and variable names
v11: rename binder_netlinnk.yaml to binder.yaml
     use reverse xmas tree for function variables
v12: make kernel doc aligned with source code
v13: use sock_priv_destroy to cleanup netlink
     require CAP_NET_ADMIN to send netlink commands
     add trampolines in ynl-gen to fix CFI failure
v14: wrap the sock priv in a separate struct
v15: switch from unicast to multicast netlink message
     add a "setup_report" permission in the "binder" class
     add generic_netlink to binder_features
v16: fix build error with CONFIG_SECURITY disabled
v17: deal with multiple binder_proc with the same pid
     simplify parameters of binder_netlink_report()
     add test for the new permission binder:setup_report

Li Li (2):
  binder: report txn errors via generic netlink
  binder: transaction report binder_features flag

Thiébaud Weksteen (1):
  lsm, selinux: Add setup_report permission to binder

 Documentation/admin-guide/binder_netlink.rst  | 108 +++++++++
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/netlink/specs/binder.yaml       | 116 ++++++++++
 drivers/android/Kconfig                       |   1 +
 drivers/android/Makefile                      |   2 +-
 drivers/android/binder.c                      | 215 +++++++++++++++++-
 drivers/android/binder_internal.h             |  16 ++
 drivers/android/binder_netlink.c              |  46 ++++
 drivers/android/binder_netlink.h              |  23 ++
 drivers/android/binder_trace.h                |  35 +++
 drivers/android/binderfs.c                    |   8 +
 include/linux/lsm_hook_defs.h                 |   1 +
 include/linux/security.h                      |   6 +
 include/uapi/linux/android/binder_netlink.h   |  57 +++++
 security/security.c                           |  13 ++
 security/selinux/hooks.c                      |   7 +
 security/selinux/include/classmap.h           |   3 +-
 .../filesystems/binderfs/binderfs_test.c      |   1 +
 18 files changed, 653 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_netlink.rst
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h


base-commit: 5b37f7bfff3b1582c34be8fb23968b226db71ebd
-- 
2.49.0.604.gff1f9ca942-goog

