Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43201925A3
	for <selinux@vger.kernel.org>; Tue, 17 Sep 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726617139; cv=none; b=E8NyDyrgUqEkee4bO1LTPN2jxuannehyGFFKuMqQ4YEQqh6lW81xcxuq5GgW6w6hbdszpjD1gEAW/ophW0GDHkc1wtWdWE2nmTLFA+/eIC6R1xlb+Z4C9kaQIQrkDaSBp7stqTxIFgJNhI37EqX+oekc2HP0RWBqA/i90JGGJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726617139; c=relaxed/simple;
	bh=5I8pyu6Eihs9FmZ3JKr8AxK2Qe+0Gmn69hg74bI0IXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=OdJueGpOJMcGGsNg2h87fclgIWm+KK77RwhPZmj3wUBJaQA+hAuZJwrEwMPZBMKV6nFfj6T4dEj/kE35aY7YC51jTkGZEr1gRq754A+lnUEp0eVvQXz35TKYqRNdwdWDZlnhlmAFm486BqYtUCuRfo2iPWv1n9zmG0u6+l0u9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DB0r/Gbd; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DB0r/Gbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617130; bh=NOWzP5VP0viHyHozWNSozCsFxmo44aVajm6MwAah0oE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=DB0r/GbdeSWDbEIm7g+9dJ5Xo4pzDihmC5+dG7+eVdP45nDLQ1/8pyuc5djn3hQ1Rkz6ops+unIK/XV4iIf3a2yXGob34QyBdZLXJpdk3pkVN/kjqWjdGyRC+aA0VtNg2RQ/eLCxszmwxkszg+B8w7S2dvoIE12ci83oHlok4Hn1jK+KH9eIEH5n0e4N3D359IqKPmwNK/LHalwReMz3wYHeGDo0Df9CxaZO8YLF5CaPErsoFRXIOhEq7IHOaubEDVuT9LoldSLX1bf5naaYP5gQ+cnuuDzk8pTo63XbRfKofMGVGC81Axz+33ygtDGCWj34fJJN1CWKwIltsRY48A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617130; bh=cCvjWbFJQl+kT3sTB6/139mXlqnYp6HynMXAtEsYb8c=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DAaCWejDzdma0a0tCO61aw4OwyWvnWmMx94uOjGccLZycidxZbkyBuNJWbxbEJfIqoMSkEy90lhMJOjrGe2R54NerKQpjBUTtz9eCZW2wImGrTKWIpuyxkPPiEl+kzLV5ORop2mO0ReSo3GB1UhngqOUuC1qf6FiuY/uaZRHww2fWl3lZpl8adqO6tnknPecmcgWx6gOnhSk8NrcyrCOyP+3Z1wQUlS8yQvNUuRueUEw9SbTqLFrWaal7tVJ5se9C2v/pqTuVKnY1eAHX3IDcyHGiMKYczMXGyEmRwnuiWCD2uBIPS6lq1tAwfbcZoSH/Brsp5OPfkG0LzAlLRjHsA==
X-YMail-OSG: 6Zq.EGEVM1mrN_6nF_k8sfMnD4h0wiN70JuZXG3NTA2jWOBotzQzaM3iPcV_J2i
 YcyZkun3ucybtSzBGCKT.Pb0UEUe57.bn2IFKflgdiHRgNmKx3BgvJtuiBeWxBlyQlybb5hv84VL
 cqJs3FmHl6Iztupd6ecX71PeVOOhUNJnQ76DlD9vLB.V0_uVm5zMk30sd3zVLn8AZ2vi768qp65l
 4MN.k_N3JM91wmthCiMdqRAk2stL_JaLIkQ.a3Ya33EznE_SmUzyLvzmM7EMEh3wX8RlOjKg_AAu
 CkQfO3BH0a9vF9B0J7jvsrSXJFEVL.MdyEvf5g_.de3EobPdNUGRX6z37NXLc158DXozBRcI54nZ
 F1u4WM_EVH48Mf4iKWGs3N06SXSDig7Ea1iTniWPr.uj_voCbz4s1OUqu0csymbMpC6B4cgXZ7YG
 PPEhx6CAYr_olwMHHGJ14arjshRY4FAlv0NYUHi_ZrcqlJxK9SaFo9SUarD3upajwAwFcpje.08J
 znCslaRlp2Gpp_FSX0Yl65szyVWtCrzSKlFtEemC1TqHBqbPaI.MssmlBqdF9WAbAlgtjhd9Yrol
 XwiElOQ263t3JEgSyWmfwValLryl_kr9pnhfRfMeiYTg0.QtI.k3tj393i7m6BXQboWrcTVzxRcs
 tA2LuGK9G2fSV6t_XfReO_sgYMzpNN0zLDmXE2mm138lQobMwjLmuSpMKTan9Fh2wqWZDHt7UQPp
 fVQn4n6yXvMZXIU06qdiB3mBIazERLg7Qj9MTDbAs8adN.Qk4dhEM4dJEQs3zC4N1KjYhmxgQFKz
 4VlBCtnAB7FSsOJnOYagLx.8G8zC94E8jeC8W40OCziN.2PtHYnFNvjPJIVvO5CbqR9Ny1Pmtzpk
 6NNYedq4K3YFFgFbW3J5jrhf7oaAt4EdfX8AmPLH.qYojZ3h.X3Gt5QJ6EptQX4Xw7v_2IotJ8TD
 EWz8X05Tmr_Z5H_7RlGVupkCOnU1ExOOLBJKU8hCEu5gffdWV5.rCTsL.uULqC5DDEGKsee4RuCV
 Lx4uhkiyGvMxVGMH.lSKRaC45rJtjC.t2v4OwTe.2ax_SIwN9w00HoBwbzBfPDM_Bwhg_LN0x7On
 JQ7X.nc21X.4cTJc4ReVw7r9J7dZWz_kNV5VHPzfmTT1mE67tfJkoQ668zpl4jc.reMhl5XKLZf3
 nd5wt872B3IpmAzyoc3m0tUjM0Tt3_KhqmiVY7V.ZX7zD3jHupbMpokcDOo3MEUYcaOstteFz1s5
 j1Hs2JQTW9LXT7JSA5_5miMwYWgGtfp36qeUY0OzOEK.AWIRmOa0f0Rf1tKjKB2m5EUdlPIWCQzY
 bDDZYBZxlpMT1GgYiZr.zC0fMljLyEr9_7xiz2O8lldFWX.M5cjz9wQBpIx6ioJZBqCCeyRwqsic
 oUEliB2F9eIzEy0p0jWbhjlL8rm0k9jLdcAd9.xfI6KHEWAJIJYAI19zoyBNEMmR67mhlakpwLbe
 UQSi0GnLPBh.NuA_W4DcaWMywcYc_ka8AdB1MfFeV28P7ilRapKHMEBJMwex0lWSfl7dvdAsTBS3
 O.aYgTRkzA4Mjz.04ndXS7Hsz7EB.5V9VPbA9uuxW8y0oiVt98Xtx.c4wWIhObyEPhTqlHM5CoJp
 UZDAj9t9wfKWofSjiXHW3SIbck.eiFFqdrk8peOVV62dWp6l.QKEySD3a9GOs.akCJKkANVlNR6p
 jwPN4Lun54h85BuvHLJ9yyJMThgd5FLx8Qa.ec.X7ffRVEz_JG3.uWy_4tssaYE6Rfagtr7Fqfbs
 cSB6t2W9s1g94lw2ah_Y7F_Vq6cxIjXvUn6qYh7CabjJpIYV1hUgsVD3WWlTFd1PIL6LT2qC2NMT
 rm4yuRSpIpN2RM81Y1Di14.M3XpFx0cf3ZBKSLUQ1aVO55z1Qhle9G2ijm1SBi9mxDsROZK2juuX
 puI1FNq8_foDnYnhaPw.pX7NQa0iJDxVpdnwfrzWCIWVabpSorNzn9NIsoCihM3hp2qVBbVg4oM9
 FexYgGOai7Yp1WN61ZAjtnkTTDeOsR7H7kb184oEXgMPZ7VggySl3otRuzTIP_KG5pqJZgIBUHw8
 RSnbRC92KuzDby0gsDLCh5U3szovURYFi8EgMiBv.78IbNQ4i_QDW8i6yE.OUZsL3uCgM4Vqc7tC
 c4vdZjbXS8codG8x.78Kd.7WY0KO8rfr_nv7oSKWXOLN6S863H6RSiKiLFSFfyZPj.FforFusa5k
 AO4_RiosPqGUDJpmpUyw6b8r_yxk0v7gu5b6S0NcjRErfbTXq09J2KE9nT8xEjmxHtVfIVHRHX07
 0T6ts2v7NxtgH.V1sLBLE9EQaFxMeug--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f539fa09-b15e-4bb0-a665-79a6f7bfe596
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Sep 2024 23:52:10 +0000
Received: by hermes--production-gq1-5d95dc458-vkwd9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b3a84955471b9061a763fb967f12395;
          Tue, 17 Sep 2024 23:52:05 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH 0/5] LSM: Replace secctx/len pairs with lsm_context
Date: Tue, 17 Sep 2024 16:51:57 -0700
Message-ID: <20240917235202.32578-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240917235202.32578-1-casey.ref@schaufler-ca.com>

Several of the Linux Security Module (LSM) interfaces use a pair of
pointers for transmitting security context data and data length. The
data passed is refered to as a security context.  While all existing
modules provide nul terminated strings, there is no requirement that
they to so. Hence, the length is necessary.

Security contexts are provided by a number of interfaces. The interface
security_release_secctx() is used when the caller is finished with the
data. Each of the security modules that provide security contexts manages
them differently. This was safe in the past, because only one security
module that provides security contexts is allowed to be active. To allow
multiple active modules that use security contexts it is necessary to
identify which security module created a security context. Adding a third
pointer to the interfaces for the LSM identification is not appealing.

A new structure, lsm_context, is created for use in these interfaces.
It includes three members: the data pointer, the data length and
the LSM ID of its creator. The interfaces that create contexts and
security_release_secctx() now use a pointer to an lsm_context instead
of a pointer pair.

The changes are mostly mechanical, and some scaffolding is used within
the patch set to allow for smaller individual patches.

This patch set depends on the patch set LSM: Move away from secids:
	https://lore.kernel.org/lkml/0529f07a-d8c5-4290-8056-6d04aa70c670@I-love.SAKURA.ne.jp/T/

https://github.com/cschaufler/lsm-stacking.git#lsm_context-after-lsm_prop-6.11-rc3

Casey Schaufler (5):
  LSM: Replace context+len with lsm_context
  LSM: Use lsm_context in security_inode_getsecctx
  LSM: lsm_context in security_dentry_init_security
  LSM: secctx provider check on release
  LSM: Use lsm_context in security_inode_notifysecctx

 drivers/android/binder.c                |  5 +-
 fs/ceph/super.h                         |  3 +-
 fs/ceph/xattr.c                         | 16 +++----
 fs/fuse/dir.c                           | 35 +++++++-------
 fs/nfs/dir.c                            |  2 +-
 fs/nfs/inode.c                          | 16 ++++---
 fs/nfs/internal.h                       |  8 ++--
 fs/nfs/nfs4proc.c                       | 22 ++++-----
 fs/nfs/nfs4xdr.c                        | 22 +++++----
 fs/nfsd/nfs4xdr.c                       | 25 ++++------
 include/linux/lsm_hook_defs.h           | 14 +++---
 include/linux/nfs4.h                    |  8 ++--
 include/linux/nfs_fs.h                  |  2 +-
 include/linux/security.h                | 44 +++++-------------
 include/net/scm.h                       |  5 +-
 kernel/audit.c                          |  9 ++--
 kernel/auditsc.c                        | 16 +++----
 net/ipv4/ip_sockglue.c                  |  4 +-
 net/netfilter/nf_conntrack_netlink.c    |  8 ++--
 net/netfilter/nf_conntrack_standalone.c |  4 +-
 net/netfilter/nfnetlink_queue.c         | 27 +++++------
 net/netlabel/netlabel_unlabeled.c       | 13 ++----
 net/netlabel/netlabel_user.c            |  3 +-
 security/apparmor/include/secid.h       |  5 +-
 security/apparmor/secid.c               | 36 ++++++--------
 security/security.c                     | 62 +++++++++++--------------
 security/selinux/hooks.c                | 57 ++++++++++++++---------
 security/smack/smack_lsm.c              | 55 +++++++++++++---------
 28 files changed, 244 insertions(+), 282 deletions(-)

-- 
2.46.0

