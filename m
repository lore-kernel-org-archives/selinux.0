Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578636;
	b=eRS7AqD2JJRerqdLsJzBfrvmxVH1w9RWBkjFfEY/tAh+SqPaDXqi9h5aSMKARWH9C1kC
	 2KQ0CpZ8t6KQ2O9JwcXv3VBLWbp1dszmfP5LKhHZWIs9arHZD2rtJdvGD8khx4Wdq5oZn
	 HHW8qgLBgIWjBK80tntZOVb6CYofgGosinhqVSl4stCEPuffr14QMcv0Bdbkb/zQWIYhI
	 FHqiawIqPgQly1Zrt6wnuyOqZUrsYiRQRHArSkZ0ayi2vgD1A+6Ckmz6S3d7C7pKQG/to
	 6Zoc4295N+bnrdQ+25LiosX9/+bqj1S69G5+jmyM56rN3R8srH7zMvwgyJrkQNFSw2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/vjfaf7ZoQwk1a5SCy6jqwLf9lNtQbMHnKYW3qZM6Mc=;
	b=mGgHOqetOELtpfvD4FWSO6cxZo+/zVnrpx6wgeLRBwdTCEe6Rv9KJrjXeFjT065urIzB
	 liCwsV+Cuz58QFXh4XToaHIcBcjhM0cVwwI+GkcO5gUPGgq7Zm8wjL0yYBsJqcvMH1CTW
	 7rU6BrpmTTHZMBGcwgF/hMFUZESMqhOZXwra62eQWO0g2iCoHsDlNTvZ6DuZiNU1AIBIp
	 oDvtwURi4Aff1iwYeH6GWxRydQ/kRbrZw0p0JIvWeMA/dwzOCjORQj+Gaowq8ux02iWaa
	 EwSAlhRRX0mwGrx7ThD3eoscGK+T2r3/76gtJlhFG7xQKUsLHy/jMrDwLox7A0FBDqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mPVgiQAN;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDD606A323
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 14:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDFDD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mPVgiQAN
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-94958650b09so65851185a.1
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794578635; x=1795183435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vjfaf7ZoQwk1a5SCy6jqwLf9lNtQbMHnKYW3qZM6Mc=;
        b=mPVgiQANRRuTfdeZX9s3CiXeV1768uCbIGAVfVNzxldITUVUrmT30HEkpr2hUQHCz+
         BE2vL0tB7/CU1QqA5ifo2zup+yqsWoneSYO0k8P/vSdUk3B+50WlbRwBVZ712BEl8yji
         6xb+STbAJfOfsvH82JdQkAWt8YCtx+bjWFVczZyhl01r93A5tiiFNe/Pm4DGAv1mPiQe
         xpUiRhJpmr/2kCXNzCXbUUhToBI6o7VXQmJICwFJXV6KycEp4h8K9VVBePyOZGLBnePe
         R327TXGc58MVv1i87FgZ8b6o656IrFI7d4vsyR2DLu2sXfcdsRjhbQsbJL82hTvqkRA4
         B3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794578635; x=1795183435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/vjfaf7ZoQwk1a5SCy6jqwLf9lNtQbMHnKYW3qZM6Mc=;
        b=tcJBBUU94t6u6Mucz/IeoLWAVpCnO7dE7BkFI5KqwAv0RBGC/9BwXHKIRMYrEFuIyS
         /nh0l/DfIBaWkQr+1ljcMcFcOqkHQs9FmqcEXc/03+zjsdnHr4Zl28Eo8152Fg7zjfxp
         V2mQisy55RDpm4dYXdXDDXztdtdRckEDfDvWu2I7WPLJ1DyFJ54HMRigfVgLSDawQmDI
         1Z5STMEGUNIb0QbDgNkG3k0oSeheGNRp174aYzxpj5Re+fl1JUWJlANHg508dpHDKj0K
         GkI67V/TQ/JUlo43tY34g+uW0Ap5GXl2C6ZYQUXJ7OS1sPk8siQCWlOLClT8sDczMCJt
         uDpw==
X-Gm-Message-State: APuU4Z8gEkRxw4JWfz1CTSxtVKyhkjFbwpszQj9Pcvh9+hWUK0AIxIox
	m4L44JhogFZSxvaChc6j/FBMFggtMQyht4l0KdGWqMBgOLQT9Ky0ke/Gb5u7//ph
X-Gm-Gg: AYBFou1v9Au1EIgXOP/vPvqsydX3abfBad+uonipyyWmrcLUqfIfb2fKrWdhb+dAeLo
	b1M7VFYCiPHiizhcV3S0i21Q95IKLsN/jY+Zp+SgyUM6OlAu7z1WIRNL7uSRGNHsgYwpWLmq3x1
	bhtw/AErlucoVhpJo94qsvHzHltvxj7JJvJd6CuuoV0nw5H8YA4FgNu23jmzU/734Iir0S72D+d
	tYoh8swIxO43QEfnnO5O7N84dJkUASLeJX1a8eSNTF0mM3dbLhC0LV1Rqo/Yj7z+cDHnM8SmK5N
	piBNYxxgJm7OntFFUQ05Zm1+VXWVvGiQX9gzDhdKpsTJNtwEDEYQrxdIV2TsEa6qSiARS0R34eX
	WbHKhM1hGhFkRwt9ctr8TKsFQsAzdnC+AUcp9RlGVdTxzrmG9GzBqGGeKMoACfasCb+2zDgDRyD
	zpy0vWl/I+pLW01abAjhU3Pc8P9eovfAo7x+jl4/4dZ3aQJb2QPjhw/8JscAIKmZGAuaTMono5V
	17WNJL30LQ7PhYHJOMlhcUQqf9M4TasVhe/1zFCr/gVuikifD125v7rgeWd6YDmGFRGFCRnpqSB
	G8bR+0RRXlIaVV9sqYDZSP96a8Ua5fdwE0DJ2jthkxkx7r17DILw3agG5jKQxATf9YkQJ3Ikowf
	Ac0rBw4USG11VcK4Uc7nvBbNVCnWBH9rBJJFj8miVLSl/v0Ca6AX3dowUBBppVnuQxk8cOpeSfO
	yFwxjsK8yWyg6vpoXz4eTPyOw7wIWbUfvEKsaQ9mI7S+BmOM8ZZsgs64/Nud37Evw+UJjlG9KT
X-Received: by 2002:a05:620a:450b:b0:93c:5f3c:f485 with SMTP id af79cd13be357-9494bc63eabmr420215685a.53.1794578634624;
        Fri, 13 Nov 2026 06:03:54 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8a8757sm189646085a.31.2026.11.13.06.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:03:53 -0800 (PST)
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
Subject: [RFC PATCH v2] projects/selinux: enroll the SELinux userspace project
Date: Fri, 13 Nov 2026 09:01:46 -0500
Message-ID: <20261113140145.91850-2-stephen.smalley.work@gmail.com>
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
cc: Paul Moore <paul@paul-moore.com>
---
v2 adds discussion of newrole and augments the discussion of
what restorecond and mcstrans consider to be trusted.

 projects/selinux/Dockerfile           |  35 +++++++
 projects/selinux/patch_guidelines.md  |  13 +++
 projects/selinux/project.yaml         |  15 +++
 projects/selinux/report_guidelines.md |  10 ++
 projects/selinux/threat_model.md      | 133 ++++++++++++++++++++++++++
 5 files changed, 206 insertions(+)
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

