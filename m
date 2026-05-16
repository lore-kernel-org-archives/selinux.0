Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDF3793D0
	for <selinux@vger.kernel.org>; Sat, 16 May 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778926524; cv=none; b=TNHEcB0AeZc5pK2i85Cv7PBSufeudYsfUC/fhvIsoAXp4BZWbNtovZATi9ME3k2MJJJztZQ9QgNzZOoTZ4BTAV2jwQ46IAIAynh8fMo75Mt3fZt8h/C/eISiB/kb8W1/0VBympZpuX5tFnSOj5yzJiM0dlVnwH8BR0fAyFxPyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778926524; c=relaxed/simple;
	bh=+ugUTdVABa3F/naVBZuQ2lukO0F4jdLleMrEvuq9BoA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dy/y9lqzKkaUTSKUOK/C1Ed72POdyODiH2OmfGbVsbJAQ567xtaE9r+heLwDdWLHEl0bwl3vYwxrny50f8daVG6sk095xwsq5H+Pa1x38WYVh1opellJHyURJYpm9FEgzm9KPWH9ifYTkXQoSbPH+EES1yh5+f8RbRSpztsMBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MJUKVdEe; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MJUKVdEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1778926518; x=1779185718;
	bh=+ugUTdVABa3F/naVBZuQ2lukO0F4jdLleMrEvuq9BoA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MJUKVdEeWgAOa88BNWBg4WsDXKM/lvMsuMrYpz4dubg+SYFWQwxMxBAoBxuqiIfni
	 x5bGaxsPjuwX0lEi08+S3rGN1LVEAgmkNzd5L1xh/7u09/jtoBUg+kgqMxnj/cBb+R
	 doG514GaS3vCH1fXzgM6fexC13Ep2qJhebJDWndHuOc8+a7vBtHZgDpk3ZZu2GQc2v
	 w/r+upg53ryF24X+6MyjYlmqI8UDTM94mnXMX5xNhNfiggJv/CbQ7r8ppFaYn3GKRg
	 adeN28jhlv1tJIQFK0QW7KlQ+boo/9WlT118TAc+0d7/LYrPcF5d7lo8dKZuOZC6tD
	 SwFsPiCKU+8Lg==
Date: Sat, 16 May 2026 10:15:15 +0000
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
From: BoxStrike <BoxStrike@proton.me>
Cc: "paul@paul-moore.com" <paul@paul-moore.com>, "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>, "eparis@parisplace.org" <eparis@parisplace.org>
Subject: [PATCH 0/2] selinuxfs: fix inconsistent policy state and deprecated op return value
Message-ID: <rKg1X_SSNB9SOzR6jIcabSwbkzTU032ccV6kLwmvjEZzs_syLg3_Ct-Wz0tzhvnXBHlbSiEBXAPL2JnWm6b7aNzs0PRf8eRpUX8aTWEyDAM=@proton.me>
Feedback-ID: 196754768:user:proton
X-Pm-Message-ID: a33bf1b1aa11e5475f22b9ae6e3614a048ec63ce
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linux Team
While reviewing selinuxfs.c I found two bugs. Patches are included below.

---

[PATCH 1/2] selinuxfs: fix inconsistent policy state on partial swap failur=
e

In sel_make_policy_nodes(), the boolean directory swap and the class
directory swap are performed as two separate, non-atomic operations.
If the boolean swap succeeds but the subsequent class swap fails
(e.g. -ENOMEM from start_renaming_two_dentries), the function jumps
to 'out' leaving the filesystem in an inconsistent state:

=C2=A0 - fsi->bool_dir points to the newly populated boolean dentries
=C2=A0 - fsi->class_dir still points to the old class dentries

This means /selinux/booleans/ reflects the new policy while
/selinux/class/ still reflects the previous one. This mismatch
persists until the next successful policy load.

Fix this by rolling back the boolean swap when the class swap fails,
so both directories either reflect the new policy or both reflect
the old one.


---
=C2=A0diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxf=
s.c
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -519,8 +519,22 @@ static int sel_make_policy_nodes(...)

=C2=A0 /* classes */
=C2=A0 ret =3D start_renaming_two_dentries(&rd, tmp_class_dir, fsi->class_d=
ir);
- if (ret)
- goto out;
+ if (ret) {
+ /*
+ * Bool swap already committed above. Roll it back so
+ * booleans and classes don't reflect different policies.
+ */
+ struct renamedata rd_rollback =3D {};
+ rd_rollback.old_parent =3D fsi->sb->s_root;
+ rd_rollback.new_parent =3D tmp_parent;
+ if (!start_renaming_two_dentries(&rd_rollback,
+ fsi->bool_dir,
+ tmp_bool_dir)) {
+ d_exchange(fsi->bool_dir, tmp_bool_dir);
+ swap(fsi->bool_num, bool_num);
+ swap(fsi->bool_pending_names, bool_names);
+ swap(fsi->bool_pending_values, bool_values);
+ fsi->bool_dir =3D tmp_bool_dir;
+ end_renaming(&rd_rollback);
+ }
+ goto out;
+ }

=C2=A0 d_exchange(tmp_class_dir, fsi->class_dir);
=C2=A0 fsi->class_dir =3D tmp_class_dir;

---

[PATCH 2/2] selinuxfs: return -EINVAL from deprecated sel_write_user

sel_write_user() is a deprecated interface that logs an error and
returns 2 (bytes written). selinux_transaction_write() interprets
any rv > 0 as success and returns the original write size to
userspace, making callers believe the operation succeeded.

Return -EINVAL instead to make the deprecation explicit at the
syscall level, consistent with how sel_write_disable() and
sel_write_checkreqprot() behave in terms of intent (though those
also have the same issue -- a follow-up could address them).

---
=C2=A0diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxf=
s.c
=C2=A0--- a/security/selinux/selinuxfs.c
=C2=A0+++ b/security/selinux/selinuxfs.c
=C2=A0@@ -998,9 +998,7 @@ static ssize_t sel_write_user(...)
=C2=A0 {
=C2=A0 pr_err_once("SELinux: %s (%d) wrote to user. This is no longer suppo=
rted.\n",
=C2=A0 =C2=A0 =C2=A0current->comm, current->pid);
=C2=A0- buf[0] =3D '0';
=C2=A0- buf[1] =3D 0;
=C2=A0- return 2;
=C2=A0+ return -EINVAL;
=C2=A0 }

---

Note: I also noticed that sel_make_policycap() assigns the name
"unknown" to all policy capabilities beyond ARRAY_SIZE(selinux_policycap_na=
mes),
resulting in multiple dentries with the same name being passed to
d_alloc_name(). This may warrant a separate fix (e.g. using a
formatted name like "unknown_%u"). I can send a patch for that
separately if useful.

Thanks for your time.

Eneshan Erdo=C4=9Fan Karaca

My github:https://github.com/Kisaca-Enes

