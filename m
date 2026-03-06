Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C33016E3
	for <selinux@vger.kernel.org>; Fri,  6 Mar 2026 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832717; cv=none; b=D/hxTcxc096gpjXznKu1F2SExHZ3qHoOVZ6UgHIDoHcNEIbFx2JgVa4eQXrni0gjrNNJ7BIgyljxK4x4FHMxL5WLRYn7VJ0M8HjBLki5ZJ6q0mF4tk0ut33ICjiV1hvseEnkuXO+0n9un+ai9HlPjwgytNPu53cnvXWsriUl77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832717; c=relaxed/simple;
	bh=DkhHXsS6gMF0c2zp638LypIrNx0MI8kizoulUI3kThc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVLONR8ifTyEoGB/2t+ItRSx6WxMybzJzhm6Tmb+2L4r8MrKxHpMBSVY10I8eC9UC2VWvNFcxgGhBbm83jX6RJ5xGK7o9Y1EGDUxNYbzrbqZpGkQoGU30yZ7Fbmt3n5yXxGlO6Ez2rr5cqpx+uwlpw+vcqcqrqNuRZgPLD4vKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=s5VRLBcT; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="s5VRLBcT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772832715; bh=RWHa4kBONMFmFBcTzzY16yZMHVhKSyvVBBu97xTYIw8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=s5VRLBcTi2v7eUhk6MztPblHTB6YPjKiDjjT4rwdZpK7UcmA7IYTI9St3mYDGRxlcs3ytAhdBww/z4kKYVYx4Rs0BM322ealuJ62E8dutQsZAQU9p2GOfD064Mh9bfr+lQh1p0MFYh4nr4NYTb1vcAfcBNWEPti/wbU4o9L69wWsqrXK+Wt9KsewajOh5V4idDDBOpp/n+YkX55/tO2DfF5ipnl8u+TDN4i9b5UXiW3YHvk/DoxZzNd/OP0qVMtEIl5yiAjWyCIz8m4U/MGwegp1dsYZYeqWv9ERaCWwnZgHWZkJyZu7Z3bfLXwyDpJL/tRdVvdfKU1esVeRbicPFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772832715; bh=LtwAmCCmCcth0xZG2Nm5CX2tr+anM2dPej6Secig1k+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dhMRAlRPeIiKdOd1GEv1iD6CYzom+vp/GxwP35n9+yPb2iTP2CoetrXWPDSMSHoeRpVBPq65UxpSxdj29aaK0EBdX8ViC3ctB5OVIsl24hmLGYIvYftHyF1WEU6KAwGBHdGTSgLsPmjORkilj3kxyAWSoP3kMXwMDh8/yr1hQoQDnbSqU69IAYIbEZMSaNt+Pze9onp9yrp3zjfZqRrC6Lx1qQbrSuhtvFsWhlIj2j1WgMw2sLQS+RFKgwyY806bt3GdXZ0mwnH3dBHXmDyTXMxNdI2NLrfQTeUybMXXiShzHpEB4aZxBDHZFUqAbikRUxT4KX0dB2UnOPkXILwRvw==
X-YMail-OSG: 7XhMbdIVM1ltSZv4p8H2w_MFMnrq45mp01GhhxDLn_JL8CnsKc7AqqetP.t6_6U
 fPzHBV2KyUFNmUM_YULBvooxURlp3oml_3ytUKJDZs43MIvJmKV7Ph4UUi0K9T0.oLjhBdkElEwf
 E_P7zyFiqC1tWuEw81lxh3CXuCRyFyukpLeOjABgsdYH0ywiny4Ww_.j.lzEbvf.3D0O9TLNIgZU
 MCOgUHAJZxvLzDng_DSkB_K4y3RyO6rsU5ye_hggDLPggfwINgW4ebrEDXQ0owjk2_h3szCmBRlv
 9zulIniQcAO0aA1EAZwyNu76aTA0X9W_zIscqVLNG8rbydgFLGBHxT_eBObHpVQ9RNgLUtlq5cSG
 StTdcASOZYxjkiD.Ycc0aDQgVnfYlayHckahVh750dVsFdYEzDNiwdJas4RtOltH1i.Q5ZDWH7.X
 gItkhLFBTnKu4wwLv.pg4254Rf.yGlsnVXqBaNygOOV2PmJxXVDmYMLNcfWFQc4iTmEnscUW00ek
 Nzp20mRWjJ1unjOqxHRWB1S9QhalJE.85Gyy1edZUKo15vxXz8ki3vNS8y4eLKBxGOUqHdG_5LsF
 fNXmMTNwegPUzbqilKTliwF3MVcysPH0rD7sNQk6Ej1L9tTr64oNcFC5jlp51l.eF2FwiftVKX1_
 kZerRN09oQ1kwNikUwlJb0GzNcjORnN3Ao7bzmydikm2uYxvhFNo07TPU_oAk6mfZ2paTaqBDs45
 WNvoP3F5rG6w.sge2gTg5EP7QYchAHS6.CrRBrRddcBbQf36iSNMPasml5wYZrHkef8mABKqxpH8
 SS.4zYlh5mOdQlB8F0B5C0Ci5sbFaNB4peOApgUg_AQlGJG4Occhp9zZXWcKotyHXBUgdchHCIt7
 .B92ala0N2kyI5AprP7VX0O.rbwJQdiijVomI.FAroAW5L_tuzPMhGLIt6wm6luL10B4RheAeo3k
 bzsFZ4kT1Gr1jhXwR8gDG_9jDzYsIcSfy__3KN1JdQFA7TuH6gFvkG3XLyemYb9tmOz4o0dHFHOC
 8pC.2nhFLhKJEG_DOeVGuaEekkCp7RhuB7C96jbdRbh.PnuhEQ8yky409qVqYiqQrcIgFqeUZrlz
 CxOFif0BtXUUBBXQz8uHkkLTQdiUvd4sfBkPYcksUiMRL.g.KpurwM5D7AGA.qNkcCbCl..vdfvJ
 w91.MsiKcUGMFnwQHOiuv.RVL_r.GvunFDVW2jAqk0H5qzQRk3iYi5p1hfAPE4aeJq9tFgqBVhIT
 ipiERh79OOpBbR11UbePaVMwWRu9rszBq1xrZ6tVAFDfWHyjwr9wdXCCivZeYPJdX9eUwkZwwlR0
 6KYYCJ7S7Siny6xrYBbUPnHa4msTMrH3cH6lyuXQhe2qN7e_NUJ3rycAAgCFrNg4zmfUWD.Sv9n_
 KP6Lq7TUOGUMVcbuDqRf86c9IT.vF7pm1mliwsKaB4YKpqZm1akkFN7WyI40GhCo9O4eNWFQfj1U
 9cTbH3N0b18RekyLlOK7Oha.rhx5mfkEmjSDJl0NGOT9rE65Ahn0Kg2l3PNbDUi.oMJolji9AvvG
 HkxiS5qV9NcU2.Q17PLRBd7w5uKxG0ViTxi1NE0w38TtdLArPVrw.InWnDZu5.3cXIYxwhYf7mhE
 4Z61vdO_.1IHRlqSgXknIFMqa7mEOvCGelRRRuC0vK9nqFVsC4EQJeK0g4gCVKqN6iq90EPvEuiV
 AA9cSDLLClcLfsnWqiHF0znr9fPtxrhrQKwDPkNAYM_ZtRFY0HO8Zngyz1RR4klyDAjKGFQhlGML
 .cfHqmNSSy3n9s_0H1Ur2Ya7Y_GtUdhEvobToi_CDt1PKpOp_b.gB.5Ml9xJ.JG2BexFCfx7.ilO
 OfABH2Vt4Gi4NB_dCLGfymBewQBPRz3E24m7YzRwC_EqgE4lRH.lg61HhoHymPFkB3.mdyzY5qBu
 VDmlrSvO5bAErEpU2HZ5T6LVxlnx0xsqW7S_Eaoce.t5nVsddV5nJkJHa6z7KzDlEUvYnggNmykY
 btBwhfuWnXFev9.eZ2MvLffYG4d1YAaBTH6_G19ziO1IWNLAiLBRQl8t3KIcfXvHaiPAUvy31NDd
 VgCDCGaOAcRdG174otCPCBJxrP1IxQYkoOeLpn22YMokUav_fClQkuEUWKPGFPtokpduMJuJugRZ
 u6khNvf0L4Ri6NSaWnMqdUgUZRKR3Vc3PGHZBySypl3mmkC84diZroWXdxBz4Rmq75q_fgfC_qm_
 1L3QilF5tf9rqa5cPnujQPek87B_jnQE5tuXu4.dWT0XUGCGENr7DCwGGvgzNCrSP9y5ln5pOi4U
 wKUiga3S0oSjYQ08-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 089228bc-47ae-44c6-9a3a-c863a2947ce6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Mar 2026 21:31:55 +0000
Received: by hermes--production-gq1-6dfcf9f8b-m4k66 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b49a5db42688b0ae6e7eb7714645b814;
          Fri, 06 Mar 2026 21:01:33 +0000 (UTC)
Message-ID: <ae5e9c1b-d0cd-476b-87d2-70c0bc8ba09c@schaufler-ca.com>
Date: Fri, 6 Mar 2026 13:01:31 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 John Johansen <john.johansen@canonical.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <20260306174815.GA9953@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260306174815.GA9953@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/6/2026 9:48 AM, Dr. Greg wrote:
> On Tue, Mar 03, 2026 at 11:46:53AM -0500, Paul Moore wrote:
>
> Good morning, I hope the week is winding down well for everyone.
>
>> On Tue, Mar 3, 2026 at 8:30???AM Stephen Smalley
>>> I think my only caveat here is that your proposal is quite a bit more
>>> complex than what I implemented here:
>>> [1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.smalley.work@gmail.com/
>>> [2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.smalley.work@gmail.com/
>>> and I'm not sure the extra complexity is worth it.
>>>
>>> In particular:
>>> 1. Immediately unsharing the namespace upon lsm_set_self_attr() allows
>>> the caller to immediately and unambiguously know if the operation is
>>> supported and allowed ...
>> Performing the unshare operation immediately looks much less like a
>> LSM attribute and more like its own syscall.  That isn't a problem
>> in my eyes, it just means if this is the direction we want to go we
>> should implement a lsm_unshare(2) API, or something similar.
> Stephen's take on this is correct, the least complicated path forward
> is a simple call, presumably lsm_unshare(2), that instructs the LSM(s)
> to carry out whatever is needed to create a new security namespace.
>
> There are only two public implementations of what can be referred to
> as major security namespacing efforts; Stephen's work with SeLinux and
> our TSEM implementation.

Please be just a tiny bit careful before you make this sort of assertion:

	https://lwn.net/Articles/645403/

