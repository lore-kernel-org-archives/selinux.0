Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452678;
	b=mwOeL4DndHpEOoEgci8WFfCcuxNScqFj5vMqJJEqRXLRlmB+Prd8AmzT6ArzPxiIN6qM
	 f8sIvQAz1xQQsBH9+QiYMD7h5+EL5zb+5aiXxAS00zjq3DxhWZaI/kMLR8b5k6DMbf1Zz
	 DnX9ygW3UqAxPBotUVIsCCVTZJmBw5tEioh5agCXjepD07CDFmLD9GnyZWNihWq5MGAix
	 tEotiLNXjqM/Y056ka3mX6LfB4gC/vgIkiExyHYmcc6zP44/6+4GrWIt1ZM3Jk+Miq9dH
	 +7G+U6N+/P/u8AhOCaxq6l92dksmb399aximNVZP5tZqa5x9wmj9kPpySYxSKEAvJgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2Lya5TxTzCvLUN9EzOvnob4+EuGTbJ2TdbqkRzlvhtA=;
	b=TFdkigTUR62iGji4JjDx4NUnwAKp1ZE26Bcj/vXQJPV1ljyr/Hf0gdhy/d1EcnzmI1FB
	 gGPIBhB4H6N9sAXalzfzuOPhnhiiNddgjK3H6FDHPEpaWzMKVsT3DM9LwmQiz9fsi8dGN
	 kirem9mQUiia0Y5E2Ph6w60NqsGZOnNYaKiHkdOr1iey8F8uHcR+nJDSxLjXfTvsiA4o0
	 hAVs2zaYJG5MDSkS0SruKyZV/kFys/1sttr8qU4mxUxLqdVl78Pr0WXbdhW3Mm5d++KmJ
	 rgmlUE+KW/8a+F+j1tPSYZIeSNOSEQBqjK5GpTn4mhPWY2akdSxMjYOleK01N4nCb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lKPPZS+Y;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E0606A33B
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 16:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB7E0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lKPPZS+Y
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9213fddb596so43122896d6.2
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452677; x=1796057477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Lya5TxTzCvLUN9EzOvnob4+EuGTbJ2TdbqkRzlvhtA=;
        b=lKPPZS+YBoZqYX0uPl4WrJvfxrjjYu23itCAxMlmOtwmQqWs6LluwgGcZzacaT0OS2
         JOtGBIywob42R3ufTJKCHzq8lvwx+Jv5wf88VoDKukKfCVQnqrQNwnuek4NRIrG4Jg4+
         iopvQibO2gJnU32M6rBuI6QBhUy1FUSwtop9kob6qTtSlWuvG6FXVKFkDJHGJySAvrYo
         9P0AZYDyOP+2Y/FBDHQova+BSmfy0JZK85zmco5lj3YHHsQ1E/ek+P85c4uVlxgPqdLX
         9oysxQxLYF6Aw5Rr8ahNKRP/1vUxgOwwNx2GJg1ShzvOsWspEUQkNolIzjGiNv7v87dR
         Xcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452677; x=1796057477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Lya5TxTzCvLUN9EzOvnob4+EuGTbJ2TdbqkRzlvhtA=;
        b=mTGPdz1dHDkCnYB5xoz6nYP1eHIOlL2ti06kxn9StcFWaEbyHjRe1HwPM1HQ5uxF06
         AFaVXjDY2JxGgwjDaTmDvz3wLDM87UIXjBNlJ+z6ZiUNklOHSj8xNKrNQjioVteCmLMz
         VdndhHpGcCTzUIwG21jeYgUo/HrEyrkBxdOzmjiZ1LpBLFm1vjhAuBX5ZAcEIjudlUwp
         /NYhHEg+P9grT93ao1e8djIMzwnJ5PjEF3KH0IP97xyWSHq6BZ3hIDwOTnZqKQ0ZESgT
         rhOLPDacqSISQlIicOmgOUr7mvQCIiLqeGIcSb9SrMT6WG3WL78OVqZgtLoue0139Wn0
         2Buw==
X-Gm-Message-State: APuU4Z8mbJ736XgPzj6sI2DAU2Ap/Hss4q0ryIadY7TqLiVTymCnWuHJ
	g+mk8gsBQuRvlU8+4aMdMNqWJ7r8+JYEFFIAEJqX0AqrJkWLKV7qLyeoXOKgTW9g
X-Gm-Gg: AZFdTZdXe7oChcqRKChe9AI9r5NUVFecac+YzB5WeQKuOQ2um23X4t9aj1/xtz7SMfX
	JpwNRdYzpaqRZZwi1SU82C1MUd+u0aZhHr0Bwcn2DqJSRLfrYK2CCp69SFKd4GYxls1gK8XAdoi
	GqeWPSlVJP3EKPSIWuMlMoPJdNIQ74FiGeO0RKFLm8qlWJ6qi2rT1YsA6vXYIV5iCChtvksZt9p
	aUO/SUc8vOPM6Vocsrpzdn5ippqobz2wochY91XnTa2NRh7Ugd2dFlRapsEVm3RfI0TTT7Ab97o
	QDT0OQxi7T7KHOm3KmymJLZaIQwbQQNDFG7oQE3vQuJorj3gdB6Lgs6+Wa1KX0JBHKwiihgAved
	57MfEgvBFkrcvnNLhPVY50UJgzZDKBqdy0ZoNtEptUliY6vOHBW4++lJCZkmXLDUlJ7mBTJ/5Mh
	7QKz+2gTU3nMA3Fn41eVHhSjUUKBJfISC7PnDKbcqmhB8g0L3ZbOPNYyGbNUTWmujquKWIgthyC
	msEQ1NcPDH9DGeN4le0y6NvcuTwL0OQiM/mRAUvWrL+LlY7gFp8j6QyIeNHpzUGtWPSf1kMvXjh
	zZZVmq+rCeWe6HdErac5urfvAAxQxNLzuJ6zQB9C8CYsrGh8pbb6rCFFD7yifMHXPS2uUPUmbMi
	MS4Epk7fyckfyPS2FVP20QfjvjPZjsdaupKl+lhh6MXxLLeqTzNUylNV3RvrtqgAptNDRxRAt72
	GBz3/nrxfkC1HMdw9KefeVwglHmMv6NMkcYEfJdTxtlE2/fg==
X-Received: by 2002:a05:6214:19c3:b0:921:2872:ee39 with SMTP id 6a1803df08f44-92134ae1592mr215742636d6.33.1795452676608;
        Mon, 23 Nov 2026 08:51:16 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cdfbasm110684136d6.17.2026.11.23.08.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:51:16 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] .github/workflows: exercise the Python bindings with PyPy 3.11
Date: Mon, 23 Nov 2026 11:51:02 -0500
Message-ID: <20261123165102.56120-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Add one GCC job with PyPy 3.11 to build, install, and import the
native Python bindings. Keep the CPython and Ruby combinations
unchanged.

Ask the selected interpreter for its include directory instead of
assuming the old PyPy layout. The Linux extension does not need to
link against a hard-coded libpypy3-c in the intepreter bin directory.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/actions/build-userspace/action.yml | 8 ++++----
 .github/workflows/run_tests.yml            | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
index 2e64b09f..4f0daac1 100644
--- a/.github/actions/build-userspace/action.yml
+++ b/.github/actions/build-userspace/action.yml
@@ -118,10 +118,10 @@ runs:
         echo "PKG_CONFIG_PATH=${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $GITHUB_ENV
 
         if [[ "${{ inputs.python-version }}" == pypy* ]] ; then
-            # PyPy does not provide a config file for pkg-config
-            # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
-            echo "PYINC=-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
-            echo "PYLIBS=-L${PYTHON_SYS_PREFIX}/bin -lpypy3-c" >> $GITHUB_ENV
+            PYTHON_INCLUDE="$(python -c 'import sysconfig; print(sysconfig.get_path("include"))')"
+            echo "PYINC=-I${PYTHON_INCLUDE}" >> $GITHUB_ENV
+            # Linux extension modules resolve Python symbols from the running intrepter.
+            echo "PYLIBS=" >> $GITHUB_ENV
         fi
 
         # Display the final environment file, for debugging purpose
diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index f379be10..247c5b98 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -25,6 +25,8 @@ jobs:
         include:
           - compiler: gcc
             python-ruby-version: {python: '3.14', ruby: '3.3', other: 'sanitizers'}
+          - compiler: gcc
+            python-ruby-version: {python: 'pypy-3.11', ruby: '3.3'}
 
     steps:
     - uses: actions/checkout@v7
-- 
2.56.1

