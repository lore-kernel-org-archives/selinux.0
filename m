Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2F30FF08
	for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284571; cv=none; b=uzxRbbKw5T5/0s6p6jswpxcfxRBs+/vy7/FyxIryaHHztqAnMOOb8cZhbtcRECtKn+5XnQtH34IG+jw/uatfr8NBHJzOikeqWbsV1xonKNxLMFbs0ZRCEy1rIPTDm8/DcPDH9xnL787y26Qm7ziRGMrG+HrAOjui4NNnlG+PF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284571; c=relaxed/simple;
	bh=wjGMWwlhXiB9mZXUBTPAiLMbumcGnHgRtPlHqGMtXHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpBqNVcH2TqhAMnrNNMTf1dRNwOMxc9xsynUE0iYqtMTWThjX4lNvnnjk6n8YIDtzwx/H1k/MfLfY0cHefi6IdTOP3lfNOaGIlLc0kRwuJCuReEfMv5G3ubJeI8LdObbLwN6OkzLl7w1zw4Jfrc9+wR3i3TPHx3vOe/RTfxGKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDhSmYj+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDhSmYj+"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-76b8fd4ba2cso18490116d6.3
        for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 05:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758284568; x=1758889368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGvxmx0w8pB6/hawwMQJPtqqj3z96xP9Vc5Q1o2Xbkk=;
        b=JDhSmYj+GkKyNwgNYi/emzLpnS3ElJMLjFspIRBy2PbHwMSLZgcozlk16Ks9JCjWwb
         BuIOj/9zDe4CKphpTDv7yr7LtgC1F6KT4Kvwu97NEQ4gPqhAffQLgkIKfTqbJTXSmgT6
         O5PzGazN2xRYlvpYavvpzQcwa75mLhEPsi8rV3rLhP201l/m87etkaS9/h7QzF6g5f5e
         QIUKHOKa796igGxrqz4hGDOvgdunQoOZygU4GRqpjM9Z5Cb8HEs0cxGLB/y6ykC0F4lF
         fuq/+YB99HwIxmlbl3NsyEom1BWhoeBGJluml6pJVO9NpozRE0tSfugQtsyCfypXaALL
         o4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284568; x=1758889368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGvxmx0w8pB6/hawwMQJPtqqj3z96xP9Vc5Q1o2Xbkk=;
        b=PqFLafTN2m7tqZV2UdiYnxR/9qgozRB4JIVJFIkIpwVv2+CHYLn1Ij100rtFwuH9VZ
         Zq79rqM09h9zebny5gwn3hTCsza/7MEalMfEc2tqZIUEnhOpuA4XCPQbx0Yk1wo0YDjH
         jT70lYllIYOWrZD0mee0nLv6mkixgG1KudFQuRo/W/ArggarDIM9Y7WFyULTYvD5NW8A
         neXasMGT4l2nSYZG3zvPZfvVwbT1daONOdUgOJF2XI2ag18gU7uZAKLAUqhg2oi3RfSG
         TVlYB9zdJGRYjeTdKH74X2JcSAQH5IqIAnmA/PKH17oYITjh+cnoVOz6U3WdwjCzvLWw
         fIjA==
X-Gm-Message-State: AOJu0YzvXRGmVqy1EyoGR5MLzMiq7veaYMwGkODdEu2rtLDHNfhwW3kg
	eK6on+WyK1OUgEun8KZxwU4xHqo0+CuwHQgRX+ZY7Z5ex0roKgXEyjh8HW6DAw==
X-Gm-Gg: ASbGncvyCZKdXzwAWPC3XZUwHB5DulT1PNZPgbO3pOBkHE/vyFfOtZDAFA/8PgIby4G
	hHLT0Iudyf7BI8X8El1OYsKGhAnsRj1sESOxH7zPwwWr+ZoUvgPBAX6Etzdmv7ACaz6w8xvh6rP
	ovyTqENL3l9bQ2ycEwknFMdoCgL+NdvyvDNLpleW0RRCBwWIo8qnNdWI32qBCoaH4E4pP7pFaF2
	3/fUaj6PuTlcEr60ezX4i3kuePVKj2+OYYdJTr6YbM2R6y/aJmQ2S0t4p7K9kysfev2i7vs1+Wn
	PBAPspHG1+bo6DWhq0u6xo7MYF6XTQeq7nEb6+fVgSfkyjAkDkW/1UfuWKOwH4sy8A12OCXswVf
	wUOOkQggTF1q3VYZUeKsK3+ydPILS0W85VHMMZn7yQk52jZWdo+l89m4flp2PTWEdmenK2aLxF2
	dOlyr+uTHA2yBtnf2ITQR5C5JiZjcG+i1BNmi8hbglzqr9HP7zan8=
X-Google-Smtp-Source: AGHT+IFXgUCcVgsEUDtCgajhIJE3WHXrmRiOBB/Rx0HbZ3YagO38Kc6c8XCSEQNhd7FYT+jVK+U29g==
X-Received: by 2002:a05:6214:20a1:b0:78a:992a:951e with SMTP id 6a1803df08f44-799100324femr32412286d6.6.1758284567583;
        Fri, 19 Sep 2025 05:22:47 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793546dd333sm28205366d6.56.2025.09.19.05.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:22:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 1/2] nspawn: add --selinux-namespace option to unshare SELinux namespace
Date: Fri, 19 Sep 2025 08:21:00 -0400
Message-ID: <20250919122100.181107-2-stephen.smalley.work@gmail.com>
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
https://lore.kernel.org/selinux/20250918135118.9896-2-stephen.smalley.work@gmail.com/

and integrates it into systemd-nspawn to support launching containers
with their own SELinux namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 src/nspawn/nspawn.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/nspawn/nspawn.c b/src/nspawn/nspawn.c
index 2dcab7d379..9c4bcb7688 100644
--- a/src/nspawn/nspawn.c
+++ b/src/nspawn/nspawn.c
@@ -138,6 +138,7 @@ static char *arg_machine = NULL;     /* The name used by the host to refer to th
 static char *arg_hostname = NULL;    /* The name the payload sees by default */
 static const char *arg_selinux_context = NULL;
 static const char *arg_selinux_apifs_context = NULL;
+static bool arg_selinux_namespace = false;
 static char *arg_slice = NULL;
 static bool arg_private_network; /* initialized depending on arg_privileged in run() */
 static bool arg_read_only = false;
@@ -422,6 +423,7 @@ static int help(void) {
                "  -L --selinux-apifs-context=SECLABEL\n"
                "                            Set the SELinux security context to be used by\n"
                "                            API/tmpfs file systems in the container\n"
+               "     --selinux-namespace    Unshare SELinux namespace\n"
                "\n%3$sResources:%4$s\n"
                "     --rlimit=NAME=LIMIT    Set a resource limit for the payload\n"
                "     --oom-score-adjust=VALUE\n"
@@ -639,6 +641,7 @@ static int parse_argv(int argc, char *argv[]) {
                 ARG_OVERLAY,
                 ARG_OVERLAY_RO,
                 ARG_INACCESSIBLE,
+                ARG_SELINUX_NAMESPACE,
                 ARG_SHARE_SYSTEM,
                 ARG_REGISTER,
                 ARG_KEEP_UNIT,
@@ -714,6 +717,7 @@ static int parse_argv(int argc, char *argv[]) {
                 { "setenv",                 required_argument, NULL, 'E'                        },
                 { "selinux-context",        required_argument, NULL, 'Z'                        },
                 { "selinux-apifs-context",  required_argument, NULL, 'L'                        },
+                { "selinux-namespace",      no_argument,       NULL, ARG_SELINUX_NAMESPACE      },
                 { "quiet",                  no_argument,       NULL, 'q'                        },
                 { "share-system",           no_argument,       NULL, ARG_SHARE_SYSTEM           }, /* not documented */
                 { "register",               required_argument, NULL, ARG_REGISTER               },
@@ -986,6 +990,10 @@ static int parse_argv(int argc, char *argv[]) {
                         arg_selinux_apifs_context = optarg;
                         break;
 
+                case ARG_SELINUX_NAMESPACE:
+                        arg_selinux_namespace = true;
+                        break;
+
                 case ARG_READ_ONLY:
                         arg_read_only = true;
                         arg_settings_mask |= SETTING_READ_ONLY;
@@ -3257,6 +3265,7 @@ static int inner_child(
                 NULL, /* NOTIFY_SOCKET */
                 NULL, /* CREDENTIALS_DIRECTORY */
                 NULL, /* LANG */
+                NULL, /* SELINUXNS */
                 NULL
         };
         const char *exec_target;
@@ -3468,6 +3477,9 @@ static int inner_child(
         if (arg_selinux_context)
                 if (setexeccon(arg_selinux_context) < 0)
                         return log_error_errno(errno, "setexeccon(\"%s\") failed: %m", arg_selinux_context);
+        if (arg_selinux_namespace)
+                if (selinux_unshare() < 0)
+                        return log_error_errno(errno, "selinux_unshare() failed: %m");
 #endif
 
         /* Make sure we keep the caps across the uid/gid dropping, so that we can retain some selected caps
@@ -3545,6 +3557,15 @@ static int inner_child(
                 n_env++;
         }
 
+#if HAVE_SELINUX
+        if (arg_selinux_namespace) {
+                envp[n_env] = strdup("SELINUXNS=1");
+                if (!envp[n_env])
+                        return log_oom();
+                n_env++;
+        }
+#endif
+
         env_use = strv_env_merge(envp, os_release_pairs, arg_setenv);
         if (!env_use)
                 return log_oom();
-- 
2.51.0

