Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NN0nqRis"
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E053A9
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:00:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1c7b20f895so530818266b.2
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702306837; x=1702911637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NiLLniJLE6fb8KiurbJNtdtPhG37u715gDxtCJGRTDg=;
        b=NN0nqRisBRiBGUVnap9OTEiHNJDRVkw7PFq4qqu3mI/3PBotWhqCiyPl2iMgWEOCUw
         1+H3BGNyktNX9XkspgN1eu7eEr4MqzxER1OdgqZpOu2MLMyA5GXmaRQFMG1EMKI3MQJs
         OAo2heV1/xPykAHE0gVmQeblE2F3PCaHTC/aD1kycfAM2pJfWor07cLOn7HzWKvGnnDe
         9HPVKpLH8hqhe2jXIEM5u56j74aKxmnaosoCieJDTLdkxiYYlspB/xjdV0YTr5mz1szl
         HBk4NrYs5/edWiQqpyBKJ8OAxqlkmm064OWkB04ICbemjO1VvWkbhjakFQbAqJ/vFRbZ
         TcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306837; x=1702911637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiLLniJLE6fb8KiurbJNtdtPhG37u715gDxtCJGRTDg=;
        b=X1nNWg+eeukKzlwaU6jWC72xA4LjVE29ZLYhKJyLix+F6acVKSllDe6kOECHKrAMLT
         N8jDpoudG8lfr9BxYzRXApv73SfjfdmULFtE/aXpjOQ4sjRU3hKyQLUI5CItRG0pIusR
         FIIm8gAS8V8mIV4jGmWJyS177bliBcbv4YyFsJrrw4oBFanXaVqT77eHh8REy5j3hKSk
         eUivT/OI16J9WRYpeWX3nihVMjywFPJugdattn+sEETyrDoBMtPtreIjIwMP5sN9DgO8
         5D1u2lREmeIDPDM/kpk07/WRYen0/pOdAGCOcuvlrRVWyK5EJAHn6sfU5mQb2BqMwdti
         GEfA==
X-Gm-Message-State: AOJu0YxNiyKWOWFgwdNglz4BcUavt+d0ut3IrVJy1vpR56adRPNLpIm4
	nkdy0FQ87lx/KdBZENwi1CotXt579zA=
X-Google-Smtp-Source: AGHT+IHlYBJP5Nf2F7O85cSpxsaha9Ie8x+HeMQr6WJfa66x4c2JsjtXxtMUIUS3rtRk3ZilKR8tag==
X-Received: by 2002:a17:906:e215:b0:a1d:3ecc:8add with SMTP id gf21-20020a170906e21500b00a1d3ecc8addmr2236713ejb.78.1702306836962;
        Mon, 11 Dec 2023 07:00:36 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-173-175.77.1.pool.telefonica.de. [77.1.173.175])
        by smtp.gmail.com with ESMTPSA id vq6-20020a170907a4c600b00a19b7362dcfsm4983559ejc.139.2023.12.11.07.00.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:00:36 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/3] libselinux: update const qualifier of parameters in man pages
Date: Mon, 11 Dec 2023 16:00:29 +0100
Message-ID: <20231211150031.127850-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add missing const qualifier to parameters in the man pages to align them
with <selinux/selinux.h>.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/getexeccon.3          |  4 +--
 libselinux/man/man3/security_compute_av.3 | 32 +++++++++++------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index d6222a4f..9cc24e8c 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -11,9 +11,9 @@ rpm_execcon \- run a helper for rpm in an appropriate security context
 .sp
 .BI "int getexeccon_raw(char **" context );
 .sp
-.BI "int setexeccon(char *" context );
+.BI "int setexeccon(const char *" context );
 .sp
-.BI "int setexeccon_raw(char *" context );
+.BI "int setexeccon_raw(const char *" context );
 .sp
 .BI "int setexecfilecon(const char *" filename ", const char *" fallback_type );
 .sp
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index efa4baf3..6c82eca5 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -7,37 +7,37 @@ the SELinux policy database in the kernel
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int security_compute_av(char *" scon ", char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av(const char *" scon ", const char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_raw(const char *" scon ", const char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_flags(char *" scon ", char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_flags(const char *" scon ", const char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_flags_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_flags_raw(const char *" scon ", const char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_create(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_create(const char *" scon ", const char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_create_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_create_raw(const char *" scon ", const char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_create_name(char *" scon ", char *" tcon ", security_class_t "tclass ", const char *" objname ", char **" newcon );
+.BI "int security_compute_create_name(const char *" scon ", const char *" tcon ", security_class_t "tclass ", const char *" objname ", char **" newcon );
 .sp
-.BI "int security_compute_create_name_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", const char *" objname ", char **" newcon );
+.BI "int security_compute_create_name_raw(const char *" scon ", const char *" tcon ", security_class_t "tclass ", const char *" objname ", char **" newcon );
 .sp
-.BI "int security_compute_relabel(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_relabel(const char *" scon ", const char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_relabel_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_relabel_raw(const char *" scon ", const char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_member(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_member(const char *" scon ", const char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_member_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_member_raw(const char *" scon ", const char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_user(char *" scon ", const char *" username ", char ***" con );
+.BI "int security_compute_user(const char *" scon ", const char *" username ", char ***" con );
 .sp
-.BI "int security_compute_user_raw(char *" scon ", const char *" username ", char ***" con );
+.BI "int security_compute_user_raw(const char *" scon ", const char *" username ", char ***" con );
 .sp
-.BI "int security_validatetrans(char *" scon ", const char *" tcon ", security_class_t "tclass ", char *" newcon );
+.BI "int security_validatetrans(const char *" scon ", const char *" tcon ", security_class_t "tclass ", const char *" newcon );
 .sp
-.BI "int security_validatetrans_raw(char *" scon ", const char *" tcon ", security_class_t "tclass ", char *" newcon );
+.BI "int security_validatetrans_raw(const char *" scon ", const char *" tcon ", security_class_t "tclass ", const char *" newcon );
 .sp
 .BI "int security_get_initial_context(const char *" name ", char **" con );
 .sp
-- 
2.43.0

