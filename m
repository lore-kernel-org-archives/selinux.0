Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92865445AC1
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905825; cv=none; b=ot31Ts7vmK+PCJI+fd+DlWIjAdeLmMGhi8GnsYy1znoamRzAz5NOLbw0y44WiIZ+9hF3HjjBPpfSkoixfN2WfTKmQv3QbTCggrdw8bIz9RxKuep4scffQvn7CeVnud2kCaX/ZjpdvQTVQVRt8bHGs8rcS+kdATbOOGjlLB+CZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905825; c=relaxed/simple;
	bh=zcIGdI8hGiBDKJ4ctfU/X9150OV3rqZtyz83bTK+dAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUYW3TES13r9QEuRenchZ/IlATMq220uYspHlTfOmSoIi/00Gnuyua/i2VLUWZMpro97NNh4pANZ6FbF9WjWiANB7JSlMYTuKclZHsSOoRJ4FpSgHYgGKoG64R3e5JsTpdS0xfhds58BurJSjCA7U7A5YHC2MNRgEPpIeyaiios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TcZX24lR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8zaW76My; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TcZX24lR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8zaW76My; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TcZX24lR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8zaW76My";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TcZX24lR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8zaW76My"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A45FF3F00;
	Fri, 24 Jul 2026 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784905820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zcIGdI8hGiBDKJ4ctfU/X9150OV3rqZtyz83bTK+dAA=;
	b=TcZX24lR8PkxnM6ANQoy92YAvrkHxFdAaBD+Yj3LpWXs1SCp6KZo8ae/Q8La8XYHj+A+T+
	uFsTeGMdbX+d7SqE4iJetyBpBGC7NMGx0xbXqehHBX2BSIJDXdIOydovXKUkSJRDtvuMrB
	R4r3ttiW32RIWN03gyfZX9bAnuZ1Ct4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784905820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zcIGdI8hGiBDKJ4ctfU/X9150OV3rqZtyz83bTK+dAA=;
	b=8zaW76MyvCMkWI4P1BASrgd/x/PMNVWyExWo/zfuPNnbWpuVidkVlW5GMyRxKqBRd/6Upj
	MVZvGeejJOV3FsDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TcZX24lR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8zaW76My
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784905820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zcIGdI8hGiBDKJ4ctfU/X9150OV3rqZtyz83bTK+dAA=;
	b=TcZX24lR8PkxnM6ANQoy92YAvrkHxFdAaBD+Yj3LpWXs1SCp6KZo8ae/Q8La8XYHj+A+T+
	uFsTeGMdbX+d7SqE4iJetyBpBGC7NMGx0xbXqehHBX2BSIJDXdIOydovXKUkSJRDtvuMrB
	R4r3ttiW32RIWN03gyfZX9bAnuZ1Ct4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784905820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zcIGdI8hGiBDKJ4ctfU/X9150OV3rqZtyz83bTK+dAA=;
	b=8zaW76MyvCMkWI4P1BASrgd/x/PMNVWyExWo/zfuPNnbWpuVidkVlW5GMyRxKqBRd/6Upj
	MVZvGeejJOV3FsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CECE779BA;
	Fri, 24 Jul 2026 15:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QdY2HVyAY2obBAAAD6G6ig
	(envelope-from <cahu@suse.de>); Fri, 24 Jul 2026 15:10:20 +0000
Message-ID: <694d78a7-bf38-4ad8-a024-dc22eef638c0@suse.de>
Date: Fri, 24 Jul 2026 17:10:18 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] python/sepolicy: add a pyproject.toml file
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
 omosnace@redhat.com
References: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
 <20260721185357.64896-4-stephen.smalley.work@gmail.com>
 <104ecf4e-7dc5-4bab-8f3b-b73f0aca5d41@suse.de>
 <CAEjxPJ6pKtPU7ozYg6D_OaVe7gLPnjT+Azw+gZygNT6Tj+W5Cw@mail.gmail.com>
 <CAEjxPJ6Ca5L0tHesizLcK3ouy2p-t9U1-CV=TXyAPUfztx36rA@mail.gmail.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <CAEjxPJ6Ca5L0tHesizLcK3ouy2p-t9U1-CV=TXyAPUfztx36rA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PWcVY5EXCLXT19hJGasUixVD"
X-Spam-Score: -6.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A45FF3F00
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,setup.py:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PWcVY5EXCLXT19hJGasUixVD
Content-Type: multipart/mixed; boundary="------------XFU5rLxPzokLcHu2X9sQT4nm";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
 omosnace@redhat.com
Message-ID: <694d78a7-bf38-4ad8-a024-dc22eef638c0@suse.de>
Subject: Re: [PATCH 2/2] python/sepolicy: add a pyproject.toml file
References: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
 <20260721185357.64896-4-stephen.smalley.work@gmail.com>
 <104ecf4e-7dc5-4bab-8f3b-b73f0aca5d41@suse.de>
 <CAEjxPJ6pKtPU7ozYg6D_OaVe7gLPnjT+Azw+gZygNT6Tj+W5Cw@mail.gmail.com>
 <CAEjxPJ6Ca5L0tHesizLcK3ouy2p-t9U1-CV=TXyAPUfztx36rA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Ca5L0tHesizLcK3ouy2p-t9U1-CV=TXyAPUfztx36rA@mail.gmail.com>

--------------XFU5rLxPzokLcHu2X9sQT4nm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNy8yNC8yNiA0OjQ0IFBNLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6DQo+IE9uIEZyaSwg
SnVsIDI0LCAyMDI2IGF0IDEwOjI24oCvQU0gU3RlcGhlbiBTbWFsbGV5DQo+IDxzdGVwaGVu
LnNtYWxsZXkud29ya0BnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIFdlZCwgSnVsIDIy
LCAyMDI2IGF0IDY6MjDigK9BTSBDYXRoeSBIdSA8Y2FodUBzdXNlLmRlPiB3cm90ZToNCj4+
Pg0KPj4+IE9uIDcvMjEvMjYgODo1MyBQTSwgU3RlcGhlbiBTbWFsbGV5IHdyb3RlOg0KPj4+
PiBBZGQgYSBweXByb2plY3QudG9tbCBmaWxlIGZvciB0aGUgc2Vwb2xpY3kgcHl0aG9uIG1v
ZHVsZS4gIFRoaXMNCj4+Pj4gcmVxdWlyZWQgYWxzbyB1cGRhdGluZyBzZXR1cC5weSB0byBh
dm9pZCBkZWZpbmluZyBhdXRob3Igb3V0c2lkZSBvZg0KPj4+PiBweXByb2plY3QudG9tbCwg
YW5kIEkgZnVydGhlciB1cGRhdGVkIHRoZSBhdXRob3JzIHRvIHJlZmVyIHRvIHRoZSBsaXN0
DQo+Pj4+IGxpa2UgbGlic2VsaW51eCBzaW5jZSBEYW4gaXMgZW5qb3lpbmcgcmV0aXJlbWVu
dC4NCj4+Pj4NCj4+Pj4gRml4ZXM6IGh0dHBzOi8vZ2l0aHViLmNvbS9TRUxpbnV4UHJvamVj
dC9zZWxpbnV4L2lzc3Vlcy81MDUNCj4+Pj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBTbWFs
bGV5IDxzdGVwaGVuLnNtYWxsZXkud29ya0BnbWFpbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAg
ICBweXRob24vc2Vwb2xpY3kvcHlwcm9qZWN0LnRvbWwgfCAxOSArKysrKysrKysrKysrKysr
KysrDQo+Pj4+ICAgIHB5dGhvbi9zZXBvbGljeS9zZXR1cC5weSAgICAgICB8ICAyIC0tDQo+
Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHB5dGhvbi9zZXBvbGljeS9weXByb2pl
Y3QudG9tbA0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvcHl0aG9uL3NlcG9saWN5L3B5cHJv
amVjdC50b21sIGIvcHl0aG9uL3NlcG9saWN5L3B5cHJvamVjdC50b21sDQo+Pj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAwLi40NzJmYWY3YQ0KPj4+PiAt
LS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL3B5dGhvbi9zZXBvbGljeS9weXByb2plY3QudG9t
bA0KPj4+PiBAQCAtMCwwICsxLDE5IEBADQo+Pj4+ICtbYnVpbGQtc3lzdGVtXQ0KPj4+PiAr
cmVxdWlyZXMgPSBbInNldHVwdG9vbHMiLCAid2hlZWwiXQ0KPj4+PiArYnVpbGQtYmFja2Vu
ZCA9ICJzZXR1cHRvb2xzLmJ1aWxkX21ldGEiDQo+Pj4+ICsNCj4+Pj4gK1twcm9qZWN0XQ0K
Pj4+PiArbmFtZSA9ICJzZXBvbGljeSINCj4+Pj4gK3ZlcnNpb24gPSAiMy4xMSINCj4+Pj4g
K2Rlc2NyaXB0aW9uID0gIlB5dGhvbiB0b29scyBmb3IgU0VMaW51eCBwb2xpY3kgYW5hbHlz
aXMgKHNlcG9saWN5LCBzZXBvbGdlbikiDQo+Pj4+ICtsaWNlbnNlID0gIkdQTC0yLjAtb3It
bGF0ZXIiDQo+Pj4+ICthdXRob3JzID0gWw0KPj4+PiArICAgIHsgbmFtZSA9ICJTRUxpbnV4
IFByb2plY3QiLCBlbWFpbCA9ICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIgfQ0KPj4+PiAr
XQ0KPj4+PiArZGVwZW5kZW5jaWVzID0gWw0KPj4+PiArICAgICJsaWJzZWxpbnV4LXB5dGhv
biIsDQo+Pj4+ICsgICAgImxpYnNlbWFuYWdlLXB5dGhvbiIsDQo+Pj4+ICtdDQo+Pj4+ICsN
Cj4+Pj4gK1twcm9qZWN0LnNjcmlwdHNdDQo+Pj4+ICtzZXBvbGljeSA9ICJzZXBvbGljeS5f
X21haW5fXzptYWluIg0KPj4+PiBkaWZmIC0tZ2l0IGEvcHl0aG9uL3NlcG9saWN5L3NldHVw
LnB5IGIvcHl0aG9uL3NlcG9saWN5L3NldHVwLnB5DQo+Pj4+IGluZGV4IGNhMDM5NmI1Li41
YzRmMmU1ZCAxMDA2NDQNCj4+Pj4gLS0tIGEvcHl0aG9uL3NlcG9saWN5L3NldHVwLnB5DQo+
Pj4+ICsrKyBiL3B5dGhvbi9zZXBvbGljeS9zZXR1cC5weQ0KPj4+PiBAQCAtOCw4ICs4LDYg
QEAgc2V0dXAoDQo+Pj4+ICAgICAgICBuYW1lPSJzZXBvbGljeSIsDQo+Pj4+ICAgICAgICB2
ZXJzaW9uPSIzLjExIiwNCj4+Pj4gICAgICAgIGRlc2NyaXB0aW9uPSJQeXRob24gU0VMaW51
eCBQb2xpY3kgQW5hbHlzZXMgYmluZGluZ3MiLA0KPj4+PiAtICAgIGF1dGhvcj0iRGFuaWVs
IFdhbHNoIiwNCj4+Pj4gLSAgICBhdXRob3JfZW1haWw9ImR3YWxzaEByZWRoYXQuY29tIiwN
Cj4+Pj4gICAgICAgIHBhY2thZ2VzPVsNCj4+Pj4gICAgICAgICAgICAic2Vwb2xpY3kiLA0K
Pj4+PiAgICAgICAgICAgICJzZXBvbGljeS50ZW1wbGF0ZXMiLA0KPj4+DQo+Pj4gbGd0bSwg
b3IgYXQgbGVhc3QgaSBkb24ndCBzZWUgdGhlIHdhcm5pbmcgYW55bW9yZSBpbiB0aGUgYnVp
bGQgc3lzdGVtDQo+Pg0KPj4gVGhhbmtzLCBib3RoIG1lcmdlZC4NCj4gDQo+IEFuZCBib3Ro
IHJldmVydGVkIHNpbmNlIHRoZXkgYnJva2UgdGhlIHRlc3RmYXJtIGJ1aWxkLg0KPiBXaWxs
IGRlZmVyIHRvIHNvbWVvbmUgYmV0dGVyIHZlcnNlZCBpbiB0aGlzIGFyZWEgdG8gZml4IHRo
aXMuDQoNCnRoYXQncyBvZGQsIG5vdCBzdXJlIHdoeSB0aGUgcGF0Y2ggc3VjY2Vzc2Z1bGx5
IGJ1aWx0IGluIG91ciBzeXN0ZW0sIGkgY2FuIGhhdmUgYSBsb29rIG5leHQgd2Vlaw0K

--------------XFU5rLxPzokLcHu2X9sQT4nm--

--------------PWcVY5EXCLXT19hJGasUixVD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmpjgFsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCK+XIQAMQAEaAKmmCtAhSzjCBt
agb6cbk+7fkbHpb5hT2t+78roFHkv3siQFQJw2USDYLMKKjjVDSwXnH/OreaFcSl
Q5KXkuVb0QGvHLoV0cRT3LC7SoLhcfNNkvjW1vyAsiy7GE2qgdtJB8C4mwIA3m34
b+MigqMsuHy9N6MXg2K2jw04nSJqAWb/l8uF1gj3Yli490NKAY9hcvydnVo9hxdj
k8Q5Lw0vEYrMoZudH58RBN03sqldj5MYA/LPdlBhdTiEi5M88jWBKxMPpNiXnNIj
ZhmlpdBfdqOhBDtygbK91PBoVMmv86zeOWA9QzMVZYm54j4KIL21s2Qz4GRp8JmO
Dore8gV4xCHk997lu9HSEZ166iANzWXaCnSthTXZG9Mf3lRqwy2Jj3Mic7EFUfNe
pBBeqm3koUtIAWT+tf7icDJT23ZVtN/Hs85jrhP8Fmjt9ks3DhwXJI7mlq3/i6+L
AoZG1CX9m5RbN5W1p1R0IZmrTK14FzNZAt6gwSBcK2rAsVy9DWfxFw6dhJS0dKCl
Axs86llc09HT6YNbf/2UhMmCP/PlcLq7JGyZuBA/1An4ULQnGLLDuNOErEYOsP6f
JQgabKCltfSrMH78LxJBEDNyO2JSOVhN5d6h+z4DHD+CtLsNbnWtjvzXaHJdFdhh
L2gLoYY1gFLWuUyHgDjvydNP
=zK5W
-----END PGP SIGNATURE-----

--------------PWcVY5EXCLXT19hJGasUixVD--
