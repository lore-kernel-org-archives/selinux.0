Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF23277B8
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798799; cv=none; b=cY37tfkIuFIdff/i/PFLJmVe7j0A6uLyTaLkWJa04trnir5qAAGx4SR59hxWFWC78ZW+amclhIs6DCzIVRY1kpzqFpK/jOuCsQ+pCgRvkaaO1VA+D7mxjQLcN8fRkj6ar0mNr7N5U9HnKLFD0gRqpMv7vDCppXCOCeHP3SpP48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798799; c=relaxed/simple;
	bh=zKrugURZRPn7whQW2IIEmAugbQcKC61BcxEZrPBs+NE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=pB1LmZ/w1rvyg9lXeSIjMYaAHUkQC8rN3JqOCvWIGBcB4uepDrg/Wc5E/T6TTDeAbRV7Kml45Bp+MPUTfsWA3FOHrLiMhJiMIo+t6czUsq+L9PO+B8FMWxqLkKJoj3dEpefy1c+u9L1F9gUytxlk2l7sn8G5rYA/VoYJY5B5EvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RJX4eWKI; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RJX4eWKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764798796; bh=zKrugURZRPn7whQW2IIEmAugbQcKC61BcxEZrPBs+NE=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=RJX4eWKIyNmf2B+t1TlFUOxQmanpFqqXH2JRwPpFoNdvowQWOFpjcysdu40nWH6ABIrdHHkuRVGyEDRABAqqrcmj1uXWbInGESYMmu2WfMpZTYkzMfehCTj+uE8NAcl53pVErBju3QhhJH2njagCsysz3O0XzW0E0Sx4wa2MaLkoFI9c1rFTnO2sDgzVpF54LFV5SAQuvYJm2e9/NOv5/WmDPPW2wPCqXqDegxInKaR6nAFiQ+CQmUcRTqTtMQCvyPKAdytPc+CKmjX0V/QqTrzFSLgQX+/pNaxxjyizQeobr8mQvY133C+rUd85UeypWKiQ5zuhOHTnJVAk50M8cA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1764798796; bh=UCueqRd5XO3mDxLcKf7J9QThI2TsrsI8OV1BvNLdl0Q=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=icbpk09/MdW4D/nxUlnofHLfBhzGnGAHHc8nyWVwYY6DAhIq+j7LJPStefQud1HyEiB36cupFbvyhjRyxanMMO9Y+e5dhoIQamstWQ22ZvE1e5yCVlfuhE9Tk+MkS6UYgSHhqoq74iAqfGExSCermw6K7ZjpHzjIfxcKQTWmjREuybtlhI/xhdn3v1UqgEBAoYapO9CtunfGhG+WCxuu/fR9O4Wco1t81K4CC9SdYsPNKoW2J2iBJD/CjYnz23kSe4uIoTINXPLIL49KHqu/FK3FCOAVBj7i4DDJOFCBvZdqq2uoxSOXqj9z6Y6UbdMWgfiDIPpKOkvlbEfejtfmOA==
X-YMail-OSG: xzcR16YVM1l2r3t0DPHZuhf65mOHk0bNjig2G4Ppxru6oXOa3dak5WZpfepEe16
 vnshnlBlSuis5JmV1yyppq1QZCCZSdOIUlr3N7UYnsH1KZXvyEYRDOm9WhwK0fGmsBnKu40wapQA
 jeZy3JlnnbYBhb321ZNch0Hrg0I3beXD2Gok5xqvyVJQFU0H2_V8ElOJ8414W9_HxqphWGnlQtLU
 YmLiWGc0EIZHwkIVVY.tfHgWJZuT8xH9F8J3MD5uasNCAMIPtXFbO2dLLFR6.K_wXcksXDKog6rO
 xss0LhGw1jxABRbsnJN8xcUjwcXYlIMU.kUGEswggPm_deZALtnHlRlBVNH18GoKtcnCYC5kcgyy
 _qldcyqWGmtCZQDIlyW9CiJk0B8KgpQqihryswve2WZ88Mlilf72oPUsWop74RHGwXj3PE2bcATA
 2z9B8vLCGFq0oXU2otcg3.38PCv2rACV6CGKX3rQPKFQfCjrfSPBiae3IEwniIVPJX5XAraPm1rB
 PCkfEvs8Y7i_9s.1wSrERDD.GTLFn1jv8G922GZuuw.Y7dotvThRJEpvJ7dIHkfVfWWpGbEMHVqy
 TouRNLxFSGDOdiyAbaI1myvc0jMXKBH5iozZTR0RxI_w0_gU6FTmp8Xkh2J8FGzfR.46uq.TM9ZF
 AOtiixNqKIn7DVz6DGrB22h6ykQC95OiEBp6GKHExKYz8FxDotiNxuKjpgvHLv_yqfEQgVRgsZRa
 WKPleAMNxTTSHDpTZzRAUR8lQTvnJy4fpeAwW2uLvX5ZoXro6iO.uel1LakIc0wP5vCwpINQXJ4n
 4l7Xuk.tjYl73p2cx1uDpezzBVE8INg6LKZ6rfFDhUldQnehp7SpIcfvKB37kWC4c.nSLGWS32At
 uwUU5KctaRog4dHNz2eCUg4hFsLcEcE5nN1pOsIWnMpi3uDixm7L50b6JRuPJW8gGA1mTd4j7js3
 ZejIatkkX0kUq.g66uMxuB8w2m5ZmL1VSwEYzoNrC4mGhfM2ttfsyJkC02hdXg4qQFFotUZO1DA6
 P4u0MPErs1c3GKZGql3xkQepAG.wnqZ5.UBq3UMp2_OC1lmo4TH7pltbeXpzhhqb40vRR7Yulofr
 Y6_Eaxn1t98_VPVfVq3K_Ol4hnbFwnhGNbA0uFXblxdf568nO_5oV8ZO8AH6ylV585nHmyK0vDXA
 6P21e2g.QtvOBSRJ8U.J2PdMaJGqlqR4636bDebQxXzrnSFwFxhiTUvW_mh39cCWqwFLo4SYKue3
 ie.4gNMhpHsz2g0G7.Dmscl2yBj8Ip.0sL2XY2W9KbRnoOsKvkVt6imrQBV577TgLeNV4yKAIUBv
 Lh.zW2oPtqdewTorTC_9k6Ro0p204N9PZw39yYvHhpZqP0h2eBRxa.QSdi6OESqpR2jewlKGdXZZ
 3_0Rkc0BUNvGkdQmE2XMhnuJcOaPT7qaZ1Y4oUVntBG.XWRq4XKuExl3JCZ7mspDRw5UIJ9nFOHD
 l5.zQsoeN0FyuhvAptOE4lM.QxHHok6RZs6jU6t0lJTwqEu1KP1hlwBuBcJJI1NLHsd.ejcLrtxq
 B3IBZz_AIG.xkVZrhBVFlQUZuFnmQd8TC1hOIvkZVr22o8vprUKAfiOH6a6z7tB3gdVyZDKui25f
 OJO6HUTyb174prxglGkx5jq_cX.KrNnCawAuEqyTu7RI13z1Ni5z421bsbsQkldEqMuFe0CBT2w7
 occp25SXNGNhjhZFLQwAxIHOv9U_G2TiH3aKwvVy.XLNkj3KZvr6DDkXR6kSqdRSIPM890eC4_.f
 _ZTslclzia2syNxIumfa8P5VjRuEHI1_UDTAi2Ov6Cr1guQsKU7vp3x9PFviWBErxZ2vpnPYdcXx
 uuBR3vOOxPvIbKofGgWyN7i0icVtCPsYQs9TMOdGcTWDr8opX.F4SldzLuD4I1SiKhWL4VRIl9Mr
 89FACDn.A0cZARMbGAUOkxKhVbksKGoyeAcfAKtMURX0EaxuUk61vYmFuga1MxA46cfelsNuoJbA
 SjIvShSIDCrI4T_LkOdWdZLsbPol2imz92nIVewzukueZ2yOOmibjedG0dapvO7Znd_ysbrX2naQ
 4VDo3WWYm8qyS1XGgO70K2Lxym_bj6d9nrTfJdPn.bp_ATa01RE7DhrlYBwl894Bswy7yLoN56Y7
 Vp2GxFaSTtsM8YE.J7HSP6xtTAZBsg_dHlgDNSPxleA8Vlnc.cwtoh4jnNqhu1HFfC7PeiInLChw
 SKk6cwl620sRWsNYFdJxBhS0vN1AcCgcQ4Em2zkzEf5OH6IjAVLG.VVYsbM.EoL3TBkToVSUOH71
 VL9JK
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d9712815-5925-4f55-b6be-a69180cc3166
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Dec 2025 21:53:16 +0000
Received: by hermes--production-gq1-fdb64d996-j67dx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 76d7dc38f9359a00d8772e98ba4ff629;
          Wed, 03 Dec 2025 21:32:57 +0000 (UTC)
Message-ID: <cb4293da-41dc-4586-adca-2859944905dc@schaufler-ca.com>
Date: Wed, 3 Dec 2025 13:32:55 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LSM List <linux-security-module@vger.kernel.org>
Cc: SElinux list <selinux@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: set_security_override_from_ctx()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <cb4293da-41dc-4586-adca-2859944905dc.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.24794 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

While trying to ensure sanity in security context processing I
discovered set_security_override_from_ctx(), which is not used anywhere
in the upstream kernel. Does anyone here know what its purpose is? I
would very much like to remove it, but of course wouldn't want to break
anything important.


