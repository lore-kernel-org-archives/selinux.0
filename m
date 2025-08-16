Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48822FFDF6
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365366; cv=none; b=m7L365eVeUmU1ey8XhsP94vyr+rU4YTV9J4VTTt4tFCt+BMbL3P4HxBbDXsXwCWQug05KkdvzHDVzWrWdXGHktChXhqIh2GheUXtfG/5WTCt8845RBrAXqa8dsbEz2t3rYBAU0A2jXdvQ1G2iv2f7ikKNtc9dsPz6OrC0O63ROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365366; c=relaxed/simple;
	bh=sXs/xlLD5JB1cHwhKsOHhoReCbUuOMwpU+ayvUP9VnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=n/wod+2suJY7wEzH8AUyHpoABj71neTstCMNu7ypClF004ukdMoZIJNzVlt5LYY06PKUSbp1/n3dpLBSmqIp55w8LTwoGWs6+WpVeRajiWKh/uGDeddoE59pPTYQBSrpaNaN7ek6MS0GmImD8MlS92gMzpOjXgu7IcMMXWzhyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=k+u+dzqy; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="k+u+dzqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365356; bh=P7BpN1kOLR2auNE6RyNLfesPgQmsbgbygWHWynjBI3s=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=k+u+dzqy/OGYtOINgKLGZiwWnax/U8lY3v098OIPPdSVV7V75jHXkM+foLilNYH6XyLp1U+VDCWXKE62I5ZbDZxWSe12nVPYNtaa8yp5uFaonkMzl2+rqPrcoaSSlQut67w3nMATcx403p+uNH6rXALKF3+bjMHOjOH73Ai1mZd0qiWKfNhQtI6qOs507A4J6ixnhy9JqvMICBFdjgoxmHevBSq57TT2aIGb1FHahWOwwNmSiiQK4do/Qy1zJmE21hYzdQpOZK5H3V+fLbcKxQWtf4VowDwiLB5YkkDfv2Bto6IitV/LQXE/06XJ5sp8yTdqUcrrwMaepTolcMFmKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365356; bh=LJ9KSp63f/bRBWAuiUBOVrQynhY1KHwUp+5dKY0EDvG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SLtKlOQOcLd8UtPi9ATPEI2q9s713zmv7D1N49/zvBF+WiP7OIWntFuoHWOKFJKMrZ2nCFudfN+bY17jXHQ/wrD/PLSFe3xxUcrSMjKle5tZWJP+a5olgi4ntAFtNWnkN40D+oxeV1PxBtSUMmJuJ4rj0QWe8DmHRnfRbCMeoXG6yd0ozN32nTFMrPPEGE8hY9STzClQzLZWPag29FxHjhqUn2DZbjrcw2Wie4Ag6nlqomL1D5FEmbo7ZAZRjR6DF+qPKfmBD3Hzu7maVrKdOeg5pXvQ7D1sBZ1AsJsBdFHlm2e58cl1FdE33bgS94ke+MPGqqaDyGLZeA1+RbK1UQ==
X-YMail-OSG: 99d1Uv8VM1k7bq1j8sQwU2pqMuan_iL5USEN8rIXvfuSodVZ.arhN1lvd41Xt7p
 nx4czDdSA8RH6Ua7X.ATMhId9yE_r2TIxgdm4FVA0WOAnQDCxJACv40CzhDkCpUaJ4e1wv09oC74
 48.FfMxFpS_ZqE7zJEMSjEuUxlrXz9LcFK.2gy5K.2lPxUeQp1rvQPymfomODaeLotd4dOKk1ljL
 GI7wEZsVlmDsyxZW5.4950bgLR6jpxI27GAz8N5zn8GvdovtGethbMvZ1Pq_oIY5xF1zNwx5dnhU
 oqX5._4lT5sssO0x5Fk5dY2wdk0ofP7f6x39qjvpY4_tFfxS3Db2PBe_XITbId4bfhOrLsfGxAUn
 kldKDvcmP84vaktdRZo6.ZJiZ0hSKmZkqoAGa3_Axg93Wy_iJ..IVR_Gg4dq2Uo7ZB_8XrWDz5Tm
 guc.CSG3J_SaIufkdFH646keG1sfXnqlGeSVKYUdTautXAYb6KyHoywGaHVDp_dF3mMRu4dydZeI
 vUT6U7mkyJmZ6YVJMkg9JUYX4V5oY7avFRjSNIUUTFp1N._t5z78Vag4OT_8BBSqpNKKGvDzyGtw
 c1vdB.MMbRRUdVxxYk16CNwGde5wk3WESC2qAyXhzq4DzxlpRz.Dq2rA49fCkQNGDyiDVlxcjxux
 T9IylmXCOKK4imSCMaxicDobpDl2yEUPa6VYMP29KhZrxmpMXTADaFBz_TiXujLMUdHtYi0pwQ.F
 c3ZTT1WPm1AbRXkYRnAJKml7AmD9A_h67A6LJk9VVSG1_rJAqd1d1J5BYs0Vp1f1dePa2cAHIn9l
 mOjm8DgOSnwru5dTYHJlKzutVwwqABQZWIO8bY3evRBHyWjWqY.OeONs6EtL8O3V9ENhdSyapFEq
 OJsvfh9_QEjZOP1qDOnaJD76IQ_D6RbGL63h8wDvkKz630UpCZvx42dtCfEsB5r_MLdN_XG2Xkzz
 vYOaxFRAuFFUksb_7pGjiHRPlv.ru35DoNbHERCOKCKhTfPYgJjkF2BVn4yZEZStDldv4hs4s3HY
 QPkvWZwgMXoApWWXgYhWSznT38.c9bIgF7o370Pvko8lTry_3Uigz.Q.bOj1qZrmFbpEueUyrYnQ
 nWiigFPq0yCuEDz6eHrENtxuGUeSn4pRNRx.AK5Q5EgGaX8UB7Heo75HJoDBHZ2fQqGq8E5dz78d
 EXxmiYUedScJ8n2EDK6_pCRtMiMvblRbFDAzzWEHA0hOVBkRhg4O7BmdwFto7kqYXlNLwQGvm4Ca
 bFIt67Zvn1wHZx51iz0GsBc8Z6KyTcxewqRjMq1h9v.ldFQjNm2HCpacTz5Z4W.DcO8J.BBaDCFp
 dp548XPwG3dMUTUlWlMVZLerxLZ02LL_PW3AfCREYhMFOmDL8_D7ATF0D4FkVRum3HtYC4d8tcGw
 lUQMovt..Pi8tYBipQqbaMBTEdXLN5HYcwMEiWqTJhunKMNrAK4jiIIw0gGOnbqOwfgKfaBeOvga
 QKWOkATRE_ve8z4sPvp3QTp1s9jTBDtJHgjrYAaZVceBoZcARbLYWDDAa6RH1hif9av.lscYjm5H
 Lgj7HeT3iBfxxFhiXn3AjTYPNy2QPd2mi_0p.vp0KNu5pJTQmFjkv9xByNVj.LewQda1oqOFbn4J
 GyP.pnxZVgZE7gBcf.jsqLLEHZyQIKYhhhQ4QZC7WrVfwi7DpZTSxFKxIfnBTOL8u_11Xzzo45hS
 Quai4SXOVsypoq254XvmzzQMcTEDXy.wnCv60iwfAVi6kq5d5dM.68PBu005fE5XQV9.WzVd8xt2
 Tzj.uU7bkh76YSAfaERHP5Ug_aMxBT47002l81NE_U2APXVMglYK_YOu0TmBO1rkiHyGyY2gC965
 vZlGuWaOc_kaUbZZkqU6A5N2tfCBY2r9yFp7nZMUUM83R5t4nl0pT7i9u9GjjyxxCsoYyA19G4.w
 _Hf.t9ocJB1aFp51jiqrDQppw2QzIohpizUSA3WvtZrHucseu.MnvhO15tLhpyg6nR2iodyBHQLE
 DVHiJXVFDhBgxzw38vBzG7GcSwH3e46IZ6e8H6ileUtUsh4N7oSd6t58OpEpa.xhmEjIGxcIh_4v
 D_5YC2fWX8zGf4vGeafwWfogAOxi3PosHTtk2_ZewWUG6aDu72LJWo0ohSlrivI8pkQjaINPXpYG
 rWSYIlDpiHEyulnwkkULUTH2jsfxQB4OLBsp21Ta0IsK02LYWtIPFY3wGMMefYpbtNBhjPuVG.EH
 n3kVO5bu6qRbLnWriRmI4tEjmHIo7YGu2PtfMM9KiTWWofBoQJiFvI4stoYEjd8H1D75T89y5oKV
 UXd1XZc0RPANjCImG5nQkDTbSFgQEQw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 90d2ad47-d515-43bf-a762-1bd92edde19a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 17:29:16 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7374b10bab8e01c99c92e4838c45fe8;
          Sat, 16 Aug 2025 17:29:10 +0000 (UTC)
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
Subject: [PATCH v6 0/4] Audit: Records for multiple security contexts
Date: Sat, 16 Aug 2025 10:28:55 -0700
Message-ID: <20250816172859.6437-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250816172859.6437-1-casey.ref@schaufler-ca.com>

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

v6:
Rebase on Linus' tree.
Drop the alignment change patch.
Finish changes from review.
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

https://github.com/cschaufler/lsm-stacking#audit-6.17-rc1

Casey Schaufler (4):
  Audit: Create audit_stamp structure
  LSM: security_lsmblob_to_secctx module selection
  Audit: Add record for multiple task security contexts
  Audit: Add record for multiple object contexts

 include/linux/audit.h        |  23 +++
 include/linux/security.h     |   6 +-
 include/uapi/linux/audit.h   |   2 +
 kernel/audit.c               | 275 ++++++++++++++++++++++++++++++-----
 kernel/audit.h               |  13 +-
 kernel/auditsc.c             |  58 ++------
 net/netlabel/netlabel_user.c |   8 +-
 security/apparmor/lsm.c      |   3 +
 security/security.c          |  18 ++-
 security/selinux/hooks.c     |   5 +
 security/smack/smack_lsm.c   |   5 +
 11 files changed, 321 insertions(+), 95 deletions(-)

-- 
2.50.1

