Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDE1EA7C6
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757291; cv=none; b=n23Ur8v5DJPSU1HzX20+qcl4oPKmssRvep6LsD1Zh0n3nboQWlZmTMA+Om2eTKgblVYfzMkPhv9t+Vzf5VOF9RSr1wADCgi+E9K3LmOxCS/aPv67OT8R93ZGjpVzJluWmVFrGNS2iFusWKd+v5J2067wMg4Thka1h4kHY8H6Bzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757291; c=relaxed/simple;
	bh=o8K7EfoLiKoB8Uii6upi8K+xC8SNWcDEqY7NqrdRcVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXr9o8ILNSSeIsnFudZM34AbwhgbP5aANx4TNewVMK4b5l2+SUNRM0NtFCFEx2FQKSLVB8EIc1jqMCdkVUfiZgt4SUD9YA+57bMt4OHLg3RIqWJs97+jdatDMX3EbFBXzE3e5ib6CciT9gREpGv8QSg9BG0ZzvOHY6mRzlif8Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bupzJX1N; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bupzJX1N"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-791875a9071so48172146d6.1
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759757287; x=1760362087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rhtEn2HyyrM2OQfRCmKiiRl2iwjdup0MYLqU4uGRb8=;
        b=bupzJX1NSeZVoD2TPDWG84j3Cyq5JeS4yindZxvj/cAHUTf0aiNVrw8/ifRJXRMBwT
         Rk3tsjlm6WeanfYPiEYCE0ZUiLR2pNtpfgewgXwnkaTPFxgy75aZvGYYD4lt1jZGiry/
         yeQ5tM7/HpV6J8HuNyOuq/FFbjyGgjgDWBmRkrlr4meZJcluC0jBdn6ueDLrSMcXmbKQ
         G/RbUtO4sScbpR/yJ1QZiWRtrBgJlJuc128ZwgWNsbdJwjHR+GX6Jghzn0UNbCv57goY
         f/oWIJhNqX4i81W/a4xodlI6RmqCt8P53liz4rvUWNgaBLPQ0cxRvnyHJZBCgV9Dwyk8
         07wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759757287; x=1760362087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rhtEn2HyyrM2OQfRCmKiiRl2iwjdup0MYLqU4uGRb8=;
        b=kW3Ru8DBOwU3uoRnRLgo1ymJmxEYTij84ZKO9CuYcJXCyC82O+OTIufMQb5qK2AuGz
         hWLsz4wn8faEPkCYAvHCaAv0u4QNHvz58fq6nT5DWjac5dwoNY2d8TPIX2yTsQ5yeo3G
         EN9PI5MROet/gQpfWR4CG+GPgQBL4ftv4YTsPHaoHIQjDu7UQahPjSUpK+eqX7TZIjOD
         UqV2RrUISfO3npt1FE+iXCxBoAGXxh9t56JtyDTmoU36AlnS/UsMVJt/mTrS8qhsa3gb
         bKT2vwkmxi83ModPPYIiCjvVDEXaH+lKd3Hh8CZNIMn88ZnDVnZlCU6+AVtgkvxPOj2s
         754w==
X-Gm-Message-State: AOJu0YzS7gIw//pxdGUUFu5jzdIOO5WmG1JTQXfnN9f8CYgJJK0jn1bP
	M5Gj22z4dz4RDHJeU+JkmXuP3qrFW44PNer3trUI19ajBW5DdCrLRBCfx4cqZA==
X-Gm-Gg: ASbGncsXH+6EsqRdvPwm5RFuodKBCgSdaLjZyfRqM1FVTeZlHTM45YdX08Sh4SusKfc
	fhpxJAMy69Y/GE2B3j14jfLbiVxoGA1Zlh/ve+ZzX8imH7jw16paKAOMfUYfSVXGFb6t+2ge7YF
	EzsSQaP97RFUcFKT11ZbZUA8Z3uFpSgYQ8p79bTX0/tBAVes1sleY4Ujpwd688cLRElLUtOXn/A
	JhDvxPIUWbyMak0i68k2xrCfkB6j+alCdRz6QU67ypgumxc8OujKSU1jVYIyCgKY11KSJf7yGzU
	SFeld6+WHKKdDmChLlXP/NiiqJx8s7gUpiyKSDIFKORy9r7siJy3r7BZV8PUiEXpmvwq21/hQnM
	+q8xS+gO5o66DGp8IfAp8TcYGG829hjZL3F3XJn0Cf5bHPKuAXJabHxtV8JkMWvCoT3zf+EU0kt
	2SuUgk8Q73kNdiiHlCwyW59jzWvY5CobmWefrtsfSzLh50fOQ=
X-Google-Smtp-Source: AGHT+IFiYEC8Oi4sryNRekrXNaMvyW3AdygOMlB7AwJ4gSltEa7JW7KTGbYmExsXHLzpXNvQG8iUqQ==
X-Received: by 2002:a05:6214:c4b:b0:86b:daa6:49fd with SMTP id 6a1803df08f44-879dc7bcf0dmr162679926d6.22.1759757286919;
        Mon, 06 Oct 2025 06:28:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60df0sm118104746d6.3.2025.10.06.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:28:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v2 1/2] nspawn: add --selinux-namespace option to unshare SELinux namespace
Date: Mon,  6 Oct 2025 09:25:08 -0400
Message-ID: <20251006132508.3430-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC only, this demonstrates how to use the selinux_unshare(3) API
added to libselinux by
https://lore.kernel.org/selinux/20251003191922.5326-2-stephen.smalley.work@gmail.com/
and integrates it into systemd-nspawn to support launching containers
with their own SELinux namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 drops the setting of the SELINUXNS environment variable since systemd
can instead use the new is_selinux_unshared(3) API introduced by the
above libselinux patch.

 src/nspawn/nspawn.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/nspawn/nspawn.c b/src/nspawn/nspawn.c
index ab8746c442..4c5f3eb812 100644
--- a/src/nspawn/nspawn.c
+++ b/src/nspawn/nspawn.c
@@ -148,6 +148,7 @@ static char *arg_machine = NULL;     /* The name used by the host to refer to th
 static char *arg_hostname = NULL;    /* The name the payload sees by default */
 static const char *arg_selinux_context = NULL;
 static const char *arg_selinux_apifs_context = NULL;
+static bool arg_selinux_namespace = false;
 static char *arg_slice = NULL;
 static bool arg_private_network; /* initialized depending on arg_privileged in run() */
 static bool arg_read_only = false;
@@ -437,6 +438,7 @@ static int help(void) {
                "  -L --selinux-apifs-context=SECLABEL\n"
                "                            Set the SELinux security context to be used by\n"
                "                            API/tmpfs file systems in the container\n"
+               "     --selinux-namespace    Unshare SELinux namespace\n"
                "\n%3$sResources:%4$s\n"
                "     --rlimit=NAME=LIMIT    Set a resource limit for the payload\n"
                "     --oom-score-adjust=VALUE\n"
@@ -654,6 +656,7 @@ static int parse_argv(int argc, char *argv[]) {
                 ARG_OVERLAY,
                 ARG_OVERLAY_RO,
                 ARG_INACCESSIBLE,
+                ARG_SELINUX_NAMESPACE,
                 ARG_SHARE_SYSTEM,
                 ARG_REGISTER,
                 ARG_KEEP_UNIT,
@@ -731,6 +734,7 @@ static int parse_argv(int argc, char *argv[]) {
                 { "setenv",                 required_argument, NULL, 'E'                        },
                 { "selinux-context",        required_argument, NULL, 'Z'                        },
                 { "selinux-apifs-context",  required_argument, NULL, 'L'                        },
+                { "selinux-namespace",      no_argument,       NULL, ARG_SELINUX_NAMESPACE      },
                 { "quiet",                  no_argument,       NULL, 'q'                        },
                 { "share-system",           no_argument,       NULL, ARG_SHARE_SYSTEM           }, /* not documented */
                 { "register",               required_argument, NULL, ARG_REGISTER               },
@@ -1005,6 +1009,10 @@ static int parse_argv(int argc, char *argv[]) {
                         arg_selinux_apifs_context = optarg;
                         break;
 
+                case ARG_SELINUX_NAMESPACE:
+                        arg_selinux_namespace = true;
+                        break;
+
                 case ARG_READ_ONLY:
                         arg_read_only = true;
                         arg_settings_mask |= SETTING_READ_ONLY;
@@ -3502,6 +3510,12 @@ static int inner_child(
         if (r < 0)
                 return log_error_errno(r, "Failed to apply resource limit RLIMIT_%s: %m", rlimit_to_string(which_failed));
 
+#if HAVE_SELINUX
+        if (arg_selinux_namespace)
+                if (selinux_unshare() < 0)
+                        return log_error_errno(errno, "selinux_unshare() failed: %m");
+#endif
+
 #if HAVE_SECCOMP
         if (arg_seccomp) {
 
-- 
2.51.0

