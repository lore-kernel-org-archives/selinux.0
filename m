Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE41470110
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717789; cv=none; b=kfzBB9V3OcMqtWLKqdaEsUftg9NZB+dzn8HjHpEH/Rkcy3pv21tneKdbEWrBT/DVWz9CzeN0xW9KR6ae7fzYRFmB2zDkWt/dl4xYjIU/dL4dAdKK46F4qtY2WWjf2SFBx0XGg6WEkx2XWPIAhiRdJqbLZGIVKmJWsJ8TeZzcYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717789; c=relaxed/simple;
	bh=6yDgkk60axkR8SWnN2j4Q1fcGuQYHI/PYmKmrD6gMog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q78E1nqzIsQiQzdWTOumXWRf32TJzSyrjguGlnQvJbNEZxCgVtnzG6fKQPtPGe5DObckMsTclKwrB3z/sVaKrPlQHTew6nUuo2+cwdAy+Itnj6XTCnLNIBSbAqOHYnImc9ZrMaI/vVNwGC3rmZLNqli1i9QNLIWiPjZEkOQhZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p52Qg3nr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p52Qg3nr"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c8e2e39easo11186561cf.0
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786717777; x=1787322577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JXYBgawKiPPjzkjj2zYmAx4gtpRo1Yt8Vinl8jFVvo=;
        b=p52Qg3nryipJd11wO1xrYnaGPUdiz7D1Kn4ZsrULrdRFNsv72cvS0LH4/Ii3bqWawL
         uC5V44N7f8/tp/PaBypBNDSoTDS7urOtAgmsHdr9z8o7d1oMGqbnyUSLDAC4C6bgcemC
         HRLtMsRgGEgdwvZKyT7NaRsCZyYCOsD3+Ru49B2HtvLg0WPLKwcB1LX3PIxrizo1EH2A
         g8Vq4D3m4r+6hQwFCinLPl2YPI9Qgk/hkyvOTmjRNSRY8nQX3EzqoOUZFRJbkRlsp8WZ
         ZP6FT301pDyHdipFt49MBLNNWky+M3tvLcYRgpNfgwFt1HXUXsOH5jJnmzxWaygHrrc3
         Ip8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717777; x=1787322577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JXYBgawKiPPjzkjj2zYmAx4gtpRo1Yt8Vinl8jFVvo=;
        b=cyFUTjhPO1IFufu3QhNVKmz9w0lXcpFQAjZeQZpIfrBXfSR6kf9Msd5fHwSZVJjHcw
         LS1+WbMsUPa7GhcxaPpkT6F7AfFzxvsAlkEAHo0JQN3CJUuWfYDmuVkVaKboOgcxoy9P
         Ck91DB1nTFQoJwprOdSxcIxRurT8dqe2DFGlDca8bX2uSE2kdsxv+3gj/6Fsk+R1WvLg
         6qKu6tTAZUVx9lnV7c/esF0aZMMHlX61q/Ulfh/RmyhQGbN7KC8rmMVf1N527fZSO99Z
         D2Ajj5I9QugwcNpuMArOVlvJPNhVQAxAhghDmzP+fpnJRaQHXQMq8LzMnfsJg/ae5TT9
         sr8Q==
X-Gm-Message-State: AOJu0YxjhtB7C+WzdRHjsLCfFxYBUdfEHjMwGzLzpw2AG7vvTDqOsqYv
	zTYzUNma+JKj/tN4Udul3vp9C/J78K6pgCId2q7QZ7wJA151wqtERLlRWQ6cyQ==
X-Gm-Gg: AR+sD11WUj8W9edRjzyd58qz3/eSNesrsgCmZ0izW3FiBk9iPk5S6iMBhYXxPto2teR
	WMP06PomdguId252Z82eXAIK+416gp7vzAJnMlVQE+LVhrLL57gbiJIeliOz1kn7W+EGahAFUL2
	qpRebT6E3ebu7qpHOBC1y+Y+L6PqKIHjKv05U0pIdBgXCeruxAQyNoWXFafBRm1PtCl3GZS8/wM
	7sOrNwfSRA8u1RuYyDGjoVx582sFqwuCumxdjCiyFjApw120hhqchaF2/OKbkDUEweX9BgLncLI
	Y7pSaYD6QVb1js4PDvijrD/1oUbojnlAAT06/6Yp2YB6OA6jiSsewaLNRPv+S+lVnorFK8leJcl
	4Wzasm5IZXFRROBZs1EO4LkPiS9RXNi/mdASfnP98Qn+H8RFCZ7tjf+6+QtfVKs4LqRI93JjCPn
	RkMxcWxgSDa6fLVEgDxJATxIW1id2hDnqPY+da7V8F/kc1EBydveTvIPLasCvExA8dHaOoClKFu
	qQ4E/d256VV/3q2CMyPtLktsAxNZIOx8JKx6aRnunpVLDx43bQ7QPTeY7xA+faQ
X-Received: by 2002:a05:622a:588e:b0:517:5add:e449 with SMTP id d75a77b69052e-52d854c1fa7mr73326901cf.22.1786717776908;
        Fri, 14 Aug 2026 07:29:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d83ece848sm22060671cf.3.2026.08.14.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:29:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] python/sepolicy: add missing socket template attributes
Date: Fri, 14 Aug 2026 10:27:19 -0400
Message-ID: <20260814142717.204397-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generate_fc() unconditionally reads template.fc_sock_file for any
path that stat()s as a socket, but only var_run, var_lib and rw
define it, so selecting a socket under /tmp, /etc, /var/cache,
/var/spool, /var/log or a systemd unit directory in the GUI raises

  AttributeError: module 'sepolicy.templates.tmp' has no
  attribute 'fc_sock_file'

The tmp template has no fc_* attributes at all, so any explicitly
added file or directory under /tmp fails the same way on fc_file /
fc_dir.  generate_te() and generate_if() likewise read
te_stream_rules / if_stream_rules for a socket path, which var_log
and unit_file lack.

Add fc_sock_file to every template that already has fc_file (using
the -s file class), give tmp a full fc_file / fc_sock_file / fc_dir
set for TEMPLATETYPE_tmp_t, and add empty stream-rule strings to
var_log and unit_file so a stray socket there no longer takes the
whole generator down.

Fixes: https://github.com/SELinuxProject/selinux/issues/379
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 changes the fc_sock_file definition in the
unit_file template to the empty string since there shouldn't
be any sockets with those types.

 python/sepolicy/sepolicy/templates/etc_rw.py    |  4 ++++
 python/sepolicy/sepolicy/templates/tmp.py       | 13 +++++++++++++
 python/sepolicy/sepolicy/templates/unit_file.py |  6 ++++++
 python/sepolicy/sepolicy/templates/var_cache.py |  4 ++++
 python/sepolicy/sepolicy/templates/var_log.py   |  8 ++++++++
 python/sepolicy/sepolicy/templates/var_spool.py |  4 ++++
 6 files changed, 39 insertions(+)

diff --git a/python/sepolicy/sepolicy/templates/etc_rw.py b/python/sepolicy/sepolicy/templates/etc_rw.py
index dcf445e0..c78d64a2 100644
--- a/python/sepolicy/sepolicy/templates/etc_rw.py
+++ b/python/sepolicy/sepolicy/templates/etc_rw.py
@@ -134,6 +134,10 @@ fc_file="""\
 FILENAME		--	gen_context(system_u:object_r:TEMPLATETYPE_etc_rw_t,s0)
 """
 
+fc_sock_file="""\
+FILENAME		-s	gen_context(system_u:object_r:TEMPLATETYPE_etc_rw_t,s0)
+"""
+
 fc_dir="""\
 FILENAME(/.*)?		gen_context(system_u:object_r:TEMPLATETYPE_etc_rw_t,s0)
 """
diff --git a/python/sepolicy/sepolicy/templates/tmp.py b/python/sepolicy/sepolicy/templates/tmp.py
index c000a75e..54ed1803 100644
--- a/python/sepolicy/sepolicy/templates/tmp.py
+++ b/python/sepolicy/sepolicy/templates/tmp.py
@@ -127,3 +127,16 @@ if_admin_rules="""
 	files_search_tmp($1)
 	admin_pattern($1, TEMPLATETYPE_tmp_t)
 """
+
+########################### File Context ##################################
+fc_file="""\
+FILENAME		--	gen_context(system_u:object_r:TEMPLATETYPE_tmp_t,s0)
+"""
+
+fc_sock_file="""\
+FILENAME		-s	gen_context(system_u:object_r:TEMPLATETYPE_tmp_t,s0)
+"""
+
+fc_dir="""\
+FILENAME(/.*)?		gen_context(system_u:object_r:TEMPLATETYPE_tmp_t,s0)
+"""
diff --git a/python/sepolicy/sepolicy/templates/unit_file.py b/python/sepolicy/sepolicy/templates/unit_file.py
index e26f5e2a..6d72dcd3 100644
--- a/python/sepolicy/sepolicy/templates/unit_file.py
+++ b/python/sepolicy/sepolicy/templates/unit_file.py
@@ -66,9 +66,15 @@ if_admin_rules="""
 	allow $1 TEMPLATETYPE_unit_file_t:service all_service_perms;
 """
 
+te_stream_rules = ""
+
+if_stream_rules = ""
+
 ########################### File Context ##################################
 fc_file="""\
 FILENAME		--	gen_context(system_u:object_r:TEMPLATETYPE_unit_file_t,s0)
 """
 
+fc_sock_file = ""
+
 fc_dir=""
diff --git a/python/sepolicy/sepolicy/templates/var_cache.py b/python/sepolicy/sepolicy/templates/var_cache.py
index 37897231..5a147896 100644
--- a/python/sepolicy/sepolicy/templates/var_cache.py
+++ b/python/sepolicy/sepolicy/templates/var_cache.py
@@ -152,6 +152,10 @@ fc_file="""\
 FILENAME		--	gen_context(system_u:object_r:TEMPLATETYPE_cache_t,s0)
 """
 
+fc_sock_file="""\
+FILENAME		-s	gen_context(system_u:object_r:TEMPLATETYPE_cache_t,s0)
+"""
+
 fc_dir="""\
 FILENAME(/.*)?		gen_context(system_u:object_r:TEMPLATETYPE_cache_t,s0)
 """
diff --git a/python/sepolicy/sepolicy/templates/var_log.py b/python/sepolicy/sepolicy/templates/var_log.py
index 371dd7e4..051a0f1e 100644
--- a/python/sepolicy/sepolicy/templates/var_log.py
+++ b/python/sepolicy/sepolicy/templates/var_log.py
@@ -106,10 +106,18 @@ if_admin_rules="""
 """
 
 ########################### File Context ##################################
+te_stream_rules = ""
+
+if_stream_rules = ""
+
 fc_file="""\
 FILENAME		--	gen_context(system_u:object_r:TEMPLATETYPE_log_t,s0)
 """
 
+fc_sock_file="""\
+FILENAME		-s	gen_context(system_u:object_r:TEMPLATETYPE_log_t,s0)
+"""
+
 fc_dir="""\
 FILENAME(/.*)?		gen_context(system_u:object_r:TEMPLATETYPE_log_t,s0)
 """
diff --git a/python/sepolicy/sepolicy/templates/var_spool.py b/python/sepolicy/sepolicy/templates/var_spool.py
index dccb5f16..84933f50 100644
--- a/python/sepolicy/sepolicy/templates/var_spool.py
+++ b/python/sepolicy/sepolicy/templates/var_spool.py
@@ -151,6 +151,10 @@ fc_file="""\
 FILENAME		--	gen_context(system_u:object_r:TEMPLATETYPE_spool_t,s0)
 """
 
+fc_sock_file="""\
+FILENAME		-s	gen_context(system_u:object_r:TEMPLATETYPE_spool_t,s0)
+"""
+
 fc_dir="""\
 FILENAME(/.*)?		gen_context(system_u:object_r:TEMPLATETYPE_spool_t,s0)
 """
-- 
2.55.0

