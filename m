Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139D403E96
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646507; cv=none; b=R+NcgiUBANXj2PIzcZMZat/Fs/pLfGnq5GSPSz8TX/VcvzX8sSVCSzQo3PKV2H+6JVFhDOSKO9hoPNdXe2iQIGLuJK8YXOIHr5xv8mlZLmtgGcCFLIf8wDyFjnHCkD6m4C/xfV3Xc0FJTy4vrFcuarlLWa0wJcFDeZiXDwK3MEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646507; c=relaxed/simple;
	bh=lLFK64aB4RGY0mNy+0w+0lw6g8kjpZDTW9Qw++1ulQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqATmcx4IWLJd+MZM4tV2R3av2Q4Q3j730euWM3KSGOfssT19VxnX7TFxdy4HUAvoxdoS5JIEgJ1C0wY/XgMbfZK2AO6FKFDjD1PCQ9RZ1Y16idZmIQAcuJaPVEdtsy1mRxMcVVDUpSepgNu+FYuz+LcuSlB+SLLujJePFlz8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A57EwNQU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A57EwNQU"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52d7ef16f91so1575191cf.3
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 11:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646504; x=1787251304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3BNCsF24Iep4byXrJgZXjJBZ+Pt7pMHIvq+AmksIkeA=;
        b=A57EwNQU7DU6EOf45b3TEFuqcE2cTzFCimCWXs4v0tLYmf7l+vUqAIrFrNmUapEbqf
         toEEkmDaEHJP7geGRvwwt/RZaonLGy4j/Zvyo6ejbrVD8XJcTXamU52H+3YaAqfGuS17
         4nERtioPFvCZWO4PlPXQDMjwsQy5Lgzca7jjMyrbK/Kkxy5XHeX2qaqaCYIcuaSRZAvH
         Bh1r3KsgNYI7KMt4/+qXewYYTaxTJB9H8zIFWi3aQks0yHL99HhZ+VJ/l6AO4a3fndgo
         LVjDptU2VmMnBQZzqBo5cKkTQkf0yJpiEJWkKPT5zyNWeK26+NwNJ7gub/Ha4gGqnqC7
         x8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646504; x=1787251304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BNCsF24Iep4byXrJgZXjJBZ+Pt7pMHIvq+AmksIkeA=;
        b=Ibw+B9gu3f//aj7uL8/fC4bJ4ny3M7WobcRvMNAdBRKjh2NCKAP3+kTPAGluc451hF
         4X6cTPTv71ZyYy9O9vgMcXbJdNrUCpOoxC4D/MGinewrvuc/5FRw1uoFXhzuWM3eug9D
         YgH9f77oFUB/x2rZCWb2QxAz/+Kmjk5vlKqq6T38vsvmSMXoizXLIchXjCGprKSQMHzC
         jeeJCH93LDrSwfbFJn+PBlOS1zTzqBVCpR9rzuR6v3nmMZlLPRZKbmJEcmOOT68JCgCz
         DN7J7lX3qC0KCrnVFr2zkFRoxIx5qdGvKxs98HKlBzOtB1gVoGMK40dcLV8NPMhs/XdH
         EfPw==
X-Gm-Message-State: AOJu0YzBM7c6lWeiJ3XfydXsQAqyUsxZoOLEMnaOd6kX88Xxt0J0OVE4
	LwE3P2aGYerLvCPHzpX2UOMx4RFz2kxzWEU2mJJLR5BBkU+Zgv3cpekLc1zHaQ==
X-Gm-Gg: AR+sD108CsbTmficu0cwMyaoHWdnr+v/QWxWR6Alcu2trZtIwbW+YtiaPOVj/fk0M5E
	glWdvhEyrcGLJ+HZthuCxPY74g4zR+YpHBC0rsMXziSC5Xt9b7Yxx7jDaGkvKVtEqK9j9yl3PMa
	Jt5hNkadqccyPNHMaerPeTliCYVGCkJpJuSvQwqY05q7gGxndtVBjef1lpTnY9AsNW7FVhGKshe
	in2u5tRGlfBUnBluTT+JE6Yfoui1vy7dHw7NfplNNLf51KuQxzlkXouBXs5Ks4c6Hoz7Z6Xh35R
	ALcISLdtuG68q98QYVz6y5iDNyAp88gNqqNW79zEtbHd/CyXUaDhOYFqGjP93/wOlV6yDOzWb9I
	kT7xWRFbq7XZGsiuCqpNkISTgt67JvrSlNcWfaw3z/Y6ToqsuiDcHOwFXXKSLllUz/Sme7uymZQ
	Zs0JIkgCcUume38J3M09dbtKh10indciAw3/UGHYlkrp2hKCP37PtPcTY9+sO1u97JeqX0wHmpM
	J5XAPzOhEq8FFP99VpBj8TJvWYYlAWgv1d/XdiStKLCtQ+K4MYTeLiLWqyLmBGK
X-Received: by 2002:ac8:5949:0:b0:516:e0eb:d7d with SMTP id d75a77b69052e-52d85439fc5mr143611cf.27.1786646504180;
        Thu, 13 Aug 2026 11:41:44 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d83ece7e8sm2535931cf.2.2026.08.13.11.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:41:43 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/sepolicy: add missing socket template attributes
Date: Thu, 13 Aug 2026 14:41:29 -0400
Message-ID: <20260813184129.186476-1-stephen.smalley.work@gmail.com>
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
index e26f5e2a..1504dabd 100644
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
 
+fc_sock_file = fc_file
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

