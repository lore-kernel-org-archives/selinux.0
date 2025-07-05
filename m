Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C02E371C
	for <selinux@vger.kernel.org>; Sat,  5 Jul 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751717679; cv=none; b=O8OQjsB35X8/FaChc/ixOJ0P1QeI5Q9Q6g8klz9J2M9tKtvcPmF2d83NBzSBvaBjClFFIy6zJaw73EBOnyJaW5/gKtuA6jj/EPAHwwe0BVNNY1GDu5+3gAeiqJDF9HREMyo21FraTHRgRbm974xVhHXvtwIEU+C6wbRaiI7DRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751717679; c=relaxed/simple;
	bh=CEFbys7PL7bFDDz2VLCaqT4uhLsEevdHiSuaSmbzIdY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEhU44hfryhObanhYTxEk/snOOewVnYCI7jkUf9rOIbndZ1LIxt8lqi+QFKBn9zmIP7VQ1fECEsXSXNkYZAVZVdMBKapm1qkQzmvhDkLinzr2DouK1D+GL6cIGYaDME9M7SKB69aG7/rsxMpkcnQXl3MMyiOVIOBr7Y+jxCSSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJI+LzkN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJI+LzkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751717676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hw2iezv6tphPGIw7oEchqj5bRMQcnFP68A+qrS6b8dM=;
	b=dJI+LzkNnYWfH94Ek2khl6BDdiJ8+rzsgiA2S0Sfe4AbsaV2zErklFP4NmINWUuXrbyd1/
	Nd4Id2sncR46K/eZU3wEwp1VKHBRHLY6fIreFjxfjQysb8Z/36YN4WJCT9edvzz86rck9O
	Cwid/2CdiuM1kNL6Vi5qsza8tlRQf70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-GTHIWz1NN--H-NO2taoD0A-1; Sat, 05 Jul 2025 08:14:35 -0400
X-MC-Unique: GTHIWz1NN--H-NO2taoD0A-1
X-Mimecast-MFC-AGG-ID: GTHIWz1NN--H-NO2taoD0A_1751717674
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704cdbso12014685e9.1
        for <selinux@vger.kernel.org>; Sat, 05 Jul 2025 05:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751717674; x=1752322474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hw2iezv6tphPGIw7oEchqj5bRMQcnFP68A+qrS6b8dM=;
        b=qui4VY4qEwF1SSUtU/L49njjyHkEAK1HPi5XUZjR2NHDgW53CVitLvyJQln9O+BEgq
         0x4FJ5kOTMU8/qcw+gBpdiIUmAXXgpO4U3iKnzkHFCm2LJoToSRb+lFCTG3ZDLHvicrV
         5DngQjs9Si0kog9XWDiwwnHx8XDV78mKlSuUXMfs5P9l1absueJcQK1+Qqm9avAVdLr0
         RA0grUf1eX8HqjHN93Vpjwy6dfvrauhHtdAqRIvqktFgrL6+oLI7J0aRHan1fn63iWF0
         wJ8V5S8NeXAFB6qx0YTgUAccjK9RNGFO3qET/bFrSS23AjSg3hlE3ifszgmOUxgMPB2x
         L37w==
X-Gm-Message-State: AOJu0YyO+0hEXfcL4+sSSlb3/CIXlkUIHLpowmOxgVsVj9pUS0WXnGgw
	Pv1yLrho5FTr2suf+swxn3QF0Ocs6Z5gdeAOgNg9gB7OxGSsSb86xLH+qfTETdw05rxeLWMAxEU
	yTQzPyiEHEiVtijR3nXrx5L8AJjunddZWEH03h5RLNt0VM8yGMviMO1jK4kUWMvzrp2bBGTTTrH
	jusqQv+TeHnD8uhmOWfJay+6S/qoN5TccodoBzDoTbyFo=
X-Gm-Gg: ASbGncvqgDQpZq+eQT7C1fBohONlG0aaVFRsZAjLKwLi7P5Y/EQbaOKOC11MpC+e8eO
	5dvOzGvnvhNvt8cbdvXnFgnpqVbX5B2KcRxudaRVunk/6OvauG2Y939BbN7j7hEvW9qyu5gnqCt
	2mF7ZT173azAeV5YzNJCj1kVrjkKLqjplkubPL+wwTKqurTbeqcLIuOpB2qoDFan+o7zSRdGIwb
	PhjKHtOobnpzxcAL+dqPWBZvlLRti8nsnMR6cP1+bQEUZwmxutBI94l6Od0dFVp1F5AxPCiPqLw
	tqAD4cTz3tqMC99vHw==
X-Received: by 2002:adf:e19b:0:b0:3a4:cb4f:ac2a with SMTP id ffacd0b85a97d-3b4970110d9mr3868106f8f.21.1751717673669;
        Sat, 05 Jul 2025 05:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqjbWCFLDnvdElg/67hH/x/qKq1lrA9ApsGolYj6mASxJ1+04zQ3vXJMSgE08eoM1TML9YpA==
X-Received: by 2002:adf:e19b:0:b0:3a4:cb4f:ac2a with SMTP id ffacd0b85a97d-3b4970110d9mr3868093f8f.21.1751717673129;
        Sat, 05 Jul 2025 05:14:33 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47040161bsm4863832f8f.4.2025.07.05.05.14.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 05:14:32 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 6/6] tmt: add some missing permissions to policy before running the tests
Date: Sat,  5 Jul 2025 14:14:24 +0200
Message-ID: <20250705121424.1221268-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250705121424.1221268-1-omosnace@redhat.com>
References: <20250705121424.1221268-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable test coverage for permissions that haven't been added to the
distro SELinux policy yet, we may want to temporarily add these
permissions to the policy. Since these new permissions will often only
be present in new kernel code, let's do this only when testing the
secnext kernel.

The permissions added are the file loading permissions (extending
module_load coverage) and the nlmsg permission (enabling the nlmsg
test).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tmt/tests.fmf | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index c9f5ff4..64c7c40 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -37,6 +37,29 @@
           --nogpgcheck --releasever rawhide \
           --repofrompath 'kernel-secnext,https://repo.paul-moore.com/rawhide/$basearch' \
           kernel-modules-*.secnext.* kernel-devel-*.secnext.*
+
+        # add classes/permissions currently not supported in Fedora
+        semodule -c -E base
+        sed -i \
+          -e 's/\((class system (ipc_info syslog_read syslog_mod syslog_console module_request module_load \)\(halt reboot status start stop enable disable reload undefined ))\)/\1firmware_load kexec_image_load kexec_initramfs_load policy_load x509_certificate_load \2/' \
+          -e 's/\((class netlink_[a-z0-9_]*_socket (\)\(nlmsg_read \)/\1nlmsg \2/' \
+          base.cil
+        echo "(policycap netlink_xperm)" >>base.cil
+        # allow nlmsg to some system domains so that the system can boot
+        for source in daemon initrc_domain systemprocess unconfined_domain_type sysadm_t; do
+          echo "(allow $source self (netlink_route_socket (nlmsg)))" >>base.cil
+          echo "(allow $source self (netlink_firewall_socket (nlmsg)))" >>base.cil
+          echo "(allow $source self (netlink_tcpdiag_socket (nlmsg)))" >>base.cil
+          echo "(allow $source self (netlink_xfrm_socket (nlmsg)))" >>base.cil
+          echo "(allow $source self (netlink_audit_socket (nlmsg)))" >>base.cil
+          echo "(allow $source self (netlink_ip6fw_socket (nlmsg)))" >>base.cil
+        done
+        semodule -X 456 -i base.cil
+        rm -f base.cil
+        sed -i.orig \
+          -e 's/module_load /module_load firmware_load kexec_image_load kexec_initramfs_load policy_load x509_certificate_load /' \
+          -e 's/nlmsg_read /nlmsg nlmsg_read /' \
+          /usr/share/selinux/devel/include/support/all_perms.spt
         ;;
       local)
         # for a non-rpm directly-installed kernel - assume all necessary files
@@ -100,6 +123,7 @@
     - jfsutils
     - dosfstools
     - rdma-core-devel
+    - kexec-tools
   /main:
     summary: Run the testsuite
     duration: 20m
@@ -139,3 +163,7 @@
       semanage boolean --modify --off ssh_sysadm_login
       semanage login --modify -s unconfined_u root
     fi
+    if [ "$STS_KERNEL" = secnext ]; then
+      semodule -X 456 -r base
+      env -C /usr/share/selinux/devel/include/support mv all_perms.spt.orig all_perms.spt
+    fi
-- 
2.50.0

