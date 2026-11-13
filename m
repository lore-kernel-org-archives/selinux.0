Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576503;
	b=HtT14n0fN/lOuY+U5nwZ8awUnVX89VKcmLSl/QvybLb3el+AeAIsNrEQW3DbU93xdvJx
	 wWnnyhITzz3jSw1i7B+Kn4Wt1PHRD8oiiYn2L58kXMneEPBTL2h1jcFRg8V8S+UpEqrd4
	 p6r9AM+fwwz7InHV20rQTcCeyWcqmMDkFkIEXcTs37GMN5KXJjceW6V3icROFUXdR0Kb9
	 HsxpVicL2S0xsON73JV4EAKU5p69hLwUjk98IdqXpnG879C/eesBH3+sXQz6igrkkX4Df
	 6TQGUBcoaxKTtT43dNZJk/X3eepGxUnowLZNqh6FSTQ+FFU9Q59v3bze5Pu6k19tnlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=923IjLrQvhzDJobqTJKJyPQy8Gc4TGCSthQw+Lj8C9g=;
	b=pcPG428meFE58VkKCHLZk3H5R/qxVrMePOp0Lk7SBDG+YMtc2sV3sTmy0hIeDWHpF3sv
	 HMANtut0HNLRjS+a+0VAGSFyg0MKev8hxaeWPEwG4p80YkbRs7kEMjIDKkxILEgBCwJk6
	 YIgK586peeGQfCcenevbLqhIEw9GtRollK0C1+jsw3rFHpyl6xXevQgDqJV1P+Q+6MMF0
	 49gNTK5svi7M1LLqD00C8cjG3B0R+pgFXzvKd/zy84/2BcPM6KlcRIMI7TapwNH+aT0/k
	 BdgJQKUYnjiKHefIGIWC4l+4lqVCwk0hgTDMIhhCJG3ZimoB+/oZI1EN/hYwbi68ipQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQ88moT8;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28C606B55E
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 13:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A28C606B55E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQ88moT8
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e55db58cfso161231285a.1
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576502; x=1795181302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=923IjLrQvhzDJobqTJKJyPQy8Gc4TGCSthQw+Lj8C9g=;
        b=FQ88moT8wVeMlwXUUqQKHsYyrOjBt3SfAqJWscdeC7u6ZWQEsUM4PcEwAw+5xstcpT
         r1TlJ5OMCtnIgkj2EBMkEBEs2fU4Dvrt6PGgb7Zp9b5hkycN6vXADuigvPrJZIn2kkAP
         ZweycgiMevEK3/4r3xNBOfcyVQMNCelcI701QKVIr5w1G/Q1WO3kKXTjvLPybUGlGVhO
         r/ogUqJXTy1q/UZEJ8wI1IyZ/Xa+fheM5fbXO2s5J4vWaB27bfwazhD7IOJ5yw/GxsR3
         beenozxfRtyo485dOTjXOWUElSdEvB7uvsSeZAf4HW9UESWwYdlkxLcqhf29CFVy19YX
         ICzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576502; x=1795181302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=923IjLrQvhzDJobqTJKJyPQy8Gc4TGCSthQw+Lj8C9g=;
        b=AmkysjaFu8RTvS4Ddd2/swjhfGecHEuS2fZsYheVj91Ae+N07PMJP+CQ7deDcdJXn/
         TMnQjEJtbENyPEaQW9bd31DV3QBcQ23A/S/HsUfWqWOg33aocfGkdsEiaVma31jPJZNB
         x2jMvRb62nSQH9Y29cCJ+XFJk8klftwgt0Rarwxnb9SzwmSTJWYjtyiPVarOSOmNcxvO
         a4kFN98g1G8FORM3VauQpgbVWIv0/9+N8n9hlwYmEQXFs8+rBYbH1WMfN44R2h8oSAh7
         +VrwVPR8fBg4E1V5r63oTAgFXPgxe612AnnPEpl6foM/BBpCOthA0/Fg8jvw4TLYWRYB
         IO+g==
X-Gm-Message-State: APuU4Z97nhWBtd0dxuizu8vi2xT60GcnL2C+R2UM0Ob3qiln6ZGbE+7/
	+2AIpPsVfuMI1F8WhsFWa8HnRGYfL0N6T8V4GY3PBqTq97qv6olZ5BYU7LkANSXp
X-Gm-Gg: AYBFou3/ec136WazxJktsgwVYp42Q1NLTmfSXYoxImKyNjRtbxlBM2hXaS3yOOfqbYd
	UTiCl0baMztmOfpZYzUAs0Em3K9npQ7EsJ/6Ry6Vr4R4NEpk9GYrIjpUMazWTeMCGJkEuWlRARi
	E5jrtLnVWmTUx9Ycde1Xm1riLLw7lKpKJoHunD3dm7QmONKOr405I2BPHDRX/WCETlEYYFXONUL
	epSQolNoEH3BC0sz8Slmkx+ACX7dXxeW3ouWpiPTlfXtbr+k5cXFVR1XqJjeHsjuQaHeIfx2231
	9CvCy5qa8eGCmyWmJwQdqlCs4dPqzB+zIVaQwqcPbGEplX5n8J2K3jXiqnw45BHMkfvYX3kz/rk
	tCiadtVs+KzEQhCCuZzVT6pJiHVDRaY1gHoesDdx4xUaxT0hcpiLJ2B1VxinBXx3sGBLevfbTKU
	WnNAPbyeGnVgzDhxnc/z2luSFspEuFVz/okdUoC73H1Xw2ygAQDPJRCfTr0vri119zpeiMNTNhp
	FjBvkmqPUyhmEkxit3Q3r5S9TJDdlnPB19u/wVo4wl945l/GMe6sdopzcaApmM58/HryYE+L3YI
	PN9NawsFfwuJJdH2RahLzV7kF5qO0KjQlOrbcT7MHAiNvBhsUr5iga2aK4uO1GB/HxWgPtAc2eu
	kIOfeG/jOOaUISO2VxSKTj5s9DZkDiqwWh4t/Bo+tSee8N1YE656CS3+WTSUwwBdXM065klC80/
	nSLrY0NUh3M0SgzzWQJMR9MRhVu6+e35ZXI1lyp/YthGT10ZgiMfk=
X-Received: by 2002:a05:620a:458a:b0:93e:ee21:70ec with SMTP id af79cd13be357-9494bd1c166mr406655585a.80.1794576501902;
        Fri, 13 Nov 2026 05:28:21 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c831b7dsm182669585a.20.2026.11.13.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:28:21 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [RFC PATCH] projects/selinux: enroll the SELinux userspace project
Date: Fri, 13 Nov 2026 08:24:19 -0500
Message-ID: <20261113132417.87823-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a RFC patch to enroll selinux in
https://github.com/anthropics/oss-scanner

See also https://red.anthropic.com/oss-scanner/

Note that instead of adding the Dockerfile and .md files to
oss-scanner, we could instead add them under a new .oss-scanner
directory in the selinux repo and then just point to those from the
oss-scanner project.yaml file.

Enroll the SELinux userspace project in oss-scanner similar to how we
are already enrolled in the oss-fuzz project. I may later migrate the
Dockerfile and .md files to our repo and point to them from
project.yaml to ease future updates but this seems reasonable for now.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
cc: Paul Moore <paul@paul-moore.com>
---
 projects/selinux/Dockerfile           |  35 ++++++++
 projects/selinux/patch_guidelines.md  |  13 +++
 projects/selinux/project.yaml         |  15 ++++
 projects/selinux/report_guidelines.md |  10 +++
 projects/selinux/threat_model.md      | 124 ++++++++++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 projects/selinux/Dockerfile
 create mode 100644 projects/selinux/patch_guidelines.md
 create mode 100644 projects/selinux/project.yaml
 create mode 100644 projects/selinux/report_guidelines.md
 create mode 100644 projects/selinux/threat_model.md

diff --git a/projects/selinux/Dockerfile b/projects/selinux/Dockerfile
new file mode 100644
index 0000000..ce909fd
--- /dev/null
+++ b/projects/selinux/Dockerfile
@@ -0,0 +1,35 @@
+FROM ubuntu:latest
+ENV DEBIAN_FRONTEND=noninteractive
+RUN apt-get update && apt-get install -y --no-install-recommends \
+      ca-certificates build-essential pkg-config git python3 \
+	bison \
+	flex \
+	gawk \
+	gcc \
+	gettext \
+	libaudit-dev \
+	libbz2-dev \
+	libcap-dev \
+	libcap-ng-dev \
+	libcunit1-dev \
+	libdbus-glib-1-dev \
+	libpcre2-dev \
+	ruby-dev \
+	swig \
+	xmlto \
+	python3-build \
+	python3-dev \
+	python3-pip \
+	python3-setuptools \
+	python3-wheel \
+	swig \
+	&& rm -rf /var/lib/apt/lists/*
+
+# scanner contract: the checkout lives inside the image, at /src
+COPY . /src
+WORKDIR /src
+
+RUN make -k DEBUG=1 DESTDIR=/src/build install install-pywrap
+
+# Smoke-test
+RUN make -k DESTDIR=/src/build -C libsepol test
diff --git a/projects/selinux/patch_guidelines.md b/projects/selinux/patch_guidelines.md
new file mode 100644
index 0000000..7688835
--- /dev/null
+++ b/projects/selinux/patch_guidelines.md
@@ -0,0 +1,13 @@
+# How we would like patches made
+
+## Size and scope of a fix
+as narrow as possible: change only the faulty function, no refactoring
+
+## Code style
+format with the .clang-format at the root
+
+## Tests
+add a regression test in a new file under the per-component tests/
+
+## Branch and commit message
+against the main branch; subject line in the form 'component: what changed'"
diff --git a/projects/selinux/project.yaml b/projects/selinux/project.yaml
new file mode 100644
index 0000000..9dbc5bb
--- /dev/null
+++ b/projects/selinux/project.yaml
@@ -0,0 +1,15 @@
+repo: https://github.com/selinuxproject/selinux
+primary_contact: stephen.smalley.work@gmail.com
+auto_ccs:
+  - omosnacek@gmail.com
+  - jwcart2@gmail.com
+  - cgzones@googlemail.com
+  - paul@paul-moore.com
+  - jason@perfinion.com
+  - plautrba@redhat.com
+
+output_format:
+  email:
+    min_severity: low
+  github_security_advisory:
+    min_severity: medium
diff --git a/projects/selinux/report_guidelines.md b/projects/selinux/report_guidelines.md
new file mode 100644
index 0000000..c4469ba
--- /dev/null
+++ b/projects/selinux/report_guidelines.md
@@ -0,0 +1,10 @@
+# How we would like reports written
+
+## Layout and length
+under one page, with these sections in this order: Summary, Affected versions, Reproduction, Suggested fix
+
+## What every report should state
+the affected versions and configuration, the attacker's starting position, and the public API that reaches the faulty code
+
+## Style
+plain text, no Markdown tables; one root cause per report; start the title with the component's name
diff --git a/projects/selinux/threat_model.md b/projects/selinux/threat_model.md
new file mode 100644
index 0000000..bbf074f
--- /dev/null
+++ b/projects/selinux/threat_model.md
@@ -0,0 +1,124 @@
+# Threat model
+
+## What this project does and where untrusted input enters
+
+selinux provides the core SELinux userspace libraries, daemons, and
+tools. It also includes some optional SELinux userspace daemons and
+tools that are not installed by default. Applications use libsepol to
+generate and read SELinux policy files, libsemanage to perform policy
+management tasks, and libselinux to look up access and labeling
+decisions, interact with the SELinux daemons, and invoke the
+SELinux-specific kernel APIs (/proc/pid/attr/*, /sys/fs/selinux/*, and
+the [l][f][gs]etxattr(2) system calls with the security.selinux xattr
+name).
+
+libsepol parses and validates binary and CIL source policy files and
+memory buffers, but any bug that requires attacker-controlled policy
+is handled as a regular bug, not as a security bug (i.e. no security
+advisory). checkpolicy and checkmodule parse and validate source
+policy files, but any bug that requires attacker-controlled source
+policy is likewise handled as a regular bug, not a security bug.  The
+libsepol API is not a trust boundary. The checkpolicy and checkmodule
+interfaces are not a trust boundary. Similarly, the semodule-utils
+programs operate on binary policy modules but their interfaces are not
+a trust boundary.
+
+All root-owned configuration files used by the SELinux userspace are
+considered to be trusted. Any bug that requires attacker-controlled
+root-owned configuration is handled as a regular bug, not a security
+bug.
+
+libsemanage parses and validates many different configuration files,
+but the caveat above regarding root-owned configuration files holds.
+The libsemanage API is not a trust boundary. The semodule, semanage,
+and setsebool program interfaces are not trust boundaries.
+
+The kernel interfaces are considered to be trusted by all of the
+SELinux userspace. Reading from the /proc/pid/attr/* interfaces will
+always return an attribute (context) value canonicalized against the
+policy by the kernel. Similarly, reading from any of the
+/sys/fs/selinux/* interfaces will always return a canonicalized value
+against the policy or the set of valid values for a given interface
+(e.g. 0 or 1 for enforce). In the case of the security.selinux xattrs
+returned by getxattr(2) and similar system calls, the underlying xattr
+value may originate from an untrusted filesystem in some cases,
+although these xattr values will only be used and returned by the
+kernel if the policy specifies the fs_use_xattr behavior for the
+filesystem type and the mounter did not specify a SELinux context=
+mount option at mount time to override it. Otherwise, the kernel will
+assign a default value from policy or use the value specified via the
+context= mount option and will always return this trusted value on
+getxattr(2) calls. Even when the kernel uses the filesystem-provided
+xattr values, it canonicalizes them against the policy before
+returning them to userspace unless the process has the CAP_MAC_ADMIN
+capability and has the SELinux mac_admin permission in the policy;
+such processes are considered to be trusted with respect to handling
+raw attribute values.
+
+Despite the items noted above as being trusted or not being trust
+boundaries, please report and fix bugs in parsing and processing
+inputs, but there is no need to open a security advisory for these.
+
+The sandbox/seunshare utility considers all of its caller-supplied
+inputs and environment to be untrusted and considers anything it runs
+within the sandboxed process to be untrusted.
+
+restorecond considers its configurations to be trusted but not the
+file trees it walks. Note that walking of user home directories is
+done by a separate per-user restorecond instance.
+
+mcstrans considers its clients to be untrusted but is known to be
+subject to denial of service attacks. Fixes for such denial of service
+attacks will be accepted but not treated as security bugs.
+
+## Components that matter most / least
+
+Start with sandbox/seunshare, restorecond, and mcstrans (in that
+order) since they often run as root or with Linux capabilities and
+deal with untrusted inputs. These are however all optional components
+in Linux and unused by Android.
+
+Next prioritize libselinux since it is the most widely linked library
+across both Linux and Android userspace.
+
+Next prioritize libsepol, checkpolicy, and secilc since they are used
+by both Linux and Android, but remember that bugs that depend on
+attacker-controlled policy are handled as regular bugs, not security
+bugs.
+
+Next prioritize libsemanage, followed by policycoreutils and python/*,
+since they are widely used by Linux but not by Android.
+
+Next review dbus and gui; while these often run as root or with Linux
+capabilities, they are optional components, rarely used, and gated by
+polkit or invoked by privileged authorized users.
+
+Last review any remaining components e.g. semodule-utils.
+
+## How to exercise it
+
+.github/actions/build-userspace/action.yml is the GitHub action for
+building the code, and .github/workflows/run_tests.yml is the workflow
+for running the tests. The TL;DR version is 'make DESTDIR=/src/build test'.
+
+FUZZING.md contains instructions for fuzzing selected components;
+oss-fuzz is used to regularly run the fuzzers.
+
+## How you rate severity
+
+Anything that depends on attacker-controlled policy is low.
+
+All DoS is low.
+
+For memory-safety findings, provide a reproducer using a public API
+where possible. Separate observed corruption or undefined behavior
+from any claim of code execution; explain attacker control and
+required features. Describe realistic impact.
+
+## Anything to leave alone
+
+The policy compilers (checkpolicy, checkmodule, and secilc) will
+consume resources in accordance with the size and complexity of the
+policies they are compiling. Small memory leaks on fatal error paths
+during policy compilation are not of interest because the policy
+compiler will exit shortly thereafter.
-- 
2.56.0

