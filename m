Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D14A2A75
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263828; cv=none; b=XfwYJ5mPXIzsWFoX+ShepHE9WcJeLQrSvid9Ozj3zYdGh2+9ILces289qsP3grVjyrwcYAAb1sByJvPXeohcZU5C1gwcHK4fdwp758VmZHYJeTTyFhDpPqjXwnnRDd1KNjpkpSql7zmZSRKSkkeea8oAignQt3a/glct4LZnbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263828; c=relaxed/simple;
	bh=TsW+hDowdeUd5ySzUBrhft1EgLZUmB7F4R8F0Sun/lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2LdqGs1zHzXYkGJfX9LbNaFspkRXkVDmk2ej6dWcmAb8yIRdBzUmFS8/iIdRh4NOthwyT8cmoJufY+bOJ+3jfWY5tJRAnlxlmxdrAk/NGaNGvCOwEDU4YETDJudX4MZUS6CUShmjez9/mvup10uCP/YX4gF9hoAE9oKWtiGZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlWHaImu; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlWHaImu"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa8so181931985a.3
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790263826; x=1790868626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQ8qY+5lvHxe94ZOSu3RH8xJ7Xz84v6DMkdFJrGOnH4=;
        b=OlWHaImuvOkfiLxTz9UkuiPiKNNLBgtYNwe1Esjme9NEstSpifrXYcTjdpj7eP1c61
         pX8fb4IaiZ8bua1FMaorGNDue7vrAgChjonEa2srS7+ByxoXj8Rn+tNcWxP+I0oz2a2j
         0I0LPCG2rm74ZE6PSLTt85tA19N5bchLhcvNmUjkwIoetcMZkkjFSN+EMxLNtMT5xTb6
         lgoKExaU49aeGeAdoZeDgfgeujP8XUQhmymxur9MoxnDjMbV60fWqSPEaglEghU4p3jN
         p0+7VByI3RgEOsBrwD/8Odzx3fkJgjf3OR7SLg5lfeboplWBEt18PKWHpsWYeu3o7Xd3
         C4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263826; x=1790868626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQ8qY+5lvHxe94ZOSu3RH8xJ7Xz84v6DMkdFJrGOnH4=;
        b=JA9HeQEK1S9fHpkuz0yN0YH4PHmGo4oVcJPQXGBFY6MQAf+D8dSuRAz5kk03u7UJ2C
         YzrJy/pA2ASd2uDLhhQyWb9vDCPlIIDLN/aO+oq+GZhU6mJAVq2OyXI+bQCdz1Jh8sdR
         rD8Nvbe7HWrdPS2kpNRTpryy6AL+CJ0MCXZw6GjxcTt1usUH/EHCDWDEANIS0Ja/4g5m
         WkOVDx+ma6RLGdN6XIUaQfBRU9M9NCkmCTp8GOKrTUEgVakw5NvUyT1H+cGZ5cnhp7j9
         8VBwbnNl9894t28fL1WESOapCJD+E+4TC7an5Rdi8gUwEJ9Ev7XHfAkSEfKHAhVpWo4I
         jUgg==
X-Gm-Message-State: AFuF++lSJG7fvvN37NYsfpy0l2jNcXzzAmt2JcOdpGdDXRm8EFygmQ6O
	21i1Ri0i3XUmQ88dS7ZwPICCNLIBNZ06ALREYyuuQeeJWd5ovi3nyntbOOXJlw==
X-Gm-Gg: AYBFou1fNMtclVWk91K4DIdDOqO2A7Q35SW2mnsjx1sFOcpg4iDXR/jiMsxvd56oOj3
	/Vg+B8aZ5FyW6tPQFHNyeIptv8gaWdj0q66GdzAkg0ck1D8KccIkL7AEiIA4nJdc+FCufti0ttv
	G+W9yMZo74jrYlhv+2Mm8h6ILh9oxdJipMykEav3Et0UP1yeERauWjm+bKyRbzOFep4/k7akeDY
	S/UM5TnWQOiDbfviOI62lPQ7Q1vPHCZYnEb0ZtaC4YI8lFewIxD8M/+YDAN6ZO5enjaLSrvKXlq
	3oUk+rkOML6cjZMvagLvuLcOlJnJfToIk2DkwnQDoV89g8VcleKBi/wvzhZKhEYMQOlJKM3Ufxn
	Xh9GtSvo3SgfEDDkqHh/wJdSRWhppyXNFZhbUykjzlgvSZrjA7kUfo8TpFHmHyhWOz+oZVZsJfw
	lVW7sZtCY2XISbzVpLtd5OZAeziNdfnmEfjFUgoIblYc6/s+gng+TXitFk1uaIHvn6KgrbAEzwn
	o7Ka34DWhKG7Ak9oZHR421KERyHH+147jK0h4J3v1xwdiOyNr2MH7MPk9SBF//FTRYXbRuuDTjD
	2Q73VQPupw==
X-Received: by 2002:a05:620a:2889:b0:939:6de6:9517 with SMTP id af79cd13be357-93c363c85c7mr320028585a.46.1790263825598;
        Thu, 24 Sep 2026 08:30:25 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2482490bsm486653185a.7.2026.09.24.08.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:30:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Laurent Bigonville <bigon@debian.org>
Subject: [PATCH] python/semanage: document and export the user labeling prefix
Date: Thu, 24 Sep 2026 11:30:09 -0400
Message-ID: <20260924153009.64277-1-stephen.smalley.work@gmail.com>
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
index 50d50bea..c4afa26e 100644
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
+.BR genhomedircon(8)
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

