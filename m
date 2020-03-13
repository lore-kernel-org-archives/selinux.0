Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304DFC2BB1D
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CC52073E
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7lcb0nF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCMNlL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:41:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34333 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgCMNlL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 09:41:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id f3so12496076qkh.1
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4YFCAZ3BuAT+wohXw3tuyO80sKFSX48Vgb/57cRHEtk=;
        b=m7lcb0nF1RvD6dy7VenxeCHIwczzR7ac2y1FE/4j5SobLhDS6IQ+7RpP2gzyQGJYyd
         8Nfr2fUyBdzEo/5d4EItHRybNb5HnYJVkACMX7gehloH28bF8Tjj+QiX9PFT77Zdr3hc
         4QDLGYbGg74s2lRRmMnKhGHvF+SpgeZmg/hTygayrbBRiwN+p5L6/Ld/Va+Xm++NXHDu
         LkEUN+JkaojbzYywacflAgolSp5XLK1gL0qARkXECmDg5kPBUrXPW15+6/izhPgdWv4A
         VGI6euTSlMu2kfkQkKN7CgWTcpAo0udu/mrOkgBM8RFEPKRs8nKM/Hi9GS/DDymcGfse
         nQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4YFCAZ3BuAT+wohXw3tuyO80sKFSX48Vgb/57cRHEtk=;
        b=EFBMKr5OEMyYZaDFkX4pwzVsXc/e1+KdEuwgNiFUv3klIEtNybuhJwBRfR1sBl3BAi
         05gKwVt1pblJasXwbdSCbYHjkqwbbQKJBnYjYh3CEx1PkhvfbBr5k5aNgi/vL6b99iYq
         cFNPRYNM+M/xvcePwXnZ50ORNx66zO1Az8Oro+ngjXS9LWia+EvC9O8TU3lvikgHsBk2
         LvDdPoWXfnBgW02z/11yRSHi4Fgtm0h6pdmDM9L1nFNSWD3EGdgFHEVp4SYXkV1CPc5p
         5X6BA1VNbzaxo92OYFWlyi9IUEId8QqDaxO6MNW7TQf5QhofN5LsDGh8iI+PwIuN5x0Z
         2rYA==
X-Gm-Message-State: ANhLgQ3XNXkVmLz0rfT7W3nJMeGT6wkLZrDXAZqvhBLqqqm/9O1SOZ1J
        NNbXu91/Y/STlX8EsTEmD3Y=
X-Google-Smtp-Source: ADFU+vug27t5ckzo53XsQ668oIj+fQlvF7MHkbQqAZdI0vUGIVqxOmI9gluFvw/iU9h3g4XUWIOgxw==
X-Received: by 2002:a05:620a:a0d:: with SMTP id i13mr13211052qka.333.1584106867215;
        Fri, 13 Mar 2020 06:41:07 -0700 (PDT)
Received: from r21-ubuntu-01.ltsnet.net ([65.127.220.137])
        by smtp.gmail.com with ESMTPSA id b10sm8505868qto.60.2020.03.13.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:41:05 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] selinux: add unprivileged sandboxing capability
Date:   Fri, 13 Mar 2020 09:40:47 -0400
Message-Id: <20200313134047.27338-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>

This is an RFC on an early prototype of a new capability for SELinux
to support unprivileged (or at least less privileged) sandboxing.
This was developed by an intern whose internship has now completed and
we are posting it as a RFC to gather feedback especially on the
concept, design, userspace/policy and kernel interfaces, although
implementation feedback is also welcome.

Currently it is not feasible for applications to opt into further
restrictions via SELinux except by switching or transitioning into
security contexts that are already predefined in the base policy, or
by toggling booleans that likewise must be predefined in the base
policy along with the associated conditional rules.  The type
hierarchy / typebounds mechanism has proven to be unwieldy due to the
strict hierarchical restrictions, the need to explicitly define
everything allowed to every descendant domain, and the lack of any
interfaces for dynamically introducing bounded types by unprivileged
programs.  SELinux namespaces offer a potential alternative path
toward unprivileged sandboxing via SELinux but substantial work
remains to making them complete and practical, and they are more
oriented toward the container use case (e.g. requiring loading of a
complete SELinux policy within the namespace) than allowing an
individual application to sandbox itself or one of its child
processes.

While others are pursuing unprivileged sandboxing through separate
LSMs (e.g. Landlock), the goal of this work is to reuse the existing
mechanisms and policy language of SELinux as much as possible,
permitting applications to take advantage of SELinux's existing
facilities and easing analysis and validation of the composition of
the mandatory system-wide policy and the discretionary application
sandbox policy.  This is not to meant to preclude or interfere with
other LSMs like Landlock but merely to offer another option for those
who wish to use it. Other LSMs (AppArmor, Smack) already have their
own mechanisms for processes to apply further restrictions on top of
their base policies.

This patch introduces the ability for a process to load sandbox
policies to be enforced by the kernel on a specified context. To be
permitted to take these actions, the base policy must allow the
process to use the sandboxing interfaces exposed by selinuxfs
(controlled by permission "sandbox" in the existing class "security",
checked against the security initial SID context) and to load and/or
unload a sandbox policy for the specified context (permissions
"load_policy" and "unload_policy" in the new class "sandbox", checked
against the specified context).  The sandbox policy can only further
restrict the context; it can never allow permissions beyond what the
base policy allows.

While a sandbox policy may optionally be written as a whitelist
("allow mode") using allow statements as with regular SELinux policy,
an alternative mode ("deny mode") exists for sandbox policies that
supports blacklists written with deny statements.  Given that the base
policy already fully specifies the maximal whitelist for the context,
the sandbox policy can then be limited to specifying the deltas via
deny mode.  These deny statements are limited to sandbox policies
only, and only if the sandbox policy is built in deny mode.

Design
------
The goal was to keep the logic as simple as possible since the intent
is to ultimately permit unprivileged (or less privileged) processes to
load the sandbox policies into the kernel, and to reuse as much as
possible of the existing SELinux userspace and kernel machinery for
creating, loading, and enforcing policies.  As a result, sandbox
policies are designed as a minimal subset of the base policy, only
containing what is necessary to support the allow or deny rules and
their dependencies, and are compiled to a binary form that is a subset
of the kernel binary policy, allowing reuse of large portions of the
policy compiler and kernel policy loading logic.  Further, sandbox
policies are associated with a source/subject security context rather
than with individual processes, allows us to keep all of our changes
within the security server and reusing the AVC and the rest of the
SELinux machinery for enforcement.

As a result, a binary sandbox policy consists of the
following:
* security context (string)
* "allow" or "deny" mode
* commons symbol table
* classes symbol table
* types symbol table
* allow or deny rules

The security context designates the context to which the sandbox
should be applied. The mode designates if the sandbox policy is
specified as a whitelist ('allow' mode) or as a blacklist ('deny'
mode).  The string/value symbol table data associated with commons,
classes, and types are used to correctly map the allow or deny rules
to values used by the base policy.

Example
-------
Note, this example requires the separate selinux userspace patch to
be applied, built, and installed to support the extensions to secilc
and the new sebox command below.

$ sudo semodule -cE base
$ sudo vi base.cil
<add "sandbox" to (class security (....))>
$ sudo semodule -i base.cil

$ cat ./definesandboxclass.cil
(class sandbox (load_policy unload_policy))
(classorder (unordered sandbox))
$ sudo semodule -i definesandboxclass.cil

$ cat ./unconfinedcansandbox.cil
; allow unconfined_t to sandbox itself
(allow unconfined_t unconfined_t (security (sandbox)))
(allow unconfined_t unconfined_t (sandbox (load_policy unload_policy)))
$ sudo semodule -i unconfinedcansandbox.cil

$ cat ./no-tmp.cil
; some boilerplate required by current limitations in secilc
; is omitted here to keep this text simple and readable,
; see the follow-up message for the full no-tmp.cil file.
(class dir (read getattr open search))
(class file (getattr))
(classorder (dir file))
(type unconfined_t)
(type tmp_t)
(deny unconfined_t tmp_t (dir (read getattr open search)))
(deny unconfined_t tmp_t (file (getattr)))

$ id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

$ ls /tmp/
  systemd-private-123456789...
  tmp.12345678
  ...

$ secilc --sandbox="unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023"
  --sandbox-deny -o ./no-tmp.sandbox ./no-tmp.cil

$ sebox --load ./no-tmp.sandbox

$ ls /tmp/
ls: cannot open directory '/tmp/': Permission denied

$ sebox --unload ./no-tmp.sandbox

$ ls /tmp/
  systemd-private-123456789...
  tmp.12345678
  ...

In real usage, one would load a sandbox for a different context than
one's own context (e.g. a child) or one would load a sandbox that
denies the ability to further load/unload the sandbox to prevent
escaping the sandbox.

Advantages
----------
* The base policy must allow sandboxing before any unprivileged
process is permitted to load or unload any sandbox policies. This
means a system administrator can deny all sandboxing on the system, or
allow select subjects to load/unload sandbox policies.

* Similarly, the base policy can specify which subjects another can
sandbox. For example, a policy can designate that chrome_t can only
sandbox chrome_renderer_t and nothing else.

* Sandbox policies are attached to contexts rather than individual
processes, which is consistent with the SELinux model and allows reuse
of the AVC and rest of the SELinux machinery in the kernel and
facilitates polcy analysis/validation of the composition of policies.

* The addition of deny statements allows a sandbox policy to use the
base policy as a starting point and remove only the permissions they
no longer want within that sandbox. Additionally, a sandbox policy can
be written in the traditional sense where all permissions are denied,
unless specifically allowed.

Disadvantages/Limitations
-------------------------
* Currently no way to create a new type, all sandbox policies must use
types that already exist in the base policy.  This could be changed by
extending the set of constructs supported by the sandbox policy, at
the cost of greater complexity in the kernel.

* The sandbox is not tied to a process, it is tied to a context. As a
result, the sandbox applies to any other processes in the same context
and persists after a process terminates. Although the sandbox can be
unloaded, the extra step to unload may be seen as a disadvantage
especially when a process is attempting to sandbox themselves and they
no longer have permissions to unload the sandbox.

* The use of a binary policy format with compiled allow/deny rules
requires dynamically remapping the rules when the sandbox is loaded,
and again if the base policy is reloaded to ensure consistency.  The
base policy reload case is not currently handled by this patch.

* This patch only allows one sandbox per context, loading a second
sandbox replaces the previous sandbox.  Similarly, this patch does NOT
allow a single sandbox policy to be applied to multiple contexts. A
separate policy would need to be compiled for each context.

* Minimal userspace support at this time; in particular, no support
yet for programmatic creation of a sandbox policy by an application.

ToDo
----
* Locking and atomicity issues around sandbox load/unload and access.

* Handle xperms.

* Fix to use our own policydb struct populated from the sandbox symbol
tables when loading the avtab to avoid problems with inconsistencies
between the base policy and sandbox policy symbol tables.

* Handle base policy reload. When the base policy is reloaded, all
sandbox policies need to be updated to match the values of the new
policy, and the sandboxes need to be preserved.

* Make additional hashtab search functionality more generic.

* Not all access computations use entries from the sid table, e.g.
the type bounds computations, so those access decisions would not have
sandboxes applied to them. This needs to be fixed.

* Code review/audit especially of everything potentially exposed
to unprivileged userspace.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/Makefile           |   3 +-
 security/selinux/include/classmap.h |   5 +-
 security/selinux/include/security.h |   6 +
 security/selinux/selinuxfs.c        | 159 +++++++++++
 security/selinux/ss/avtab.c         |  27 +-
 security/selinux/ss/avtab.h         |  10 +-
 security/selinux/ss/hashtab.c       |  35 +++
 security/selinux/ss/hashtab.h       |   8 +
 security/selinux/ss/policydb.c      |  42 +++
 security/selinux/ss/policydb.h      |   4 +
 security/selinux/ss/sandbox.c       | 391 ++++++++++++++++++++++++++++
 security/selinux/ss/sandbox.h       |  24 ++
 security/selinux/ss/services.c      | 125 ++++++++-
 security/selinux/ss/sidtab.c        |  27 ++
 security/selinux/ss/sidtab.h        |   6 +
 15 files changed, 859 insertions(+), 13 deletions(-)
 create mode 100644 security/selinux/ss/sandbox.c
 create mode 100644 security/selinux/ss/sandbox.h

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 0c77ede1cc11..094f27ed2e56 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
 	     netnode.o netport.o status.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
-	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o
+	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o \
+	     ss/sandbox.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 986f3ac14282..7d5e9c8a1b47 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -42,7 +42,8 @@ struct security_class_mapping secclass_map[] = {
 	  { "compute_av", "compute_create", "compute_member",
 	    "check_context", "load_policy", "compute_relabel",
 	    "compute_user", "setenforce", "setbool", "setsecparam",
-	    "setcheckreqprot", "read_policy", "validate_trans", NULL } },
+	    "setcheckreqprot", "read_policy", "validate_trans",
+	    "sandbox", NULL } },
 	{ "process",
 	  { "fork", "transition", "sigchld", "sigkill",
 	    "sigstop", "signull", "signal", "ptrace", "getsched", "setsched",
@@ -248,6 +249,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ "lockdown",
 	  { "integrity", "confidentiality", NULL } },
+	{ "sandbox",
+	  { "load_policy", "unload_policy"} },
 	{ NULL }
   };
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index d6036c018cf2..8275fa46a587 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -231,6 +231,12 @@ size_t security_policydb_len(struct selinux_state *state);
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
 
+int security_sandbox_load(struct selinux_state *state, u32 ssid,
+			  void *data, size_t len);
+int security_sandbox_unload(struct selinux_state *state, u32 ssid,
+			    void *data, size_t len);
+int security_sandbox_list(struct selinux_state *state);
+
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4781314c2510..5d31b079b85b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1935,6 +1935,154 @@ static int sel_make_policycap(struct selinux_fs_info *fsi)
 	return 0;
 }
 
+#define SEL_SANDBOX_LOAD_SIZELIMIT (32*1024*1024)
+#define SEL_SANDBOX_UNLOAD_SIZELIMIT (32*1024*1024)
+
+static ssize_t sel_sandbox_unload_write(struct file *file,
+					const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi;
+	unsigned long length;
+	u32 ssid;
+	int denied;
+	int rc;
+	void *data = NULL;
+
+	if (count == 0 || count >= SEL_SANDBOX_UNLOAD_SIZELIMIT)
+		return -ERANGE;
+
+	/* no partial writes */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	ssid = current_sid();
+	denied = avc_has_perm(&selinux_state,
+			      ssid, ssid,
+			      SECCLASS_SECURITY, SECURITY__SANDBOX, NULL);
+	if (denied)
+		return denied;
+
+	data = vmalloc(count);
+	if (!data) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	length = copy_from_user(data, buf, count);
+	if (length != 0) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	fsi = file_inode(file)->i_sb->s_fs_info;
+	mutex_lock(&fsi->mutex);
+	rc = security_sandbox_unload(fsi->state, ssid, data, count);
+	mutex_unlock(&fsi->mutex);
+	if (rc)
+		goto out;
+
+	rc = count;
+out:
+	vfree(data);
+
+	return rc;
+}
+
+static const struct file_operations sel_sandbox_unload_ops = {
+	.write		= sel_sandbox_unload_write,
+	.llseek		= generic_file_llseek,
+};
+
+static ssize_t sel_sandbox_load_write(struct file *file, const char __user *buf,
+				      size_t count, loff_t *ppos)
+
+{
+	struct selinux_fs_info *fsi;
+	unsigned long length;
+	u32 ssid;
+	int denied;
+	int rc;
+	void *data = NULL;
+
+	if (count <= 0 || count >= SEL_SANDBOX_LOAD_SIZELIMIT)
+		return -ENOMEM;
+
+	/* no partial writes */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	ssid = current_sid();
+	denied = avc_has_perm(&selinux_state,
+			      ssid, ssid,
+			      SECCLASS_SECURITY, SECURITY__SANDBOX, NULL);
+	if (denied)
+		return denied;
+
+	data = vmalloc(count);
+	if (!data) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	length = copy_from_user(data, buf, count);
+	if (length != 0) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	fsi = file_inode(file)->i_sb->s_fs_info;
+	mutex_lock(&fsi->mutex);
+	rc = security_sandbox_load(fsi->state, ssid, data, count);
+	mutex_unlock(&fsi->mutex);
+	if (rc)
+		goto out;
+
+	rc = count;
+out:
+	vfree(data);
+
+	return rc;
+}
+
+static const struct file_operations sel_sandbox_load_ops = {
+	.write		= sel_sandbox_load_write,
+	.llseek		= generic_file_llseek,
+};
+
+static int sel_make_sandbox_files(struct dentry *dir)
+{
+	struct super_block *sb = dir->d_sb;
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+	int i;
+
+	static const struct tree_descr files[] = {
+		{"sandbox_load", &sel_sandbox_load_ops, 0222},
+		{"sandbox_unload", &sel_sandbox_unload_ops, 0222},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		struct inode *inode;
+		struct dentry *dentry;
+
+		dentry = d_alloc_name(dir, files[i].name);
+		if (!dentry)
+			return -ENOMEM;
+
+		inode = sel_make_inode(sb, S_IFREG|files[i].mode);
+		if (!inode) {
+			dput(dentry);
+			return -ENOMEM;
+		}
+
+		inode->i_fop = files[i].ops;
+		inode->i_ino = ++fsi->last_ino;
+		d_add(dentry, inode);
+	}
+
+	return 0;
+}
+
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 			unsigned long *ino)
 {
@@ -2078,6 +2226,17 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	ret = sel_make_policy_nodes(fsi);
 	if (ret)
 		goto err;
+
+	dentry = sel_make_dir(sb->s_root, "sandbox", &fsi->last_ino);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto err;
+	}
+
+	ret = sel_make_sandbox_files(dentry);
+	if (ret)
+		goto err;
+
 	return 0;
 err:
 	pr_err("SELinux: %s:  failed while creating inodes\n",
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 01b300a4a882..584925034981 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -103,7 +103,8 @@ avtab_insert_node(struct avtab *h, int hvalue,
 	return newnode;
 }
 
-static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
+int avtab_insert(struct avtab *h, struct avtab_key *key,
+		 struct avtab_datum *datum)
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;
@@ -375,6 +376,7 @@ static uint16_t spec_order[] = {
 	AVTAB_ALLOWED,
 	AVTAB_AUDITDENY,
 	AVTAB_AUDITALLOW,
+	AVTAB_SANDBOXDENY,
 	AVTAB_TRANSITION,
 	AVTAB_CHANGE,
 	AVTAB_MEMBER,
@@ -654,6 +656,29 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 	return rc;
 }
 
+int avtab_map(struct avtab *h,
+	      int (*apply)(struct avtab_key *k, struct avtab_datum *d,
+			   void *args),
+	      void *args)
+{
+	int i;
+	int rc;
+	struct avtab_node *cur;
+
+	if (!h)
+		return 0;
+
+	for (i = 0; i < h->nslot; i++) {
+		for (cur = h->htable[i]; cur; cur = cur->next) {
+			rc = apply(&cur->key, &cur->datum, args);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
 void __init avtab_cache_init(void)
 {
 	avtab_node_cachep = kmem_cache_create("avtab_node",
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 5fdcb6696bcc..40524f902147 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -30,7 +30,9 @@ struct avtab_key {
 #define AVTAB_ALLOWED		0x0001
 #define AVTAB_AUDITALLOW	0x0002
 #define AVTAB_AUDITDENY		0x0004
-#define AVTAB_AV		(AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
+#define AVTAB_SANDBOXDENY	0x1000
+#define AVTAB_AV		(AVTAB_ALLOWED | AVTAB_AUDITALLOW | \
+				 AVTAB_AUDITDENY | AVTAB_SANDBOXDENY)
 #define AVTAB_TRANSITION	0x0010
 #define AVTAB_MEMBER		0x0020
 #define AVTAB_CHANGE		0x0040
@@ -105,10 +107,16 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp);
 
 struct avtab_node *avtab_insert_nonunique(struct avtab *h, struct avtab_key *key,
 					  struct avtab_datum *datum);
+int avtab_insert(struct avtab *h, struct avtab_key *key,
+		 struct avtab_datum *datum);
 
 struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key *key);
 
 struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
+int avtab_map(struct avtab *h,
+	      int (*apply)(struct avtab_key *k, struct avtab_datum *d,
+			   void *args),
+	      void *args);
 
 #define MAX_AVTAB_HASH_BITS 16
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 883f19d32c28..0e777e538041 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -116,6 +116,41 @@ void *hashtab_search(struct hashtab *h, const void *key)
 	return cur->datum;
 }
 
+struct hashtab_node *hashtab_rsearch(struct hashtab *h,
+				     int (*cmp_f)(void *d, u32 value),
+				     u32 value)
+{
+	struct hashtab_node *cur;
+	int i;
+
+	if (!h)
+		return NULL;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur) {
+			if (cmp_f(cur->datum, value) == 0)
+				return cur;
+			cur = cur->next;
+		}
+	}
+
+	return NULL;
+
+}
+
+void *hashtab_compare_search(struct hashtab *base, struct hashtab *child,
+			     int (cmp_f)(void *d, u32 value),
+			     u32 value)
+{
+	struct hashtab_node *node;
+
+	node = hashtab_rsearch(child, cmp_f, value);
+	if (!node)
+		return NULL;
+	return hashtab_search(base, node->key);
+}
+
 void hashtab_destroy(struct hashtab *h)
 {
 	u32 i;
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index dde54d9ff01c..4a766f5f6a3f 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -62,6 +62,14 @@ int hashtab_insert(struct hashtab *h, void *k, void *d);
  */
 void *hashtab_search(struct hashtab *h, const void *k);
 
+struct hashtab_node *hashtab_rsearch(struct hashtab *h,
+				     int (*cmp_f)(void *d, u32 value),
+				     u32 value);
+
+void *hashtab_compare_search(struct hashtab *base, struct hashtab *child,
+			     int (*cmp_f)(void *d, u32 value),
+			     u32 value);
+
 /*
  * Destroys the specified hash table.
  */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 932b2b9bcdb2..2bb93f152870 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2541,6 +2541,48 @@ int policydb_read(struct policydb *p, void *fp)
 	goto out;
 }
 
+int policydb_read_symbols(struct policydb *p, struct symtab *s,
+			  int symbol_index, void *fp)
+{
+	__le32 data;
+	u32 nprim, nel;
+	int rc, i;
+
+	rc = next_entry(&data, fp, sizeof(__le32));
+	if (rc)
+		return rc;
+	nprim = le32_to_cpu(data);
+
+	rc = next_entry(&data, fp, sizeof(__le32));
+	if (rc)
+		return rc;
+	nel = le32_to_cpu(data);
+
+	rc = symtab_init(s, nel);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < nel; i++) {
+		rc = read_f[symbol_index](p, s->table, fp);
+		if (rc)
+			goto bad;
+	}
+
+	return 0;
+bad:
+	policydb_destroy_symbols(s, symbol_index);
+	s->table = NULL;
+	return rc;
+}
+
+void policydb_destroy_symbols(struct symtab *s, int symbol_index)
+{
+	if (!s)
+		return;
+	hashtab_map(s->table, destroy_f[symbol_index], NULL);
+	hashtab_destroy(s->table);
+}
+
 /*
  * Write a MLS level structure to a policydb binary
  * representation file.
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 72e2932fb12d..ebf6ddd13714 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -29,6 +29,7 @@
 #include "mls_types.h"
 #include "context.h"
 #include "constraint.h"
+#include "sandbox.h"
 
 /*
  * A datum type is defined for each kind of symbol
@@ -320,6 +321,9 @@ extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
+extern int policydb_read_symbols(struct policydb *p, struct symtab *s,
+				 int symbol_index, void *fp);
+extern void policydb_destroy_symbols(struct symtab *s, int symbol_index);
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/security/selinux/ss/sandbox.c b/security/selinux/ss/sandbox.c
new file mode 100644
index 000000000000..cf93135877cd
--- /dev/null
+++ b/security/selinux/ss/sandbox.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+
+#include "flask.h"
+#include "avc.h"
+#include "avc_ss.h"
+#include "security.h"
+#include "services.h"
+#include "policydb.h"
+#include "sandbox.h"
+#include "avtab.h"
+#include "symtab.h"
+#include "hashtab.h"
+
+#define SANDBOX_CONTEXT_LENGTH PAGE_SIZE
+
+struct fix_args {
+	struct policydb *p;
+	struct symtab *symbols;
+	struct sandbox *s;
+};
+
+/*
+ * It is expected that the caller frees the string.
+ */
+static int context_read(char **context_str, size_t *context_strlen, void *fp)
+{
+	int rc;
+	__le32 data;
+	char *str = NULL;
+	size_t strlen = 0;
+
+	/* read the context length */
+	rc = next_entry(&data, fp, sizeof(data));
+	if (rc)
+		goto out;
+
+	strlen = le32_to_cpu(data);
+	if (strlen == 0 || strlen >= SANDBOX_CONTEXT_LENGTH) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	/* read context */
+	str = kmalloc(strlen + 1, GFP_KERNEL);
+	if (!str) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = next_entry(str, fp, strlen);
+	if (rc) {
+		kfree(str);
+		goto out;
+	}
+
+	/* null-terminate */
+	str[strlen] = '\0';
+
+out:
+	*context_strlen = strlen;
+	*context_str = str;
+	return rc;
+}
+
+static int type_value_compare(void *d, u32 value)
+{
+	struct type_datum *datum = d;
+
+	if (datum->value == value)
+		return 0;
+	return -EINVAL;
+}
+
+static int class_value_compare(void *d, u32 value)
+{
+	struct class_datum *datum = d;
+
+	if (datum->value == value)
+		return 0;
+	return -EINVAL;
+}
+
+static int perm_value_compare(void *d, u32 value)
+{
+	struct perm_datum *datum = d;
+
+	if (datum->value == value)
+		return 0;
+	return -EINVAL;
+}
+
+void sandbox_destroy(struct sandbox *s)
+{
+	if (!s)
+		return;
+	kfree(s->context_str);
+	avtab_destroy(&s->te);
+	kfree(s);
+}
+
+void sandbox_detach(struct sidtab_entry *entry)
+{
+	struct sandbox *s_old;
+
+	s_old = sidtab_sandbox_detach(entry);
+	if (s_old)
+		sandbox_destroy(s_old);
+}
+
+int sandbox_attach(struct sidtab_entry *entry, struct sandbox *s)
+{
+	sandbox_detach(entry);
+	return sidtab_sandbox_attach(entry, s);
+}
+
+int sandbox_fix_node(struct avtab_key *k, struct avtab_datum *d, void *args)
+{
+	struct fix_args *fargs = args;
+	struct policydb *p = fargs->p;
+	struct symtab *symbols = fargs->symbols;
+	struct sandbox *s_new = fargs->s;
+
+	struct avtab_key key;
+	struct avtab_datum datum;
+
+	struct type_datum *base_type;
+	struct class_datum *base_class;
+	struct perm_datum *base_perm;
+	struct common_datum *base_common;
+
+	struct hashtab_node *rnode;
+	struct class_datum *sandbox_class;
+	struct common_datum *sandbox_common;
+	int rc, i;
+
+	/* fix source type */
+	base_type = hashtab_compare_search(p->symtab[SYM_TYPES].table,
+					   symbols[SYM_TYPES].table,
+					   type_value_compare,
+					   k->source_type);
+	if (!base_type)
+		return -EINVAL;
+	key.source_type = base_type->value;
+
+	/* fix target type */
+	base_type = hashtab_compare_search(p->symtab[SYM_TYPES].table,
+					   symbols[SYM_TYPES].table,
+					   type_value_compare,
+					   k->target_type);
+	if (!base_type)
+		return -EINVAL;
+	key.target_type = base_type->value;
+
+	/* fix class */
+	base_class = hashtab_compare_search(p->symtab[SYM_CLASSES].table,
+					    symbols[SYM_CLASSES].table,
+					    class_value_compare,
+					    k->target_class);
+	if (!base_class)
+		return -EINVAL;
+	key.target_class = base_class->value;
+
+	/* fix specified */
+	key.specified = k->specified;
+
+	/* fix data */
+	rnode = hashtab_rsearch(symbols[SYM_CLASSES].table,
+				class_value_compare,
+				k->target_class);
+	if (!rnode)
+		return -EINVAL;
+
+	sandbox_class = rnode->datum;
+	sandbox_common = sandbox_class->comdatum;
+	base_common = base_class->comdatum;
+	base_perm = NULL;
+	datum.u.data = 0x00;
+	rnode = NULL;
+
+	for (i = 0; i < (sizeof(u32)*8); i++) {
+		if (d->u.data & (1<<i)) {
+			if (sandbox_common)
+				rnode = hashtab_rsearch(
+					sandbox_common->permissions.table,
+					perm_value_compare,
+					i+1);
+			if (!rnode)
+				rnode = hashtab_rsearch(
+					sandbox_class->permissions.table,
+					perm_value_compare,
+					i+1);
+			if (!rnode)
+				return -EINVAL;
+
+			if (base_common)
+				base_perm = hashtab_search(
+					base_common->permissions.table,
+					rnode->key);
+			if (!base_perm)
+				base_perm = hashtab_search(
+					base_class->permissions.table,
+					rnode->key);
+			if (!base_perm)
+				return -EINVAL;
+			datum.u.data |= (1<<(base_perm->value-1));
+		}
+	}
+
+	rc = avtab_insert(&s_new->te, &key, &datum);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+int sandbox_fix(struct policydb *p, struct symtab *symbols, struct sandbox **sp)
+{
+	struct sandbox *s;
+	struct sandbox *s_new;
+	int rc;
+	struct fix_args args = { p, symbols, NULL };
+
+	s = *sp;
+	s_new = kmalloc(sizeof(*s_new), GFP_KERNEL);
+	if (!s_new)
+		return -ENOMEM;
+
+	s_new->context_strlen = s->context_strlen;
+	s_new->context_str = kstrdup(s->context_str, GFP_KERNEL);
+	s_new->mode = s->mode;
+	s_new->te.htable = NULL;
+	s_new->te.nel = 0;
+	if (s_new->context_str == NULL) {
+		rc = -ENOMEM;
+		goto bad;
+	}
+
+	rc = avtab_alloc(&s_new->te, s->te.nel);
+	if (rc)
+		goto bad;
+	args.s = s_new;
+
+	rc = avtab_map(&s->te, sandbox_fix_node, &args);
+	if (rc)
+		goto bad;
+
+	*sp = s_new;
+	sandbox_destroy(s);
+	return 0;
+
+bad:
+	sandbox_destroy(s_new);
+	return rc;
+}
+
+int sandbox_load(struct selinux_state *state, u32 ssid, void *fp)
+{
+	u32 tsid;
+	int rc;
+	struct sandbox *s = NULL;
+	char *context_str = NULL;
+	size_t context_strlen = 0;
+	struct sidtab_entry *entry = NULL;
+	struct policydb *policydb = &state->ss->policydb;
+	struct symtab symbols[SYM_NUM] = {{ NULL, 0 }};
+	u32 mode = 0;
+
+	rc = context_read(&context_str, &context_strlen, fp);
+	if (rc)
+		return rc;
+
+	rc = security_context_to_sid(state, context_str, context_strlen,
+				     &tsid, GFP_KERNEL);
+	if (rc)
+		goto exit;
+
+	rc = avc_has_perm(state,
+			  ssid, tsid,
+			  SECCLASS_SANDBOX, SANDBOX__LOAD_POLICY, NULL);
+	if (rc)
+		goto exit;
+
+	rc = next_entry(&mode, fp, sizeof(mode));
+	if (rc)
+		goto exit;
+	if (mode != SANDBOX_MODE_ALLOW && mode != SANDBOX_MODE_DENY) {
+		rc = -EINVAL;
+		goto exit;
+	}
+
+	rc = policydb_read_symbols(policydb, &symbols[SYM_COMMONS],
+				   SYM_COMMONS, fp);
+	if (rc)
+		goto exit;
+
+	rc = policydb_read_symbols(policydb, &symbols[SYM_CLASSES],
+				   SYM_CLASSES, fp);
+	if (rc)
+		goto exit;
+
+	rc = policydb_read_symbols(policydb, &symbols[SYM_TYPES],
+				   SYM_TYPES, fp);
+	if (rc)
+		goto exit;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	s->context_strlen = context_strlen;
+	s->context_str = kstrdup(context_str, GFP_KERNEL);
+	s->mode = mode;
+	s->te.htable = NULL;
+	s->te.nel = 0;
+	if (s->context_str == NULL) {
+		rc = -ENOMEM;
+		goto bad;
+	}
+
+	rc = avtab_read(&s->te, fp, policydb);
+	if (rc)
+		goto bad;
+
+	rc = sandbox_fix(policydb, symbols, &s);
+	if (rc)
+		goto bad;
+
+	entry = sidtab_search_entry(state->ss->sidtab, tsid);
+	if (!entry) {
+		rc = -EINVAL;
+		goto bad;
+	}
+
+	write_lock_irq(&state->ss->policy_rwlock);
+	rc = sandbox_attach(entry, s);
+	write_unlock_irq(&state->ss->policy_rwlock);
+	if (rc)
+		goto bad;
+
+exit:
+	kfree(context_str);
+	policydb_destroy_symbols(&symbols[SYM_COMMONS], SYM_COMMONS);
+	policydb_destroy_symbols(&symbols[SYM_CLASSES], SYM_CLASSES);
+	policydb_destroy_symbols(&symbols[SYM_TYPES], SYM_TYPES);
+	return rc;
+
+bad:
+	sandbox_destroy(s);
+	goto exit;
+}
+
+int sandbox_unload(struct selinux_state *state, u32 ssid, void *fp)
+{
+	u32 tsid;
+	int rc;
+	char *context_str = NULL;
+	size_t context_strlen = 0;
+	struct sidtab_entry *entry = NULL;
+
+	rc = context_read(&context_str, &context_strlen, fp);
+	if (rc)
+		return rc;
+
+	rc = security_context_to_sid(state, context_str, context_strlen,
+				     &tsid, GFP_KERNEL);
+	kfree(context_str);
+	context_str = NULL;
+	context_strlen = 0;
+	if (rc)
+		return rc;
+
+	rc = avc_has_perm(state,
+			  ssid, tsid,
+			  SECCLASS_SANDBOX, SANDBOX__UNLOAD_POLICY, NULL);
+	if (rc)
+		return rc;
+
+	entry = sidtab_search_entry(state->ss->sidtab, tsid);
+	if (!entry)
+		return -EINVAL;
+
+	write_lock_irq(&state->ss->policy_rwlock);
+	sandbox_detach(entry);
+	write_unlock_irq(&state->ss->policy_rwlock);
+	return 0;
+}
diff --git a/security/selinux/ss/sandbox.h b/security/selinux/ss/sandbox.h
new file mode 100644
index 000000000000..339f6f52bbde
--- /dev/null
+++ b/security/selinux/ss/sandbox.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _SS_SANDBOX_H_
+#define _SS_SANDBOX_H_
+
+#include "security.h"
+#include "symtab.h"
+#include "avtab.h"
+
+#define SANDBOX_MODE_ALLOW 0x00
+#define SANDBOX_MODE_DENY 0x01
+
+struct sandbox {
+	char *context_str;
+	u32 context_strlen;
+	u32 mode;
+	struct avtab te;
+};
+
+int sandbox_load(struct selinux_state *state, u32 ssid, void *fp);
+int sandbox_unload(struct selinux_state *state, u32 ssid, void *fp);
+void sandbox_destroy(struct sandbox *s);
+
+#endif /* _SS_SANDBOX_H_ */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8ad34fd031d1..a41ca000ec48 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -101,7 +101,8 @@ static void context_struct_compute_av(struct policydb *policydb,
 				      struct context *tcontext,
 				      u16 tclass,
 				      struct av_decision *avd,
-				      struct extended_perms *xperms);
+				      struct extended_perms *xperms,
+				      struct sandbox *sandbox);
 
 static int selinux_set_mapping(struct policydb *pol,
 			       struct security_class_mapping *map,
@@ -571,7 +572,7 @@ static void type_attribute_bounds_av(struct policydb *policydb,
 				  tcontextp,
 				  tclass,
 				  &lo_avd,
-				  NULL);
+				  NULL, NULL);
 
 	masked = ~lo_avd.allowed & avd->allowed;
 
@@ -620,7 +621,8 @@ static void context_struct_compute_av(struct policydb *policydb,
 				      struct context *tcontext,
 				      u16 tclass,
 				      struct av_decision *avd,
-				      struct extended_perms *xperms)
+				      struct extended_perms *xperms,
+				      struct sandbox *sandbox)
 {
 	struct constraint_node *constraint;
 	struct role_allow *ra;
@@ -629,6 +631,10 @@ static void context_struct_compute_av(struct policydb *policydb,
 	struct class_datum *tclass_datum;
 	struct ebitmap *sattr, *tattr;
 	struct ebitmap_node *snode, *tnode;
+	u32 sandbox_allowed = 0;
+	u32 sandbox_deny = 0;
+	u32 sandbox_auditallow = 0;
+	u32 sandbox_auditdeny = 0xffffffff;
 	unsigned int i, j;
 
 	avd->allowed = 0;
@@ -655,6 +661,7 @@ static void context_struct_compute_av(struct policydb *policydb,
 	avkey.specified = AVTAB_AV | AVTAB_XPERMS;
 	sattr = &policydb->type_attr_map_array[scontext->type - 1];
 	tattr = &policydb->type_attr_map_array[tcontext->type - 1];
+
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
@@ -673,13 +680,45 @@ static void context_struct_compute_av(struct policydb *policydb,
 					services_compute_xperms_drivers(xperms, node);
 			}
 
+
 			/* Check conditional av table for additional permissions */
 			cond_compute_av(&policydb->te_cond_avtab, &avkey,
 					avd, xperms);
 
+			/* Compute sandbox policy */
+			if (likely(!sandbox))
+				continue;
+			for (node = avtab_search_node(&sandbox->te, &avkey);
+			     node;
+			     node = avtab_search_node_next(node,
+							   avkey.specified)) {
+				if (node->key.specified == AVTAB_ALLOWED)
+					sandbox_allowed |= node->datum.u.data;
+				else if (node->key.specified ==
+					 AVTAB_SANDBOXDENY)
+					sandbox_deny |= node->datum.u.data;
+				else if (node->key.specified ==
+					 AVTAB_AUDITALLOW)
+					sandbox_auditallow |=
+						node->datum.u.data;
+				else if (node->key.specified ==
+					 AVTAB_AUDITDENY)
+					sandbox_auditdeny &= node->datum.u.data;
+				/* TODO: add support for xperms */
+			}
 		}
 	}
 
+	if (sandbox != NULL) {
+		/* Apply sandbox restrictions */
+		if (sandbox->mode == SANDBOX_MODE_DENY)
+			avd->allowed &= (~sandbox_deny);
+		else
+			avd->allowed &= sandbox_allowed;
+		avd->auditallow &= sandbox_auditallow;
+		avd->auditdeny &= sandbox_auditdeny;
+	}
+
 	/*
 	 * Remove any permissions prohibited by a constraint (this includes
 	 * the MLS policy).
@@ -1106,7 +1145,9 @@ void security_compute_av(struct selinux_state *state,
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	u16 tclass;
+	struct sidtab_entry *entry = NULL;
 	struct context *scontext = NULL, *tcontext = NULL;
+	struct sandbox *sandbox = NULL;
 
 	read_lock(&state->ss->policy_rwlock);
 	avd_init(state, avd);
@@ -1117,13 +1158,18 @@ void security_compute_av(struct selinux_state *state,
 	policydb = &state->ss->policydb;
 	sidtab = state->ss->sidtab;
 
-	scontext = sidtab_search(sidtab, ssid);
-	if (!scontext) {
+	entry = sidtab_search_entry(sidtab, ssid);
+	if (!entry) {
 		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		goto out;
 	}
 
+	sandbox = entry->sandbox;
+	scontext = &entry->context;
+	if (!scontext)
+		goto out;
+
 	/* permissive domain? */
 	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
@@ -1142,7 +1188,7 @@ void security_compute_av(struct selinux_state *state,
 		goto out;
 	}
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
-				  xperms);
+				  xperms, sandbox);
 	map_decision(&state->ss->map, orig_tclass, avd,
 		     policydb->allow_unknown);
 out:
@@ -1161,7 +1207,9 @@ void security_compute_av_user(struct selinux_state *state,
 {
 	struct policydb *policydb;
 	struct sidtab *sidtab;
+	struct sidtab_entry *entry = NULL;
 	struct context *scontext = NULL, *tcontext = NULL;
+	struct sandbox *sandbox = NULL;
 
 	read_lock(&state->ss->policy_rwlock);
 	avd_init(state, avd);
@@ -1171,13 +1219,18 @@ void security_compute_av_user(struct selinux_state *state,
 	policydb = &state->ss->policydb;
 	sidtab = state->ss->sidtab;
 
-	scontext = sidtab_search(sidtab, ssid);
-	if (!scontext) {
+	entry = sidtab_search_entry(sidtab, ssid);
+	if (!entry) {
 		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		goto out;
 	}
 
+	sandbox = entry->sandbox;
+	scontext = &entry->context;
+	if (!scontext)
+		goto out;
+
 	/* permissive domain? */
 	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
@@ -1196,7 +1249,7 @@ void security_compute_av_user(struct selinux_state *state,
 	}
 
 	context_struct_compute_av(policydb, scontext, tcontext, tclass, avd,
-				  NULL);
+				  NULL, sandbox);
  out:
 	read_unlock(&state->ss->policy_rwlock);
 	return;
@@ -3787,3 +3840,57 @@ int security_read_policy(struct selinux_state *state,
 	return 0;
 
 }
+
+int security_sandbox_unload(struct selinux_state *state, u32 ssid,
+			    void *data, size_t len)
+{
+	struct policy_file file = { data, len }, *fp = &file;
+	int rc = 0;
+	u32 seqno;
+
+	if (!state->initialized)
+		return -EINVAL;
+
+	/* unload */
+	rc = sandbox_unload(state, ssid, fp);
+	if (rc)
+		return rc;
+
+	write_lock_irq(&state->ss->policy_rwlock);
+	seqno = ++state->ss->latest_granting;
+	write_unlock_irq(&state->ss->policy_rwlock);
+
+	/* reset AVC - this will clear the cache */
+	avc_ss_reset(state->avc, seqno);
+	selnl_notify_policyload(seqno);
+	selinux_status_update_policyload(state, seqno);
+
+	return 0;
+}
+
+int security_sandbox_load(struct selinux_state *state, u32 ssid,
+			  void *data, size_t len)
+{
+	struct policy_file file = { data, len }, *fp = &file;
+	int rc = 0;
+	u32 seqno;
+
+	if (!state->initialized)
+		return -EINVAL;
+
+	/* load */
+	rc = sandbox_load(state, ssid, fp);
+	if (rc)
+		return rc;
+
+	write_lock_irq(&state->ss->policy_rwlock);
+	seqno = ++state->ss->latest_granting;
+	write_unlock_irq(&state->ss->policy_rwlock);
+
+	/* reset AVC - this will clear the cache */
+	avc_ss_reset(state->avc, seqno);
+	selnl_notify_policyload(seqno);
+	selinux_status_update_policyload(state, seqno);
+
+	return 0;
+}
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index a308ce1e6a13..3fe125da429b 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -88,6 +88,7 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 #if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
 	isid->entry.cache = NULL;
 #endif
+	isid->entry.sandbox = NULL;
 	isid->set = 1;
 
 	/*
@@ -292,6 +293,7 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 		goto out_unlock;
 
 	dst->sid = index_to_sid(count);
+	dst->sandbox = NULL;
 
 	rc = context_cpy(&dst->context, context);
 	if (rc)
@@ -465,6 +467,7 @@ static void sidtab_destroy_entry(struct sidtab_entry *entry)
 #if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
 	kfree(rcu_dereference_raw(entry->cache));
 #endif
+	sandbox_destroy(entry->sandbox);
 }
 
 static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
@@ -595,4 +598,28 @@ int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
 	return rc;
 }
 
+int sidtab_sandbox_attach(struct sidtab_entry *entry,
+			  struct sandbox *sandbox)
+{
+	if (!entry)
+		return -EINVAL;
+
+	entry->sandbox = sandbox;
+
+	return 0;
+}
+
+struct sandbox *sidtab_sandbox_detach(struct sidtab_entry *entry)
+{
+	struct sandbox *sandbox;
+
+	if (!entry)
+		return NULL;
+
+	sandbox = entry->sandbox;
+	entry->sandbox = NULL;
+
+	return sandbox;
+}
+
 #endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 3311d9f236c0..bb2a74b0db9d 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -16,6 +16,7 @@
 #include <linux/hashtable.h>
 
 #include "context.h"
+#include "sandbox.h"
 
 struct sidtab_entry {
 	u32 sid;
@@ -24,6 +25,7 @@ struct sidtab_entry {
 	struct sidtab_str_cache __rcu *cache;
 #endif
 	struct hlist_node list;
+	struct sandbox *sandbox;
 };
 
 union sidtab_entry_inner {
@@ -147,6 +149,10 @@ static inline int sidtab_sid2str_get(struct sidtab *s,
 }
 #endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
 
+int sidtab_sandbox_attach(struct sidtab_entry *entry,
+			  struct sandbox *sandbox);
+struct sandbox *sidtab_sandbox_detach(struct sidtab_entry *entry);
+
 #endif	/* _SS_SIDTAB_H_ */
 
 
-- 
2.17.1

