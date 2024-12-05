Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB181D0DEC
	for <selinux@vger.kernel.org>; Thu,  5 Dec 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388810; cv=none; b=ghP37AhAvklu3wG5jr8ZpqDKaZ1Yz2tZKwwpSgP9KFduAhETq4PP5epo0UefqrYSfgNsKxyclrA479JDUF6uRu+LPLA80Kea94GotLrZTSfucPTtXXXWVad8tjH/dKVDaE+c3w0nD1yCHv4VoSHULdDtX0An1acPg1m7WrulDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388810; c=relaxed/simple;
	bh=5seNRPtQPYizUzL8Ff+RqINT5ml3+2sd/JTLG7b9np8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F7ToME+7rliTstVZSYfOY5AAJQ8/lF1F98RYq0rugeHwTbwXCmVJ0QWNhzbu7w4fKl9Si1pb6Yy5FBLYIvZ1Ow0qNwejtlbrT8uzMOOxS0fJm67CbSLRX3SmuVO5DxK05JwdJdH3VzTznuhdw62MTa9Igeg1sQf/S0hMN5wHimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ENeDhAun; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENeDhAun"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so604022e87.3
        for <selinux@vger.kernel.org>; Thu, 05 Dec 2024 00:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733388806; x=1733993606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mHsrvq+mjk1DOofbb56eKBkfsZAOUG7NEPelJMCd78M=;
        b=ENeDhAun2K0PjV78Zga9db6EXpVjUYsEwapvW9/vSWfg//LLVJpWVE+zu0rURwsNnF
         fW1q5VWsn0XHK+NO0R9j7GTxumtdYA+gSuIF1RnuM1ZrUj9nf8FAV1CqPNKAdIKmJij4
         UpNFaG4ucZlXTOxY6/bXMBKPpESL4AxRQ2qos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388806; x=1733993606;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHsrvq+mjk1DOofbb56eKBkfsZAOUG7NEPelJMCd78M=;
        b=DqTjmTLe/A0q6QCt/KDPAahdTRStDKUBGwyhBOtRpE0jIRO2JfIdJ0NS0bulOX2Jl3
         0CIqJJo6qwb7+u7GlpUeTJLlHPbGdxdJ2jyHxTbBhpeyRnpLx+DcUvGLRdyrt4+c61Ex
         b914oXfT4IqAYre/gLI/NK+oRzY1PPKWRgD72EKeinhnpBRTlyAaf5DT60Tt65dRvyg/
         kv+wd7DRWGC/o8CeExO/c0TqYaGENB9BAqDd06FNjUH7Kw6FZaqbdbWpsMQOHOoGdASX
         qzMMA6Ifne29t+OaT5BZetieBccS8K+TkaG6py+bOQocyGof4SC4kKD8e15zRgBx9pMN
         KWBw==
X-Gm-Message-State: AOJu0YxxK0lPJeD/GessoOqBd7MHTMfwoa+1svcYk5oHA32eTm+d36lM
	EhkGeFJsaThNjOlgoE85iiCBuznB/tLEmGiV/LprNg4R3wQXxsP9zLwrGdv3eGsb8JGzSos0KKu
	Yiv+i0aMDDHFYi7GIXliZ+Q+LMwpShOCBE0FlCxTkNkKxeQKa
X-Gm-Gg: ASbGncsHZy64mSspzVRdZs+yX1ykbmxc6O+Tc0SdeF417Qk1d6Q/FNWRX982W2VA9vN
	9YhO2dYb8C1D2WoG0LuTL7StYohuLURlmvBo7mITMdO/s1l+2UIpdgmNbaA==
X-Google-Smtp-Source: AGHT+IG8y8IDJ4sRCCh4nxFeaeAwjB8/W1uEs06d5eN0lYQyY0p4xbtVyOgmkrRLX5g097MWLjek/DI/paoC1wlpFwU=
X-Received: by 2002:a05:6512:128b:b0:539:8a9a:4e63 with SMTP id
 2adb3069b0e04-53e12a21812mr4445912e87.42.1733388806480; Thu, 05 Dec 2024
 00:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takaya Saeki <takayas@chromium.org>
Date: Thu, 5 Dec 2024 17:53:14 +0900
Message-ID: <CAH9xa6dmxzcooYYya5kH=KwfhhKUJSq9LYVKiwxj1sxsDB3h-w@mail.gmail.com>
Subject: [RFC] genfscon wildcard support for faster sysfs labeling
To: selinux@vger.kernel.org
Cc: tweek@google.com, nnk@google.com, jeffv@google.com, 
	Junichi Uekawa <uekawa@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hello SELinux developers,

I propose wildcard match support in genfscon to improve sysfs labeling
performance, and I would like to hear your opinions on it.

Currently, labeling numerous dynamic sysfs entries (e.g.,
`/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`)
requires either listing all specific PCI paths in genfscon entries,
which are hard to maintain, or using slow regex rules in file_contexts
with restorecon. On our test device, `restorecon -R /sys` takes 2.7
seconds with regular expression rules.

Wildcard matching offers a good balance here. The patch below allows us
to avoid the slowdowns of regex while keeping genfscon maintainable for
diverse hardware.

This requires defining precedence when multiple wildcards match. I
suggest prioritizing longer matches, which is the existing behavior. For
example, given the rules `/sys/devices/*/wakeup` and
`/sys/devices/*/wakeup/*/uevent` (note `*` also matches `/`), the path
`/devices/LNXSYSTM:00/PNP0C14:01/wakeup/wakeup57/uevent` would match
both, but the second rule would be applied. Users can control the
precedence by writing concrete parent directories.

There are also cases where multiple rules of the same length match
against a path. To remove this ambiguity, we can document the current
behavior that the first matching rule in the genfscon file takes
precedence. Users should not rely on this rule but should specify paths
that are concrete enough, though.

I'd appreciate your feedback.

Signed-off-by: Takaya Saeki <takayas@chromium.org>
---
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/include/security.h        |  6 +++
 security/selinux/ss/policydb.c             | 56 ++++++++++++++++++----
 security/selinux/ss/services.c             | 13 +++--
 5 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/security/selinux/include/policycap.h
b/security/selinux/include/policycap.h
index 079679fe7254..2b4014a826f0 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -15,6 +15,7 @@ enum {
  POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
  POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
  POLICYDB_CAP_NETLINK_XPERM,
+ POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
  __POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h
b/security/selinux/include/policycap_names.h
index e080827408c4..17e5c51f3cf4 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -18,6 +18,7 @@ const char *const
selinux_policycap_names[__POLICYDB_CAP_MAX] = {
  "ioctl_skip_cloexec",
  "userspace_initial_context",
  "netlink_xperm",
+ "genfs_wildcard",
 };
 /* clang-format on */

diff --git a/security/selinux/include/security.h
b/security/selinux/include/security.h
index c7f2731abd03..ccd80fb037d5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -201,6 +201,12 @@ static inline bool selinux_policycap_netlink_xperm(void)
  selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
 }

+static inline bool selinux_policycap_genfs_seclabel_wildcard(void)
+{
+ return READ_ONCE(
+ selinux_state.policycap[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]);
+}
+
 struct selinux_policy_convert_data;

 struct selinux_load_state {
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 383f3ae82a73..959e98fae3d5 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1090,29 +1090,59 @@ static int context_read_and_validate(struct
context *c, struct policydb *p,
  * binary representation file.
  */

-static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
+static int entry_read(char **bufp, gfp_t flags, void *fp, u32 entry_len,
+       u32 buf_len)
 {
  int rc;
- char *str;
+ char *buf;

- if ((len == 0) || (len == (u32)-1))
+ if ((buf_len == 0) || (buf_len == (u32)-1) || (buf_len < entry_len))
  return -EINVAL;

- str = kmalloc(len + 1, flags | __GFP_NOWARN);
- if (!str)
+ buf = kmalloc(buf_len, flags | __GFP_NOWARN);
+ if (!buf)
  return -ENOMEM;

- rc = next_entry(str, fp, len);
+ rc = next_entry(buf, fp, entry_len);
  if (rc) {
- kfree(str);
+ kfree(buf);
  return rc;
  }

+ *bufp = buf;
+ return 0;
+}
+
+static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
+{
+ int rc;
+ char *str;
+
+ rc = entry_read(&str, flags, fp, len, len + 1);
+ if (rc)
+ return rc;
+
  str[len] = '\0';
  *strp = str;
  return 0;
 }

+static int str_read_with_padding(char **strp, gfp_t flags, void *fp, u32 len,
+ char padding)
+{
+ int rc;
+ char *str;
+
+ rc = entry_read(&str, flags, fp, len, len + 2);
+ if (rc)
+ return rc;
+
+ str[len] = padding;
+ str[len + 1] = '\0';
+ *strp = str;
+ return 0;
+}
+
 static int perm_read(struct policydb *p, struct symtab *s, void *fp)
 {
  char *key = NULL;
@@ -2193,7 +2223,17 @@ static int genfs_read(struct policydb *p, void *fp)
  if (!newc)
  goto out;

- rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
+ if (ebitmap_get_bit(
+     &p->policycaps,
+     POLICYDB_CAP_GENFS_SECLABEL_WILDCARD))
+ /* Append a wildcard '*' to make it a wildcard pattern */
+ rc = str_read_with_padding(&newc->u.name,
+    GFP_KERNEL, fp, len,
+    '*');
+ else
+ /* Prefix pattern */
+ rc = str_read(&newc->u.name, GFP_KERNEL, fp,
+       len);
  if (rc)
  goto out;

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 971c45d576ba..da4d22220fe8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -48,6 +48,7 @@
 #include <linux/audit.h>
 #include <linux/vmalloc.h>
 #include <linux/lsm_hooks.h>
+#include <linux/parser.h>
 #include <net/netlabel.h>

 #include "flask.h"
@@ -2861,9 +2862,15 @@ static inline int __security_genfs_sid(struct
selinux_policy *policy,

  for (c = genfs->head; c; c = c->next) {
  size_t len = strlen(c->u.name);
- if ((!c->v.sclass || sclass == c->v.sclass) &&
-     (strncmp(c->u.name, path, len) == 0))
- break;
+ if (selinux_policycap_genfs_seclabel_wildcard()) {
+ if ((!c->v.sclass || sclass == c->v.sclass) &&
+     (match_wildcard(c->u.name, path)))
+ break;
+ } else {
+ if ((!c->v.sclass || sclass == c->v.sclass) &&
+     (strncmp(c->u.name, path, len)))
+ break;
+ }
  }

  if (!c)
-- 
2.47.0.338.g60cca15819-goog
