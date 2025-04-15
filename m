Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64612DFA41
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733601; cv=none; b=FP22quo35cXGt+DrJPC03S+9oWekISZ9U2K/UCgbNa7iUqs34W86R26BHjfOHaJ5PCyE37JoYzGa1ZbkKA4yzQJjd5DlsrEDeW1ixNdmvf7Qa0I3+X57XEr9zOyhpvhDctR27GiFHHRshBuLLg6hesZlTDjC53NnkhhxELOWbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733601; c=relaxed/simple;
	bh=V+yze5hQz8lB1IfMX09lvbL0g1lT4RBGvyMq/xzi9iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDtNnliMu7ukDX6cJ4xeU1tm48/G1B1N+BsMO00OPhrIwPDsbFQAfvXgmK42fNi9xa5U8EaBOeFaE15tp/z2dZfP7Mbp/ECMZ8WRJexJ4N2P4UKngJv4qZ7ZslqdqEmW/owxhOtWn0XJTwbiOOLwoRJG6tMZUnCdqVLd5nxuPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gMXKjx2m; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gMXKjx2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744733592; bh=XNONWKl0jaudWlmwk2oEYdjO8PF0qEpq0lhcm/vXCEM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gMXKjx2mIshOPx/4hnZWhoLY15MwL7Tp6H+i9ClyR+GO/JkPCcZElTQW5sgs/9UQUuXpUiBIaZxGKFYY9CWilZu7jlpYrx650SJAjr/3NM7nuIkYy7Ak9inGEjYKSEjx199q3iIxU3Gu1umYeL2YgDbP+YEKe9PT5wJJQHgVNQdobw1x+K3LKj9ltKRyLziXrtjbIUZMS6cPLiayx74exYoGoWVanyyrt7b5luHMAGFC5th+x1wtjtpj4twzrY5hlR1AEpb6RtnqNamb8VfCPiW6tdBD8iWL6J0rzCBmunT72aXwp4mmON/bxaP+bFEnAsrfPhrDC/JI1XeY2vhyWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744733592; bh=xzWg4C5CztZQ2RZK3oKfaBX1OOpaEcI9z8NJCTg8jsp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=avOth21YY0THsvb/81T9NeFnAQz2ce259lwAwG4UwQmLwEd3TWO9OAFL8EjBsFtPypizYanqlol62/oK9pE9/QqAP6VoVbjRvUnAuGajthgyf+jhqeLdFapJx+3TYrPE8Twd09DqC7XGqNfkaBxbXoihl4xjPwuUe6YpPGCWGCk47xnwoWOMZWfpoZl3Rvhi85foGGWTA1gy0S9CAR9SZPgimAZ+YNOAv+ia7l23e/Bf6CcLuxXyjLS5TyNEI0effD6u1vm6ceHrMCCsiWOFNyUzVckMOSjxjjskh+QLVk40Rol9ytXvRDqL75feUfNMrBhCk8Sh7Att1WWatv/RTg==
X-YMail-OSG: ADN_yYgVM1m3z4jaaoyeySxawOtdGlyJ_lplipfhdlepBdw5s2PqpIY6UQOUhjd
 ksnM3pgZUPT2A554AToBCCWeN156xaHCrR5Fb91Drwo9T.57A77RAiknJTlOYwW_aDcUvtbhjN6e
 z_D26GnjuQo9vJFNb_BDVCjcje4GyKk1zhnzDq8Z9kdX5sjyAIt5rTKd8qGmJ8QN9I4PWjEl1gab
 6gc3FV4uP6PRfiNnmFJsu9WNVDNxtjLuu29b_cD1R_dxnsbfk79neGO2WNmiWNIz46XedSYLSuLX
 iK3ESits3z1nx4UUj455.RBMlkXARNKjUcGRn1H0d.eXVDj_vznDvf_uPcSEoPDfvBhrIEJ3C5Nn
 Ykop45Lh7A5EWxCW4tKIqL4f5ycSaUa64mZhOTeCBm7vId9JdofYISR4Jq1YoYOU3kRCW7C_JWl3
 gXszRK7l8s5szzOlqeLMu4zcrF51od4gJV3WpH6bm6o4Z7uACLjY3n4TMB6K4Mj8vgQFd0x9OVfv
 GIMYvFkEJNgt5Ylw0AZj3bWBxFa0kXT8Z9pbfP5Cmg8xHPCIn6SwE3btbXYjBglVTtrazct5qj_1
 5g02XRIG_w0GsXn4h7SKxnjG.LvyTTOu09J9p7C6hFfeTQiVjjG9iiteTIoBj4wo0u1L5oawD6cc
 gKcoHA49b5N1KUqsErwkAfwCbRi255cphWDswBSvTV_FRnJ.3tCb.95GEABk3BitBXEOyZ_ZN1.o
 shZ6jgy5JjIe0gWglZ51NGThZotkFWfN8UCX3fYfA3iGfqL0m3t__aTzjWNO518GQp9ndSUpixdt
 nuWk7qXTVNxRZvRATtjtul3sTOePyI2k.GZpq5neEzOQJX6ztMThaJe4aV9q3MDKhoW9Soa.BW1Y
 8_pOriBArr1..kbfzMSZrBqItBVfjbqgwpnZb9D7daUa8vhJVhu5BavPT50A9kZdLbLUj5Uca_Wj
 3oL1ElQma1_38tTdYkr3IQXIJyUF1x5hLUpSlKcoUL5fkHUulw850pCCJV5af7MNrVcuoc9YrpWW
 _GlaUyY9yOJ1DhourwVZz23uy8mkmh7D1dsyS7G58iJWT.pWQus3aq.bvBVwE0isPczGk89sr2Lf
 QSrIbLt1WlpOfLLzpEGHc9jjSsqRuHL2RlBvmoPkZJUd1zHH9brK0djLG3nLvXSF10KuRtFJkJ8Y
 lHm1dTmIUGR_2C4yhO2ekSaitTuhwggvgLS8jzNUTAupWhJjBq7qBX4N3TNT704MeAxKwqQE_wdW
 5QkvhpwycpXvOH21k1iEg5LyjVa3Mpm9bH5Pupz5IDNi8MmtEFwh8T0MM.TF3NemQ65a5KXnBEe4
 o5p9KZKB5XKEQjQINn76h7INbkmtLrUDn_Si7KKFvqMAm_kz3gNprMcNbtihy265zxhP1yMW8ymI
 9XApn8dNknWK8c7ptNVyK3sf3o2ZQZhoFxxkL.fzTBG6U6jtiZPz16K0dwyHzP6bCcneX39GnpiF
 uG_d4wMhxbX3EA3a96yMPW1cW9_OrpwlTYRIvWSbKEZTMq9H2v9KZxaG5wGbn_KqQ9q9cl14GsYw
 _alA72ciSVX07yIdDkrPJrWUpvZsn_7PJh84AwxE3tm7QJZn_zVVD_p2KMNPPh1xgx96QrcEZe_i
 v.61n58vVn9vg_Udh7nQI7UyIdGshiazXr1XfBvSGgdAGeBcP2d_gDynsYo0WVcc_deqeY28x4fj
 iYjS0HhVxQ.tmbFhrUp6sSLyL5FpKXQBL3DGv4ZAT9xLXjxr34HmoOsaHZvVqH.yHsLkTwbblcCf
 whjfdEdc_mgCbfnGtLUnCqyeqt6alI5PHuA_HhVue_0KZ68pBw72TdMKaRD16YVo4b.5tAXQDWx0
 LadMdNtR2cXNi6jJrtDkJF2TD3RhM.qEtvp.7rQx.gj4fXu1oVK2LQL9htY0SiU66CY.u48YrYfD
 XzP_OVrIMje3xC8BrS_HY_h0ubJwtJnb.5gl.EeGIfZu9e4wMsSvVU1nYVjCUYAFkoOwr.mWRYvq
 M4pJwEem281pMOsfPnsG4xU.GvGHM0AYUjG1RdnMYT9_vEDDm2UR8sXr0Ct6pATlUWhQKf8lh19E
 .mV6AkBci_LQVx6.13qpUQYj3rU0HfTwA2zlXovrPZBIJ44HsMXLjHbTlcOtaKzcJae_p3L.q7AO
 Bgl.CUVtXNPiQ9Mvh.sGr45vxKrty1DilbQQV7tGhKRbFLfJ72A4dGXnUwBp7Yh3zBFrJL65l.fK
 o4HvdUnWPE6.YfvuaTiKtLwXSBVlAA29kR4lWHXP0Gw9Bhl2GqDNJC.QF32ovssYA7zZQBvnH1pA
 jN9v8
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8f75c530-de34-4864-9dc1-b4323dc33f68
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Apr 2025 16:13:12 +0000
Received: by hermes--production-gq1-74d64bb7d7-mh87r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b5dd3583aeda04525e68f8f8b81efdbb;
          Tue, 15 Apr 2025 16:13:06 +0000 (UTC)
Message-ID: <69763528-bb00-44c5-a3ce-8c30530b29ee@schaufler-ca.com>
Date: Tue, 15 Apr 2025 09:13:05 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to
 binder
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, gregkh@linuxfoundation.org,
 arve@android.com, tkjos@android.com, maco@android.com,
 joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
 surenb@google.com, omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 tweek@google.com, paul@paul-moore.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, selinux@vger.kernel.org,
 hridya@google.com
Cc: smoreland@google.com, ynaffit@google.com, kernel-team@android.com
References: <20250415071017.3261009-1-dualli@chromium.org>
 <20250415071017.3261009-2-dualli@chromium.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250415071017.3261009-2-dualli@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/15/2025 12:10 AM, Li Li wrote:
> From: Thiébaud Weksteen <tweek@google.com>
>
> Introduce a new permission "setup_report" to the "binder" class.
> This persmission controls the ability to set up the binder generic
> netlink driver to report certain binder transactions.
>
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  include/linux/lsm_hook_defs.h       |  1 +
>  include/linux/security.h            |  6 ++++++
>  security/security.c                 | 13 +++++++++++++

This patch needs to be sent to the linux-security-module list.

