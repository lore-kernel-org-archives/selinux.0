Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909A2D7DC8;
	Tue, 28 Jul 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202259; cv=none; b=ngSDP4IB1dF52WYtlquwVQ1wzDFwG7uQXM5UwabdoNo9Ym5jSkpHle6LGadT8I9H9hz6PYfiYCF8WwH8jGYLV++2NvE6pA8DxtJQVYLCK1sXfOoghhCBPnjApzGexoH1wW0Xrs6Vg1UfFGdesS+YdDNVQ7cQZHsafrzXhXr9WsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202259; c=relaxed/simple;
	bh=OzO6UXS8tSj/egtmp+fK0ULSIhqqWibFskH4bj3SY/s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s0vPAGNMPM+Nt1DNZQE1pNgvPt/69K7Oi7D8JvrAdWV2pt3TaI/wbU+Wi0IuQefvPLKeDOZHw8bsXOmAtPsFlZbj05nc5JYhiRczMFnsBV8IpLb9WqkcQqk5NcIElvrI56+MGDxq9RzBH0Xv0Ta2CEdAlStfLd4kbdLaMu1meKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsYBbGoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsYBbGoq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDA38C19425;
	Tue, 28 Jul 2026 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785202258;
	bh=OzO6UXS8tSj/egtmp+fK0ULSIhqqWibFskH4bj3SY/s=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZsYBbGoq0PDYqGpaLm5peqo8o+ID6H+FRxKtaesxFugsHcNSRjoJ7Rd3hmbT/nocy
	 BCASqnJmVJGH4BIFNNEJexx2+hDcvwL9nAkaBgN58N/SILalcndPhxeetHZOhpujj3
	 7UNsZLDnsdG3UXTlwZEOlYxeh2QraaARfYWPSZfMPm8rsbv/L7HQFcOk7S8SlGIYw1
	 FOI/09LSu+qNK0V7rwcCTSO+EiqMPLMesVrb7atOYqU8EQUsagIi5Jz+NNAF+oCRmd
	 lX39DqTWZxAvPEcdaNisTQ07tsvQyqOapSYs/rrgmV3HjJkWhiyiXXO1pYN+QDcOtF
	 O/bpsgl1XVp+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9696C54EFC;
	Tue, 28 Jul 2026 01:30:58 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH v2 0/2] selinux: bound class/common permission counts on
 policy load
Date: Mon, 27 Jul 2026 20:30:57 -0500
Message-Id: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqDQBBF0a1IjVOghXSHbEUy6M9TKwMjXUkIi
 HtPR4dncO9GhqIwujUbFXzU9LlUyKWhNIdlAmuuJmnFtV48x56z2spA7sS7wHCI/XVMyflANVs
 LRv0ey+F+2t7xgfT6f2jffzzPObh0AAAA
X-Change-ID: 20260727-b4-disp-eed1276a-e6eb48fcc67a
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785202257; l=3344;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=OzO6UXS8tSj/egtmp+fK0ULSIhqqWibFskH4bj3SY/s=;
 b=aVL/v5eXMrjau9+ZwTsB14m1jRF7c5vsugGX/N0viCmExCHqCNETJMMqD+esAPpz5/5S6xrqa
 O2E51jFINLcAgSE6DxgxaR41RZJIu69cMJWxVKjidGOFfZ3Z7D2Fqej
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

perm_read() bounds a permission value to [1, SEL_VEC_MAX] but not against
the owning symbol table's nprim, which security_get_permissions() uses to
size a kcalloc() array that perms[value - 1] writes into. Loading a crafted
policy image then drives an out-of-bounds heap write in
get_permissions_callback(), reached from selinuxfs while it builds the new
policy's class directories. Two independent triggers:

  1/2 (perm_read): a class's own permission value exceeds the class nprim.
      Acked by Stephen Smalley on v1 [1].
  2/2 (class_read): a class inherits a common but declares fewer
      permissions than the common provides; the common's permissions --
      valid within the common -- are mapped into the class-sized array.
      perm_read() cannot catch this (a class with no own permissions never
      calls it), which is why v1 needed the second check.

A/B on a KASAN kernel, writing each policy into /sys/fs/selinux/load in a
single write -- sel_write_load() refuses a partial one outright, so a split
write never reaches the parser:

  1/2 -- "process" (31 own perms), permissions.nprim patched to 1: without
    the series, KASAN slab-out-of-bounds in get_permissions_callback <-
    security_get_permissions; with 1/2, rejected -EINVAL at parse.
  2/2 -- "capability" (inherits common "cap", 32 perms, no own perms),
    permissions.nprim patched to 1 -- one byte of the image: without the
    series, the same slab-out-of-bounds write of size 8, this time through
    the inherited-common map; with 2/2, rejected at parse with "class
    capability has fewer permissions than common cap".
  Control: a well-formed policy loads on the patched kernel exactly as it
    does without the series, with neither check firing.

The load path needs the SELinux load_policy permission plus write access to
/sys/fs/selinux/load and is not namespaced; this hardens the parser against
malformed or corrupted policy images.

v2:
 - split into two patches, as asked [2]; squash them on merge if that reads
   better
 - 2/2 is new: the inherited-common trigger
 - 1/2 is unchanged from v1, so Stephen's ack is carried forward
 - class_read() now names the class and the common when it rejects, like
   the "unknown common" error above it

The other thing review raised is not folded in here. Permission values that
are bounded but sparse leave NULL holes in that same perms[] array, and
sel_make_perm_files() passes each entry to sel_attach_file() ->
d_alloc_name() -> hashlen_string() with no check. By inspection; I have not
reproduced it, which is why it is not in this series rather than a third
patch. It follows once I have an A/B for it.

[1] https://lore.kernel.org/selinux/20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me/
[2] https://lore.kernel.org/selinux/CAHC9VhT4M2--c-ZGf+xPSRz-TiGLUnfmULNXcWMC2NgycufrDg@mail.gmail.com/

---
Bryam Vargas (2):
      selinux: reject a permission value exceeding the class permission count
      selinux: reject a class permission count below its inherited common

 security/selinux/ss/policydb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260727-b4-disp-eed1276a-e6eb48fcc67a

Best regards,
--  
Bryam Vargas <hexlabsecurity@proton.me>


