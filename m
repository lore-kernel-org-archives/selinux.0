Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580429;
	b=1KZS3lZaJZeI+Lsk85vp/uHsCK6YSnkySGh7S4kEA1NKBwctuZUpexzTrSd54DzfHH6x
	 gUfyvMIDcmOmU+4MRcAA2NT24S18Oodrsju6B2I2cWLdRIe2vXQ6yINC14eI9nudj11Ty
	 hqxPW1S8zhq/QlFrx3r3BnNnSqiYxIjXaF1jd5dJbPoOBkk7LyPIDzmiVuGLpwjI6Flk5
	 OjrQeJaQ1/TGEyBDYIvaRXALFVy9Ndrd3qQnLOiwofV8xznQXLQhOye1gFLRqhe6H4ec3
	 94bGldKFUEfyT8chFV/tYGG7F6XhjLtcSU2kciaxhWwc2bkM+qx8vBCT0acy3mx+PMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UfSLn8dGDJ3HOLEDI7lNdlvZGJlQdMOffPqu+nQz/+E=;
	b=EesItL/9G8Kx2LsnkFv00sKpzsGXVOwuGVBxD0USG0C6uxgCiYGCVSr7B8lq7+ygZNZP
	 cjV2W+6eAKf3mYNcPCy/bjuQw2hGQgTJtI3BFzBChrF199bVj4nQAhHLBoMs70WBjSLwS
	 RwYQUdbsvkqz8gDs5H1voEBWIOsbOiPd03Gu0dPg/f5itX3mwExZbJTWXCg8Mlc9MtuaV
	 1Qp8KF5RK07Vg0rbdV9UD5/h+767BY5oBSHL/fQu6lAGVvXdOuuD1goD1k3pEkjEvbUU/
	 IdmyunEbLfvxs9R/bn4RbImzOzscaj+wj6l5WSqsd0cv3uWqDSVTWd3rQlnFXoPQuWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZzMr8jW;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F060A5BC0
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 14:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E2F060A5BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZzMr8jW
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9495d543c42so47835085a.3
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794580427; x=1795185227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfSLn8dGDJ3HOLEDI7lNdlvZGJlQdMOffPqu+nQz/+E=;
        b=oZzMr8jW2avzzMYjulNCxcDpW90F3Y6SfF8MdbUFcOVEQMNiorDlwr/C8AUTxmFaZp
         NFZ4WN+oNI7uHEI7u6dGfU6SNxJnud5hdtnQy8Ez4fxSEP0DAo63HzmrjfpFrCkLIMMK
         Ji/BJpWHUERMFGP/xAQHM/eE+gg52y5Ahp7fGLvSZrZ+0fkv8sEKRvWIOiDSG2MB4p5W
         NjVA5lCYCYaTLOVoGZiRQFMdSEPqhW7cdshjrNdINg+fbos7t4YJQjb/7r1wxjGy/fBl
         dm6c1uMyBJXzy9tgIYVy9MKJbw4+IfWvB+a1s+Q/QpkMuoqR18/29w5ncf2Z1arTVWo+
         ZC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580427; x=1795185227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfSLn8dGDJ3HOLEDI7lNdlvZGJlQdMOffPqu+nQz/+E=;
        b=yF1PHDYeiJx+oBuFfuzoFIJ3KOjUOB73rdESRAQiuvYyvPqiLBYngAyvOo7n+Shc/I
         ++iKmmtrX45h8FhvzPs3PZ9U9KxbnqGIKya9bC5FhgLI+735y896caUQX6CA3z15TkaC
         Zlg9kJqbH/JWGCJ6ImYPDII9U51P9PhgAMk0tgQ8+5SfGACswZTxGrIhdkAA1KWz4maT
         ualuXm8lUzgbvTAYc18hNrwkfNOwRcjIPRshpp7MZS3hPpadhkNEJOapNqzMh/YSJEOZ
         QUlsQ/r66m88ysvQreNtT+yEZFT1vIhEEmNTe/xFOslhVl8M/DznLSnjckLrVv7ViqSo
         Fi1A==
X-Gm-Message-State: APuU4Z/32ll7X6WHr8da5gQUv6YbELNCAgQEwUbp1YdDnXEB6j1P7mxW
	siUoGbP+uLSTjafBIlDpWOHAIQsHY8bkCDp+Ho6k0Cwj4TiE8mk8TxvNjaxIstoQ
X-Gm-Gg: AYBFou2hsa3XOHIjwlZfgBx4KVSaohMxSbCj0ASvR/y3N7l4MncCX6DqJ5gTJ8NaQ83
	ODCdy6WFhPCSsD/CcQTK0Alo1AAbbl7oKe0j2ZKD3s//Gi1iyK1u+RPMEmC2uvykHOWspq3Nftz
	4qvs8j5kZ5pIL+n36+JnTWhXz0yBAV/N9nMz8FWyCAtk7eA1iyRCkzvZwMnIDAAOaVsAUWwojA2
	SJIrlzLQ7oDM9b1ZunYRK1CjCVobPasXDcEcTsbHJ1s6H1QtU6qqKVWYlsDy2F9BnUVloEk88IM
	kdOqZucDN7OpiYEK1MO9adBmyjyFB7p9JI98Q+FVZ59Rblah9GCoDJsDGRvQH+JM6M8y7DBzTv3
	J8WJrlFMtyo5UFSNI0TlDH9WNj9KO7oCOxN+3ziIuPid5q6Dm9qdHJxsamsedKGvZ1kWMtrZmch
	D+ijUPPcmHf3L7xTrKfEXD8b1QD1EbDU7Yzc/dI2ZHYN+mxV1rLNELQQy5EeVHFO+GAk06YToVD
	aZ7jRqWVSQzVZWr0cPzPcOmaYWRkk2+Zf93OGvRbXKDdrQTsdKm84wUrB3tlN0STRUIem/hTsVc
	NoNSqUp/165TT6OgI6pBGVS5mZ+dvTHbh1WEM173HjN66loSMyoCiWI8BdWYYE0mzpUdSaQGIKB
	5DiBBmcxCp9G8u9iPhj2PtVeXqUxmYvMmUyWK3dkLVxdcVD3+fMrFMeMufo3x9v/fCIO4ncz6qu
	CEoVasTQaOnld+nHLc2vV3sXDcEy9W8i4ditKewyZvh+EjUmk90Ic=
X-Received: by 2002:a05:620a:439e:b0:93f:1936:b206 with SMTP id af79cd13be357-9494bc1f675mr393294285a.83.1794580427428;
        Fri, 13 Nov 2026 06:33:47 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8f9576sm196432485a.42.2026.11.13.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:33:47 -0800 (PST)
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
	paul@paul-moore.com,
	cgzones@googlemail.com
Subject: [PATCH v3] projects/selinux: enroll the SELinux userspace project
Date: Fri, 13 Nov 2026 09:31:26 -0500
Message-ID: <20261113143126.103018-2-stephen.smalley.work@gmail.com>
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

Enroll the SELinux userspace project in oss-scanner similar to how we
are already enrolled in the oss-fuzz project. I may later migrate the
Dockerfile and .md files to our repo and point to them from
project.yaml to ease future updates but this seems reasonable for now.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
cc: <paul@paul-moore.com>
cc: <omosnacek@gmail.com>
cc: <jwcart2@gmail.com>
cc: <cgzones@googlemail.com>
cc: <jason@perfinion.com>
cc: <plautrba@redhat.com>
---
v3 adds newrole build dependencies and flags and updates
patch_guidelines.md per the sashiko review.

 projects/selinux/Dockerfile           |  36 +++++++
 projects/selinux/patch_guidelines.md  |  13 +++
 projects/selinux/project.yaml         |  15 +++
 projects/selinux/report_guidelines.md |  10 ++
 projects/selinux/threat_model.md      | 133 ++++++++++++++++++++++++++
 5 files changed, 207 insertions(+)
 create mode 100644 projects/selinux/Dockerfile
 create mode 100644 projects/selinux/patch_guidelines.md
 create mode 100644 projects/selinux/project.yaml
 create mode 100644 projects/selinux/report_guidelines.md
 create mode 100644 projects/selinux/threat_model.md

diff --git a/projects/selinux/Dockerfile b/projects/selinux/Dockerfile
new file mode 100644
index 0000000..b81a35e
--- /dev/null
+++ b/projects/selinux/Dockerfile
@@ -0,0 +1,36 @@
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
+	libpam0g-dev \
+	libpam-modules \
+	ruby-dev \
+	swig \
+	xmlto \
+	python3-build \
+	python3-dev \
+	python3-pip \
+	python3-setuptools \
+	python3-wheel \
+	&& rm -rf /var/lib/apt/lists/*
+
+# scanner contract: the checkout lives inside the image, at /src
+COPY . /src
+WORKDIR /src
+
+RUN make -k DEBUG=1 LSPP_PRIV=y DESTDIR=/src/build install install-pywrap
+
+# Smoke-test
+RUN make -k DESTDIR=/src/build -C libsepol test
diff --git a/projects/selinux/patch_guidelines.md b/projects/selinux/patch_guidelines.md
new file mode 100644
index 0000000..3a16e30
--- /dev/null
+++ b/projects/selinux/patch_guidelines.md
@@ -0,0 +1,13 @@
+# How we would like patches made
+
+## Size and scope of a fix
+as narrow as possible: change only the faulty function, no refactoring
+
+## Code style
+format with the .clang-format in /src
+
+## Tests
+add a regression test in a new file under the per-component tests/ for those that have one, or create one for those that do not
+
+## Branch and commit message
+against the main branch; subject line in the form 'component: what changed'; include a Signed-off-by: line per the DCO; see /src/CONTRIBUTING.md
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
index 0000000..f049921
--- /dev/null
+++ b/projects/selinux/threat_model.md
@@ -0,0 +1,133 @@
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
+Depending on build configuration (any of AUDIT_LOG_PRIV=y,
+NAMESPACE_PRIV=y, LSPP_PRIV=y), the newrole utility may run with
+greater privileges than its caller and therefore considers all of its
+caller-supplied inputs and environment to be untrusted and considers
+the shell or command it launches in the new role to be untrusted.
+
+The sandbox/seunshare utility considers all of its caller-supplied
+inputs and environment to be untrusted and considers anything it runs
+within the sandboxed process to be untrusted.
+
+restorecond considers its environment, arguments, and configurations
+to be trusted but not the file trees it walks. Note that walking of
+user home directories is done by a separate per-user restorecond
+instance.
+
+mcstrans considers its environment, arguments, and configurations to
+be trusted. mcstrans considers its clients to be untrusted but is
+known to be subject to denial of service attacks. Fixes for such
+denial of service attacks will be accepted but not treated as security
+bugs.
+
+## Components that matter most / least
+
+Start with policycoreutils/newrole, sandbox/seunshare, restorecond,
+and mcstrans (in that order) since they often run as root or with
+Linux capabilities and deal with untrusted inputs. These are however
+all optional components in Linux and unused by Android.
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

