Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5A25760
	for <selinux@vger.kernel.org>; Wed,  3 Jul 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045552; cv=none; b=I64Z6b0gbafckmnGJ5HTmUCzgCB6up6HHygAk+ingTc3TCL8GvTsBil17ir92YkIGiaZ4SKLwcaLuHlCWywQnyrcpZyjD3coHkkkiD9FGdd3o0Va7efK5binQD4tZVmkbbI0boHcMo2vGXumtwMNNw7Kb/SjyOqfBbGAedREUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045552; c=relaxed/simple;
	bh=d/GXZExxP7iHIljKktH2xf2oo8tzAzf7itiZJHSdGLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=kJVD9cBT7Cw08bhZtOpUbxd6MXu00rET8Gzaa3wzlQMOgR24uj6ADyDwaitAwvDXEUtUO+dRu2xm15gakmMX1QbE6enGWt2HCsbfnB0O64dC1kOKajdZ90h2KNR4QSPRrx5c6QXo21PiKAoFKNq1f+OYN8nRupe/pyGTOLP32J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fBTwfX+y; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fBTwfX+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720045549; bh=1fMoFRg02t09ZaM5zT0OQRAJMuRGusVcoXWxDXP0NzA=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=fBTwfX+yz8Xzv2jPMkY4Qq8+hWb5MlaBepHCKUX8RJHO2K9drCPvaS0ZK4lECu/d3ODjgy2O88Q9tJ0GZATXEguGszzcEGodM2RaSemfa2UGWvAjUBPh5nHtuS+5vXCVKf2QvW4lNmZpjlhuqt0D6Zg24eyVISNQMY0SwbAIupz5c8LY3DgcvPRAEXGRBFKKrm+HINu4qSSYjl486FUQ/smgcoMYWlseQl99VcuQ14vjapsqBHRnv3BoFqrx5ETJwPmKBb2cMLcRQ/cdUPnQg6b27yDsuXkj4aIQqZEdTOVTYe5dQzoh/rwSkgD1DvrKOSbpFRRQM3kQvLAJPwzzFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720045549; bh=iEgm2ZVCOJuw+IcFhf+ebAE682cbrV2q0RcIYOOdLzu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=msdaQxUWB8qw50oLobsv0euuyIZVZKkQcPQWdnr7G4FbNpbwfToRnvkuBaqzHfJu3czO1zAjQN2ZFH0LwlBVKI3r8FIDVo8QW4BL48YfGWwbulFlhfkxVBY8Hz1S2fgPLcbx1tTapNsO5hHg2rULiK4IIBykN38ZlgKBRu4CAljfwNA4w8xdDbfnJsjo8aaE+edYcGV2fvVMWH3fx6CHzufzE3//CF6ZEF/wOh5JfO7hjmvwtwti//FPLOITW2k7/NpxgVYZbj3ggfteSAMaHP7Ncenlmypgkq/AZvnkmX0nrPWkGTdKjyAR/1V6/cw/NAcVWqzQKQVgvl6oNaSQRA==
X-YMail-OSG: vAFVpxYVM1l2rzAZkQgyK0e340gl0Ef8ULIKtrnLCdqgdsoY3AsZ_714H5OYTYz
 XDmhr97PPS5A_miQBI1wfbBEQFxhN3TfS8pfR8KQfJ_WSRtiFnzDVp8HdQSOPkAUSFtNCfw6.HDz
 _TT0bInWVxs8BxHl5.zxmfx95A7Ugj9Fl5Ua0cHEWY.IFvDgFjYRkF4qU.V3645wFf_f3sWOlYj_
 WV18H2cUWyhaTfkezcN0PQSScIqHuxUK4xl2lGRZmk9hjZm.kBSNFMXZDeYftrK.0XKAI215fpBN
 .JZ3lZ34Gj7RWPPmU6LzyYQ1kWy2FH6Jqe3pQVPI8Iv2oPyDSdSrh7Q57AeI5iqiK4.LRd727V23
 xbtwg9ASTMFHDLKDOZ8BD_gWb2SeFceOxpFaP3v9Auba8GwDemL4g1fEHk9UmRlQqETKdVRKiRcf
 EX76bJ7ZywpJd6Zz5s4JX3JcvpS9gK15fx3G94x9N_tSbAS1w3kmbYjmBRh7U7QXX9p.ey6RNucx
 YMouunEhh_YQhCWcUdTg0HrG4iRIBoIWu_tSEXEEppnuLKfY3ONkVGI_GUFP88d4BPmgI9FnXTfu
 wKJkWDmiG51eHLqLdhLsnQxHrN_HgZjXR.0rVkrnOuJT1dERINHaQvetKVKFUr_.EOhgVXxKOsIW
 R7sO13LdX_FA5Gl8WehCwDDWfYIBke6ogVxk_Zr13ZWF62aTa8ZBjTdb7GUFyGKGAiIBggj.r2hh
 k6e_CFX3FuktEMrlzp7zlktSwVOx_26Up8FAd1Zbeo7XN51tzHiVaMAP.qXwJQvXId89C1IjGvQf
 7L6clSSpz3B9qfoGLhWLN50O.jDktU2sTJNP87kD6WgwClWFmCpu42Z1ruGtJ7dSzWRLldao_S5X
 EjuJqfX1P_Wj9Sjfn6nc_R854wFJNY0K0dBgOFcjLiC47Yj_Q68tZjKu9xmj62dJT0sLSdfKeXGR
 8wPVuj8I5mKt2Rt4ls57M_IzZhg7npPMVrtGMO1eXWtShHAEYCwSf64euRmU4qVk88j42_lqH23v
 FXksW_bcfXYXCDBX2WNVPq1pTpB3WMHkgel1Eim5QaH4nIuFVJ_YAg.iJt5ivBzihbxxLdVCW8sX
 weWrCX10QKQwMDBYAk5eBve4SGoATUwx7NaRzHwrOtQzEadNZOAi2l1mkROjCPSxzS.6PbeRIJNo
 AQ3FjOkBqeLiv3XiSIDTAsVcoef6zapmNIWcnYVR1UA4dVwi0xDDsumNl_HidpaTQbV2aS2eeOiL
 6jAj6.KZdkBv1sJDX8xRqgMbNaUpuZBoOEx_Gv6BFhSmRY7M0PVcVelK7SGvN0IblhfAXP5X8e3U
 .tZ9BeLBCxVBc4a5fr6Ta19vjPMnuA0SvUIZTbni35keRTOJ2cSB9QWX3I2KWUqYx3s9fwiO1iCs
 poT886oM9JGmsVZGtSDqK8vuC49flGWgJme7lMUYkoF79hlU2cwxSAkTVTa39jWrSgR7A9PaZyqs
 oWvlIqGKzpzNq8bBBIx3DG1JOd_Wtqe_Yy4AGnb4z9zoBJiR_0VfC8nwssJQ42i3PLwmvsT2Twhm
 7k8i2xOUC_faExAtEcG2yRK_oza50jy677SOxTZNuh_lGsFQqFnXXWufdGInTkQms3e3KEwb9JeE
 xn3vkeBeiTmUIVDN4wu9Z5jkltSYZY3tYHn5SwPmhRnyWt5w2zggb1BgWrgZfBaE99nXgSKneYBH
 E2aWiuBr2HocFSkE2PYd7QWOMoTFuMAXyA929RjJLFkcKDgtTTsCSR6dqyUHSr1H_UTLiMGmqaxL
 YgqAxCQB3blF2t0dXi_uve4eBEyNkz4wDM9GLdMENrspYPXOgtBh.srO3Xzt4CHnzffV7SRozvZM
 austK1hw7SK8lqXfY5TaVzTIR4cxstypxXnLFs0TViNe8dx_W1bstmBy55htmV8KdNDCL16kPNcB
 6luC6jdOvycjw3Mkq0ffZFoSX2Xh848d9iBxROjXS.RUUF5qCeXyPKRSEEYhQm3p_M6A0r3vkz.E
 G0U.dfqN_sDQre335ThYvhiJ86JHlJNvu.a6.UVhFBpjlw3l_z4adrpJz1166DtWOAhcp3u2cRbJ
 UvwPPqcGp2lJcHhyxloF9c7yXXBnpp12qXsahbUrXtyAwwBm0uOs92zkJ3s1_Sz6bt6Vc.LBCIno
 RI2IJnZFCyxFKYE5kl8spasuQp_R3o1Wf1qRPy0WcUSU7mT8RlZbocrEVWIEaQgCsAI0foGHKSGG
 zA6fO86aagTfPdB4aqjiTS13RitWjM9EZdw5JGTJPk.y_U5sius.M9bg_fJaFBje3y0hCbjxEzg1
 7KBmpPg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f052b74b-efac-4265-9759-5a6a8cdfc37d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jul 2024 22:25:49 +0000
Received: by hermes--production-gq1-5b4c49485c-qj6fx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aaa554a1e262de3d08c55cdb86156ef6;
          Wed, 03 Jul 2024 21:55:27 +0000 (UTC)
Message-ID: <30fe42db-461c-4716-8874-ff78baf4b14b@schaufler-ca.com>
Date: Wed, 3 Jul 2024 14:55:25 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux,smack: remove the capability checks in the
 removexattr hooks
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
References: <20240703211134.349950-2-paul@paul-moore.com>
 <CAHC9VhTA5tUUH7DAYx9k6X2L4eTzJ1a-ETaJ5+sMZrxKqjKOKA@mail.gmail.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTA5tUUH7DAYx9k6X2L4eTzJ1a-ETaJ5+sMZrxKqjKOKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/3/2024 2:14 PM, Paul Moore wrote:
> On Wed, Jul 3, 2024 at 5:11 PM Paul Moore <paul@paul-moore.com> wrote:
>> Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
>> moved the responsibility of doing the inode xattr capability checking
>> out of the individual LSMs and into the LSM framework itself.
>> Unfortunately, while the original commit added the capability checks
>> to both the setxattr and removexattr code in the LSM framework, it
>> only removed the setxattr capability checks from the individual LSMs,
>> leaving duplicated removexattr capability checks in both the SELinux
>> and Smack code.
>>
>> This patch removes the duplicated code from SELinux and Smack.
>>
>> Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/selinux/hooks.c   | 10 ++--------
>>  security/smack/smack_lsm.c |  3 +--
>>  2 files changed, 3 insertions(+), 10 deletions(-)
> FYI, this is still untested as my test kernel is compiling now, but I
> wanted to get this out onto the list before the holiday in the US for
> folks (/me looks at Casey for the Smack bits)

Let me know how your test goes, and then I'll have a closer look.

>  to look at and
> potentially review.
>
