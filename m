Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C66ADD
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761312; cv=none; b=gwSE72QN0FEPHK7GgVjJGw86QTWSi1Tphofymo9hSwsXRg3RWS9+AiNkEFocYFRnuXiav+fr+nFhukUH+j2GHnqoMpFO5Iw/15j3Ux9CkGXd5iK7vbIbcTwId3OvwfF8yS/cUp2x3aJl8F5PPLi7T2zwHnt2PMAfSNXZLY/p3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761312; c=relaxed/simple;
	bh=juvGzKCKleUkoxXP/AvyLSBP/8S7ahOlGPn6Ldncjm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvzN3PMYVdWX5VUmhhYL0RxHlzmVMTMAWR4gNAIy14f6Kmp/QIalcAhvnoSya+t2RDlk4JOjvIWdSrwExw+DPeI7QCywxVrY2EqrnR3nQYTvqNaawepX8mhvWgvC+KtJD72mzcJ7n0agzwdFQ36KEXQWiW/2JNzB2C0bvyGDi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbONY74M; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbONY74M"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78f15d5846dso59478176d6.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759761310; x=1760366110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR+mUhA5Kuos/2vakwBj5BqLP90/449VUU1F44vPVZ4=;
        b=VbONY74MDKNj1TVe2CihS0FQEKYiP6AMyXSdmmh1yWKvasKHEd6Zk63pPWGmSwqjnx
         go1mOzGwNXR51zEIRSlBNJn5vA1GvdOhr9/dqzSUfu6HmpuAE2ospvYu9gUj5qponmNX
         sr3PvTCMzxg3nPvAtRTUkkqlqceL4PciHSzz7VQduY4bZYLd/MtbvPsSkbyA288OF1dK
         ebQ4eYkrEQvGRb9624ZrMrm0lr4xVpYl5XSCxQoHcmSYSUkEEGq1ecnEBBFN8Mfg64A9
         QGYEcMD8x/h5hg8OiRo+LMX3Y3eprsDndEsPBoWtA+DC8oQ597Z+PUVwbd7xwvSzVsZb
         sPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761310; x=1760366110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR+mUhA5Kuos/2vakwBj5BqLP90/449VUU1F44vPVZ4=;
        b=Nfvtpd1bNAUBCs7Zn+fNyfrS6P55goI5KDsB0byORImknU/8bBnzmZSnbFBo7G952T
         MX8IKQe6uie/zimJ32OP8YCuLSUb0szQCK4jhWwVIb9XhsG4OrwvhDgzBmYPGNpNntTr
         uHYS5lbq73b+L8Vt78/Wha2d6+87VDPPXPr+Ph6Yu5dzpm+DJJaLKyx6GqIafaDs3N5R
         RPA8q5XJPR9HCAW7k+ksXGApJPDnXn79SLElUjuBQYkNLvGa29wk3+zgF7qH3bpE3x+z
         jtHueRpE7QILVUZIIjwVNzjKN0oq4VPTba9i8/7g9deSHD7f4MYUHHb8fuQx6W75HUnd
         RtCg==
X-Gm-Message-State: AOJu0Yz1khorjDMwgSp4wm03zTXhGiwPLrdrIySBnc1o2b9I3qiV/ZqQ
	SvMX+pRQ5Ehf8MEyGiGR9HvpQatQN54+5ctH1Wy1ILg1DYcnKb0xzyMw9RmNbg==
X-Gm-Gg: ASbGncurLWyncsswt7F6VZjlv5gQ0p+4OxOgjpJRA6E8EwKsl1KlpELOAupH+8dlyE+
	BwJdeGRRj08STTj5rWIZEAbEVbJYZstCR6kmNE+fXjB9hfHsS+QiIzcy+2BDPQSPFqE0BPdQPcc
	L5OrhsiJYgcevmwCo5aa9qN3GK8HT31zwvPoaRyspbd7yadOag6W7llBOcvXGEiPowNHUJrl79x
	2dgJZlMCn5oUVadtN5gA4nq1tMVY94yRBkN97X3iYuS2aKbIGEVn5MbgqixgrenXtVwtDLwsB+A
	g0TwAsHp+vJk+UACvSJK0TI9u9OKufNXiDK7fR1BgE13OruoGQhbctNdEA+3uqokBQclWPgrDJC
	VHD1Utbvro7QJaKO9trNGuROVlZ3NAVeL/pnAs0Mo1r1xrpHNGiR16wMKzuJLWE0nCOW9ZVA1Y9
	5UfzkKKiHOPQLjvCMQA3I/I+x0Wh1C8UC9afRrmHR5Tp5W3PA=
X-Google-Smtp-Source: AGHT+IHpfAMRbry5YfXZ/3PZmjfujzB3XuUeaHoihgsdSGBX1C3Vnp2blQBFGSEDKWb0gE7armlONQ==
X-Received: by 2002:a05:6214:484:b0:81b:23d:55a8 with SMTP id 6a1803df08f44-879dc87ee1amr145506866d6.59.1759761309707;
        Mon, 06 Oct 2025 07:35:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fc21sm118975926d6.63.2025.10.06.07.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:35:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v3 2/2] systemd: perform SELinux initialization again in a SELinux namespace
Date: Mon,  6 Oct 2025 10:30:54 -0400
Message-ID: <20251006143052.271761-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006143052.271761-2-stephen.smalley.work@gmail.com>
References: <20251006143052.271761-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC only, this demonstrates the changes required to systemd to
perform SELinux setup and initialization when run in its own
SELinux namespace. Otherwise, by default, systemd currently skips
SELinux processing when run within a container to avoid conflicting
with the host.

Modify systemd to perform SELinux setup and initialization when
run in its own SELinux namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3 reverts to setting and checking the SELINUXNS environment variable
for detection of whether the SELinux namespace was unshared since
systemd-nspawn sets seccomp filters that do not allow-list the
lsm_get_self_attr(2) system call.

 src/core/main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/core/main.c b/src/core/main.c
index 4fc870d6c0..eb8075fb79 100644
--- a/src/core/main.c
+++ b/src/core/main.c
@@ -3124,6 +3124,22 @@ int main(int argc, char *argv[]) {
                         log_set_target(LOG_TARGET_JOURNAL_OR_KMSG);
 
                 } else {
+                        const char *selinuxns = getenv("SELINUXNS");
+
+                        if (selinuxns) {
+                                r = mac_selinux_setup(&loaded_policy);
+                                if (r < 0) {
+                                        error_message = "Failed to setup SELinux namespace support";
+                                        goto finish;
+                                }
+
+                                r = mac_selinux_init();
+                                if (r < 0) {
+                                        error_message = "Failed to initialize SELinux namespace support";
+                                        goto finish;
+                                }
+                        }
+
                         /* Running inside a container, as PID 1 */
                         log_set_target_and_open(LOG_TARGET_CONSOLE);
 
-- 
2.51.0

