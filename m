Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842911;
	b=wfuOAzbdr5mOwHMmRI44J7J/B9zQt3+9K8nQJ0MQxwrJ43XYrVlJW5o/kSzKc6AYAxIQ
	 cM5bPhJAGxNzbCfUKDXidYusHJ/aDIg1vinB21fySdRPYCPcqK8JsbMCyR3AU54cBzDqa
	 F+udEfryzsma2Tny3IIWngWQLmCJU40LmE+Z14TE5HVTcdlgyxTAHt26bbz3WldT1wUom
	 O2aTrOKf6ZE5A9EZJQFpKZFMgu8Mf/VTf2/JVg7oXfxOhVtzrJE99CccPWGRIOl452CUb
	 Lwqg5ebr3F2F8kp4cXNNYDotFEoNDavNMXMvulymEniaw8mwBhv5BztPZfcxnzStpZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oVi4hXjB7D/dNF+GAUkTbKmVsiaoym0gEXTGv+6A7/c=;
	b=TiQfEEHdSoNR3Rbw06cvg0l+xU91c8GuaBMJ5+b9PljcQFQnThMjaBKQGcOYc93Gr9Fg
	 fnlxmPwGk1rgeG3bLkBbYPR8if7V4BX2qaDi4/Kwprqfl+qgc90E8Bop42E7lQ4SQrhm3
	 StjO1froWQC9isN1VcmXR97rb1RXZL4M7BrttDhL6dxX+vcwDns4E5OQjHUKqs4LwrvZV
	 ocKAWwd950eg0t+/84BLKmOqNL9g9anIBj2VgEjFl/Wrc55bXFq9RaIE9xhwKKxawFIbp
	 kuod2hO/TZDTba6TlWzVU9H0YVpovecty3VHNM3aiIworymJg0koufBFFYKodCk6oVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2YRmEv1;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFC606A88E
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 15:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5BFC606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2YRmEv1
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91f1e3dd08cso14588876d6.3
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842910; x=1795447710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVi4hXjB7D/dNF+GAUkTbKmVsiaoym0gEXTGv+6A7/c=;
        b=C2YRmEv1WN822ed9QYsvGBG/5G6vhi9gLY5k+hxFJMW6taFB5DIIIX8d2e0Pcq38YQ
         fKtrJaO4s6LlpY0Mb6IHfbieqrTB6iK0mAIdNvUJajj+e6qRCP2ip3Bek3W/kIAw8Dcl
         OCx1cYIy/m7ehdp1IfCm44Cu352GiioFu776m/Iu6NBIglDU4qFkPkD86vsxo7v5YAuT
         ETDutoAhMhIwmPN6FwkMOYM72KkwduP4O0NsRdu3YIS+ewpzBt91T44evHUR/uSDey0n
         8sj2LIxyMS+PuRo3lGEyU8mpfjWf8swuppesBO/jlJxklPdup4E6BgQC/MKJmgTuby79
         8owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842910; x=1795447710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVi4hXjB7D/dNF+GAUkTbKmVsiaoym0gEXTGv+6A7/c=;
        b=qL3Rln6ia64lVaN+rcm/xapqMgx6pAjX5SqBXm90K499E+UtyoV+XM1Ap6tZbD+wCR
         uAiCIchcG8oB/oecF6etUwTMEOiHhbX5BTDbUEIa3guiOXb6RjFwr8vv1pjbMTpjCG4B
         fFWYJepw6qmjyGud0kDb9x7goqPjsWub3tCTi1bf485hhbgO/SHDvFhrW6CTCcPlYBIV
         3b9kSeh3/2ip/jHQ40aeTl4X8d6Lm74Lo/QrquEiMhzdSrGVWrSikwN+bxw3uqCvs+/7
         +oYDqBGafhC/VzS8hnJJOZjFvOnA34aTKksNNRfAegBnRWDhaU5KDNC79lAkWWC13NsL
         K6fw==
X-Gm-Message-State: APuU4Z8FyJsf/NSSmvOJOwnz4FXon7USTeNyeukzz2rP7xVveM2ukwNY
	1WK9+Fs0dr3i+0vzCVuVlN0WMEcy5fUw4X3S2n8KYnHvCgqR0I7RGk3oB+4suEDj
X-Gm-Gg: AZFdTZfDdEB1Ux9XBpCM6ZF/KCZQicWMiv88sudR4TR1dfiE9FNZZ+7lunQIfmVGgYu
	wLUOel1RRxjxjyqQeZSLp5dw5YlWWnLTqMi/gLctaW2xnus96meV/5BYkF/Qifq1AwZV2URx+o6
	kDUAYVO6c1R30adkE1ILgSf3hpvhvpjsm92rT0Q37w20aXF0S6hKoGvp1zf7cgpNSRywt5AS6/U
	TWsHnM0VUHE9EYb7ZQ4HgTFnkq21Y4TA9GRwlYmeV3rOTHhM1NDmQX2ebHiO1LhRBkkXWNOQ3TG
	4tnBZSXTWkClSr7ftLvWjfjliNBj+G2PrUJPAS7b64XNEukoe3JxOVO7UHhsc/VTkQ/u37pBG+4
	T4QApJmscUQdG6bg4x4by+ae4O+zmnw9a2Kxdevm+u3+SU/4MrNs/Xu1EnXx6ySuY8UnSolT5xc
	kP8wRDC3kSeVYUUPE24zu+n6xpNAp+Us6bguCbpX0HNTSYgpWs0QaJ1AT+rwK3BU7PvRsM+DN+4
	ZNZjg4StBrL19cCC/Zfa6tdq+TkkwEeMYfAZcPi3FEazAxLxkAd+2erO75YzQ0lsXvLk6+IeNSz
	iPjsNO0MIou/RIfvvkYYz91Jaa6b3wMC3bXTt+Vx++DgtHynBVHBNXVo1LWHVsbSXNv/QyEbbwp
	Xuc5EfRXuJpE+cL98j7vvevYsL2h/21GSVnd3oG1V/Nc5yB/96c/Cz3+kJXKiXzZBu26avhxSMb
	Y60Fl8Bja+FN12FRhB1dpPCD70l02GSP1tZmNOjYO56pt0D5FD1GhvXzNVP9CMXKtSJ58wXsor
X-Received: by 2002:a05:6214:762:b0:91e:b7fd:b35f with SMTP id 6a1803df08f44-91f2421e092mr172870106d6.30.1794842909660;
        Mon, 16 Nov 2026 07:28:29 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db49c5sm88286056d6.41.2026.11.16.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:28:29 -0800 (PST)
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
Subject: [PATCH] libselinux: require a pathname in Python policy_open
Date: Mon, 16 Nov 2026 10:28:14 -0500
Message-ID: <20261116152814.137764-1-stephen.smalley.work@gmail.com>
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

Python open() accepts an integer descriptor and then ignores the
opener.  This lets policy_open() adopt and close a caller-owned
descriptor and bypasses the read-only policy configuration file
lookup.

Normalize the argument with os.fspath() before passing it to open().
Test both an integer descriptor and a path-like object that also has
an integer representation.

Fixes: 98c2eb900519 ("libselinux: let Python own policy_open descriptor cleanup")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinuxswig_python.i  |  2 +-
 libselinux/tests/test_policy_open.py | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 28d37e92..e3f98a49 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -68,7 +68,7 @@ def policy_open(path, mode="r", **kwargs):
     def opener(name, flags):
         return selinux_policy_open(name, os.O_RDONLY | os.O_CLOEXEC)
 
-    return open(path, mode, opener=opener, **kwargs)
+    return open(os.fspath(path), mode, opener=opener, **kwargs)
 %}
 
 /* security_get_boolean_names() typemap */
diff --git a/libselinux/tests/test_policy_open.py b/libselinux/tests/test_policy_open.py
index 337be348..dda2886a 100644
--- a/libselinux/tests/test_policy_open.py
+++ b/libselinux/tests/test_policy_open.py
@@ -70,6 +70,27 @@ class PolicyOpenTests(unittest.TestCase):
         with self.assertRaises(FileNotFoundError):
             policy_open(self.path + ".missing")
 
+    def test_integer_descriptor_remains_owned_by_caller(self):
+        with open(self.path, "r+b") as owner:
+            with self.assertRaises(TypeError):
+                with policy_open(owner.fileno(), "wb", buffering=0):
+                    pass
+            self.assertEqual(owner.read(), b"policy data\n")
+
+    def test_pathlike_uses_path_not_descriptor(self):
+        with open(self.path, "rb") as owner:
+            class Both:
+                def __index__(self):
+                    return owner.fileno()
+
+                def __fspath__(self):
+                    return owner.name
+
+            with policy_open(Both(), "rb") as stream:
+                self.assertNotEqual(stream.fileno(), owner.fileno())
+                self.assertEqual(stream.read(), b"policy data\n")
+            self.assertEqual(owner.read(), b"policy data\n")
+
     def test_late_failure_does_not_close_reused_fd(self):
         namespace = policy_open.__globals__
         original = namespace["selinux_policy_open"]
-- 
2.56.0

