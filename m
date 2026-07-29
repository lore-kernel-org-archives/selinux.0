Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471A3EDE75
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328788; cv=none; b=Ui7Ykt7jE7uSYSa8Ej9MARMtG7+moIKsubCl45CkMrfXM77Yg9ptO+YD2Ji5MHGGPiWlXRC1fDINvyx/f//agXcUwAATTyoRi53EuvAjEgp8OOhjkRu67FmP81GC115EPz1QgOY2jl6dre3zNE/UG8EmzT0vr/qMhYKlsU1ohOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328788; c=relaxed/simple;
	bh=a8EMykSM5MlZXvvelk762Xcr3+6Qc4oPZ+1/ytkmZ6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6UvmfIH/UDOOZQFX4AkRggepv9M1K4/SacHaREo3Cb9UVwbrA27m6ZFU/xS6qoBoysEn9PPOro3zFqME6Vu+MPp/OgpXh6Q3R68jjWGzTcJ6pQJLQ8doTWL3oOUZoSAPNtrfDO0OtJchGfwLWQjZGNalfgaYnach3qfjOScbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dtj1OXjS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TPxvE/0p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eLCjUnlH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QMffIPuC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dtj1OXjS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TPxvE/0p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eLCjUnlH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QMffIPuC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 322F47CA94;
	Wed, 29 Jul 2026 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785328774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a8EMykSM5MlZXvvelk762Xcr3+6Qc4oPZ+1/ytkmZ6g=;
	b=dtj1OXjSs96HFOG2I7lxSMcEZf2++uyKPAghMqCBkk6KNUvbDWhE01UQyHBr521czvojVg
	WZQn87TeJacxE8B5fBDojlMzKFg/lpezNqzsoXorwsIs5uCpTgYCnSh51Rpf1qnxTE68uN
	WiUZliaWNIiRhLoy6x5TdyF7RHoqRXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785328774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a8EMykSM5MlZXvvelk762Xcr3+6Qc4oPZ+1/ytkmZ6g=;
	b=TPxvE/0pIPLrLv7IIT78Sf9asi4WgUxbxJ7d7xGd4/kKfx7iM/8NK1KBvEXuGylSGFdCL8
	mvq5b6R4hlUFyuAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eLCjUnlH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QMffIPuC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785328770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a8EMykSM5MlZXvvelk762Xcr3+6Qc4oPZ+1/ytkmZ6g=;
	b=eLCjUnlHKbfhKJX0cV8lUlS7psuee1QfZmxNuEVx6Zqw9Tvcn/3umUjzPWpSDEhBBvFhoc
	IO+n7DMCykJJ9lPXlpKphMhyhUaBAWhz+TrykQ+aPRLUuGstYj2j5rMFtnXLZwKfVDsLDI
	AlhJgheC0BtaCtoKikidjgPg5feqIAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785328770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a8EMykSM5MlZXvvelk762Xcr3+6Qc4oPZ+1/ytkmZ6g=;
	b=QMffIPuCAtx2Q+xqhBhTM4Fz7fCi47XpJlCkAtvIXS5PEh8W/FKfyuWmV8tmal2hx7ZcqO
	mZF3H90v8OJX2xDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15E04779A1;
	Wed, 29 Jul 2026 12:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id edYnBIL0aWo7SAAAD6G6ig
	(envelope-from <cahu@suse.de>); Wed, 29 Jul 2026 12:39:30 +0000
Message-ID: <2fe6f92f-0288-48bb-a49c-8519bcd1ebfa@suse.de>
Date: Wed, 29 Jul 2026 14:39:28 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] python/sepolicy: add a pyproject.toml file
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
References: <20260724175059.18960-3-stephen.smalley.work@gmail.com>
 <20260724175059.18960-5-stephen.smalley.work@gmail.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <20260724175059.18960-5-stephen.smalley.work@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PO9Qe5ruL1xUWmh4GiV4Ak0A"
X-Spam-Score: -5.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 322F47CA94
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,sepolicy.py:url,setup.py:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PO9Qe5ruL1xUWmh4GiV4Ak0A
Content-Type: multipart/mixed; boundary="------------6sxzWUAXIzgid9EOgBKfWBVD";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Message-ID: <2fe6f92f-0288-48bb-a49c-8519bcd1ebfa@suse.de>
Subject: Re: [PATCH v2 2/2] python/sepolicy: add a pyproject.toml file
References: <20260724175059.18960-3-stephen.smalley.work@gmail.com>
 <20260724175059.18960-5-stephen.smalley.work@gmail.com>
In-Reply-To: <20260724175059.18960-5-stephen.smalley.work@gmail.com>

--------------6sxzWUAXIzgid9EOgBKfWBVD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNy8yNC8yNiA3OjUxIFBNLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6DQo+IEFkZCBhIHB5
cHJvamVjdC50b21sIGZpbGUgZm9yIHRoZSBzZXBvbGljeSBweXRob24gbW9kdWxlLiAgVGhp
cw0KPiByZXF1aXJlZCBhbHNvIHVwZGF0aW5nIHNldHVwLnB5IHRvIGF2b2lkIGRlZmluaW5n
IGF1dGhvciBvdXRzaWRlIG9mDQo+IHB5cHJvamVjdC50b21sLCBhbmQgSSBmdXJ0aGVyIHVw
ZGF0ZWQgdGhlIGF1dGhvcnMgdG8gcmVmZXIgdG8gdGhlIGxpc3QNCj4gbGlrZSBsaWJzZWxp
bnV4IHNpbmNlIERhbiBpcyBlbmpveWluZyByZXRpcmVtZW50Lg0KPiANCj4gRml4ZXM6IGh0
dHBzOi8vZ2l0aHViLmNvbS9TRUxpbnV4UHJvamVjdC9zZWxpbnV4L2lzc3Vlcy81MDUNCj4g
U2lnbmVkLW9mZi1ieTogU3RlcGhlbiBTbWFsbGV5IDxzdGVwaGVuLnNtYWxsZXkud29ya0Bn
bWFpbC5jb20+DQo+IC0tLQ0KPiB2MiBkcm9wcyB0aGUgZGVwZW5kZW5jaWVzIHNpbmNlIHRo
b3NlIHdlcmUgYnJlYWtpbmcsIHByZXN1bWFibHkNCj4gYmVjYXVzZSB0aGUgbGlic2VsaW51
eCBweXRob24gbW9kdWxlIGlzIGp1c3QgY2FsbGVkICJzZWxpbnV4Ij8NCj4gSSByZW1haW4g
dW5zdXJlIGFzIHRvIHRoZSBjb3JyZWN0bmVzcy9jb21wbGV0ZW5lc3Mgb2YgdGhlc2UgYnV0
DQo+IHRoZXkgZGlkIHBhc3MgdGhlIENJIGZ1bGx5Lg0KDQpJIHRoaW5rIGRyb3BwaW5nIHRo
ZSBkZXBlbmRlbmNpZXMgaXMgZmluZSBBVE0sIGFzIHNldHVwLnB5IGFsc28gZGlkIG5vdCBh
ZGQgdGhvc2UgZGVwZW5kZW5jaWVzLg0KDQpUaGUgdGVzdGluZyBmYXJtIChodHRwczovL2dp
dGh1Yi5jb20vU0VMaW51eFByb2plY3Qvc2VsaW51eC9hY3Rpb25zL3J1bnMvMzAwOTk5NjIw
MTIvam9iLzg5NTAzMjM4MDEzKSBmYWlsZWQgaSB0aGluayBiZWNhdXNlOg0KJCBweXRob24z
IC1tIHBpcCBpbnN0YWxsIC0tbm8tYnVpbGQtaXNvbGF0aW9uIC0tZm9yY2UtcmVpbnN0YWxs
IC0tcHJlZml4PS91c3IgYHRlc3QgLW4gIiIgJiYgZWNobyAtLXJvb3QgIC0taWdub3JlLWlu
c3RhbGxlZCAtLW5vLWRlcHNgIGRpc3QvKi53aGwNCg0KYW5kIHRlc3QgLW4gIiIgaXMgZmFs
c2UgKHNob3VsZCBiZSBERVNURElSKSwgc28gLS1uby1kZXBzIGlzIG5vdCB1c2VkIGFuZCB0
aGUgZGVwZW5kZW5jeSBzZWN0aW9uIGlzIGNoZWNrZWQuDQoNCkluIG91ciBidWlsZCBERVNU
RElSIGlzIHNldCB0byB0aGUgQlVJTERST09UIHNvIGl0IHdhcyBub3QgY2hlY2tpbmcgdGhl
IGRlcGVuZGVuY3kgc2VjdGlvbiBhbnl3YXkuDQoNCj4gDQo+ICAgcHl0aG9uL3NlcG9saWN5
L3B5cHJvamVjdC50b21sIHwgMTUgKysrKysrKysrKysrKysrDQo+ICAgcHl0aG9uL3NlcG9s
aWN5L3NldHVwLnB5ICAgICAgIHwgIDIgLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHB5
dGhvbi9zZXBvbGljeS9weXByb2plY3QudG9tbA0KPiANCj4gZGlmZiAtLWdpdCBhL3B5dGhv
bi9zZXBvbGljeS9weXByb2plY3QudG9tbCBiL3B5dGhvbi9zZXBvbGljeS9weXByb2plY3Qu
dG9tbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMC4uZDMzZTc4
YzgNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9weXRob24vc2Vwb2xpY3kvcHlwcm9qZWN0
LnRvbWwNCj4gQEAgLTAsMCArMSwxNSBAQA0KPiArW2J1aWxkLXN5c3RlbV0NCj4gK3JlcXVp
cmVzID0gWyJzZXR1cHRvb2xzIiwgIndoZWVsIl0NCj4gK2J1aWxkLWJhY2tlbmQgPSAic2V0
dXB0b29scy5idWlsZF9tZXRhIg0KPiArDQo+ICtbcHJvamVjdF0NCj4gK25hbWUgPSAic2Vw
b2xpY3kiDQo+ICt2ZXJzaW9uID0gIjMuMTEiDQo+ICtkZXNjcmlwdGlvbiA9ICJQeXRob24g
dG9vbHMgZm9yIFNFTGludXggcG9saWN5IGFuYWx5c2lzIChzZXBvbGljeSwgc2Vwb2xnZW4p
Ig0KPiArbGljZW5zZSA9ICJHUEwtMi4wLW9yLWxhdGVyIg0KPiArYXV0aG9ycyA9IFsNCj4g
KyAgICB7IG5hbWUgPSAiU0VMaW51eCBQcm9qZWN0IiwgZW1haWwgPSAic2VsaW51eEB2Z2Vy
Lmtlcm5lbC5vcmciIH0NCj4gK10NCj4gKw0KDQoNCj4gK1twcm9qZWN0LnNjcmlwdHNdDQo+
ICtzZXBvbGljeSA9ICJzZXBvbGljeS5fX21haW5fXzptYWluIg0KDQpJIGhhZCBhIGRlZXBl
ciBsb29rIGFuZCBJIGFtIG5vdCBzdXJlIGlmIHRoaXMgc2NyaXB0cyBwYXJ0IGlzIG5lZWRl
ZC4NCg0KQmVjYXVzZSBzZXBvbGljeSB3aWxsIHRocm93IGFuIGVycm9yIHdoZW4gaW5zdGFs
bGVkIHdpdGggcGlwIG9ubHk6DQoNCiQgY2QgcHl0aG9uL3NlcG9saWN5DQokIHB5dGhvbjMg
LW0gdmVudiAtLXN5c3RlbS1zaXRlLXBhY2thZ2VzIGVudg0KJCBzb3VyY2UgZW52L2Jpbi9h
Y3RpdmF0ZQ0KJCBwaXAgaW5zdGFsbCAuDQokIHNlcG9saWN5IC0taGVscA0KTW9kdWxlTm90
Rm91bmRFcnJvcjogTm8gbW9kdWxlIG5hbWVkICdzZXBvbGljeS5fX21haW5fXycNCg0KQmVj
YXVzZSBieSBhZGRpbmcgdGhlIFtwcm9qZWN0LnNjcmlwdHNdIHRhZywgc2V0dXB0b29scyB3
cml0ZXMgdGhpcyBpbnRvIGVudi9iaW4vc2Vwb2xpY3k6DQoNCmltcG9ydCBzeXMNCmZyb20g
c2Vwb2xpY3kuX19tYWluX18gaW1wb3J0IG1haW4NCmlmIF9fbmFtZV9fID09ICdfX21haW5f
Xyc6DQogICAgIHN5cy5hcmd2WzBdID0gc3lzLmFyZ3ZbMF0ucmVtb3Zlc3VmZml4KCcuZXhl
JykNCiAgICAgc3lzLmV4aXQobWFpbigpKQ0KDQpCdXQgX19tYWluX18ucHkgYW5kIG1haW4o
KSBkb2VzIG5vdCBleGlzdCwgc28gaXQgd29uJ3Qgd29yayBJIHRoaW5rLg0KDQpQcm9iYWJs
eSB0aGlzIHBhcnQgaXMgbm90IG5lZWRlZCBpbiB0aGlzIGNhc2UgYW55d2F5IGJlY2F1c2Ug
c2Vwb2xpY3kucHkgZ2V0cyBpbnN0YWxsZWQgIm1hbnVhbGx5IiBoZXJlIElJVUM6DQoNCmh0
dHBzOi8vZ2l0aHViLmNvbS9TRUxpbnV4UHJvamVjdC9zZWxpbnV4L2Jsb2IvYWQ3ZWZhY2Vh
OTk3ZWJhZDhjMTRiNjQ3MmNjYTU4OTkzYTM1ZDJkMi9weXRob24vc2Vwb2xpY3kvTWFrZWZp
bGUjTDMxLUwzMg0KDQpTbyBtaWdodCBtYWtlIHNlbnNlIHRvIGRlbGV0ZSB0aGUgc2NyaXB0
cyBzZWN0aW9uLg0KDQo+IGRpZmYgLS1naXQgYS9weXRob24vc2Vwb2xpY3kvc2V0dXAucHkg
Yi9weXRob24vc2Vwb2xpY3kvc2V0dXAucHkNCj4gaW5kZXggY2EwMzk2YjUuLjVjNGYyZTVk
IDEwMDY0NA0KPiAtLS0gYS9weXRob24vc2Vwb2xpY3kvc2V0dXAucHkNCj4gKysrIGIvcHl0
aG9uL3NlcG9saWN5L3NldHVwLnB5DQo+IEBAIC04LDggKzgsNiBAQCBzZXR1cCgNCj4gICAg
ICAgbmFtZT0ic2Vwb2xpY3kiLA0KPiAgICAgICB2ZXJzaW9uPSIzLjExIiwNCj4gICAgICAg
ZGVzY3JpcHRpb249IlB5dGhvbiBTRUxpbnV4IFBvbGljeSBBbmFseXNlcyBiaW5kaW5ncyIs
DQo+IC0gICAgYXV0aG9yPSJEYW5pZWwgV2Fsc2giLA0KPiAtICAgIGF1dGhvcl9lbWFpbD0i
ZHdhbHNoQHJlZGhhdC5jb20iLA0KPiAgICAgICBwYWNrYWdlcz1bDQo+ICAgICAgICAgICAi
c2Vwb2xpY3kiLA0KPiAgICAgICAgICAgInNlcG9saWN5LnRlbXBsYXRlcyIsDQoNCkkgdGhv
dWdodCBtYXliZSB0aGUgZHVwbGljYXRlIGRlZmluaXRpb25zIChuYW1lLCB2ZXJzaW9uLC4u
LikgaW4gc2V0dXAucHkgY291bGQgYmUgZHJvcHBlZCwNCmJ1dCBJIHRlc3RlZCBpdCBhbmQg
dGhlIChnY2MscHlweTMuNykgcnVubmVyIFswXSBzdGlsbCB0YWtlcyB0aGUgZGVmaW5pdGlv
bnMgZnJvbSBzZXR1cC5weQ0KZXZlbiB0aG91Z2ggcHlwcm9qZWN0LnRvbWwgZXhpc3RzIGJl
Y2F1c2Ugc2V0dXB0b29scy00Ny4xLjAgPCA2MS4wLjAuDQoNCldoaWNoIG1lYW5zLCBpdCBj
YW4gbm90IGZpbmQgdGhlIGRlZmluaXRpb25zIHdoZW4gc2V0dXAucHkgd2FzIGRyb3BwZWQu
DQogRnJvbSB0aGUgcnVubmVyIChodHRwczovL2dpdGh1Yi5jb20vY2EtaHUvc2VsaW51eC9j
b21taXQvM2EwODM2Yjk4Zjg0NmFmMzk4MTA4MWI4N2FiNzNlNWY1ZWQzZjk3Yik6DQo+IFRl
c3QgLmdpdGlnbm9yZSBhbmQgbWFrZSBjbGVhbiBkaXN0Y2xlYW4NCiAgIGVycm9yOiBtaXNz
aW5nIC5naXRpZ25vcmUgZW50cnkgZm9yIGxpYnNlbGludXgvc3JjL1VOS05PV04uZWdnLWlu
Zm8vDQogICBlcnJvcjogbWlzc2luZyAuZ2l0aWdub3JlIGVudHJ5IGZvciBweXRob24vc2Vw
b2xpY3kvVU5LTk9XTi5lZ2ctaW5mby8NCg0KXiBzZWUgVU5LTk9XTiBpbnN0ZWFkIG9mIHRo
ZSBwYWNrYWdlIG5hbWUNCg0KV2hpY2ggbWFrZXMgbWUgd29uZGVyIGlmIHRoZSBhdXRob3Ir
YXV0aG9yX2VtYWlsIG5lZWRzIHRvIGJlIGtlcHQgaW4gdGhlIHNldHVwLnB5IGFzIHdlbGwg
aWYgc2V0dXB0b29scyA8IDYxLjAuMCBpcyBzdGlsbCBzdXBwb3J0ZWQNCmFuZCBpdCBuZWVk
cyB0byBiZSBiYWNrd2FyZHMgY29tcGF0aWJsZS4NCg0KSW4gY2FzZSBzZXR1cHRvb2xzIDwg
NjEuMC4wIGlzIG5vdCBzdXBwb3J0ZWQgYW55bW9yZSBieSB0aGUgc2VsaW51eCB0b29sY2hh
aW4gKGl0IGlzIGF0IGxlYXN0IG5vdCBieSBzZXR1cHRvb2xzIHVwc3RyZWFtKSwgaXQgbWln
aHQgYmUgcG9zc2libGUgdG8gZHJvcCB0aGUgc2V0dXAucHkgZW50aXJlbHkgZm9yIHNlcG9s
aWN5IGFuZCByZWx5IG9uIHB5cHJvamVjdC50b21sIGFsb25lLg0KRXhhbXBsZToNCmh0dHBz
Oi8vZ2l0aHViLmNvbS9jYS1odS9zZWxpbnV4L2NvbW1pdC8zYTA4MzZiOThmODQ2YWYzOTgx
MDgxYjg3YWI3M2U1ZjVlZDNmOTdiDQoNCkF0IGxlYXN0IG9uIHRoZSBvcGVuU1VTRS9TVVNF
IFNMRVMgc2lkZSwgaWl1YyB3ZSBoYXZlIHNldHVwdG9vbHMgPj0gNjEuMC4wIGZvciBhbGwg
c3VwcG9ydGVkIHZlcnNpb25zLCBidXQgSSBkb24ndCBrbm93IGFib3V0IG90aGVyIGRpc3Ry
aWJ1dGlvbnMuDQoNCg0KQnV0IGZlZWwgZnJlZSB0byBkaXNyZWdhcmQgbXkgcmV2aWV3IGFu
ZCBtZXJnZSBpdCwgaXQgaXMgYnVpbGRpbmcgZmluZSBhcyBpcyBvbiBvdXIgZW5kLg0K

--------------6sxzWUAXIzgid9EOgBKfWBVD--

--------------PO9Qe5ruL1xUWmh4GiV4Ak0A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmpp9IAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCK/2wQAKPItPGQxvGv6Rh7nA5k
/w7knXBqVXUi2KlktUZbkJHvzW9yL9RpEk0BuukARN1op/TYnnnZa8bDCvdccpK9
WsMKPZKy0KYIPtlDJujUVnKTTVtGgpQyBkXshiR+h904u8fToof62DOp2gKwAwYF
8kw+mEBbU93LzCuIpw9cPGmZG7pV2z437M9iOKgvNsm6ATtx2tYRcmAsQBbyQG6S
x9EFHoLl8//pKgvwWN31X+OBFWm0HTzd+AkyrTZxnKpiAOGxaGABeP3YlipleB1D
gziQYYsJRPbpCPjQYSCGhHPUfR2uYIC2x0RxJYXo0biug8VlkAbuSEiroR4Pd2Ib
imMT33785gf7QvPeI5Ju4bX50iaEWzBQ2EuHD7rs7exARhadI32wjjKJFQsOu4H8
arF70U327kvhUNFAnJJWvEU3E4XbM9n1auvp9RF7/pABL9QdOnbWcroV4Jco/mj8
NPThbYqgfziSdLOg55MlaqFctyx6vcO+JYtaSS/KGB6QyjEFF3K1+HFfHO/lwjQe
OPJAEbJpXGfqgrqJBtnGGGEq3OFh5ZnBDPkSjB9WHspvS158CPFGwMKCwjYlBshz
9Rvpwm56pEGkN/ESb7ybKDuuhQY3+hofACD680JuVtrfxLau/FBu0un9NSLHPiBp
97oJUOm4wfuoZGaF5SmNW+dR
=wRC2
-----END PGP SIGNATURE-----

--------------PO9Qe5ruL1xUWmh4GiV4Ak0A--
