Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237920;
	b=aDmaf5OHjW4cgBhVfsM1700wVFV0/3YtOvJisbQlQY+4dMnsdQx44i7WyYJE+Gb1UpzF
	 pAjyAJkDbrIaGxX7rBOOy56Lz7jNs4tS/CyNINd4Kq2h+9AT525eiRK2JmBMss2ikfyBs
	 LJB/kFBYTEbe/1uOTIe6mvhHe+H4nzDUL3D1pAtVz19a4wsVt4oOINl5w3/pC3g2hMdJX
	 k3owOCrPbspt9MA2wUN600nBeunu0rI/4tzRNkDXC4LhUSSVBPj4ui8Q7eKWezFlBX9Rg
	 F2GuvGdD4QO2pttKGBh+FomDt+g35GP0zV3KRFm8l/4TDrZI+uNXMjBDGQ/mKpQpJ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zhQLArt3j13nMq8gjeQRg/dlVQlvhhEHGgIF5pMYbl0=;
	b=zjsSrjoVpxSr17DzBz05GbCv4LwK147sa048xk+fRwj7wjKNqZUj8a2aEwgN0HmjL3vk
	 ID6UQeen2x7yZmjW8KEHA/6ZKrhIzX2KLCaLiX15+DGfQ/0Vn+mL777xR1TixyA/GOj0d
	 FqH4TmgrcEit5NrFQ/t40bK5PTuCUpQcbrxJ1ptkfYDbI79CV1AQE4rqgtOQEO1l/C0vE
	 chQr8maRN+wvqnYDYuzg2WZ+WW5a7k7iuQXQK/Jep5bC68ypXSBjed6zGk8aNsdWmHPb9
	 +Vx1bLTsydumjJcV3B14+xBhaXHscTtD7Q+NZMe1t0tjgE1woY6coKrDUy4p5a+bkmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oqKEuRTn;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60216606A337
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60216606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oqKEuRTn
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53665358476so9290421cf.2
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 07:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237919; x=1794842719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhQLArt3j13nMq8gjeQRg/dlVQlvhhEHGgIF5pMYbl0=;
        b=oqKEuRTntyT/te+IRSJRiG8KAOz4jvXr/wW62wjIZJ3SRx37jkpiIOa+V79EE4jPJX
         n+wlEH3PWKYvVBhYNZFfRgqAwHo9osdONMb0/qP4hqF67j4VVR5prIthgQGlFO4rQT0I
         a+prYUyAYhpGmqHxuap5JfoJGe6gYfTAiioUr1CTuZx2jJUxuUkZM57Z1/SsBseRYDjc
         GQLgh0kniZdJ5Xd5yzi5fyAyJu0hWWhGYD+sjraGmW4VULXBrjvuSHnP3oWqiTDdwq02
         JYp/PBK2OOPbCAjv/ccQ7o3ZiCVMzybHNGGxAP9nP5zAKwf/aHv5VQxvKMVUJXMaxqGb
         a1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237919; x=1794842719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhQLArt3j13nMq8gjeQRg/dlVQlvhhEHGgIF5pMYbl0=;
        b=tGuM5lV2UhfuxzNvraV0yLk4CAS/8QfnVJMMNpCl1f1PeTZM+clfvtnlpFDBZNsCTB
         tAequ9SbyL7Rk2u1U5yMa82cmPA0wm9KRGMgxbOeP5+80HdN8shOhsqfUPxRUE6VkLqx
         0m7WHmn9iEp+av6SmtcwkIREcfh/fsl4jC2TJPB9uHXzO8ARTY2HQoTDNKDB6bgkL3xr
         fhbFItZ3hMFViOimRlr1qCMTGEXbYtwr7tp2MLTrIySeX1g1fJ38gNIwNe91qYd2nur/
         Sh3fbSz7wwAu5ONhjB1yLkc5mPrcUEvVimc679/3Ny40LEMcCoBkxqJzsX/nzliEu5o1
         lePQ==
X-Gm-Message-State: APuU4Z93YSoyuuOa0pS6c5eOXRNv1/inow1LkGXTztZo1RF2pIa/CRUC
	uDrvMVEa0kG4CvgI22kbTRbiO0hGP5veujF4RmF3BbWIptO9cO2L3cLxW9ARxSle
X-Gm-Gg: AYBFou0QvEnG7BJXMUBaemxWU6m9KNNqPPUmson6URilXrxy1j1rTGHIgdVbTq/Lf/W
	frHRh7IGkvUCvZ/0j1X94/AslUlXahV8f7vrAFMYVRbHKAZ/gD2re0PXsYuoipddks/AeOEyv7w
	Dcdrgg5HQXi+LfV/adHGk4pWUT64punRmdfRr6vSjfLsWIWYQxp9mw6TJtowqATYt7HMHKMbbDS
	iq9VL1iLJm0FmXYy/Vv7NbJXZt5ivIZtiuOTrY1JUZTzAxaYtg81ypncHUbpH4+tV7bAdLMZc6b
	1AluFC//oSpOQV5q0h24+DGeCEN6VVp3BGHR6eG6HxLb2AqNU+QAo4D6mEHUIUpgGEwHvYWhX28
	kmQLVAlEVK1s1lqHh3TR+JZfjAeQDPOOTaPqEFnEZStlhqkq2eAe7frYbLCyzbaEqRiaS3+LCPc
	RRMELVcLlrOhFJcOVf1aKPXZ1L1SydLxJAOgMN742tXvAkqdeFD4l1gZTDSW3o7K8VutwkZpNey
	ZJKFlzivatOCbB5T9o274wzqP/j4ANROtePA6VVWfIkWuo2p4L5igwGVd1Vtf9NBDiTEko6fBBx
	7ex/66e/a9VxG3SgBu3jKCY8TkMPUUmtIzYlsAC5prWvrXiTt5g7CH8e5qcovTZ1lwKf3mA6K9A
	5gPtoyC03DdwPXrxZaJRTmBFqA7i6D1L8ftLm97ciYaiPdmcvWh+OhPc76pIx/sM1CTtE+AOy/8
	U8OD6reY4HjlsslJiZx0suj0GX6Y0eu4So7u/4+vjO5pB81WNl3X8ROeeWh8MPELTjWEg=
X-Received: by 2002:ac8:5f12:0:b0:536:8843:c2bf with SMTP id d75a77b69052e-552a578c35fmr66535951cf.67.1794237919202;
        Mon, 09 Nov 2026 07:25:19 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecee766c1sm44208046d6.36.2026.11.09.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:25:18 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 3/3] python/semanage: use a temporary file in test_input_output
Date: Mon,  9 Nov 2026 10:25:02 -0500
Message-ID: <20261109152502.124123-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109152502.124123-1-stephen.smalley.work@gmail.com>
References: <20261109152502.124123-1-stephen.smalley.work@gmail.com>
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

test_input_output hardcodes /tmp/out as the export file. Create the
file with tempfile.mkstemp() and clean it up when the test finishes.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/semanage/test-semanage.py | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/python/semanage/test-semanage.py b/python/semanage/test-semanage.py
index 004b52e9..a2788603 100644
--- a/python/semanage/test-semanage.py
+++ b/python/semanage/test-semanage.py
@@ -1,3 +1,5 @@
+import os
+import tempfile
 import unittest
 import sys
 from subprocess import Popen, PIPE
@@ -35,8 +37,11 @@ class SemanageTests(unittest.TestCase):
             self.assertSuccess(p.returncode, err)
 
     def test_input_output(self):
-        print("Verify semanage export -f /tmp/out")
-        p = Popen(['semanage', "export", '-f', '/tmp/out'], stdout=PIPE)
+        fd, out_path = tempfile.mkstemp(prefix="semanage-out-")
+        os.close(fd)
+        self.addCleanup(os.unlink, out_path)
+        print("Verify semanage export -f %s" % out_path)
+        p = Popen(['semanage', "export", '-f', out_path], stdout=PIPE)
         out, err = p.communicate()
         self.assertSuccess(p.returncode, err)
         print("Verify semanage export -S targeted -f -")
@@ -47,16 +52,16 @@ class SemanageTests(unittest.TestCase):
         p = Popen(["semanage", "-S", "targeted", "-o", "-"], stdout=PIPE)
         out, err = p.communicate()
         self.assertSuccess(p.returncode, err)
-        print("Verify semanage import -f /tmp/out")
-        p = Popen(['semanage', "import", '-f', '/tmp/out'], stdout=PIPE)
+        print("Verify semanage import -f %s" % out_path)
+        p = Popen(['semanage', "import", '-f', out_path], stdout=PIPE)
         out, err = p.communicate()
         self.assertSuccess(p.returncode, err)
-        print("Verify semanage import -S targeted -f /tmp/out")
-        p = Popen(["semanage", "import", "-S", "targeted", "-f", "/tmp/out"], stdout=PIPE)
+        print("Verify semanage import -S targeted -f %s" % out_path)
+        p = Popen(["semanage", "import", "-S", "targeted", "-f", out_path], stdout=PIPE)
         out, err = p.communicate()
         self.assertSuccess(p.returncode, err)
-        print("Verify semanage -S targeted -i /tmp/out")
-        p = Popen(["semanage", "-S", "targeted", "-i", "/tmp/out"], stdout=PIPE)
+        print("Verify semanage -S targeted -i %s" % out_path)
+        p = Popen(["semanage", "-S", "targeted", "-i", out_path], stdout=PIPE)
         out, err = p.communicate()
         self.assertSuccess(p.returncode, err)
 
-- 
2.56.0

