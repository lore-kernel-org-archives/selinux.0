Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22E3C199B
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546692; cv=none; b=Gki/EfgNZJgelUC+UlRrpUszcQvnU5h/6y8dk1lZ+dnlZaE/pDga7eFEE4B+bKFtcfXZF7ZMhA9Q5cdGXYiKxLCBVgruzjx8mt9IeeXQ98Se4wacl0lpL+6rgls9qKCLg8yGHiOCRH2r1owMqsQcQkQ1jkXE+BiKnhUJUYjWtvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546692; c=relaxed/simple;
	bh=92DVuuFiUeJ8uZzMq8Dlz+9B0LThM3OOeOGZZAeTFwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YCaJP4ph6YTO4ZIqcJ8ZV4AvDRWLEqaiVbqS4okpo3r7UfXEJlVma0Mbh8s+OxJqnqV/wJYHMGco9MTr98wAS2+d5pjrir9tgZmvNkouZjwLncefcGVlOY5EEJgvr6n0cCeLe1Woma++ayFXawJ9r9D8RyTQQH/78DdhhLi53YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TzguYc6G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LNTyVcF7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TzguYc6G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LNTyVcF7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TzguYc6G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LNTyVcF7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TzguYc6G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LNTyVcF7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 334F86A803;
	Thu, 30 Apr 2026 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777546689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=92DVuuFiUeJ8uZzMq8Dlz+9B0LThM3OOeOGZZAeTFwU=;
	b=TzguYc6G5tKV2qYPSWeknrZR7hrYRycHkmMAnl2v3Swp0NR78tB4slH4iiD2K6vIAVWnFR
	1wRZwOpnJ+ZVVsxxm8DnSZMN2xgfN+q8rxq3+EpXCl9p20ww48L4yCpLsvA+rAh9Fk/B1Y
	y/58M85jZzZVlRktndeAcdsm4sNqtUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777546689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=92DVuuFiUeJ8uZzMq8Dlz+9B0LThM3OOeOGZZAeTFwU=;
	b=LNTyVcF7fy3Zj9VAODuXQops2mOwKO2oegSpL0orC5mV4xcj8KI6CJ50Ljmfg4YdMjtOSN
	NvBXyIlVqzcEUHBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TzguYc6G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LNTyVcF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777546689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=92DVuuFiUeJ8uZzMq8Dlz+9B0LThM3OOeOGZZAeTFwU=;
	b=TzguYc6G5tKV2qYPSWeknrZR7hrYRycHkmMAnl2v3Swp0NR78tB4slH4iiD2K6vIAVWnFR
	1wRZwOpnJ+ZVVsxxm8DnSZMN2xgfN+q8rxq3+EpXCl9p20ww48L4yCpLsvA+rAh9Fk/B1Y
	y/58M85jZzZVlRktndeAcdsm4sNqtUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777546689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=92DVuuFiUeJ8uZzMq8Dlz+9B0LThM3OOeOGZZAeTFwU=;
	b=LNTyVcF7fy3Zj9VAODuXQops2mOwKO2oegSpL0orC5mV4xcj8KI6CJ50Ljmfg4YdMjtOSN
	NvBXyIlVqzcEUHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E69E593B0;
	Thu, 30 Apr 2026 10:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 40j8BcE182l7HgAAD6G6ig
	(envelope-from <cahu@suse.de>); Thu, 30 Apr 2026 10:58:09 +0000
Message-ID: <539483da-4001-4394-a592-e72687d05b52@suse.de>
Date: Thu, 30 Apr 2026 12:58:07 +0200
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
 <875x5ctkeu.fsf@redhat.com> <53d9cc60-73a0-4c65-90c7-58cb51f1f6a5@suse.de>
 <87tssvs6tl.fsf@redhat.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <87tssvs6tl.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WmgLlqA4E0FrbmRQzyUGAejh"
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 334F86A803

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WmgLlqA4E0FrbmRQzyUGAejh
Content-Type: multipart/mixed; boundary="------------UwpPwCCZ4LsC0bFwDtUqWi68";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Message-ID: <539483da-4001-4394-a592-e72687d05b52@suse.de>
Subject: Re: [PATCH] restorecon: Only log error on readonly fs (bsc#1257996)
References: <20260310153249.2077092-3-cahu@suse.de>
 <875x5ctkeu.fsf@redhat.com> <53d9cc60-73a0-4c65-90c7-58cb51f1f6a5@suse.de>
 <87tssvs6tl.fsf@redhat.com>
In-Reply-To: <87tssvs6tl.fsf@redhat.com>

--------------UwpPwCCZ4LsC0bFwDtUqWi68
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yOC8yNiAxMjo0NCBQTSwgUGV0ciBMYXV0cmJhY2ggd3JvdGU6DQo+IA0KPiB0aGFu
a3MgZm9yIHRoZSBwb2ludGVycywgaXQncyBjbGVhciBub3cuDQo+IA0KPiBJcyBpdCBleHBl
Y3RlZCB0aGF0IGl0IHdvdWxkIHdvcmsgb25seSBpbiBmaXJzdCBsZXZlbCBvZiBzdWJkaXJl
Y3Rvcmllcz8NCj4gDQo+ICQgbW91bnQgfCBncmVwIC9tbnQNCj4gL2Rldi9sb29wMCBvbiAv
bW50IHR5cGUgZXh0NCAocm8scmVsYXRpbWUsc2VjbGFiZWwpDQo+IC9kZXYvbG9vcDEgb24g
L21udC9ydyB0eXBlIGV4dDQgKHJ3LHJlbGF0aW1lLHNlY2xhYmVsKQ0KPiAvZGV2L2xvb3Ay
IG9uIC9tbnQvYS9iL2MvZC9ydyB0eXBlIGV4dDQgKHJ3LHJlbGF0aW1lLHNlY2xhYmVsKQ0K
PiANCj4gJCBzdWRvIHJlc3RvcmVjb24gLVIgLXYgL21udA0KPiBSZWFkIG9ubHkgZmlsZXN5
c3RlbSwgcmVsYWJlbCBub3QgcG9zc2libGU6IC9tbnQNCj4gUmVhZCBvbmx5IGZpbGVzeXN0
ZW0sIHJlbGFiZWwgbm90IHBvc3NpYmxlOiAvbW50L2xvc3QrZm91bmQNCj4gUmVhZCBvbmx5
IGZpbGVzeXN0ZW0sIHJlbGFiZWwgbm90IHBvc3NpYmxlOiAvbW50L2ENCj4gUmVsYWJlbGVk
IC9tbnQvcncgZnJvbSBzeXN0ZW1fdTpvYmplY3Rfcjp1c2VyX2hvbWVfdDpzMCB0byBzeXN0
ZW1fdTpvYmplY3RfcjptbnRfdDpzMA0KPiBSZWFkIG9ubHkgZmlsZXN5c3RlbSwgcmVsYWJl
bCBub3QgcG9zc2libGU6IC9tbnQvMQ0KPiANCj4gSXQgc2VlbXMgdG8gYmUgdXNlZnVsIGp1
c3QgZm9yIG9uZSBzcGVjaWZpYyB1c2UgY2FzZS4NCg0KTm8sIHNvIGl0IHdpbGwgY29udGlu
dWUgdHJhdmVyc2luZy4gVGhlIHByb2JsZW0gaW4gdGhpcyB0ZXN0IGNhc2UgaXMgdGhhdCAv
bW50L2EvYiBkb2VzIG5vdCBoYXZlIGEgZGVmYXVsdCBsYWJlbCwgdGhlcmVmb3JlIGl0IHdp
bGwgbm90IGNvbnRpbnVlOg0KDQokIG1hdGNocGF0aGNvbiAvbW50L2EvYg0KL21udC9hL2IJ
PDxub25lPj4NCg0KDQpJZiB5b3UgdHJ5IGl0IG9uIGFub3RoZXIgZGlyZWN0b3J5IHRoYXQg
ZG9lcyBoYXZlIGEgZGVmYXVsdCBsYWJlbCBpdCB3aWxsIGNvbnRpbnVlLiBGb3IgZXhhbXBs
ZSB3aXRoIHRoaXMgdGVzdCBjYXNlIGluIC92YXIvbGliL2RhdGEyIGl0IHdvcmtzOg0KDQpt
a2RpciAtcCAvdG1wL3NvdXJjZV9iYXNlIC90bXAvc291cmNlX3J3MSAvdG1wL3NvdXJjZV9y
dzINCm1rZGlyIC1wIC90bXAvc291cmNlX2Jhc2UvcncNCm1rZGlyIC1wIC90bXAvc291cmNl
X2Jhc2UvYS9iL2MvZC9ydw0KdG91Y2ggL3RtcC9zb3VyY2VfcncxL2Zvbw0KY2hjb24gLXQg
aHR0cGRfZXhlY190IC90bXAvc291cmNlX3J3MS9mb28NCnRvdWNoIC90bXAvc291cmNlX3J3
Mi9mb28NCmNoY29uIC10IGh0dHBkX2V4ZWNfdCAvdG1wL3NvdXJjZV9ydzIvZm9vDQoNCm1v
dW50IC0tYmluZCAvdG1wL3NvdXJjZV9iYXNlIC92YXIvbGliL2RhdGEyDQptb3VudCAtbyBy
ZW1vdW50LHJvLGJpbmQgL3Zhci9saWIvZGF0YTINCm1vdW50IC0tYmluZCAvdG1wL3NvdXJj
ZV9ydzEgL3Zhci9saWIvZGF0YTIvcncNCm1vdW50IC0tYmluZCAvdG1wL3NvdXJjZV9ydzIg
L3Zhci9saWIvZGF0YTIvYS9iL2MvZC9ydw0KDQpPdXRwdXQ6DQoNCiQgcmVzdG9yZWNvbiAt
UnYgL3Zhci9saWIvZGF0YTINClJlYWQgb25seSBmaWxlc3lzdGVtLCByZWxhYmVsIG5vdCBw
b3NzaWJsZTogL3Zhci9saWIvZGF0YTINClJlYWQgb25seSBmaWxlc3lzdGVtLCByZWxhYmVs
IG5vdCBwb3NzaWJsZTogL3Zhci9saWIvZGF0YTIvYQ0KUmVhZCBvbmx5IGZpbGVzeXN0ZW0s
IHJlbGFiZWwgbm90IHBvc3NpYmxlOiAvdmFyL2xpYi9kYXRhMi9hL2INClJlYWQgb25seSBm
aWxlc3lzdGVtLCByZWxhYmVsIG5vdCBwb3NzaWJsZTogL3Zhci9saWIvZGF0YTIvYS9iL2MN
ClJlYWQgb25seSBmaWxlc3lzdGVtLCByZWxhYmVsIG5vdCBwb3NzaWJsZTogL3Zhci9saWIv
ZGF0YTIvYS9iL2MvZA0KUmVsYWJlbGVkIC92YXIvbGliL2RhdGEyL2EvYi9jL2QvcncgZnJv
bSB1bmNvbmZpbmVkX3U6b2JqZWN0X3I6dXNlcl90bXBfdDpzMCB0byB1bmNvbmZpbmVkX3U6
b2JqZWN0X3I6dmFyX2xpYl90OnMwDQpSZWxhYmVsZWQgL3Zhci9saWIvZGF0YTIvYS9iL2Mv
ZC9ydy9mb28gZnJvbSB1bmNvbmZpbmVkX3U6b2JqZWN0X3I6aHR0cGRfZXhlY190OnMwIHRv
IHVuY29uZmluZWRfdTpvYmplY3Rfcjp2YXJfbGliX3Q6czANClJlbGFiZWxlZCAvdmFyL2xp
Yi9kYXRhMi9ydyBmcm9tIHVuY29uZmluZWRfdTpvYmplY3RfcjptbnRfdDpzMCB0byB1bmNv
bmZpbmVkX3U6b2JqZWN0X3I6dmFyX2xpYl90OnMwDQpSZWxhYmVsZWQgL3Zhci9saWIvZGF0
YTIvcncvZm9vIGZyb20gdW5jb25maW5lZF91Om9iamVjdF9yOmh0dHBkX2V4ZWNfdDpzMCB0
byB1bmNvbmZpbmVkX3U6b2JqZWN0X3I6dmFyX2xpYl90OnMwDQoNCj4gDQo+IEFsc28gY291
bGQgeW91IHBsZWFzZSBpbXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZSBzbyBpdCBjb250YWlu
cyBzb21lDQo+IHJlYXNvbiwgdXNlcyBjYXNlIGFuZCB0aGUgZmluYWwgZWZmZWN0PyBpdCB3
aWxsIGhlbHAgZnV0dXJlIHJldmlld2VycyB0byBiZXR0ZXINCj4gdW5kZXJzdGFuZCB0aGlz
IGNoYW5nZS4NCg0KVGhhbmtzLCB5ZXMgd2lsbCBkbywgSSB3aWxsIHNlbmQgYSB1cGRhdGVk
IHBhdGNoIHdpdGggYSBtb3JlIGRlc2NyaXB0aXZlIGNvbW1pdCBtZXNzYWdlIGxhdGVyLg0K
DQoNCg==

--------------UwpPwCCZ4LsC0bFwDtUqWi68--

--------------WmgLlqA4E0FrbmRQzyUGAejh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmnzNb8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCK8JgP/jLNZ88hXksOEC1qVjdj
7ZxNadtJOKQpjMD/VL242BUHMx+ZlcW/JYcS6ysdhWKmdG2ABolmBZVIQwRupGSt
2cUIqp1L9zxArm5RO1DsL3QmeTF13KNdio8/NJsAvqvR/sc+ShiJ6IzXAPAugW96
amOaD+VOnCvmUBywjwnI4vmXJgah7Vzx2lCrffCQZLKqZc49SZFm3lZWUz5xYahh
5UcqLajdQWlToHeSPL2Lj1CHOZzdmT/6bDq9g5LtjXZPcAhxSswCWnT36BkGElv5
euIjfP12eY8M1ggm48jFH403eM0lUtUUKi2/F59qVUMid3wCi8aKRLYuE+FdjyP+
tdXcnot4gAiuFSyHfkXaw4ZNIQI3PDY96myVL5J2eIzMQnQf898StMNj817ggMud
TvuTeSv9wFc9UJGwol/YSJ3wy95lMcj1foLJjP6ivKeromfoRA5uycSVf5HKK95L
Ab/vF3fq8lKGFqhUop10p/td9bEysopSwLmQfzQgErWuOb68n6b1hn7sAs34INdr
G+sY+1SBUxbflI1VKaGi/cwGihxB5pxKhzEOoJRO5lHSdSK8JmiAYK88mJqeIGSo
GBvGxAWSN5o0ByP43jxkyP438E1mMyAR3KTpJhfe+3fVO8oegopRDvtNsfvRp66P
vi9AQz4o/epScw/pE/HTHbZf
=X6h3
-----END PGP SIGNATURE-----

--------------WmgLlqA4E0FrbmRQzyUGAejh--
