Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0809345CAB
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313318; cv=none; b=BEc614HdtOlB1JiQsUNA5yXVSWTdH7K/myD9TUp4NXpaDT1tE3DcU/5QixMI171uRwHXHOJS6f+jtKCLFYCA8RggKZUt+pvbmGCxabTPchf+bnKDKt+IpDF4zrpb70H3PETtSLABl2SosdYUnQP6nCjiPWk2FIVAKiFbTR7QJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313318; c=relaxed/simple;
	bh=rGVxbRRl1kfH0Mh8J8pVSMJIRLn0OGtkYfuWV3yCLhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfunVKLX60T2zG5f+/YJgCY7GlmR2Fi+h5LHCpDZ1zBTYngauZNzQu04Tol3wJh/Y0b/0h7T+uY2YrckycbDxkdpxqKyO/FbG1D4yQ2x/gGC8igfJElhVnhIhKLt0it1WZh/1XWU3UeVMWndpLdhhCCd4Kj6Js7qJiZxYM1svw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRgniUQE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRgniUQE"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c4436d02cso27087801cf.1
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313316; x=1784918116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F49G/OoMVdOSeWdg7dcaH5I2fSamTXNZ4Hb6qx0w9PU=;
        b=jRgniUQEFYeqmAIH/9l9wyT72uChpdDjBWgog+LZHP82zrJVc1snmIznB3wu1PDVoL
         VQD8cUpZVy+9T2eWD29oRZlRLiVtwH9PBxltQ+froTYk2p29k1X2cbhr2AYLFauxLPCx
         VMWRnxFb+eNmKaytfk6w2T6+T5EGMQtno1GBX8BSlnTwG61T/ze8exJWWd/JtyvuVFYI
         BiCcimD1Co3NqctTnd1r56UjEFTxj620psTyr6bwi9mgxF5dvGm09K0unEMUUb7Jov3m
         QX6LcVKt4cEBISnCwCP7M4zVt0FXqxKh9AYaszQTWyax4OWweunThSxYHiiGTtNG+dZs
         4ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313316; x=1784918116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F49G/OoMVdOSeWdg7dcaH5I2fSamTXNZ4Hb6qx0w9PU=;
        b=cFIoRFWu0tUzoYqr2BmMXSjlCoig0B/tjEaMXZAPImBD6+qzx/oHqoFi3pc9dYJ18r
         ja3OK8nvEMsV1olaP8hbYb+GJAu0qT7ch38QuAa6ZXl+FG7juRgRBHfrS43Enc+uH0e+
         t195eUzMiI5QI7Ji+93QmRUWgYJKw7rcKZKiK5TijFxDtoPNkJPayXtK2F70DerOf4wW
         vdqoRJdxMa4+kjIyA7KLVZ/ZEMOpJLekEPWs6iDu5yb173Gj+TtCmpPtq8k+VHrRQRCM
         kFe+3YCvqvOH2g026A/0lD8fSei2nS7M8s39JI8eLEVWUUBgAFAAHIXUP7c0duLDuyZl
         +ErQ==
X-Gm-Message-State: AOJu0YxGPca5l+hx6FeLAVYc4o7r2D8JxMnNHS8tp5M12s0TFITXnLEH
	j6sFl6c7WIgnqnogmqvwd4f3pundvWecX9nT3rOfqt0bxjsLKpuMvQgiyy5oCQ==
X-Gm-Gg: AfdE7ckh0U5ZbJhXqww/VpDddjfegA+RkMXUBXOopqBYmWg/9sWGd8ecuwxuhaE3BBt
	bHzpKDRCH0COajtPilPmNoMk6e3NTmcHkGMEX+MQimBdOcvDs137jvyFHu13jMJvhyl8FLOfTC2
	JuoN753KiNMry/Q09guC+mfWjgiO+F0tRKs27XSBHKdgpUt+ZHDcy4gqIQANoKP4DckZ7QtfV9N
	h2DpEP7D2E/F9BCAy3nd8X7Hv2ChFgth7wt/HZISurApuD+bMb+fOwVtN8/i6NKcH+1bAsfBDLk
	YXlTbrzCPf2Yos/9WdgZK5fhu/mgZ/fyu6+Q61bxamYeShDv8SQuyHiIJg4yC1hd8Sv88iBFvuM
	T1s6gtuUSQLqq9cKlGku3mp2OKsADouxnRFD0BYaHlO3etFxMnITEdNjMVvSe2sxy177bMeEBN0
	AoDBHGmCSNks3Va7I/LXdOLHuOZ0i9VNUUni6N+kJv5PGE0NEasnZRkCyfrPQnpVnnHZ8mRZXbK
	tkfLg==
X-Received: by 2002:ac8:5816:0:b0:51c:7b12:1207 with SMTP id d75a77b69052e-5213f668797mr38903161cf.85.1784313315735;
        Fri, 17 Jul 2026 11:35:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:35:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 05/10] sandbox/seunshare: document that -C has long been a no-op
Date: Fri, 17 Jul 2026 14:34:19 -0400
Message-ID: <20260717183424.20324-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
References: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally seunshare cleared both effective and boundings set by
default, with -C as an option to only clear the effective
set. However, commit 1f0b5bd920c8 ("policycoreutils: seunshare: Only
drop caps not the Bounding Set from seunshare") switched the default
to only clear the effective set, making -C a no-op. Document it as
such in the man page and a comment in the code to avoid confusion.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.8 | 5 ++++-
 sandbox/seunshare.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sandbox/seunshare.8 b/sandbox/seunshare.8
index 5339a3b1..bad7e1dc 100644
--- a/sandbox/seunshare.8
+++ b/sandbox/seunshare.8
@@ -22,7 +22,10 @@ Use alternate temporary directory to mount on /tmp. tmpdir must be owned by the
 Use alternate temporary directory to mount on XDG_RUNTIME_DIR (/run/user/$UID). runuserdir must be owned by the user
 .TP
 \fB\-C --capabilities\fR
-Allow apps executed within the namespace to use capabilities. Default is no capabilities
+Retained for compatibility; has no effect. seunshare always drops all
+capabilities and sets the no-root seecurebits so setuid-root programs
+run without capabilities, but leaves the bounding set intact so
+programs with file capabilities continue to work.
 .TP
 \fB\-k --kill\fR
 Kill all processes with matching MCS level
diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 37a24c57..7c6154e1 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -864,6 +864,12 @@ int main(int argc, char **argv)
 			verbose++;
 			break;
 		case 'C':
+			/*
+			 * This is a no-op ever since
+			 * commit 1f0b5bd920c8 switched
+			 * the default to support
+			 * use of file-cap binaries.
+			 */
 			cap_set = CAPNG_SELECT_CAPS;
 			break;
 		case 'P':
-- 
2.55.0

