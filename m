Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCE415F1A
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715653; cv=none; b=EftZ+ksWzsHPnKbmv/zkNuAPVFxPllTQdQExTN8cSHJH+Kwovgz7ym7GmQZ3iivcOS+tDQIPi+XuE5mt/LgV5D64WKOizs6e8Xd+17N+MG8lF36xNuEySthKpBOI45B4x2KrxdkePHO//43oTvNpNJmUP5Mf3mgh8chjANt+Ch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715653; c=relaxed/simple;
	bh=aFQD4zBNIwuj/435cn+6hAS+TJ/fJZIEk1iHCjL/ZJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flCOpiHGIecd8Qq6z6SltOqvniH4qLBY1LQdyriTtYV4gymTfquP8arK1GgvcATPx6dTCE75E7Y9//ypxgAZDiRw49R0YLyNQYBpM32bxXxyKgVYrzAaBBBABYQXalwmj0ge+7M3BhJ+W0piaF37FiVictFhhxu1MkD/KepRfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ogoSt0GE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BeJkeVX5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ogoSt0GE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BeJkeVX5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ogoSt0GE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BeJkeVX5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ogoSt0GE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BeJkeVX5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5955A3E2E;
	Wed, 22 Jul 2026 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784715649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFQD4zBNIwuj/435cn+6hAS+TJ/fJZIEk1iHCjL/ZJc=;
	b=ogoSt0GED+CzvVv8HnFjCMvp+MZoC5Ijss0PQ35cvM+v40AhZvIf2ENKjbZMJmVEmPF8ld
	k235JsQiS9AZjs9384Tj/1fczU6eyiPMLPAlTY6PbT61Qifunpx5xKviqYIqvpmSgfbozN
	s+GwocvyqP97cBCtSMwuheFlqvrlcgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784715649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFQD4zBNIwuj/435cn+6hAS+TJ/fJZIEk1iHCjL/ZJc=;
	b=BeJkeVX5Sx2uMwY+9RVEWxt+XQcPBeTQk5hSWmJsRgOLjbXgMu+L4P4brzDxZAu7g3zk+E
	WqLrttqXFNg+7OAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ogoSt0GE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BeJkeVX5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784715649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFQD4zBNIwuj/435cn+6hAS+TJ/fJZIEk1iHCjL/ZJc=;
	b=ogoSt0GED+CzvVv8HnFjCMvp+MZoC5Ijss0PQ35cvM+v40AhZvIf2ENKjbZMJmVEmPF8ld
	k235JsQiS9AZjs9384Tj/1fczU6eyiPMLPAlTY6PbT61Qifunpx5xKviqYIqvpmSgfbozN
	s+GwocvyqP97cBCtSMwuheFlqvrlcgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784715649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFQD4zBNIwuj/435cn+6hAS+TJ/fJZIEk1iHCjL/ZJc=;
	b=BeJkeVX5Sx2uMwY+9RVEWxt+XQcPBeTQk5hSWmJsRgOLjbXgMu+L4P4brzDxZAu7g3zk+E
	WqLrttqXFNg+7OAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 333D8779B0;
	Wed, 22 Jul 2026 10:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ZQVC4GZYGplcQAAD6G6ig
	(envelope-from <cahu@suse.de>); Wed, 22 Jul 2026 10:20:49 +0000
Message-ID: <104ecf4e-7dc5-4bab-8f3b-b73f0aca5d41@suse.de>
Date: Wed, 22 Jul 2026 12:20:47 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] python/sepolicy: add a pyproject.toml file
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
References: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
 <20260721185357.64896-4-stephen.smalley.work@gmail.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <20260721185357.64896-4-stephen.smalley.work@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jfDf3gduT9cjW4inBqrigXCz"
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5955A3E2E
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	HAS_ATTACHMENT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jfDf3gduT9cjW4inBqrigXCz
Content-Type: multipart/mixed; boundary="------------ymXK9VhfswYuXTBrT0cnjk20";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Message-ID: <104ecf4e-7dc5-4bab-8f3b-b73f0aca5d41@suse.de>
Subject: Re: [PATCH 2/2] python/sepolicy: add a pyproject.toml file
References: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
 <20260721185357.64896-4-stephen.smalley.work@gmail.com>
In-Reply-To: <20260721185357.64896-4-stephen.smalley.work@gmail.com>

--------------ymXK9VhfswYuXTBrT0cnjk20
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNy8yMS8yNiA4OjUzIFBNLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6DQo+IEFkZCBhIHB5
cHJvamVjdC50b21sIGZpbGUgZm9yIHRoZSBzZXBvbGljeSBweXRob24gbW9kdWxlLiAgVGhp
cw0KPiByZXF1aXJlZCBhbHNvIHVwZGF0aW5nIHNldHVwLnB5IHRvIGF2b2lkIGRlZmluaW5n
IGF1dGhvciBvdXRzaWRlIG9mDQo+IHB5cHJvamVjdC50b21sLCBhbmQgSSBmdXJ0aGVyIHVw
ZGF0ZWQgdGhlIGF1dGhvcnMgdG8gcmVmZXIgdG8gdGhlIGxpc3QNCj4gbGlrZSBsaWJzZWxp
bnV4IHNpbmNlIERhbiBpcyBlbmpveWluZyByZXRpcmVtZW50Lg0KPiANCj4gRml4ZXM6IGh0
dHBzOi8vZ2l0aHViLmNvbS9TRUxpbnV4UHJvamVjdC9zZWxpbnV4L2lzc3Vlcy81MDUNCj4g
U2lnbmVkLW9mZi1ieTogU3RlcGhlbiBTbWFsbGV5IDxzdGVwaGVuLnNtYWxsZXkud29ya0Bn
bWFpbC5jb20+DQo+IC0tLQ0KPiAgIHB5dGhvbi9zZXBvbGljeS9weXByb2plY3QudG9tbCB8
IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gICBweXRob24vc2Vwb2xpY3kvc2V0dXAucHkg
ICAgICAgfCAgMiAtLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgcHl0aG9uL3NlcG9saWN5
L3B5cHJvamVjdC50b21sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcHl0aG9uL3NlcG9saWN5L3B5
cHJvamVjdC50b21sIGIvcHl0aG9uL3NlcG9saWN5L3B5cHJvamVjdC50b21sDQo+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwLi40NzJmYWY3YQ0KPiAtLS0gL2Rl
di9udWxsDQo+ICsrKyBiL3B5dGhvbi9zZXBvbGljeS9weXByb2plY3QudG9tbA0KPiBAQCAt
MCwwICsxLDE5IEBADQo+ICtbYnVpbGQtc3lzdGVtXQ0KPiArcmVxdWlyZXMgPSBbInNldHVw
dG9vbHMiLCAid2hlZWwiXQ0KPiArYnVpbGQtYmFja2VuZCA9ICJzZXR1cHRvb2xzLmJ1aWxk
X21ldGEiDQo+ICsNCj4gK1twcm9qZWN0XQ0KPiArbmFtZSA9ICJzZXBvbGljeSINCj4gK3Zl
cnNpb24gPSAiMy4xMSINCj4gK2Rlc2NyaXB0aW9uID0gIlB5dGhvbiB0b29scyBmb3IgU0VM
aW51eCBwb2xpY3kgYW5hbHlzaXMgKHNlcG9saWN5LCBzZXBvbGdlbikiDQo+ICtsaWNlbnNl
ID0gIkdQTC0yLjAtb3ItbGF0ZXIiDQo+ICthdXRob3JzID0gWw0KPiArICAgIHsgbmFtZSA9
ICJTRUxpbnV4IFByb2plY3QiLCBlbWFpbCA9ICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIg
fQ0KPiArXQ0KPiArZGVwZW5kZW5jaWVzID0gWw0KPiArICAgICJsaWJzZWxpbnV4LXB5dGhv
biIsDQo+ICsgICAgImxpYnNlbWFuYWdlLXB5dGhvbiIsDQo+ICtdDQo+ICsNCj4gK1twcm9q
ZWN0LnNjcmlwdHNdDQo+ICtzZXBvbGljeSA9ICJzZXBvbGljeS5fX21haW5fXzptYWluIg0K
PiBkaWZmIC0tZ2l0IGEvcHl0aG9uL3NlcG9saWN5L3NldHVwLnB5IGIvcHl0aG9uL3NlcG9s
aWN5L3NldHVwLnB5DQo+IGluZGV4IGNhMDM5NmI1Li41YzRmMmU1ZCAxMDA2NDQNCj4gLS0t
IGEvcHl0aG9uL3NlcG9saWN5L3NldHVwLnB5DQo+ICsrKyBiL3B5dGhvbi9zZXBvbGljeS9z
ZXR1cC5weQ0KPiBAQCAtOCw4ICs4LDYgQEAgc2V0dXAoDQo+ICAgICAgIG5hbWU9InNlcG9s
aWN5IiwNCj4gICAgICAgdmVyc2lvbj0iMy4xMSIsDQo+ICAgICAgIGRlc2NyaXB0aW9uPSJQ
eXRob24gU0VMaW51eCBQb2xpY3kgQW5hbHlzZXMgYmluZGluZ3MiLA0KPiAtICAgIGF1dGhv
cj0iRGFuaWVsIFdhbHNoIiwNCj4gLSAgICBhdXRob3JfZW1haWw9ImR3YWxzaEByZWRoYXQu
Y29tIiwNCj4gICAgICAgcGFja2FnZXM9Ww0KPiAgICAgICAgICAgInNlcG9saWN5IiwNCj4g
ICAgICAgICAgICJzZXBvbGljeS50ZW1wbGF0ZXMiLA0KDQpsZ3RtLCBvciBhdCBsZWFzdCBp
IGRvbid0IHNlZSB0aGUgd2FybmluZyBhbnltb3JlIGluIHRoZSBidWlsZCBzeXN0ZW0NCg==


--------------ymXK9VhfswYuXTBrT0cnjk20--

--------------jfDf3gduT9cjW4inBqrigXCz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmpgmX8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCKrZ0P/RkBtD0Oft3W/Ub1/V02
RbSrX7kowscBllBbNKxaUvM2Lih0cy/utBrfYbITVnX4FhIuU9DCXRXDc7doJ4xC
apUg/mYywZm7CPKsnAWqa3x6NeYBQ+ZNdvSk0yD+QcTT6EUULDODM0b8OJ50zOiV
1E9rXnirwinbeXtV4rWBLIZ5yQuu5rNN9kGb7hAMRvxudhCHo6sjZl+Vm5uqjfpP
Bzc/13VuY7UqIjfJVgzdDrELAbaNJ8Q/VNzfDKhAnqULUgRpet3vbvcW34ukEsyQ
kitIkGsUq5gQ9h464EV/+kt3PMlsXuxjjd1ayWUIxOj13IuPKvkRJJPCHg1Ts84N
H4NoPl5y/CFZBPFVKpA6tf0PQ05cmonpJlNTiax5xsBoHIAdedfopOuL4ZGL1o6K
3pnWqFHj0xOMb9d7DvpU1YNuljLxmECyaz0ljS/47milLoFKPoUan/ZJF0seerZa
lcDtyWOGZufjY53l2YzPDUJwS8G2zcYyqTg0VG0pMD7raK7sIUzwsYsornm9bjH2
12pi0kVf/c247/Sc/qJawa0eU24TXcwYjPCdsiuVuUID9vrkgOCiG0RPirPAXP1o
VOqJ2F5E1RtRic+R/AYGHLP9nl8nACdLQBzwXbpVdeWDankAw3RYRHc5O4g3uOXh
Im86j07QS/HcSN1RB/bW95ve
=S+NU
-----END PGP SIGNATURE-----

--------------jfDf3gduT9cjW4inBqrigXCz--
