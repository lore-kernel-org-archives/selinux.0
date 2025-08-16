Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EC1A317D
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365285; cv=none; b=ZGKkbuyu1wgsfGPsPJBMQPlR4ayOq2vFZzkGCUnVJsfv131OIbjLvb8xd6E10YSM6qHJSqYEfpqI7/tIas10ZKnOsiypFylTneHTGkcRMwBoUuwKVt+8M6c7JqhEhKGlPBoWAn1/4pp3Q5nxKCj/PeDyoMijIpOSlguoNgRhFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365285; c=relaxed/simple;
	bh=qfd5Bpl29LjbUuYcluXS6+PkRhUbGbXh09AU6IENGkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5fMwClEBsr+FhGlqmHjtHRPIdojt9z9KE5Vb+2V6imtHjQ5wCOIK0rlpLM3l2eIFjLCPQ/BP1uQhCQOJ3xDPbNqtJdT94bFQP1PrLUcynjYrwypjAIxxcxeN/6w1xSn7/ivds2Ya7apDJXt+9tLKontdFu9NCaSEhHdffSitSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=il+Ei518; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="il+Ei518"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365276; bh=i8DayYv+95JsTVimWEBfQAF5hYZeMAz3j5aY/gIoeQE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=il+Ei518Qq207efT+RmQbo1KQd8rhr+sMApI6n4QvQb9cxKl8LXdDG3DfeIpq75YiF2l4rx7Jen5sARihKUC7JGtn/zPe8iAAMdC+zWRn/KsNxFEAaKq1+OM30UAiAojdvCzjdxX2ShNcfRDWYy4kg8nHMjk8QpgDeyEBZyxCoZOp5ctxz0Y6IcooGZWBh0rqJFT16sfX8K8tWsFRZeVmrq94PMaIkZV4fhUvNXUs/I6so2UAwgmTX3aDt+IadrDrBPxzx54GK3T4tWfI7Vnge36wpjirnsk3rKxsEDpLqE4C9KAQZIa4jSfIyBE2z/Ea779AGsELhe0TzqT1xi37A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365276; bh=tNje3rHJRdLXlmNVOri2AM2PuYULlPcH2Cr1ZwZ1KH4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UjNkUDIQnRmUg9gT5E3VJb4ZKjWTGj/hgJzVjGI6CNDdoQd88/3+vXgnkXzNmU8yKwZIttkSS0ENXYtDSO54HDddVC3FB6J5HAXezSbAaM3CSFqCP+csBxavElOfaTsIanQl6Oyq2zbWsXdjtIdKXtzcTuqj+pe8LS/K2OJ8O6YnyaxR9+obGossGIQXQEvkJyBw/Y3RdZtJyHo2ZLH0R+3+ajirRxzrZIejyTvWbUfWmBzG7p6NqhGzNZK7YJi5iyqkds4IJ/hSX/BUb1QXYbCYpeid25YvKbY8FuKxNSvwnfMKTJFAJhP+297jSQAIp3DRxVYaJ+51IeaoCHAc2g==
X-YMail-OSG: La05JAUVM1l6C2gpIlsRgjat3TOYEPvoifJKmbaMfP0k.hCiUO3wMZDvqhpTOJF
 JqqmdRZZ_Sc2rB7tV4_UgcI4KE_xXuCFdwUVhmT5RYoZKUkmxXwRIlfQOlv5gvV7yKyl34ElWR.6
 EWf6tRuDYvZNfFsjWSRVA1Nndl.jWwvuln7S2zRtwuTR16D2lmjXa7Shi9Dq4M50LrmpvHsYrfws
 1eWljiJ2D7IZajBfqVWUMYOd9mfNscznR9dA2TcGK5NVgSuIzDNWijjQJE_sLWvsfjOafFRT7463
 oK6WEQLq_50cNDXsJZzgUGAeJKUZkB8YqGXxWqcnlHMtQdurXB.hdEFgEKSsL.kqEOI2ZN0eCERt
 Np_.UNsW8ND5MyuBxbgby6U70m_c8X.Lm3Y6OqJScHIU4ZTk73K3EEvMSkd48wMxFNKFp99bLhNU
 8nT7A3XfknfOG2ZH7JeOW.RuQN.n.nVngBxBQ55byXoCqEYWInI2DZILl7MUp3SR54MSjx8eViuQ
 MOBVrVkwyFEOoTChZo5UewVKbPv9mKRoXEbWLqizJ2394CT8vjymssvi_m9w3TZHcBGmiuJLZg4J
 Jh7O9bMJwSB.jduefaUxGbI.tN0oZXYKD5GcuUf.Gq7Zl4jqtoD9l8gqRo7YCKYQHgVVCdUc9vgo
 TV9DiHivqJFMjzODXcw55PmYN.rnH7gvL3EW9pgeElaV.03HDaygKbURRONQ9ONcCD7kKMDKwvjP
 5VO5EBynuNb64vj_mZfQwtmwGKLoNEbpyoIVSScQUkiesjqT4IyAUx2KIa2rYmrC2_mGJ.1_4bOL
 6Ue.GXnoLzK6ldknHkvzavMpia1jAI0K_any1rPQp5YBZRBG1CFbPmXvBV7ClQzr2dIwGQmZrJt4
 vqV_jr7u.y_cJxUqBT6Db5ObMRiDKFyaPAGi3e3n177pqhc5eA.VO1Tu7mwn25vnw.3d3GsS77hj
 oeU.2NU3hUTqld0dBcpBm4dOPedk3Na05U1u3Pcw6rDHxE5i5WryHq0dzlVYt_7SICGSA1oHP1PV
 TJPE5ctK1ZQP1Ol6zVz.rZEPGAVzht9QFLvtg4n2Ar2rP5u0Y6FRF8DthCKneRcbI752yLhYIZwc
 tVVCNl1K38_jvYRk0PUIXZkATL9ZjODPf4kEVilbSMEc99LVWlZUtXCnxUpbV0xRVqYPKfAHOU5V
 iEVY_CExQhkG6ULYH9r_LiOcwS13PAICjLo4vSyTWCEsKzOaey2aeVDiw4IFx2ui8OnUs1xaOFMA
 zvvfSpE38Nhp4HxJxtNZgHUR3Th2cgGDQADLNwFInHyIMB6qwNQRMxr0FhzZENVnnEDaofdW_01s
 50QuJgoYcl268zqpzEi4aCmFC6KIpAeKm4YUcrXz5UDJd0jBAAU_qUbEkEz_0w0aLf28xgJCJM7_
 bWOLEiqalYe0IzxK2TaIOo1VecS84IYk43zk7I9kxd1gh.96kxXtemEMPhBcD9FkIo3EEreP_8pB
 2U3E6.50.IF.vrSv80iBS_pl.VFPs4cL3S8.Uvf7hK3vbGFZoLqegW1gPOgSN8N8zGWqoSu6kWFx
 ZYfS1v0732JGR5U9Xw.J6VVSsqxXFIU89fO2YdDrDKHEm9xYlosAE_cGnYDT2zb_lgsLeAztJfZV
 0fLk8QRCgN5gsPZBefLSEYcsOaVX6LziNCmTLENaRZ5VDE3rqKEMtomCrOy6XTJjYpTp_y2GGVDQ
 rmW8I0OMfx.fCARY3vhOJnTPyj9ujpH8n9YAPq48DnjPyzzx1sbkJ8IVwjGdDWRSk4sBR.CEfQLd
 1eDW8OREi1wQy64jFSEZ_dnxXPE.yUd5VU2oDkWG1B7BBpBj0kY3zcbO6GPNebcu71w8uruYd5ON
 Xwk.FP9iTdmY.7ffWbgPsygZk.2gwgfOSayD1FOGQmtG8NUAnCebAlbXlJGalebF2Opms_IcGeVt
 7lGiwgvNx4zvKv8gaaU14B_JuPoO5axNxS7grsGLkkAAJSpmHa7xII5dpShjW9l6c82N4Swosjv7
 2BQxvuDMUsTKljw1OIRc.BivcY1urIGssVkYEr.b1yNsOLZKDY9vqlvQDRYB9zmpttdeqgPD_tzA
 yJLXfJWdNN4FtXW2.QQyGwL082iYIzPBmOAWZDKab0cn2pgAoTCOfv8rCjPqZlDkaloZ9Kn7XomR
 rNwIJHk2fKesYXLy0CMI0LqX6tCFCxi1v4zSOaid0EGScsY.tyuw33rjp6irnjDCspN.eegh9lle
 _Bk2_6shZn9fR8sPmQJLAcOq7FeeU5oAu6jvKeV2iKpQsfbpRf1pJSSk5tPHs7m_5Beui9B5LfCi
 mBd5et67LFI6OS7PsrnwtpbdU
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 00d65f2d-0ce4-4459-b992-21d0ad94126c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 17:27:56 +0000
Received: by hermes--production-gq1-74d64bb7d7-4ndhm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6030f5619f5a29a549fe58c2f4d3ccdf;
          Sat, 16 Aug 2025 17:27:53 +0000 (UTC)
Message-ID: <99ee372d-ca63-4dae-bf53-567a5dc69be4@schaufler-ca.com>
Date: Sat, 16 Aug 2025 10:27:51 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Audit: Records for multiple security contexts
To: paul@paul-moore.com, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org
References: <20250816164140.6045-1-casey.ref@schaufler-ca.com>
 <20250816164140.6045-1-casey@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250816164140.6045-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24338 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Opps. script error. Please disregard.


On 8/16/2025 9:41 AM, Casey Schaufler wrote:
> The Linux audit system includes LSM based security "context" information
> in its events. Historically, only one LSM that uses security contexts can
> be active on a system. One of the few obsticles to allowing multiple LSM
> support is the inability to report more than one security context in an
> audit event. This patchset provides a mechanism to provide supplimental
> records containing more than one security context for subjects and
> objects.
>
> The mechanism for reporting multiple security contexts inspired
> considerable discussion. It would have been possible to add multiple
> contexts to existing records using sophisticated formatting. This would
> have significant backward compatibility issues, and require additional
> parsing in user space code. Adding new records for an event that contain
> the contexts is more in keeping with the way audit events have been
> constructed in the past.
>
> Only audit events associated with system calls have required multiple
> records prior to this. Mechanism has been added allowing any event
> to be composed of multiple records. This should make it easier to
> add information to existing audit events without breaking backward
> compatability.
>
> v5:
> Comment on the LSM_ID_UNDEF behavior in security_secid_to_secctx().
> Change some names to better reflect their purpose.
> Move alignment changes into a separate patch.
> v4:
> Use LSM_ID_UNDEF when checking for valid LSM IDs in
> security_lsmprop_to_secctx().
> Fix the object record to include only those for LSMs that use them.
> Squash the two patches dealing with subject contexts.
> Base the patches on Paul Moore's LSM initialization patchset.
> https://lore.kernel.org/all/20250409185019.238841-31-paul@paul-moore.com/
> v3:
> Rework how security modules identify that they provide security
> contexts to the audit system. Maintain a list within the audit
> system of the security modules that provide security contexts.
> Revert the separate counts of subject and object contexts.
> v2:
> Maintain separate counts for LSMs using subject contexts and object
> contexts. AppArmor uses the former but not the latter.
> Correct error handling in object record creation.
>
> https://github.com/cschaufler/lsm-stacking#audit-6.16-rc4-v5
>
> Casey Schaufler (5):
>   Audit: Create audit_stamp structure
>   LSM: security_lsmblob_to_secctx module selection
>   Audit: Add record for multiple task security contexts
>   Audit: Fix indentation in audit_log_exit
>   Audit: Add record for multiple object contexts
>
>  include/linux/audit.h        |  23 +++
>  include/linux/security.h     |   6 +-
>  include/uapi/linux/audit.h   |   2 +
>  kernel/audit.c               | 274 ++++++++++++++++++++++++++++++-----
>  kernel/audit.h               |  13 +-
>  kernel/auditsc.c             |  65 +++------
>  net/netlabel/netlabel_user.c |   8 +-
>  security/apparmor/lsm.c      |   3 +
>  security/lsm.h               |   4 -
>  security/lsm_init.c          |   5 -
>  security/security.c          |  21 ++-
>  security/selinux/hooks.c     |   5 +
>  security/smack/smack_lsm.c   |   5 +
>  13 files changed, 325 insertions(+), 109 deletions(-)
>
