Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF87221714
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373238; cv=none; b=rVQuNb5qtXP4gCaJhlWoBZu+ado1eBasP3W627Sksaamak28f98gaFaI20sjLr+KZgvdGOt+TlqvEbqZMZIh64xWlkxHPMQAVQXRWCv0DkqX2Einpi87Wc8R6ObZqhdcGTleNQfgRKY9YLmmkuAbMR8u7YrUC3e3YT/EVH93x2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373238; c=relaxed/simple;
	bh=zz3uBk48+7no25j+Ns24PzVLZrTPAcWmGdELG9brV9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=knbMwWZJ8zT3GXNvXfjhZR4nfcO9ktN1145l20hk1NRB+/P66PRzT4p6kxI5yd1Tu/2tgcyfwSU2i5ptM8Aw459+drWK73aB69YxaZdrU55flov/mukTvhhlXbxRS/kbfHvXOMpoVagnVk5YWrl38GWLJ5GNJ+5lVi6jb36NPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JW0AK+zL; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JW0AK+zL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741373236; bh=dR6sLeIF6x2BIfs1xnT3U5+B1dmWz+hDD8EKB1ZIw3c=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=JW0AK+zLCffOsqkQN/3VH3Xguv9R2HSkhMkNlYYnQfBi4sNqAJEtMm2wxt66WrVnVqetNiBNKU53m9N7x8qWzQ7WXIe9W3RSgGSTSEwKvyXCTXq7aJQQvfNjxN15Do23vZLDXFRxeEOTi5RumK8eZLPzQUlToO10QxGIVOwH6BqykaHyk9uu08mbqJgGG+cZFa6wsHUa1jsBFDOtxZNNA+iAM6aXOCi5tXqgGEoQJV4pSpRdItCbFPCTGQXmkyXHLOCK2qoXoO/TmbmlYEl7UPSWM/0blUtaotLvY4jzl6HvzQO7h6DUyQCH3zWz9DgTMuThS/iljJ1lkc2XujNFSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741373236; bh=QqbjRRLafcTwP4FuRCwXF+9WKtyw8KaB/nBID2yQ3tn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bS19YCfuIK88dqvct0uBDBTrKg7TWYxVBPKrz4XKWGRPR2M4jIE9oOTsBLl/1I4kUQ9gTaf0hRBbrnNpQcpwMP6mub9UXBGeAY/kFNOIFhNPTJI1Q3U1arEvJVtoygW9BCx3rBRJQqW0qEuz9aPUAUxHUyRxvpmdtavzYUvxBjmcpYuI39OwvvYDzLqbkZ5PreC0ftb6Q+0nGipO0oAMmUQFDNjheOc2iNCCJPznH7hTxgX+Cjb0MIbRgAPOVZ64ObZEzvvHsptCPW+wC8leKej9iz2DA6vW72j/nrOP9G1ufgUHk3/QljXew6thRUf/T0s8W7NZdRb8Hk9y+qir0g==
X-YMail-OSG: fiDnTWsVM1n8p45s0EHmwAEbkem6XNTjPuFp3Zrm_5MKw3_HGV29AJwdKdwjIJo
 IaIn7o1IsE3sf4en7wqgjYrZOjUv8tzW.5xPU6htXL9pP8tT1t13IqH9QF.9v7gkAk9UGaIWlGW0
 dyaHLGGxgeXxQOW.2Hln3bnkljYiO4S5qDma1GD5afMIgufm7sR3kUoVkrrH4NR0EVVnfZdi0Q5w
 dR1GQlPQtnqCsA1FDpG6t5L3JZS87NOR1maWdCTb_jMpBImAXIyS1luPiL60vgpwOGbC0_wKI0z5
 2gdJUmU8qyh3M4aBdaVeyLSdFcgbnw3MwnDSP6XZHEPmII8dIGGJw27s5jR48OSaTSPfSZHbTvk7
 iEwzi.UkpZ_N.dAefv6f6qb2W337QusD.VSnbQnM6ND_kKZQaQ4yGdQgZuqcs6lG7dM9n4635KiU
 TKSQl8Qsx9sc.bGCc20FsE1vt.YGga5vovwEBScTThBda9dZSMLcaNqsKcHVMTuC.R0agZAgtC6C
 kmhayd4Sirh.1vx3hd2anAXctO_Qzz5lsWIHDrJHABNmmZXkk9vDrfmY80bx7UX5pK5G3evUzYx5
 rYPyzmwJRY2Ko3plooof35Ezc80w6NwXkf7Q2FXEO._GhfhWMHRZuerU9bYYOErc6R3imbJ8xFuj
 5iwA0XhLeob7YIcTRdOUIsICJclQoxMCFX13THTkOJIHCip5medoA93.MF7zGKL2.8rC5YXsByFu
 MhdwhqyI8UAz3Sduj21piVeZ_.6sIu4Ez8osBA6HDDxcmnqr5Y8gFHn2Lnfzz4EH1fdnre3.s6Rv
 42EN5YDb3VptkBdaTb9hUq30phVocxMafvL.2FeMC3KOtD6PBeDVhr_iWb4KDyeGp_mmS.SWUOm6
 G7kn49jBOSXW59YXflRczK5z2AmW.N3oPBhIhFSk6EFVOK_YJC5rbvGV56s6X55a_p88qfaqYgvy
 Sn5j.6oirqc3.J3i4nkxKm27OhxvE7MRKePbSxqL2cdly.OhQc5pfCdVqhO13mnZfFG.rjgADA_p
 Obazzn_YpX_pM.BVLH2BeLK8QdTJD.80yM9d1j0w0L0wugiT8nLI29RMzbIzG8Bre1Y8DUDpeYl0
 TYIkrueOlj2KeoUmSq4ughcFwVPuUHMeYwTrFGVz2LQ0Hvduar4Pwp_k6aZMoU4kfzuTCZ8zJ2CB
 L9bG3DPrlKt0.fCN1VQuAlYFIvhKClOcvYSUr.QxeT0.mhtRWozdC19Fq4nyWD7qZPJX37wC5Ccs
 13fWD64QnggBpwxERMLsmHyJqJ5uFwjv7LGNp2SXzAK6bfOtbx6XxCq_zUYZt_m6olRQ1.F__JJn
 ZKNNABNxs5ujnDEe_8Tv3dM7ACWDANf.55wgVqCDFirWzhVbY7WZIELKvabmvzY7E8tSb2HpLVvd
 Tacu8Zr29FKbHLfZUq4r9tKXvzlFGjk48SmKVO4SUFPgY32kRs7a6kXBBDgBeVmQhdtWbI3jhYiV
 7EjvJCjWt3OPCFHrCcPsvgNbYGfGFu0jgxCHIqCSIo66qjiKkfzaMZl4DN4KL0trN_maByiN8lsC
 owFNtspFy5raBu.LQByFD8WAslq7hLApgiRRGtBIR_RF8lzH5ChZpLmiF6Y0SQ2ra3l3AhM_jdr7
 ZmINSXne3z4Dea.5ULVyvc1w3GwhJ6KUofoS.O1GaIcDySNiMn4FVPIfOEPoSvvvObJ.1cJx7p9i
 gU3nHjMhY0gCKfPXuPJ4yhSbgFrM_BV9rIYoNwpfdoQen8cmP6V9Fg9gUeXKnGwYLYbrHlJXpuMa
 7wH4.TZTy_sVgsP1ieabGD17l0e_DA6s1oo1RFGnrlgzTzZi3c4tNbqzAfF6tYds534NQs8lim4M
 7rOB5QvT56ecMrUr_SRW3XLipRhKeoxOClre00QxTX7qkxLIpcQcUaEx4gLm2KsTvGJ2gJzI8BEZ
 fIG8lOjP9ic0DL4DR53LptOMW18vdb3D9eeuAT8UqVGfUHsjO_EV04XWJMJeqZTzWSYOBawG0BGD
 BlP6J5atJI.6s6dkITkAz.01hRBDsgKczjTU0LaariXLIJ6F6BmahoBJ06V__AxB.OeI4aXuGhjR
 usOgLMBqFJWBIKjUdISBig0omF.bm6x3mpG4ECaLKimqN4Omm_P7IrqmotRvEhGhkYfIKU4bOgfh
 g6MLYWJgbXDC1OS4WtGp9N0vDb_psixdrUTj2YU_JM2MwZJwzXEtrvlVhc63ooXTSaUwPUpojxEx
 tz3TiLBrOdeXnBLOepibYvIVEar26fUDv3c_4Oo5AsCTtq2RwCzEmhrlBKluDCt90uGWVUi2hiG2
 zspYSjUluTsi3uGDlWAtk74k-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fb54d543-40b2-4d78-bd7f-e5e71d482f8a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 18:47:16 +0000
Received: by hermes--production-gq1-7d5f4447dd-9qjv2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e6d6a2ea591e1dd2da3497c747300b1;
          Fri, 07 Mar 2025 18:37:06 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 0/6] Audit: Records for multiple security contexts
Date: Fri,  7 Mar 2025 10:36:55 -0800
Message-ID: <20250307183701.16970-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250307183701.16970-1-casey.ref@schaufler-ca.com>

The Linux audit system includes LSM based security "context" information
in its events. Historically, only one LSM that uses security contexts can
be active on a system. One of the few obsticles to allowing multiple LSM
support is the inability to report more than one security context in an
audit event. This patchset provides a mechanism to provide supplimental
records containing more than one security context for subjects and
objects. 
  
The mechanism for reporting multiple security contexts inspired
considerable discussion. It would have been possible to add multiple
contexts to existing records using sophisticated formatting. This would
have significant backward compatibility issues, and require additional
parsing in user space code. Adding new records for an event that contain
the contexts is more in keeping with the way audit events have been
constructed in the past.
 
Only audit events associated with system calls have required multiple
records prior to this. Mechanism has been added allowing any event
to be composed of multiple records. This should make it easier to
add information to existing audit events without breaking backward
compatability.
 
v2:
Maintain separate counts for LSMs using subject contexts and object
contexts. AppArmor uses the former but not the latter.
Correct error handling in object record creation.

https://github.com/cschaufler/lsm-stacking#audit-records-multiple-contexts-v2

Casey Schaufler (6):
  Audit: Create audit_stamp structure
  Audit: Allow multiple records in an audit_buffer
  LSM: security_lsmblob_to_secctx module selection
  Audit: Add record for multiple task security contexts
  Audit: multiple subject lsm values for netlabel
  Audit: Add record for multiple object contexts

 include/linux/audit.h        |  13 ++
 include/linux/lsm_hooks.h    |   4 +
 include/linux/security.h     |   8 +-
 include/uapi/linux/audit.h   |   2 +
 kernel/audit.c               | 235 +++++++++++++++++++++++++++++------
 kernel/audit.h               |  13 +-
 kernel/auditsc.c             |  65 +++-------
 net/netlabel/netlabel_user.c |   8 +-
 security/apparmor/lsm.c      |   1 +
 security/bpf/hooks.c         |   1 +
 security/security.c          |  19 ++-
 security/selinux/hooks.c     |   2 +
 security/smack/smack_lsm.c   |   2 +
 13 files changed, 274 insertions(+), 99 deletions(-)

-- 
2.47.0

