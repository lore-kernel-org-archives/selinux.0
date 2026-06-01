Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4EB37DE97
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323760; cv=none; b=oEXW6NLt/Z5vNj6X61fVbbHygznmPtXene/9zkKIYPMHEtfTSs6MrD7PCPuct5kAlpriWr6dQLP8cthGT7tME5NHlvlGFcmCGnUxvQtCBKGdEKKz72bdPZLxhNw5hPpaP0eE6q/IPx38W9NCLxKay0MdD+kaY4ctV3LRSeAodKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323760; c=relaxed/simple;
	bh=eFEBXBjxY/tKsGZFgMv/iMwItfDL7EqyyjMZCYGdZNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyHWSK9NXyGVK8z21MsHHMDbRJ2la04eMZ25+HVss6PZ2pWyAmskac7wE0pr23mfJCvKJKwrLtutyIqf6ibJvWTs11UzVlSo8DKXSEbYcmjmOULv2RbThY/iX83sWh1wVIRU2ytkj3O6qqrcKl6lTXP/l3NJoZGvHK8Hv8YlGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rkt7Ifn1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yyQCIrkp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rkt7Ifn1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yyQCIrkp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rkt7Ifn1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yyQCIrkp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rkt7Ifn1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yyQCIrkp"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CBC96787F;
	Mon,  1 Jun 2026 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eFEBXBjxY/tKsGZFgMv/iMwItfDL7EqyyjMZCYGdZNI=;
	b=rkt7Ifn1zL6Fl10DLyqUMAwBIVw2jQwjPPbetH2mWLO0ktbzgrY6N/gY0o9vi0WsyGq4G1
	p/+11mH4af4NKFIH/eo6Y53LDdY3GNNmlrf1PD3WnUzOOTbZCq1WZy/COt7IHAvMMrLrUv
	NpLkg+efv0KtGfdbwOBomwL2xwWG0AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eFEBXBjxY/tKsGZFgMv/iMwItfDL7EqyyjMZCYGdZNI=;
	b=yyQCIrkpD31LdtIYII/MNaEwesm8cNyyNFb8dPr0Gq6+JTWjt/JImjloHne7bLUgaiISyR
	Kzr3mEMAbqrIqYDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eFEBXBjxY/tKsGZFgMv/iMwItfDL7EqyyjMZCYGdZNI=;
	b=rkt7Ifn1zL6Fl10DLyqUMAwBIVw2jQwjPPbetH2mWLO0ktbzgrY6N/gY0o9vi0WsyGq4G1
	p/+11mH4af4NKFIH/eo6Y53LDdY3GNNmlrf1PD3WnUzOOTbZCq1WZy/COt7IHAvMMrLrUv
	NpLkg+efv0KtGfdbwOBomwL2xwWG0AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eFEBXBjxY/tKsGZFgMv/iMwItfDL7EqyyjMZCYGdZNI=;
	b=yyQCIrkpD31LdtIYII/MNaEwesm8cNyyNFb8dPr0Gq6+JTWjt/JImjloHne7bLUgaiISyR
	Kzr3mEMAbqrIqYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA9A2779A7;
	Mon,  1 Jun 2026 14:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oq3FKKyVHWpdegAAD6G6ig
	(envelope-from <cahu@suse.de>); Mon, 01 Jun 2026 14:22:36 +0000
Message-ID: <c15f5407-f129-4e92-88d5-8dd9ef4bde3d@suse.de>
Date: Mon, 1 Jun 2026 16:22:34 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libsemanage: Require LIBSO before SWIGSO and
 SWIGRUBYSO (bsc#1266385)
To: selinux@vger.kernel.org
Cc: selinux@suse.de, fvogt@suse.de, lautrbach@redhat.com
References: <20260529143424.180246-2-cahu@suse.de>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <20260529143424.180246-2-cahu@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zIvCuk8TpjtDNdYse2Il0XJ5"
X-Spam-Flag: NO
X-Spam-Score: -5.29
X-Spamd-Result: default: False [-5.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-0.99)[-0.992];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_BASE64_TEXT(0.10)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,13_semanage.so:url,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zIvCuk8TpjtDNdYse2Il0XJ5
Content-Type: multipart/mixed; boundary="------------J3pL60qVhbWpMHwq5AWvt0dP";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: selinux@suse.de, fvogt@suse.de, lautrbach@redhat.com
Message-ID: <c15f5407-f129-4e92-88d5-8dd9ef4bde3d@suse.de>
Subject: Re: [PATCH v2] libsemanage: Require LIBSO before SWIGSO and
 SWIGRUBYSO (bsc#1266385)
References: <20260529143424.180246-2-cahu@suse.de>
In-Reply-To: <20260529143424.180246-2-cahu@suse.de>

--------------J3pL60qVhbWpMHwq5AWvt0dP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGxlYXNlIGlnbm9yZSB2MSBhbmQgdjIsIGxpa2VseSB3b24ndCB3b3JrIHdpdGggRElTQUJM
RV9TSEFSRUQ9eS4NCg0KSSBzZW50IGEgdjMsIHNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5j
ZQ0KDQpPbiA1LzI5LzI2IDQ6MzMgUE0sIENhdGh5IEh1IHdyb3RlOg0KPiBXZSBlbmNvdW50
ZXJlZCByYWNlIGNvbmRpdGlvbnMgd2hlcmUgdGhlIGJ1aWx0IG9yZGVyIHdhczoNCj4gMS4g
bGlic2VtYW5hZ2UuYQ0KPiAyLiBweXRob24tMy4xM19zZW1hbmFnZS5zbw0KPiAzLiBsaWJz
ZW1hbmFnZS5zby4qDQo+IA0KPiBUaGF0IGhhcHBlbmVkIHdoZW4gbWFrZSB3YXMgY2FsbGVk
IHdpdGggYC1qMmAuDQo+IA0KPiBJbiB0aGlzIGNhc2UsIHB5dGhvbi0zLjEzX3NlbWFuYWdl
LnNvIHRyaWVzIHRvIHVzZSBsaWJzZW1hbmFnZS5hIGFuZA0KPiAtIG9uIHMzOTB4OiBzdWNj
ZWVkcyBhbmQgYnVpbGRzIGFuIGluY29ycmVjdCBweXRob24tMy4xM19zZW1hbmFnZS5zbw0K
PiAgICAodGhhdCBvbmUgd2FzIGZvdW5kIGR1cmluZyBwcm9kdWN0IHRlc3RpbmcpDQo+IC0g
b24geDg2OiBmYWlscyAobWFudWFsbHkgcmVwcm9kdWNlZCwgbmV2ZXIgZW5jb3VudGVyZWQg
SVJMKQ0KPiAgICBSZXByb2R1Y2VyOg0KPiAgICBgYGANCj4gICAgY2Qgc2VsaW51eC9saWJz
ZW1hbmFnZS9zcmMNCj4gICAgbWFrZSBjbGVhbg0KPiAgICBtYWtlIHB5d3JhcA0KPiAgICBm
aW5kIC4gLXdob2xlbmFtZSAiKmxpYnNlbWFuYWdlLnNvKiIgLWRlbGV0ZQ0KPiAgICBmaW5k
IC4gLXdob2xlbmFtZSAiKnB5dGhvbiouc28iIC1kZWxldGUNCj4gICAgbWFrZSBweXRob24t
My4xM19zZW1hbmFnZS5zbw0KPiAgICAtPiBmYWlscw0KPiAgICBgYGANCj4gDQo+IFRoZXJl
Zm9yIGhhcmQtcmVxdWlyZSBMSUJTTyB0byBiZSBwcmVzZW50IGJlZm9yZSBTV0lHU08gYW5k
DQo+IHByb2JhYmx5IGFsc28gU1dJR1JVQllTTy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENh
dGh5IEh1IDxjYWh1QHN1c2UuZGU+DQo+IC0tLQ0KPiAgIGxpYnNlbWFuYWdlL3NyYy9NYWtl
ZmlsZSB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGlic2VtYW5hZ2Uvc3JjL01ha2Vm
aWxlIGIvbGlic2VtYW5hZ2Uvc3JjL01ha2VmaWxlDQo+IGluZGV4IGY4NzBkYzY4Li43ODJl
NDA0NSAxMDA2NDQNCj4gLS0tIGEvbGlic2VtYW5hZ2Uvc3JjL01ha2VmaWxlDQo+ICsrKyBi
L2xpYnNlbWFuYWdlL3NyYy9NYWtlZmlsZQ0KPiBAQCAtODIsMTAgKzgyLDEwIEBAICQoU1dJ
R0xPQkopOiAkKFNXSUdDT1VUKQ0KPiAgICQoU1dJR1JVQllMT0JKKTogJChTV0lHUlVCWUNP
VVQpDQo+ICAgCSQoQ0MpICQoQ1BQRkxBR1MpICQoQ0ZMQUdTKSAkKFNXSUdfQ0ZMQUdTKSAk
KFJVQllJTkMpIC1mUElDIC1EU0hBUkVEIC1jIC1vICRAICQ8DQo+ICAgDQo+IC0kKFNXSUdT
Tyk6ICQoU1dJR0xPQkopDQo+ICskKFNXSUdTTyk6ICQoU1dJR0xPQkopICQoTElCU08pDQo+
ICAgCSQoQ0MpICQoQ1BQRkxBR1MpICQoQ0ZMQUdTKSAkKExERkxBR1MpIC1MLiAtZlBJQyAt
c2hhcmVkIC1vICRAICQ8IC1sc2VtYW5hZ2UgJChQWUxJQlMpDQo+ICAgDQo+IC0kKFNXSUdS
VUJZU08pOiAkKFNXSUdSVUJZTE9CSikNCj4gKyQoU1dJR1JVQllTTyk6ICQoU1dJR1JVQllM
T0JKKSAkKExJQlNPKQ0KPiAgIAkkKENDKSAkKENQUEZMQUdTKSAkKENGTEFHUykgJChMREZM
QUdTKSAtTC4gLWZQSUMgLXNoYXJlZCAtbyAkQCAkXiAtbHNlbWFuYWdlICQoUlVCWUxJQlMp
DQo+ICAgDQo+ICAgJChMSUJBKTogJChPQkpTKQ0KDQo=

--------------J3pL60qVhbWpMHwq5AWvt0dP--

--------------zIvCuk8TpjtDNdYse2Il0XJ5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmodlaobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCKLBsP/1tUmeFJV7BJ04l1qLGp
1XxM9Ad/7RblbXQITcG124B3mDnPeerYSX9Ao/Y88qav9X+y3+s9EvePs1L7G4Dm
cEBMaXt7k5/QyPoaL58/xizJzR325LqsnlrGh6SmIy3lKz0nOnAB3vbfN09qXNGt
MarpeffyU83dg61t8KXqmXqn87Ayh+jVszDCbA49U2NRUV7ZdXhnsRHpQ7ym3eDP
7RfgPy7AmAocBknEfbeg1EgRaPnI7AKHA+tmylzhrrAGFaLgPUTAE+K6ybd3xhJu
AOemPpNXkvJ5AZ0lMFxv258uApEwFPBmTcLlbL5TaDQvOAVS/iChY16hUIc3PfcW
5r8gXEH56l9cds1GDsg/ElD17xZYc54CYwpGZK6zqDCFhBx+Vbq12+qkemfeW4n+
nyrAhdCtgSxHxXYWQQI2uXIqX1xZ1K9CxTx3MKF6yBohTivIIhiwkoaQACtHfJyM
7GcwJEdJfCYzo1MvpiznZHJ2SCtO4XtZ+BjkuuAbmPYzJFbf42X1fjfELLVVapVo
cDwuwHM4H+fZpuxl+JpcyUuomU8v5Lo2JdHtxr9z2WHRL5rJkC1bA8F5neyX6FAc
GxVFUlbVthQhGIzrgpNAdFogguys6t04qdTKpvefyCsMnzLJF0nxNZhLi6r+fLVY
Uu5391ZkmPdZNYFx3E9uaoPD
=SKaU
-----END PGP SIGNATURE-----

--------------zIvCuk8TpjtDNdYse2Il0XJ5--
