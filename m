Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72D238D56
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827559; cv=none; b=kN8Kvw0NXwdy8GWI6s8ALLBEZ9xWAG4E8aeYGiI5t2iEeAarsv4/bIeFzGxWS0ajL/jodjMQ9aO/g9CdxHjYliwAA/zy+2jIlTTKgBc5bmyBgw9I+OhzMFuaopN3s8Im+Eg5azk2kvqhS2g9jzKdA6T+ntdDTP+STMez2HxRUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827559; c=relaxed/simple;
	bh=uvT1yrEhp/YbzOQj3QWGGsTJnrFKEzCClpBauuNnNjo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mh0xuDLgJ+4HUl3EERmUFQkN5Wee95UkTi62iHF7vJUUUXZhwDS/31DtvV9YvmKaIdvJaIjM0PklDWcx6f5rmiEf4xxG1KhxBXZolkLAkj/n6WSRjE/oC2GbVGOPVibXs11VNSJuZZN1Z1e8EL3ZYllB2L0puOM+33sAvK2e+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zFxv5ZPd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/JNarwjq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zFxv5ZPd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/JNarwjq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zFxv5ZPd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/JNarwjq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zFxv5ZPd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/JNarwjq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F39A220710
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747827554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=uvT1yrEhp/YbzOQj3QWGGsTJnrFKEzCClpBauuNnNjo=;
	b=zFxv5ZPdrftz8ZfvwOU2bbuWxOjG7NsRnerof1eNciPbIHkdhtvVjkEPgc3h1WJlXNus+Q
	1dqtamjyOADBQKRQp520sOAAPeThG/q3uYm6GH11Sc10h3mp6QNBnOyBAzP/KB85rd2y6D
	+S8r3RACu7XnbSRQCYYl1L4jtKJU7jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747827554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=uvT1yrEhp/YbzOQj3QWGGsTJnrFKEzCClpBauuNnNjo=;
	b=/JNarwjqlXuMZuxzLVYYA1Ck8DON4OxajCPDRpHTSPK255gZ2PTFNbgLmCu5Sn4W36eocW
	aGUSzl20gLJu6mAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747827554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=uvT1yrEhp/YbzOQj3QWGGsTJnrFKEzCClpBauuNnNjo=;
	b=zFxv5ZPdrftz8ZfvwOU2bbuWxOjG7NsRnerof1eNciPbIHkdhtvVjkEPgc3h1WJlXNus+Q
	1dqtamjyOADBQKRQp520sOAAPeThG/q3uYm6GH11Sc10h3mp6QNBnOyBAzP/KB85rd2y6D
	+S8r3RACu7XnbSRQCYYl1L4jtKJU7jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747827554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=uvT1yrEhp/YbzOQj3QWGGsTJnrFKEzCClpBauuNnNjo=;
	b=/JNarwjqlXuMZuxzLVYYA1Ck8DON4OxajCPDRpHTSPK255gZ2PTFNbgLmCu5Sn4W36eocW
	aGUSzl20gLJu6mAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D983513888
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 11:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h8s5MmG7LWjXZAAAD6G6ig
	(envelope-from <cahu@suse.de>)
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 11:39:13 +0000
Message-ID: <2a34cb17-3290-416f-bea8-bd743e18ff3b@suse.de>
Date: Wed, 21 May 2025 13:39:05 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: selinux@vger.kernel.org
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Subject: selinuxproject.org down?
Autocrypt: addr=cahu@suse.de; keydata=
 xsFNBF90UHUBEADUtdHBsvZam/KLgeriGeft36rqthD8ijzTSoKxai7x1e7SzcYGtOQT9bun
 eVyWp9raec7awo3z8UUBXDuIAnTM0a+pzYheSeTtDovoHNbb3cIB/NcRnqUrlVLI/ZhdK3x8
 0EXWZ9Hc8fiD7EyreTtNVBzmN40rOkHdQ9Kc+xJphV8/rinelEAachvw6c3bPzLs88Pv/IJ+
 Fjx7on1dS0I6ADEp8G/l3fU8f4Hxy/kLfJ28N1wNb1aLvWG/uztNrO8ed3KVs/NhzmL9WpTO
 mEpnpUDr9SH7flYAvKBquwXG/KWLBCB6T9+3I0LehRC14Z96CWWtofhOB3t3hlOZmstwSyfd
 zeYAhOXwm/yULb/MqHlWxE55rU7eSRYPCvtYfqZ8NfvrdeDIcz1en5Q76aaZNsPv/IvoWWhx
 jkQeT7sTSBWtk171sHp2nKKuqb2aHidSE6xFPLj8ZkyyN6SL0HxjJy+nYLeFAFnVyti/mLfz
 UVa6NBmFoAHDzp5PxAN7Ey9lALIWvlDFLYzeIRXVKvloCv1P8NwBgmVP3uETgcYQM1RNrICe
 yO46gBs3HUnLDRt11f2c1GK+STpLQmQffVNv3qx3dBNUWluO3KEyBvvoBvqKjiRYQnbQL2Qm
 xLBAB7+NxN97acczrdpknOS9FbsBvORU7B+/+h2w7gNTn02v+QARAQABzQxjYWh1QHN1c2Uu
 ZGXCwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQRYc8/RjA6m1Jy79sQG
 KhAWFQWgigUCYxXl/AIZAQAKCRAGKhAWFQWgir3rD/0TwrxmIDneIz25Reigzj0DNwDycflF
 RdQlnQRia8S5+NrZmbO8PM6Twss0FYCZS7LPKjesxBgbFdVBdHqS8RkPglK1+f1itDVxBRKN
 8nJDklsP2X7m5NGNs7fVmhnEwrTa4DPjGQgyHj+yoRuS76VSIU1IcuizAhsAAgcPBEotwFEj
 vsh3jLgauLDGYfFGyUzl+wKI1MieeKZoVc+r6cb8GXxhy1dOGSRxCsBoSRx+6wSSbHnBS45t
 2XhybCEhbV6sH8QauUtDyKp6ZaDTV+A50v5HsMoOTgZjYfiCW3AgOuNhXiQNTLFTvE7Tk442
 QssvoM5LVUWdJZzSNMuD/UxQUk7S+/y6AKkpKHejpJiWsgp9jiH9Qc7kg3/HKgzhPrR/zbGc
 2C3lY9yyJqG+6bX7lcgVQrg9UcQ8kX1PaXPuroO9O6Dm3Li2Ej7VX13ciraQpX7aOdDx+qDW
 sTlw8t96H3JzHpcBFSyTEbkPcESVyR5mLs1GRGIVjkKrMpF6tStGVkhgC4MRUsZT0k0dpG1A
 HxPrLIVUxZZz9q6+8Ss0J5C7pM58lW0fcjtw1HVHTTqyj98WI7YDwGegMayx+jW4KlAcygPk
 ZUoagrlU4SrfEXjcy+8tbbBPGzBI8Un24sxk2xubpQ9LZARBy7rNAxADzihD/RS6h+4S4r9T
 1BzAzM7BTQRfdFB1ARAAtXRfAKngaOB5ZbVK/sIqCscQftG6PBaJOpBLXsNSDvj2zH03We7r
 yzHuH7hhbcDtz8VtIn/ybNnB7QIMyx5MUieOEqr3FI2o9mRrYD/2XkXBITPJyFuZfVa3Ebdo
 5Huv+NyXbzu+nsEkrNdSZKlTTVJY1vF3ukFAvEs/MvBtAlGhSJWtEmVLotqUAlN3KnSyrg/C
 M5PNqrD3ZKs1dDW0LH/AwkzLlGoMJ9fUyKLHojujm+rY8nFnBqZu6kHM36YKiy/d3lbc0SJn
 z7d2kbtbW3yP10lDzAoi+gTXqpjeLxGDcNLBt79BobJLfGJ6cng91zbOxXfFI9giUZHR80jB
 foA19D4f2LJVD7Ofm0/HPSws2j1Bhnhp4L6anGk6Q0Uj0G9owycvwdOUIfMmAxaQ3ELJTQFr
 l9WwYFzkdS6z9BOR42HIVmxkLd0kzAJzTH/S0Ms5uRtXgDk8Fc8sspGvuque5sFcGM9dfWU3
 VZNy0o0KpS/xy048ZEbY/30YiyGnBZNIps8s+YwxU7nlEnmBGWK+sLZvvSd/kbyVtWIEXUGF
 6tWbaIs9/j4yLJuAvnxadiPoqZ8MfdrsIaQPGOsRt3Z4igEzh9HyDGr9vPGRA3tZOY1C63jL
 mPk/aVFIaV9qCv0lXl4BcE7cYDRcAmZ+q7ns3eLnSG6egglhRlyzGtkAEQEAAcLBdgQYAQgA
 IBYhBFhzz9GMDqbUnLv2xAYqEBYVBaCKBQJfdFB1AhsMAAoJEAYqEBYVBaCK9ogQAKFLRK90
 o/PlhRlUxMZ3ImSX5Oi0no16C1SoROPBOTsrYPYImgdlMJFqDTWdsrFNIS86NBcRWitEEp9v
 vzOIJd3Hf0XKAZpAMufRpK/zdMgjEMT5rMU2mqoPGaDoJpPjr2ldlY+JivXo9dPl2k+HQ+N6
 7UEU7c8Be1E+hIBYotjKsAQXusC+HQp2vZwy2kl9TdSkE7joWO2y419UquSCwGwAgA46JCrf
 grLxgL5UeZ9tO7KxBUmBzPCLbEj4d9u/Y1+r24AEQ8niCm5HyYg5YdPFuLYxD215Eb8dRvJt
 GDL2JH9WZUE45RYgPnSoPVGEHL67iTl7ltQdHtg1ncxMcf+xebQPvtkbRuLVQPDrUxf8jfcr
 dG12bsUqN/Vw+moB4IrAys/lZzVgyhrulbyKOVC23pPL5BiFLUiYw2dzfWa98qhhCx/JRUrm
 /ZNwam+MORvIcR4eW7+9PBC6iPboumcP4Xtj3ENfOKDlTZQuya1FT6rm7hY//enYFVhjqtjd
 q0GH2SgHbzjG1HhMHIT/LqzHB0JxJtBYyFSnHSns8XEIyVZc3WCQYKNhyPkzX2tIBOwZjadg
 GVgkG+LQb2a3WUQmCM4mH+WGMxWrdbOJOywtlguCZxcipt7Gk48cCtgrnbs5Gy6DfbrdqekD
 iPe2E2Yib2ud+um1SRsY/41PP+0e
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GtEU2V4aY6X0hh5LXM7ZmnH8"
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.20
X-Spamd-Result: default: False [-2.20 / 50.00];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[selinux@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GtEU2V4aY6X0hh5LXM7ZmnH8
Content-Type: multipart/mixed; boundary="------------jHD6lBhTpNfjXCfK3C0nbNWl";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Message-ID: <2a34cb17-3290-416f-bea8-bd743e18ff3b@suse.de>
Subject: selinuxproject.org down?

--------------jHD6lBhTpNfjXCfK3C0nbNWl
Content-Type: multipart/mixed; boundary="------------ngaNfVMA13GiPiboYKW57ho2"

--------------ngaNfVMA13GiPiboYKW57ho2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgbWlnaHQgaGF2ZSBtaXNzZWQgc29tZXRoaW5nLCBidXQgc2VsaW51eHByb2pl
Y3Qub3JnIGlzIGRvd24uDQpJcyB0aGlzIGludGVudGlvbmFsPw0KDQpUaGFua3MsDQoNCkNh
dGh5DQoNCi0tIA0KQ2F0aHkgSHUgPGNhaHVAc3VzZS5kZT4NClNFTGludXggU2VjdXJpdHkg
RW5naW5lZXINCkdQRzogNTg3MyBDRkQxIDhDMEUgQTZENCA5Q0JCIEY2QzQgMDYyQSAxMDE2
IDE1MDUgQTA4QQ0KDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZy
YW5rZW5zdHJhc3NlIDE0Ng0KOTA0NjEgTsO8cm5iZXJnDQoNCkdlc2Now6RmdHNmw7xocmVy
OiBJdm8gVG90ZXYsIEFuZHJldyBNY0RvbmFsZCwgV2VybmVyIEtub2JsaWNoDQooSFJCIDM2
ODA5LCBBRyBOw7xybmJlcmcpDQoNCg==
--------------ngaNfVMA13GiPiboYKW57ho2
Content-Type: application/pgp-keys; name="OpenPGP_0x062A10161505A08A.asc"
Content-Disposition: attachment; filename="OpenPGP_0x062A10161505A08A.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D=3D
=3DNxaA
-----END PGP PUBLIC KEY BLOCK-----

--------------ngaNfVMA13GiPiboYKW57ho2--

--------------jHD6lBhTpNfjXCfK3C0nbNWl--

--------------GtEU2V4aY6X0hh5LXM7ZmnH8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmgtu1kACgkQBioQFhUF
oIovZA/+LvMspoRZL+OEw69ZiOVFryLwPqZF+2oSmZb+5vMzl2r2jEhF+DdmSKMT
RoAYmTLipN39uE3ivYt8b35nw5RB9fGfyqxtZ/mFmRHepdqGoLoziYNMEeqLOms1
2p2nMLPw1VKGZKYcllZas0+bRYxIHNS8DTwlJlMXkPxF3j0xDcqzX9GOr7jvrWXU
A9kw61t8VuEsh2xaTyNMS5NWXyqUdRRhMG6CnDvA9sFfk1QcK4bM0WDu9DiOD1jF
kpO36/cUbPPMN3RTzeVvAD9fBQtWfwVDmjG8dBpuraYomgx5AJYrjvKUwFX0ibNt
xd7vqK7n/waz2siz2IC6whFB0WD6TW4capghwNraXyT3HeH8QlJraWIuX+zNpywz
VEdpJnZmIpZxpoksYdN40LY8qZ+09+8yWNQTbRPdOrF7fTRjQ70TrbEL8nbXMrFC
fESM4oBO3D+Ob6VLQGdFoeb8mxFb15Y8SdNAPYajtmhEE/xGhXQiVS2Iq5ED9/KU
iWZz79CxNhbrfAp7omcV72SebCov6Ou4a/EMKR8ekafvqFx46JWsMcas3egleNQx
o7hBRTjQsHhlxQt3a/MxXbhEib0XKNw2Xk3JUY1pkS1BF1SPkGS0ehs32v1rFVMn
rFcwYJQQOB+vAniIOwxlRQJW7RI0aG7CsGAL8fh9ALmiMp3PLY4=
=29oq
-----END PGP SIGNATURE-----

--------------GtEU2V4aY6X0hh5LXM7ZmnH8--
