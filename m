Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBF28A727
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701275; cv=none; b=fRwT/hqRaJs+Gb3o9CZKlNFM2laZHPCXNh6NkB8ndNpj+NUmkDuWhusQYp5X24PFxfDJBJ2g9Fzd4iiar/vWDF3Mrr/xsrjK6cCTKeePvgme+guUVvS/DGgHES20vU90mqStBHMQ7M/rlBr/JqZbhltesHt6CMhA+/iwm5RtOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701275; c=relaxed/simple;
	bh=LzUCl3hoJEExpToziP9fTxrE872KV3dSO1feighJNnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=GwtPk2xuxv4MdhjuboqaPjeF625pLgpVeoDVpCRs23rYM8RZ0d1AxG0AahIB21I0+1wYzmG+TOvYzJ9iYrlY1bXIZmAVJSEDLXf2R4GXrkt/QEvj11u0HgMX81n97MqeYzve13S8n5mj6zUSsmbCVQ+0FCbJmHIcGdHeCrggqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ot1xIJRl; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ot1xIJRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701265; bh=D+A4s2puEKRfCvZ3mdVLmiFNlIwcfme6AV7KlzI6Syc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Ot1xIJRl+iLEbC776m9QKyFlw9i1qTkfglXtfiYNkKwCC3WrX+1t4n6UQByTBKdYMby1CfDpmWhX6hritv97K7AnlFGrohrMExxdzqd4+kjgEjuh7YB5lzldA9jbQU/d4KHZFgjGT2cnxToloFzNN1fkqVyMhI2sNhj7lq8LSROp/TMyNXNaXXXpElTQBoARIzZSKi0bZiOXZ3eQ7gf8JY4KZbS1xftnWiTYPcIrzotP05cH8oohLzlGiqMhyuNuNQWOoI7chk3+LDRte7j4PEsuEBXrNPkN5uHWuQh8CdDxRJCRANJLxqOggss8CHmn2+NRZ2WBwjpJBl/yF9zinQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701265; bh=fYaojdwppR6oB7MgqaGHmkU05Yj+dCR04hO4QvW2Y6j=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=d7G6yIy9OQlWLMneskHyjraL1BPYgN8QhgwNI8hHgrQRguLJ+7fXFaLYF8dsc5mkOPt06SiL/a8TPbBi5OEf2v+cwWGWv8AZQcbpI3rm2jZfLbfHVY3Bq39tXvzS1b5O5YvJu6E6Ymz19VrOYfdAycoYJFvJIOLYCkJKs5Ouu+trU0THdfrkTIcT0Hl4a1ST4DGeSByyBlfV6x1X7WSlqM1ZpHgoSdZvth6r5S4zcHZPQSuKzrlWcjgfb/ZzIi+1L/LiYN5XzVnov2+BmKHIh+etklGKdirWdZ1vb1pPYQTgIAJTMwXYY99ioxJ4O7OjEKavlJEJ9ynbaElqVKXeOw==
X-YMail-OSG: zj_kmoQVM1n3hC2Q_RftGB9VNCJIgqISqj_f4zD8dUSYsm5hxNT1LVMzgvTEmiX
 _dvbFRgj04zbl6ZGelFYS.IiLFUF6lQ0LeFtGvoaMtZANxBGNVY96iBqr8ZemDY4ubs_s_XhXqDG
 wyxbcuhWanqmEXA3kMpdS1lMug551aKD5c2N.kzceXZGtiCpJk2ANxqrSXgSZ89vARF.fnQDh0ZZ
 YokhzRdbDEx.hLfovCyfKb6zkcrHSGEbqHBa.JTAYr2vQt0bCaqROaUXmcDPX0CqM34_QrKZeFxy
 7AsYeM3xuhrZrh2sKFiOJTx5cipt2ZJwG_0PwCzNETAz0QOd5b1l7EocX0hoxpw89hFifSoIUyBF
 YJjaMas0bGFxTmBJUbpilrSe6_Uy.u7EHcagX4EbmMyV7ThnNb80b6h_FvqMuvBU94q2onQskIDw
 WbabmMOHOQr2UGtUVLyrcYYdeZLpESGMEtslBr8OqGs839QpaDYv5OTpa4iVlTX00HP7usxnzjJz
 qEKIeVS5gApevo5gES5vMz_8B1oya.r5X02lBf.wo8p7yFsniwS9dQwYLswRaS0OdB2CGhaKm1Hl
 eTVOKSimgxGpGqSvOYHGURzOB_7SvWS6PaEcWPuhVqlYpXl3U89UPN5_IpuYIsmIZwI_gqVa4ENL
 MPZNt.485v1DWeq3ftxQFLJRdlMKdJ5swYUaCO_Xz4TwRbpQ7QEv7RIcbyRkZIWPdcqZMgr73Qvf
 nVI8AI0vN0ejOtWqoX.8fCO6tmxBWE.CJDE4S2NmJ.zpP0szjstgnYbesdiKZQEIJJomulNYH9bH
 QbR8F9kEA8nQaGtfptvr6d946cncXgFaJIaHpITJItMiA.dMQZN_WQZjfbVq7upmvqhTxCrlVFci
 Lqv5xusrFHfO.Tq1v_qmVtQf3OhCz1NZRMmgQL6AawJsdyEXoCtxZB_Krv9UddhAlzmOf2yWeQVy
 pQGJA28IEErBFmYUKF0qTFibFIc0yZNPxmqQPnKYbmrS9ffJL49eQTMW7wilucmg4IZ8DwMlX9Wa
 tsHMFHK2jZ5c14Uhjh3bxY_fsSPV1DBqWJVG0ja0W48Rgen1ryME0OCteGjXX2jv5RJfrYsiA53r
 gXYX.M3CfwTPWRQPtcqjx_h7Qr8FA4Z3YGr12gDJZF6SCZ52no6BBYEn2USofLOFf25Q9WvOc4yE
 2l.YhaEtI_1xOja02OS0vK6hxlYRE5we7wfZCdSmsAdXDEvMYGMGqueVRPXXTC9xPIYRakFrDmWb
 9iafqcatVSsw9Ymg5v27TSY3hrtsfZj.TdsfpsiF62QLFICw_03JEVN7MUPtz03Cj9jIq.mILpld
 h0fK3iKeb1dXfYEQ3G_ZOVLY4H5b9jiRiyjWOZHUKkwl1ILx1VCz51Hdyw6coJC2o2kCnWasp0hA
 KqR0O8ZdLpKDZ6Ns13Nj4jIYqU_7mGWZTEDGMrVa2p0LQi3E00dnlvoAE.N2Um.ptdirmtYZ4VKx
 UnJzKlpqoOji_BtIBLemc7VxC5GxG9GP7ELx2x0whEnC60ZSeFdya9NVrUup8HnhVPbpwW.KkVai
 Vy24_k4_49R7b24jvnRgXkOkDvlvQZQeTPW276b5gr7DqoYXlv7Krdc3vrrVlfDCcNLI5UqwMRh_
 Mn.dNXjc.7tItESwAa7yg.2_JRs1ymCW7Bc.Km3CNoFLGcw.LfmBFD6sUjewEyw.7zTbBBlDVrMZ
 br1dQE2nDgqNYBLZWwa9lGU5BGXm0CSdlnTNfy3xMNjhsZPppqfRQ4jc3CkM2eoTEwitWXaCFtjc
 payMxpzUsA.kewHBP757Ok_5H2cHgrvr54skAzY.tLcYTE73ToONDoGreU4Ka3QFmZ8zcyxlcCqO
 wD4bB5hKgrFHc.gWoFTxJImFBb7na8Jonugna.bk6IuOkD_rQtDBvDOoR1vaiOXF1E2Gt8h5ZhH5
 GbmgzWLVvULUxfmUuhYEDbGmA8ipX62WezuZmJgLghQgNhSN1el591SROCMYlg4iq2OcRZj2zJ.b
 J1_juzzADUsfxLj9NhxUuA.NdVHabQUlLXrbAnOHeL64wcFyd.ePXsU5htna0n2CbbHEc5GoVg3K
 Q3yr9eB2Twbh5_RY0XHb1PBLFcY_nQEiZ.F3p114VOoF6pZSCtcKqHPSPxqLUX2AkBRK6EBbAzoR
 m5oAM8QNRuQktPmQzZY727PMYtXtx9BLO5ClmmSYmRtEjKBBUGjE1WzFiA66pjyGlI9vS7l6gDI8
 sI8JQRdWq1cdaTCugYUztcyePFJkfupPXu8gxJ3S_9E_NRgJjvQJNDYwRgCVg38juEHHbYSLuD1N
 GOWu56a3LrvuhThSw.wv6tkMFQA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0f00651e-2484-48b5-87d7-3b47bf0aee9e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Jul 2025 21:27:45 +0000
Received: by hermes--production-gq1-74d64bb7d7-lbnk4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c82aa99504a499c14c18b1238d973034;
          Wed, 16 Jul 2025 21:27:42 +0000 (UTC)
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
Subject: [PATCH v5 0/5] Audit: Records for multiple security contexts
Date: Wed, 16 Jul 2025 14:27:26 -0700
Message-ID: <20250716212731.31628-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250716212731.31628-1-casey.ref@schaufler-ca.com>

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

v5:
Comment on the LSM_ID_UNDEF behavior in security_secid_to_secctx().
Change some names to better reflect their purpose.
Move alignment changes into a separate patch.
v4:
Use LSM_ID_UNDEF when checking for valid LSM IDs in
security_lsmprop_to_secctx().
Fix the object record to include only those for LSMs that use them.
Squash the two patches dealing with subject contexts.
Base the patches on Paul Moore's LSM initialization patchset.
https://lore.kernel.org/all/20250409185019.238841-31-paul@paul-moore.com/
v3:
Rework how security modules identify that they provide security
contexts to the audit system. Maintain a list within the audit
system of the security modules that provide security contexts.
Revert the separate counts of subject and object contexts.
v2:
Maintain separate counts for LSMs using subject contexts and object
contexts. AppArmor uses the former but not the latter.
Correct error handling in object record creation.

https://github.com/cschaufler/lsm-stacking#audit-6.16-rc4-v5

Casey Schaufler (5):
  Audit: Create audit_stamp structure
  LSM: security_lsmblob_to_secctx module selection
  Audit: Add record for multiple task security contexts
  Audit: Fix indentation in audit_log_exit
  Audit: Add record for multiple object contexts

 include/linux/audit.h        |  23 +++
 include/linux/security.h     |   6 +-
 include/uapi/linux/audit.h   |   2 +
 kernel/audit.c               | 274 ++++++++++++++++++++++++++++++-----
 kernel/audit.h               |  13 +-
 kernel/auditsc.c             |  65 +++------
 net/netlabel/netlabel_user.c |   8 +-
 security/apparmor/lsm.c      |   3 +
 security/lsm.h               |   4 -
 security/lsm_init.c          |   5 -
 security/security.c          |  21 ++-
 security/selinux/hooks.c     |   5 +
 security/smack/smack_lsm.c   |   5 +
 13 files changed, 325 insertions(+), 109 deletions(-)

-- 
2.50.1

