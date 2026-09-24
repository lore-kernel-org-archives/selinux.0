Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539949F136
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265344; cv=none; b=p6lyCLo+/f4u6Z4YxRbvnf/MT46CqhyqrLXIyx/lsfcCLsHlXnKSRZyZzI7+u4pr6FXoOow3ZPGNPLMbDrzG/kJobZXtM6Iy0xA7PkDzqK9jqqdUMb+PSZG04Wwt0i1glA/6KAJiLHjeIL2NvtnK9kpRi13Fn6AHaQl25bov1fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265344; c=relaxed/simple;
	bh=Q5D4yAvuqXHbiKhEa/er96XtBVg+QWLaBcAGSIsbXTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJLQDP37PlJ5MV1Ah7XsmWE77ry3f0QYIg5bgXbPJX+fy4oi4T8h5xRenYT/gezNdcDpG478FO01bcWrfHx1lMzvQJeAXY+36KQFnCO5bSCjgnbDb3lmi6B5u2i5ciIlZviwh7iF5VVVj8DeTLcRQHdf7ppj1YFnecklsv0vX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFWxtrp/; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFWxtrp/"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-532db7db0c6so17796561cf.2
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265342; x=1790870142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qweEPtcKXgRYttqbDy1g92kx8sdhToHOPmTPtEdnZec=;
        b=HFWxtrp/aquHXjdz55oMnvWRbsW9PoyJjLnk6fqOtxO4M0IJCE+wN+ClSeU0PTguC5
         1rcSOFUw9W1Y7CdtCx82AN8IELs7ruBNn5bP1m8QrrhAwbLiE6al/dJOY+9jLQ0auJGy
         r8q0RQJUcKm4GZzCNmStaAVmNsIlWM3+6TzXB4amgsQLp+B4p6Yi4hd80Bh817XC1SKT
         kVEgB8PqScnv8EM6/CkuB+6k7UdZGPLQJ2rcN4Q2htbTSLop2ROmZOYZKve2HgZXD6gL
         JY8W1/zqWRX7fGmrJWi2t4C5HnBwSU1ZikNqWjcRPQe6CMwkuFskVEkVnaKM+u7V8fXq
         oCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265342; x=1790870142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qweEPtcKXgRYttqbDy1g92kx8sdhToHOPmTPtEdnZec=;
        b=0mSydT0WhnYTZnai1TRJsOUcYq+xnMLzXLDJtbyy2kp92gLYBAmO6FbgOwfUEt95CC
         i0t6M9dORaXZNZ3jjZeKaHDKGPix7srlnN1QMb7qdyXyBf+FHA1eJbizFQkQCSo1DAg8
         bCcDCB/IMGlyLVVikIiecWUyvMMup8KgkCyyri4HoahuFdmGpGgWryhxOW4irT7hcyrU
         6/cRSL7kDqnLH8VJqGtsqGp6CysL8IQzN774sDgGwbP2vxdiQENzxgykmoDQV8keL1SC
         PD3hh9QEgBj1djfsFOaYXbHfq9xPExA55IAijbxxf0UrgItLmykslmhxSjHjtfbK9aHS
         UT0g==
X-Gm-Message-State: AFuF++nLtKG5QR1QlhSUHain7O4Z9yp42Gzyv+I3dtKrmkcwtdtozl24
	DrhZvXYQCXQD5l5/Y7wq5d++E3wd5itCedfyjy+RtcuWodZfcsnlpPy58Igj7w==
X-Gm-Gg: AYBFou1ESbSVzDZuaK/WdurKm5AxjvYBp+KzRWOQqW43/QbBTI6qVgj/2hmdfRJwqS/
	mw7OpTgEuRwvYiuRiUoLqOyUF/SEYgEgwN/wUdOsPXv4w9VJRAex6wIzx+TKhYNILFZdfrxeuQB
	Uc2BJ39Zgipqkr0mjiBla3H2DIBljs3ueASNgVDx3/Hrv2oyyo/w0kRfVzX12YjLXmyVCXJcZVs
	Dv4rkbP7bbegZdjeZQkc7bhOhxjWKyriiZ49mdWWlDbstR7C7G7D3ktHhg4Dp54Mb2t3NZ2vKbG
	CVFezL9yKHgV1DDDKLHbdFFEepl4XWQDeC0mcYT/M3u2RssMh5s1Fwc/CfvKtgo7/mneRGfwW2N
	f+MmXxg5fzqlNRvacDOzDS/IcDChuq/ya525V9T2H+G7p4VTmqhwhurwdERRER7o6eYv+Oflj6H
	SajtjMaYHbtddjDcCMrk7I2upv99ul3bKwfag4AuHpcxGQJB9lWRhEGQHtpd2X5KZFJVXIu7RpC
	qiGrMMZouOa6cvh7VovaSOtll6G9Ey23KXXTti9zMruCpQ4bgpgAGOHU26kfQr1I1KFb+T3GivH
	4dIyBc4/NQ==
X-Received: by 2002:a05:622a:4d88:b0:531:d52:a271 with SMTP id d75a77b69052e-532fea87d45mr28279091cf.27.1790265342110;
        Thu, 24 Sep 2026 08:55:42 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eaec166bsm45717541cf.4.2026.09.24.08.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:55:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Laurent Bigonville <bigon@debian.org>
Subject: [PATCH v2] python/semanage: document and export the user labeling prefix
Date: Thu, 24 Sep 2026 11:54:36 -0400
Message-ID: <20260924155435.64444-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semanage user -l has always printed a Labeling / Prefix column and
semanage user -a/-m -P PREFIX has always set it (stored in users_extra
as 'user NAME prefix PREFIX;' and consumed by genhomedircon for the
ROLE template substitution and homedir_role selection), but -P has
been argparse-suppressed and undocumented since the 2013 argparse
conversion, and seluserRecords.customized() does not emit it, so
'semanage export | semanage import' silently resets any non-default
prefix to 'user'.

Give -P a real --help string, document it in semanage-user(8), and
have customized() emit '-P PREFIX' when the stored prefix differs from
the 'user' default so export/import round-trips.

Reported-by: Laurent Bigonville <bigon@debian.org>
Fixes: https://github.com/SELinuxProject/selinux/issues/140
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 adds a space in the man page to prevent bolding (8).

 python/semanage/semanage        |  3 ++-
 python/semanage/semanage-user.8 | 10 +++++++++-
 python/semanage/seobject.py     |  8 +++++---
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 89166269..09bfc806 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -416,7 +416,8 @@ def setupUserParser(subparsers):
     userParser.add_argument('-R', '--roles', default=[],
                             action=CheckRole,
                             help=_("SELinux Roles. You must enclose multiple roles within quotes, separate by spaces. Or specify -R multiple times."))
-    userParser.add_argument('-P', '--prefix', default="user", help=argparse.SUPPRESS)
+    userParser.add_argument('-P', '--prefix', default="user",
+                            help=_("Labeling prefix for the SELinux user, used by genhomedircon when generating home directory labels. Defaults to 'user'."))
     userParser.add_argument('selinux_name', nargs='?', default=None, help=_('selinux_name'))
     userParser.set_defaults(func=handleUser)
 
diff --git a/python/semanage/semanage-user.8 b/python/semanage/semanage-user.8
index 50d50bea..0cb82765 100644
--- a/python/semanage/semanage-user.8
+++ b/python/semanage/semanage-user.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 .B semanage\-user \- SELinux Policy Management SELinux User mapping tool
 .SH "SYNOPSIS"
-.B  semanage user [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE SEUSER) | \-\-delete SEUSER | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE SEUSER ) ]
+.B  semanage user [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE \-P PREFIX SEUSER) | \-\-delete SEUSER | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE \-P PREFIX SEUSER ) ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
@@ -54,6 +54,14 @@ MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login ma
 .TP
 .I   \-R [ROLES], \-\-roles [ROLES]
 SELinux Roles. You must enclose multiple roles within quotes, separate by spaces. Or specify \-R multiple times.
+.TP
+.I   \-P PREFIX, \-\-prefix PREFIX
+Labeling prefix for the SELinux user, stored in
+.I users_extra
+and used by
+.BR genhomedircon (8)
+when generating home directory context entries. Defaults to
+.BR user .
 
 .SH EXAMPLE
 .nf
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index b790597d..a2a16dd6 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1043,10 +1043,12 @@ class seluserRecords(semanageRecords):
         l = []
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
-            if ddict[k][1] or ddict[k][2]:
-                l.append("-a -L %s -r %s -R '%s' %s" % (ddict[k][1], ddict[k][2], ddict[k][3], k))
+            prefix, level, srange, roles = ddict[k]
+            popt = "-P %s " % prefix if prefix and prefix != "user" else ""
+            if level or srange:
+                l.append("-a %s-L %s -r %s -R '%s' %s" % (popt, level, srange, roles, k))
             else:
-                l.append("-a -R '%s' %s" % (ddict[k][3], k))
+                l.append("-a %s-R '%s' %s" % (popt, roles, k))
         return l
 
     def list(self, heading=1, locallist=0):
-- 
2.55.0

