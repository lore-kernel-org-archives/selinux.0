Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170F1917F0
	for <selinux@vger.kernel.org>; Wed, 10 Dec 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765382117; cv=none; b=hoWN6FjFmGWGvqym1C6eONMoPT5KtUZUQDqHWzwj6iH2KYPMal9LJLsu//CnP4fjgz7Gb0QPuHfNH54Q6wSO0wNggS6pAj9Bw9gGIFBfZicKTUblTHbuh8Ej6rzYQi0vnFtbFrzqPdXGautyO5SgR9EipINp3nROIwC011DorAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765382117; c=relaxed/simple;
	bh=CBKu6vpyPC4s0sS2QF4ZmCo+AGn7772b4OmowDTCJBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXKZrby+fVFrF7KM3zq7qIG2waY62+iQnxhB+2SQxsvIB14l2QjmNcRvk2cIJjk+I9uxQJtGb4sLM0PlCPNhrzYm1wG6W+uzclldCQfFzqf4q82FQGpy5SPt/blcp+6K0M3b23ZNgzuuYna/Y2nK5HnyMAHok0chiI0AyjXwsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VaIE3s6Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oEezbjVe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VaIE3s6Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oEezbjVe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VaIE3s6Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oEezbjVe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VaIE3s6Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oEezbjVe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 544845BD1D;
	Wed, 10 Dec 2025 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765382113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CBKu6vpyPC4s0sS2QF4ZmCo+AGn7772b4OmowDTCJBo=;
	b=VaIE3s6QVsGqOo0/83Oe3mAOFDVeB85mKV3IIILawWNirYBDX9whW5tBpJBt+tHmb0Slgq
	R3jNYRsSf3Y/vtdqF9CdQfTgbnSj9yN6W4xO8JHwwI2MM/RNEdQ73uBxyO29Oc8x4o2O8P
	ydTAdbQWnlIMEljOg2S05ifNoFAhA6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765382113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CBKu6vpyPC4s0sS2QF4ZmCo+AGn7772b4OmowDTCJBo=;
	b=oEezbjVe3l/cEPFKaz2QzzgAo5U74tO65RPvY/9PbaA9nZmZTS8fXzvANVfDUEpEmlloSO
	BnPK9c2TV36oiVBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VaIE3s6Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oEezbjVe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765382113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CBKu6vpyPC4s0sS2QF4ZmCo+AGn7772b4OmowDTCJBo=;
	b=VaIE3s6QVsGqOo0/83Oe3mAOFDVeB85mKV3IIILawWNirYBDX9whW5tBpJBt+tHmb0Slgq
	R3jNYRsSf3Y/vtdqF9CdQfTgbnSj9yN6W4xO8JHwwI2MM/RNEdQ73uBxyO29Oc8x4o2O8P
	ydTAdbQWnlIMEljOg2S05ifNoFAhA6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765382113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CBKu6vpyPC4s0sS2QF4ZmCo+AGn7772b4OmowDTCJBo=;
	b=oEezbjVe3l/cEPFKaz2QzzgAo5U74tO65RPvY/9PbaA9nZmZTS8fXzvANVfDUEpEmlloSO
	BnPK9c2TV36oiVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 396E63EA63;
	Wed, 10 Dec 2025 15:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RgZyDeGXOWkuOgAAD6G6ig
	(envelope-from <cahu@suse.de>); Wed, 10 Dec 2025 15:55:13 +0000
Message-ID: <d906f09e-5a1a-4d57-afd6-503103bc44be@suse.de>
Date: Wed, 10 Dec 2025 16:55:11 +0100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question regarding no_new_privs for pid 1 and SELinux
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, selinux@suse.de, paul@paul-moore.com,
 Vit Mojzis <vmojzis@redhat.com>, Zdenek Pytela <zpytela@redhat.com>,
 Chris PeBenito <pebenito@ieee.org>
References: <e004aaad-7885-420e-9001-af4897885daf@suse.de>
 <CAEjxPJ4eE_gau==Fj6fytyQb=jciQo+x391iDUh4EbJUMfrGKw@mail.gmail.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <CAEjxPJ4eE_gau==Fj6fytyQb=jciQo+x391iDUh4EbJUMfrGKw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DHvjxLdvUYzvGlV1UqGrPMlZ"
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 544845BD1D
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DHvjxLdvUYzvGlV1UqGrPMlZ
Content-Type: multipart/mixed; boundary="------------mxRwl0AkaEMr8r4MS4L07OEZ";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, selinux@suse.de, paul@paul-moore.com,
 Vit Mojzis <vmojzis@redhat.com>, Zdenek Pytela <zpytela@redhat.com>,
 Chris PeBenito <pebenito@ieee.org>
Message-ID: <d906f09e-5a1a-4d57-afd6-503103bc44be@suse.de>
Subject: Re: Question regarding no_new_privs for pid 1 and SELinux
References: <e004aaad-7885-420e-9001-af4897885daf@suse.de>
 <CAEjxPJ4eE_gau==Fj6fytyQb=jciQo+x391iDUh4EbJUMfrGKw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4eE_gau==Fj6fytyQb=jciQo+x391iDUh4EbJUMfrGKw@mail.gmail.com>

--------------mxRwl0AkaEMr8r4MS4L07OEZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMjEvMjUgMzoxNSBQTSwgU3RlcGhlbiBTbWFsbGV5IHdyb3RlOg0KPiANCj4gVGhl
IGdlbmVyYWwgcHJpbmNpcGxlIGlzIHRoYXQgaXQgc2hvdWxkIGJlIHNhZmUgdG8gYWxsb3cN
Cj4gbm5wX3RyYW5zaXRpb24gd2hlbiB0aGUgY2FsbGluZy9vbGQgZG9tYWluIGlzIG1vcmUg
dHJ1c3RlZCB0aGFuIHRoZQ0KPiBjYWxsZWQvbmV3IGRvbWFpbi4NCj4gU28gZm9yIHRyYW5z
aXRpb25zIGZyb20gaW5pdC9zeXN0ZW1kLCBJIHdvdWxkbid0IGJlIGNvbmNlcm5lZCBhYm91
dA0KPiBhbGxvd2luZyBubnBfdHJhbnNpdGlvbiBwZXJtaXNzaW9uLiBEaXR0byBmb3IgdHJh
bnNpdGlvbnMgZnJvbSBhbnkNCj4gdW5jb25maW5lZCBkb21haW4uDQo+IE90aGVyd2lzZSwg
SSB3b3VsZCBiZSBjYXV0aW91cyB3aXRoIGFsbG93aW5nIGl0IGZyb20gYW55IGNvbmZpbmVk
DQo+IGRvbWFpbiwgYWx0aG91Z2ggYWdhaW4gaWYgeW91IHRydXN0IHRoZSBjYWxsaW5nIGRv
bWFpbiB0byBzZXQgdXAgb3RoZXINCj4gYXNwZWN0cyBvZiB0aGUgc3RhdGUgb2YgdGhlIGNh
bGxlZCBkb21haW4sIGl0IG1heSBiZSBmaW5lLiBJZiB5b3UNCj4gYWxyZWFkeSBhbGxvdyAi
bm9hdHNlY3VyZSIgcGVybWlzc2lvbiBiZXR3ZWVuIHRoZSB0d28gZG9tYWlucywgdGhlbg0K
PiB5b3UndmUgYWxyZWFkeSBhbGxvd2VkIHRoZSBjYWxsZXIgdG8gZXhlcnQgc3Vic3RhbnRp
YWwgaW5mbHVlbmNlIG92ZXINCj4gdGhlIGNhbGxlZSBhbmQgaGVuY2UgYWxsb3dpbmcgbm5w
X3RyYW5zaXRpb24gc2hvdWxkIGJlIChubyBsZXNzKSBzYWZlLg0KPiANCg0KVGhhbmtzIGEg
bG90IGZvciB0aGUgZXhwbGFuYXRpb24hDQoNCj4+IDIpIFtRdWVzdGlvbiBmb3IgZmVkb3Jh
IGFuZCB1c2Vyc3BhY2UgcGVvcGxlXSAuLi4gaG93IHRoaXMgY291bGQgYmUNCj4+IGltcGxl
bWVudGVkIGluIHRoZSBwb2xpY3ksIHN1Y2ggdGhhdCB0aGlzIHdvdWxkIGJlIGVpdGhlciBh
Y2NlcHRlZCBieQ0KPj4gdGhlIGZlZG9yYSBwb2xpY3kgb3Igd2Ugd291bGQgbm90IGRpdmVy
Z2UgdG9vIG11Y2guDQo+IA0KPiBJJ2xsIGRlZmVyIHRoaXMgb25lIHRvIHRoZSBwb2xpY3kg
Zm9sa3MuIEFkZGVkIENocmlzIFAgdG8gdGhlIGNjIGZvcg0KPiB0aGUgdXBzdHJlYW0gcmVm
cG9saWN5IHZpZXcuDQo+IA0KRllJLCBJIHN0YXJ0ZWQgdGVzdGluZyBvdXQgZGlmZmVyZW50
IGltcGxlbWVudGF0aW9ucyBhbmQgaGl0dGluZyB3YWxscywgDQpub3Qgc3VyZSBpZiBzb21l
b25lIHdvdWxkIGhhdmUgYSBtb3JlIGNsZXZlciB3YXkgb3IgaWRlYXMgOikNCmh0dHBzOi8v
Z2l0aHViLmNvbS9mZWRvcmEtc2VsaW51eC9zZWxpbnV4LXBvbGljeS9wdWxsLzI5OTMNCg==


--------------mxRwl0AkaEMr8r4MS4L07OEZ--

--------------DHvjxLdvUYzvGlV1UqGrPMlZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmk5l98bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEAYqEBYVBaCK+Q4QAJL+8JfDxKV2ha8s0HhE
Izd0m662jNJKwCl2FXjBi2pAT4ORC6WibTkYxmAB2efSzCWN3l9v3VtFONnS/MS1
K6XAotvrpFT81rFQ8ai6piL74iIrff8/HeAr0snq2YpZ9ykkyaXqYutNb+NF7j7i
3q34jbBPqxaZQmL5a9u1gXMLzAScq824JJwN3ZCCqN9eWdUezetKcpiNSlxu70yU
4JTMAo5tpEmkZmySkr0HAJnCbhqQN3Fb2gVvf0uSOQUn4/oA3leJ/qRWKm+JJ4EW
IAAVFFNZWSkbYGUQDi4Qe9PTN/1yyxjMR8lDjrHxwr8Vkt0E0hT9lwq6A43iNhT5
qM52Oejo2rARoNh8WE6slyUNu0/RLolv5Uw5oW3oDzKitqxQolfskWqbLta6bAAy
h8NUA9XRCq1g46MT6C9vhAWR9yjIqzvd7O+2s4l3IUWkR8jFmMQaY6b1cGHd3r8L
eOpdsfoQoqBewMhaT8c4e2o6wTL/4UnveW9FBStPyLY5kLTEsIhH8iB9QzT/OOkb
c1VItEVqUdDR6IDSuDIEsJTGiuLLzszrTzstUv4vWuwTLK+aFwBZhFSRhmgX3yqc
+RjNzFEnHdINhsKBR2QASGg/oZRqJ0li4nt8GUvd6acQa8T/bSLlPAI4KQc+3TVr
e4nUh8MX1f/mSQSJ9/s5P78d
=2EAi
-----END PGP SIGNATURE-----

--------------DHvjxLdvUYzvGlV1UqGrPMlZ--
