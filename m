Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889925;
	b=NGjojrWLUCoOGeaOfRSSfuyY6LFxuI/9khPgSjLmBrMOanSf/aypbH/q7MJyVvwI97Wy
	 I2FPh5j/NDzch5sF3Ez67vEWUJNd/JcLLCED2KGUidoKPdONHdBJiAU+Besk5ATHs+PAO
	 Iu5HQAqifK7bAYZBKVs71yOqjFoXCXx20ae6siE5jVwZcQEwGoZcRgt4XtGkx16L/C7D9
	 BI0VMd6K0FHfnGosjDQDUPSA00KaqrwzR2ZBPXFJOaJShmOPjfPWv4yKGWdVzlFmKvtnP
	 +n4yuIGjtnqW2obkak5HgL+tUfsi8iqi46FdLkoxLS7mFP9gK7XBM+81aYakrZ6i6aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889925;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=xnvOIDGTPonUH6ysmmMN6GHGPrjB2cTfQMhlhz62DA0=;
	b=ceojRljjsElvqVkZzfCsy9wV5/VNmA+Mw3XSNHekgNYMEh46xc0G6JCjLPQ1sdhMG3a6
	 flBbwuDCoakGzD6oZ5kPxDR1dJngkLpJfn50+6HWvLrwypVserYVaVskLbhQ3n2pcpNWf
	 LJ56aAwZJxVBLwh+IaQn2ya0Dc7tbJprzSt+HboJZp5WGEEXz2CcUbMXG0RWFETMfJRqr
	 xtQ+7949G657YzniqT2tufGIQFteH+D0vAgRZRQhD3M/A819RXpyKr3lht/oEzib0xPTb
	 oa12oDDtROsBUmh9ZoctyJ6u6A21NIwGQ+ZZxPD//Q+MTbiNc20iJzT5yMZkFcBmnnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GLkqBuG4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=H7eOTblu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GLkqBuG4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=H7eOTblu;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F91606A32F
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 14:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F91606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GLkqBuG4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=H7eOTblu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GLkqBuG4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=H7eOTblu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF49F1F785;
	Thu,  5 Nov 2026 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793889917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnvOIDGTPonUH6ysmmMN6GHGPrjB2cTfQMhlhz62DA0=;
	b=GLkqBuG4JpBdvDXT+8ZiI4dCXCeTc1/vm7BqZrhRBBl/s2LEv0DSZw/KujpoBGXdkZzt4t
	YaPMyYlWLGD9WSUQnyIYAaN+PM/6otYoKoX6LQHxmx0kC3PgjWL8GM3fz7wj0nRdGwlK5b
	okmmmV3/bMCwnqCacLTAfz7mYlSLjok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793889917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnvOIDGTPonUH6ysmmMN6GHGPrjB2cTfQMhlhz62DA0=;
	b=H7eOTblul0Trjd5Gmfus9gOosySuVRog2e2P76q9LhDWPFN2QhPAJKbFaaOOxcTEkb40RY
	ydRrKnqKTxe7MGCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793889917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnvOIDGTPonUH6ysmmMN6GHGPrjB2cTfQMhlhz62DA0=;
	b=GLkqBuG4JpBdvDXT+8ZiI4dCXCeTc1/vm7BqZrhRBBl/s2LEv0DSZw/KujpoBGXdkZzt4t
	YaPMyYlWLGD9WSUQnyIYAaN+PM/6otYoKoX6LQHxmx0kC3PgjWL8GM3fz7wj0nRdGwlK5b
	okmmmV3/bMCwnqCacLTAfz7mYlSLjok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793889917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnvOIDGTPonUH6ysmmMN6GHGPrjB2cTfQMhlhz62DA0=;
	b=H7eOTblul0Trjd5Gmfus9gOosySuVRog2e2P76q9LhDWPFN2QhPAJKbFaaOOxcTEkb40RY
	ydRrKnqKTxe7MGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C4F3133F6;
	Thu,  5 Nov 2026 14:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2kcrEH2W7GpkOQAAD6G6ig
	(envelope-from <fbonazzi@suse.de>); Thu, 05 Nov 2026 14:45:17 +0000
Date: Thu, 5 Nov 2026 15:45:15 +0100
From: Filippo Bonazzi <fbonazzi@suse.de>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, selinux@suse.de
Subject: Re: Question about libselinux *_with_level functions
Message-ID: <auyV4UaYWjPiDZdD@suse.com>
Mail-Followup-To: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, selinux@suse.de
References: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
 <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com>
 <auxhNtTcQa-6TS35@suse.com>
 <CAEjxPJ7w5BMmMW-cZNG-fVpZT73BW0C9d-cBcrG3AVW-ArS=Tg@mail.gmail.com>
 <CAEjxPJ6ihzVO32+RAah_g9vo7vbFQTK5EGybgvJhow9u6tzMbg@mail.gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c7f4uwd73pxl2tk6"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ6ihzVO32+RAah_g9vo7vbFQTK5EGybgvJhow9u6tzMbg@mail.gmail.com>
User-Agent: NeoMutt/20260406
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-15.40 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,suse.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -15.40


--c7f4uwd73pxl2tk6
Content-Type: text/plain; protected-headers=v1; charset=utf-8;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Question about libselinux *_with_level functions
MIME-Version: 1.0

On 2026-11-05 09:25 (UTC -0500), Stephen Smalley wrote:
>On Thu, Nov 5, 2026 at 9:18=E2=80=AFAM Stephen Smalley
><stephen.smalley.work@gmail.com> wrote:
>>
>> On Thu, Nov 5, 2026 at 6:03=E2=80=AFAM Filippo Bonazzi <fbonazzi@suse.de=
> wrote:
>> >
>> > On 2026-05-27 13:46 (UTC -0400), Stephen Smalley wrote:
>> > >I believe this is a regression introduced by the deprecation/removal
>> > >of /sys/fs/selinux/user,
>> > >as used by security_compute_user(), which was formerly used by
>> > >get_ordered_context_list*().
>> >
>> > Hi,
>> >
>> > Just checking the state of this. Is this planned to be fixed at some p=
oint?
>>
>> Sorry I saw Petr's response in the GitHub issue and was then unclear
>> that there is anything to be fixed at the moment. Patches accepted if
>> there is in fact a real bug for a real user of this interface.
>
>Actually, on a re-read, I see that there is indeed a bug that likely
>has a relatively simple fix; is that something you want to create or
>should we?

Yes, I understood that the GH response was a red herring back then and I fi=
gured
this email thread was the right path. But then it kinda fell through the cr=
acks.

I'd appreciate if you could come up with a fix, since I lack the historical
context to understand he regression and the deprecation of the previous
features you mentioned.

Thank you

Filippo

--=20
Filippo Bonazzi
Security Engineer                        suse.com
8257 4398 947A 2DBE F21D 76E6 937A 63F0 5B36 46D9

--c7f4uwd73pxl2tk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAABCAA5FiEEgldDmJR6Lb7yHXbmk3pj8Fs2RtkFAmrslnsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEJN6Y/BbNkbZu/EIAI4vd2PCfY/A2zcg1bNB
d+r3irUlgUfWCYvyFDwLNeSJpL7u0D3TbowIdhC1J39oYWqtoNG1r2nS1j5IRHSV
O/prIDvm3nlKNwVru+WBTuJMkTmdWRzH6AZxUkhflJYKElNozy7F8Oy+CRu4cCDX
rqssZ9XILWTMwg1S0uHSEh9D32zUIlgyGA8YYMJoP4C3wkEKBvimT/XDfrNRiE/e
m4i10rAkK0/tq+AWpHDwEJmG6g/sSxkDPQ3kvKJDxLnzSqZ9G3qFGxTG2YQbP5cn
x2pqTHoNdojzGJbcSdXPz5KV08aU424zmc1al5/aw37g7j0aI0nC2F0qwWETB8/q
hdo=
=0J0B
-----END PGP SIGNATURE-----

--c7f4uwd73pxl2tk6--
