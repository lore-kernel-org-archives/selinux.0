Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48828689F
	for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720720; cv=none; b=CMT1A1N7S7kBlIeW1B6rqz4/v45mSmQoYKmtBLwKCdBEOEVcuggZ5aFegnjDCo3GdxmrZ3OU1QlUDTpHEEllU2k3okx9DrCmNI3AXGZWT/IKQNRM38cJdg+wnodEoFjdfg8GDp2+bgD9mJIwlcpQxdXA56i0vgRFnWBQ5q10/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720720; c=relaxed/simple;
	bh=FrYQ4NCXQU64iqFzgfguPzB92N0fjiNp08v30+4e+nc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=gGtMcUDFoJDppcDi0KjwUWk+QCayb/mO9KDkvMtz7Xdrix17qhBeu8lWums+jFYCOc+Cq/bN/QGEikTB1Zpc5XHU/ckX4vuFHzDCwluVui5LilahXcohuZFDGrNnmdkPJluOww9B4iNESsOvAP91dsCel87fUqqDy3cMQonJtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BtFQHQbK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vB7m/RFB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vCbr0Yy4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JkwzRQjZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BtFQHQbK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vB7m/RFB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vCbr0Yy4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JkwzRQjZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1B0A2170C;
	Fri, 21 Nov 2025 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763720710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=FrYQ4NCXQU64iqFzgfguPzB92N0fjiNp08v30+4e+nc=;
	b=BtFQHQbKS/ZrkIj/CrsDVkDmS+Zf5ns/V+VBP8xGAt8gcFcdBllhohLtGIkn5EhYy307R7
	AOy7VGBc/MUsHnL7Mcya6gLdqTP8v1O4DkUGom3kcpSPsJwog8z2vTVrs8WjhyIVZEdlpq
	VfJQk1QZhJoVQOS98JM5yJAVKQAQJno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763720710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=FrYQ4NCXQU64iqFzgfguPzB92N0fjiNp08v30+4e+nc=;
	b=vB7m/RFBG6zuXOtJ3SLeKqMxbVF19ySoaxvr31/xAvIg5KlyTXGpmLqskYqE1ldleGlYsA
	p26KzV0THl9x59DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763720709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=FrYQ4NCXQU64iqFzgfguPzB92N0fjiNp08v30+4e+nc=;
	b=vCbr0Yy4cltXssFJNRQFEL3z/2xFEqF3dUwpKJf1BbBSa56G3NSn4shen4RSAqZrsPT0q/
	wFyS0+F6zwXEUHYsizOWqrE6oxIDuig4LK38KKE06AXjtwyqp06K6XXNJ0gvsNzO4yzSRs
	QzEA1k41xLi8fmj/PQA/7Ii59DzJQd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763720709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=FrYQ4NCXQU64iqFzgfguPzB92N0fjiNp08v30+4e+nc=;
	b=JkwzRQjZ+JwT8xPp4Xz0dYIWu2DDbJtoQvgJq9o/47xrmXFSHCLVy2CdPBdc3xHqq2rkt7
	P/0N8EBfHvWYxeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3DFC3EA61;
	Fri, 21 Nov 2025 10:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q06/JgU+IGmSKQAAD6G6ig
	(envelope-from <cahu@suse.de>); Fri, 21 Nov 2025 10:25:09 +0000
Message-ID: <e004aaad-7885-420e-9001-af4897885daf@suse.de>
Date: Fri, 21 Nov 2025 11:25:08 +0100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Subject: Question regarding no_new_privs for pid 1 and SELinux
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
To: selinux@vger.kernel.org
Cc: selinux@suse.de, paul@paul-moore.com, Vit Mojzis <vmojzis@redhat.com>,
 Zdenek Pytela <zpytela@redhat.com>, stephen.smalley.work@gmail.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Wn77lBUGlqr6peh1EhApoXh6"
X-Spamd-Result: default: False [-4.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_BASE64_TEXT(0.10)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,paul-moore.com,redhat.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,opensuse.org:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.80
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Wn77lBUGlqr6peh1EhApoXh6
Content-Type: multipart/mixed; boundary="------------ji7LHxrM5gMf4607I4bCRShA";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: selinux@suse.de, paul@paul-moore.com, Vit Mojzis <vmojzis@redhat.com>,
 Zdenek Pytela <zpytela@redhat.com>, stephen.smalley.work@gmail.com
Message-ID: <e004aaad-7885-420e-9001-af4897885daf@suse.de>
Subject: Question regarding no_new_privs for pid 1 and SELinux

--------------ji7LHxrM5gMf4607I4bCRShA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGhhdmUgc29tZSBxdWVzdGlvbnMgcmVnYXJkaW5nIHRoZSAibm5wX3Ry
YW5zaXRpb24iLg0KV2UgYXJlIHNlZWluZyBlZmZvcnRzIGN1cnJlbnRseSB0byBkaXNhYmxl
IG1vc3Qgc2V0dWlkL2dpZCBiaW5hcmllcyBieQ0KdXNpbmcgbm9fbmV3X3ByaXZzIGluIHBp
ZCAxIFswXToNCg0KaHR0cHM6Ly93d3cudGhrdWt1ay5kZS9ibG9nL25vX25ld19wcml2cy8N
Cg0KRm9yIGNvbnRleHQsIHdlIGFyZSB1c2luZyB0aGUgZmVkb3JhIHBvbGljeSBhcyB1cHN0
cmVhbSB3aXRoIHNvbWUgDQptb2RpZmljYXRpb25zIGFuZCB0aGUgcmVndWxhciB1c2Vyc3Bh
Y2UgdG9vbGNoYWluLg0KDQpUaGUgcHJvYmxlbSB0aGF0IHdlIGhhdmUgYXRtIGlzIHRoYXQg
c2V0dGluZyBub19uZXdfcHJpdnMgZm9yIHBpZCAxIA0KKHN5c3RlbWQpDQptZWFucyB0aGF0
IHRoZSBzdWJzZXF1ZW50IGRvbWFpbiB0cmFuc2l0aW9ucyB3aGVyZSBleGVjdmUgaXMgdXNl
ZCB3b3VsZCANCm5lZWQgdG8gaGF2ZSBubnBfdHJhbnNpdGlvbiBhbGxvd2VkLg0KDQpJIGFt
IGN1cnJlbnRseSB1bnN1cmUgYWJvdXQ6DQoNCjEpIFtRdWVzdGlvbiBmb3Iga2VybmVsIHBl
b3BsZV0gLi4uIHRoZSBpbXBhY3QgdGhhdCB3b3VsZCBoYXZlLCBhcyBJIA0KZG9uJ3QgcmVh
bGx5IGZ1bGx5IHVuZGVyc3RhbmQgdGhlIGV4YWN0IHZlY3RvciB0aGF0IHdhcyBkZXNjcmli
ZWQgaW4gdGhlIA0Ka2VybmVsIGNvbW1pdCBbMF0gYnkgU3RlcGhlbiBhbmQgUGF1bDoNCg0K
IkFsbG93aW5nIG5ucF90cmFuc2l0aW9uIGJldHdlZW4gdHdvIGNvbnRleHRzIG9wZW5zIHVw
IHRoZSBwb3RlbnRpYWwgZm9yIA0KdGhlIG9sZCBjb250ZXh0IHRvIHN1YnZlcnQgdGhlIG5l
dyBjb250ZXh0IGJ5IGluc3RhbGxpbmcgc2VjY29tcCBmaWx0ZXJzIA0KYmVmb3JlIHRoZSBl
eGVjdmUuIEFsbG93aW5nIG5vc3VpZF90cmFuc2l0aW9uIGJldHdlZW4gdHdvIGNvbnRleHRz
IG9wZW5zIA0KdXAgdGhlIHBvdGVudGlhbCBmb3IgYSBjb250ZXh0IHRyYW5zaXRpb24gdG8g
b2NjdXIgb24gYSBmaWxlIGZyb20gYW4gDQp1bnRydXN0ZWQgZmlsZXN5c3RlbSAoZS5nLiBy
ZW1vdmFibGUgbWVkaWEgb3IgcmVtb3RlIGZpbGVzeXN0ZW0pLiBVc2UgDQp3aXRoIGNhcmUu
Ig0KDQpXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBoYXZlIGEgbW9yZSBpbi1kZXB0aCBleHBs
YW5hdGlvbiAoYW5kIG1heWJlIA0KcmVjb21tZW5kYXRpb24gZm9yIHRoZSBwb2xpY3kpPyBU
aGFua3MgOkQNCg0KMikgW1F1ZXN0aW9uIGZvciBmZWRvcmEgYW5kIHVzZXJzcGFjZSBwZW9w
bGVdIC4uLiBob3cgdGhpcyBjb3VsZCBiZSANCmltcGxlbWVudGVkIGluIHRoZSBwb2xpY3ks
IHN1Y2ggdGhhdCB0aGlzIHdvdWxkIGJlIGVpdGhlciBhY2NlcHRlZCBieSANCnRoZSBmZWRv
cmEgcG9saWN5IG9yIHdlIHdvdWxkIG5vdCBkaXZlcmdlIHRvbyBtdWNoLg0KDQpUaGUgcHJv
YmxlbSBoZXJlIGlzLCB0aGF0IGJlY2F1c2Ugb2YgMSksIHdlIGxpa2VseSB3b3VsZCB3YW50
IHRvIGhhdmUgaXQgDQpub3QgYXMgZGVmYXVsdCBhbmQgbWF5YmUgYmVoaW5kIGEgYm9vbGVh
biAoPykNCg0KSSB0cmllZCBhZGRpbmcgYSB0dW5hYmxlX3BvbGljeSB0byAiZG9tYWluX3Ry
YW5zaXRpb25fcGF0dGVybiIgWzFdLCANCndoaWNoIGRvZXMgbm90IHdvcmssIGFzIHRoZSBt
NCBnZW5lcmF0ZXMgbmVzdGVkIGlmKCkNCndoZW4gdGhlIGRvbWFpbiB0cmFuc2l0aW9uIGlz
IGJlaGluZCBhIGRpZmZlcmVudCBib29sZWFuIGFscmVhZHksIHdoaWNoIA0KaXMgbm90IGFj
Y2VwdGVkIGJ5IHRoZSBwYXJzZXIuIFRoYXQgc2VlbXMgdG8gYmUgbm90IGVhc2lseSB3b3Jr
YXJvdW5kYWJsZS4NCg0KU28gdGhlIG9ubHkgaWRlYSBsZWZ0IHRoYXQgSSBoYXZlIGlzIHRv
IGNyZWF0ZSBhIHBhdHRlcm4gYW5kIGFkZCBpdCB0byANCmV2ZXJ5IGRvbWFpbiB0cmFuc2l0
aW9uIG1hbnVhbGx5LiBJIGFtIG5vdCBzdXJlIGlmIHRoYXQgYmlnIGNoYW5nZSB3b3VsZCAN
CmJlIGFjY2VwdGFibGUgb3IgaWYgdGhlcmUgYXJlIGFueSBvdGhlciB3YXlzL2lkZWFzIHRv
IGFjY29tcGxpc2ggdGhhdD8NCg0KVGhhbmtzIGEgbG90IGFuZCBwbGVhc2UgbGV0IG1lIGtu
b3cgaWYgSSBhbSB0b3RhbGx5IG9uIHRoZSB3cm9uZyB0cmFjayANCmhlcmUgOikNCg0KS2lu
ZCByZWdhcmRzLA0KDQpDYXRoeQ0KDQpbMF0NCmh0dHBzOi8vd3d3LnRoa3VrdWsuZGUvYmxv
Zy9ub19uZXdfcHJpdnMvDQpodHRwczovL2dpdGh1Yi5jb20vdGhrdWt1ay9hY2NvdW50LXV0
aWxzDQpodHRwczovL2J1aWxkLm9wZW5zdXNlLm9yZy9wcm9qZWN0cy9ob21lOmt1a3VrOm5v
X25ld19wcml2cy9wYWNrYWdlcy9kaXNhYmxlLXNldHVpZC9maWxlcy8xMC1kaXNhYmxlLXNl
dHVpZC5jb25mP2V4cGFuZD0xDQpbMV0gaHR0cHM6Ly93d3cucGF1bC1tb29yZS5jb20vYmxv
Zy9kLzIwMTcvMTEvbGludXhfdjQxNC5odG1sDQpbMl0gDQpodHRwczovL2dpdGh1Yi5jb20v
ZmVkb3JhLXNlbGludXgvc2VsaW51eC1wb2xpY3kvYmxvYi9yYXdoaWRlL3BvbGljeS9zdXBw
b3J0L21pc2NfcGF0dGVybnMuc3B0I0w0DQoNCg0KLS0gDQpDYXRoeSBIdSA8Y2FodUBzdXNl
LmRlPg0KU0VMaW51eCBTZWN1cml0eSBFbmdpbmVlcg0KR1BHOiA1ODczIENGRDEgOEMwRSBB
NkQ0IDlDQkIgRjZDNCAwNjJBIDEwMTYgMTUwNSBBMDhBDQoNClNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2DQo5MDQ2MSBOw7xybmJl
cmcNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IEpvY2hlbiBKYXNlciwgQW5kcmV3IE1jRG9uYWxk
LCBXZXJuZXIgS25vYmxpY2gsIChIUkIgDQozNjgwOSwgQUcgTsO8cm5iZXJnKQ0KDQo=

--------------ji7LHxrM5gMf4607I4bCRShA--

--------------Wn77lBUGlqr6peh1EhApoXh6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmkgPgQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEAYqEBYVBaCKWeMQAJtIrJEoR4EpBd9pTqb8
dv3CQjKUWpZ9n8fThv9m9bQIBkIuZ9HGddN5DZXfPqZqUht1YzAfKtQGy34WW80p
pE1kYqmLxcAWBBu1lmVU5tC4tZyC/OXS5wv3IVRN+YYYndcs79UU93FqCqyh2GtG
2RH3X/86Q8NenkfxoWdU2E68zjaZsU3TjpBfAi8MsG6AhZ/i8X/OraZnR327KPLJ
NOip5gc9aaRi0tlo3NFTEJgXfS966H0IKXzEcrumwqE1pNysG4U/54rSwOin5yqT
5B6Ep1Bc9yJib6TRHAOQP9N8AXbhQjSCnLwdKyDVafTTIRE3Suex+o7jmTl2p5Im
nU5AdIaSkdIQG/w04GJJ18Mpodj1QRHOprt/QWDmivkxUvUbn5d4jhAEADTT8YvS
9pddW5sdWS06wni9Arn2GItmH3FgbCY7TNa+P94KL7juye+KWzhkzZw3eEBr0IVO
O2cd8tLZI+tipnY56FWcslr98SnjNYrzHC02BAdxQDfu5vuk4vVsNGsqVRiID1FB
v+s6cBywO6J32tyBdJwq09b8a/VAn5LrXOiivj/QoUSRQWTfNIz6XPYThvPK1xag
OkoxyJ01veKHBQkCYrGlFqZ/MPOXWSXtVj+ChncEhYSalp9vZsDQ+gCLHUhr7ur/
NMNoallo+KTGbepzrbVIHy+b
=+gzs
-----END PGP SIGNATURE-----

--------------Wn77lBUGlqr6peh1EhApoXh6--
