Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D043112AB
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252025; cv=none; b=BSAlJnaNwtUcKwsxgMvsdtfZJrJUKiXf4bbDznqsSYXevoSjWYXXHiELbL3JH0xHwUXlPz0pHJZTncDnTKBfGU3L54ZZNxTSPucGs68pf+C8a4t+MH/iCD3zoFCoE0WOEouaFwD90HpgQ73k0GpCRj9397RFrK22lTn/n4bxWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252025; c=relaxed/simple;
	bh=/6JuOS/CMAua9V7hGEU+vf8KnTdH1x0TFF/tWlIXJtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECASAEKmmKeY3vQhUIoDwYc2LQ1oQDbD3kfyTz5USvPyTdAKIQPlDM/DBmMmNpC6EzEfu3V1dvTxuThU6wdtVXpqbRZcU8P8TCMSyqENwTaMElnlQJED2gxgaY/uKG3c/VwnXDwmUyQYxWclgnLzLE3FmPSdXRgBUpoUtRRXdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QxAZoPnC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YnqafDC1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xRX6x0wE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c55+U1rE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QxAZoPnC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YnqafDC1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xRX6x0wE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c55+U1rE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1E8421C82;
	Tue,  1 Sep 2026 08:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788252017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/6JuOS/CMAua9V7hGEU+vf8KnTdH1x0TFF/tWlIXJtE=;
	b=QxAZoPnCujmpg3WMj6TwWE4PyXHuQhYoX7Rij3R0XDN1g19G/l4cyEM5GbcDqMONm0oafR
	tlCNvkSMx5gi+Opnvq/PyJxFot/y9slUWKiyHrdTv7oyg1cW7kEyVgQ0xY+06XTLDxXNke
	mIU/CgGOeVX4wKeavl8lybq7gCNeqso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788252017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/6JuOS/CMAua9V7hGEU+vf8KnTdH1x0TFF/tWlIXJtE=;
	b=YnqafDC1OfUkXwTzpJFrb7eBMVDBNqVN7/7njYqOnc7Ele+YyIt5txlkWY5K9VpSWUmSIb
	U5OCS/GYAoLgf9DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xRX6x0wE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c55+U1rE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788252013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/6JuOS/CMAua9V7hGEU+vf8KnTdH1x0TFF/tWlIXJtE=;
	b=xRX6x0wER9OemFFm1lpcpnCckrl9NwIec7EtU9aOzCLLzYLnJ5DB3ZZCdQMYr2h+uFOb+1
	kk20u+RQ38OoMK02xb/BsywasW026ghmSF/OZItfPUgEZcfr33hRGJd0AYVqAOl0j5xNo+
	A+QTqZ/zxXsTcWxEergRUy7Fd2P0HO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788252013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/6JuOS/CMAua9V7hGEU+vf8KnTdH1x0TFF/tWlIXJtE=;
	b=c55+U1rEYjPtknst5tlsKI8TFX9lmSXBslN9anQ2mX6kxpCcofuUijEpkYk5m4mtkiTq2q
	fGB1I8iriWYkgLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CF8B13515;
	Tue,  1 Sep 2026 08:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ldVWCW2PlmrVEQAAD6G6ig
	(envelope-from <cahu@suse.de>); Tue, 01 Sep 2026 08:40:13 +0000
Message-ID: <9b2939c5-7935-4d2a-b628-6c3ba961e16f@suse.de>
Date: Tue, 1 Sep 2026 10:40:11 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] libsepol: drop support for policy versions before
 xperms_ioctl/xen_devicetree
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com,
 jason@perfinion.com, paul@paul-moore.com, Johannes Segitz <jsegitz@suse.de>,
 Russell Coker <russell@coker.com.au>, Laurent Bigonville <bigon@debian.org>,
 =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, selinux@suse.de
References: <20260827125511.19408-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mPG0nWpbIFvqZuCSSeEH9pPt"
X-Spam-Score: -6.01
X-Rspamd-Queue-Id: A1E8421C82
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,perfinion.com,paul-moore.com,suse.de,coker.com.au,debian.org,google.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mPG0nWpbIFvqZuCSSeEH9pPt
Content-Type: multipart/mixed; boundary="------------qnYs22NoOSPk2rIFV3xu6lwq";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com,
 jason@perfinion.com, paul@paul-moore.com, Johannes Segitz <jsegitz@suse.de>,
 Russell Coker <russell@coker.com.au>, Laurent Bigonville <bigon@debian.org>,
 =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, selinux@suse.de
Message-ID: <9b2939c5-7935-4d2a-b628-6c3ba961e16f@suse.de>
Subject: Re: [PATCH v5] libsepol: drop support for policy versions before
 xperms_ioctl/xen_devicetree
References: <20260827125511.19408-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>

--------------qnYs22NoOSPk2rIFV3xu6lwq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOC8zMS8yNiA4OjAxIFBNLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6DQo+IE9uIFRodSwg
QXVnIDI3LCAyMDI2IGF0IDk6NDnigK9BTSBTdGVwaGVuIFNtYWxsZXkNCj4gPHN0ZXBoZW4u
c21hbGxleS53b3JrQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gRHJvcCBzdXBwb3J0IGZv
ciBrZXJuZWwgYW5kIG1vZHVsZSBwb2xpY3kgdmVyc2lvbnMgYmVmb3JlIHRoZQ0KPj4geHBl
cm1zX2lvY3RsIHN1cHBvcnQgKFNFTGludXgga2VybmVsIHBvbGljeSB2ZXJzaW9uIDMwLCBt
b2R1bGFyIHBvbGljeQ0KPj4gdmVyc2lvbiAxOCkgYW5kIHhlbl9kZXZpY2V0cmVlIHN1cHBv
cnQgKFhlbiBwb2xpY3kgdmVyc2lvbiAzMCkuIEtlcm5lbA0KPj4gcG9saWN5IHZlcnNpb24g
MzAgd2FzIGZpcnN0IHN1cHBvcnRlZCBpbiBMaW51eCB2NC4zLCBYZW4gNC42LCBhbmQNCj4+
IGxpYnNlcG9sIDIuNSAoMjAxNjAyMjMpLiBNb2R1bGFyIHBvbGljeSB2ZXJzaW9uIDE4IHdh
cyBmaXJzdCBzdXBwb3J0ZWQNCj4+IGluIGxpYnNlcG9sIDIuNyAoMjAxNzA4MDQpLg0KPj4N
Cj4+IFJIRUwgPj0gOCwgRGViaWFuID49IDEwLCBVYnVudHUgPj0gMTguMDQsIGFuZCBTVVNF
L1NMRVMgPj0gMTUgaGF2ZQ0KPj4gbGlic2Vwb2wgPj0gMi43Ky4NCj4gDQo+IFdvdWxkIGFw
cHJlY2lhdGUgYW55IGZlZWRiYWNrIGZyb20gZGlzdHJvIHBhY2thZ2UgbWFpbnRhaW5lcnMg
b24NCj4gaG93L2lmIHRoaXMgY2hhbmdlIHdvdWxkDQo+IGltcGFjdCB0aGVtLiBMaW5rIHRv
IHRoZSBvcmlnaW5hbCBwYXRjaCBmb3IgdGhvc2Ugd2hvIHdlcmVuJ3QgY2MnZCBvbiBpdDoN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc2VsaW51eC8yMDI2MDgyNzEyNTUxMS4xOTQw
OC0yLXN0ZXBoZW4uc21hbGxleS53b3JrQGdtYWlsLmNvbS9ULyN1DQo+IA0KPiBUaGlzIHdv
dWxkIGJyZWFrIGUuZy4gUkhFTCA3LCBEZWJpYW4gOSwgVWJ1bnR1IDE2LjA0LCBvciBTVVNF
L1NMRVMgMTINCj4gaWYgdGhleSBldmVyIHVwZGF0ZWQgdG8gYSB2ZXJzaW9uIG9mIGxpYnNl
cG9sIHdpdGggdGhpcyBjaGFuZ2UgYnV0IEkNCj4gdGhpbmsgdGhhdCdzIHVubGlrZWx5Lg0K
DQpTTEVTIHNob3VsZCBiZSBmaW5lOg0KLSBTTEVTIDEyOiB2ZXJzaW9uIGJ1bXBzIGFyZSB1
bmxpa2VseSwgb25seSBiYWNrcG9ydGluZyBvZiBwYXRjaGVzIGJlY2F1c2UgZXZlcnl0aGlu
ZyBlbHNlIGlzIHRvbyByaXNreQ0KLSBTTEVTIDE1OiBldmVyeXRoaW5nIGJlc2lkZXMgMTUu
MCBoYXMgbGlic2Vwb2wgPjIuNyBhbmQgYWxzbyB1bmxpa2VseSB0aGF0IHdlIGJ1bXAgdGhl
IGxpYnNlcG9sIHZlcnNpb24gaW4gMTUNCg0KPiBUaGUgZ3JlYXRlciByaXNrIGlzIGlmIHlv
dSBoYXZlIGFueSBsaW5nZXJpbmcgYmluYXJ5IG1vZHVsZXMgY29tcGlsZWQNCj4gd2l0aCB2
ZXJzaW9ucyA8IDE4IGluaGVyaXRlZCBhY3Jvc3MgbXVsdGlwbGUgdXBncmFkZXMgKGUuZy4g
UkhFTC03IHRvDQo+IFJIRUwtOCksIHRoZW4gdGhvc2UgbW9kdWxlcyB3aWxsIGJyZWFrIGFu
ZCBwcm9iYWJseSBpbiBhIG5vdC12ZXJ5LW5pY2UNCj4gd2F5IChsaWJzZXBvbCBzdWRkZW5s
eSB3b24ndCBiZSBhYmxlIHRvIHBhcnNlIHRoZW0gYW5kIHRoZXJlZm9yZSBhbnkNCj4gc2Vt
b2R1bGUvc2VtYW5hZ2Ugb3BlcmF0aW9ucyB3aWxsIGZhaWwgYW5kIHlvdSBtaWdodCBoYXZl
IHRvIGRlbGV0ZQ0KPiB0aGVtIG1hbnVhbGx5IGZyb20gdGhlIHBvbGljeSBtb2R1bGUgc3Rv
cmUpLg0KDQpXZSBkaWQgbm90IHN1cHBvcnQgdGhlIHBvbGljeSB0aGF0IGxvbmcsIHNvIEkg
dGhpbmsgaXQgc2hvdWxkIGJlIG9rYXk6DQpTTEVTOg0KLSAxMiAtPiAxNSBubyBwb2xpY3kg
dXBkYXRlIHdpbGwgaGFwcGVuIGJlY2F1c2UgaW4gU0xFUyAxNSB0aGVyZSBpcyBubyBkaXN0
cm8gcG9saWN5IHNoaXBwZWQgb3Igc3VwcG9ydGVkDQotIGV2ZXJ5dGhpbmcgZWxzZSBoYXMg
bGlic2Vwb2wgPjIuNw0KSXQgbWlnaHQgYmUgdGhhdCAxIHBlcnNvbiBkcmFncyB0aGVpciBT
TEUxMiBwb2xpY3kgdG8gMTYsIGJ1dCBJIHRoaW5rIHRoYXQgaXMgbm90IGEgc3VwcG9ydGVk
IHVzZSBjYXNlDQoNClNMRSBNaWNybzoNCi0gc3RhcnRlZCB3aXRoIGxpYnNlcG9sID49My4x
LCBzbyBzaG91bGQgYmUgZmluZQ0KDQpCdXQgZ2VuZXJhbGx5IG91ciBidWlsdCBkaXN0cm8g
cG9saWNpZXMgYXJlIHVubGlrZWx5IHRvIGJlIGluaGVyaXRlZCBiZXR3ZWVuIHZlcnNpb25z
IGZyb20gU0xFID49MTYgKyBTTEUgTWljcm8gPj02IG9uLCBvbiB1cGdyYWRlIGl0IHdpbGwg
YmUgbWlncmF0ZWQgdG8gdGhlIG9uZSB0aGF0IGlzIGJ1aWx0IGZvciB0aGUgdXBncmFkZSB0
YXJnZXQNCg0KPiANCj4gSSdtIGZpbmUgd2l0aCBkZWZlcnJpbmcgdGhpcyBjaGFuZ2UgdG8g
YSBmdXR1cmUgbGlic2Vwb2wgcmVsZWFzZSBhZnRlcg0KPiAzLjEyIChlLmcuIDMuMTMgb3Ig
bGF0ZXIpIGlmIHRoYXQgd291bGQgYmUgc2FmZXIgZm9yIHRoZSBkaXN0cm9zLg0KDQpJIGRv
bid0IHRoaW5rIGl0IGlzIG5lY2Vzc2FyeSB0byBkZWxheSBmcm9tIG91ciBzaWRlLCB0aGFu
a3MgZm9yIHRoZSBub3RpZmljYXRpb24uDQoNCkxldCBtZSBrbm93IGluIGNhc2UgSSBhbSBt
aXN1bmRlcnN0YW5kaW5nIHNvbWV0aGluZywgdGhhbmtzIQ0KDQoNCg0K

--------------qnYs22NoOSPk2rIFV3xu6lwq--

--------------mPG0nWpbIFvqZuCSSeEH9pPt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmqWj2sbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCK0AQQAJCefNx6LNDf7iAxwaW/
hw76OkEx+ANsyOSaDzryyhAKhVfbbAW2jA/vv7wtO6cyoCyFBr+PdH3sojIwuLOs
pcfM63BmOQvpLn47CifLZGPxzAi1QSoVW7QfHYE4pSqOTobaJLLq65/IoWdOBZTx
qyah32EHNT/ZQPjgpaiURzUcU+HH0YoBAkE9AYJ0rA0JNPUZ3yYj95oioqZBjxK9
jj+MrSG7SK0mrEuMEplcLn34wu8ZhZi/yE1+aqpTvACZrFSnQ5ger3J457CNMQFl
GKV+P8BakGUYPNVP/K11L4rj2E0sM4UrOXLgbw5tM/SIJjbv7SkLn7LuWqdC/hqs
cGvCGhILNAI+GCHEuZZbvN13NYHyiESyWvZ3CnDO/j0Wvf60GewS1EwnoCCrvNtq
2sm3wAu4LE8I7kFH/FbAxMI7ctpIFKyZEW5wPphtGFMc1EIa5G+oyV7lf1K3wnAI
b0OswFnrvFqIOuhettSNicXJfqghsd1e/77l38KlPky+Lb6BO1zsaiOIqQq9buYy
Csxmo3EFLcxaYbZ5ksToEzEoyDYvhlBe1gZdCrnhcpqYXQU5PKmVmjiL0QWEdifg
pvtEjFfhn0OzLxUV9Yqa5DEB5rrDug3c1+w2JGGarj4aXMWFV2k4EmWMRqCZQAcS
7EgApyxCtiESwjuYUBj0Rh+V
=FCI6
-----END PGP SIGNATURE-----

--------------mPG0nWpbIFvqZuCSSeEH9pPt--
