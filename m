Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699EE37E319
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367907; cv=none; b=AghEyEOQ8o94qBOSv0OBJfiAE05T6KHzg9xmlCoMi9KRU8p/FJoCR0b2kxqgwpO+h5FAWyoJzRdNjZNo187oZn0lTIl4ocZogB30PQIBNyWRR3cMcerebr/D0LcxCifnjQweBcW32LqII48BwgtZDQC6WVj9Cnq5pXi+NdQqF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367907; c=relaxed/simple;
	bh=7PiRUs5aMjBolOeow7dritY1ZxMiYPPu0oB3P+qAZpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ET9RYw/z/BvFKA7+onN1PAyQNUdvjvXG1vcLSv7+Op5QFL+yRRBBHoKnW6JStu2jpONoGL5A5TVKC8HBzra2beW45qgS0zqLTL+5ha19QpOVq3CLHJFEfE7O4temkLRNpakt7ql0kIyt3QJEH1Zbi993ZRpcb5S2Rq+lkkGRCHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dCP287Lv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kdaBlmV3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dCP287Lv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kdaBlmV3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dCP287Lv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kdaBlmV3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dCP287Lv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kdaBlmV3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FBB95BD0E;
	Tue, 28 Apr 2026 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777367904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7PiRUs5aMjBolOeow7dritY1ZxMiYPPu0oB3P+qAZpo=;
	b=dCP287Lv39heX8yzgT8W0mcBIsxDVKM2xWESj4noljJQ0UhES1vtCeJuyEvtuLytBI7JQu
	9VlTyd3sFSeBNK2iif39chvj3ldi3TZcRRucrlelXSj9CAeUQRLrgEqo0rMwDc3Ig+KEnj
	KTGnVCi8oAxoMnzEceAtXiy3YaU5EFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777367904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7PiRUs5aMjBolOeow7dritY1ZxMiYPPu0oB3P+qAZpo=;
	b=kdaBlmV3DiK1aQMWSzGgqz10o5MPrJRlBX0AM2xx3ubvrcq1r+b4XQJVsfCLW3rpL4WFzi
	8jHmm6uOyk8wX2Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dCP287Lv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kdaBlmV3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777367904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7PiRUs5aMjBolOeow7dritY1ZxMiYPPu0oB3P+qAZpo=;
	b=dCP287Lv39heX8yzgT8W0mcBIsxDVKM2xWESj4noljJQ0UhES1vtCeJuyEvtuLytBI7JQu
	9VlTyd3sFSeBNK2iif39chvj3ldi3TZcRRucrlelXSj9CAeUQRLrgEqo0rMwDc3Ig+KEnj
	KTGnVCi8oAxoMnzEceAtXiy3YaU5EFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777367904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7PiRUs5aMjBolOeow7dritY1ZxMiYPPu0oB3P+qAZpo=;
	b=kdaBlmV3DiK1aQMWSzGgqz10o5MPrJRlBX0AM2xx3ubvrcq1r+b4XQJVsfCLW3rpL4WFzi
	8jHmm6uOyk8wX2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9166A593B0;
	Tue, 28 Apr 2026 09:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 45PdImB78GlHaAAAD6G6ig
	(envelope-from <cahu@suse.de>); Tue, 28 Apr 2026 09:18:24 +0000
Message-ID: <53d9cc60-73a0-4c65-90c7-58cb51f1f6a5@suse.de>
Date: Tue, 28 Apr 2026 11:18:23 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] restorecon: Only log error on readonly fs (bsc#1257996)
To: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
References: <20260310153249.2077092-3-cahu@suse.de>
 <875x5ctkeu.fsf@redhat.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <875x5ctkeu.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rmRSFnXI1lTdJqtMo3mr7K23"
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.984];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,suse.com:url]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9FBB95BD0E

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rmRSFnXI1lTdJqtMo3mr7K23
Content-Type: multipart/mixed; boundary="------------owakQNejo0VfxwqlzaRV0CN6";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Message-ID: <53d9cc60-73a0-4c65-90c7-58cb51f1f6a5@suse.de>
Subject: Re: [PATCH] restorecon: Only log error on readonly fs (bsc#1257996)
References: <20260310153249.2077092-3-cahu@suse.de>
 <875x5ctkeu.fsf@redhat.com>
In-Reply-To: <875x5ctkeu.fsf@redhat.com>

--------------owakQNejo0VfxwqlzaRV0CN6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yNy8yNiA2OjUyIFBNLCBQZXRyIExhdXRyYmFjaCB3cm90ZToNCj4gQ2F0aHkgSHUg
PGNhaHVAc3VzZS5kZT4gd3JpdGVzOg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IENhdGh5IEh1
IDxjYWh1QHN1c2UuZGU+DQo+PiAtLS0NCj4+IFJGQyBQYXRjaCBmb3IgdGhlIGlzc3VlIGRl
c2NyaWJlZCBpbiB0aHJlYWQgIlF1ZXN0aW9uIHJlZ2FyZGluZyByZXN0b3JlY29uIGFuZCBi
dHJmcyByZWFkLW9ubHkgc25hcHNob3RzIg0KPj4NCj4gDQo+IENvdWxkIHlvdSBwb2ludCBt
ZSB3aGVyZSBJIGNhbiBmaW5kIHRoZSB0aHJlYWQgYW5kIGlzIGJzYyMxMjU3OTk2Pw0KDQoi
UXVlc3Rpb24gcmVnYXJkaW5nIHJlc3RvcmVjb24gYW5kIGJ0cmZzIHJlYWQtb25seSBzbmFw
c2hvdHMiIFRocmVhZDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3NlbGludXgvOThmODdm
ZDYtNmQzZS00NTM5LWFkOGYtMWEwZGMwOWFhODkwQHN1c2UuZGUvDQoNCmJzYyMxMjU3OTk2
OiBHb29kIHBvaW50LCB0aGF0IGlzIHRoZSB3cm9uZyBidWcgbnVtYmVyLCB0aGUgcmlnaHQg
b25lIGlzOg0KaHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTIz
MjIyNg0KSSB3aWxsIHJlZnJlc2ggdGhlIHBhdGNoIGFmdGVyIHRoZSBkaXNjdXNzaW9uDQoN
Cg0KPiANCj4gV2hhdCdzIHRoZSBleHBlY3RlZCBvdXRjb21lPyBCZWZvcmUgdGhpcyBjaGFu
Z2UgSSBzZWU6DQo+IA0KPiAkIHN1ZG8gcmVzdG9yZWNvbiAtUiAtdiAvbW50Lw0KPiByZXN0
b3JlY29uOiBDb3VsZCBub3Qgc2V0IGNvbnRleHQgZm9yIC9tbnQ6ICBSZWFkLW9ubHkgZmls
ZSBzeXN0ZW0NCj4gcmVzdG9yZWNvbjogQ291bGQgbm90IHNldCBjb250ZXh0IGZvciAvbW50
L2xvc3QrZm91bmQ6ICBSZWFkLW9ubHkgZmlsZSBzeXN0ZW0NCj4gcmVzdG9yZWNvbjogQ291
bGQgbm90IHNldCBjb250ZXh0IGZvciAvbW50L2E6ICBSZWFkLW9ubHkgZmlsZSBzeXN0ZW0N
Cj4gcmVzdG9yZWNvbjogQ291bGQgbm90IHNldCBjb250ZXh0IGZvciAvbW50LzE6ICBSZWFk
LW9ubHkgZmlsZSBzeXN0ZW0NCj4gDQo+IEFmdGVyOg0KPiANCj4gJCBzdWRvIHJlc3RvcmVj
b24gLVIgLXYgL21udC8NCj4gUmVhZCBvbmx5IGZpbGVzeXN0ZW0sIHJlbGFiZWwgbm90IHBv
c3NpYmxlOiAvbW50DQo+IFJlYWQgb25seSBmaWxlc3lzdGVtLCByZWxhYmVsIG5vdCBwb3Nz
aWJsZTogL21udC9sb3N0K2ZvdW5kDQo+IFJlYWQgb25seSBmaWxlc3lzdGVtLCByZWxhYmVs
IG5vdCBwb3NzaWJsZTogL21udC9hDQo+IFJlYWQgb25seSBmaWxlc3lzdGVtLCByZWxhYmVs
IG5vdCBwb3NzaWJsZTogL21udC8xDQo+IA0KPiBUaGlzIHNlZW1zIHRvIGJlIG9ubHkgYSBj
b3NtZXRpYyBjaGFuZ2UuDQoNCnJldHVybiB2YWx1ZSBzaG91bGQgYmUgMCB3aXRoIHRoZSBj
aGFuZ2UsIGJlZm9yZSB0aGF0IGl0IHdhcyAyNTUuDQpTbyBiZWZvcmUgaXQgd2FzIGZhaWxp
bmcsIG5vdyBpdCBpcyB0cmF2ZXJzZSBhbmQgbG9nIG9ubHkNCg0KDQo+IA0KPiBQZXRyDQo+
IA0KPiANCj4+ICAgbGlic2VsaW51eC9zcmMvc2VsaW51eF9yZXN0b3JlY29uLmMgfCA4ICsr
KysrKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL3NlbGludXhfcmVz
dG9yZWNvbi5jIGIvbGlic2VsaW51eC9zcmMvc2VsaW51eF9yZXN0b3JlY29uLmMNCj4+IGlu
ZGV4IDhmYWRmNGQyLi5lODU0NWUyNyAxMDA2NDQNCj4+IC0tLSBhL2xpYnNlbGludXgvc3Jj
L3NlbGludXhfcmVzdG9yZWNvbi5jDQo+PiArKysgYi9saWJzZWxpbnV4L3NyYy9zZWxpbnV4
X3Jlc3RvcmVjb24uYw0KPj4gQEAgLTc3NCwxMCArNzc0LDE0IEBAIHN0YXRpYyBpbnQgcmVz
dG9yZWNvbl9zYihjb25zdCBjaGFyICpwYXRobmFtZSwgY29uc3Qgc3RydWN0IHN0YXQgKnNi
LA0KPj4gICAJCWlmICghZmxhZ3MtPm5vY2hhbmdlKSB7DQo+PiAgIAkJCWlmIChsc2V0Zmls
ZWNvbihwYXRobmFtZSwgbmV3Y29uKSA8IDApIHsNCj4+ICAgCQkJCS8qIElnbm9yZSBmaWxl
cyByZW1vdmVkIGR1cmluZyByZWxhYmVsaW5nIGlmIGlnbm9yZV9ub2VudCBpcyBzZXQgKi8N
Cj4+IC0JCQkJaWYgKGZsYWdzLT5pZ25vcmVfbm9lbnQgJiYgZXJybm8gPT0gRU5PRU5UKQ0K
Pj4gKwkJCQlpZiAoZmxhZ3MtPmlnbm9yZV9ub2VudCAmJiBlcnJubyA9PSBFTk9FTlQpIHsN
Cj4+ICAgCQkJCQlnb3RvIG91dDsNCj4+IC0JCQkJZWxzZQ0KPj4gKwkJCQl9IGVsc2UgaWYg
KGVycm5vID09IEVST0ZTKSB7DQo+PiArCQkJCQlzZWxpbnV4X2xvZyhTRUxJTlVYX0lORk8s
ICJSZWFkIG9ubHkgZmlsZXN5c3RlbSwgcmVsYWJlbCBub3QgcG9zc2libGU6ICVzXG4iLCBw
YXRobmFtZSk7DQo+PiArCQkJCQlnb3RvIG91dDsNCj4+ICsJCQkJfSBlbHNlIHsNCj4+ICAg
CQkJCQlnb3RvIGVycjsNCj4+ICsJCQkJfQ0KPj4gICAJCQl9DQo+PiAgIA0KPj4gICAJCQl1
cGRhdGVkID0gdHJ1ZTsNCj4+IC0tIA0KPj4gMi41My4wDQo+IA0KDQo=

--------------owakQNejo0VfxwqlzaRV0CN6--

--------------rmRSFnXI1lTdJqtMo3mr7K23
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmnwe18bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCKshAQAIVJNy5P/AqQIL1g1J97
TBTWMtxQcNAuxRBDrIEUxOPtDRXGDFe9xLTnwtVjI/jVuIhSweQY0kNBx2wHsK3T
Im/Cf1O9dGfEXdICvIRwki2oaDqQTGF/XNfKdmP1NTHBDXUg6XXmtXAix16eWFC9
yeBb3gZmwbRYyGHwlJNYZGfCKhl1chJHDKfZpNKObpYzcA1EHjmQbUZ5oP4hEtuc
/A18L6ZGeavLlFPN4VXNM3/+agUYiJBLZOnj8+PT99+MncbZTigETwmnzV3g+zP7
ow4wqOYKEO/2LBPyfi8PHs+xzqT69t1m2ICHFrfOwSK1fl0uzX6JSBhUYm3aYmb1
/1deHq5jNyY1oxXA4f35P2ZnG4JJ38OfKuZo/YZ0HSIaQnKspRkv6M+4FCwi0+10
nVtEM4ooCgdn2XAscUDewdRMHmu3AE1CmRHTCBHAn52T3RQDQ0Kd+9eB0fkmoLyA
LX15fxnVzZPRPVEcEb66f0VNYlniD+acDiJRF/n28ZdDPN90Qgg5tdxi8XGKguj0
FgbSZtnVsuwRz5X9+0UUhKVp/CZ7l/UmAZfIskRSJkmMC9FgZw1UyJvCGmmqqe3I
vDESxQOc16kN4a3dz48YdoXivDQKHWxTX/39EHy5imI6/Wxj954xlHIhpBNtwovE
9hLdC+kKjS83G9zOyW/JkCyn
=u2mY
-----END PGP SIGNATURE-----

--------------rmRSFnXI1lTdJqtMo3mr7K23--
