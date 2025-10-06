Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254892D47E8
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761179; cv=none; b=lFuv7Gp/6Yk3HSoG+NVZpJqMlTdv/e7nd3PDdyfXKbSFzFkGC0Bc72qP78p0NKy96ZUMcMPeF3jrDHJBndUaKaQMAr84qAQSRqCa1Po0fhjKIkUfYewVP4E7tUmKkdKTBR7fUACK30lwpgkKwiDwOy903oKAPQyyIBUU+WkGYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761179; c=relaxed/simple;
	bh=egw5/xO0WmT5Wh4XvKWn0uyDdCLUfUmTSvUQUsaL0oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fgdx9Szk+5OPnOuT5HN41f+POUtgw19PeOny4R8TmAZL+vyCsO2JINhaZvdn2ibL9/OCwSe5JjBZWkSKVNBxEkLhwPOttuxTsr++BmVFWt0jRLosKHioXWOTA687G+r1ZGr3bpO91Z8wvmQA/BrLtyncGFmrucSvQArQQn3gDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuRb0uG1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuRb0uG1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-859b2ec0556so520765185a.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759761177; x=1760365977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/Xyd7g8R0YgMw9strMFejNyynaskKPredzIy0tJZNw=;
        b=YuRb0uG1/XVO+F8vf3PktbJs/FobDD7OMS9dmi/AHGnKgFKQ08rVjoTIQeAaDjNJ+P
         ssgkIL2oWxEjm5NLsrWOPlee7BSIdXUc2TcPU+fdiFyml+UwLdIWE17BwsjzEkl0YXLA
         vHyNKPCKDV+9lzSY80iwsyX4DsUSU161jMpHqKN+8DUEArMAVCVkSuV+gN3x/3H8jn0t
         tDx1JwQrhoMIld9KQISOxXVbm5Vuw4vy05DxRfqO1yOZmJevL6uVt8bwg73xfssX5nsp
         RE6F7kJagUjeNMdBA+B8xABmALEO1YncWPO1d96nL5mA6HObvlFdOmDVUu29yyQWwVOM
         vQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761177; x=1760365977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/Xyd7g8R0YgMw9strMFejNyynaskKPredzIy0tJZNw=;
        b=FhtD9OiB5xqIoaUhYTc5eYVmARtQCqCcvBKA2DsuykDjz//TwWgCVfV0tcxp3bpJRJ
         mvEJk45AqR/dquQN4PTHf9nenNId7YJ4+gMPyhbGHmfrI7EekRpRQVNC8ygPZIxsDt3c
         7Y0x7fsvJKjMrmsdfwB9iMAUruyb7Y1yk7z6LB6GEKP9LLE69CKxyFnz6QgsSFdPiBMo
         bhG8Yp2FC96/vjNiXurzThXxgeviH8o7PyOtqYdVU3/sUOTgMp9EBVhYSO6sTh6cRajp
         nST92JloNr6m0PFPTvZCTNnk/UMsVwcU7KOLNLfCv+1f7YJuo8obKqNR9tgtnjacaQ0P
         n7Rw==
X-Gm-Message-State: AOJu0YzV8HgGademtzP1FSVzo4WSqWGpch8lKSyWdHW5uV5QcHrkBG4K
	V9h2+G/OPdhm/aF3kZqC8fgW/HKPSCzmC0nncgYu67m9vOMeCiGN8PFtF8rQDQ==
X-Gm-Gg: ASbGncudraWciAoQBiG5w+B8JmFLd6kpA/susx9gPpU0qDI2U7cSP7yeS+w416y07lq
	oaAiviFOPkAGXiBkBKfQQjLWmJyAdtn0tdXR32RLPbb4bImpQI2l54J+CiTci7o+uZHH5QnUymu
	J2lfScD6t8MS+XWfsbHHip2Qxr+bdWbG31Tr3uxnu/1elxD4yLH+SArza1VSgKR1ojVISMbx6TV
	bieNQ+GKoXhv7U4IisWBLDSvxadPpIcTXI8WXndpI9wK8NVjlXMTN4no/zkCjtj/Sw1tP279NBE
	ozkvW2uCsENzF+PQ9wqNVH5vXiR9XWkgQTVetI3ORKKY2ApBMGoxV+b47H0azEyK1HhMDd0ImjG
	UbxOlfYqKA/9GepMJ2Pj6CZY++rxmYtc/6WX+KgXO6oeAhg8D9dvtauVUEPmWDnGjMbzv45pRPj
	vlc7ldQiVKrhjJr8LCVjyRRjzY5gd1fza7+7HXq+8RWbcLfX77Ei0guvWjhA==
X-Google-Smtp-Source: AGHT+IGSpy/AgAiznBu4fHcrTLtK67tSXHbHJKp0VhJNWSu1cogffU8+/V0MdQKNsOFxe8fnUOO8Rw==
X-Received: by 2002:ad4:5d6f:0:b0:7e7:8c87:9e0e with SMTP id 6a1803df08f44-879dc83440emr155128196d6.42.1759761176506;
        Mon, 06 Oct 2025 07:32:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fc21sm118975926d6.63.2025.10.06.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:32:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v3 1/2] nspawn: add --selinux-namespace option to unshare SELinux namespace
Date: Mon,  6 Oct 2025 10:30:52 -0400
Message-ID: <20251006143052.271761-2-stephen.smalley.work@gmail.com>
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
v3 reverts to setting and checking the SELINUXNS environment variable
for detection of whether the SELinux namespace was unshared since
systemd-nspawn sets seccomp filters that do not allow-list the
lsm_get_self_attr(2) system call.

 src/nspawn/nspawn.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/nspawn/nspawn.c b/src/nspawn/nspawn.c
index ab8746c442..22a5070cc6 100644
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
@@ -3323,6 +3331,7 @@ static int inner_child(
                 NULL, /* NOTIFY_SOCKET */
                 NULL, /* CREDENTIALS_DIRECTORY */
                 NULL, /* LANG */
+                NULL, /* SELINUXNS */
                 NULL
         };
         const char *exec_target;
@@ -3502,6 +3511,12 @@ static int inner_child(
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
 
@@ -3611,6 +3626,15 @@ static int inner_child(
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

