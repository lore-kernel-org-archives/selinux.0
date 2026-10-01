Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0352CCF0
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868847; cv=none; b=mntdzv1DFddssjNdgVe4rLzMlXXdjrjRe0dSpHaZHz7bGDK1pDhAqhhXmc+p1SAdU6oTuxnCom8ee3JX7+KJaTWWJxok/MTmhGeoXOHk2Fk1OBOj7Lq5vvmis2rzWAfasNR8/4PaVKaAA2dia/d1ZFk58X/AcwTzp5gB6q9O4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868847; c=relaxed/simple;
	bh=bJt5zX1zg9Am4KWVn6hv2GG71bK+oWpYfU7kcjfAiK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ4tOlbw8Hg7yGWlCq7JaPu0H5fMSwITGe9BO+gl6B4zTANjnYOa/ygojW1+B+WT/aybAyUJYJMYUZJLiEB4hhg86M3F7SQb0VsdkQluNVZUZuZoPCcsR875GAIZFiPKkATneSTBnxmPHK3X8s5TD5mOxQkDwV1zNF2I0PvkRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=obJV/qAP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bMD1WhrZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tPS1tkdp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ify/CeHW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="obJV/qAP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bMD1WhrZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tPS1tkdp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ify/CeHW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D89472129F;
	Thu,  1 Oct 2026 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790868839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bJt5zX1zg9Am4KWVn6hv2GG71bK+oWpYfU7kcjfAiK0=;
	b=obJV/qAPBO99q1lFXW4xULzaPAXCwZjjl2MkRsNFVajkyQ/fAlxeSU/MTAQOdy1SQQ4Bjo
	duSwdcEwK1V83A8GDNuAoMoY2PbjYwvHci4WvMfIvb0Gua1luER9RT/OSBUXUXaYYQJUoQ
	d9FxB3roArxTfEEwLeBAHrB7NS/wyos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790868839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bJt5zX1zg9Am4KWVn6hv2GG71bK+oWpYfU7kcjfAiK0=;
	b=bMD1WhrZ4WTyr3ObORsopr2xvh7Ult8rEDKqHFcKur7O0kOgkm/6ue5xa3VM1iIuUVyUHJ
	H6UKjEg2bwR57ZDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tPS1tkdp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Ify/CeHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790868834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bJt5zX1zg9Am4KWVn6hv2GG71bK+oWpYfU7kcjfAiK0=;
	b=tPS1tkdpdT8T0cb6bMGBohhs3LQkMOSfUIYkdjWcFFCOOptOARldHQcv4rmHJPn2Z2KPIl
	cxH5rII71v1GAm+v8UrtQPYdxo2LGV4Q49OK7N+Jo44+JX3Ypz0MWwgw8GYIM+EBV4Mqn2
	4SH4CIYi/sfYewtmlXsJgzFij/GYt8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790868834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bJt5zX1zg9Am4KWVn6hv2GG71bK+oWpYfU7kcjfAiK0=;
	b=Ify/CeHWlxgc4oXuYsnMSST9+2kC6mu2wSeK8Aecg/zIbne1UiJgr5N8v6fOHapaTM4EKv
	X2l4pjtqTeEuMNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62C6C13B80;
	Thu,  1 Oct 2026 15:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y+5BDWJ9vmo+OQAAD6G6ig
	(envelope-from <cahu@suse.de>); Thu, 01 Oct 2026 15:33:54 +0000
Message-ID: <94b5050d-4e32-4369-8a45-c1c96df74d86@suse.de>
Date: Thu, 1 Oct 2026 17:33:52 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Petr Lautrbach <plautrba@redhat.com>,
 Jason Zaman <jason@perfinion.com>, Russell Coker <russell@coker.com.au>,
 Johannes Segitz <jsegitz@suse.de>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?=
 <tweek@google.com>
References: <20260930111444.192037-2-lautrbach@redhat.com>
 <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
 <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0vlf7hB57Zyb00hsscdI807o"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D89472129F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	HAS_ATTACHMENT(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[libselinux.so:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0vlf7hB57Zyb00hsscdI807o
Content-Type: multipart/mixed; boundary="------------4WKz2o3tFsDf4D1HjMkm8P6d";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Petr Lautrbach <plautrba@redhat.com>,
 Jason Zaman <jason@perfinion.com>, Russell Coker <russell@coker.com.au>,
 Johannes Segitz <jsegitz@suse.de>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?=
 <tweek@google.com>
Message-ID: <94b5050d-4e32-4369-8a45-c1c96df74d86@suse.de>
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
References: <20260930111444.192037-2-lautrbach@redhat.com>
 <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
 <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>

--------------4WKz2o3tFsDf4D1HjMkm8P6d
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS8zMC8yNiA1OjU0IFBNLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6DQo+IE9uIFdlZCwg
U2VwIDMwLCAyMDI2IGF0IDk6NDTigK9BTSBTdGVwaGVuIFNtYWxsZXkNCj4gPHN0ZXBoZW4u
c21hbGxleS53b3JrQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gV2VkLCBTZXAgMzAs
IDIwMjYgYXQgNzoxOOKAr0FNIFBldHIgTGF1dHJiYWNoIDxsYXV0cmJhY2hAcmVkaGF0LmNv
bT4gd3JvdGU6DQo+Pj4NCj4+PiBGcm9tOiBQZXRyIExhdXRyYmFjaCA8cGxhdXRyYmFAcmVk
aGF0LmNvbT4NCj4+Pg0KPj4+IFNIQS0xIGlzIGNvbnNpZGVyZWQgb2Jzb2xldGUgc28gbW92
ZSB0byBTSEEtMjU2IGFzIHRoZSBkZWZhdWx0IGRpZ2VzdCBhbGdvcml0aG0uDQo+Pj4NCj4+
PiBJbXBvcnQgdGhlIHB1YmxpYy1kb21haW4gU0hBLTI1NiBpbXBsZW1lbnRhdGlvbiBmcm9t
IFdqQ3J5cHRMaWIgYW5kIHVzZSBpdCBmb3INCj4+PiBsYWJlbCBkaWdlc3QgaGFuZGxpbmcu
DQo+Pj4NCj4+PiBUaGUgb3JpZ2luYWwgc291cmNlIG9mIHNoYTI1Ni5jIGlzDQo+Pj4gaHR0
cHM6Ly9naXRodWIuY29tL1dhdGVySnVpY2UvV2pDcnlwdExpYi9yZWxlYXNlcy90YWcvVmVy
c2lvbl8zLjAuMA0KPj4+DQo+Pj4gSWdub3JlIHNoYTI1Ni57YyxofSBpbiBtYWtlLWZvcm1h
dCBhbmQgY2hlY2stZm9ybWF0IHRhcmdldHMgaW4gb3JkZXIgdG8gYWRvcHQNCj4+PiBwb3Nz
aWJsZSBmdXR1cmUgY2hhbmdlcyBpbiBXYXRlckp1aWNlL1dqQ3J5cHRMaWIgc2ltcGxlci4N
Cj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBldHIgTGF1dHJiYWNoIDxsYXV0cmJhY2hAcmVk
aGF0LmNvbT4NCj4+PiAtLS0NCj4+DQo+PiBBIGZldyBjb21tZW50cyBiZWxvdyByZWdhcmRp
bmcgY29tcGF0aWJpbGl0eSAvIHZlcnNpb25pbmcgYW5kIGNvZGUNCj4+IGZvcm1hdHRpbmcg
aW5jb25zaXN0ZW5jeSwgYnV0IG90aGVyd2lzZQ0KPj4gQWNrZWQtYnk6IFN0ZXBoZW4gU21h
bGxleSA8c3RlcGhlbi5zbWFsbGV5LndvcmtAZ21haWwuY29tPg0KPj4NCj4+IDEuIHNlbGFi
ZWxfaGFzaF9hbGxfcGFydGlhbF9tYXRjaGVzKCkgb3V0cHV0IHNpemUgZ3Jvd3MgZnJvbSAy
MCB0byAzMg0KPj4gYnl0ZXMuIHNlbGFiZWxfaGFzaF9hbGxfcGFydGlhbF9tYXRjaGVzKCkg
aXMgYSBwdWJsaWMgZXhwb3J0ZWQgc3ltYm9sDQo+PiAobGlic2VsaW51eC5tYXAsIExJQlNF
TElOVVhfMi45KSB3aG9zZSBwcm90b3R5cGUgaXMgdWludDhfdCAqZGlnZXN0DQo+PiB3aXRo
IG5vIGxlbmd0aCBwYXJhbWV0ZXIgYW5kIG5vIG1hbiBwYWdlLiBBbnkgZXh0ZXJuYWwgY2Fs
bGVyIHNpemVkDQo+PiBmb3IgdGhlIG9sZCBTSEEtMSBvdXRwdXQgZ2V0cyBhIDEyLWJ5dGUg
T09CIHdyaXRlIGZyb20NCj4+IGhhc2hfYWxsX3BhcnRpYWxfbWF0Y2hlcygpLiBUaGlzIGlu
dGVyZmFjZS9mdW5jdGlvbmFsaXR5IHdhcyBiYXNlZCBvbg0KPj4gQW5kcm9pZC1zcGVjaWZp
YyBmdW5jdGlvbmFsaXR5IGFuZCBJIGRvbid0IHNlZSBhbnkgZGlzdHJvIHVzZXJzLCBzbw0K
Pj4gdGhpcyBpcyBwcm9iYWJseSBmaW5lIHRvIGJyZWFrLCBidXQgaXQgc2hvdWxkIGJlIGEg
c3RhdGVkIGRlY2lzaW9uIGFuZA0KPj4gY2FsbGVkIG91dCBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UgYW5kIHRoZSAzLjEyIHJlbGVhc2Ugbm90ZXMuIEkgd2lsbA0KPj4gZGVmZXIgdG8gdGhl
IGRpc3Ryb3Mgb24gd2hldGhlciBpdCByZXF1aXJlcyBhIGxpYnNlbGludXguc28gdmVyc2lv
bg0KPj4gYnVtcDsgSSBhbSBmaW5lIGVpdGhlciB3YXkuDQo+IA0KPiBBY3R1YWxseSwgaWYg
c29tZW9uZSBjYXJlcywgd2UgY291bGQganVzdCB1c2Ugc3ltYm9sIHZlcnNpb25pbmcgZm9y
DQo+IHRoaXMgYW5kIGZhbGxiYWNrIG9uIHRoZSBvbGQgc3ltYm9sIHRvIG9ubHkgd3JpdGUg
dGhlIGZpcnN0IDIwLWJ5dGVzDQo+IG9mIHRoZSBTSEEyNTYgaGFzaCB0byB0aGUgb3V0cHV0
IGJ1ZmZlciB0byBhdm9pZCBhIGNvbXBhdGliaWxpdHkNCj4gYnJlYWsuIFRoYXQgc2FpZCwg
dGhlIG9ubHkgdXNlciBvZiB0aGlzIGZ1bmN0aW9uIHRoYXQgSSBzZWUgaXMgaW4NCj4gQW5k
cm9pZCdzIGxpYnNlbGludXggYW5kIHRoYXQgd291bGRuJ3QgYmUgaGVscGVkIGJ5IHRoYXQu
DQo+DQoNCkp1c3QgbXkgMiBjZW50cywgSSBncmVwcGVkIHRocm91Z2ggYWxsIG9wZW5zdXNl
L3N1c2UgdW5wYWNrZWQgc291cmNlcyBhbmQgZGlkIG5vdCBmaW5kDQphbnl0aGluZyB0aGF0
IHVzZXMgdGhpcyByZWFsbHkgYmVzaWRlcyB0aGUgc2VsaW51eCB0b29sY2hhaW4uDQpTbyBv
biBvdXIgZW5kIEkgdGhpbmsgZWl0aGVyIHdheSBpcyBmaW5lLCBhIG5ldyB2ZXJzaW9uZWQg
c3ltYm9sIGlzIGEgZ29vZCBpZGVhLCBidXQgYWxzbyBqdXN0IGJyZWFraW5nIGNvbXBhdCBz
aG91bGQgbm90IGJlIGEgcHJvYmxlbS4NCkkgdGhpbmsgaXQgaXMgdW5saWtlbHkgdGhhdCBh
IGV4aXN0aW5nIHRoaXJkIHBhcnR5IHVzZXMgdGhpcyBhdG0gb24gb3VyIGVuZCwgYnV0IEkg
Z3Vlc3Mgd2UgaGF2ZSBpdCBlYXN5IGhlcmUuDQpJIGRvbid0IHRoaW5rIGEgbmV3IGxpYnNl
bGludXguc28gdmVyc2lvbiBpcyBuZWVkZWQNCg==

--------------4WKz2o3tFsDf4D1HjMkm8P6d--

--------------0vlf7hB57Zyb00hsscdI807o
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmq+fWAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCKPh4QAMbR2psPtn/U8jzHnmrd
U+GpyN8yZStEbTZ9Kd02B55Z43/eM0h4bfogVZV0PR/xPcRNjpzERzTL21CCvpYf
LoaPsoTA88l0pauiYF37M8b0on7uMexl+JkbohYP5mHqjq0/62vy4490xn43o1tn
O4q/yGPdlbf2q+Msc0dxWibiuoJ+vvCiGjvs6Rrm/cARQBei18Lt24FLysVquh0F
VGfsdILNW9gI+xDg2dqqQOUywy8uaVohA7nbQIDz3ZscA1rgqZNVgVEqevCJWGMm
RwZL8glD2xZnTfO/oSkFkbd9NwfqFG5caNyWOdh1tanQPWGD/sEEKzM79UM4wNV2
nEd0WEM/LfLEhBaCb6Ej1pig3gNi134QsTVPMdld7XJfoQNsp9klPnb2aAKcXgO5
cU8ud/spHbmaCD5lBER/EvxmR5ClJb94obHg40gby6ZOUtm7rnX70wfW8xdS9ErS
ZWj1xi14eq+y4RKnKBIrWAtrlsxZxSRgiw32VIteGE+E1amO7vjGDV4G4RHlTV58
10ezlwpCfqeDMc2XUD1NIWpykha9Nr7rsEKHORMPAXszY3ArBQoC+qqI2Sau45Nh
EEgpCJNgxFOI1pmHkdZskXp9XExXtvo/0tregDl4hvvXmOH6xv2ADyzQ4MsPmcLm
IygXxqdCt5gucOEA5EJ/Pi6K
=QuAa
-----END PGP SIGNATURE-----

--------------0vlf7hB57Zyb00hsscdI807o--
