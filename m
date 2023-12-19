Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69261D13D
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T0CYrzPY"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a233a60f8feso357666566b.0
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002214; x=1703607014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akgUxFrDS2OEoiOfORLhSX66qaJZlbiwFJ71FzN57x0=;
        b=T0CYrzPY2jVn66K6kvsW3mrbB6KWmAzH9IBka7+yjTkSCeAIGAdbKyQHgymMdNO1wO
         3zFMrAa+OLxnj/UzJrHFeAcoppyYGIYjicXPgcnjU0hFLS2+HuZ3y7Y7OtQBRfDI655w
         cuSUOZMj+9DUajYBKuNZBmI/yRoUAwec7mlX7KbBVaSbnsz49eYkldg1Snfx6C4KZucs
         7EMJJKtCVSeOKIaFhj8z9GB5KrPAKnFn1pUQZ5ww1Dtf+xz+C/2TUQ6pjKWWUIPLGGDN
         7c4jPVUti157ho7+ypeIDHO1KGYyV2O17gijvkdAfaWC4Ld9dUargyjq1msxIfHzMU2q
         3Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002214; x=1703607014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akgUxFrDS2OEoiOfORLhSX66qaJZlbiwFJ71FzN57x0=;
        b=DERW5gACO2eUL1q4vGbZQUSuUjjqaGMG43r0OOS2FIBcM0hUsniiOYD+u0VZCeNhRw
         8+HD1rfhzy7qt+dIsi078ISIjwRggnnG9o20loIpY2DTnY8qx71fUhxEu0FDKHH4DJ6f
         YzROJJKabNDWAhdvFarGDn3nser7tLGNfI3O5Qx69+jhN2jz/Pap1pFncCmQPOUyFIw7
         05stcrA/pokJsV/CXNROrK4RujbbTohNBnUimSq+fIv1QYXQnFtpHGSUDprd3LsIuacI
         NQtk88ExTkcunZFsdWSsMmKNZV4n96FVZPE9R6urrKsaw+Bfv7qTg4FHayBGqTSg6RZH
         foPw==
X-Gm-Message-State: AOJu0Yy7kHdcBvvV0kgPvZ/CcZKmNVl/mX8L7fXc7msWqO24E5F9Did+
	XpG3LwfCls/Kt5WeDkrQMTdoHLdv/R8=
X-Google-Smtp-Source: AGHT+IGdxgMdv54MszGq0vn1OZikBRXL9Smkrw/FLGX2vhvrT0gPYZ3Cw4lKUIrChbkK3GRyzai3Rw==
X-Received: by 2002:a17:907:3e13:b0:a26:8683:bd3b with SMTP id hp19-20020a1709073e1300b00a268683bd3bmr377124ejc.125.1703002214021;
        Tue, 19 Dec 2023 08:10:14 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:13 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 04/11] libselinux/utils: improve compute_av output
Date: Tue, 19 Dec 2023 17:09:26 +0100
Message-ID: <20231219160943.334370-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Show the more interesting inverse of the auditdeny vector as dontaudit.

Show the inverse of the decided vector, although since Linux v2.6.30
f1c6381a6e33 ("SELinux: remove unused av.decided field") all permissions
are always decided.

    $ compute_av staff_u:staff_r:staff_t:s0 sysadm_u:sysadm_r:sysadm_t:s0 process
    allowed= null
    auditdeny= { fork transition sigchld sigkill sigstop signull ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit 0x80000000 }
    dontaudit= { signal }

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/compute_av.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_av.c
index cca407d6..09f574a0 100644
--- a/libselinux/utils/compute_av.c
+++ b/libselinux/utils/compute_av.c
@@ -44,10 +44,14 @@ int main(int argc, char **argv)
 	print_access_vector(tclass, avd.allowed);
 	printf("\n");
 
-	if (avd.decided != ~0U) {
+	if (~avd.decided) {
 		printf("decided=");
 		print_access_vector(tclass, avd.decided);
 		printf("\n");
+
+		printf("undecided=");
+		print_access_vector(tclass, ~avd.decided);
+		printf("\n");
 	}
 
 	if (avd.auditallow) {
@@ -56,10 +60,14 @@ int main(int argc, char **argv)
 		printf("\n");
 	}
 
-	if (avd.auditdeny != ~0U) {
-		printf("auditdeny");
+	if (~avd.auditdeny) {
+		printf("auditdeny=");
 		print_access_vector(tclass, avd.auditdeny);
 		printf("\n");
+
+		printf("dontaudit=");
+		print_access_vector(tclass, ~avd.auditdeny);
+		printf("\n");
 	}
 
 	exit(EXIT_SUCCESS);
-- 
2.43.0

