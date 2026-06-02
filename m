Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264C30FF2A
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394507; cv=none; b=BWjogWhNJzbL1IyQbHOXEcbiPKnb2ue4qA/070O0sjOkS9ZG4I+YEs/KGFGUJXgi/3+N8t5LiVtYpOb8vl/KZNi5v/ITCDcinNzw+EsmOFCkU7wWwO7/hZ5UIBHvhdgym0hvvpZ/Fcyy7zxWTi1zXB94UnDCxY6CZ+tUd/OuwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394507; c=relaxed/simple;
	bh=X0Pi+eK2F+dfIb9RM6BdjqdI76SqH9vDLFUlc2xQ1k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPdHHqkWiOpYG7qgTX/y6OLFTs/Q0SyhrfVN4tsvu+CcLQNNm0Cp728dDtV9vjDcuao2QhRGR2sHEDXNwgu0Ra1yTuIKs8Qd/P3LBmb5qsbGYmbGr1cqfC/CIndwsL3DbotjMLS07lhf32Jddm775EucLx/VxVOGRiNYOniQOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SWeYUE6R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9fZD1HTj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QLjauzPr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9fZD1HTj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SWeYUE6R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9fZD1HTj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QLjauzPr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9fZD1HTj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F32D5673A2;
	Tue,  2 Jun 2026 10:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780394503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X0Pi+eK2F+dfIb9RM6BdjqdI76SqH9vDLFUlc2xQ1k8=;
	b=SWeYUE6R7HO3l0UaEdP7lJTPzfKXMfwtCZz2vtq+RRPOroXF025BWdtIlEn9flEPzV5N69
	hDIwFlcY4MDIujX+teo7OHmL2ISeNHP2uMTWVjAP0JKTHWkVsc1NpHVOrS5HjY3ckjjiRM
	c/XNoLauzHeimdBhXMyHw+KURhhKstw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780394503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X0Pi+eK2F+dfIb9RM6BdjqdI76SqH9vDLFUlc2xQ1k8=;
	b=9fZD1HTjlHJ8WFEdWLnojZ7d3/pcEUP73D9P6Y1N3XvoE3MM05cYNv+SS523WAqxtZuvIm
	ouLiD6nDlOlZ1gDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QLjauzPr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9fZD1HTj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780394502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X0Pi+eK2F+dfIb9RM6BdjqdI76SqH9vDLFUlc2xQ1k8=;
	b=QLjauzPrfC6ftJt9PZCZF8oAxIfNSxFRRFD6d0xoI//kvOBUgHPaI0h2Tfcwt8TB0tS6Yt
	5B/pIaqkxhUTCrRAFNv3JnbbEIw1nZu/qPBx22F+65ZSTyacdkVrVhlni4S2wbGirRbaFU
	oROK7t2vIb4iodRj6OSPsJeDyjU1jHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780394503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X0Pi+eK2F+dfIb9RM6BdjqdI76SqH9vDLFUlc2xQ1k8=;
	b=9fZD1HTjlHJ8WFEdWLnojZ7d3/pcEUP73D9P6Y1N3XvoE3MM05cYNv+SS523WAqxtZuvIm
	ouLiD6nDlOlZ1gDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0D5F779A7;
	Tue,  2 Jun 2026 10:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5lyZMQaqHmqGbgAAD6G6ig
	(envelope-from <cahu@suse.de>); Tue, 02 Jun 2026 10:01:42 +0000
Message-ID: <ae62c515-c83e-4a5e-aac9-299d9da2774d@suse.de>
Date: Tue, 2 Jun 2026 12:01:41 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] libsemanage: Require LIBSO before SWIGSO and
 SWIGRUBYSO (bsc#1266385)
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com, fvogt@suse.com
References: <20260601141904.60859-3-cahu@suse.de>
 <CAEjxPJ6icHimK5FJG572NF+GMbZ54cS3T3=imi3y9hiFs6ATUg@mail.gmail.com>
Content-Language: en-US
From: Cathy Hu <cahu@suse.de>
Autocrypt: addr=cahu@suse.de; keydata=
 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
 iPe2E2Yib2ud+um1SRsY/41PP+0e
In-Reply-To: <CAEjxPJ6icHimK5FJG572NF+GMbZ54cS3T3=imi3y9hiFs6ATUg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VOh5FWsACgLPyDK1RaYm84Av"
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F32D5673A2
X-Spam-Flag: NO
X-Spam-Score: -3.56
X-Spam-Level: 
X-Spamd-Result: default: False [-3.56 / 50.00];
	BAYES_HAM(-2.55)[98.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,ruby_semanage.so:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VOh5FWsACgLPyDK1RaYm84Av
Content-Type: multipart/mixed; boundary="------------vuDUtJ6BHT6VhWXmSyc309Be";
 protected-headers="v1"
From: Cathy Hu <cahu@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com, fvogt@suse.com
Message-ID: <ae62c515-c83e-4a5e-aac9-299d9da2774d@suse.de>
Subject: Re: [PATCH v3] libsemanage: Require LIBSO before SWIGSO and
 SWIGRUBYSO (bsc#1266385)
References: <20260601141904.60859-3-cahu@suse.de>
 <CAEjxPJ6icHimK5FJG572NF+GMbZ54cS3T3=imi3y9hiFs6ATUg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6icHimK5FJG572NF+GMbZ54cS3T3=imi3y9hiFs6ATUg@mail.gmail.com>

--------------vuDUtJ6BHT6VhWXmSyc309Be
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNi8xLzI2IDk6MTIgUE0sIFN0ZXBoZW4gU21hbGxleSB3cm90ZToNCj4gVGhpcyBhcHBl
YXJzIHRvIGJyZWFrIHRoZSBidWlsZCwNCj4gZnJvbSBodHRwczovL2dpdGh1Yi5jb20vc3Rl
cGhlbnNtYWxsZXkvc2VsaW51eC9hY3Rpb25zL3J1bnMvMjY3NzU1Nzc4Njkvam9iLzc4OTI2
MTc0MzEyDQo+IDoNCj4gDQo+IG1ha2VbMl06IEVudGVyaW5nIGRpcmVjdG9yeSAnL2hvbWUv
cnVubmVyL3dvcmsvc2VsaW51eC9zZWxpbnV4L2xpYnNlbWFuYWdlL3NyYycNCj4gc3dpZyAt
V2FsbCAtcnVieSAtbyBzZW1hbmFnZXN3aWdfcnVieV93cmFwLmMgLW91dGRpciAuLyBzZW1h
bmFnZXN3aWdfcnVieS5pDQo+IGNsYW5nIC1mZGVjbHNwZWMgLUkvdG1wL2Rlc3RkaXIvdXNy
L2luY2x1ZGUgLUkuLi9pbmNsdWRlDQo+IC1JLi4vLi4vbGlic2VsaW51eC9pbmNsdWRlIC1E
X0dOVV9TT1VSQ0UgLVduby1lcnJvcg0KPiAtV25vLXVudXNlZC1idXQtc2V0LXZhcmlhYmxl
IC1Xbm8tdW51c2VkLXZhcmlhYmxlIC1Xbm8tc2hhZG93DQo+IC1Xbm8tdW51c2VkLXBhcmFt
ZXRlciAtV25vLW1pc3NpbmctcHJvdG90eXBlcw0KPiAtV25vLW1pc3NpbmctZmllbGQtaW5p
dGlhbGl6ZXJzDQo+IC1JL29wdC9ob3N0ZWR0b29sY2FjaGUvUnVieS8zLjMuMTEveDY0L2lu
Y2x1ZGUvcnVieS0zLjMuMC94ODZfNjQtbGludXgNCj4gLUkvb3B0L2hvc3RlZHRvb2xjYWNo
ZS9SdWJ5LzMuMy4xMS94NjQvaW5jbHVkZS9ydWJ5LTMuMy4wIC1mUElDDQo+IC1EU0hBUkVE
IC1jIC1vIHJ1YnlzZW1hbmFnZXN3aWdfcnVieV93cmFwLmxvIHNlbWFuYWdlc3dpZ19ydWJ5
X3dyYXAuYw0KPiBjbGFuZyAtZmRlY2xzcGVjIC1JL3RtcC9kZXN0ZGlyL3Vzci9pbmNsdWRl
IC1JLi4vaW5jbHVkZQ0KPiAtSS4uLy4uL2xpYnNlbGludXgvaW5jbHVkZSAtRF9HTlVfU09V
UkNFIC1ML3RtcC9kZXN0ZGlyL3Vzci9saWIgLUwuDQo+IC1mUElDIC1zaGFyZWQgLW8gcnVi
eV9zZW1hbmFnZS5zbyBydWJ5c2VtYW5hZ2Vzd2lnX3J1Ynlfd3JhcC5sbyBhbGwNCj4gLWxz
ZW1hbmFnZSAtTC9vcHQvaG9zdGVkdG9vbGNhY2hlL1J1YnkvMy4zLjExL3g2NC9saWINCj4g
LUwvb3B0L2hvc3RlZHRvb2xjYWNoZS9SdWJ5LzMuMy4xMS94NjQvbGliL3g4Nl82NC1saW51
eA0KPiAtV2wsLXJwYXRoLC9vcHQvaG9zdGVkdG9vbGNhY2hlL1J1YnkvMy4zLjExL3g2NC9s
aWINCj4gLUwvb3B0L2hvc3RlZHRvb2xjYWNoZS9SdWJ5LzMuMy4xMS94NjQvbGliIC1scnVi
eQ0KPiBjbGFuZzogZXJyb3I6IG5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rvcnk6ICdhbGwnDQo+
IG1ha2VbMl06ICoqKiBbTWFrZWZpbGU6ODk6IHJ1Ynlfc2VtYW5hZ2Uuc29dIEVycm9yIDEN
Cj4gbWFrZVsyXTogVGFyZ2V0ICdpbnN0YWxsLXJ1Ynl3cmFwJyBub3QgcmVtYWRlIGJlY2F1
c2Ugb2YgZXJyb3JzLg0KPiBtYWtlWzJdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvcnVu
bmVyL3dvcmsvc2VsaW51eC9zZWxpbnV4L2xpYnNlbWFuYWdlL3NyYycNCj4gbWFrZVsxXTog
KioqIFtNYWtlZmlsZToyMzogaW5zdGFsbC1ydWJ5d3JhcF0gRXJyb3IgMg0KPiBtYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvcnVubmVyL3dvcmsvc2VsaW51eC9zZWxpbnV4
L2xpYnNlbWFuYWdlJw0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjQ1OiBpbnN0YWxsLXJ1Ynl3
cmFwXSBFcnJvciAxDQo+IEVycm9yOiBQcm9jZXNzIGNvbXBsZXRlZCB3aXRoIGV4aXQgY29k
ZSAyLg0KDQpTb3JyeSwgdjQgc2hvdWxkIHdvcmsgbm93DQpodHRwczovL2dpdGh1Yi5jb20v
Y2EtaHUvc2VsaW51eC9hY3Rpb25zL3J1bnMvMjY4MTIxNDAzNDYvam9iLzc5MDQ0NjAxOTY5
DQo=

--------------vuDUtJ6BHT6VhWXmSyc309Be--

--------------VOh5FWsACgLPyDK1RaYm84Av
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEWHPP0YwOptScu/bEBioQFhUFoIoFAmoeqgUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEAYqEBYVBaCKFY0P/A2ITAOgce1MdlSpVvXj
BOpmdRxf5tVxt/8BGpVsa0H+mIGfrZ0OvoS2SMAxjztX18PNjAlVkUgL4SFIPy16
z433aoPwk8keG07M9hqrDW1hxjR2BE97JHwF/hVoGIwNnn2T/GE88NpVRHkOWUG5
7jwQPG5JJAqohiIB2lUbALi/oYHMzRtLR/kAR5xJ4CKaBVlzxAalkAI4iaZL8gy+
cTJwNMtml4wT2uEPf0uRJyAiL8to6QUqpnKyOvuaTvDUaSIBtthUaK6oncsyDHfu
qTZcgMXOo8xlvAfYWF/mseKNjNoBiI+DT3IYeEEPLAf/26ALULQkKP8Pua59dIqX
0IzBehO40NZpAJLG0QnbIskbJmvo2FA8ocHBv2Imzf36hS9EAxyGWYjjqFDJqXC4
z5Qtq1yGuf5yDqS5Liim02PbAS2kk4FFFJiEXGqqtJ66NgW5JSMn/7OIKkj9LReZ
OxB0Qq6hJsyuSwmwg2GrMs9qjGv9SNocziZujzkA7MDIljNHtf9kco5w6SrlpB9V
ItyBeEM75coXYKyJxp3h7pEq1rbPxd6v640QSD+5VhYBTTtRtuHSDSk8+24g94tJ
1knnENLGpjMBLO7+jWHQDMYrjpDX93aPl2bMgjyoIIogOQww6l3SAhfKR0m/K2h4
M8ImV6wDrDjH0gx5zhW49RyN
=v9kg
-----END PGP SIGNATURE-----

--------------VOh5FWsACgLPyDK1RaYm84Av--
