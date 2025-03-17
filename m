Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31A226888
	for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219380; cv=none; b=pBpm0y54gnyEaynovLKHCy7dSDQXi+0kG9YwY891YMZo7uzx8jRthNqxc9tRWyx+4mvG+alITeK111u38YuB+MivvDcbXTwu6OMRuVRQ7NNhClxGSB8ncijw7LkfZI8/NKPSIbbSyxtXTTXiaN+37/DlPDtDEDTogv9JIPQ3CQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219380; c=relaxed/simple;
	bh=o6SsIMBI1YDCEJPjoxu9kyop0Hh83V0miIFWxMFpU54=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=pgg7KUnzMerLH8mahHSIJPS5qTi5KwLWZDeu6tXqC90RirGBbNppH/LpHc4U2jtqJlFgNDjw6B/f/0DMUE4dtKR2yDecUYPulynkMPVV2HBXICmeiafzA17ngDp36s56E+9XkmqJJpdmRN7UCGNizLXjjeTmbsFbLW5cBSgJHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UBMhYQZJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4odlySbQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UBMhYQZJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4odlySbQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UBMhYQZJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4odlySbQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UBMhYQZJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4odlySbQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 837FE1FF6B;
	Mon, 17 Mar 2025 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742219376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=o6SsIMBI1YDCEJPjoxu9kyop0Hh83V0miIFWxMFpU54=;
	b=UBMhYQZJZmmuk2b7iqGHQzm1AHofutZgliJ8eaVE04cIvi2dslIQkConQAkhp3ae5Fwwef
	U7MB7ATpUCw5RtGibzxSoL1XSgG156EAg8nAP4FAn9AeWgxqP+tMZP7Gr1PHL6Bnmv2xSB
	ouJB6A43Db08lkyFjTp02rFLq75Lttw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742219376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=o6SsIMBI1YDCEJPjoxu9kyop0Hh83V0miIFWxMFpU54=;
	b=4odlySbQJJEMlNBlNhivrxQTY2wjjeHuP+Lb5Qpaj0hNw0U89Wjf7Wqa9iIrJ1kOV5YXCJ
	pFwGZWQydQul+NAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UBMhYQZJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4odlySbQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742219376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=o6SsIMBI1YDCEJPjoxu9kyop0Hh83V0miIFWxMFpU54=;
	b=UBMhYQZJZmmuk2b7iqGHQzm1AHofutZgliJ8eaVE04cIvi2dslIQkConQAkhp3ae5Fwwef
	U7MB7ATpUCw5RtGibzxSoL1XSgG156EAg8nAP4FAn9AeWgxqP+tMZP7Gr1PHL6Bnmv2xSB
	ouJB6A43Db08lkyFjTp02rFLq75Lttw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742219376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=o6SsIMBI1YDCEJPjoxu9kyop0Hh83V0miIFWxMFpU54=;
	b=4odlySbQJJEMlNBlNhivrxQTY2wjjeHuP+Lb5Qpaj0hNw0U89Wjf7Wqa9iIrJ1kOV5YXCJ
	pFwGZWQydQul+NAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65649132CF;
	Mon, 17 Mar 2025 13:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BcigF3Ao2Gc0YgAAD6G6ig
	(envelope-from <cahu@suse.de>); Mon, 17 Mar 2025 13:49:36 +0000
Message-ID: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de>
Date: Mon, 17 Mar 2025 14:49:34 +0100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Subject: Question regarding restorecon and btrfs read-only snapshots
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
To: selinux@vger.kernel.org
Cc: fvogt@suse.com, selinux@suse.de
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------F9e9b0blcXoDVMdwdAGQNNyo"
X-Rspamd-Queue-Id: 837FE1FF6B
X-Spam-Score: -6.41
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.41 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MX_GOOD(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	HAS_ATTACHMENT(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------F9e9b0blcXoDVMdwdAGQNNyo
Content-Type: multipart/mixed; boundary="------------J1Dpq0DQykCdtImXuTKJoLpf";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: fvogt@suse.com, selinux@suse.de
Message-ID: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de>
Subject: Question regarding restorecon and btrfs read-only snapshots

--------------J1Dpq0DQykCdtImXuTKJoLpf
Content-Type: multipart/mixed; boundary="------------tECRMcyTtH5IxOd4JQWFvl2o"

--------------tECRMcyTtH5IxOd4JQWFvl2o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGhhdmUgYSBxdWVzdGlvbiByZWdhcmRpbmcgcmVzdG9yZWNvbiBhbmQg
YnRyZnMgcmVhZC1vbmx5IHNuYXBzaG90IGhhbmRsaW5nLg0KDQpyZXN0b3JlY29uIGlzIGZh
aWxpbmcgd2l0aCAicmVzdG9yZWNvbjogQ291bGQgbm90IHNldCBjb250ZXh0IGZvciA8cGF0
aD46ICBSZWFkLW9ubHkgZmlsZSBzeXN0ZW0iDQphbmQgcmV0dXJuIGNvZGUgMjU1IG9uIGJ0
cmZzIHJlYWQtb25seSBzbmFwc2hvdHMuDQoNCkN1cnJlbnRseSB3ZSBhcmUgc2V0dGluZyA8
PG5vbmU+PiBmb3IgdGhvc2UgcmVhZC1vbmx5IGJ0cmZzIHNuYXBzaG90cyBpbiB0aGUgc2Vs
aW51eCBwb2xpY3ksIGFzDQp3ZSB1c2UgcmVzdG9yZWNvbiBpbiBvdXIgYXV0b3JlbGFiZWxs
aW5nIFswXSBkdXJpbmcgYm9vdCBhbmQgcmVzdG9yZWNvbiB3b3VsZCBmYWlsIHdpdGggY29k
ZSAyNTUgb3RoZXJ3aXNlLg0KV2UgZG8gbm90IHdhbnQgdG8gaWdub3JlIG5vbi16ZXJvIHJl
dHVybiBjb2Rlcywgc2luY2UgaXNzdWVzIG1pZ2h0IGJlIG92ZXJsb29rZWQuDQoNCkhvd2V2
ZXIsIHRoaXMgaXMgYWxzbyBub3Qgb3B0aW1hbCBhcyB3ZSBoYXZlIHRvIHdyaXRlIGV2ZXJ5
IHBvc3NpYmxlIHBhdGggaW50byB0aGUgcG9saWN5IG9yIGFza2luZw0KdXNlcnMgdG8gc2V0
IHRoZSA8PG5vbmU+PiB0YWcgbWFudWFsbHkuDQoNCkkgd2FzIHdvbmRlcmluZyBpZiB0aGVy
ZSB3YXMgaW50ZXJlc3QvcGxhbnMgaW4gaW1wbGVtZW50aW5nIHRvIHNraXAgcmVhZC1vbmx5
IGJ0cmZzIHN1YnZvbHVtZXMgaW4gcmVzdG9yZWNvbg0KZW50aXJlbHkgb3IgcHJvdmlkZSBh
IGRpZmZlcmVudCByZXR1cm4gY29kZSBvdGhlciB0aGFuIHRoZSBjYXRjaGFsbCBMQUJFTF9G
SUxFX0tJTkRfSU5WQUxJRD8NCk9yIGlzIHRoZXJlIGFub3RoZXIgd2F5IHRoYXQgd2UgZGlk
IG5vdCBzZWU/DQoNCkZvciBtb3JlIGNvbnRleHQsIHRoaXMgaXMgdGhlIGJ1ZyBvbiBvdXIg
c2lkZTogaHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTIzMjIy
Ng0KVGhlcmUgd2FzIGFsc28gc29tZSBjb21tZW50cyBhYm91dCBwb3NzaWJsZSBpbXBsZW1l
bnRhdGlvbiwgc2VlIGNvbW1lbnQgMSBpbiB0aGUgYnVnLg0KDQpUaGFua3MgOikNCg0KS2lu
ZCByZWdhcmRzLA0KDQpDYXRoeQ0KDQpbMF0gaHR0cHM6Ly9naXRodWIuY29tL29wZW5TVVNF
L21pY3Jvb3MtdG9vbHMvYmxvYi9tYXN0ZXIvc2VsaW51eC9zZWxpbnV4LWF1dG9yZWxhYmVs
LWdlbmVyYXRvcg0KDQotLSANCkNhdGh5IEh1IDxjYWh1QHN1c2UuZGU+DQpTRUxpbnV4IFNl
Y3VyaXR5IEVuZ2luZWVyDQpHUEc6IDU4NzMgQ0ZEMSA4QzBFIEE2RDQgOUNCQiBGNkM0IDA2
MkEgMTAxNiAxNTA1IEEwOEENCg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBH
bWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYNCjkwNDYxIE7DvHJuYmVyZw0KDQpHZXNjaMOkZnRz
ZsO8aHJlcjogSXZvIFRvdGV2LCBBbmRyZXcgTWNEb25hbGQsIFdlcm5lciBLbm9ibGljaA0K
KEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KDQo=
--------------tECRMcyTtH5IxOd4JQWFvl2o
Content-Type: application/pgp-keys; name="OpenPGP_0x062A10161505A08A.asc"
Content-Disposition: attachment; filename="OpenPGP_0x062A10161505A08A.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D=3D
=3DNxaA
-----END PGP PUBLIC KEY BLOCK-----

--------------tECRMcyTtH5IxOd4JQWFvl2o--

--------------J1Dpq0DQykCdtImXuTKJoLpf--

--------------F9e9b0blcXoDVMdwdAGQNNyo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmfYKG8ACgkQBioQFhUF
oIqOdxAAjql7SVe5IftAgcY4x6nDFzikgEJh/uR8Yq/OtS+kUOLt1Jb+OiMsKf6K
JWCqgNjJzm1NjKTH1TZOtxrGtdJ4xNBBrEUxyqWxQQTAUeMNSjOr9A8f0Z/M+7za
njkbZMwmSQzoNsunpgrEzl3VrlByJn3vY2P97NsKBT/hS2wqCJSJeuCvhReXIBxw
sJjfAUWTBDdSrRGzDxzQ9jwbCdOEx5I2w8nvnYhldqmAKNeknadH0PVqebd/inYU
y3G5AF4d4q/ARUd4xOtD04OPpo4/YD1NgvD7Db/KuISkhm6qH5iOAaHBK7Rg1VjY
GVVEEjSlNWkG15WPYi7zBAtn+8wkfpwPlyXlEoXGRAUfMldqbFcl0RupRTIJ7JLJ
E1mVb9dt6qXLkZV+bprvgMu4Juhvokie7j7+XRAzxqpKdy/yVtnwOZqApR1CeDa6
78EOn+BOJZHhJbWcuxXLdB0RuGdjt5pXgkafpeld+/IJx/JvfNfUxVPH8jT7k/MA
KFdaI1FeSfBZIVDJCSmdQXlJZNpKtwEHaf0nf3aiV4nMUQOCmh+LI/ru0etaNr2E
GViRDOdlgRodtocShJ1+AbvVXwwwU8X1zMDwmTDJ7fndV0fa13X3P7tUOe4gz6bZ
Mxq05TkniJjLmja5INbxGL6PGo0IKwSVHFfSsFr5VIMx36T2GTQ=
=AhxY
-----END PGP SIGNATURE-----

--------------F9e9b0blcXoDVMdwdAGQNNyo--
