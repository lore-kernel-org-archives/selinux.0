Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF021C17B
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423282; cv=none; b=Kim/T+HLeQE87qopbTo2z0ujzbkZTB0hae63DQOBu59Y83Z8MtGz3awGHoIU7ZrOyHAbWzr/nggNOGqQ82Kr93hI9eJrpTfmTDx4SxS5lKaZ6RV6J2iJl4wHPSYnrzpe4jm1vQwXkdP1lN7fjM5+zNJWrAPNWCJ2ZODX1K33tD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423282; c=relaxed/simple;
	bh=sRz2BiU8Y8mQzXk19BZ18SfvUyKcB4QPv3377qEFka8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=P0pcwvxUR5ib6Z9jbF5qaIat7t1OhKuufe0bA317QvdlHPzU3TEiAPNuLnvW7oWQsUBY+EEYXU53Rd+xxhXptbMNvRQd1H0QLyj0vFiHaF//4PuEOtR8gnkz4fkKod8BqVIYYTp8lZJftpRXuOSf7foGskTBXFulsue1HTw+r80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ePlgc8y4; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ePlgc8y4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423273; bh=gAnxGggb52Au55yCpJeLGqRkh6FU+lKXXSkEtIgqIPA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ePlgc8y4eoCvlrd4KfX3oR0jPaV5Ol1r4ipxKk+YG57R0T15sv5gROh1ZZ667X/fgpC0s0ENF8miFnICE7DgM55ZFspEvMl9TCrHgbSSNe/njJXoZ+HoobJwfqY+MHU0meS20W8UV8Y3PzIXDBE7ZMFr828+016Xic35/JTG6mFP2BMX3Ydc3EnBExpdD1t917NXO+we/QJPqlS0bSeFLC8camVlg6KvtHmPRi/Fxp3v9qOOfiGZ1KOb1bNZ1Q9qhxXt8730xpAIe6sjihPJmysXEnU1yjJMA3FZogXdgQvhrRS7Jxk8KE4WDuzLytTNQvsNrIQN5zNcsaeUtGcTvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423273; bh=kXt57kDgv8EsxHwb2w11kW/NQNBmTdX1rTUg/7LrDkK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=U0yWafC+aCrGhVxuKCRtl5u4ZGfoIOYrgxRdhmcOrJrHjCH78xyq97QfQ/W4FOUrnXcHZKb1fpgUup30l/j2/XrnFjMo5UgWntjexYQEESKEITdaiEa+gM0lf2jOKDIPXIi/49Ny5lI0uXgRw70rizqmL7GaQq5c8q+5APRIsicfI56MBQSFcK7M0RxWV8Qmi8Lecu9rni28bmOZNp21xLkvBDwS4x43WlZ7ELsfzTiu/fiWZHEKtdE0eQLYm6iO4bxOBR6tIHzTCp8Ca0rBjJ27lKcNxK+PQ0Slz3BzxSHzwz7Lfg6oJw//Oxqi53brSgZxZPg6D15Me6ucNLZbEQ==
X-YMail-OSG: IapKuloVM1nhWKzRo9k5vimV8u77sJMe7mKiPjhR.Va1PWu5GAOK_ajB.PWZqh2
 MAx1f7pGvqsgj8zyJk1gOYiR5HyvR1k3FwEAKvrzQy7MHkMVYNJgWip.9lnjug2nhoPciUOt9xkr
 hJhSc6gHCuuiXglzKuf8.sfPPyyq2.B_bN1EzqO1jNGpY2mP7IJ9lgC8ZmRDvT07kp8LZqfrna.i
 UcuQlctf8urIC6WvNRCLtS5KEk.AKLYsu6UtHkne21r7yM7HcdSV_sWa2u6V6FMBWEUVtyD4WON8
 xPFrdQlSn6nYgYJgAneK..eqRpJrkThU4k8DPeLPcYq2lDm8WomuHcE3iLjZvF7b9b8QCCE2F3FE
 I6sEFTx_WhQ7dpPAEC1r9gY_AHSQMKw3KmMD_LSDXXrx2RXHYeyvO0KNOmta1ovjiDONBgQI4tvz
 Gnyh9XVEpma_yfz4BgHRzkrgrBBBkqBRACpYkI6DqZY_G2bFKXJH6JZDneWPTvt2Q8qvVWH.HHu9
 LwtMrhQmXBhStMPBF8BjXsrdI6nMa.trx79A6FmOyriePYSSMskyfTub8a_BoNz3Jlmu_bVYejno
 Mbzl5iDk4YhcaC7De.UfWsUJiaQWq233mHfqPbSwPdiYRkFJa4T7QB98Gvqi4yOunGefEmhroPpy
 eppNguCDwavkC0L6crgGQczTNH7opLEt_BMTRdXZP0.5VKf6cNThigewb5GXcgkVGdhKigXpzAeA
 .t12pnsZDl5d1pguynvQZJnL.rlv1Fowno3yZx0FoMYpM33I9JPG7WIqPVQ5ppxxtql6a3cOLUYE
 eQZlxjTnfckLLn7BcDxQiXKnEy0H_4OWPqivvKZbYbg.aATIcPpUhHzqpzqGdionHJv7vrpE5ITR
 x9QTQi9HVV9r30nRnMpil4U39KsvwK5SbvU5gyFe64aTl_DfCXKGx0N_V_a5VFow4QhwernX_0sZ
 a.s8QPRN08a86aEYIj.85Lk1AW4kG4fCO4H_CqZ1gME9y6a2vXGYOFLeH06sHF5tfJI.TQ7qhs6n
 yF5JhOlkEFLWnsGxHeuTZnXo0SneqcWNsmE_yk5zse_zIKtwP9_EZNUrTaH3RKklPZZCMef9y13l
 l.M.DNK.1c7vN3o4b0Xrpxd_hOmPfv_kQEaXrgsGaBlGhMhfm9bJ32gyoyQJzfBWFdXPYo.vrbbW
 T2Y2CfzuDSD_P59pT.1lilJJQaSRK62Tr2soT4VCr_37KOlh6.dQlOn.cGNUOrs6R3maG.RR_l1t
 YJGPcz6xD2muvgFuINOONSfICkuWfbgmDGhtzRJDG.ivXp7omUemXSZoGE0rqdrM2SznDb8yKAyT
 wkr0sis8s0a395rLzsgSZ4sJR1ivvL5bsBrS8LF346jZM2v2vhjZM_G2ouw31M53vl_4W3nNLQbt
 KjOVvsmNmAqRevcF.YgnCT6xDdFUFcVZ9te7W2cVpMwxWxN0NgjwidQdZqIBwXNRi0g6wLpxCA_O
 n46KrZrsvynF6CYKC8On830J6YpYV8Q5u5hst856v5KNqmpLiUPf6UUu3t5eVMs6OOwYcR82EVyj
 RxpL3j5WQW6bfgJuzhexFQvMpq.ZIYhItwf9pk.is8W3ikDDGVWYlkb50bx.fqe5VgsJYDI9nQZw
 6lo.VPnj57wy00.xZI3.2sawoDeqisfzsnjvF_KDX0DA05TWiL1CDWhJQKBbPR6PoLpvob2Ivwv2
 9L4vgWDolAX1PJcaDKBCkD9HxUBIOg0vmPIqbhSDVjPutWpYLxN2Q5ws7EJadl7Uqx5Sde_XMiEw
 9kqOSGq6nGoaqQhk8pjyNQA_eTDilNF.OzFU0Z5mqBoRl2cYcDMt5A5PG5Ko6Ntm0nZAQ2TyLZC6
 23VF0ExEZ0.oRcnMnNU1WXRv_90Erhhms2ufLuj4JQ1SPW_gS4AqJJmQHlBI5ihqf3lUMC.J.jMT
 78KimJghG0It_UPcz7xQXlnK2kwnP2kX9ultCBu0WAGh9b_XwDbySfEMMzM07TWivlqrdOfA_4.B
 KvMTAgWYQe2Us7LDnF9tTPDB7NgJmtPVRLBvU0pcJDlKqrz2R9EEawl6a35xGf1HfoCo9NBAEUou
 gkUGvqKqF_x2_Z5SyrDQ5VQiFKJ4X68_J11FlCK6r9Wm1trg25GLo_WEYFc8MDuVNqvpg7Z90uLv
 IlMrDA3YRFsqYbjGwi5IneRVMBuDvwnig4sgRJL5kW1zomNB8J3yIHCGmLefMwaFWUCa.PDPYSiy
 MneAEOVxAeUsyPHT4xzD6z0FO6x3MnlbgwwhvWmmLVCYSet1WA2i4vTEJkErcPwYYvMjefPwdklQ
 NXv6bGf7trKxQte6Qx4otwQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6cb43d66-bab3-446e-91ec-94879a8a3b3f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Mar 2025 22:27:53 +0000
Received: by hermes--production-gq1-7d5f4447dd-jcqz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e9bd32085bcf3fce38fe3767fad9b05;
          Wed, 19 Mar 2025 22:27:48 +0000 (UTC)
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
Subject: [PATCH v3 0/5] Audit: Records for multiple security contexts
Date: Wed, 19 Mar 2025 15:27:39 -0700
Message-ID: <20250319222744.17576-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250319222744.17576-1-casey.ref@schaufler-ca.com>

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

v3:
Rework how security modules identify that they provide security
contexts to the audit system. Maintain a list within the audit
system of the security modules that provide security contexts.
Revert the separate counts of subject and object contexts.
v2:
Maintain separate counts for LSMs using subject contexts and object
contexts. AppArmor uses the former but not the latter.
Correct error handling in object record creation.

https://github.com/cschaufler/lsm-stacking#audit-6.14-rc1-v3

Casey Schaufler (5):
  Audit: Create audit_stamp structure
  LSM: security_lsmblob_to_secctx module selection
  Audit: Add record for multiple task security contexts
  Audit: multiple subject lsm values for netlabel
  Audit: Add record for multiple object contexts

 include/linux/audit.h        |  19 +++
 include/linux/security.h     |   6 +-
 include/uapi/linux/audit.h   |   2 +
 kernel/audit.c               | 255 +++++++++++++++++++++++++++++------
 kernel/audit.h               |  13 +-
 kernel/auditsc.c             |  65 +++------
 net/netlabel/netlabel_user.c |   8 +-
 security/apparmor/lsm.c      |   3 +
 security/security.c          |  13 +-
 security/selinux/hooks.c     |   3 +
 security/smack/smack_lsm.c   |   3 +
 11 files changed, 291 insertions(+), 99 deletions(-)

-- 
2.47.0

