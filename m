Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FE195FF0
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993700; cv=none; b=pbqniIbdmse/JmIPAjgCHnnPRC7bLTUINljNzuGw1eWSNuDbI3MmHYciLhDYbsZdAFtymk6T4k62dc/dPrPiQh63yBzsSNpG3PTYrd1rNerD3sgEiVFSd/EzQl58TcP8wpES8/yHXuQ0tPxBKQh+8bseJR+d8rKPk8abV5blPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993700; c=relaxed/simple;
	bh=Q7YWA5zA0NIyHrN/KQP/n5zchegq1UkLHDoInrF/+v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=qaKnVEbnCSIBiY8W75a7PheKZHZ5I/5Uks+y8s5xajKKYfjbNRzxxrBPrj86oZNrogoUDsrSHoIG5I1VBl7HeaTXYXcFeFJIzaHYy5mlF3laipACBevvR6UcsI5PMc64MBg5HvjlTjbdaOZ4cYrTUZsAxI0iirXKTMAOY+cwqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=riT0tC5D; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="riT0tC5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993691; bh=/rR0ywMhT239YD5c8xgShSWBcId+VbspYYpTTj/7AtA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=riT0tC5DNmTLJ4c1seJxuck0pseN6QJG1Vs5FXzwyUSKVY5UlXU/ANZyR++QP+aa5eVvRDYrS0csHxPZY6tarWQAMIEBT6rLDba+O4bjC35FUOpOgNamTJwGrU4ISMd4Jbzb+JAbSwpNQi18FtKpA6Tnnm1AD0ciTFBRvUzL86qiz6NvsF2Bhf4g2LhlJVjE0GGVeYGUQg7tH2wpCxWYOKP0UlK13SCZ8i+1fXN/ubAQ1bgr2C11PLkvej50pwTCHMwVxpvOXRlr3mPYYuuLaA/DFP6RRVY5W4MBcg88nNt/Se+fKVsTCthx+71Cznc6rENAeQ1rYX2uBm0Ez6N1ng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993691; bh=XPvP4FibaskJrKq6Y6mfBjj4sJsCHaVs3ZWuTvZhqa+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=T/4DEPNihkYMAwK2IB7PKel5hlVgn/g3mwqsT1KVDN2fEY3Uii2WbZjfvU81pNN8w+Rd7oubPbLihdhmiE2aRTPbew505WvCjdjUpJjR3iu++N5iwEtUpnmOrzvw4czEeM1WbLIBfRORwtM/e87GaToDllfF79HkWwUHC8d1FgPGEAbNBIn6u0aKPcrLJOpmz5p15d2rfdJ/YiE6ENG+Aivk16w54c2FQ1BgVXhcyGh7oyaSLCp7zO1vqgqRkRmVl2X7PBcIMao31gKC3FA313QNN65zDntOG59m4sNN567954BAQH43u36znJQyxzbTECcKGVDcxrUjTkKO9CUCTQ==
X-YMail-OSG: FwndeYYVM1mZxmDXCZXFH2IPvfP6MbDpZokVWtiDNMADmaO1JilcFq3Bmp3_71g
 h9DEqrB7jWhNTJb8.M5uwhAU0LE2enh5pddcxS_mbw955Te7buJoPEo5V4Ri3qnldPgNpCTzmzQf
 K0.46eNKJMHtT3DoP0MHgIY.df3HeRqFgPh5OrN_Y1aVT6xWY29F9x_UdKpmXbv5nbCsAqO6npIt
 Y6T9E.NHl0XIwMQMBD8wzyIcWDRmwPbPWVBTes.XPAmKIap.XiqDpSiRb3hCQ8f3w10XikaOGMaZ
 VrgyJJmwg1dBjbll784dZnJesAXNZJjDPa5NiuxroB45i6SlRNMWcClfavZKg4a7zfBEFP31uVUe
 6tTSr9jRbq5Oc31UhyeZwr7btLC.btJILJE5Zj2mzvUz4zMFifO39H9GaRBPbJVJ_5mFrbjYKuW3
 KifbxrCZYcoHUDs1qXbBS8fSte_Sr.Rv1K7A0ljRZe6gtUBZPC.rNEGNSg10jFSOJAxSzwZeQylf
 MCTKDOdQ3.G0MhFyzsxoGHUZFuApWzoNHAQtNLWqxVmh6zDQM5sH8oExnUC.fjhJ0MVLcY3oGduw
 VEvpc.0PPlINwQz3gS9kb9Ty36CEbxFcbQTIgpmJflV8i.wlRf6kgqoOjl4D0mRPhaXRJXi96ARP
 Oql59uybKyksq36okGtW62qt4O51r3BgSLQMt3xZJ1KjWkQl4F54i6_Zn0SfV4cwLaE9006W_X4H
 bGHHBchO3M.GQ94BwgXhi42TEKpg7hsg4KttFSROGC7NcwvQrb2j6JbuitUtgNOonsQHqXYm2Kuv
 dKT4m3Sxw4mLZI6ApZsshNwLyiRMbwScjMj1dq2r7NJsw31MkMGHRM7KTM0Wx4kjIvJdE_1moGD6
 8fpr5VLsPuhLJW95OmTeDlPtexwnpYr7Q4Ba4NvyK29xHe0FdJLZ1MQyt4wqB5ZAhqqC1Y9e5yYP
 XWr5XMhj.RuSWXiyEWUQlESpQTqdURzzQRIjfkLBzlH5ixwEow6X0op9aeDdxKpXqSAJDaitEQej
 Hii27DgOHX4_GxHDxbNG8A62L0vg6dB9boQHDIPBb8TtVwPQscgCb3O23KzFD3dDSjI_DNMxuNWE
 SoFLrSQ6xNdZflk3Ymecm_10nlRwpTvXizMx0aD_b3PVQxNkUagaQtvFxMADqQqRBQ5h_2I5fuUd
 7y3nomX11ibm4FycwfXdbDEQbcyRipyGJSG7vBMW7P6WZoBvzwoR5s9XQWtvpt7nHxq_NjM7Qj_p
 QKXrIA3VNy9e3kI3XOvtVE3eFzToVu3EZ6AQV3jMi6PoXnSz85MYVtu_3nsnX7idAxTOfMGg7wQK
 TPQnF8mLE69YtKLnwi12rzwRaEuKanFNCmcG46H_1KsonORValnZwN5PrlQo6HKZUGQn6QmPgX5v
 ZMfdYn69ZFSodkUXxtbnQ1mZQXiVELCZjZp7IZjxR99fDrgExsui2YscIUnOcF4oBrZO2dYz4h_.
 QF27CqoKViUiugUAzpOiPrK6wkIQcgzO36d.LG29mJVEL7C3l2tLLj0mW1zXfCEn4UjtTLnj5iQD
 _VbMWcgLEgJncojzrDhOSIfCHrO5936gtUngsG20WlI3Bjgm91I7W8fp89zpsi4TqO61bNpOAeIK
 lDZRPNi2TsmB7ArcbPSq7cOtOEilWA77msKvzYKpRqO2QULAPKXqs1.7VT2Qg.76k.2XxutNgb1B
 qAt6Fdxfb3X.Xl.TujnZv8MBnM.In0YDtI0t72Td9IVCWwjyAFMQ9po5AJTgyYtEhqNzmypmhkbC
 6NG3WDpTbQ4gIlk4uSYZ3hi.LHGrTfd4A4uy512J3ucOesswqlWc5idlA33AbZY0hWpcoNd5XhdF
 Tv9bNnaAjz0VoZQgk6FCFGJMlut0XfQEE2Fx6QFbPOCFo_6qVyw9nFhLjf1vX76zMGq1Vn1Aq08d
 uvdcVvLeqU3Q0n9qqbw4JqhLl1XnfQi2mtbFwH7CgQV6_OBvQjbtZ8JDaNh3UtjCYYfvnAVYLCkX
 Uo3xSKlYkD_4JspYQuJMh1hTeEOOX1UESzKXwIFyUF4asjWcUEBis5.R3NcfXuts4Cj2im4yjJGc
 KAxs5Bfbzb3K2E6wPdhcjP2UfTfY5o.frLGPJYk0IocpPp4ljSCSKIP7_NxolAmRqD5G9nVYLubO
 D1Bcydm08oweiH71XN1djBSFx8BZQ.oxP4lnzB9ug.JUeKABo4abFb2QArXN_wuowV8.UpDN9amJ
 7hemSJoftzjzy0r3EimyhiKg_s0hC3.GeHtkroCcvtyNvZpdq1AUB0qq4Wo7lAZksAsjfPWHPTUU
 YMU4CX3QpX5JbwWXZ0XshMCzGr.kA_DzCzA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 11a03366-5027-470d-bc39-0a506f64de59
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:41:31 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0f4d83cf88f6912abe79246c392d6ed4;
          Tue, 10 Sep 2024 18:41:29 +0000 (UTC)
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
Subject: [PATCH v3 00/13] LSM: Move away from secids
Date: Tue, 10 Sep 2024 11:41:12 -0700
Message-ID: <20240910184125.224651-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240910184125.224651-1-casey.ref@schaufler-ca.com>

Many of the Linux Security Module (LSM) interfaces use u32
security ID values (secids) to identify module specific security
attributes. This is an artifact of the SELinux security server
architecture and compromises made to allow security attributes
to be associated with networking mechanisms. There are significant
performance implications to using this approach, as access control
decisions must map the secids to the real data to be used. There is
also impact on the audit system, which must provide textual values
for security attributes.

The secid based interfaces are also constrained to supporting a
single security module. There are clever mechanisms for representing
multiple 32 bit values in a single 32 bit value, but they add overhead
and complexity. While the issue of multiple concurrent security modules
is not explicity addressed here, the move away from secids is required
to make that possible.

Most uses of secids can be replaced by a security module specific
value. In SELinux this remains a u32 secid. In Smack the value is
a pointer into the system label list. In AppArmor a pointer to a
security context can be used. Because the active security module can
be specified at boot time using the "security=" or "lsm=" flags,
the system must be able to use any of the possible values.

A struct lsm_prop is introduced to contain the attribute values.
This struct includes a member for each of the security modules that
are built into the kernel. Where possible, uses of secids are
replaced with a lsm_prop. LSM interfaces have been modified to use
lsm_prop pointers instead of secids in most cases. Some new interfaces
have been introduced where it is not practical to replace an existing
secid interface. This occurs in several networking code paths.

https://github.com/cschaufler/lsm-stacking.git#lsmprop-6.11-rc3-v3

Revisons:

v3: Feedback on v2 - Top Shelf (TM) Bikeshedding
    - Change structure name from lsmblob to lsm_prop
    - Fix return value in security_lsmprop_to_secctx()
    - Fix compilation errors when CONFIG_SECURITY is not defined
v2: Feedback on v1
    - Share common code in apparmor_*_to_secctx()
    - Remove stale review tags
    - Fix mistakes in comments

Casey Schaufler (13):
  LSM: Add the lsm_prop data structure.
  LSM: Use lsm_prop in security_audit_rule_match
  LSM: Add lsmprop_to_secctx hook
  Audit: maintain an lsm_prop in audit_context
  LSM: Use lsm_prop in security_ipc_getsecid
  Audit: Update shutdown LSM data
  LSM: Use lsm_prop in security_current_getsecid
  LSM: Use lsm_prop in security_inode_getsecid
  Audit: use an lsm_prop in audit_names
  LSM: Create new security_cred_getlsmprop LSM hook
  Audit: Change context data from secid to lsm_prop
  Use lsm_prop for audit data
  LSM: Remove lsm_prop scaffolding

 include/linux/lsm/apparmor.h          | 17 +++++
 include/linux/lsm/bpf.h               | 16 +++++
 include/linux/lsm/selinux.h           | 16 +++++
 include/linux/lsm/smack.h             | 17 +++++
 include/linux/lsm_hook_defs.h         | 20 ++++--
 include/linux/security.h              | 98 ++++++++++++++++++++++-----
 include/net/netlabel.h                |  2 +-
 kernel/audit.c                        | 21 +++---
 kernel/audit.h                        |  7 +-
 kernel/auditfilter.c                  |  9 +--
 kernel/auditsc.c                      | 61 ++++++++---------
 net/netlabel/netlabel_unlabeled.c     |  2 +-
 net/netlabel/netlabel_user.c          |  7 +-
 net/netlabel/netlabel_user.h          |  2 +-
 security/apparmor/audit.c             |  4 +-
 security/apparmor/include/audit.h     |  2 +-
 security/apparmor/include/secid.h     |  2 +
 security/apparmor/lsm.c               | 17 +++--
 security/apparmor/secid.c             | 21 +++++-
 security/integrity/ima/ima.h          |  8 +--
 security/integrity/ima/ima_api.c      |  6 +-
 security/integrity/ima/ima_appraise.c |  6 +-
 security/integrity/ima/ima_main.c     | 60 ++++++++--------
 security/integrity/ima/ima_policy.c   | 20 +++---
 security/security.c                   | 96 ++++++++++++++++++--------
 security/selinux/hooks.c              | 49 +++++++++-----
 security/selinux/include/audit.h      |  5 +-
 security/selinux/ss/services.c        |  6 +-
 security/smack/smack_lsm.c            | 96 ++++++++++++++++----------
 security/smack/smackfs.c              |  4 +-
 30 files changed, 469 insertions(+), 228 deletions(-)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

-- 
2.46.0

